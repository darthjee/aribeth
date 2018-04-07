require 'spec_helper'

describe Race do
  subject do
    build :race
  end

  it_behaves_like 'a model that validates', :code
end
