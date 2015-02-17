%w{rest_client json}.each { |lib| require lib }

class Hash
  def not_nils!
    reject! { |k,v| v.nil? }
  end
end

# This class creates a new comagic connector instanse
class ComagicClient

  # Comagic API error class
  class ApiError < StandardError
  end

  # Set up a new connector instanse
  def initialize(login, password)
    @session_key = nil
    @api_url = 'http://195.211.120.36/api'
    @login, @password = login, password
  end

  # Perform login with login and password specified in the initialize method
  def login
    response = post "login", login: @login, password: @password
    @session_key = response['session_key']
  end


  # Perform logout
  def logout
    require_auth!
    get "logout", session_key: @session_key
  end

  # Get sit(es)
  def site(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/site', options
  end

  # Get ad campaigns
  def ac(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/ac', options
  end

  # Get tags
  def tag(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/tag', options
  end

  # Get communications
  def communication(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/communication', options
  end

  # Get stat
  def stat(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/stat', options
  end

  # Get goal
  def goal(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/goal', options
  end
  
  # Get call
  def call(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/call', options
  end

  # Get chat
  def chat(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/chat', options
  end

  # Get chat_message
  def chat_message(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/chat_message', options
  end

  # Get offline_message
  def offline_message(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/offline_message', options
  end

  # Get person_by_visitor
  def person_by_visitor(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/person_by_visitor', options
  end

  # Get visitors_by_person
  def visitors_by_person(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/visitors_by_person', options
  end

  # Get visitor
  def visitor(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/visitor', options
  end

  # Get get_cdr_in
  def get_cdr_in(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/get_cdr_in', options
  end

  # Get get_cdr_out
  def get_cdr_out(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/get_cdr_out', options
  end
  
  # Get customer_list
  def customer_list(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    get 'v1/customer_list', options
  end

  def create_site(options = {})
    require_auth!
    options.merge!({ session_key: @session_key }).not_nils!
    post 'v1/create_site', options
  end

  # Pass post, get, delete, put and patch to the request method
  def method_missing(method_name, *arguments, &block)
    if method_name.to_s =~ /(post|get|put|patch|delete)/
      request($1.to_sym, *arguments, &block)
    else
      super
    end
  end

  # Let class instance respond to post, get, delete, put and patch
  def respond_to?(method_name, *arguments, &block)
    !!method_name.to_s.match(/(post|get|put|patch|delete)/) || super
  end

  def to_s
    "#{@login}"
  end
  
  private

    # Generic request method
    def request(strategy, uri, data)
      if strategy == :get
        response = RestClient.get "#{@api_url}/#{uri}/", params: data, accept: 'application/json'
      else
        response = RestClient.send strategy, "#{@api_url}/#{uri}/", data, accept: 'application/json'
      end
      response = JSON.parse response
      require_success! response
      response['data']
    end

    def session_created?
      @session_key != nil
    end

    def require_auth!
      raise ApiError, "Must be logged in to log out" unless session_created?
    end

    def require_success!(response)
      raise ApiError, response['message'] unless response['success'] 
      response
    end
end
