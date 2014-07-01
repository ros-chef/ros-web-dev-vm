require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "ROSLIBJS" do
  describe command('bash -c "cd /home/vagrant/rwt/roslibjs/utils && grunt build"') do
    it { should return_stdout /Done, without errors./ }
  end
end
