local rro = require("lib.remove-replace-object")
if data.raw["technology"]["planet-discovery-corrundum"] then
    --rro.replace(data.raw["technology"]["planet-discovery-corrundum"].prerequisites,"space-science-pack","asteroid-collector")
    if data.raw["boiler"]["red-boiler"] then
        data.raw["boiler"]["red-boiler"].surface_conditions = {
            {
                property="oxygen",
                min=1,
            }
        }
    end
    require("prototypes.technology.electrochemical-techs")
end

if data.raw["generator"]["red-steam-engine"] then 
    data.raw["generator"]["red-steam-engine"].energy_source.emissions_per_minute.pollution = 20
end
-- if data.raw["technology"]["platinum-thruster"] then
--     rro.soft_insert(data.raw["technology"]["platinum-thruster"].prerequisites,"interstellar-science-pack")
-- end

