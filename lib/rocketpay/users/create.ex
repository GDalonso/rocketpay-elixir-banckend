defmodule Rocketpay.Users.Create do
  #Cria mais de um alias simultâneamente
  alias Rocketpay.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()

  end
end
