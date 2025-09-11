defmodule FriendsList.DB.CSV do
  alias Mix.Shell.IO, as: Shell
  alias FriendsList.CLI.Menu

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{ id: :create, label: _ } -> Shell.info("Create selected")
      %Menu{ id: :read, label: _ }   -> Shell.info("Read selected")
      %Menu{ id: :update, label: _ } -> Shell.info("Update selected")
      %Menu{ id: :delete, label: _ } -> Shell.info("Delete selected")
    end
  end
end
