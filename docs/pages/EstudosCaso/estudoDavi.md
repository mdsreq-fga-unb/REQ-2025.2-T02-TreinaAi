# Estudo de Caso – Registrar Informações

## 1. Nome do Caso de Uso
**Registrar Informações**

---

## 1.1 Breve Descrição
Este caso de uso permite que o **Paciente** registre informações relevantes à sua saúde no aplicativo, tais como sintomas, medições (pressão, glicemia, etc.), evolução de uma condição ou anotações pessoais.  
O objetivo é manter um histórico organizado que pode ser consultado posteriormente pelo usuário ou compartilhado com profissionais de saúde.

---

## 1.2 Atores
- **Ator Principal:** Paciente  
- **Atores Secundários:**  
  - Sistema (responsável por armazenar os registros)  
  - Profissional de saúde (acessa as informações caso tenha permissão)

---

# 2. Fluxo de Eventos

## 2.1 Fluxo Principal

O caminho padrão para um registro de informações bem-sucedido.

| Passo | Ação do Ator (Paciente) | Ação do Sistema |
|------|---------------------------|-----------------|
| 1 | O Paciente acessa a função **"Registrar Informações"** no aplicativo. | O Sistema exibe um formulário com os campos disponíveis para registro. |
| 2 | O Paciente seleciona o tipo de informação (ex.: Sintomas). | O Sistema exibe campos específicos conforme o tipo escolhido. |
| 3 | O Paciente preenche os campos necessários. | O Sistema valida os dados preenchidos. |
| 4 | O Paciente anexa fotos, documentos ou exames (opcional). | O Sistema realiza o upload e verifica a integridade dos arquivos. |
| 5 | O Paciente confirma o registro. | O Sistema salva o registro, gera um identificador único e exibe a confirmação. |

---

## 2.2 Fluxos Alternativos

### **[FA01] Registro sem Anexos (iniciado no passo 4)**
- O Paciente decide não anexar arquivos.  
- O Sistema continua para a etapa de confirmação.  
- O fluxo retorna ao passo 5.

### **[FA02] Categoria Personalizada (iniciado no passo 2)**
- O Paciente escolhe “Outro tipo de informação”.  
- O Sistema solicita o nome da nova categoria.  
- O Sistema registra a categoria e retorna ao passo 3.

---

## 2.3 Fluxos de Exceção

### **[FE01] Campo Obrigatório Incompleto**
- O Paciente tenta prosseguir sem preencher um campo obrigatório.  
- O Sistema exibe:  
  **“Informação incompleta. Preencha o campo [Nome do Campo] para continuar.”**  
- O fluxo permanece no passo atual.

### **[FE02] Falha no Upload de Arquivo**
- O Sistema não consegue processar o arquivo anexado.  
- O Sistema exibe:  
  **“Não foi possível enviar o arquivo. Tente novamente.”**  
- O usuário pode tentar novamente ou prosseguir sem anexos.

### **[FE03] Falha ao Salvar Registro**
- O Sistema não consegue salvar o registro.  
- O Sistema exibe:  
  **“Ocorreu um erro ao salvar suas informações. Tente novamente mais tarde.”**  
- O caso de uso é encerrado.

---

# 3. Requisitos Especiais

- Deve funcionar em modo offline, sincronizando quando houver conexão.  
- Anexos aceitos: imagens, PDF e documentos de até 20 MB.  
- Os dados devem ser criptografados.  
- Interface adaptada para dispositivos móveis.

---

# 4. Regras de Negócio

- **RN01:** O usuário só pode registrar informações do próprio perfil ou de dependentes.  
- **RN02:** Cada tipo de informação possui campos obrigatórios específicos.  
- **RN03:** Todos os arquivos anexados devem ser verificados quanto à integridade.  
- **RN04:** O registro só é validado após confirmação explícita do usuário.

---

# 5. Precondições

- O Paciente deve estar autenticado no sistema.  
- O dispositivo deve ter espaço disponível para anexos.  
- O Paciente deve ter permissão para registrar informações de dependentes.

---

# 6. Pós-condições

- O registro é salvo no sistema.  
- O histórico do paciente é atualizado.  
- Anexos são vinculados ao registro criado.

---
