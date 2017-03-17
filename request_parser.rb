require 'nokogiri'

class RequestParser

	def initialize(file)
		@xml = File.open(file)  { |f| Nokogiri::XML(f) }
		@xml_list = []
	end
   
	def xml
		@xml
	end


	def prepare_full_ws
		copy_xml = @xml.clone
		@xml_list << add_variables_to_xml(copy_xml)
    	end


    	def add_variables_to_xml(xml_doc)
		xml_doc.traverse do |node|
			if is_attribute_of_ws(node)
				insert_variable_to_node(node)
			end
        	end
        	xml_doc
	end
    
	def insert_variable_to_node(node)
		variable = node.name.gsub(/^\w*\W/, "")
		node.content = "${#{variable}}"
	end
    
	def prepare_mandatory_ws
		copy_xml = @xml.clone
		copy_xml = remove_non_mandatory_nodes(copy_xml)
		copy_xml = add_variables_to_xml(copy_xml)
		@xml_list << copy_xml
	end

	def remove_non_mandatory_nodes(xml_doc)
		xml_doc.traverse do |node|
			if  is_attribute_of_ws(node) && !node.text.include?("MANDATORY")
				node.remove
			end
		end
		xml_doc
	end
    
	def is_attribute_of_ws(node)
		node.children.count == 1 && node.name != "document"
	end
end
