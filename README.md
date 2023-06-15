# LiveCal

This [commit](https://github.com/codeanpeace/live_cal/commit/e56742cfd0cfea7896829494924c078f94d5c860) demonstrates how to conditionally show and hide a nested input within [`Phoenix.Component.inputs_for/1`](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#inputs_for/1) based on the value of a sibling nested input.

To see it in action:

  * Navigate to [`http://localhost:4000/calendars/new`](http://localhost:4000/calendars/new)
  * Click `add event`
  * Select `field trip` from the type dropdown

There should now be a `destination` text input field underneath the dropdown.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
