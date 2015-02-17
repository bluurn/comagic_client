require 'spec_helper'

config = YAML::load_file(File.join(File.dirname(__FILE__), '..', 'secrets.yml'))

describe ComagicClient do

  describe "as an agency account" do
    let(:agency_connector) do
      login = config['accounts']['agency']['login']
      password = config['accounts']['agency']['password']
      ComagicClient.new login, password
    end

    it "should login to service and receive a string token" do
      expect(agency_connector.login).to be_an_instance_of(String)
    end

    describe "when logged in" do
      before { agency_connector.login }

      describe "site feature" do
        it "should not get sites with no options specified" do
          expect { agency_connector.site }.to raise_error(ComagicClient::ApiError, /Access denied/)
        end
        it "should get sites if customer_id specified" do
          expect(agency_connector.site customer_id: config['accounts']['agency']['customer_id']).to be_a(Array)
        end
      end

      describe "ad campaigns feature" do
        it 'should throw error with no options' do
          expect { agency_connector.ac }.to raise_error(ComagicClient::ApiError, /Access denied/)
        end
        it 'should return sites if customer_id is specified' do
          expect(agency_connector.ac customer_id: config['accounts']['agency']['customer_id']).to be_a(Array)
        end
        it 'should return sites if only site_id is specified' do
          expect { agency_connector.ac site_id: config['accounts']['agency']['site_id'] }.to raise_error(ComagicClient::ApiError, /Access denied/)
        end
        it 'should return sites if customer_id and site_id are specified' do
          expect(agency_connector.ac site_id: config['accounts']['agency']['site_id'], customer_id: config['accounts']['agency']['customer_id']).to be_a(Array)
        end
      end


      describe "tags feature" do
        it 'should throw error with no options specified' do
          expect{ agency_connector.tag }.to raise_error(ComagicClient::ApiError, /Access denied/)
        end
        it 'should get tags if customer_id is specified' do
          expect(agency_connector.tag customer_id: config['accounts']['agency']['customer_id']).to be_a(Array)
        end
      end

      describe "communications feature" do
        it 'should throw error with no options specified' do
          expect { agency_connector.communication }.to raise_error(ComagicClient::ApiError, /Missing required parameter/)
        end

        it 'get communications if all parameters given' do
          expect(agency_connector.communication customer_id: config['accounts']['agency']['customer_id'], site_id: config['accounts']['agency']['site_id'], date_from: config['accounts']['agency']['date_from'], date_till: config['accounts']['agency']['date_till']).to be_a Array
        end

      end

      describe "stat feature" do
        it "should throw error if no options specified" do
          expect{agency_connector.stat}.to raise_error(ComagicClient::ApiError, /Missing required parameter/)
        end

        it "should return stats if all parameters given" do
          expect(agency_connector.stat customer_id: config['accounts']['agency']['customer_id'], site_id: config['accounts']['agency']['site_id'], date_from: config['accounts']['agency']['date_from'], date_till: config['accounts']['agency']['date_till']).to be_a(Array)
        end
      end
      
      it "should logout from service" do
        expect(agency_connector.logout).to be_empty
      end
    end
  end

  describe "with invalid credentials" do
    let!(:invalid_connector) do
      ComagicClient.new 'a', 'b'
    end

    it "should receive access denied message" do
      expect { invalid_connector.login }.to raise_error(ComagicClient::ApiError, /Wrong login or password/)
    end
  end
end