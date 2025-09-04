defmodule Mix.Tasks.Start do
  use Mix.Task # Modulo padrao do elixir que utiliza a funcao run para executar a task

  # Para que a task apareca no mix help e necessario que adc essa descricao
  @shortdoc "Start [Friends List App]"
  def run(_), do: FriendsList.CLI.Main.start_app
end
