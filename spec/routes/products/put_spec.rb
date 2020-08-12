# dica, tente fazer o PUT no Insomia, depois no código!
# dica, o PUT é um misto do Get + Post, ou seja tem Payload no Body e Id na Rota

describe "PUT /products/:id" do
  context "dado que eu tenho um produto" do
    before(:all) do
      # todo
    end

    context "quando eu atualizo" do
      before(:all) do
        # todo
      end

      it "então deve retornar 204" do
        expect(@resp.code).to eql 204
      end
    end

    after (:all) do
      # todo
    end
  end
end
