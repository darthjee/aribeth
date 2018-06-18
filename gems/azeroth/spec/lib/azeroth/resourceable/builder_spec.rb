require 'spec_helper'

shared_examples 'a builder that adds a resource for route' do |route|
  let(:params) { {} }

  it "adds #{route}_resource" do
    expect { subject.build }
      .to change { clazz.new.respond_to?(:"#{route}_resource") }
      .from(false).to(true)
  end

  it "#{route}_resource responds with correct resource" do
    subject.build
    expect(clazz.new(params).get(route).to_json).to eq(expected.to_json)
  end
end

describe Azeroth::Resourceable::Builder do
  subject { described_class.new(clazz, :document) }

  let(:clazz) do
    Class.new(Controller) do
    end
  end

  describe '#build' do
    describe 'index_resource' do
      it_behaves_like 'a builder that adds a resource for route', :index do
        let(:expected) { Document.all }
      end
    end

    describe "new_resource" do
      it_behaves_like 'a builder that adds a resource for route', :new do
        let(:expected) { Document.new }
      end
    end

    describe "create_resource" do
      it_behaves_like 'a builder that adds a resource for route', :create do
        let(:expected) { Document.last }
        let(:params) { { document: { name: 'The Doc'} } }
      end
    end

    describe "show_resource" do
      let(:document) { Document.create }

      it_behaves_like 'a builder that adds a resource for route', :show do
        let(:expected) { document }
        let(:params) { { id: document.id } }
      end
    end

    describe "update_resource" do
      let(:document) { Document.create }

      it_behaves_like 'a builder that adds a resource for route', :update do
        let(:expected) { Document.find(document.id) }
        let(:params) { { id: document.id, document: { name: 'The Doc' } } }
      end
    end
  end
end
