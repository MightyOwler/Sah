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

    def poisci_uporabnika(self, uporabnisko_ime):
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
        
        