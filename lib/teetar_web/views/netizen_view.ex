defmodule TeetarWeb.NetizenView do
  use TeetarWeb, :view
  alias TeetarWeb.NetizenView

  def render("index.json", %{netizens: netizens}) do
    %{data: render_many(netizens, NetizenView, "netizen.json")}
  end

  def render("show.json", %{netizen: netizen}) do
    %{data: render_one(netizen, NetizenView, "netizen.json")}
  end

  def render("netizen.json", %{netizen: netizen}) do
    %{id: netizen.id,
      following_id: netizen.following_id}
  end

  def render("followings.json", %{netizen: netizen}) do
    %{data: render_one(netizen, NetizenView, "follow.json")}
  end

  def render("follow.json", %{netizen: netizen}) do
    %{Followed: netizen.following_id

    }
  end
end
