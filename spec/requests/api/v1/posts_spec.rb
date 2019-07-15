require 'rails_helper'

describe 'PostAPI' do
  it '全てのポストを取得する' do
    create_list(:post, 10)

    get '/api/v1/posts'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 正しい数のデータが返されたか確認する。
    expect(json['data'].length).to eq(10)
  end

  it '特定のポストを取得する' do
    post = create(:post, title: 'test-title')

    get "/api/v1/posts/#{post.id}"
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 要求した特定のポストのみ取得したことを確認する
    expect(json['data']['title']).to eq(post.title)
  end

  it '新しいポストを作成する' do
    valid_params = { title: 'title' }

    # データが作成されていることを確認
    expect { post '/api/v1/posts', params: {post: valid_params } }.to change(Post, :count).by(+1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end

  it 'ポストの編集を行う' do
    post = create(:post, title: 'old-title')

    put "/api/v1/posts/#{post.id}", params: { post: {title: 'new-title'} }
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # データが更新されていることを確認
    expect(json['data']['title']).to eq('new-title')
  end
end