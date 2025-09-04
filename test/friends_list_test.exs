defmodule FriendsListTest do
  use ExUnit.Case
  doctest FriendsList

  test "greets the world" do
    assert FriendsList.hello() == :world
  end
end
