defmodule Rocketpay.Numbers do
  def acc_file_values(filename) do
    #Operador de match, o retorno da func eh {:ok, conteudo}
    #Usando a atribuição assim ele remove o {:ok } e atribui
    #somente o conteúdo
    #{:ok, file} = File.read("#{filename}.csv")
    #|> pipe operator - passa o retorno da função anterior como primeiro parâmetro para a próxima
    #Se tiver multiplos argumentos tem que passar na mão, só passa um argumento
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end
  #defp =  função provada do elixir
  #O elixir escolhe a função que há o match no parâmetro pra executar
  defp handle_file({:ok, file}) do
    result =
      #Valor inicial do pipeline
      file
      #Split para lista de strings
      |> String.split(",")
      #Transforma a lista de strings em int
      |> Enum.map(fn number -> String.to_integer(number) end)
      #Soma a lista de ints
      |> Enum.sum()
    #não tem keyword de retorno, é o resultado da ultima linha
    {:ok, %{result: result}}
  end
  defp handle_file({:error, _error}), do: {:error, %{message: "arquivo nao encontrado!"}}
end
