require 'bibliography_list.rb'
require 'faker'

RSpec.describe BibliographyList, "#format_fullnames" do
  context "with empty fullnames" do
    it "returns empty list" do
      bibliography_list = BibliographyList.new([])
      expect(bibliography_list.format_fullnames).to eq([])
    end
  end

  context "with null fullnames" do
    it "returns empty list" do
      bibliography_list = BibliographyList.new(nil)
      expect(bibliography_list.format_fullnames).to eq([])
    end
  end

  context "with single fullname" do
    it "returns upcased for single name" do
      name = Faker::Name.first_name
      bibliography_list = BibliographyList.new([name])
      expect(bibliography_list.format_fullnames).to match_array([name.upcase])
    end

    it "returns two upcased for secondary lastname" do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      secondary_lastname = ["neto", "neta", "filho", "filha", "sobrinho", "sobrinha", "junior"].sample
      name = "#{first_name} #{last_name} #{secondary_lastname}"
      bibliography_list = BibliographyList.new([name])
      expect(bibliography_list.format_fullnames).to(
        match_array(["#{last_name.upcase} #{secondary_lastname.upcase}, #{first_name.capitalize}"])
      )
    end

    it "returns preposition with lowercase" do
      preposition = ['dE', 'DAS', 'Da', 'dO', 'DOs'].sample
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      name = "#{first_name} #{preposition} #{last_name}"
      bibliography_list = BibliographyList.new([name])
      expect(bibliography_list.format_fullnames).to(
        match_array(["#{last_name.upcase}, #{first_name.capitalize} #{preposition.downcase}"])
      )
    end
  end

  context "with variety of names" do
    it "returns formated list" do
      bibliography_list = BibliographyList.new([
        "joao", "joao silva", "joao da silva", "Joao da silva neto",
        "joao silva da neto", "joao da silva douglas neto"
        ])
      expect(bibliography_list.format_fullnames).to match_array([
        "JOAO",
        "SILVA, Joao",
        "SILVA, Joao da",
        "SILVA NETO, Joao da",
        "da NETO, Joao Silva",
        "DOUGLAS NETO, Joao da Silva"
      ])
    end
  end
end
