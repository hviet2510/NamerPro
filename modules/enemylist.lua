local EnemyList = {
    -- Starter Island
    {Name = "Bandit", MinLevel = 1, MaxLevel = 10, QuestName = "BanditQuest1", QuestLevel = 1, QuestPos = Vector3.new(1060, 17, 1547)},
    
    -- Jungle
    {Name = "Monkey", MinLevel = 11, MaxLevel = 20, QuestName = "JungleQuest", QuestLevel = 1, QuestPos = Vector3.new(-1600, 36, 145)},
    {Name = "Gorilla", MinLevel = 21, MaxLevel = 30, QuestName = "JungleQuest", QuestLevel = 2, QuestPos = Vector3.new(-1600, 36, 145)},

    -- Pirate Village
    {Name = "Brute", MinLevel = 31, MaxLevel = 40, QuestName = "BuggyQuest1", QuestLevel = 1, QuestPos = Vector3.new(-1140, 5, 3825)},
    {Name = "Pirate", MinLevel = 41, MaxLevel = 60, QuestName = "BuggyQuest1", QuestLevel = 2, QuestPos = Vector3.new(-1140, 5, 3825)},

    -- Desert
    {Name = "Desert Bandit", MinLevel = 61, MaxLevel = 75, QuestName = "DesertQuest", QuestLevel = 1, QuestPos = Vector3.new(896, 7, 4485)},
    {Name = "Desert Officer", MinLevel = 76, MaxLevel = 90, QuestName = "DesertQuest", QuestLevel = 2, QuestPos = Vector3.new(896, 7, 4485)},

    -- Frozen Village
    {Name = "Snow Bandit", MinLevel = 91, MaxLevel = 105, QuestName = "SnowQuest", QuestLevel = 1, QuestPos = Vector3.new(1389, 38, -1297)},
    {Name = "Snowman", MinLevel = 106, MaxLevel = 120, QuestName = "SnowQuest", QuestLevel = 2, QuestPos = Vector3.new(1389, 38, -1297)},

    -- Marine Fortress
    {Name = "Trainee", MinLevel = 121, MaxLevel = 150, QuestName = "MarineQuest2", QuestLevel = 1, QuestPos = Vector3.new(-5035, 28, 4327)},
    {Name = "Enforcer", MinLevel = 151, MaxLevel = 175, QuestName = "MarineQuest2", QuestLevel = 2, QuestPos = Vector3.new(-5035, 28, 4327)},
    {Name = "Vice Admiral", MinLevel = 176, MaxLevel = 190, QuestName = "MarineQuest2", QuestLevel = 3, QuestPos = Vector3.new(-5035, 28, 4327)},

    -- Skylands
    {Name = "Sky Bandit", MinLevel = 191, MaxLevel = 210, QuestName = "SkyQuest", QuestLevel = 1, QuestPos = Vector3.new(-4842, 717, -2622)},
    {Name = "Dark Master", MinLevel = 211, MaxLevel = 250, QuestName = "SkyQuest", QuestLevel = 2, QuestPos = Vector3.new(-4842, 717, -2622)},

    -- Coliseum
    {Name = "Gladiator", MinLevel = 251, MaxLevel = 275, QuestName = "ColosseumQuest", QuestLevel = 1, QuestPos = Vector3.new(-1820, 11, -2742)},
    {Name = "Military Soldier", MinLevel = 276, MaxLevel = 300, QuestName = "ColosseumQuest", QuestLevel = 2, QuestPos = Vector3.new(-1820, 11, -2742)},

    -- Magma Village
    {Name = "Military Spy", MinLevel = 301, MaxLevel = 325, QuestName = "MagmaQuest", QuestLevel = 1, QuestPos = Vector3.new(-5310, 12, 8510)},
    {Name = "Magma Admiral", MinLevel = 326, MaxLevel = 350, QuestName = "MagmaQuest", QuestLevel = 2, QuestPos = Vector3.new(-5310, 12, 8510)},

    -- Underwater City
    {Name = "Fishman Warrior", MinLevel = 351, MaxLevel = 400, QuestName = "FishmanQuest", QuestLevel = 1, QuestPos = Vector3.new(61123, 19, 1569)},
    {Name = "Fishman Commando", MinLevel = 401, MaxLevel = 450, QuestName = "FishmanQuest", QuestLevel = 2, QuestPos = Vector3.new(61123, 19, 1569)},

    -- Fountain City
    {Name = "Galley Pirate", MinLevel = 451, MaxLevel = 525, QuestName = "FountainQuest", QuestLevel = 1, QuestPos = Vector3.new(5257, 38, 4049)},
    {Name = "Galley Captain", MinLevel = 526, MaxLevel = 700, QuestName = "FountainQuest", QuestLevel = 2, QuestPos = Vector3.new(5257, 38, 4049)},
}

return EnemyList
