
---- VARIABLER ----
h = 7.6--høyde | meter
m = 0.43--masse | kg
g = 9.81--gravitasjonsakseleraksjon | meter/sekund^2
k = 0.1--luftkonstant

v = 0--startfart | meter/sekund
t = 0--starttid
dt = 0.001--tidssteg

---- FUNKSJONER ----
function akselerasjon(luftmotstand)
    if luftmotstand == true then
        fsum = m*g - k * v^2--sum av krefter
        aks = fsum / m--akselerasjon
        return aks
    elseif luftmotstand == false then
        return g
    else
        error("luftmotstand-variabel opgitt i feil type")
    end
end

function falltid(h,luftmotstand)
    a = akselerasjon(luftmotstand)
    local h = h
    if luftmotstand == true then
        while h > 0 do
            a = akselerasjon(luftmotstand)
            v = v + a * dt--nåværende hastighet
            h = h - v * dt--gjenværende høyden
            t = t + dt--gjenværende tid

            if h <= 0 then
                break
            end
        end
        return t
    elseif luftmotstand == false then
        return math.sqrt(2 * h / a)
    else
        error("luftmotstand-variabel opgitt i feil type")
    end
end

function avrund(a,b)
    return math.floor(a * b + 0.5) / b
end

---- HOVEDDEL ----
falltidingenluft = falltid(h,false)
falltidmedluft = falltid(h,true)

absforskjell = math.abs(falltidingenluft - falltidmedluft)
prosentavvik = (absforskjell / falltidingenluft) * 100

print("----  ----\n")

print("Det tar ballen "..avrund(falltidingenluft,10).." sekunder til bakken uten luftmotstand.")
print("Derimot tar det "..avrund(falltidmedluft,10).." sekunder til bakken med luftmotstand")

print("Absolutt forskjell mellom disse er "..avrund(absforskjell,10))
print("Prosentvis avvik mellom disse er "..avrund(prosentavvik,10).."%")