
# ELK Nedir?

**ELK Stack**, Elasticsearch, Logstash ve Kibana bileşenlerinden oluşan bir açık kaynaklı analiz platformudur. Log yönetimi, gerçek zamanlı analiz, veri görselleştirme ve arama gibi işlemler için kullanılır. İşte bileşenlerin kısa açıklamaları:

- **Elasticsearch**: Verileri depolayan ve sorgulayan dağıtılmış bir arama ve analiz motorudur.
- **Logstash**: Verileri farklı kaynaklardan alıp, dönüştürerek Elasticsearch'e ileten bir veri işleme ardışık düzenidir.
- **Kibana**: Elasticsearch üzerinde depolanan verileri görselleştiren ve analiz etmenizi sağlayan bir kullanıcı arayüzüdür.

---

# Docker Compose ile ELK Stack Kurulumu

Bu rehberde, ELK Stack'i [murat-akpinar/elk-docker](https://github.com/murat-akpinar/elk-docker) reposundan indirip Docker Compose ile ayağa kaldırmayı ve ardından curl komutları ile kontrol mekanizmalarını oluşturmayı öğreneceksiniz.

## 1. Gerekli Dosyaların İndirilmesi

Öncelikle, ELK Docker Compose dosyalarının bulunduğu repoyu klonlayın:

```bash
git clone https://github.com/murat-akpinar/elk-docker.git
cd elk-docker
```

---

## 2. Docker Compose ile ELK Stack'i Ayağa Kaldırma

Repo içinde bulunan `docker-compose.yml` dosyasını kullanarak ELK Stack'i başlatabilirsiniz:

```bash
docker-compose up -d
```

Bu komut, Elasticsearch, Logstash ve Kibana servislerini arka planda çalıştırır.

### Durumu Kontrol Etme

Çalışan konteynerlerin durumunu kontrol etmek için aşağıdaki komutu kullanabilirsiniz:

```bash
docker ps
```

Eğer her şey düzgün çalışıyorsa, `elasticsearch`, `logstash`, ve `kibana` konteynerlerini listede görmelisiniz.

---

## 3. Curl ile Kontrol Mekanizmaları

### Elasticsearch Sağlık Durumu

Elasticsearch'in çalıştığını doğrulamak için şu komutu çalıştırabilirsiniz:

```bash
curl -X GET "http://localhost:9200/_cluster/health?pretty"
```

Bu komut, Elasticsearch cluster'ının sağlık durumunu döndürür. Yanıt şu şekilde görünmelidir:

```json
{
  "cluster_name": "docker-cluster",
  "status": "green",
  "timed_out": false,
  ...
}
```

### Kibana Sağlık Durumu

Kibana'nın doğru şekilde çalıştığını kontrol etmek için:

```bash
curl -X GET "http://localhost:5601/status"
```

Bu komutun çıktısı içerisinde `status` değeri `green` olarak görünmelidir.

### Logstash Bağlantı Testi

Logstash'in çalıştığını doğrulamak için bir TCP bağlantı testi yapabilirsiniz:

```bash
curl -X GET "http://localhost:9600/"
```

Bu komut size Logstash hakkında temel bilgileri döndürmelidir.

---

## 4. ELK Stack Kullanıma Hazır

Bu adımları tamamladıktan sonra, aşağıdaki URL'lerden ELK Stack bileşenlerine erişebilirsiniz:

- **Kibana Arayüzü**: [http://localhost:5601](http://localhost:5601)

---

