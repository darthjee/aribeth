shared_examples 'a model that validates' do |*attributes|
  it do
    expect(subject).to be_valid
  end

  attributes.each do |attribute|
    context "when #{attribute} is null" do
      before do
        subject.public_send("#{attribute}=", nil)
      end

      it do
        expect(subject).to be_invalid
      end
    end
  end
end
