import Config

config :ex_render, :api_key, "rnd_test"

config :ex_render,
  ex_render_req_options: [
    plug: {Req.Test, ExRender}
  ]

config :mix_test_watch,
  tasks: [
    "test",
    "format"
  ]
