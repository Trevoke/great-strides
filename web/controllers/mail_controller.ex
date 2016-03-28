defmodule GreatStrides.MailController do
	use GreatStrides.Web, :controller
  require Logger
  require IEx

  def create(conn, params) do
    IEx.pry
    Logger.info params[:message]
    Logger.info "----------"
    Logger.info params[:body_params]
    render conn, :ok
  end
end
