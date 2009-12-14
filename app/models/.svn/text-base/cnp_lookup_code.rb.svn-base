class CnpLookupCode < ActiveRecord::Base
  set_table_name 'CNP_LOOKUP_CODES'
  set_primary_key 'lookup_id'

  def self.lookup(table, column, value)
    v = find(:first, :select => primary_key,
             :conditions => { :table_name => table,
                              :column_name => column.to_s,
                              :value => value.to_s })
    v ? v.id : nil
  end

  def self.codes(table, column)
    v = find(:all, :select => primary_key,
             :conditions => { :table_name => table,
                              :column_name => column.to_s })
    v.collect { |c| c.id }
  end

  def self.to_fixture(out = STDOUT)
    out.puts '---'
    find(:all, :order => :lookup_id).each { |c|
      out.puts "code_#{c.id}:"
      out.puts "  lookup_id: #{c.id}"
      %w(table_name column_name value).each { |v|
        out.puts "  #{v}: #{c.send(v)}"
      }
    }
  end
end
