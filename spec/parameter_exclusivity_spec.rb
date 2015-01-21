require 'spec_helper'

describe 'Parameter Sets' do
  describe 'one_of' do
    it 'returns 400 on requests that contain more than one mutually exclusive parameter' do
      params = [
        {a: 1, b: 2},
        {b: 2, c: 3},
        {a: 1, b: 2, c: 3}
      ]

      params.each do |param|
        get('/choice', param) do |response|
          expect(response.status).to eql 400
          expect(JSON.parse(response.body)['message']).to match(/mutually exclusive/)
        end
      end
    end

    it 'returns 400 on requests that contain more than one mutually exclusive parameter' do
      get('/choice2', {a: 1, b: 2}) do |response|
        expect(response.status).to eql 400
        expect(JSON.parse(response.body)['message']).to match(/mutually exclusive/)
      end
    end

    it 'returns successfully for requests that have one parameter' do
      params = [
        {a: 1},
        {b: 2},
        {c: 3}
      ]

      params.each do |param|
        get('/choice', param) do |response|
          expect(response.status).to eql 200
          expect(JSON.parse(response.body)['message']).to match(/OK/)
        end
      end
    end

    it 'returns successfully for requests that have no parameter' do
      get('/choice') do |response|
        expect(response.status).to eql 200
        expect(JSON.parse(response.body)['message']).to match(/OK/)
      end
    end
  end
end
