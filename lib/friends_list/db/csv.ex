defmodule FriendsList.DB.CSV do
  alias Mix.Shell.IO, as: Shell
  alias FriendsList.CLI.Menu
  alias NimbleCSV.RFC4180, as: CSVParser

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{ id: :create, label: _ } -> create()
      %Menu{ id: :read, label: _ }   -> Shell.info("Read selected")
      %Menu{ id: :update, label: _ } -> Shell.info("Update selected")
      %Menu{ id: :delete, label: _ } -> Shell.info("Delete selected")
    end

    Menu.Choice.start()
  end

  defp create do
    collect_data()
    |> Map.values
    |> wrap_in_list
    |> CSVParser.dump_to_iodata
    |> save_csv_file
  end

  defp collect_data do
    Shell.cmd("clear")

    %{
      name: prompt_message("Enter name: "),
      email: prompt_message("Enter email: "),
      phone: prompt_message("Enter phone: ")
    }
  end

  defp prompt_message(message), do: String.trim(Shell.prompt(message))

  defp wrap_in_list(data), do: [data]

  defp save_csv_file(data) do
    File.write!("#{File.cwd!}/friends.csv", data, [:append])
  end
end
