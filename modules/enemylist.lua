local EnemyList = {
    { Name = "Bandit", Level = 5, Position = Vector3.new(1038, 17, 1547) },
    { Name = "Monkey", Level = 10, Position = Vector3.new(-1342, 6, 473) },
    { Name = "Gorilla", Level = 20, Position = Vector3.new(-1127, 40, -525) },
    { Name = "Pirate", Level = 30, Position = Vector3.new(-2845, 7, 5350) },
    { Name = "Brute", Level = 45, Position = Vector3.new(-3956, 14, 5269) },
    { Name = "Desert Bandit", Level = 60, Position = Vector3.new(932, 7, 4488) },
    { Name = "Desert Officer", Level = 70, Position = Vector3.new(1572, 7, 4376) },
    { Name = "Snow Bandit", Level = 90, Position = Vector3.new(1357, 87, -1325) },
    { Name = "Snowman", Level = 100, Position = Vector3.new(1211, 138, -1513) },
    { Name = "Chief Petty Officer", Level = 120, Position = Vector3.new(-4855, 21, 4307) },
    { Name = "Sky Bandit", Level = 150, Position = Vector3.new(-4970, 278, -2867) },
    { Name = "Dark Master", Level = 175, Position = Vector3.new(-5251, 389, -2272) },
    { Name = "Prisoner", Level = 190, Position = Vector3.new(5010, 38, 474) },
    { Name = "Dangerous Prisoner", Level = 210, Position = Vector3.new(5315, 38, 474) },
    { Name = "Toga Warrior", Level = 250, Position = Vector3.new(-1760, 7, -2745) },
    { Name = "Gladiator", Level = 275, Position = Vector3.new(-1455, 7, -3215) },
    { Name = "Military Soldier", Level = 300, Position = Vector3.new(-5400, 8, 8430) },
    { Name = "Military Spy", Level = 325, Position = Vector3.new(-5786, 8, 8828) },
    { Name = "Fishman Warrior", Level = 375, Position = Vector3.new(61123, 18, 1569) },
    { Name = "Fishman Commando", Level = 400, Position = Vector3.new(61884, 18, 1472) },
    { Name = "Warden", Level = 425, Position = Vector3.new(5295, 38, 477) },
    { Name = "Chief Warden", Level = 450, Position = Vector3.new(5247, 38, 798) },
    { Name = "Swan", Level = 475, Position = Vector3.new(5324, 38, 652) },
    { Name = "Magma Admiral", Level = 500, Position = Vector3.new(-5247, 7, 8468) },
    { Name = "Vice Admiral", Level = 550, Position = Vector3.new(-5121, 8, 4030) },
    { Name = "Marine Captain", Level = 625, Position = Vector3.new(2227, 73, 4449) },
    { Name = "Marine Rear Admiral", Level = 650, Position = Vector3.new(2972, 73, 4240) },
    { Name = "Cyborg", Level = 675, Position = Vector3.new(60791, 18, -6374) },
    { Name = "God's Guard", Level = 700, Position = Vector3.new(-4631, 845, -1937) },
}

function EnemyList.GetEnemyByLevel(playerLevel)
    local target = nil
    for _, enemy in ipairs(EnemyList) do
        if playerLevel >= enemy.Level then
            target = enemy
        else
            break
        end
    end
    return target
end

return EnemyList
