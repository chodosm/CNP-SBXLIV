require 'md5'
require 'digest/sha1'
class Agent < ActiveRecord::Base
  set_table_name 'AGENTS'
  set_primary_key 'agent_id'
  
  @@type_id   ||= CnpLookupCode.lookup('AGENTS', 'agent_type_id', 'CNP_AGENT')
  @@status_id ||= CnpLookupCode.lookup('AGENTS', 'agent_status_id', 'AGENT_ACTIVE')
  
  def self.find_by_id(id)
    self.find_by_agent_id(id)
  end
  
  def self.authenticate(login, password)
    conditions = []
    conditions << Agent.send(:sanitize_sql, ["agent_type_id = ?", @@type_id])
    conditions << Agent.send(:sanitize_sql, ["agent_status_id = ?", @@status_id])
    conditions << Agent.send(:sanitize_sql, ["login_id = ?", login])
    conditions = conditions.collect{|c| "(#{c})" }.join(' AND ')

    agent = Agent.find(:first, :conditions => conditions)
    agent && agent.authenticated?(password) ? agent : nil
  end

  def authenticated?(password)
    self.password == MD5.new(password).to_s
  end

end