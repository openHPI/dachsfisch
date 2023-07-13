# frozen_string_literal: true

# Examples from http://www.sklar.com/badgerfish/
module Examples
  class ExampleBase
    def self.test_directions
      %i[xml2json json2xml]
    end
  end

  class Example2 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "$1": "bob"
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>bob</alice>
      XML
    end
  end

  class Example3 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "bob": {
              "$1": "charlie"
            },
            "david": {
              "$1": "edgar"
            }
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>
          <bob>charlie</bob>
          <david>edgar</david>
        </alice>
      XML
    end
  end

  class Example4 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "bob": [
              {
                "$1": "charlie"
              },
              {
                "$1": "david"
              }
            ]
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>
          <bob>charlie</bob>
          <bob>david</bob>
        </alice>
      XML
    end
  end

  class Example5 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "$1": "bob",
            "@charlie": "david"
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice charlie="david">bob</alice>
      XML
    end
  end

  class Example7 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "$1": "bob",
            "@xmlns": {
              "$": "http://some-namespace"
            }
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice xmlns="http://some-namespace">bob</alice>
      XML
    end
  end

  class Example8 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "$1": "bob",
            "@xmlns": {
              "$": "http://some-namespace",
              "charlie": "http://some-other-namespace"
            }
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace">bob</alice>
      XML
    end
  end

  class Example9 < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "bob": {
              "$1": "david",
              "@xmlns": {
                "charlie": "http://some-other-namespace",
                "$": "http://some-namespace"
              }
            },
            "charlie:edgar": {
              "$1": "frank",
              "@xmlns": {
                "charlie": "http://some-other-namespace",
                "$": "http://some-namespace"
              }
            },
            "@xmlns": {
              "charlie": "http://some-other-namespace",
              "$": "http://some-namespace"
            }
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace">
          <bob>david</bob>
          <charlie:edgar>frank</charlie:edgar>
        </alice>
      XML
    end
  end

  class CustomExampleMultipleTextNodes < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "$1": "bob",
            "charlie": {
              "$1": "bob2"
            },
            "$2": "bob3"
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>bob<charlie>bob2</charlie>bob3</alice>
      XML
    end
  end

  class CustomExampleComment < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "!1": "my comment"
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>
          <!--my comment-->
        </alice>
      XML
    end
  end

  class CustomExampleCommentWhitespace < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "!1": " my comment "
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>
          <!-- my comment -->
        </alice>
      XML
    end
  end

  class CustomExampleLargerArray < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "bob": [
              {
                "$1": "charlie"
              },
              {
                "$1": "david"
              },
              {
                "$1": "edgar"
              }
            ]
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>
          <bob>charlie</bob>
          <bob>david</bob>
          <bob>edgar</bob>
        </alice>
      XML
    end
  end

  class CustomExampleEmptyNodeWithAttribute < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "bob": {
              "@foo": "bar"
            }
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>
          <bob foo="bar"/>
        </alice>
      XML
    end
  end

  class CustomExampleCdata < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "#1": "<bob></bob>"
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice><![CDATA[<bob></bob>]]></alice>
      XML
    end
  end

  class CustomExampleCdataEmpty < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "#1": ""
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice><![CDATA[]]></alice>
      XML
    end
  end

  class CustomExampleCdataIntentionalWhitespace < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "#1": "   "
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice><![CDATA[   ]]></alice>
      XML
    end
  end

  class CustomExampleFormattedXml < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "bob": {
              "$1": "charlie"
            }
          }
        }
      JSON
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

  class CustomExampleNumber < ExampleBase
    def self.test_directions
      [:json2xml]
    end

    def self.json
      <<~JSON
        {
          "alice": {
            "$1": 1
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <alice>1</alice>
      XML
    end
  end

  class CustomExampleNestedXMLNS < ExampleBase
    def self.json
      <<~JSON
        {
          "alice": {
            "@xmlns": {
              "$": "http://some-namespace"
            },
            "bob": {
              "@xmlns": {
                "$": "http://some-other-namespace"
              },
              "$1": "charlie"
            }
          }
        }
      JSON
    end

    def self.xml
      <<~XML
        <alice xmlns="http://some-namespace">
          <bob xmlns="http://some-other-namespace">charlie</bob>
        </alice>
      XML
    end
  end

  class CustomExampleNamespaceOnRoot < ExampleBase
    def self.json
      <<~JSON
        {
          "bob:alice": {
            "@xmlns": {
              "bob": "http://some-other-namespace"
            },
            "$1": "charlie"
          }
        }
      JSON
    end

    def self.xml
      <<-XML
        <bob:alice xmlns:bob="http://some-other-namespace">charlie</bob:alice>
      XML
    end
  end

  def self.all
    constants.filter_map do |constant|
      c = const_get(constant)
      c if c.is_a?(Class) && c != ExampleBase
    end
  end

  def self.each(direction, &)
    all.filter {|c| c.test_directions.include? direction }.each(&)
  end
end
