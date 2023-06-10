# defmodule ManagementServerWeb.WorkerControllerTest do
#   use ManagementServerWeb.ConnCase

#   import ManagementServer.WorkersFixtures

#   alias ManagementServer.Workers.Worker

#   @create_attrs %{
#     age: 42,
#     description: "some description",
#     email: "some email",
#     name: "some name",
#     position: "some position",
#     responsibility: "some responsibility"
#   }
#   @update_attrs %{
#     age: 43,
#     description: "some updated description",
#     email: "some updated email",
#     name: "some updated name",
#     position: "some updated position",
#     responsibility: "some updated responsibility"
#   }
#   @invalid_attrs %{age: nil, description: nil, email: nil, name: nil, position: nil, responsibility: nil}

#   setup %{conn: conn} do
#     {:ok, conn: put_req_header(conn, "accept", "application/json")}
#   end

#   describe "index" do
#     test "lists all workers", %{conn: conn} do
#       conn = get(conn, Routes.worker_path(conn, :index))
#       assert json_response(conn, 200)["data"] == []
#     end
#   end

#   describe "create worker" do
#     test "renders worker when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.worker_path(conn, :create), worker: @create_attrs)
#       assert %{"id" => id} = json_response(conn, 201)["data"]

#       conn = get(conn, Routes.worker_path(conn, :show, id))

#       assert %{
#                "id" => ^id,
#                "age" => 42,
#                "description" => "some description",
#                "email" => "some email",
#                "name" => "some name",
#                "position" => "some position",
#                "responsibility" => "some responsibility"
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.worker_path(conn, :create), worker: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "update worker" do
#     setup [:create_worker]

#     test "renders worker when data is valid", %{conn: conn, worker: %Worker{id: id} = worker} do
#       conn = put(conn, Routes.worker_path(conn, :update, worker), worker: @update_attrs)
#       assert %{"id" => ^id} = json_response(conn, 200)["data"]

#       conn = get(conn, Routes.worker_path(conn, :show, id))

#       assert %{
#                "id" => ^id,
#                "age" => 43,
#                "description" => "some updated description",
#                "email" => "some updated email",
#                "name" => "some updated name",
#                "position" => "some updated position",
#                "responsibility" => "some updated responsibility"
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn, worker: worker} do
#       conn = put(conn, Routes.worker_path(conn, :update, worker), worker: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "delete worker" do
#     setup [:create_worker]

#     test "deletes chosen worker", %{conn: conn, worker: worker} do
#       conn = delete(conn, Routes.worker_path(conn, :delete, worker))
#       assert response(conn, 204)

#       assert_error_sent 404, fn ->
#         get(conn, Routes.worker_path(conn, :show, worker))
#       end
#     end
#   end

#   defp create_worker(_) do
#     worker = worker_fixture()
#     %{worker: worker}
#   end
# end
