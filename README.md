
# ads_connector

ads_connector è una libreria Flutter modulare per integrare:

- Meta Marketing API (RAW)
- Instagram Insights API (RAW)
- Google Ads API (RAW)
- TikTok Ads API (RAW)
- Meta Tracking SDK
- OAuth multiprovider
- Rate limit avanzato (Exponential backoff + Circuit breaker)
- Logging avanzato
- Scheduler per refresh automatico

## ⚠️ Sicurezza: API vietate lato client
NON sono mai chiamate da Flutter:

- appsecret_proof
- client_secret
- system_user
- Business Manager admin API
- API di scrittura campagne
- API che richiedono permessi speciali

## 📦 Moduli
- oauth/
- meta/
- instagram/
- googleads/
- tiktokads/
- tracking/
- common/

Tutti i dati sono RAW, nessuna trasformazione dei risultati.

## 🔐 Token
- Salvati separatamente per provider
- Usano flutter_secure_storage
- Nessun secret nell’app
