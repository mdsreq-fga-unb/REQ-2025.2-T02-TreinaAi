# Backlog do Produto

  

O **Backlog do Produto** é uma lista viva e priorizada de tudo que é necessário para construir, manter e aprimorar um produto, servindo como uma **única fonte de requisitos** para qualquer mudança no produto.

  

Todos os épicos e histórias de usuário apresentados nesta página compõem o **Mínimo Produto Viável (MVP)** do projeto. Ou seja, representam o conjunto essencial de funcionalidades necessárias para garantir a entrega de valor inicial aos usuários, permitindo validação, testes e evolução futura da aplicação.

  

### Itens do Backlog e Sua Estrutura

  

Os itens dentro do Backlog são hierárquicos:

  

1.  **Épicos (Epics):**

*  **O que são:** Itens grandes e abrangentes que representam um recurso ou funcionalidade significativa. São grandes demais para serem entregues em um único ciclo de desenvolvimento (Sprint).

*  **Estrutura Básica:** Título (`E01 – Criar Usuário`) e **Descrição Geral** (o propósito e o valor do recurso).

2.  **Histórias de Usuário (User Stories - US):**

*  **O que são:** Pequenas descrições de um recurso do ponto de vista do usuário final. Representam a menor unidade de trabalho que agrega valor.

*  **Estrutura Básica Comum:** "Como um [tipo de usuário], eu quero [alguma meta], para que [algum benefício]."

---

  

## Épicos do Projeto

  

A tabela a seguir organiza os Épicos do seu projeto, detalhando o Código, o Título e a Descrição Geral de cada item de alto nível:

  

| Código | Título | Descrição Geral |

| :---: | :--- | :--- |

| **E01** | **Criar Usuário** | O sistema deve permitir o cadastro do usuário, possibilitando que informações pessoais sejam armazenadas de forma organizada e segura para uso posterior. Esse recurso servirá como base para o gerenciamento dos alunos dentro da aplicação. |

| **E02** | **Página do Período** | O sistema deve disponibilizar uma página de período para organizar e acompanhar os treinos dos alunos de forma digital. Essa página funcionará como um painel central em que serão definidos objetivos, peculiaridades do treino e observações específicas de cada aluno, substituindo os registros manuais em papel. |

| **E03** | **Gerar Gráficos** | O sistema deve permitir a geração de gráficos personalizados a partir de métricas selecionadas, possibilitando que treinadores e alunos visualizem de forma clara a evolução do desempenho. Os gráficos poderão ser gerados em diferentes formatos e compartilhados facilmente. |

| **E04** | **Página do Aluno** | O sistema deve oferecer uma página dedicada a cada aluno, onde seja possível visualizar e editar seu perfil completo. Essa página deve concentrar informações pessoais, períodos de treino e status de atividade (ativo/inativo), além de permitir operações CRUD (criar, visualizar, atualizar e excluir). | REQ02, |

| **E05** | **Registro de Treinos** | O sistema deve permitir o registro de treinos de forma digital e centralizada, eliminando a dependência do aluno para anotar cargas e execuções. Esse recurso possibilita ao treinador controlar e salvar o histórico de treinos diretamente na plataforma. |

| **E06** | **PDF do Período** | O sistema deve permitir exportar relatórios em PDF contendo a evolução e os objetivos cumpridos pelos alunos em um determinado período. |

  

## Histórias de Usuário

  

A tabela a seguir organiza os Épicos do seu projeto, detalhando o **Código**, o **Título** e a **Descrição Geral** de cada item de alto nível:

  

| Código | Título | Descrição Geral |

|:--------:|:--------:|:----------------:|

| US01 | Registro de novo usuário | Como um novo usuário, eu quero realizar meu registro no aplicativo para que eu possa ter pdf’s personalizados e atendimento mais pessoal. <br><br> **Descrição:** Ao abrir o app pela primeira vez, o usuário deve preencher suas informações (nome, CREF (opcional) e pronomes) para ser atendido como preferir. |

