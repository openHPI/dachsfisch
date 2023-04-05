# frozen_string_literal: true

# Examples from http://www.sklar.com/badgerfish/
module Examples
  class Example2
    def self.json
      '{ "alice": { "$1" : "bob" } }'
    end

    def self.xml
      '<alice>bob</alice>'
    end
  end

  class Example3
    def self.json
      '{ "alice": { "bob" : { "$1": "charlie" }, "david": { "$1": "edgar"} } }'
    end

    def self.xml
      '<alice><bob>charlie</bob><david>edgar</david></alice>'
    end
  end

  class Example4
    def self.json
      '{ "alice": { "bob" : [{"$1": "charlie" }, {"$1": "david" }] } }'
    end

    def self.xml
      '<alice><bob>charlie</bob><bob>david</bob></alice>'
    end
  end

  class Example5
    def self.json
      '{ "alice": { "$1" : "bob", "@charlie" : "david" } }'
    end

    def self.xml
      '<alice charlie="david">bob</alice>'
    end
  end

  class Example7
    def self.json
      '{ "alice": { "$1" : "bob", "@xmlns": { "$" : "http://some-namespace"} } }'
    end

    def self.xml
      '<alice xmlns="http://some-namespace">bob</alice>'
    end
  end

  # rubocop:disable Layout/LineLength
  class Example8
    def self.json
      '{ "alice": { "$1" : "bob", "@xmlns": { "$" : "http://some-namespace", "charlie" : "http://some-other-namespace" } } }'
    end

    def self.xml
      '<alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace">bob</alice>'
    end
  end

  class Example9
    def self.json
      '{ "alice" : { "bob" : { "$1" : "david" , "@xmlns" : {"charlie" : "http://some-other-namespace" , "$" : "http://some-namespace"} } , "charlie:edgar" : { "$1" : "frank" , "@xmlns" : {"charlie":"http://some-other-namespace", "$" : "http://some-namespace"} }, "@xmlns" : { "charlie" : "http://some-other-namespace", "$" : "http://some-namespace"} } }'
    end

    def self.xml
      '<alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace"> <bob>david</bob> <charlie:edgar>frank</charlie:edgar> </alice>'
    end
  end
  # rubocop:enable Layout/LineLength

  class CustomExampleMultipleTextNodes
    def self.json
      '{"alice":{"$1":"bob","charlie":{"$1":"bob2"},"$2":"bob3"}}'
    end

    def self.xml
      '<alice>bob<charlie>bob2</charlie>bob3</alice>'
    end
  end

  class CustomExampleComment
    def self.json
      '{"alice":{"!1":"my comment"}}'
    end

    def self.xml
      '<alice><!--my comment--></alice>'
    end
  end

  class CustomExampleCommentWhitespace
    def self.json
      '{"alice":{"!1":" my comment "}}'
    end

    def self.xml
      '<alice><!-- my comment --></alice>'
    end
  end

  class CustomExampleCdata
    def self.json
      '{"alice":{"#1":"<bob></bob>"}}'
    end

    def self.xml
      '<alice><![CDATA[<bob></bob>]]></alice>'
    end
  end

  class CustomExampleLargerArray
    def self.json
      '{ "alice": { "bob" : [{"$1": "charlie" }, {"$1": "david" }, {"$1": "edgar" }] } }'
    end

    def self.xml
      '<alice><bob>charlie</bob><bob>david</bob><bob>edgar</bob></alice>'
    end
  end

  class CustomExampleCdataEmpty
    def self.json
      '{"alice":{"#1":""}}'
    end

    def self.xml
      '<alice><![CDATA[]]></alice>'
    end
  end

  class CustomExampleCdataIntentionalWhitespace
    def self.json
      '{"alice":{"#1":"   "}}'
    end

    def self.xml
      '<alice><![CDATA[   ]]></alice>'
    end
  end

  class CustomExampleFormattedXml
    def self.json
      '{"alice":{"bob":{"$1":"charlie"}}}'
    end

    def self.xml
      <<~XML
        <alice>
          <bob>
            charlie
          </bob>
        </alice>
      XML
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
