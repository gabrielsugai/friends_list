defmodule FriendsList.CLI.MenuItens do
  alias FriendsList.CLI.Menu # Nao precisa do "as" pq o elixir entende que vc vai utilizar o ultimo modulo (Menu)

  def all do
    [
      %Menu{ label: "Register a Friend", id: :create },
      %Menu{ label: "List all Friends", id: :read },
      %Menu{ label: "Update a Friend", id: :update },
      %Menu{ label: "Delete a Friend", id: :delete },
    ]
  end
end
