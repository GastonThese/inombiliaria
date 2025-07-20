class Admin::SearchRealStatesService
  attr_reader :query, :page

  def initialize(query:, page:, current_user: nil)
    @query = query.to_s&.strip
    @page = page
  end

  def call
    pattern = "%#{@query&.strip}%"

    real_states = RealState.order('number').page(@page)

    if @query.present?
      real_statesByNumber = real_states.where('CAST(number AS TEXT) ILIKE :q', q: pattern)
      real_states = real_statesByNumber.order('number').page(@page)
      real_states
    end

    real_states
  end
end
