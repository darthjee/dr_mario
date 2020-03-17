# frozen_string_literal: true

shared_examples 'a request cached', cached: true do
  it 'sets cache' do
    expect(response.headers['Cache-Control'])
      .to eq("max-age=#{Settings.cache_age}, public")
  end
end

shared_examples 'a request not cached', not_cached: true do
  it 'does not set cache' do
    expect(response.headers['Cache-Control']).to be_nil
  end
end
