require 'spec_helper'

config = YAML::load_file(File.join(File.dirname(__FILE__ ), '..', 'secrets.yml'))

describe ComagicClient do


  describe "login feature" do
    describe "with valid credentials" do
      let(:agency_connector) do
        login = config['accounts']['agency']['login']
        password = config['accounts']['agency']['password']
        ComagicClient.new login, password
      end

      it "should login to service and receive a string token" do
        expect(agency_connector.login).to be_an_instance_of(String)
      end

      describe "logout feature" do
        before { agency_connector.login }
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
end