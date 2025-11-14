Aqui, analisamos cada etapa referente ao produto que pretendemos produzir, junto a seus objetivos, características, dificuldades e facilidades.

## 2.1 Objetivos do Produto

Com este produto, buscamos otimizar o trabalho de personal trainers e professores de educação física, permitindo que o registro, acompanhamento e análise dos treinos dos alunos sejam feitos de forma mais rápida, organizada e estratégica. Além de reduzir o tempo gasto em anotações manuais ou planilhas, a solução visa centralizar todas as informações de treino em um ambiente intuitivo, permitindo que o profissional e, de forma complementar, o próprio aluno, compreendam facilmente o progresso e desempenho físico.

**Objetivo geral (OG) do projeto:** 

- Desenvolver uma plataforma digital que otimize o trabalho de personal trainers e professores de educação física, permitindo o registro, acompanhamento e análise de treinos de forma centralizada, rápida e confiável, aprimorando o gerenciamento do desempenho dos alunos.


## 2.2 Características da Solução

A solução será uma plataforma mobile, acessível pelo personal trainer ou professor de educação física, que trará ferramentas para tornar o registro, acompanhamento e análise dos treinos mais práticos, organizados e estratégicos.
Entre as principais características estão:

*Tabela 01: Características da Solução*

<a id="tabela-1"></a> <a id="TAB01"></a>

| Código | Característica        | Descrição                                          |
|:-------:|:-----------------------:|-----------------------------------------------------:|
| C01 <a id="C01"></a>| Cadastro de alunos | Regisgro de alunos com informações completas, como nome e descrição, de forma dinâmica. |
| C02 <a id="C02"></a>| Planejamento de treinos | Criação e organização de planos de treino personalizados para cada aluno, com exercícios, séries, repetições e cargas. |
| C03 <a id="C03"></a>| Registro detalhado de treinos | Permitir o registro completo de cada sessão de treino, incluindo carga, séries, repetições, tipo de estímulo e observações. |
| C04 <a id="C04"></a>| Histórico e comparativos | Visualização da evolução dos alunos ao longo do tempo, com gráficos e indicadores de desempenho. |
| C05 <a id="C05"></a>| Relatórios visuais | Geração de gráficos e relatórios de evolução para análise do desempenho dos alunos. |
| C06 <a id="C06"></a>| Autonomia e flexibilidade | Permitir que cada profissional gerencie seus treinos, relatórios e ajustes de forma independente. |
| C07 <a id="C07"></a>| Feedback motivador para alunos | Disponibilizar a visualização do progresso de forma clara, reforçando o engajamento dos alunos. |

### Objetivos Específicos (OE) do projeto:

*Tabela 02: Objetivos Específicos do Projeto*

<a id="tabela-2"></a> <a id="TAB01"></a>

| Código | Objetivo Específico   | Indicador de Sucesso                                |
|:--------:|:-----------------------:|:---------------------------------------------------:|
| OE1 <a id="OE1"></a>| Reduzir o tempo necessário para registrar e acompanhar treinos. | O profissional consegue registrar um treino completo em menos de 20 minutos. |
| OE2 <a id="OE2"></a>| Centralizar todas as informações de treino em um único ambiente. | Todas as variáveis do treino (carga, séries, repetições, estímulos etc.) podem ser consultadas em uma única tela/página, eliminando múltiplas planilhas ou consultas separadas. |
| OE3 <a id="OE3"></a>| Fornecer ferramentas visuais para análise de desempenho. | O profissional pode gerar gráficos e relatórios de evolução com apenas alguns cliques, facilitando a compreensão do progresso dos alunos. |
| OE4 <a id="OE4"></a>| Permitir personalização de indicadores e métricas de acordo com o perfil do aluno.| O profissional consegue configurar ao menos 3 indicadores personalizados por aluno sem necessidade de realizar trabalho manual |
| OE6 <a id="OE5"></a>| Aumentar a motivação e engajamento dos alunos por meio de feedback visual. | Pelo menos 80% dos alunos relatam maior motivação para continuar os treinos após visualizarem seu progresso na plataforma. |


## 2.3 Tecnologias a Serem Utilizadas

Para o desenvolvimento da solução proposta, serão utilizadas tecnologias modernas e amplamente adotadas no mercado, garantindo escalabilidade, desempenho e manutenção facilitada. A arquitetura será baseada na separação entre front-end e back-end, com integração a um banco de dados relacional robusto e uso de ferramentas de automação para testes de qualidade.

- **Front-end:** O desenvolvimento do aplicativo mobile será realizado com o framework **Flutter**, utilizando a linguagem **Dart**. Essa escolha permite construir interfaces nativas para múltiplas plataformas (Android e iOS) a partir de uma única base de código, reduzindo custos e tempo de desenvolvimento, além de proporcionar alto desempenho e experiência de uso fluida, fora o maior ponto positivo: a facilidade de criação de tabelas, gráficos e visuais.

- **Back-end:** A camada de servidor será implementada com **Node.js** em typescript, oferecendo uma base robusta, escalável e com tipagem estática para maior segurança no desenvolvimento. Essa combinação favorece a produtividade da equipe e garante uma arquitetura flexível para a evolução futura do sistema.

