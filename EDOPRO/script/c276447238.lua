--Virtual World
local s,id=GetID()
function s.initial_effect(c)
	aux.EnableExtraRules(c,s,s.VirtualWorldStart)
end

function s.VirtualWorldStart()
	--Faceup Def
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_LIGHT_OF_INTERVENTION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
	
	-- Deck Master
	local dm=Duel.CreateToken(0,153000000)
	Duel.ConfirmCards(1,dm)
	if Duel.SelectYesNo(0,aux.Stringid(id,0)) and Duel.SelectYesNo(1,aux.Stringid(id,0)) then
		Duel.Hint(HINT_CARD,0,153000000)
		Duel.Hint(HINT_OPSELECTED,0,aux.Stringid(id,1))
		Duel.Hint(HINT_OPSELECTED,1,aux.Stringid(id,1))
		DeckMaster.RegisterRules(dm)
	else
		Duel.Hint(HINT_OPSELECTED,0,aux.Stringid(id,2))
		Duel.Hint(HINT_OPSELECTED,1,aux.Stringid(id,2))
	end

	-- Allow Pendulum monsters to be summoned from the Extra Deck to the Main Monster Zone
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_PENDULUM_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetTargetRange(1,1)
	e2:SetCondition(s.pendcon)
	Duel.RegisterEffect(e2,0)
end

function s.pendcon(e,c)
	return c:IsType(TYPE_PENDULUM) and c:IsLocation(LOCATION_EXTRA)
end

-- Additional effect to allow Pendulum Summon from Extra Deck to Main Monster Zone
function s.initial_effect(c)
	aux.EnableExtraRules(c,s,s.VirtualWorldStart)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC_G)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(s.pendcon2)
	c:RegisterEffect(e2)
end

function s.pendcon2(e,c,tp)
	return c:IsType(TYPE_PENDULUM) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
