defmodule FriendsList.CLI.MenuChoice do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("Choose an option:")

    FriendsList.CLI.MenuItens.all()
    |> Enum.map(&(&1.label)) # Pipe operator + funcao anonima reduzida
    |> display_options
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}") # Funcao anonima convencional
    end)
  end
end
