defmodule FriendsList.CLI.Main do
  alias Mix.Shell.IO, as: Shell # Cria alias Shell para o modulo

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Press ENTER to continue...")
  end

  def welcome_message do
    Shell.info("=============== Friends List ===============")
    Shell.info("   Welcome to your personal friend list!")
    Shell.info("============================================")
  end
end
