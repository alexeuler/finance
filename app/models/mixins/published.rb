module Mixins::Published
  def self.extended(base)
    base.class_eval do
      scope :published, -> { where(status: 'published') }
    end
  end
end