# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveCal.Repo.insert!(%LiveCal.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveCal.Repo
alias LiveCal.Scheduling

[
  %Scheduling.Calendar{name: "Holidays", description: "time for an adventure", visibility: :public},
  %Scheduling.Calendar{name: "Birthdays", description: "remember to find gifts", visibility: :private},
  %Scheduling.Calendar{name: "Meetups", description: "channeling inner social butterfly", visibility: :private},
  %Scheduling.Calendar{name: "Sport Matches", description: "oggy oggy oggy, oi oi oi", visibility: :public}
] |> Enum.map(&Repo.insert!/1)

