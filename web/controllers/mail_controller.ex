defmodule GreatStrides.MailController do
	use GreatStrides.Web, :controller
  require Logger

  def create(conn, params) do
    Logger.info params[:message]
    Logger.info "----------"
    Logger.info params[:body_params]
    render conn, :ok
  end
end
