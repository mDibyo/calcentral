describe HubEdos::Registrations do

  context 'mock proxy' do
    let(:proxy) { HubEdos::Registrations.new(fake: true, user_id: '61889', term_id: '2168') }
    subject { proxy.get }

    it_should_behave_like 'a simple proxy that returns errors'

    it 'returns data with the expected structure' do
      expect(subject[:feed]['registrations']).to be
      expect(subject[:feed]['registrations'][0]['academicCareer']['code']).to eq('LAW')
      expect(subject[:feed]['registrations'].size).to eq(1)
    end
  end

end
