-- Code Change
function c276447233.initial_effect(c)
    -- Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c276447233.target)
    e1:SetOperation(c276447233.activate)
    c:RegisterEffect(e1)
end

function c276447233.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE) -- Cambiado a HINTMSG_ATTRIBUTE para selección de tipo
    local t=c276447233.AnnounceType(tp)
    e:SetLabel(t)
end

function c276447233.activate(e,tp,eg,ep,ev,re,r,rp)
    local t=e:GetLabel()
    local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    for tc in aux.Next(g) do
        local i=0
        while i<tc:GetCardEffectCount() do
            local te=tc:GetCardEffect(i)
            if te then
                local category=te:GetCategory()
                if category and bit.band(category, TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)~=0 then
                    local new_category = bit.bor(bit.band(category, ~(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)), t)
                    te:SetCategory(new_category)
                end
            end
            i=i+1
        end
    end
end

function c276447233.AnnounceType(tp)
    -- Esta función debe devolver el tipo declarado por el jugador (TYPE_MONSTER, TYPE_SPELL, TYPE_TRAP)
    local types = {TYPE_MONSTER, TYPE_SPELL, TYPE_TRAP}
    local opt=Duel.SelectOption(tp,aux.Stringid(276447233,0),aux.Stringid(276447233,1),aux.Stringid(276447233,2))
    return types[opt+1]
end
