require 'payjp'

if Rails.env.development?
  # SSL error ကို ကျော်ဖြတ်ရန် (Development mode အတွက်သာ)
  # ဤနည်းလမ်းသည် ca_bundle_path ထက် ပိုမိုသေချာပါသည်
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end