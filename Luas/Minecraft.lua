--created by fiji (modified for toggling)

local Minecraft = {}
Minecraft.Enabled = false
Minecraft.OriginalMaterials = {}

local faces = {"Front", "Back", "Bottom", "Top", "Right", "Left"}
local materials = {
	{"Wood", "3258599312"}, {"WoodPlanks", "8676581022"},
	{"Brick", "8558400252"}, {"Cobblestone", "5003953441"},
	{"Concrete", "7341687607"}, {"DiamondPlate", "6849247561"},
	{"Fabric", "118776397"}, {"Granite", "4722586771"},
	{"Grass", "4722588177"}, {"Ice", "3823766459"},
	{"Marble", "62967586"}, {"Metal", "62967586"},
	{"Sand", "152572215"}
}

local function texture(ins, id)
	for _, v in pairs(faces) do
		local t = Instance.new("Texture", ins)
		t.ZIndex = 2147483647
		t.Texture = "rbxassetid://" .. id
		t.Face = Enum.NormalId[v]
		t.Color3 = ins.Color
		t.Transparency = ins.Transparency
	end
end

function Minecraft:Enable()
	if self.Enabled then return end
	self.Enabled = true

	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") then
			self.OriginalMaterials[part] = part.Material
			for _, v in pairs(materials) do
				if part.Material.Name == v[1] then
					texture(part, v[2])
					part.Material = Enum.Material.SmoothPlastic
				end
			end
		end
	end
end

function Minecraft:Disable()
	if not self.Enabled then return end
	self.Enabled = false

	for part, mat in pairs(self.OriginalMaterials) do
		if part and part.Parent then
			part.Material = mat
			for _, tex in pairs(part:GetChildren()) do
				if tex:IsA("Texture") then
					tex:Destroy()
				end
			end
		end
	end

	self.OriginalMaterials = {}
end

return Minecraft
