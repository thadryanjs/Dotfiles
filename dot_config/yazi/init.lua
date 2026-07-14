-- You can configure your bookmarks by lua language
local bookmarks = {
  { tag = "Vaults", path = "~/Vaults/Projects", key = "v" },
  { tag = "Dotfiles", path = "~/Vaults/Projects/Dotfiles", key = "d" },
  { tag = "SurgicalRobots", path = "~/Vaults/Projects/Work/Primary/SurgicalRobots/LapVsRobo/code", key = "l" },
  { tag = "TheoryProject", path = "~/Vaults/Projects/Work/Primary/TheoryProject", key = "t" },
  { tag = "RCD", path = "~/Vaults/Projects/Work/Primary/RCD", key = "r" },
  { tag = "WorkAdmin", path = "~/Vaults/Projects/Work/Primary/WorkAdmin", key = "a" },
  { tag = "Knowledge", path = "~/Vaults/Knowledge", key = "k" },
  { tag = "HomeAdmin", path = "~/Vaults/Home/Projects/HomeAdmin", key = "h" },
  { tag = "LearnLean", path = "~/Vaults/Projects/Work/Secondary/LearnLean", key = "L" },
  { tag = "SmokingMetaanalysis", path = "~/Vaults/Projects/Work/Secondary/SmokingMetaanalysis", key = "S" },
  { tag = "INFORMSLogistics", path = "~/Vaults/Projects/Work/Secondary/INFORMSLogistics", key = "I" },
  { tag = "Workflow", path = "~/Vaults/Projects/Work/Secondary/Workflow", key = "W" },
  { tag = "Scripts", path = "~/Vaults/Projects/Tools/Scripts", key = "s" },
  { tag = "ProofPractice", path = "~/Vaults/Projects/Work/Primary/ProofPractice", key = "P" },
}

require("whoosh"):setup {
  bookmarks = bookmarks,
  jump_notify = false,
}