- **Banco de Dados:** Para o armazenamento dos dados será utilizado o sistema de gerenciamento de banco de dados relacional **PostgreSQL**, reconhecido por sua confiabilidade, suporte a dados complexos e alta performance em ambientes com grande volume de informações, além da grende comunidade online que pode ensinar e facilitar o aprendizado.

- **Garantia de Qualidade (QA):** Para a automação de testes será adotado o framework **Appium**, que permite a execução de testes funcionais em múltiplas plataformas móveis. Essa ferramenta garantirá a qualidade e estabilidade do aplicativo, reduzindo falhas e garantindo uma experiência consistente para os usuários finais.


## 2.4 Pesquisa de Mercado e Análise Competitiva

Nos últimos anos, o mercado de aplicativos voltados para saúde, bem-estar e fitness tem apresentado crescimento significativo, impulsionado pela digitalização de serviços e pelo aumento da procura por acompanhamento físico personalizado. 

Atualmente, já existem plataformas que oferecem acompanhamento de métricas de treino, como MyFitnessPal, SmartFit, Nike Training Club e MFIT Personal.

Entretanto, em entrevistas realizadas, o cliente destacou que não conhece aplicativos que ofereçam uma organização completa dos treinos voltada para o trabalho do profissional. Segundo ele, utiliza apenas um app que gera gráficos de força do exercício, mas considera a ferramenta imprecisa, pois depende que o aluno insira manualmente a carga utilizada. 

Na visão de Gustavo, essa limitação inviabiliza o uso no dia a dia, já que ele gostaria de um sistema que pudesse alimentar sozinho, de forma prática, sem depender do aluno.

## 2.5 Análise de Viabilidade

A viabilidade técnica do projeto é considerada alta, mesmo que a equipe não possua experiência prévia em **FLutter**, tecnologia escolhida para o desenvolvimento do aplicativo mobile. 

Os integrantes já possuem sólida experiência em front-end e back-end, o que facilita a curva de aprendizagem e a adaptação ao novo framework. Além disso, o escopo do projeto não envolve integrações complexas ou funcionalidades críticas de difícil implementação, o que torna o processo mais acessível e adequado ao nível atual da equipe.

O prazo estimado para o desenvolvimento é de seis meses, dividido em sprints quinzenais. Cada sprint resultará em entregas incrementais de funcionalidades, que poderão ser avaliadas e ajustadas rapidamente de acordo com o feedback do cliente. 

Esse cronograma é considerado viável, uma vez que o cliente demonstrou grande flexibilidade e abertura para adaptações, reduzindo a pressão por entregas rígidas e permitindo que a equipe avance de forma consistente.

Em termos de competência, os desenvolvedores já possuem domínio em tecnologias de back-end e front-end, o que garante a qualidade da arquitetura, segurança e escalabilidade da aplicação. 

A introdução de Flutter, mesmo sendo uma novidade, será incorporada com o apoio de práticas ágeis e aprendizagem contínua ao longo do processo, servindo como oportunidade de crescimento técnico para a equipe. 

Com isso, o projeto mantém alta viabilidade e baixo risco, sustentado pelo equilíbrio entre aprendizado, apoio do cliente e experiência consolidada em desenvolvimento web.

---

## 2.6 Impacto da Solução

Os benefícios para os usuários serão percebidos com essa nova forma de demonstrar ganho de força e resistência em atividades físicas: os alunos ficarão mais motivados a seguir com o acompanhamento dos personais. 

#### Redução do tempo de registro - OE1 & OE4

A redução do tempo de registro e acompanhamento de treinos melhora significativamente a produtividade dos profissionais, permitindo que atendam mais alunos por dia, diminuam o tempo gasto em atividades administrativas e dediquem mais atenção ao planejamento de treinos e à qualidade do acompanhamento individual.

#### Centralização das informações - OE2 

A centralização dos dados elimina a necessidade de navegar entre planilhas, aplicativos ou anotações físicas, reduzindo erros humanos e aumentando a confiabilidade das informações. Isso resulta em maior organização, facilidade de consulta e ganho de eficiência no processo de acompanhamento dos alunos.

#### Ferramentas visuais de análise de desempenho - OE3 & OE4 

A disponibilização de gráficos e relatórios automáticos facilita a interpretação de dados complexos, permitindo que o profissional tome decisões mais embasadas sobre ajustes de carga, periodização e evolução dos alunos. Isso aprimora a qualidade das prescrições e favorece resultados mais consistentes.

A possibilidade de configurar indicadores específicos para cada aluno torna o acompanhamento mais alinhado aos objetivos individuais, aumentando a precisão das análises e a relevância das métricas. Isso contribui para planos de treino mais personalizados e eficazes, elevando o valor percebido pelo aluno.

#### Aumento da motivação e engajamento - OE5, OE3 & OE4

O fornecimento de feedback visual sobre o progresso aumenta o engajamento dos alunos, tornando o processo de treino mais recompensador e estimulante. A sensação de evolução contínua contribui para maior aderência ao programa de treinos, diminuição da taxa de desistência e melhora geral na experiência do usuário.

## Histórico de Versão

| Data     | Versão | Descrição             | Autor              |
| -------- | ------ | --------------------- | ------------------ |
| 14/09/2025 | 1.0    | Criação do Documento  | Gabriel Fae    |
| 22/09/2025 | 1.1 | Refinamento | Gabriel Fae | 
| 14/11/2025 | 1.2 | Ajuste para correção issue #1 | Gabriel Fae |

