
# Projeto de Modelagem de Crédito com Data Build Tool + PostgreSQL

Este projeto tem como objetivo aprender conceitos básicos de modelagem com o [dbt (Data Build Tool)](https://docs.getdbt.com/), utilizando um banco de dados PostgreSQL local, com foco em dados financeiros fictícios da área de crédito.

## 📊 Regra de negócio fictícia

Uma empresa possui um sistema de análise de crédito que armazena transações na tabela `raw_credit_transactions`. Cada transação representa uma solicitação de crédito feita por um cliente.

Precisa-se tratar esses dados para criar uma visão mais limpa e útil para análises. Para isso, aplicamos regras como:

- Conversão do valor solicitado (`amount`) para um tipo decimal padrão
- Filtro de dados incompletos (sem data de criação)
- Criação de uma coluna `is_approved` com valor booleano para facilitar a análise de status

## ⚙️ Requisitos

- Python 3.7+
- PostgreSQL local (Docker ou instalação nativa)
- dbt core instalado com adapter `dbt-postgres`

```bash
pip install dbt-core dbt-postgres
```

## 🐘 Setup do banco de dados PostgreSQL

### Criação da tabela de dados brutos:

```sql
CREATE TABLE public.raw_credit_transactions (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL,
    status TEXT,
    created_at TIMESTAMP
);

INSERT INTO raw_credit_transactions (user_id, amount, status, created_at) VALUES
(101, 1500.75, 'approved', '2025-04-01 10:00:00'),
(102, 800.00, 'rejected', '2025-04-02 11:30:00'),
(103, NULL, 'pending', NULL),
(104, 560.50, 'approved', '2025-04-03 09:15:00'),
(105, 700.50, 'approved', '2025-04-03 09:20:00'),
(106, 810.50, 'rejected', '2025-04-04 14:50:00'),
(107, 1065.50, 'rejected', NULL),
(108, 2200.50, 'approved', '2025-04-05 08:00:00'),
(109, 1200.00, 'pending', '2025-04-05 08:15:00'),
(110, 1450.25, 'approved', '2025-04-06 12:45:00'),
(111, 999.99, 'approved', '2025-04-07 09:00:00'),
(112, 300.00, 'rejected', '2025-04-07 10:10:00'),
(113, 500.00, 'approved', '2025-04-07 11:15:00'),
(114, 800.00, 'pending', '2025-04-08 13:00:00'),
(115, 2000.00, 'approved', '2025-04-08 13:30:00'),
(116, 950.00, 'rejected', '2025-04-09 15:20:00'),
(117, 1125.00, 'approved', '2025-04-09 16:10:00'),
(118, 1350.00, 'approved', '2025-04-10 17:45:00'),
(119, 675.00, 'pending', '2025-04-10 18:30:00'),
(120, 1234.56, 'approved', '2025-04-11 08:55:00');

```

## ▶️ Como executar

1. Inicialize:

```bash
dbt init
```

2. Execute os modelos:

```bash
dbt run
```

3. Rode os testes:

```bash
dbt test
```

---

## 📚 Geração da documentação

```bash
dbt docs generate
dbt docs serve
```

Acesse: http://localhost:8000 para visualizar a documentação interativa com descrição de colunas, fontes e lineage.


## ✅ Resultado esperado

Ao rodar o projeto com sucesso, o dbt irá criar uma `VIEW` chamada:

```
public.stg_credit_transactions
```

Para verificar os dados transformados, pode-se fazer a query:
```
select * from staging.stg_credit_transactions;
```
Agora os dados estão tratados e prontos para análise exploratória ou construção de dashboards.

---