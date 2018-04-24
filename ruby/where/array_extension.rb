module ArrayExtension
	
	def where(args)
		data = self
		args.each do |key, value|
			if value.is_a? Regexp
				data.select! { |obj| args[key] =~ obj[key] }
			else 
				data.select! { |obj| args[key] == obj[key] }
			end
		end
		data  
	end

end