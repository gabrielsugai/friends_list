defmodule Mix.Tasks.Utils.AddFakeFriends do
  use Mix.Task # Modulo padrao do elixir que utiliza a funcao run para executar a task
  alias NimbleCSV.RFC4180, as: CSVParser

  @shortdoc "Add Fake Friends to Friends List App"
  def run(_) do
    Faker.start()

    create_friends([], 5)
    |> CSVParser.dump_to_iodata
    |> save_csv_file

    IO.puts("Amigos cadastrados com sucesso!")
  end

  defp create_friends(list, count) when count <= 1 do
    list ++ [random_list_friend()]
  end

  defp create_friends(list, count) do
    list ++ [random_list_friend()] ++ create_friends(list, count - 1)
  end

  defp random_list_friend do
    %{
      name: Faker.Person.PtBr.name(),
      email: Faker.Internet.email(),
      phone: Faker.Phone.PtBr.phone()
    }
    |> Map.values()
  end

  defp save_csv_file(data) do
    File.write!("#{File.cwd!}/friends.csv", data, [:append])
  end
end
