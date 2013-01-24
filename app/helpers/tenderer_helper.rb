module TendererHelper

  def winning_rate(tenderer)
    rate = sprintf( "%.1f", ((tenderer.winning_tender_infos_count) / (tenderer.tender_infos_count).to_f)*100)
    "#{rate}% (#{tenderer.winning_tender_infos_count}/#{tenderer.tender_infos_count})"
  end
end
