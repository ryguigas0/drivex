defmodule Drivex.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drivex.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        profile_pic: "some profile_pic"
      })
      |> Drivex.Accounts.create_user()

    user
  end

  @doc """
  Generate a unique credential email.
  """
  def unique_credential_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a credential.
  """
  def credential_fixture(attrs \\ %{}) do
    {:ok, credential} =
      attrs
      |> Enum.into(%{
        email: unique_credential_email(),
        password: "some password"
      })
      |> Drivex.Accounts.create_credential()

    credential
  end
end
