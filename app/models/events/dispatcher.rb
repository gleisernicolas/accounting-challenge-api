# frozen_string_literal: true

# Subscribes Reactors to Events.
# * `trigger` will run the Reactor synchronously
# * `async` will queue up a ReactorJob to run the Reactor
module Events
  class Dispatcher < Lib::EventDispatcher
  end
end
