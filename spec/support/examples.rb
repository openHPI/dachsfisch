# frozen_string_literal: true

module Examples
  class Example2
    def self.json
      '{ "alice": { "$" : "bob" } }'
    end

    def self.xml
      '<alice>bob</alice>'
    end
  end

  class Example3
    def self.json
      '{ "alice": { "bob" : { "$": "charlie" }, "david": { "$": "edgar"} } }'
    end

    def self.xml
      '<alice><bob>charlie</bob><david>edgar</david></alice>'
    end
  end

  class Example4
    def self.json
      '{ "alice": { "bob" : [{"$": "charlie" }, {"$": "david" }] } }'
    end

    def self.xml
      '<alice><bob>charlie</bob><bob>david</bob></alice>'
    end
  end

  class Example5
    def self.json
      '{ "alice": { "$" : "bob", "@charlie" : "david" } }'
    end

    def self.xml
      '<alice charlie="david">bob</alice>'
    end
  end

  class Example7
    def self.json
      '{ "alice": { "$" : "bob", "@xmlns": { "$" : "http://some-namespace"} } }'
    end

    def self.xml
      '<alice xmlns="http://some-namespace">bob</alice>'
    end
  end

  # rubocop:disable Layout/LineLength
  class Example8
    def self.json
      '{ "alice": { "$" : "bob", "@xmlns": { "$" : "http://some-namespace", "charlie" : "http://some-other-namespace" } } }'
    end

    def self.xml
      '<alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace">bob</alice>'
    end
  end

  class Example9
    def self.json
      '{ "alice" : { "bob" : { "$" : "david" , "@xmlns" : {"charlie" : "http://some-other-namespace" , "$" : "http://some-namespace"} } , "charlie:edgar" : { "$" : "frank" , "@xmlns" : {"charlie":"http://some-other-namespace", "$" : "http://some-namespace"} }, "@xmlns" : { "charlie" : "http://some-other-namespace", "$" : "http://some-namespace"} } }'
    end

    def self.xml
      '<alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace"> <bob>david</bob> <charlie:edgar>frank</charlie:edgar> </alice>'
    end
  end
  # rubocop:enable Layout/LineLength

  class CustomExampleMultipleTextNodes
    def self.json
      '{"alice":{"$":"bob","charlie":{"$":"bob2"},"$2":"bob3"}}'
    end

    def self.xml
      '<alice>bob<charlie>bob2</charlie>bob3</alice>'
    end
  end

  class CustomExampleComment
    def self.json
      '{"alice":{"#":"my comment"}}'
    end

    def self.xml
      '<alice><!--my comment--></alice>'
    end
  end

  class CustomExampleCdata
    def self.json
      '{"alice":{"!":"<bob></bob>"}}'
    end

    def self.xml
      '<alice><![CDATA[<bob></bob>]]></alice>'
    end
  end

  def self.all
    constants.filter_map do |constant|
      c = const_get(constant)
      c if c.is_a?(Class)
    end
  end

  def self.each(&)
    all.each(&)
  end
end
