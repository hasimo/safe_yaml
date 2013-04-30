require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe SafeYAML::Transform do
  it "should return the same encoding when decoding Base64" do
    value = "c3VyZS4="
    decoded = SafeYAML::Transform.to_proper_type(value, false, "!binary")

    decoded.should == "sure."
    decoded.encoding.should == value.encoding if decoded.respond_to?(:encoding)
  end

  it "should return String when adding the str tag" do
    value = "2002-04-28"
    decoded = SafeYAML::Transform.to_proper_type(value, false, "!str")

    decoded.should == value

    decoded = SafeYAML::Transform.to_proper_type(value, false, "tag:yaml.org,2002:str")
    decoded.should == value
  end
  
  it "should return Float when adding the float tag" do
    value = "1.999"
    expect = 1.999
    decoded = SafeYAML::Transform.to_proper_type(value, true, "!float")

    decoded.should == expect

    decoded = SafeYAML::Transform.to_proper_type(value, true, "tag:yaml.org,2002:float")
    decoded.should == expect
  end
end
