describe "GET" do
  before(:all) do
    @product = Product.new("papito@ninjapixel.com", "pwd123")
    @data = YAML.load_file(File.join(Dir.pwd, "spec/fixtures/get.yaml"))
  end

  describe "/products/:id" do
    context "dado que eu tenho um produto" do
      before(:all) do
        @payload = @data["streetf2"]
        Database.new.remove_product(@payload["title"])
        resp = @product.create(@payload)
        @product_id = resp.parsed_response["id"]
      end
      context "quando busco por id" do
        before(:all) do
          @resp = @product.unique(@product_id)
        end

        it "então deve retornar 200" do
          expect(@resp.code).to eql 200
        end

        it "e retorna o produto cadastrado" do
          expect(@resp.parsed_response["title"]).to eql @payload["title"]
        end
      end
    end

    context "quando busco por id não cadastrado" do
      before do
        @resp = @product.unique(Faker::Number.number(digits: 5))
      end

      it "então deve retornar 404" do
        expect(@resp.code).to eql 404
      end
    end

    context "quando busco por id muito grande" do
      before(:all) do
        @product_id = Faker::Number.number(digits: 10)
        @resp = @product.unique(@product_id)
      end

      it "então deve retornar 412" do
        expect(@resp.code).to eql 412
      end

      it "e retorna msg de erro" do
        expect_message = "value \"#{@product_id}\" is out of range for type integer"
        expect(
          @resp.parsed_response["msg"]
        ).to eql expect_message
      end
    end
  end

  describe "/products" do
    context "dado que eu tenho produtos" do
      before(:all) do
        # cadastrar produtos
        product_list = @data["list"]

        product_list.each do |payload|
          @product.create(payload)
        end
      end

      context "quando eu busco todos", :list do
        before(:all) do
          @resp = @product.list
        end

        it "então retorna 200" do
          expect(@resp.code).to eql 200
        end

        it "e deve retornar uma lista" do
          expect(@resp.parsed_response["data"]).not_to be_empty
        end
      end
    end
  end
end
