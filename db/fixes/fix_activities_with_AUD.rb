Activity.find_all_by_new_spend_currency("AUD").each { |a| puts " #{a.id}: #{a.currency} (#{a.project.currency}) (#{a.data_response.currency}) "; p = a.project ; p.currency = p.data_response.currency; p.save!; a.save!; a.code_splits.each {|ca| ca.save!} }

#
#  log
# 4733: AUD (AUD) (RWF)
# 4737: AUD (AUD) (RWF)
# 4437: RWF (RWF) (RWF)
# 4438: RWF (RWF) (RWF)
# 4443: RWF (RWF) (RWF)
# 4436: RWF (RWF) (RWF)
# 4442: RWF (RWF) (RWF)
# 4444: RWF (RWF) (RWF)
# 4441: RWF (RWF) (RWF)
# 4478: RWF (RWF) (RWF)
# 4479: RWF (RWF) (RWF)
# 4469: RWF (RWF) (RWF)
# 4483: RWF (RWF) (RWF)
# 4477: RWF (RWF) (RWF)
# 4481: RWF (RWF) (RWF)
# 4482: RWF (RWF) (RWF)
# 4480: RWF (RWF) (RWF)
# 4670: RWF (RWF) (RWF)
# 4674: RWF (RWF) (RWF)
# 4684: RWF (RWF) (RWF)
# 4691: RWF (RWF) (RWF)
# 4666: RWF (RWF) (RWF)
# 4667: RWF (RWF) (RWF)
# 4669: RWF (RWF) (RWF)
# 4671: RWF (RWF) (RWF)
# 4673: RWF (RWF) (RWF)
# 4676: RWF (RWF) (RWF)
# 4678: RWF (RWF) (RWF)
# 4681: RWF (RWF) (RWF)
# 4683: RWF (RWF) (RWF)
# 4685: RWF (RWF) (RWF)
# 4687: RWF (RWF) (RWF)
# 4690: RWF (RWF) (RWF)
# 4692: RWF (RWF) (RWF)
# 4693: RWF (RWF) (RWF)
# 4694: RWF (RWF) (RWF)
# 4696: RWF (RWF) (RWF)
# 4695: RWF (RWF) (RWF)
# 4697: RWF (RWF) (RWF)
# 4722: RWF (RWF) (RWF)
# 4717: RWF (RWF) (RWF)
# 4718: RWF (RWF) (RWF)
# 4721: RWF (RWF) (RWF)
# 4731: RWF (RWF) (RWF)
# 4719: RWF (RWF) (RWF)
# 4720: RWF (RWF) (RWF)
# 4723: RWF (RWF) (RWF)
