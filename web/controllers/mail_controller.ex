defmodule GreatStrides.MailController do
	use GreatStrides.Web, :controller
  require Logger

  def create(conn, %{"message" => message}) do
    Logger.info message
  end
end
