# Backlog do Produto

O **Backlog do Produto** é uma lista viva e priorizada de tudo que é necessário para construir, manter e aprimorar um produto, servindo como uma **única fonte de requisitos** para qualquer mudança no produto.

Todos os épicos e histórias de usuário apresentados nesta página compõem o **Mínimo Produto Viável (MVP)** do projeto. Ou seja, representam o conjunto essencial de funcionalidades necessárias para garantir a entrega de valor inicial aos usuários, permitindo validação, testes e evolução futura da aplicação.

### Itens do Backlog e Sua Estrutura

Os itens dentro do Backlog são hierárquicos:

1.  **Épicos (Epics):**
    * **O que são:** Itens grandes e abrangentes que representam um recurso ou funcionalidade significativa. São grandes demais para serem entregues em um único ciclo de desenvolvimento (Sprint).
    * **Estrutura Básica:** Título (`E01 – Criar Usuário`) e **Descrição Geral** (o propósito e o valor do recurso).
2.  **Histórias de Usuário (User Stories - US):**
    * **O que são:** Pequenas descrições de um recurso do ponto de vista do usuário final. Representam a menor unidade de trabalho que agrega valor.
    * **Estrutura Básica Comum:** "Como um [tipo de usuário], eu quero [alguma meta], para que [algum benefício]."
---

## Épicos do Projeto

A tabela a seguir organiza os Épicos do seu projeto, detalhando o Código, o Título e a Descrição Geral de cada item de alto nível:

| Código | Título | Descrição Geral |
| :---: | :--- | :--- |
| **E01** | **Criar Usuário** | Como administrador, quero gerenciar o cadastro de usuários para que seja possível organizar e controlar o acesso à plataforma. |
| **E02** | **Página do Período** | Como treinador, quero acessar uma visão geral dos períodos de treino dos alunos para acompanhar objetivos, progresso e particularidades de cada ciclo. |
| **E03** | **Gerar Gráficos** | Como usuário (aluno ou treinador), quero visualizar gráficos personalizados de desempenho para entender a evolução ao longo do tempo. |
| **E04** | **Página do Aluno** | Como treinador, quero acessar o perfil completo do aluno para visualizar informações pessoais, status e histórico de treinos. | REQ02,  |
| **E05** | **Registro de Treinos** | Como aluno, quero registrar meus treinos digitalmente para manter um histórico atualizado e acessível ao treinador. |
| **E06** | **PDF do Período** | Como treinador, quero exportar relatórios de período em PDF para documentar e compartilhar o desempenho dos alunos. |

## Histórias de Usuário

A tabela a seguir organiza os Épicos do seu projeto, detalhando o **Código**, o **Título** e a **Descrição Geral** de cada item de alto nível:

| Código | Título | Descrição Geral |
|:--------:|:--------:|:----------------:|
| US01   | Registro de novo usuário | Como um novo usuário, eu quero realizar meu registro no aplicativo para que eu possa ter pdf’s personalizados e atendimento mais pessoal. <br><br> **Descrição:** Ao abrir o app pela primeira vez, o usuário deve preencher suas informações (nome, CREF (opcional) e pronomes) para ser atendido como preferir. |
| US02   | Cadastro de aluno | Como um usuário, eu quero cadastrar um novo aluno para que eu possa acompanhar seus períodos e treinos. <br><br> **Descrição:** Permite adicionar um aluno com dados pessoais e objetos de acompanhamento. |
| US03   | Acesso ao perfil do aluno | Como um usuário, eu quero abrir o perfil de um aluno para que eu possa visualizar suas informações e períodos. <br><br> **Descrição:** Tela com dados do aluno, períodos ativos e anteriores. |
| US04   | Acesso a períodos ativos ou anteriores | Como um usuário, eu quero acessar períodos anteriores ou ativos de um aluno para que eu possa revisar ou acompanhar sua evolução. <br><br> **Descrição:** Navegação no perfil do aluno entre períodos concluídos e em andamento. |
| US05   | Cadastro de período de treino | Como um usuário, eu quero cadastrar um período de treino para um aluno para que ele tenha um plano estruturado e metas definidas. <br><br> **Descrição:** Cadastro de período com título, objetivo e plano de treino associado. |
| US06   | Registro de treinos em período ativo | Como um usuário, eu quero registrar treinos no período ativo de um aluno para que seu progresso seja acompanhado corretamente. <br><br> **Descrição:** Inclusão de treinos ao longo do período vigente. |
| US07   | Registro de exercícios em um treino | Como um usuário, eu quero registrar exercícios realizados em um treino para que eu possa detalhar carga, duração e outras informações. <br><br> **Descrição:** Cada treino pode ter exercícios vinculados com métricas registradas. |
| US08   | Edição de perfis e períodos | Como um usuário, eu quero editar perfis de alunos e períodos ativos para que eu possa manter informações sempre atualizadas. <br><br> **Descrição:** Alteração de dados de aluno, período, objetivos, planos e treinos. |
| US09   | Fechamento de período de treino | Como um usuário, eu quero fechar um período de treino de um aluno para que ele seja arquivado e um novo possa ser iniciado. <br><br> **Descrição:** Função para encerrar oficialmente um período ativo. |
| US10   | Geração de PDF ao encerrar período | Como um usuário, eu quero que o sistema gere um PDF ao fechar um período para que eu tenha um relatório baixável da evolução do aluno. <br><br> **Descrição:** Geração automática de arquivo PDF ao encerrar um período. |
| US11   | PDF completo de relatório | Como um usuário, quero que o PDF contenha título, plano de treino, datas, gráficos e variáveis para que o relatório seja completo. <br><br> **Descrição:** O PDF deve ser gerado com layout organizado e dados de evolução. |
| US12   | Busca de alunos por nome | Como um usuário, eu quero buscar alunos por nome para que eu encontre rapidamente o aluno desejado. <br><br> **Descrição:** Barra de busca dentro da lista de alunos cadastrados. |
| US13   | Ocultar alunos inativos | Como um usuário, eu quero ocultar alunos da minha lista para que eu possa organizar apenas os ativos. <br><br> **Descrição:** Função de marcar aluno como inativo, mantendo seus dados salvos. |
| US14   | Exclusão de aluno | Como um usuário, quero deletar um aluno cadastrado para que ele não apareça mais no sistema. <br><br> **Descrição:** Opção de exclusão definitiva de aluno. |
| US15   | Adição de observações | Como um personal, quero adicionar observações em diferentes locais do aplicativo para que eu registre informações adicionais relevantes. <br><br> **Descrição:** Campo de anotações livres em pontos estratégicos (aluno, período, treino, etc.). |

