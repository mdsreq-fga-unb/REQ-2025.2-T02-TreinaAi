# Diagrama de Casos de Uso

Tem por objetivo apresentar uma visão externa das funções e serviços que o sistema deverá oferecer aos usuários, sem se preocupar em como tais funções serão implementadas

Para este estudo, usamos como base o projeto Connect Care, um app para ajudar pessoas numa comunidade necessitada.

### Atores

Os atores são papéis que um usuário desempenha com relação ao sistema. Podem ser humanos, sistemas ou dispositivos de hardware.

- Quem ou o quê utiliza o sistema? 
- Quem ou o quê recebe informações do sistema?
- Quem ou o quê provê informações para o sistema? 
- Em que lugar da empresa o sistema será utilizado?
- Quem ou o quê suporta e mantém o sistema?
- Que outros sistemas utilizam este sistema?

**Os atores identificados na Connect Care são:**

- **Pacientes**: utilizam diretamente do sistema para buscar informações, além de realizar um registro manual.
  
-** Sistema de informações**: usa das informações do paciente para acessar, pelo sistema, pontos de interesse.
 
- **Profissional de saúde**: acessa a plataforma para acessar exames e detalhes do Paciente.
  
- **Agentes comunitários:** usam o sistema para identificar áreas prioritárias.
  
- **ONG:** usam o sistema para divulgar e gerenciar iniciativas.
    
- **Administrador**: garante a segurança da plataforma, usando o sistema para obter informações sobre o app no geral.

### Casos de Uso

Usando o formato “**Verbo no infinitivo + Objeto**”, identificamos os seguintes casos de uso:

### Paciente

- Registrar com informações pessoais;
- Buscar serviços de saúde;
- Realizar agendamento de consultas;
- Consultar disponibilidade de horários;
- Realizar feedback da consulta;

![Paciente](../../assets/paciente.png)

### Sistema de informações

- Coletar dados do paciente;
- Buscar postos de saúde próximos do paciente;
- Indicar campanhas existentes;

![SisMapa](../../assets/sistemaMapa.png)


### Profissional de saúde

- Gerenciar atendimentos de pacientes;
- Acessar informações de pacientes;
- Criar perfil profissional;
- Organizar fluxo de trabalho;
- Visualizar agenda de consultas;
- Acessar histórico do paciente;
- Atualizar prontuário do paciente;

![profissionalsaude](../../assets/profissionalsaude.png)

### Ongs

- Divulgar campanhas;
- Divulgar iniciativas de saúde;
- Administrar iniciativas;

### Agentes comunitários

- Registrar visitas domiciliares;
- Criar relatórios de condições de saúde;
- Identificar áreas prioritárias.

### Administrador

- Integrar novas funcionalidades;
- Atualizar informações de parceiros;
- Responder feedback do usuário;
- Monitorar indicadores de desempenho;

![agenteAdmin](../../assets/agenteAdmin.png)



### Diagrama no miro

![agenteAdmin](../../assets/DiagramUC.png)

<iframe width="768" height="432" src="https://miro.com/app/live-embed/uXjVJHChsK4=/?embedMode=view_only_without_ui&moveToViewport=-107585,-9026,29568,19204&embedId=411380534809" frameborder="0" scrolling="no" allow="fullscreen; clipboard-read; clipboard-write" allowfullscreen></iframe>

:::::

---

# Especificações de caso de uso

Abaixo está a especificação completa de cinco casos de uso selecionados para detalhamento.

## 1. Realizar Agendamento de Consultas

#### 1.1 Breve Descrição

Para o seguinte experimento, utilizamos de um exemplo geral: um adulto levando seu filho à um médico.

Permite ao Paciente, através do aplicativo, localizar postos de saúde próximos, verificar a disponibilidade de médicos por especialidade (pediatria) e efetuar o agendamento de uma consulta para seu filho. O sistema deve confirmar o agendamento ou informar sobre a indisponibilidade.

#### 1.2 Atores

* **Ator Principal:** Paciente
* **Atores Secundários:** Sistema de Localização (GPS) e Profissional de saúde (recebe a confirmação).

---

### 2. Fluxo de Eventos

#### 2.1 Fluxo Principal

O caminho padrão para um agendamento bem-sucedido.

| Passo | Ação do Ator (Paciente) | Ação do Sistema |
| :--- | :--- | :--- |
| 1 | O Paciente acessa a função de "Agendamento de Consultas" no aplicativo. | |
| 2 | O Paciente informa a especialidade desejada (pediatria) e a localização atual ou CEP. | O Sistema [RN01] exibe um mapa com os postos de saúde próximos (até 5km) e o tempo de deslocamento estimado. |
| 3 | O Paciente seleciona o posto de saúde de sua preferência. | |
| 4 | O Paciente seleciona o médico desejado e o dia do agendamento. | O Sistema consulta a agenda do médico selecionado e [RN02] exibe os horários disponíveis. |
| 5 | O Paciente seleciona o horário desejado. | |
| 6 | O Sistema solicita a confirmação dos dados (posto, médico, data, hora, nome do paciente/filho). | |
| 7 | O Paciente confirma o agendamento. | O Sistema [RN03] reserva o horário na agenda do médico, [Pós-condição 1] registra o agendamento no sistema e [Pós-condição 2] envia uma notificação de confirmação. |
| 8 | | O Sistema exibe a tela de confirmação do agendamento com o número de protocolo. |

