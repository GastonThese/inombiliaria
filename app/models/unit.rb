class Unit < Property
  belongs_to :building
  belongs_to :owner, class_name: "User", optional: true
  belongs_to :tenant, class_name: "User", optional: true


  def type
    :unit
  end
end
