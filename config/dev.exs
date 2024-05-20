import Config

if Mix.env() == :dev do
  config :mix_test_watch,
    tasks: [
      "test",
      "credo",
      "format"
    ]
end

import_config "dev.secret.exs"
