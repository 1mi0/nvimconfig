return function(defaults, settings)
	local result = {}
  for k, v in pairs(defaults) do
    if settings[k] ~= nil then
      result[k] = settings[k]
    else
      result[k] = v
    end
  end
	return result
end