| US02 | Cadastro de aluno | Como um usuário, eu quero cadastrar um novo aluno para que eu possa acompanhar seus períodos e treinos. <br><br> **Descrição:** Permite adicionar um aluno com dados pessoais e objetos de acompanhamento. |

| US03 | Acesso ao perfil do aluno | Como um usuário, eu quero abrir o perfil de um aluno para que eu possa visualizar suas informações e períodos. <br><br> **Descrição:** Tela com dados do aluno, períodos ativos e anteriores. |

| US04 | Acesso a períodos ativos ou anteriores | Como um usuário, eu quero acessar períodos anteriores ou ativos de um aluno para que eu possa revisar ou acompanhar sua evolução. <br><br> **Descrição:** Navegação no perfil do aluno entre períodos concluídos e em andamento. |

| US05 | Cadastro de período de treino | Como um usuário, eu quero cadastrar um período de treino para um aluno para que ele tenha um plano estruturado e metas definidas. <br><br> **Descrição:** Cadastro de período com título, objetivo e plano de treino associado. |

| US06 | Registro de treinos em período ativo | Como um usuário, eu quero registrar treinos no período ativo de um aluno para que seu progresso seja acompanhado corretamente. <br><br> **Descrição:** Inclusão de treinos ao longo do período vigente. |

| US07 | Registro de exercícios em um treino | Como um usuário, eu quero registrar exercícios realizados em um treino para que eu possa detalhar carga, duração e outras informações. <br><br> **Descrição:** Cada treino pode ter exercícios vinculados com métricas registradas. |

| US08 | Edição de perfis e períodos | Como um usuário, eu quero editar perfis de alunos e períodos ativos para que eu possa manter informações sempre atualizadas. <br><br> **Descrição:** Alteração de dados de aluno, período, objetivos, planos e treinos. |

| US09 | Fechamento de período de treino | Como um usuário, eu quero fechar um período de treino de um aluno para que ele seja arquivado e um novo possa ser iniciado. <br><br> **Descrição:** Função para encerrar oficialmente um período ativo. |

| US10 | Geração de PDF ao encerrar período | Como um usuário, eu quero que o sistema gere um PDF ao fechar um período para que eu tenha um relatório baixável da evolução do aluno. <br><br> **Descrição:** Geração automática de arquivo PDF ao encerrar um período. |

| US11 | PDF completo de relatório | Como um usuário, quero que o PDF contenha título, plano de treino, datas, gráficos e variáveis para que o relatório seja completo. <br><br> **Descrição:** O PDF deve ser gerado com layout organizado e dados de evolução. |

| US12 | Busca de alunos por nome | Como um usuário, eu quero buscar alunos por nome para que eu encontre rapidamente o aluno desejado. <br><br> **Descrição:** Barra de busca dentro da lista de alunos cadastrados. |

| US13 | Ocultar alunos inativos | Como um usuário, eu quero ocultar alunos da minha lista para que eu possa organizar apenas os ativos. <br><br> **Descrição:** Função de marcar aluno como inativo, mantendo seus dados salvos. |

| US14 | Exclusão de aluno | Como um usuário, quero deletar um aluno cadastrado para que ele não apareça mais no sistema. <br><br> **Descrição:** Opção de exclusão definitiva de aluno. |

| US15 | Adição de observações | Como um personal, quero adicionar observações em diferentes locais do aplicativo para que eu registre informações adicionais relevantes. <br><br> **Descrição:** Campo de anotações livres em pontos estratégicos (aluno, período, treino, etc.). |

  


## Priorização do Backlog e Definição do MVP

Para organizar e priorizar o backlog do sistema **TreinaAí**, foram aplicadas duas técnicas complementares:

- **MoSCoW**, para classificação geral de criticidade;
- **Avaliação categórica de Valor e Complexidade**, com níveis definidos em **Baixo / Médio / Alto**.

