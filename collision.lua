function Collision(objects)
	local collision = {}

	collision.objects = objects or {}

	function collision.update()
		collision.handle_player_wall_collision()
	end

	function collision.handle_player_wall_collision()
		local player = collision.objects.player
		local right_wall = collision.objects.right_wall
		local left_wall = collision.objects.left_wall

		if collision.AABB(player, right_wall) then
			player.pos.x = WIDTH - player.w
		end

		if collision.AABB(player, left_wall) then
			player.pos.x = 0
		end
	end

	function collision.AABB(obj1, obj2)
		return (
			obj1.pos.x < obj2.pos.x + obj2.w
			and obj1.pos.x + obj1.w > obj2.pos.x
			and obj1.pos.y < obj2.pos.y + obj2.h
			and obj1.pos.y + obj1.h > obj2.pos.y
		)
	end

	return collision
end
