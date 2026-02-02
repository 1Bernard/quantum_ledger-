defmodule QlWebWeb.PageController do
  use QlWebWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
