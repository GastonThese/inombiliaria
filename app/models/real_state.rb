class RealState < Property
  belongs_to :owner, class_name: "User", optional: true
  belongs_to :tenant, class_name: "User", optional: true

  validates :number, presence: true

  def type
    :real_state
  end
end
