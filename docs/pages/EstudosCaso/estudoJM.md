# 1. Nome do Caso de Uso
Responder Feedback do Usuário

## 1.1 Breve Descrição
Este caso de uso permite que o Administrador ou a equipe responsável pela plataforma visualize, analise e responda aos feedbacks enviados pelos Usuários (pacientes, profissionais de saúde, agentes comunitários ou ONGs).

O objetivo é garantir que sugestões, reclamações ou elogios recebidos possam ser avaliados e respondidos, melhorando a qualidade dos serviços oferecidos e fortalecendo o canal de comunicação.

## 1.2 Atores
- **Ator Principal:** Administrador do Sistema
- **Atores Secundários:**  
  - Usuário que enviou o feedback  
  - Banco de Dados de Feedback  
  - Sistema de Notificações (Push/E-mail)  

---

# 2. Fluxo de Eventos

## 2.1 Fluxo Principal

O processo padrão para responder a um feedback é descrito abaixo:

| Passo | Ação do Ator (Administrador) | Ação do Sistema |
|------|-------------------------------|------------------|
| 1 | O Administrador acessa a função “Gerenciar Feedback” no painel administrativo. | O Sistema lista todos os feedbacks pendentes de resposta. |
| 2 | O Administrador seleciona um feedback para visualizar. | O Sistema exibe detalhes: tipo, descrição, data, autor e categoria. |
| 3 | O Administrador escreve uma resposta para o feedback selecionado. | O Sistema valida os campos obrigatórios (texto da resposta). |
| 4 | O Administrador confirma o envio da resposta. | O Sistema registra a resposta no banco de dados. |
| 5 | — | O Sistema envia uma notificação ao Usuário informando que seu feedback foi respondido. |
| 6 | — | O Sistema altera o status do feedback para “Respondido”. |

---

## 2.2 Fluxos Alternativos

### **[FA01] Filtrar Feedback (iniciado no passo 1)**
- 2.2.1 O Administrador utiliza filtros (categoria, pendente, respondido, data).
- 2.2.2 O Sistema atualiza a lista conforme o filtro aplicado.
- 2.2.3 O fluxo retorna ao passo 1.

### **[FA02] Resposta Rascunho (iniciado no passo 3)**
- 2.2.1 O Administrador decide não enviar a resposta imediatamente.
- 2.2.2 O Sistema salva como “Rascunho”.
- 2.2.3 O fluxo termina.

---

## 2.3 Fluxos de Exceção

### **[FE01] Sistema de Notificações Indisponível (iniciado no passo 5)**
- 2.3.1 O Sistema não consegue enviar a notificação ao Usuário.
- 2.3.2 O Sistema salva a resposta, mas exibe a mensagem:  
  “Notificação não enviada. Será reenviada automaticamente mais tarde.”
- 2.3.3 O fluxo continua normalmente.

### **[FE02] Campos Obrigatórios Incompletos (iniciado no passo 3)**
- 2.3.1 O Administrador tenta salvar a resposta sem preencher o texto.
- 2.3.2 O Sistema exibe:  
  “Preencha o campo ‘Resposta’ para continuar.”
- 2.3.3 O fluxo retorna ao passo 3.

### **[FE03] Falha no Banco de Dados (iniciado no passo 4)**
- 2.3.1 O Sistema encontra erro ao salvar a resposta.
- 2.3.2 O Sistema exibe:  
  “Erro ao salvar a resposta. Tente novamente mais tarde.”
- 2.3.3 O caso de uso termina sem alterar o status do feedback.

---

# 3. Requisitos Especiais
- O sistema deve garantir que a resposta seja salva mesmo que a notificação falhe.
- A interface deve permitir visualizar feedbacks por ordem cronológica.
- A resposta deve ser registrada com data, hora e identificação do Administrador.
- O sistema deve permitir anexar arquivos na resposta (opcional).

---

# 4. Regras de Negócio
- **RN01:** Apenas Administradores podem responder feedbacks.
- **RN02:** Após respondido, o feedback não pode ser apagado, apenas arquivado.
- **RN03:** A resposta deve ficar visível para o Usuário na área “Meus Feedbacks”.
- **RN04:** O sistema deve registrar o log de todas as alterações no feedback.

---

# 5. Precondições
- O Administrador deve estar autenticado no sistema.
- Deve existir ao menos um feedback pendente ou arquivado.
- O sistema de banco de dados deve estar disponível para leitura.

---

# 6. Pós-condições
- A resposta fica registrada no histórico do feedback.
- O status do feedback é atualizado para “Respondido”.
- Uma notificação é enviada ao Usuário (quando possível).
