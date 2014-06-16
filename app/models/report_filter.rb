class ReportFilter

  def initialize(params)
    start_date  = params[:start_date]
    end_date    = params[:end_date]

    order       = params[:order]
    order       = order.present? ? order : 'desc' && params[:order] = 'desc'
    @order      = "created_at #{order}"

    @start_date = Date.parse(start_date).end_of_day if start_date.present?
    @end_date   = Date.parse(end_date).end_of_day if end_date.present?
  end

  def query
    if defined?(@start_date) && defined?(@end_date)
      reports = completed_reports.where('Date(created_at) >= ? and Date(created_at) <= ?', @start_date, @end_date)
    elsif defined?(@start_date)
      reports = completed_reports.where('Date(created_at) >= ?', @start_date)
    elsif defined?(@end_date)
      reports = completed_reports.where('Date(created_at) <= ?', @end_date)
    else
      reports = completed_reports.where(@params)
    end
    reports.order(@order)
  end

private

  def completed_reports
    Report.completed
  end

end
