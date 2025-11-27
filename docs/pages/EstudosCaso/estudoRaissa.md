# 1. Nome do Caso de Uso
Acessar Histórico de Saúde

## 1.1 Breve Descrição
Este caso de uso permite que o Profissional de Saúde visualize o histórico clínico do Paciente.  
O histórico inclui informações como: consultas anteriores, exames feitos, diagnósticos registrados, campanhas ou iniciativas das quais o paciente participou e visitas domiciliares realizadas.

O objetivo é fornecer ao profissional uma visão consolidada e confiável do prontuário do paciente, permitindo atendimento mais rápido e preciso.  
Algumas informações podem vir de sistemas externos (ex.: sistema de mapas, campanhas vinculadas a ONGs, registros de agentes comunitários).

## 1.2 Atores
- **Ator Principal:** Profissional de Saúde  
- **Atores Secundários:**  
  - Sistema de Armazenamento de Histórico  
  - Administrador (libera permissões)  
  - Agente Comunitário de Saúde (pode ter gerado parte do histórico)

---

# 2. Fluxo de Eventos

## 2.1 Fluxo Principal

O fluxo abaixo descreve o caminho padrão para consultar o histórico com sucesso.

| Passo | Ação do Ator (Profissional de Saúde) | Ação do Sistema |
|------|---------------------------------------|------------------|
| 1 | O Profissional acessa a função “Acessar Histórico” no aplicativo ou sistema web. | O Sistema valida a sessão do profissional e exibe o campo de busca por paciente. |
| 2 | O Profissional informa o identificador do paciente (CPF, nome completo ou ID do sistema). | O Sistema consulta a base de dados e exibe os pacientes correspondentes. |
| 3 | O Profissional seleciona o paciente desejado. | O Sistema exibe o resumo do histórico clínico (consultas, exames, diagnósticos, iniciativas). |
| 4 | O Profissional seleciona um item específico do histórico (consulta, exame, registro de iniciativa). | O Sistema exibe os detalhes completos do item selecionado. |
| 5 | O Profissional finaliza a visualização. | O Sistema registra o acesso no log de auditoria. |

---

## 2.2 Fluxos Alternativos

### **[FA01] Paciente não encontrado (iniciado no passo 2)**
- 2.2.1 O Profissional insere um nome incompleto ou CPF com erro.
- 2.2.2 O Sistema exibe a mensagem “Paciente não encontrado. Verifique os dados e tente novamente.”
- 2.2.3 O fluxo retorna ao passo 2.

### **[FA02] Histórico parcial (iniciado no passo 3)**
- 2.2.1 O Sistema identifica que parte dos dados do paciente está em um sistema externo.
- 2.2.2 O Sistema exibe um aviso: “Algumas informações estão sendo carregadas de sistemas externos.”
- 2.2.3 O fluxo continua normalmente.

---

## 2.3 Fluxos de Exceção

### **[FE01] Falha de Comunicação com o Sistema de Histórico (iniciado no passo 3)**
- 2.3.1 O Sistema não consegue acessar a base de dados.
- 2.3.2 O Sistema exibe: “Erro ao acessar o histórico. Tente novamente mais tarde.”
- 2.3.3 O caso de uso é encerrado.

### **[FE02] Profissional sem permissão (iniciado no passo 1)**
- 2.3.1 O Sistema detecta que o profissional não tem acesso ao prontuário do paciente.
- 2.3.2 O Sistema exibe: “Acesso negado. Entre em contato com o Administrador.”
- 2.3.3 O caso de uso é encerrado.

### **[FE03] Registro específico não acessível (iniciado no passo 4)**
- 2.3.1 O Sistema não encontra detalhes do registro selecionado.
- 2.3.2 O Sistema exibe: “Informações indisponíveis.”
- 2.3.3 O fluxo retorna ao passo 3.

---

# 3. Requisitos Especiais
- A consulta ao histórico deve retornar em até **3 segundos**.
- O sistema deve registrar todos os acessos para fins de auditoria.
- O histórico deve ser responsivo e acessível em dispositivos móveis.
- Caso existam registros externos, o sistema deve integrar via API segura.

---

# 4. Regras de Negócio
- **RN01:** Apenas profissionais autorizados podem visualizar o histórico.
- **RN02:** Dados sensíveis (diagnósticos, exames, notas médicas) devem seguir protocolos de sigilo.
- **RN03:** Todo acesso ao histórico deve ficar registrado com data, hora e profissional.
- **RN04:** O profissional só pode acessar históricos de pacientes vinculados à sua unidade de atendimento, salvo permissão especial do Administrador.

---

# 5. Precondições
- O Profissional deve estar autenticado no aplicativo/sistema.
- O Paciente deve existir no sistema.
- O Profissional deve possuir permissão mínima de consulta conforme RN01.

---

# 6. Pós-condições
- Um registro de auditoria é criado.
- O Sistema mantém o histórico intacto, sem alterações.
