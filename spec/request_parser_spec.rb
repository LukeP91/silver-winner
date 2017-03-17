require_relative '../request_parser.rb'
require 'pry'
			
describe RequestParser do
	context 'basic request' do 
		before(:each) do
			@parser = RequestParser.new('./spec/test_full_ws.xml')
			@xml_doc = @parser.prepare_full_ws                                     	
		end
		
		it 'inserts proper variables' do
			expect(@xml_doc.first.xpath('//test1').first.content).to eq('${test1}')	
			expect(@xml_doc.first.xpath('//test2').first.content).to eq('${test2}')
		end
		
		it "doesn't change node with children nodes" do
			expect(@xml_doc.first.xpath('//node1').children.count).to eq(3)
		end
	end

	context 'mandatoryWS' do
		before(:each) do
			@parser = RequestParser.new('./spec/test_mandatory_ws.xml')
			@xml_doc = @parser.prepare_mandatory_ws
		end
		
		it 'removes optional nodes' do
			expect(@xml_doc.first.xpath('//test2')).to be_empty
		end
	
		it 'inserts proper variables ' do
			expect(@xml_doc.first.xpath('//test1').first.content).to eq('${test1}')
		end
	end
end
