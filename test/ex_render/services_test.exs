defmodule ExRender.ServicesTest do
  use ExUnit.Case
  doctest ExRender.Services

  alias ExRender.Services

  @mock %{
    "autoDeploy" => "no",
    "branch" => "main",
    "createdAt" => "2024-03-28T09:22:43.450664Z",
    "id" => "srv-some-id",
    "name" => "customer-vault-us-east",
    "notifyOnFail" => "default",
    "ownerId" => "tea-owner-id",
    "repo" => "https://github.com/some/repos",
    "rootDir" => "",
    "serviceDetails" => %{
      "autoscaling" => %{
        "criteria" => %{
          "cpu" => %{"enabled" => true, "percentage" => 70},
          "memory" => %{"enabled" => true, "percentage" => 70}
        },
        "enabled" => true,
        "max" => 10,
        "min" => 1
      },
      "buildPlan" => "starter",
      "env" => "elixir",
      "envSpecificDetails" => %{
        "buildCommand" => "./build.sh",
        "startCommand" => "_build/prod/rel/vault/bin/vault start"
      },
      "numInstances" => 1,
      "openPorts" => [
        %{"port" => 4_369, "protocol" => "TCP"},
        %{"port" => 10_000, "protocol" => "TCP"},
        %{"port" => 33_769, "protocol" => "TCP"}
      ],
      "plan" => "starter",
      "pullRequestPreviewsEnabled" => "no",
      "region" => "ohio",
      "url" => "customer-vault-us-east:10000"
    },
    "slug" => "customer-vault-us-east",
    "suspended" => "not_suspended",
    "suspenders" => [],
    "type" => "private_service",
    "updatedAt" => "2024-03-31T19:04:02.274724Z"
  }

  test "list of Services" do
    Req.Test.stub(ExRender, fn conn ->
      Req.Test.json(conn, [
        %{
          "cursor" => "vsxehalH0Mtkb29sNmNhYzczYmsdqsdw",
          "service" => @mock
        }
      ])
    end)

    assert Services.list() == [
             %{
               service: %ExRender.Service{
                 auto_deploy: "no",
                 branch: "main",
                 created_at: "2024-03-28T09:22:43.450664Z",
                 id: "srv-some-id",
                 name: "customer-vault-us-east",
                 notify_on_fail: "default",
                 owner_id: "tea-owner-id",
                 repo: "https://github.com/some/repos",
                 root_dir: "",
                 service_details: %ExRender.ServiceDetails{
                   autoscaling: %{
                     "criteria" => %{
                       "cpu" => %{"enabled" => true, "percentage" => 70},
                       "memory" => %{"enabled" => true, "percentage" => 70}
                     },
                     "enabled" => true,
                     "max" => 10,
                     "min" => 1
                   },
                   build_plan: "starter",
                   env: "elixir",
                   env_specific_details: %{
                     "buildCommand" => "./build.sh",
                     "startCommand" => "_build/prod/rel/vault/bin/vault start"
                   },
                   num_instances: 1,
                   open_ports: [
                     %{"port" => 4_369, "protocol" => "TCP"},
                     %{"port" => 10_000, "protocol" => "TCP"},
                     %{"port" => 33_769, "protocol" => "TCP"}
                   ],
                   plan: "starter",
                   pull_request_previews_enabled: "no",
                   region: "ohio",
                   url: "customer-vault-us-east:10000"
                 },
                 slug: "customer-vault-us-east",
                 suspended: "not_suspended",
                 suspenders: [],
                 type: "private_service",
                 updated_at: "2024-03-31T19:04:02.274724Z"
               },
               cursor: "vsxehalH0Mtkb29sNmNhYzczYmsdqsdw"
             }
           ]
  end

  test "retrieve Service" do
    Req.Test.stub(ExRender, fn conn ->
      Req.Test.json(conn, @mock)
    end)

    assert Services.retrieve("srv-some-id") == %ExRender.Service{
             auto_deploy: "no",
             branch: "main",
             created_at: "2024-03-28T09:22:43.450664Z",
             id: "srv-some-id",
             name: "customer-vault-us-east",
             notify_on_fail: "default",
             owner_id: "tea-owner-id",
             repo: "https://github.com/some/repos",
             root_dir: "",
             service_details: %ExRender.ServiceDetails{
               autoscaling: %{
                 "criteria" => %{
                   "cpu" => %{"enabled" => true, "percentage" => 70},
                   "memory" => %{"enabled" => true, "percentage" => 70}
                 },
                 "enabled" => true,
                 "max" => 10,
                 "min" => 1
               },
               build_plan: "starter",
               env: "elixir",
               env_specific_details: %{
                 "buildCommand" => "./build.sh",
                 "startCommand" => "_build/prod/rel/vault/bin/vault start"
               },
               num_instances: 1,
               open_ports: [
                 %{"port" => 4_369, "protocol" => "TCP"},
                 %{"port" => 10_000, "protocol" => "TCP"},
                 %{"port" => 33_769, "protocol" => "TCP"}
               ],
               plan: "starter",
               pull_request_previews_enabled: "no",
               region: "ohio",
               url: "customer-vault-us-east:10000"
             },
             slug: "customer-vault-us-east",
             suspended: "not_suspended",
             suspenders: [],
             type: "private_service",
             updated_at: "2024-03-31T19:04:02.274724Z"
           }
  end
end
