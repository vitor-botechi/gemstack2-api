describe "DELETE /products/:id" do
  before(:all) do
    @product = Product.new("papito@ninjapixel.com", "pwd123")
    @data = YAML.load_file(File.join(Dir.pwd, "spec/fixtures/delete.yaml"))
  end

  context "dado que eu tenho um produto" do
    before(:all) do
      @payload = @data["mario3"]
      Database.new.remove_product(@payload["title"])
      resp = @product.create(@payload)
      @product_id = resp.parsed_response["id"]
    end
    context "quando busco por id" do
      before(:all) do
        @resp = @product.remove(@product_id)
      end

      it "então deve retornar 204" do
        expect(@resp.code).to eql 204
      end
    end

    after(:all) do
      resp = @product.unique(@product_id)
      expect(resp.code).to eql 404
    end
  end
end
