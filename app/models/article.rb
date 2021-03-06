class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings 

    belongs_to :author
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
    
    def tag_list
        tags.join(", ")
    end

    def tag_list=(tags_string)
        tag_names = tags_string.split(",").map{|s| s.strip.downcase()}.uniq()
        tags = tag_names.map{ |name| Tag.find_or_create_by(name: name) }
        self.tags = tags
    end
end
