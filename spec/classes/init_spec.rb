require 'spec_helper'
describe 'fhs_app_vcs' do

  context 'with defaults for all parameters' do
    it { should contain_class('fhs_app_vcs') }
  end
end
