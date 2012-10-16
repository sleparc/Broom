require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class AlphabetizeTest < Test::Unit::TestCase
  context "When given a stylesheet, retrieve_block" do
    should "return a structure of each file line" do
      # files = ['test', 'nested', 'app', 'comment']
      files = ['extend']
      prefix = "#{File.dirname(__FILE__)}/fixtures/"
      files.each do |filename|
        file          = open_file(prefix + filename + ".scss")
        file_expected = open_file(prefix + filename + "_expected.scss")
        output = Broom::Alphabetize.new.retrieve_block(file)
        if filename == 'extend'
          output_file = File.new('app_output.css', "w")
          output_file.puts(output)
          output_file.close
        end
        assert_equal file_expected.readlines.to_s, output
        file.close
        file_expected.close
      end
    end
  end

  context "force_sort" do
    should "do the right thing" do
      structure = ["    z-index: 1000;\n", "    border: 1px\n", "    background: black;\n", "    h1 {\n", "      border-bottom: 2px;\n      font-size: 10px;\n    }\n", "  }\n"]
      structure_expected = ["    background: black;\n", "    border: 1px\n", "    z-index: 1000;\n", "    h1 {\n", "      border-bottom: 2px;\n      font-size: 10px;\n    }\n", "  }\n"]
      assert_equal structure_expected.to_s, Broom::Alphabetize.new.force_sort(structure).to_s
    end
    should "do the right thing still" do
      structure = ["  text-align:left;\n", "  margin: 10px;\n", "  p {\n", "    background: black;\n    border: 1px\n    z-index: 1000;\n    h1 {\n      border-bottom: 2px;\n      font-size: 10px;\n    }\n  }\n", "}\n"]
      structure_expected = ["  margin: 10px;\n", "  text-align:left;\n", "  p {\n", "    background: black;\n    border: 1px\n    z-index: 1000;\n    h1 {\n      border-bottom: 2px;\n      font-size: 10px;\n    }\n  }\n", "}\n"]
      assert_equal structure_expected.to_s, Broom::Alphabetize.new.force_sort(structure).to_s
    end
  end

end
