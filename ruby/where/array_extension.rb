module ArrayExtension
	
	def where(args)
		data = self
		args.each do |key, value|
			data.select! { |obj| args[key] == obj[key] }
		end
		data  
	end

end