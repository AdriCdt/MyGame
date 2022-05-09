game.ReplicatedStorage.Flag.OnServerEvent:Connect(function (plr, char)
	
	
	for _, flag in ipairs(workspace.FlagCapture:GetChildren()) do
		if (flag.Base.Position - char.HumanoidRootPart.Position).Magnitude <= 10 then
			
			local name = game.Workspace.FlagCapture.FlagCapture.FlagSettings.name
			
			if name.Value ~= ""..plr.Name then
				
				name.Value = ""..plr.Name
				flag.Flag.Decal.Texture = "".. plr.Name
				flag.Flag.Decal2.Texture = "".. plr.Name
				flag.PlayerName.BillboardGui.TextLabel.Text = ""..plr.Name
				flag.Flag.BodyPosition.Position = flag.Start.Position
				flag.Flag.Color = Color3.new(math.random(0,255), math.random(0,255), math.random(0,255))
				
				wait(2.5)
				
				flag.Flag.BodyPosition.Position = flag.End.Position
				
				repeat wait(game.Workspace.FlagCapture.FlagCapture.FlagSettings.Time.Value)
					
					local amount = game.Workspace.FlagCapture.FlagCapture.FlagSettings.Amount.Value
					
					game.Players[name.Value].leaderstats.Fame.Value = game.Players[name.Value].leaderstats.Fame.Value + amount
					
					print("New fame value: ".. game.Players[name.Value].leaderstats.Fame.Value)
					
				until name.Value ~= ""..plr.Name
				
				else
			end
		end
	end
end)
