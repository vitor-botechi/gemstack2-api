# suite de teste
describe "POST /products" do
  before(:all) do
    @product = Product.new("papito@ninjapixel.com", "pwd123")
    @data = YAML.load_file(File.join(Dir.pwd, "spec/fixtures/post.yaml"))
  end

  context "dado que eu tenho um produto" do
    before(:all) do
      @payload = @data["contra"]
      Database.new.remove_product(@payload["title"])
    end
    context "quando faço o cadastro" do
      before(:all) do
        @resp = @product.create(@payload)
      end

      it "então deve retornar 200" do
        expect(@resp.code).to eql 200
      end
    end
  end

  context "dado que o produto é duplicado" do
    before(:all) do
      @payload = @data["dup"]
      Database.new.remove_product(@payload["title"])
      @product.create(@payload)
    end

    context "quando faço o cadastro" do
      before(:all) do
        @resp = @product.create(@payload)
      end

      it "então retorna 409" do
        expect(@resp.code).to eql 409
      end

      it "e retorna title must be unique" do
        expect(@resp.parsed_response["msg"]).to eql "title must be unique"
      end
    end
  end

  context "quando faço o cadastro sem titulo" do
    before(:all) do
      @payload = @data["no_title"]
      @resp = @product.create(@payload)
    end

    it "então deve retornar 400" do
      expect(@resp.code).to eql 400
    end

    it "e titulo não informado" do
      expect(@resp.parsed_response["msg"]).to eql "Oops! title cannot be empty"
    end
  end
end
