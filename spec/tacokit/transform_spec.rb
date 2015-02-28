require "spec_helper"

module Tacokit
  describe Transform do
    subject(:transform) { Transform.new }

    describe "#serialize" do
      def process(body)
        transform.serialize(body)
      end

      it "does not change no body" do
        result = process(nil)
        expect(result).to be_nil
      end

      it "does not change empty body" do
        result = process("")
        expect(result).to eq ""
      end

      it "does not change string body" do
        result = process("{a: 1}")
        expect(result).to eq "{a: 1}"
      end

      it "does not change empty hash body" do
        result = process({})
        expect(result).to eq({})
      end

      context "hash body" do
        it "it stringifies keys" do
          result = process(hello: "world")

          expect(result).to eq "hello" => "world"
        end

        it "lower camelizes keys" do
          result = process(hello_world: "hello_world", biggie_smalls: "biggie_smalls")

          expect(result).to include("helloWorld" => "hello_world")
          expect(result).to include("biggieSmalls" => "biggie_smalls")
        end

        it "flattens nested keys" do
          result = process(prefs: { "showSidebar" => true })

          expect(result).to eq("prefs/showSidebar" => true)
        end

        it "coverts id suffix to prefix" do
          result = process("card_id" => "a" * 10)

          expect(result).to eq("idCard" => "a" * 10)
        end

        it "coverts ids suffix to prefix and pluralizes" do
          result = process("card_ids" => "a" * 10)

          expect(result).to eq("idCards" => "a" * 10)
        end

        describe "special cases" do
          it "callbackURL" do
            result = process(callback_url: "http://example.com")

            expect(result).to eq("callbackURL" => "http://example.com")
          end

          it "idChecklistSource" do
            result = process("checklist_source_id" => "a" * 10)

            expect(result).to eq("idChecklistSource" => "a" * 10)
          end
        end
      end
    end

    describe "#deserialize" do
      def process(body)
        transform.deserialize(body)
      end

      it "does not change no body" do
        result = process(nil)
        expect(result).to be_nil
      end

      it "does not change empty body" do
        result = process("")
        expect(result).to eq ""
      end

      it "does not change string body" do
        result = process("{a: 1}")
        expect(result).to eq "{a: 1}"
      end

      it "does not change empty hash body" do
        result = process({})
        expect(result).to eq({})
      end

      context "hash body" do
        it "it stringifies keys" do
          result = process(hello: "world")

          expect(result).to eq "hello" => "world"
        end

        it "underscores keys" do
          result = process(helloWorld: "helloWorld", biggieSmalls: "biggieSmalls")

          expect(result).to include("hello_world" => "helloWorld")
          expect(result).to include("biggie_smalls" => "biggieSmalls")
        end

        it "coverts id prefix to suffix" do
          result = process("idCard" => "a" * 10, "idBoardPinned" => "123")

          expect(result).to eq("card_id" => "a" * 10, "board_pinned_id" => "123")
        end

        it "coverts ids suffix to prefix and pluralizes" do
          result = process("idCards" => "a" * 10, "idBoardsPinned" => ["123"])

          expect(result).to eq("card_ids" => "a" * 10, "boards_pinned_ids" => ["123"])
        end
      end
    end
  end
end
