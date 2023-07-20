require 'rails_helper'

RSpec.describe IncidentsController, type: :controller do
  let(:app) { FactoryBot.create(:app) }
  let(:channel) { FactoryBot.create(:channel) }
  
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #investigate_incident' do
    context 'when the command is "declare"' do
      let(:params) { { text: 'declare Title' } }

      before do
        allow(controller).to receive(:create_new_incident)
        allow(controller).to receive(:fetch_app).and_return(app)
        post :investigate_incident, params: params
      end

      it 'does not render an error message' do
        expect(response.body).not_to include('error')
      end
    end

    context 'when the command is "resolve"' do
      let(:params) { { text: 'resolve' } }

      before do
        allow(controller).to receive(:resolve_incident)
        post :investigate_incident, params: params
      end
    end

    context 'when the command is invalid' do
      let(:params) { { text: 'invalid' } }

      before do
        post :investigate_incident, params: params
      end

      it 'renders an error message' do
        expect(response.body).to include('Invalid command')
      end
    end

    context 'when an exception occurs' do
      let(:params) { { text: 'declare Title' } }

      before do
        allow(controller).to receive(:create_new_incident).and_raise('Something went wrong')
        post :investigate_incident, params: params
      end

      it 'renders an error message' do
        expect(response.body).to include('Something went wrong')
      end
    end
  end

  describe 'GET #sort_incident_list' do
    it 'renders the incidents partial' do
      get :sort_incident_list
      expect(response).to render_template(partial: '_incidents')
    end
  end
end
