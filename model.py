from dataclasses import dataclass
import json
from typing import List




@dataclass
class Uporabnik:
    uporabnisko_ime: str
    zasifrirano_geslo: str
    igre: list

    @staticmethod
    def zasifriraj_geslo(geslo_v_cistopisu):
        return "XXX" + geslo_v_cistopisu[::-1] + "XXX"

    def v_slovar(self):
        return {
            "uporabnisko_ime": self.uporabnisko_ime,
            "zasifrirano_geslo": self.zasifrirano_geslo,
            "igre": self.igre
        }

    @classmethod
    def iz_slovarja(cls, slovar):
        return cls(
            uporabnisko_ime=slovar["uporabnisko_ime"],
            zasifrirano_geslo=slovar["zasifrirano_geslo"],
            igre=slovar["igre"]
        )



@dataclass
class VseSkupaj:
    uporabniki: List[Uporabnik]

    def poisci_uporabnika(self, uporabnisko_ime = None, prijavljanje = False):
        import bottle
        if prijavljanje == False:
            uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
        if uporabnisko_ime is None and not prijavljanje:
            bottle.redirect('/')
        for uporabnik in self.uporabniki:
            if uporabnik.uporabnisko_ime == uporabnisko_ime:
                return uporabnik

    def v_slovar(self):
        return {
            "uporabniki": [uporabnik.v_slovar() for uporabnik in self.uporabniki],
        }

    @classmethod
    def iz_slovarja(cls, slovar):
        return cls(
            uporabniki=[Uporabnik.iz_slovarja(sl)
                        for sl in slovar["uporabniki"]]
        )

    def v_datoteko(self, ime_datoteke):
        with open(ime_datoteke, "w") as f:
            json.dump(self, f, ensure_ascii=False, indent=4)

    @classmethod
    def iz_datoteke(cls, ime_datoteke):
        with open(ime_datoteke, encoding="utf-8") as f:
            return cls.iz_slovarja(json.load(f))

    @staticmethod
    def preberi_skrivnost_iz_datoteke():
        with open("skrivnost.txt") as datoteka_s_skrivnostjo:
            return (datoteka_s_skrivnostjo.read())

    @staticmethod
    def doloci_lastnosti_odigrane_igre(igra, uporabnisko_ime, beli, crni):
        if "1-0" in igra:
            rezultat_igre = "W"
            lokalni_rezultat = "Zmaga" if uporabnisko_ime == beli else "Poraz"
            lokalni_rezultat_nasprotnik = "Zmaga" if uporabnisko_ime == crni else "Poraz"
        elif "0-1" in igra:
            rezultat_igre = "B"
            lokalni_rezultat = "Zmaga" if uporabnisko_ime == crni else "Poraz"
            lokalni_rezultat_nasprotnik = "Zmaga" if uporabnisko_ime == beli else "Poraz"
        else:
            rezultat_igre = "D"
            lokalni_rezultat = "Remi"
            lokalni_rezultat_nasprotnik = "Remi"

        return rezultat_igre, lokalni_rezultat, lokalni_rezultat_nasprotnik

