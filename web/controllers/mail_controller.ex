defmodule GreatStrides.MailController do
	use GreatStrides.Web, :controller
  require Logger

  def create(_conn, params) do
    Logger.info params
  end
end
