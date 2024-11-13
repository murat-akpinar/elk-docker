#!/bin/bash

# Elasticsearch hazır olana kadar bekle
until curl -s http://elasticsearch:9200 >/dev/null; do
  echo "Elasticsearch başlatılıyor..."
  sleep 5
done

echo "Elasticsearch hazır. Yapılandırmalar gönderiliyor..."

# ILM Policy'yi oluştur
curl -X PUT "http://elasticsearch:9200/_ilm/policy/delete_after_30_days" -H 'Content-Type: application/json' -d'
{
  "policy": {
    "phases": {
      "hot": {
        "actions": {
          "rollover": {
            "max_size": "50GB",
            "max_age": "7d"
          }
        }
      },
      "delete": {
        "min_age": "30d",
        "actions": {
          "delete": {}
        }
      }
    }
  }
}'

# Index Template'i oluştur
curl -X PUT "http://elasticsearch:9200/_index_template/logs_template" -H 'Content-Type: application/json' -d'
{
  "index_patterns": ["logs-*"],
  "template": {
    "settings": {
      "index.lifecycle.name": "delete_after_30_days",
      "index.lifecycle.rollover_alias": "logs"
    }
  }
}'

# İlk index'i oluştur
curl -X PUT "http://elasticsearch:9200/logs-000001" -H 'Content-Type: application/json' -d'
{
  "aliases": {
    "logs": {
      "is_write_index": true
    }
  }
}'

echo "Yapılandırmalar tamamlandı."
