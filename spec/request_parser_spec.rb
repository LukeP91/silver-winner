require_relative '../request_parser.rb'

describe RequestParser do
	context 'basic request' do 
		it 'inserts proper variables ' do
			parser = RequestParser.new('./spec/test.xml')
			xml_doc = parser.prepare_full_ws
			expect(xml_doc.first.xpath('//test5').first.content).to eq('${test5}')
		end
	end

	context 'mandatoryWS' do
		it 'removes optional nodes' do
			parser = RequestParser.new('./spec/test.xml')
			xml_doc = parser.prepare_mandatory_ws
			expect(xml_doc.first.xpath('//test8')).to be_empty
		end
	
		it 'inserts proper variables ' do
			parser = RequestParser.new('./spec/test.xml')
			xml_doc = parser.prepare_full_ws
			expect(xml_doc.first.xpath('//test5').first.content).to eq('${test5}')
		end
	end
end
