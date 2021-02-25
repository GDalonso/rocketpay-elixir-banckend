defmodule Rocketpay.Users.Create do
  #Cria mais de um alias simultâneamente
  alias Rocketpay.{Repo, User}
  alias Ecto.Multi
  alias Rocketpay.Account
  alias Io

  def call(params) do
    #Multi é o módulo de transaction/multiplas operações do Ecto
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
        repo.insert(account_changeset(user.id))
      end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user}->
        preload_data(repo, user)
      end)
    |> run_transaction()

  end
  defp account_changeset(user_id) do Account.changeset(%{user_id: user_id, balance: "0.00"})
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
  defp preload_data(repo, user) do
    {:ok, Repo.preload(user, :account)}
  end
end