## Priorização do Backlog Geral e Definição do MVP

Para a priorização do backlog geral do sistema **TreinaAí**, a equipe optou por utilizar a técnica **MoSCoW**, conforme descrita na etapa de Engenharia de Requisitos, dentro do módulo de Análise e Consenso. Essa metodologia, amplamente reconhecida em abordagens ágeis, auxilia na identificação das funcionalidades essenciais para o Mínimo Produto Viável (MVP) e na definição daquelas que poderão ser implementadas em versões futuras.

### Técnica MoSCoW

A técnica MoSCoW classifica os requisitos em quatro níveis de prioridade:

- **Must Have (M)** – Deve Ter: Funcionalidades indispensáveis para o funcionamento básico do sistema. Sem elas, o produto não é considerado viável.

- **Should Have (S)** – Deveria Ter: Funcionalidades importantes, que agregam valor relevante, mas que podem ser adiadas sem comprometer a entrega inicial.

- **Could Have (C)** – Poderia Ter: Funcionalidades desejáveis, que melhoram a experiência do usuário, mas não são essenciais para o funcionamento mínimo.

- **Won’t Have (W)** – Não Terá por agora: Funcionalidades que não serão implementadas nesta versão, podendo ser consideradas em futuras atualizações.

### Processo de Priorização

A priorização dos requisitos foi definida com base em reuniões de alinhamento entre a equipe de desenvolvimento e o cliente, considerando os objetivos estratégicos do TreinaAí e as necessidades do público-alvo.

Dois fatores principais foram avaliados:

- **Valor para o negócio e experiência do usuário**: A importância de cada funcionalidade foi analisada de acordo com seu impacto direto na entrega de valor e na usabilidade do sistema definida pelo cliente em 0-10 e também com a técnica MoSCoW.

- **Viabilidade técnica e esforço de implementação**: A equipe realizou uma estimação de **0 a 5 do tempo necessário** para o desenvolvimento e somou com outra estimação de **0 a 5** com base no **nível de esforço** exigido para a implementação de cada funcionalidade.

Com base nesses critérios, todos os **Requisitos Funcionais (RF)** foram classificados segundo a técnica MoSCoW, permitindo à equipe definir de forma clara o escopo do MVP e organizar o backlog de maneira estratégica e eficiente.

## Definição do MVP

O MVP será composto por funcionalidades que possuam **alto valor de negócio** e possuam boa viabilidade, ou seja:

- Alto valor de negócio (Must Have ou Should Have segundo MoSCoW, junto da métrica feita com cliente);
- Baixo esforço de desenvolvimento (baixa pontuação em CT, de 4-8);

**Funcionalidades incluídas:**

``` REQ02, REQ03, REQ04, REQ05, REQ6, REQ07, REQ11, REQ012, REQ13, REQ14 ```

**Essas funcionalidades serão entregues na primeira versão do sistema, garantindo entrega rápida de valor com menor complexidade e maior impacto para o usuário final.**

**Objetivos específicos concluídos:**

- O1: reduzir o tempo de registro e acompanhamento de treinos;
- O2: Consolidar informações e métricas de treino em um lugar só (período) e por aluno;
- O3: apoiar o profissional com informações de progressão nos treinos.

O mvp proposto, portanto, resolve a grande maioria dos problemas apresentados pelo cliente, principalmente a falta de tempo para adição de métricas, dificuldade de visualização da evolução e a grande gama de alunos administrados em diferentes tabelas.


## Histórico de Versão

| Data     | Versão | Descrição             | Autor              |
| -------- | ------ | --------------------- | ------------------ |
| 28/09/2025 | 1.0    | Criação do Documento  | Gabriel Fae    |
| 06/10/2025 | 1.1 | Adição da priorizaão | Gabriel Fae|
| 07/10/2025 | 1.2 | Adição dos objetivos MVP | Gabriel Fae |


