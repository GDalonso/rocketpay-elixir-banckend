#.exs = script


defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  #nome_da_funcao_publica/qtd_de_args
  describe "acc_file_values/1" do
    test "Soma todos os numeros de um arquivo" do
      response = Numbers.acc_file_values("numbers")
      assert response == {:ok, %{result: 353}}
    end
    test "arquivo inexistente, erro" do
      response = Numbers.acc_file_values("HUEE")
      assert response == {:error, %{message: "arquivo nao encontrado!"}}
    end

  end
end
