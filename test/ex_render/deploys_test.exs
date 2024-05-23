defmodule ExRender.DeploysTest do
  use ExUnit.Case
  alias ExRender.Deploys

  @moduletag :deploys

  @mock %{
    "commit" => %{
      "createdAt" => "2024-05-20T08:16:22Z",
      "id" => "some-commit-id",
      "message" => "Rest API challenge controller draft"
    },
    "createdAt" => "2024-05-20T11:00:23.620137Z",
    "finishedAt" => "2024-05-20T11:04:50.667727Z",
    "id" => "dep-some-deploy-id",
    "status" => "live",
    "trigger" => "service_resumed",
    "updatedAt" => "2024-05-20T11:05:24.845489Z"
  }

  describe "Deploys.list/2" do
    @describetag :list_deploys

    test "should returns an empty list if it is not a 200 response" do
      response(400)

      assert Deploys.list("srv-some-service-id") == []
    end

    test "should return a list of Deploy from a Service" do
      Req.Test.stub(ExRender, fn conn ->
        Req.Test.json(conn, [
          %{
            "cursor" => "vsxehalH0Mtkb29sNmNhYzczYmsdqsdw",
            "deploy" => @mock
          }
        ])
      end)

      assert Deploys.list("srv-some-service-id") == [
               %{
                 cursor: "vsxehalH0Mtkb29sNmNhYzczYmsdqsdw",
                 deploy: %ExRender.Deploy{
                   commit: %ExRender.Commit{
                     created_at: "2024-05-20T08:16:22Z",
                     id: "some-commit-id",
                     message: "Rest API challenge controller draft"
                   },
                   created_at: "2024-05-20T11:00:23.620137Z",
                   finished_at: "2024-05-20T11:04:50.667727Z",
                   id: "dep-some-deploy-id",
                   status: "live",
                   trigger: "service_resumed",
                   updated_at: "2024-05-20T11:05:24.845489Z"
                 }
               }
             ]
    end
  end

  describe "Deploys.trigger/1" do
    @describetag :trigger_service

    test "should returns nil if it is not a 200 response" do
      response(404)

      refute Deploys.trigger("srv-some-service-id")
    end

    test "should return a Service" do
      Req.Test.stub(ExRender, fn conn ->
        conn
        |> Req.Test.json(@mock)
        |> Map.put(:status, 201)
      end)

      assert Deploys.trigger("srv-some-service-id") == %ExRender.Deploy{
               commit: %ExRender.Commit{
                 created_at: "2024-05-20T08:16:22Z",
                 id: "some-commit-id",
                 message: "Rest API challenge controller draft"
               },
               created_at: "2024-05-20T11:00:23.620137Z",
               finished_at: "2024-05-20T11:04:50.667727Z",
               id: "dep-some-deploy-id",
               status: "live",
               trigger: "service_resumed",
               updated_at: "2024-05-20T11:05:24.845489Z"
             }
    end
  end

  describe "Deploys.retrieve/1" do
    @describetag :retrieve_service

    test "should returns nil if it is not a 200 response" do
      response(404)

      refute Deploys.retrieve("srv-some-service-id", "dp-some-deploy-id")
    end

    test "should return a Service" do
      Req.Test.stub(ExRender, fn conn ->
        Req.Test.json(conn, @mock)
      end)

      assert Deploys.retrieve("srv-some-service-id", "dp-some-deploy-id") == %ExRender.Deploy{
               commit: %ExRender.Commit{
                 created_at: "2024-05-20T08:16:22Z",
                 id: "some-commit-id",
                 message: "Rest API challenge controller draft"
               },
               created_at: "2024-05-20T11:00:23.620137Z",
               finished_at: "2024-05-20T11:04:50.667727Z",
               id: "dep-some-deploy-id",
               status: "live",
               trigger: "service_resumed",
               updated_at: "2024-05-20T11:05:24.845489Z"
             }
    end
  end

  describe "Deploys.cancel/1" do
    @describetag :cancel_service

    test "should returns nil if it is not a 200 response" do
      response(404)

      refute Deploys.cancel("srv-some-service-id", "dp-some-deploy-id")
    end

    test "should return a Service" do
      Req.Test.stub(ExRender, fn conn ->
        Req.Test.json(conn, @mock)
      end)

      assert Deploys.cancel("srv-some-service-id", "dp-some-deploy-id") == %ExRender.Deploy{
               commit: %ExRender.Commit{
                 created_at: "2024-05-20T08:16:22Z",
                 id: "some-commit-id",
                 message: "Rest API challenge controller draft"
               },
               created_at: "2024-05-20T11:00:23.620137Z",
               finished_at: "2024-05-20T11:04:50.667727Z",
               id: "dep-some-deploy-id",
               status: "live",
               trigger: "service_resumed",
               updated_at: "2024-05-20T11:05:24.845489Z"
             }
    end
  end

  describe "Deploys.rollback/1" do
    @describetag :rollback_service

    test "should returns nil if it is not a 200 response" do
      response(404)

      refute Deploys.rollback("srv-some-service-id")
    end

    test "should return a Service" do
      Req.Test.stub(ExRender, fn conn ->
        conn
        |> Req.Test.json(@mock)
        |> Map.put(:status, 201)
      end)

      assert Deploys.rollback("srv-some-service-id") == %ExRender.Deploy{
               commit: %ExRender.Commit{
                 created_at: "2024-05-20T08:16:22Z",
                 id: "some-commit-id",
                 message: "Rest API challenge controller draft"
               },
               created_at: "2024-05-20T11:00:23.620137Z",
               finished_at: "2024-05-20T11:04:50.667727Z",
               id: "dep-some-deploy-id",
               status: "live",
               trigger: "service_resumed",
               updated_at: "2024-05-20T11:05:24.845489Z"
             }
    end
  end

  defp response(status_code) do
    Req.Test.stub(ExRender, fn conn ->
      conn
      |> Req.Test.json("")
      |> Map.put(:status, status_code)
    end)
  end
end
