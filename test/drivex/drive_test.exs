defmodule Drivex.DriveTest do
  use Drivex.DataCase

  alias Drivex.Drive

  describe "uploads" do
    alias Drivex.Drive.Upload

    import Drivex.DriveFixtures

    @invalid_attrs %{extension: nil, name: nil, path: nil}

    test "list_uploads/0 returns all uploads" do
      upload = upload_fixture()
      assert Drive.list_uploads() == [upload]
    end

    test "get_upload!/1 returns the upload with given id" do
      upload = upload_fixture()
      assert Drive.get_upload!(upload.id) == upload
    end

    test "create_upload/1 with valid data creates a upload" do
      valid_attrs = %{extension: "some extension", name: "some name", path: "some path"}

      assert {:ok, %Upload{} = upload} = Drive.create_upload(valid_attrs)
      assert upload.extension == "some extension"
      assert upload.name == "some name"
      assert upload.path == "some path"
    end

    test "create_upload/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drive.create_upload(@invalid_attrs)
    end

    test "update_upload/2 with valid data updates the upload" do
      upload = upload_fixture()
      update_attrs = %{extension: "some updated extension", name: "some updated name", path: "some updated path"}

      assert {:ok, %Upload{} = upload} = Drive.update_upload(upload, update_attrs)
      assert upload.extension == "some updated extension"
      assert upload.name == "some updated name"
      assert upload.path == "some updated path"
    end

    test "update_upload/2 with invalid data returns error changeset" do
      upload = upload_fixture()
      assert {:error, %Ecto.Changeset{}} = Drive.update_upload(upload, @invalid_attrs)
      assert upload == Drive.get_upload!(upload.id)
    end

    test "delete_upload/1 deletes the upload" do
      upload = upload_fixture()
      assert {:ok, %Upload{}} = Drive.delete_upload(upload)
      assert_raise Ecto.NoResultsError, fn -> Drive.get_upload!(upload.id) end
    end

    test "change_upload/1 returns a upload changeset" do
      upload = upload_fixture()
      assert %Ecto.Changeset{} = Drive.change_upload(upload)
    end
  end
end
