require 'spec_helper'

describe WebServer::Resource do
  def conf_double(options={})
    double(WebServer::HttpdConf, {
      document_root: '/doc_root',
      directory_index: 'index.html'
    }.merge(options))
  end

  def request_double(options={})
    double(WebServer::Request, {
      http_method: options.fetch(:method, 'GET'),
      uri: options.fetch(:uri, '/')
    })
  end

  describe '#resolve' do
    context 'for an unaliased path' do
      let(:conf) do 
        object = conf_double
        object.stub(:aliases).and_return []
        object.stub(:script_aliases).and_return []
        object
      end

      let(:request) { request_double(uri: '/a/resource') }

      it 'should return the absolute path to the file' do
        expected_path = "#{conf.document_root}#{request.uri}/#{conf.directory_index}"
        expect(WebServer::Resource.new(request, conf).resolve).to eq expected_path
      end
    end

    context 'for a script aliased path' do
      let(:conf) do
        object = conf_double
        object.stub(:aliases).and_return []
        object.stub(:script_aliases).and_return ['/ss/ss']
        object.stub(:script_alias_path).and_return '/tt/tt/tt'
        object
      end
      let(:request) { request_double(uri: '/ss/ss/resource.php') }

      it 'should return the absolute path to the file' do
        expected_path = '/doc_root/tt/tt/tt/resource.php'
        expect(WebServer::Resource.new(request, conf).resolve).to eq expected_path
      end
    end

    context 'for an aliased path' do
      let(:conf) do 
        object = conf_double
        object.stub(:aliases).and_return ['/aa/aa']
        object.stub(:alias_path).and_return('/bb/bb/bb')
        object
      end
      let(:request) { request_double(uri: '/aa/aa/resource') }

      it 'should return the absolute path to the file' do
        expected_path = '/doc_root/bb/bb/bb/resource/index.html'
        expect(WebServer::Resource.new(request, conf).resolve).to eq expected_path
      end
    end
  end

  describe '#script_aliased?' do
    context 'for a script aliased path' do
      let(:conf) { conf_double(script_aliases: ['/ss/ss'], script_alias_path: '/tt/tt/tt') }
      let(:request) { request_double(uri: '/ss/ss/resource') }

      it 'returns true' do
        expect(WebServer::Resource.new(request, conf).script_aliased?).to be_true
      end
    end

    context 'for a non script aliased path' do
      let(:conf) { conf_double(script_aliases: []) }
      let(:request) { request_double(uri: '/a/resource') }

      it 'returns false for a non script aliased path' do
        expect(WebServer::Resource.new(request, conf).script_aliased?).to eq false
      end
    end
  end

  # I want these tests, but need to decide how to spec authentication first:
  # <directory> tags or .htaccess? (or both for EC?)
# describe '#protected?' do
#   context 'when protected directory' do
#     it 'returns true'
#     it 'returns false if valid credentials supplied'
#     it 'returns true if invalid credentials supplied'
#     it 'returns true if no credientials are supplied'
#   end
#
#   context 'when unprotected directory' do
#     it 'returns false'
#   end
# end
end
