# defmodule ManagementServerWeb.LocationControllerTest do
#   use ManagementServerWeb.ConnCase

#   import ManagementServer.LocationsFixtures

#   alias ManagementServer.Locations.Location

#   @create_attrs %{
#     address: "some address",
#     location: %{},
#     name: "some name"
#   }
#   @update_attrs %{
#     address: "some updated address",
#     location: %{},
#     name: "some updated name"
#   }
#   @invalid_attrs %{address: nil, location: nil, name: nil}

#   setup %{conn: conn} do
#     {:ok, conn: put_req_header(conn, "accept", "application/json")}
#   end

#   describe "index" do
#     test "lists all locations", %{conn: conn} do
#       conn = get(conn, Routes.location_path(conn, :index))
#       assert json_response(conn, 200)["data"] == []
#     end
#   end

#   describe "create location" do
#     test "renders location when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.location_path(conn, :create), location: @create_attrs)
#       assert %{"id" => id} = json_response(conn, 201)["data"]

#       conn = get(conn, Routes.location_path(conn, :show, id))

#       assert %{
#                "id" => ^id,
#                "address" => "some address",
#                "location" => %{},
#                "name" => "some name"
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.location_path(conn, :create), location: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "update location" do
#     setup [:create_location]

#     test "renders location when data is valid", %{conn: conn, location: %Location{id: id} = location} do
#       conn = put(conn, Routes.location_path(conn, :update, location), location: @update_attrs)
#       assert %{"id" => ^id} = json_response(conn, 200)["data"]

#       conn = get(conn, Routes.location_path(conn, :show, id))

#       assert %{
#                "id" => ^id,
#                "address" => "some updated address",
#                "location" => %{},
#                "name" => "some updated name"
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn, location: location} do
#       conn = put(conn, Routes.location_path(conn, :update, location), location: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "delete location" do
#     setup [:create_location]

#     test "deletes chosen location", %{conn: conn, location: location} do
#       conn = delete(conn, Routes.location_path(conn, :delete, location))
#       assert response(conn, 204)

#       assert_error_sent 404, fn ->
#         get(conn, Routes.location_path(conn, :show, location))
#       end
#     end
#   end

#   defp create_location(_) do
#     location = location_fixture()
#     %{location: location}
#   end
# end
