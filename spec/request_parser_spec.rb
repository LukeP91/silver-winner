require_relative '../request_parser.rb'

describe RequestParser do
	it 'inserts proper variables' do
		parser = RequestParser.new('./spec/test.xml')
		xml_doc = parser.addVariablesToXML
		expect(xml_doc['test5'].content).to eq('${test5}')
	end
end

