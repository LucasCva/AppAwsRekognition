# 🛡️ Image Guardian - Filtro de Imagens com AWS Rekognition

Este é um aplicativo mobile criado para uma apresentação de inovações tecnológicas. O projeto tem como objetivo analisar imagens enviadas pelos usuários e verificar se elas são apropriadas, utilizando o serviço **AWS Rekognition**, integrado a um backend desenvolvido em **Spring Boot**.

---

## 📱 Visão Geral

O app permite que os usuários façam o upload de imagens, que são então processadas por um serviço backend. Esse backend utiliza o **AWS Rekognition** para verificar o conteúdo da imagem. Com base na análise:

- ✅ **Se a imagem for apropriada**: Ela será publicada em uma **galeria pública**, visível a todos os usuários.
- ❌ **Se a imagem for imprópria**: O app exibirá uma **mensagem com o motivo** pelo qual a imagem foi considerada inapropriada (ex: nudez, violência, etc.).

---

## 🧠 Tecnologias Utilizadas

### Frontend
- Flutter

### Backend (desenvolvido por outro colega do grupo)
- Spring Boot
- Integração com AWS Rekognition

### Serviços
- **AWS Rekognition**: Serviço de análise de imagens da Amazon Web Services, utilizado para identificar conteúdo impróprio com base em machine learning.

---

## 🚀 Como Funciona

1. O usuário seleciona uma imagem no aplicativo.
2. A imagem é enviada para o backend Spring Boot.
3. O backend faz a chamada ao AWS Rekognition para analisar o conteúdo.
4. Com base na resposta:
   - Se a imagem for **segura**, ela é armazenada e exibida na galeria.
   - Se for **imprópria**, o app mostra o motivo da rejeição.

---

## 🖼️ Galeria Pública

As imagens que passam pela verificação são exibidas em uma galeria pública, promovendo um ambiente seguro e controlado para visualização de conteúdo.

---
