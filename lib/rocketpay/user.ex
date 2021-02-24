defmodule Rocketpay.User do
  #Esse é um exemplo de schema de banco pra manipular dados no banco de dados

  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  import Pbkdf2

  #Cria uma primary key autoincrement
  #binary_id é o tipo de dado UUID
  @primary_key {:id, :binary_id, autogenerate: true}

  #Validação de dados, parâmetros obrigatórios
  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    #Campo projetado, não é gravado no banco de dados
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    #adiciona info das colunas inserted at e updated at
    timestamps()
  end

  #valida parâmetros enviados
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    #Validações de dados
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_length(:password, min: 5)
    #regex de email
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  #recebe um struct do tipo changeset
  #Pega a variável password usando pattern matching
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    #hasheia o password
    change(changeset, Pbkdf2.add_hash(password))
  end
  #caso não tenha match, erro
  defp put_password_hash(changeset), do: changeset

end
