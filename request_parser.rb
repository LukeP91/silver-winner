require 'nokogiri'

class RequestParser

    def initialize(file)
        @xml = File.open(file)  { |f| Nokogiri::XML(f) }
        @xml_list = []
    end
   
    def xml
        @xml
    end
 
    def addVariablesToXML
	xml_doc = @xml.clone
        xml_doc.traverse do |node|
            if node.children.count == 1 && node.name != "document"
                insertVariableToNode(node)
            end
        end
        xml_doc
    end
    
    def insertVariableToNode(node)
        variable = node.name.gsub(/^\w*\W/, "")
        node.content = "${#{variable}}"
    end
    
    def prepareMandatoryWS
        copy_xml = @xml.clone
        copy_xml = removeNonMandatoryNodes(copy_xml)
        copy_xml = addVariablesToXML(copy_xml)
        @xml_list << copy_xml
    end
    
    def removeNonMandatoryNodes(xml_doc)
        xml_doc.traverse do |node|
            if  isAttributeOfWS(node) && !node.text.include?("MANDATORY")
                node.remove
            end
        end
        xml_doc
    end
    
    def print_xml
        @xml_list.each do |xml|
            puts xml
        end
    end
    
    def testMethod
        # prepareFullWS
        prepareMandatoryWS
        
        print_xml
    end
    
    def isAttributeOfWS(node)
        node.children.count == 1 && node.name != "document"
    end
end
