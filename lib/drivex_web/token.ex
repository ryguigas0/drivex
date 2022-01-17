defmodule DrivexWeb.Token do
  alias Phoenix.Token

  alias Drivex.Accounts

  @salt "tIMiv1FYS9PI/V0ZZTTDUR5HqYWkvYX3PLhq4s1gQV0sv5GYXf6wTKRso76ybAlU"
  @age 7200

  def create_token(email, password) do
    with {:ok, user} <- Accounts.validate_email_password(email, password) do
      Token.sign(
        DrivexWeb.Endpoint,
        @salt,
        %{user_id: user.id},
        max_age: @age
      )
    else
      err -> err |> IO.inspect(label: "TOKEN ERROR")
    end
  end

  def verify_token(token) do
    case Token.verify(DrivexWeb.Endpoint, @salt, token) do
      {:ok, %{user_id: _user_id}} = resp -> resp
      {:error, _} -> {:error, :unauthorized}
    end
  end
end
