defmodule ManagementServer.Forms do
  @moduledoc """
  The Forms context.
  """

  import Ecto.Query, warn: false
  alias ManagementServer.Repo

  alias ManagementServer.Forms.Form

  @doc """
  Returns the list of forms.

  ## Examples

      iex> list_forms()
      [%Form{}, ...]

  """
  def list_forms(organization_id, params) do
    form_type_id = params["form_type_id"]

    Form
    |> where([f], f.organization_id == ^organization_id)
    |> where([f], f.form_type_id == ^form_type_id)
    |> Repo.all()
  end

  @doc """
  Gets a single form.

  Raises `Ecto.NoResultsError` if the Form does not exist.

  ## Examples

      iex> get_form!(123)
      %Form{}

      iex> get_form!(456)
      ** (Ecto.NoResultsError)

  """
  def get_form!(id), do: Repo.get!(Form, id)

  @doc """
  Creates a form.

  ## Examples

      iex> create_form(%{field: value})
      {:ok, %Form{}}

      iex> create_form(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a form.

  ## Examples

      iex> update_form(form, %{field: new_value})
      {:ok, %Form{}}

      iex> update_form(form, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_form(%Form{} = form, attrs) do
    form
    |> Form.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a form.

  ## Examples

      iex> delete_form(form)
      {:ok, %Form{}}

      iex> delete_form(form)
      {:error, %Ecto.Changeset{}}

  """
  def delete_form(%Form{} = form) do
    Repo.delete(form)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking form changes.

  ## Examples

      iex> change_form(form)
      %Ecto.Changeset{data: %Form{}}

  """
  def change_form(%Form{} = form, attrs \\ %{}) do
    Form.changeset(form, attrs)
  end
end
