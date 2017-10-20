require "spec_helper"

describe ::Harness::Protobuf::Nats do
  let(:collector) { ::Harness::NullCollector.new }

  before do
    ::Harness.config.queue = ::Harness::SyncQueue.new
    ::Harness.config.collector = collector
  end

  it "has a version number" do
    expect(Harness::Protobuf::Nats::VERSION).not_to be nil
  end

  describe "server metrics" do
    it "can instrument server.message_received.protobuf-nats" do
      expect(collector).to receive(:increment).with("protobuf-nats.server.message_received")
      ::ActiveSupport::Notifications.instrument "server.message_received.protobuf-nats"
    end

    it "can instrument server.message_received.protobuf-nats" do
      expect(collector).to receive(:increment).with("protobuf-nats.server.message_dropped")
      ::ActiveSupport::Notifications.instrument "server.message_dropped.protobuf-nats"
    end

    it "can instrument server.request_duration.protobuf-nats" do
      expect(collector).to receive(:timing).with("protobuf-nats.server.request_duration", 0.254)
      ::ActiveSupport::Notifications.instrument "server.request_duration.protobuf-nats", 0.254
    end

    it "can instrument server.thread_pool_execution_delay.protobuf-nats" do
      expect(collector).to receive(:timing).with("protobuf-nats.server.thread_pool_execution_delay", 0.123)
      ::ActiveSupport::Notifications.instrument "server.thread_pool_execution_delay.protobuf-nats", 0.123
    end

    it "can instrument server.request_duration.protobuf-nats" do
      expect(collector).to receive(:timing).with("protobuf-nats.server.request_duration", 0.254)
      ::ActiveSupport::Notifications.instrument "server.request_duration.protobuf-nats", 0.254
    end
  end

  describe "client metrics" do
    it "can instrument client.request_timeout.protobuf-nats" do
      expect(collector).to receive(:increment).with("protobuf-nats.client.request_timeout")
      ::ActiveSupport::Notifications.instrument "client.request_timeout.protobuf-nats"
    end

    it "can instrument client.request_nack.protobuf-nats" do
      expect(collector).to receive(:increment).with("protobuf-nats.client.request_nack")
      ::ActiveSupport::Notifications.instrument "client.request_nack.protobuf-nats"
    end

    it "can instrument client.request_duration.protobuf-nats" do
      stat = ""
      duration = 0
      expect(collector).to receive(:timing) do |the_stat, the_duration|
        stat = the_stat
        duration = the_duration
      end

      ::ActiveSupport::Notifications.instrument "client.request_duration.protobuf-nats" do
        sleep 0.1
      end
      expect(stat).to eq("protobuf-nats.client.request_duration")
      expect(duration).to be >= 0.1
    end
  end
end
