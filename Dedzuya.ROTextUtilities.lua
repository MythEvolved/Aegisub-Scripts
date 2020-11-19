script_name = "RO Text Utilities"
script_description = "A bunch of functions for romanian languages. Functionalities: changes the wrong diacritics with the right ones; changes '--' to '—'."
script_author = "KazuyaShuu"
script_version = "1.0.1"

function change_diacritics(subs, sel, active)
    for i = 1, #subs do
        if subs[i].class == "dialogue" then
			local line = subs[i]
			line.text = line.text:gsub("ã", "ă")
			line.text = line.text:gsub("º", "ș")
			line.text = line.text:gsub("þ", "ț")
			line.text = line.text:gsub("Ã", "Ă")
			line.text = line.text:gsub("ª", "Ș")
			line.text = line.text:gsub("Þ", "Ț")
			line.text = line.text:gsub("ş", "ș")
			line.text = line.text:gsub("ţ", "ț")
			line.text = line.text:gsub("Ş", "Ș")
			line.text = line.text:gsub("Ţ", "Ț")
			subs[i] = line
		end
    end
end

function en_dash(subs, sel, active)
	for i = 1, #subs do
		if subs[i].class == "dialogue" then
			local line = subs[i]
			line.text = line.text:gsub("%-%-", "—")
			subs[i] = line
		end
	end
end

function GUI(subs, sel, active)
	display_config=
	{
		{x=0,y=0,class="checkbox",name="Romanian Diacritics",label="Romanian Diacritics"},
		{x=0,y=1,class="checkbox",name="En-dash",label="En-dash"}
	}
	buttons={"OK","Cancel"}

	pressed, results = aegisub.dialog.display(display_config, buttons)
	
	if pressed=="Cancel" then
		aegisub.cancel()
	end
	
	if results["Romanian Diacritics"] == true then
		change_diacritics(subs, sel, active)
	end
	if results["En-dash"] == true then
		en_dash(subs, sel, active)
	end
	aegisub.set_undo_point(script_name)
end

aegisub.register_macro(script_name, script_description, GUI)