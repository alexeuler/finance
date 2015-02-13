class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessor :indent, :parent, :children
  after_initialize :defaults

  def defaults
    @children=[]
  end

  def self.delete_tree(comments)
    comments=[comments] unless comments.is_a? Array
    comments.each do |comment|
      new_comments=self.where(parent_id:comment.id).to_a
      comment.delete
      self.delete_tree(new_comments)
    end
  end

  def self.flatten(comments)
    comment_hash = {}
    root=nil
    comments.each do |comment|
      comment_hash[comment.id] = comment
    end
    comment_hash.each_pair do |id, comment|
      parent_id=comment.parent_id
      if parent_id then
        comment.parent=comment_hash[parent_id]
        comment.parent.children.push comment
      else
        root=comment
      end
    end
    traverse(root, [], 0)
  end

  private

  def self.traverse(node, list, indent)
    node.indent = indent
    list.push node
    children = node.children
    if children
      children.sort_by &:created_at
      children.each do |child|
        traverse(child, list, indent + 1)
      end
    end
    list
  end

end
