class Post < ActiveRecord::Base
  belongs_to :parent, class_name: "Post", foreign_key: "parent_id"
  has_many :children, class_name: "Post", foreign_key: "parent_id"
  validates_presence_of :comment
  attr_accessible :comment, :parent_id
end