#### 2.2 Fluxos Alternativos

Variações do fluxo principal que não são erros.

* **[FA01] Troca de Localização (iniciado no passo 2.1.2)**
    * 2.2.1.1 O Paciente insere manualmente um novo endereço ou CEP diferente do atual.
    * 2.2.1.2 O Sistema recalcula e [RN01] exibe os postos de saúde próximos à nova localização.
    * 2.2.1.3 O fluxo retorna ao passo 2.1.3.

* **[FA02] Indisponibilidade na Agenda (iniciado no passo 2.1.4)**
    * 2.2.2.1 O Paciente seleciona um dia sem horários disponíveis.
    * 2.2.2.2 O Sistema exibe a mensagem "Não há horários livres neste dia" e sugere datas próximas com disponibilidade.
    * 2.2.2.3 O fluxo retorna ao passo 2.1.4 (seleção de dia).

#### 2.3 Fluxos de Exceção

Erros e falhas.

* **[FE01] Postos de Saúde Indisponíveis (iniciado no passo 2)**
    * 2.3.1.1 Se o Sistema [RN01] não encontrar postos de saúde em um raio de 5km (ou na especialidade desejada) OU se todos os postos próximos estiverem com a agenda lotada.
    * 2.3.1.2 O Sistema exibe a mensagem de erro: **"Não foi possível encontrar postos de saúde próximos com horários livres para a especialidade de Pediatria."**
    * 2.3.1.3 O Sistema encerra o caso de uso.

* **[FE02] Campo Obrigatório Incompleto (iniciado em qualquer passo)**
    * 2.3.2.1 O Paciente tenta avançar sem preencher um campo obrigatório (Ex: Especialidade, Médico, Horário).
    * 2.3.2.2 O Sistema exibe a mensagem de erro: **"Informação incompleta. Por favor, preencha o campo [Nome do Campo] para continuar."**
    * 2.3.2.3 O fluxo permanece no passo atual.

* **[FE03] Horário Selecionado Ocupado (iniciado no passo 7)**
    * 2.3.3.1 Durante o processamento da reserva, outro Paciente simultaneamente reservou o mesmo horário.
    * 2.3.3.2 O Sistema cancela a reserva atual e exibe a mensagem: **"O horário selecionado não está mais disponível. Por favor, escolha outro horário."**
    * 2.3.3.3 O fluxo retorna ao passo 2.1.4 (seleção de dia).

---

### 3. Requisitos Especiais

* O agendamento deve ser otimizado para dispositivos móveis (Android e iOS) diferentes.
* O sistema deve consultar a localização do usuário com permissão explícita (GPS).
* O tempo de resposta para a consulta de disponibilidade (passo 2.1.4) não deve exceder 2 segundos.

### 4. Regras de Negócio

* **[RN01]** A busca por postos de saúde deve priorizar a distância física (raio de 5km) e a especialidade desejada (pediatria, por exemplo).
* **[RN02]** A disponibilidade de horários é determinada pela agenda médica real e deve ser exibida em tempo real.
* **[RN03]** Após a confirmação (passo 7), o horário é imediatamente bloqueado na agenda do médico.
* **[RN04]** O Paciente só pode agendar consultas para ele próprio ou dependentes cadastrados em seu perfil, não podendo realizar consultas para outrem sem cadastro de informações prévio.

### 5. Precondições

* O Paciente deve estar autenticado no aplicativo.
* O serviço de localização (GPS) do Paciente deve estar ativo (se a busca for por proximidade).
* O Paciente deve ter dependentes (filho, padrasto, mãe, etc) cadastrados no sistema (Referência RN04).

### 6. Pós-condições

* **[Pós-condição 1]** O agendamento é registrado no sistema de trabalho do profissional de saúde.
* **[Pós-condição 2]** Uma notificação de confirmação é enviada ao Paciente e ao Profissional de Saúde.
* **[Pós-condição 3]** O horário reservado é marcado como indisponível na agenda do médico.

### 7. Pontos de Extensão

* No passo 7, este caso de uso pode ser estendido por **"Gerar Lembrete de Consulta"**.
* No passo 2, este caso de uso pode ser estendido por **"Consultar Histórico de Agendamentos"**.

---

## 1. Criar perfil profissional

#### 1.1 Breve Descrição
O caso de uso "Criar Perfil Profissional" tem como objetivo permitir que o usuário registre suas informações pessoais, experiências e habilidades em um perfil organizado dentro da plataforma.

O ator deseja criar e registrar seu perfil profissional, enquanto o sistema oferece os meios para coletar, salvar e disponibilizar essas informações de forma estruturada.

#### 1.2 Atores
- **Ator Principal:** Profissional da Saúde - responsável por iniciar a ação de criar o perfil profissional
- **Atores Secundários:**  
  - Sistema de autentificção - responsável por validar a identidade do profissional antes da criação do perfil.
  
