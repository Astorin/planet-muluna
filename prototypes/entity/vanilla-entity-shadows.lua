if settings.startup["muluna-separate-shadows"].value == true then
    local rro = require("lib.remove-replace-object")

    local pipe_ground = table.deepcopy(data.raw["pipe-to-ground"]["pipe-to-ground"])
    local new_pictures = {}
    local send_new_pictures = true
    for key,picture in pairs(pipe_ground.pictures) do
        local old_picture = table.deepcopy(pipe_ground.pictures[key])
        --local new_layers = {old_picture}
        -- old_picture.filename = __base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png
        local new_filename_shadow = string.gsub(old_picture.filename,"__base__/graphics/entity","__muluna-graphics__/graphics/entities")
        local new_filename = string.gsub(old_picture.filename,"__base__/graphics","__muluna-graphics__/graphics")
        local new_filename_shadow = string.gsub(new_filename,"/pipe%-to%-ground/","/pipe-to-ground-shadow/")
        log(new_filename)
        log(new_filename_shadow)
        --assert(new_filename ~= old_picture.filename,new_filename)
        --assert(new_filename_shadow ~= new_filename,new_filename_shadow)
        if new_filename ~= old_picture.filename and new_filename_shadow ~= new_filename then
            local new_layers = {
                {
                    filename = new_filename,
                    priority = "extra-high",
                    width = 128,
                    height = 128,
                    scale = 0.5,
                },
            {
                filename = new_filename_shadow,
                priority = "extra-high",
                width = 128,
                height = 128,
                scale = 0.5,
                draw_as_shadow = true
            }
            }
            
            new_pictures[key] = {layers = new_layers}
        else
            send_new_pictures = false
        end

    end


    if send_new_pictures == true then
        pipe_ground.pictures = new_pictures
    end



    data:extend{pipe_ground}

    local pipe = table.deepcopy(data.raw["pipe"]["pipe"])
    local new_pictures = {}
    local send_new_pictures = true
    for key,picture in pairs(pipe.pictures) do
        local old_picture = table.deepcopy(pipe.pictures[key])
        --local new_layers = {old_picture}
        -- old_picture.filename = __base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png
        --local new_filename_shadow = string.gsub(old_picture.filename,"__base__/graphics/entity","__muluna-graphics__/graphics/entities")
        local excluded_keys = {
            "horizontal_window_background",
            "vertical_window_background",
            "fluid_background",
            "low_temperature_flow",
            "middle_temperature_flow",
            "high_temperature_flow",
            "gas_flow",

        }
        if rro.contains(excluded_keys,key) or string.find(key,"frozen") or string.find(key,"visualization") then
            new_pictures[key] = old_picture
        else
            local new_filename = string.gsub(old_picture.filename,"__base__/graphics","__muluna-graphics__/graphics")
            local new_filename_shadow = string.gsub(new_filename,"/pipe/","/pipe-shadow/")
            log(new_filename)
            log(new_filename_shadow)
            --assert(new_filename ~= old_picture.filename,new_filename)
            --assert(new_filename_shadow ~= new_filename,new_filename_shadow)
            if new_filename ~= old_picture.filename and new_filename_shadow ~= new_filename then
                local new_layers = {
                    {
                        filename = new_filename,
                        priority = "extra-high",
                        width = 128,
                        height = 128,
                        scale = 0.5,
                    },
                {
                    filename = new_filename_shadow,
                    priority = "extra-high",
                    width = 128,
                    height = 128,
                    scale = 0.5,
                    draw_as_shadow = true
                }
                }
                
                new_pictures[key] = {layers = new_layers}
            else
                send_new_pictures = false
            end
        end

    end


    if send_new_pictures == true then
        pipe.pictures = new_pictures
    end



    data:extend{pipe}


end