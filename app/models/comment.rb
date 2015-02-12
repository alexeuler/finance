class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessor :indent
end
