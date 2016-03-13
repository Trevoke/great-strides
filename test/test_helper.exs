ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GreatStrides.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GreatStrides.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GreatStrides.Repo)

