class Contact < ActiveRecord::Base
    belongs_to :user

	has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200"}
	validates_attachment :image, presence:true,
	content_type:{content_type:["image/jpg", "image/png"]},
	size:{in: 0..500.kilobytes }	
	validates :name, presence: true
	#validates :email,presence: true,
	#format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
	validates :zipcode, presence: true,
	numericality: true,
	format: { with: /\A\d{1,9}(\. \d{0,2})?\z/ } 

	scope :sort_alphabetically, ->(direction){order "name #{direction}"}	
	scope :search_by_name, -> (search_value){where "name like ?", "#{search_value}%"}

	def self.import(csv,user)
		puts user
		csv = CSV.new(csv, headers: true)
		csv.to_a.each do |row| 
    		row_hash = row.to_hash
    		row_hash["image"] = File.new(row_hash["image"])
    		row_hash["user_id"] = user["id"]
    		Contact.create! row_hash
		end
	end
   def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
				all.each do |contact|
				csv << contact.attributes.values_at(*column_names)
			end

		end
	end


	
end
	


