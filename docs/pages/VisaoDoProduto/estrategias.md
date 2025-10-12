# Estrategias de Engenharia de Software

Com base nas definições e solicitações do cliente, aliadas ao conhecimento da equipe e ao tempo disponível para a execução do projeto, definimos a estratégia a ser priorizada.

### Estratégia priorizada

- Abordagem de Desenvolvimento de Software: Ágil
- Ciclo de vida: Interativo e Incremental
- Processo de Engenharia de Software: ScrumXP

### Quadro comparativo

Segue anexo o quadro comparativo entre as duas principais opções de processos de ES.

| Características                 | RAD                                                                 | ScrumXP                                                                 |
|---------------------------------|---------------------------------------------------------------------|------------------------------------------------------------------------|
| Complexidade do processo        | Menos formal que metodologias tradicionais, com forte foco em prototipagem rápida e ciclos curtos de desenvolvimento. | Mais leve e ágil, com menos documentação formal e mais foco na entrega funcional, facilitando a adaptação contínua. |
| Qualidade Técnica               | Qualidade garantida pela validação frequente de protótipos junto ao cliente, mas pode pecar em aspectos estruturais se não houver disciplina. | Alta ênfase na qualidade técnica, com práticas como TDD (Test-Driven Development), Pair Programming e integração contínua para garantir um código limpo e funcional. |
| Práticas de Desenvolvimento     | Baseado em prototipagem e interação com o cliente. Menos práticas técnicas específicas dentro do processo. | Inclui práticas técnicas robustas como TDD, refatoração contínua, integração contínua e Pair Programming, promovendo alta qualidade do código. |
| Adaptação ao projeto do TreinaAi | Ideal para projetos que exigem protótipos rápidos para validação de ideias e feedback imediato do cliente (ex.: testar telas e fluxos com usuários). | Ideal para projetos onde a interação constante com o cliente e a evolução contínua do produto são fundamentais. Adaptável a mudanças frequentes e rápidos ciclos de feedback. |
| Documentação                    | Documentação reduzida, prioriza protótipos e comunicação direta, o que pode comprometer a rastreabilidade em projetos maiores. | Minimiza a documentação formal, com foco em comunicação e feedback rápido. A documentação é apenas o essencial. |
| Controle de Qualidade           | Baseado em validação dos protótipos e feedback contínuo do cliente durante o processo. | Controle de qualidade embutido nas práticas do XP, como TDD e integração contínua, garantindo que o software seja testado a cada nova funcionalidade. |
| Escalabilidade                  | Funciona melhor em equipes pequenas e médias, voltado para aplicações de menor porte ou com necessidade de rápida entrega. | Escalável, mas mais indicado para equipes menores e médias devido à sua abordagem colaborativa e interativa constante. |

## Justificativa

Depois de longa análise e Com base nas características do projeto e nos desafios enfrentados pela TreinaAí, o ScrumXP é o processo mais adequado pelos seguintes motivos:

#### 1. Flexibilidade e Entregas Rápidas:

- Considerando que a TreinaAí conta com uma equipe pequena e um prazo limitado de dois meses, o ScrumXP possibilita entregas incrementais semanais, garantindo que cada iteração traga adaptações já prontas para os alunos. Esse ritmo assegura feedback contínuo do cliente e ajustes ágeis, permitindo que o aplicativo evolua de acordo com as necessidades reais de professores e alunos.

#### 2. Aprendizado e Readequação de Requisitos:

- Durante o desenvolvimento, a capacidade da equipe de aprender com o processo e refazer requisitos quando necessário foi um ponto crucial para validar o uso do ScrumX, pela permissão de tratar requisitos como variáveis. Essa abordagem colaborativa torna o projeto mais adaptável às mudanças naturais que surgem ao longo do ciclo de desenvolvimento.

#### 3. Práticas de Alta Qualidade Técnica:

- Os desafios técnicos da TreinaAí, como a organização e visualização de dados em tempo real e a escalabilidade da aplicação, podem ser superados com as práticas do XP, como TDD e integração contínua. Isso garante que o código seja constantemente testado e validado, mantendo a qualidade do sistema mesmo com entregas frequentes.

#### 4. Adaptação ao Nível de Conhecimento da Equipe:

- A equipe ainda possui pouca experiência com algumas tecnologias, o ScrumXP se mostra ideal por estimular aprendizado contínuo, colaboração intensa e evolução iterativa, evitando a rigidez de metodologias mais formais como 

#### 5. Entrega de Valor:

- O app TreinaAí precisa oferecer uma solução que agregue valor em cada sprit para o cliente. Por mais que a RAD permitisse uma visualização mais rápida de telas e funciona muito bem com feedback constante, a permissão de adicionar alto valor em cada sprint e ainda receber feedbacks em períodos não muito distantes facilita muito o processo de desenvolvimento.


### Histórico de Versão

| Data     | Versão | Descrição             | Autor              |  
| -------- | ------ | --------------------- | ------------------ |
| 15/09/2025 | 1.0   | Definição inicial  | Gabriel Fae    |