#### 2. Fluxo de Eventos

##### 2.1 Fluxo Principal


| Passo    | Ação                                                                 |
|----------|----------------------------------------------------------------------|
| **2.1.1** | O **Profissional da Saúde** acessa a opção *Criar Perfil Profissional*. |
| **2.1.2** | O **Sistema** exibe o formulário de criação de perfil.               |
| **2.1.3** | O **Profissional da Saúde** preenche suas informações profissionais.                  |
| **2.1.4** | O **Sistema** valida os dados informados.                       |
| **2.1.5** | O **Sistema** registra o novo perfil no banco de dados.              |
| **2.1.6** | O **Sistema** confirma a criação do perfil exibindo uma mensagem de sucesso. |


### 2.2 Fluxos Alternativos


#### [FA01] – Edição opcional de informações adicionais
**Origem:** Passo 2.1.3  
1. O **Ator** opta por adicionar informações complementares ao perfil (ex.: certificações, idiomas).  
2. O **Sistema** exibe os campos opcionais correspondentes.  
3. O **Ator** preenche os campos desejados.  
**Retorno:** O fluxo volta ao passo 2.1.4.

---

#### [FA02] – Indicação de experiência profissional prévia
**Origem:** Passo 2.1.3  
1. O **Ator** decide incluir experiências profissionais anteriores.  
2. O **Sistema** exibe os campos para cargo, instituição, período e descrição da atividade.  
3. O **Ator** adiciona uma ou mais experiências.  
**Retorno:** O fluxo volta ao passo 2.1.4.

---

#### [FA03] – Inserção de links externos
**Origem:** Passo 2.1.3  
1. O **Ator** opta por inserir links relevantes (ex.: LinkedIn, portfólio, site profissional).  
2. O **Sistema** apresenta os campos para adicionar URLs .  
3. O **Ator** insere um ou mais links.  
4. O **Sistema** verifica se os links possuem formato válido.  
**Retorno:** O fluxo volta ao passo 2.1.4.

### 2.3 Fluxos de Exceção

#### [FE01] – Dados obrigatórios ausentes
**Origem:** Passo 2.1.4  
1. O **Sistema** identifica que campos obrigatórios não foram preenchidos.  
2. O **Sistema** exibe mensagem informando os campos faltantes e solicita correção.  
**Retorno:** O fluxo retorna ao passo 2.1.3.

---

#### [FE02] – Formato de dados inválido
**Origem:** Passo 2.1.4  
1. O **Sistema** detecta dados em formato inválido (ex.: e-mail incorreto, telefone incompleto).  
2. O **Sistema** destaca os campos inválidos e orienta o ator a corrigir.  
**Retorno:** O fluxo retorna ao passo 2.1.3.

---

#### [FE03] – Falha ao registrar o perfil no banco de dados
**Origem:** Passo 2.1.5  
1. O **Sistema** não consegue salvar o perfil devido a uma falha na operação de banco de dados.  
2. O **Sistema** informa o erro e solicita que o ator tente novamente mais tarde.  
**Retorno:** O fluxo é encerrado sem criar o perfil.

---

#### [FE04] – Tamanho de arquivo excedido (caso exista upload)
**Origem:** Passo 2.1.3  
1. O **Sistema** detecta que um arquivo enviado (ex.: foto) excede o tamanho permitido.  
2. O **Sistema** exibe mensagem de erro e rejeita o upload.  
**Retorno:** O fluxo retorna ao passo 2.1.3.

### 3. Requisitos Especiais

- **Compatibilidade com dispositivos móveis:**  
  O sistema deve permitir a criação do perfil profissional em smartphones e tablets, mantendo layout responsivo e usabilidade adequada.

- **Requisitos de performance:**  
  O formulário de criação do perfil e a validação dos dados devem ser executados rapidamente pelo sistema.

### 4. Regras de Negócio

**[RN01]** Todos os campos obrigatórios do perfil devem estar preenchidos para permitir a criação do perfil profissional.

**[RN02]** O número de registro profissional (ex.: CRM, COREN, CRP) deve seguir o formato definido pelo respectivo conselho e ser validado antes do registro do perfil.

**[RN03]** Cada profissional pode possuir apenas um perfil ativo por CPF cadastrado.

**[RN04]** Em caso de integração externa, o sistema deve verificar o registro profissional em até 5 segundos; após esse tempo, a verificação deve ser considerada indisponível.

### 5. Pré-condições

- O **Profissional da Saúde** deve estar autenticado no sistema.  
- O ator deve ter sido previamente validado como um **profissional da saúde legítimo** (ex.: registro em conselho profissional confirmado).  
- O sistema deve estar conectado ao banco de dados.  
- O ator deve possuir um cadastro básico ativo (ex.: CPF e e-mail verificados). 

### 6. Pós-condições

- Um novo perfil profissional é criado e armazenado no banco de dados.  
- O ator passa a ter acesso às funcionalidades que dependem de um perfil profissional ativo.  


