class ImportJob
	@queue = :import

	def self.perform(csv, current_user)
		puts "srgt"
    Contact.import(csv, current_user)
  end
end