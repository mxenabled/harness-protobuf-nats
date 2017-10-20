require "harness/protobuf/nats/version"

require "harness"
require "active_support"

##
# Server metrics
#
::ActiveSupport::Notifications.subscribe "server.message_received.protobuf-nats" do
  ::Harness.increment "protobuf-nats.server.message_received"
end

::ActiveSupport::Notifications.subscribe "server.message_dropped.protobuf-nats" do
  ::Harness.increment "protobuf-nats.server.message_dropped"
end

::ActiveSupport::Notifications.subscribe "server.thread_pool_execution_delay.protobuf-nats" do |_, _, _, _, delay|
  ::Harness.timing "protobuf-nats.server.thread_pool_execution_delay", delay
end

::ActiveSupport::Notifications.subscribe "server.request_duration.protobuf-nats" do |_, _, _, _, duration|
  ::Harness.timing "protobuf-nats.server.request_duration", duration
end

##
# Client metrics
#
::ActiveSupport::Notifications.subscribe "client.request_timeout.protobuf-nats" do
  ::Harness.increment "protobuf-nats.client.request_timeout"
end

::ActiveSupport::Notifications.subscribe "client.request_nack.protobuf-nats" do
  ::Harness.increment "protobuf-nats.client.request_nack"
end

::ActiveSupport::Notifications.subscribe "client.request_duration.protobuf-nats" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  ::Harness.timing "protobuf-nats.client.request_duration", event.duration
end
