defmodule Rocketpay.Account do
  #Esse é um exemplo de schema de banco pra manipular dados no banco de dados

  use Ecto.Schema
  import Ecto.Changeset
  alias Rocketpay.User

  #Cria uma primary key autoincrement
  #binary_id é o tipo de dado UUID
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  #Validação de dados, parâmetros obrigatórios
  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    #adiciona info das colunas inserted at e updated at
    timestamps()
  end

  #valida parâmetros enviados
  #Esse changeset faz update por receber o struct antigo
  #struct OR vazio
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    #valida a constraint criada na migration
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
