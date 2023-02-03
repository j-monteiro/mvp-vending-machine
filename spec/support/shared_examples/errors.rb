# frozen_string_literal: true

RSpec.shared_examples 'a error code' do
  describe '#code' do
    it 'returns status code' do
      expect(subject.code).to eq(code)
    end
  end
end

RSpec.shared_examples 'a error error_message' do
  subject do
    Class.new(described_class) do
      def error_message
        super
      end
    end.new
  end

  describe '#error_message' do
    it 'returns message' do
      expect(subject.error_message).to eq(message)
    end
  end
end

RSpec.shared_examples 'a error reason' do
  subject do
    Class.new(described_class) do
      def reason
        super
      end
    end.new('the-error-message')
  end

  it 'returns reason' do
    expect(subject.reason).to eq(reason)
  end
end
