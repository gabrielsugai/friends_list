defmodule FriendsList.CLI.MenuChoice do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("Choose an option:")

    menu_itens = FriendsList.CLI.MenuItens.all()
    find_menu_item_by_index = &Enum.at(menu_itens, &1) # Declaracao de funcao anonima que escolhe um item da lista

    menu_itens
    |> Enum.map(&(&1.label)) # Pipe operator + funcao anonima reduzida
    |> display_options()
    |> generate_question()
    |> Shell.prompt
    |> parse_answer()
    |> find_menu_item_by_index.()
    |> confirm_menu_item()
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
    {option, _} = Integer.parse(answer) # Utiliza o pattern match para atribuir a opcao ao option (a funcao parse retorna o resultado e um texto)
    option - 1
  end

  defp confirm_menu_item(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("You chose: #{chosen_menu_item.label}\n")

    if Shell.yes?("Is that correct? [y/n]") do
      Shell.info("... #{chosen_menu_item.label} ...\n")
    else
      start()
    end
  end
end
