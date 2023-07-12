# LiveCal

---------------------------------------

![demo gif](https://github.com/codeanpeace/live_cal/blob/master/demo.gif)

The following commit demonstrates how to conditionally show and hide a nested input within [`Phoenix.Component.inputs_for/1`](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#inputs_for/1) based on the value of a sibling nested input.

- [Nested inputs_for events in calendar form livecomponent with conditional rendering of one input based on another](https://github.com/codeanpeace/live_cal/commit/e56742cfd0cfea7896829494924c078f94d5c860)

To see it in action:

  * Navigate to [`http://localhost:4000/calendars/new`](http://localhost:4000/calendars/new)
  * Click `add event`
  * Select `field trip` from the type dropdown

There should now be a `destination` text input field underneath the dropdown.

For reference, this was created in response to this
[thread](https://elixirforum.com/t/understanding-phoenix-html-form-changesets-and-data-lifecycle/56483/7?u=codeanpeace) on ElixirForum.

---------------------------------------

The following two commits demonstrate how to handle multiple radio button
inputs grouped together under a fieldset that represent the possible values of
an `Ecto.Enum` field in a Phoenix LiveView form. 

1. [Add fieldset radio button example for Ecto.Enum field](https://github.com/codeanpeace/live_cal/commit/736b4e307391b68cd600446f30a112f9afeacab8)
2. [Add radio_fieldset function component that autogenerates radio buttons](https://github.com/codeanpeace/live_cal/commit/11d246d11454a7a8e943685444e0b3d4cb9d3649)

To see it in action:

  * Navigate to [`http://localhost:4000/calendars/new`](http://localhost:4000/calendars/new)
  * Click between the `public` and `private` radio buttons
  * Click `add event`
  * Click between the `busy`, `free`, and `tbd` radio buttons

For reference, this was created in response to this [thread](https://elixirforum.com/t/radio-buttons-using-the-corecomponents-module-in-phoenix-1-7/56856/5?u=codeanpeace) on ElixirForum.

---------------------------------------

The following commit demonstrates how to show/hide streamed elements by tagging them via HTML attributes and using LiveView's client side JS commands to toggle their visibility.

- [Show or hide streamed calendars on the client side based on their visibility field](https://github.com/codeanpeace/live_cal/commit/5ec335d552ac36787934972ea23619a72513deef)

To see it in action:

  * Navigate to [`http://localhost:4000/calendars`](http://localhost:4000/calendars)
  * Click the `public` and `private` toggle buttons once to hide the public and private calendars respectively
  * Click either again to show the public and private calendars respectively
  * So on and so forth

For reference, this was created in response to this [thread](https://elixirforum.com/t/conditional-display-of-an-html-element-part-of-a-stream/56960/4?u=codeanpeace) on ElixirForum.

---------------------------------------

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
