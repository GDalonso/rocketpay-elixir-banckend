defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    #cria a tabela e as colunas
    #O campo id é gerado automaticamente na criação da tabela, não precisa explicitar
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      timestamps() #adiciona as colunas inserted at e updated at
    end

    #Cria índices no banco
    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end
