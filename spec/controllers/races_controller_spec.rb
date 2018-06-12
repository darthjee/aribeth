require 'spec_helper'

describe RacesController, type: :controller do
  before do
    Race.delete_all
  end

  # This should return the minimal set of attributes required to create a valid
  # Race. As you add validations to Race, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      'code' => 'orc',
      'playable' => false
    }
  end

  let(:invalid_attributes) do
    {}
  end

  let(:expected_attributes) do
    {
      'code' => 'elf',
      'playable' => true
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RacesController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let!(:race) { create(:race, code: :elf) }
  let(:response_json) { JSON.parse(response.body) }

  describe "GET #index" do
    let(:parameters) { { format: :json } }
    before do
      get :index, params: parameters
      expected_attributes.merge!('id' => race.to_param)
    end

    context 'when requestin the REST api' do
      it { expect(response).to be_successful }

      it 'returns all races' do
        expect(response_json.mapk('code')).to eq(['elf'])
      end

      it 'returns all the information' do
        expect(response_json).to include(hash_including(expected_attributes))
      end
    end

    context 'when requesting the templates' do
      let(:parameters) { { ajax: true } }
      it { expect(response).to render_template('races/index') }
    end
  end

  describe 'GET new' do
    let(:parameters) { { format: :json} }
    before do
      get :new, params: parameters
    end

    it { expect(response).to be_successful }

    context 'when requesting the view' do
      before { get :new, params: { ajax: true, format: :html } }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('races/new') }
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: parameters
      expected_attributes.merge!('id' => race.to_param)
    end

    context 'when requestin the REST api' do
      let(:parameters) { { id: race.to_param, format: :json } }
      it { expect(response).to be_successful }

      it 'returns the whole race' do
        expect(response_json).to match(hash_including(expected_attributes))
      end
    end

    context 'when requesting the templates' do
      let(:parameters) { { id: race.id, ajax: true } }
      it { expect(response).to render_template('races/show') }
    end
  end

  describe "GET #new" do
    before { get :new, params: { ajax: true } }
    it { expect(response).to be_successful }
    it { expect(response).to render_template('races/new') }
  end

  describe "GET #edit" do
    context 'when requesting the view' do
      before { get :edit, params: { id: race.id, ajax: true } }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('races/edit') }
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:expected_attributes) do
        valid_attributes.merge('_id' => anything)
      end
      it do
        expect do
          post :create, params: { race: valid_attributes, format: :json }
        end.to change(Race, :count).by(1)
      end

      context 'after the request' do
        before do
          post :create, params: {race: valid_attributes, format: :json }
        end

        it { expect(response).to be_successful }

        it 'returns the whole race' do
          expect(response_json).to match(hash_including(expected_attributes))
        end
      end
    end

    context "with invalid params" do
      it do
        expect do
          post :create, params: { race: invalid_attributes } rescue nil
        end.not_to change(Race, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:expected_attributes) do
        valid_attributes.merge('_id' => race.id.as_json)
      end
      it 'updates the requested race' do
        expect do
          put :update, params: {id: race.to_param, race: valid_attributes, format: :json }
        end.to change { race.tap(&:reload).code }
      end

      it 'returns the whole race' do
        put :update, params: {id: race.to_param, race: valid_attributes, format: :json }
        expect(response_json).to match(hash_including(expected_attributes))
      end
    end

    context "with invalid params" do
      it do
        expect do
          put :update, params: {id: race.to_param, race: invalid_attributes, format: :json } rescue nil
        end.not_to change(Race, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested race" do
      expect do
        delete :destroy, params: { id: race.id, format: :json }
      end.to change(Race, :count).by(-1)
    end
  end
end
