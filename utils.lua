function math.clamp(num, min, max)
	return math.max(min, math.min(num, max))
end

function math.norm(num, min, max)
	return (num - min) / (max - min)
end

function math.lerp(num, min, max)
	return min + (max - min) * num
end

function display_info()
	local fps = love.timer.getFPS()

	-- 计算文本宽度用于背景框
	local text = "FPS: " .. fps .. "\n" .. "HITS: " .. globals.hit_count .. "\n" .. "HP: " .. globals.health

	-- local textWidth = fonts.small:getWidth(text)
	-- local textHeight = fonts.small:getHeight()

	-- -- 绘制半透明背景框
	-- love.graphics.setColor(0, 0, 0, 0.5)
	-- love.graphics.rectangle("fill", 8, 8, textWidth + 4, textHeight + 4)

	-- 绘制FPS文本（绿色）
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.setFont(fonts.small)
	love.graphics.print(text, 8, 8)

	-- 重置颜色为白色，避免影响其他绘制
	love.graphics.setColor(1, 1, 1, 1)
end
