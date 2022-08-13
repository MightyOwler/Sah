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

    def poisci_uporabnika(self, uporabnisko_ime, geslo_v_cistopisu=None, igre=None):
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
