require 'spec_helper'

describe OmniAuth::Strategies::Pavlok do
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  let(:site)          { 'https://some.other.site.com/api/v1' }
  let(:authorize_url) { 'https://some.other.site.com/oauth/authorize' }
  let(:token_url)     { 'https://some.other.site.com/oauth/token' }
  let(:pavlok) do
    OmniAuth::Strategies::Pavlok.new('PAVLOK_KEY', 'PAVLOK_SECRET',
        {
            :client_options => {
                :site => site,
                :authorize_url => authorize_url,
                :token_url => token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::Pavlok.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://pavlok-mvp.herokuapp.com")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('https://pavlok-mvp.herokuapp.com/oauth/authorize')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('https://pavlok-mvp.herokuapp.com/oauth/token')
    end

    describe "should be overrideable" do
      it "for site" do
        pavlok.options.client_options.site.should eq(site)
      end

      it "for authorize url" do
        pavlok.options.client_options.authorize_url.should eq(authorize_url)
      end

      it "for token url" do
        pavlok.options.client_options.token_url.should eq(token_url)
      end
    end
  end

  context "info" do
    it "should return email from raw_info if available" do
      expect(subject).to receive(:raw_info).and_return({'email' => 'you@example.com'})
      subject.email.should eq('you@example.com')
    end

    it "should return nil if there is no raw_info and email access is not allowed" do
      expect(subject).to receive(:raw_info).and_return({})
      subject.email.should be_nil
    end
  end

  context "client timeout" do
    it "should raise Timeout::Error if it fails to connect with site" do
      allow(access_token).to receive(:get).and_raise(::Errno::ETIMEDOUT)
      expect{subject.email}.to raise_error ::Timeout::Error
    end
  end

end
