# 1. Consultar Disponibilidade de Horário

## 1.1 Breve Descrição

Este caso de uso permite ao Paciente consultar, em tempo real, a disponibilidade de horários de atendimento oferecidos por Profissionais de Saúde ou unidades parceiras cadastradas no ConnectCare. A partir desta funcionalidade, o paciente pode localizar serviços de saúde, aplicar filtros de busca e visualizar os horários disponíveis, preparando-se para realizar o agendamento em seguida. Nenhuma reserva é efetivada neste caso de uso.

## 1.2 Atores

- Paciente - ator principal
- Profissional de Saúde - ator secundário

---

# 2. Fluxo de Eventos

## 2.1 Fluxo Principal

Este caso de uso é iniciado quando o Paciente escolhe a opção “Buscar Serviços de Saúde”.

2.1.1 O sistema apresenta filtros de busca, como tipo de atendimento, localização e especialidade.

2.1.2 O Paciente preenche e confirma os filtros desejados.

2.1.3 O sistema sugere unidades de saúde e profissionais compatíveis com a busca realizada [RN02].

2.1.4 O Paciente seleciona a unidade de saúde ou profissional exibido na lista de resultados.

2.1.5 O Paciente escolhe a opção “Consultar Disponibilidade de Horário”.

2.1.6 O sistema acessa a agenda do profissional/unidade e verifica se os dados estão registrados e atualizados [RN01][FE02].

2.1.7 O sistema apresenta a grade com os horários disponíveis para os próximos dias.

2.1.8 O Paciente visualiza as opções e seleciona um horário disponível.

2.1.9 O sistema registra a consulta realizada no log.

2.1.10 O caso de uso é encerrado, encaminhando o horário selecionado para o caso de uso “Agendar Consulta”.


## 2.2 Fluxos Alternativos

### 2.2.1 [FA01] Ajustar Filtros de Busca

No passo 2.1.4 o Paciente decide alterar os filtros utilizados.

2.2.1.1 O sistema exibe novamente a área de filtros.
2.2.1.2 O Paciente ajusta os filtros e confirma.
2.2.1.3 O sistema apresenta nova lista de unidades e profissionais.

(Retorna ao passo 2.1.4)


### 2.2.2 [FA02] Sugerir Atendimento Alternativo

No passo 2.1.7 o Paciente não encontra horários satisfatórios.

2.2.2.1 O sistema identifica indisponibilidade ou dificuldade de acesso.
2.2.2.2 O sistema apresenta serviços alternativos, como campanhas móveis ou visitas domiciliares.

(O fluxo pode encerrar ou o Paciente pode seguir para o agendamento alternativo)


## 2.3 Fluxos de Exceção

### 2.3.1 [FE01] Horários Esgotados

No passo 2.1.7 o sistema identifica que não existe disponibilidade para o dia solicitado.
O sistema exibe mensagem informando indisponibilidade e oferece visualização de datas futuras.
O fluxo retorna ao passo 2.1.7 ou encerra.



### 2.3.2 [FE02] Dados do Profissional Não Registrados

No passo 2.1.6 o sistema identifica ausência ou inconsistência na agenda cadastrada.
O sistema informa a indisponibilidade e sugere ao Paciente escolher outra unidade.
O caso de uso é encerrado.

---

# 3. Requisitos Especiais

3.1 A funcionalidade deve oferecer desempenho adequado mesmo em dispositivos simples ou com baixa conectividade.
3.2 O sistema deve permitir mapear e exibir unidades de saúde geograficamente próximas ao Paciente.

---

# 4. Regras de Negócio

4.1 [RN01] Cadastro de Disponibilidade
O Profissional de Saúde deve registrar previamente sua agenda para que o sistema possa exibir os horários disponíveis.

4.2 [RN02] Sugestões Personalizadas
As sugestões de unidades ou profissionais devem considerar dados básicos do Paciente, como idade, condições preexistentes e sintomas informados.

---

# 5. Precondições

5.1 O Paciente deve estar autenticado no sistema.
5.2 As unidades de saúde e profissionais devem ter agendas e dados atualizados no sistema.

---

# 6. Pós-condições

6.1 O Paciente conhece os horários disponíveis para o atendimento desejado.
6.2 O sistema registra a consulta realizada no log de auditoria.

---

# 7. Pontos de Extensão

7.1 Nos passos 2.1.3 e 2.2.1.3 este caso de uso pode ser estendido por “Buscar Serviço de Saúde”.
7.2 Após o passo 2.1.8 este caso de uso pode ser estendido por “Agendar Consulta”.