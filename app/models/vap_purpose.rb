require 'ajax_scaffold'

class VapPurpose < ActiveRecord::Base

  validates_presence_of :name

  @@scaffold_columns = [
    AjaxScaffold::ScaffoldColumn.new(self, { :name => 'id' }),
    AjaxScaffold::ScaffoldColumn.new(self, { :name => 'name' }),
    AjaxScaffold::ScaffoldColumn.new(self, { :name => 'active' })
  ].freeze

  @scaffold_columns = @@scaffold_columns

end