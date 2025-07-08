class Admin::SearchBuildingsService
  def initialize(query:, page:)
    @query = query.to_s&.strip
    @page = page
  end

  def call
    pattern = "%#{@query&.strip}%"

    buildings = Building.order("number").page(@page)

    if @query.present?
      buildingsByNumber = buildings.where("CAST(number AS TEXT) ILIKE :q OR name ILIKE :q", q: pattern)
      buildings = buildingsByNumber.order("number").page(@page)
      buildings
    end
    
    buildings
  end
end
