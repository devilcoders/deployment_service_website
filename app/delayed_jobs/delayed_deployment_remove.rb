class DelayedDeploymentRemove < Struct.new(:fqdn, :digest)
  include HTTParty
  base_uri "http://puppet.spreecommerce.com:5000"

  def perform
    begin
      result = self.class.get('/remove', :query => {:digest => digest, :fqdn => fqdn}, :timeout => 300)
    rescue Exception => e
      deploy.update_attributes(:config_state => 'error')
      raise e
    end
  end
end

