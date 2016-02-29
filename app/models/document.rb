class Document < ActiveRecord::Base
  has_attached_file :file,
          content_type: { content_type: %w(application/pdf application/msword)}
  validates_attachment_content_type :file, content_type: ["application/pdf application/msword"]
  enum category: { policy: 0,  record: 1, form: 2 }
end
