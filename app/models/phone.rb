
class Phone < ActiveRecord::Base
  belongs_to :network  
  has_many :messages
  
  before_destroy :cleanup
  
  def cleanup
    self.messages{|msg| msg.destroy}
  end
  
end
