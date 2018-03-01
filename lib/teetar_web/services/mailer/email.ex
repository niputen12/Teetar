defmodule TeetarWeb.Services.Mailer.Email do
  use Bamboo.Phoenix, view: TeetarWeb.MailerView

  def welcome_text_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("niputen13@gmail.com")
    |> subject("Welcome!")
    |> text_body("Welcome to MyApp!")
  end

end