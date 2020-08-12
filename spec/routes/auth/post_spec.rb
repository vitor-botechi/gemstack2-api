# suite de teste
describe "POST /auth" do
  def auth(payload)
    return HTTParty.post(
             "http://pixel-api:3333/auth",
             body: payload.to_json,
             headers: { "Content-Type" => "application/json" },
           )
  end

  # cenário de teste
  it "autorizar usuário" do
    payload = { email: "papito@ninjapixel.com", password: "pwd123" }

    resp = auth(payload)

    expect(resp.code).to eql 200
    expect(resp.parsed_response["token"].length).to eql 147
  end

  it "senha incorreta" do
    payload = { email: "papito@ninjapixel.com", password: "abc123" }

    resp = auth(payload)

    expect(resp.code).to eql 401
  end
end
