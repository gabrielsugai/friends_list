defmodule FriendsList.CLI.Menu.Choice do
  alias Mix.Shell.IO, as: Shell
  alias FriendsList.CLI.Menu.Itens

  def start do
    Shell.cmd("clear")
    Shell.info("Choose an option:")

    menu_itens = Itens.all()
    find_menu_item_by_index = &Enum.at(menu_itens, &1, :error) # Declaracao de funcao anonima que escolhe um item da lista / o terceiro parametro eh o valor default caso o index nao exista na lista

    menu_itens
    |> Enum.map(&(&1.label)) # Pipe operator + funcao anonima reduzida
    |> display_options()
    |> generate_question()
    |> Shell.prompt
    |> parse_answer()
    |> find_menu_item_by_index.()
    |> confirm_menu_item()
    |> confirm_menu_item_flow()
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}") # Funcao anonima convencional
    end)

    options # Retorna o options para que o retorno da funcao seja utilizado com o pipe operator para a proxima funcao
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ", ")
    "Choose one of the above options: [#{options}]\n"
  end

  defp parse_answer(answer) do
    case Integer.parse(answer) do
      :error -> invalid_input()
      {option, _} -> option - 1 # O case utiliza pattern matching para verificar se o retorno de Integer.parse eh :error ou uma tupla {option, _} e retorna o valor de option
    end
  end
  
  defp invalid_input do
    Shell.cmd("clear")
    Shell.error("Invalid input!")
    Shell.prompt("Press enter to try again.")
    start()
  end

  defp confirm_menu_item(chosen_menu_item) do
    case chosen_menu_item do
      :error -> invalid_input()
      _ -> chosen_menu_item
    end
  end

  defp confirm_menu_item_flow(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("You chose: #{chosen_menu_item.label}\n")

    if Shell.yes?("Is that correct? [y/n]") do
      Shell.info("... #{chosen_menu_item.label} ...\n")
    else
      start()
    end
  end
end
