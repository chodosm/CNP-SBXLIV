require 'ajax_scaffold'

class VapDirmap < ActiveRecord::Base
  belongs_to :vap_access

  validates_presence_of :directions
  validates_associated :vap_access

  @@scaffold_columns = [
    AjaxScaffold::ScaffoldColumn.new(self, { :name => 'id' }),
    AjaxScaffold::ScaffoldColumn.new(self, { :name => 'directions_first',
      :label => 'Directions',
      :sort_sql => "#{table_name}.directions" }),
    AjaxScaffold::ScaffoldColumn.new(self, { :name => 'active' }),
  ].freeze
  @scaffold_columns = @@scaffold_columns

  def before_save
    self.mime_type.downcase!
    self.vap_access_id = 1
    true
  end

  def access
    return vap_access.name
  end

  def directions_first
    directions.split(/[\r\n]/).first
  end

  def VapDirmap.txt_select
    'id,event_id,vap_access_id,directions,active,mime_type'
  end
  
  def VapDirmap.find_txt(id)
    VapDirmap.find(id, :select => txt_select)
  end

  def suffix
    mime_type == 'image/jpeg' ? 'jpg' : mime_type.split('/')[1]
  end
  
  def filename
    "map-#{id}.#{suffix}"
  end

  # returns the content-id for mail attachments
  # due to a bug in tmail, this needs to
  # look like a hostname, hence example.com
  def cid(vap_request)
    "#{filename}@#{vap_request.id}.#{id}.example.com"
  end
  
end