Dynamoid::Adapter.class_eval do
  def reconnect!
    require "dynamoid/adapter/aws_sdk"
    @adapter = Dynamoid::Adapter::AwsSdk
    @adapter.connect!
    self.tables = benchmark('Cache Tables') {list_tables}
  end
end