Essas técnicas permitem entender tanto a importância estratégica de cada requisito quanto seu custo aproximado de implementação.

---


### Técnica MoSCoW

  

A técnica MoSCoW classifica os requisitos em quatro níveis de prioridade:

  

-  **Must Have (M)** – Deve Ter: Funcionalidades indispensáveis para o funcionamento básico do sistema. Sem elas, o produto não é considerado viável.

  

-  **Should Have (S)** – Deveria Ter: Funcionalidades importantes, que agregam valor relevante, mas que podem ser adiadas sem comprometer a entrega inicial.

  

-  **Could Have (C)** – Poderia Ter: Funcionalidades desejáveis, que melhoram a experiência do usuário, mas não são essenciais para o funcionamento mínimo.

  

-  **Won’t Have (W)** – Não Terá por agora: Funcionalidades que não serão implementadas nesta versão, podendo ser consideradas em futuras atualizações.

---

## Avaliação de Valor de Negócio e Complexidade (Baixo / Médio / Alto)

Além do MoSCoW, cada requisito também recebeu uma avaliação segundo dois critérios:

---

### Valor de Negócio

| Nível | Definição |
|------|-----------|
| **Baixo** | Impacto limitado; funcionalidade complementar. |
| **Médio** | Melhora relevante para usuários; facilita operações. |
| **Alto** | Impacto direto no objetivo do produto; elemento central do funcionamento. |

---

### Complexidade / Esforço Técnico

| Nível | Definição |
|------|-----------|
| **Baixa** | Implementação simples; poucas dependências; baixo tempo. |
| **Média** | Exige integração moderada, validações ou interface dedicada. |
| **Alta** | Necessita múltiplas integrações, cálculos complexos ou tratamento avançado de dados. |

---

## Matriz de Priorização (Valor × Complexidade)

| Valor \ Complexidade | Baixa | Média | Alta |
|----------------------|-------|-------|------|
| **Alta** | Prioridade Máxima | Alta | Avaliar retorno |
| **Média** | Alta | Média | Baixa |
| **Baixa** | Média | Baixa | Mínima |

Essa matriz permite identificar:

- **Entregar primeiro:** Alto valor + baixa complexidade  
- **Planejar com cuidado:** Alto valor + alta complexidade  
- **Deixar para depois:** Baixo valor + alta complexidade

---

# Definição do MVP

O MVP é composto por funcionalidades que apresentam:

- **Alto valor** (segundo MoSCoW e a matriz de valor);  
- **Baixa ou média complexidade**;  
- **Relevância direta para os objetivos principais do produto**.

  

**Funcionalidades incluídas:**

  

``` REQ02, REQ03, REQ04, REQ05, REQ07, REQ10, REQ11, REQ012, REQ13, REQ14 ```

  

**Essas funcionalidades serão entregues na primeira versão do sistema, garantindo entrega rápida de valor com menor complexidade e maior impacto para o usuário final.**

  

**Objetivos específicos concluídos:**

  

- O1: reduzir o tempo de registro e acompanhamento de treinos;

- O2: Consolidar informações e métricas de treino em um lugar só (período) e por aluno;

- O3: apoiar o profissional com informações de progressão nos treinos.

  

O mvp proposto, portanto, resolve a grande maioria dos problemas apresentados pelo cliente, principalmente a falta de tempo para adição de métricas, dificuldade de visualização da evolução e a grande gama de alunos administrados em diferentes tabelas.

  
  

## Histórico de Versão

  

| Data | Versão | Descrição | Autor |

| -------- | ------ | --------------------- | ------------------ |

| 28/09/2025 | 1.0 | Criação do Documento | Gabriel Fae |

| 06/10/2025 | 1.1 | Adição da priorização | Gabriel Fae|

| 07/10/2025 | 1.2 | Adição dos objetivos MVP | Gabriel Fae |

| 16/11/2025 | 1.3 | Ajustes na priorização | Davi Negreiros |