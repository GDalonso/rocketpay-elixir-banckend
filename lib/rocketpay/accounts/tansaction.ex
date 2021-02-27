defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.Repo
  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Account.Transactions.Response, as: TransactionResponse

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    Multi.new()
    #Multi Faz uma mágica pra mergear duas transactions aqui, não executa na operation a transaction, só aqui
    |> Multi.merge(fn _changes -> Operation.call(build_params(from_id, value), :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(build_params(to_id, value), :deposit) end)
    |> run_transaction()
  end

  def build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: deposit, withdraw: withdraw}} ->
        {:ok, TransactionResponse.build(withdraw, deposit)}
    end
  end
end
