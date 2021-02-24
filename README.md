# Rocketpay

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


# Criando api

`mix phx.new rocketpay --no-webpack --no-html`

# Subindo docker postgres

`docker run -d -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=mysecretpassword postgres`

alterar a senha no dev.exs e test.exs

## cria as tabelas no banco

`mix ecto.setup` 

## gera a config do credo

`mix credo gen.config`

# Subir

`mix phx.server`

- http://localhost:4000/dashboard
- http://localhost:4000/api/

# Terminal iterativo no projeto

`iex -S mix`

`Rocketpay.Numbers.acc_file_values("numbers")`

## atualizando o terminal sem encerrar

`recompile`

# Rodando testes

`mix test`

# Criando um arquivo de migration

`mix ecto.gen.migration create_user_table`

cria o arquivo da migration no priv>repo>migrations que você altera com os dados da tabela

adicione no config.exs

`
#altera os ids do postgres para UUID ao invés de integer
config :rocketpay, Rocketpay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]
`

Cria as tabelas baseadas nos arquivos de migration

`mix ecto.migrate`

# validando o changeset - a validação de dados de entrada

num terminal iterativo

`Rocketpay.User.changeset(%{name: "batata", password: "hue546", email: "hue@hue.com", nickname: "uaeh", age: 23})`

# Cria um usuário no DB

`Rocketpay.create_user(%{name: "batata", password: "hue546", email: "hue@hue.com", nickname: "uaeh", age: 23})`

# select all

`Rocketpay.Repo.all(Rocketpay.User)`