@dataclass
class PrikazovanjeStrani:
    @staticmethod
    def arhiv_igra(id):
        import bottle
        SKRIVNOST = VseSkupaj.preberi_skrivnost_iz_datoteke()
        STANJE = "stanje.json"
        vse_skupaj = VseSkupaj.iz_datoteke(STANJE)
        uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
        uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime)
        vse_uporabnikove_igre = uporabnik.igre
        for posamezna_igra in vse_uporabnikove_igre:
            if str(posamezna_igra["id"]) == id[:-1]:
                igra = posamezna_igra["igra"]
                beli = posamezna_igra["beli"]
                crni = posamezna_igra["crni"]
                #id_igre = str(posamezna_igra["id"])
                celoten_fen = posamezna_igra["celoten_fen"].split(",")
                popravljen_celoten_fen = [i.split(" ")[0] for i in celoten_fen]
                return uporabnisko_ime, igra, beli, crni, popravljen_celoten_fen
        
    @staticmethod
    def arhiv():
        import bottle
        SKRIVNOST = VseSkupaj.preberi_skrivnost_iz_datoteke()
        STANJE = "stanje.json"
        vse_skupaj = VseSkupaj.iz_datoteke(STANJE)
        uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
        uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime)
        vse_uporabnikove_igre = uporabnik.igre
        return uporabnisko_ime, vse_uporabnikove_igre
    
    @staticmethod
    def igraj_proti_racunalniku():
        import bottle
        SKRIVNOST = VseSkupaj.preberi_skrivnost_iz_datoteke()
        uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
        #cookie_obstaja = bottle.request.get_cookie('barva', secret=SKRIVNOST)
        return uporabnisko_ime
    
    @staticmethod
    def statistika():
        import bottle
        SKRIVNOST = VseSkupaj.preberi_skrivnost_iz_datoteke()
        STANJE = "stanje.json"
        vse_skupaj = VseSkupaj.iz_datoteke(STANJE)
        uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
        uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime)
        vse_uporabnikove_igre = uporabnik.igre
        
        mozni_razpleti = ["zmage", "porazi", "remiji", "zmage_beli", "porazi_beli", "remiji_beli", "zmage_crni", "porazi_crni", "remiji_crni"]
        slovar_rezultatov = {razplet:0 for razplet in mozni_razpleti}

        
        def pridobi_podatek_o_odstotkih(razplet):
            if "beli" in razplet:
                if slovar_rezultatov["zmage_beli"] + slovar_rezultatov["porazi_beli"] + slovar_rezultatov["remiji_beli"] != 0:
                    return '{:.1%}'.format(slovar_rezultatov[razplet]/(slovar_rezultatov["zmage_beli"] + slovar_rezultatov["porazi_beli"] + slovar_rezultatov["remiji_beli"]))
                else:
                    return "ni podatka"
            
            if "crni" in razplet:
                if slovar_rezultatov["zmage_crni"] + slovar_rezultatov["porazi_crni"] + slovar_rezultatov["remiji_crni"] != 0:
                    return '{:.1%}'.format(slovar_rezultatov[razplet]/(slovar_rezultatov["zmage_crni"] + slovar_rezultatov["porazi_crni"] + slovar_rezultatov["remiji_crni"]))
                else:
                    return "ni podatka"
            
            if slovar_rezultatov["zmage"] + slovar_rezultatov["porazi"] + slovar_rezultatov["remiji"] != 0:
                    return '{:.1%}'.format(slovar_rezultatov[razplet]/(slovar_rezultatov["zmage"] + slovar_rezultatov["porazi"] + slovar_rezultatov["remiji"]))
            else:
                return "ni podatka"
           
        for posamezna_igra in vse_uporabnikove_igre:
            uporabnik_je_bel = posamezna_igra["beli"] == uporabnisko_ime
            if posamezna_igra["lokalni_rezultat"] == "Zmaga":
                slovar_rezultatov["zmage"] += 1
                if uporabnik_je_bel:
                    slovar_rezultatov["zmage_beli"] += 1
                else:
                    slovar_rezultatov["zmage_crni"] += 1
            if posamezna_igra["lokalni_rezultat"] == "Poraz":
                slovar_rezultatov["porazi"] += 1
                if uporabnik_je_bel:
                    slovar_rezultatov["porazi_beli"] += 1
                else:
                    slovar_rezultatov["porazi_crni"] += 1
            if posamezna_igra["lokalni_rezultat"] == "Remi":
                slovar_rezultatov["remiji"] += 1
                if uporabnik_je_bel:
                    slovar_rezultatov["remiji_beli"] += 1
                else:
                    slovar_rezultatov["remiji_crni"] += 1
                           
        slovar_rezultatov_s_podatki = {i: pridobi_podatek_o_odstotkih(i) for i in slovar_rezultatov}
        
        return uporabnisko_ime, slovar_rezultatov, slovar_rezultatov_s_podatki
        
    @staticmethod
    def igraj():
        import bottle
        STANJE = "stanje.json"
        vse_skupaj = VseSkupaj.iz_datoteke(STANJE)
        SKRIVNOST = VseSkupaj.preberi_skrivnost_iz_datoteke()
        uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
        
        return uporabnisko_ime, vse_skupaj.uporabniki
        
SKRIVNOST = VseSkupaj.preberi_skrivnost_iz_datoteke()