from dataclasses import dataclass
import random
import json
from typing import List

# vejretno sploh ne bo potrebno importati
#import chess

# tule je treba preveritim ali to sploh deluje
@dataclass
class Uporabnik:
    uporabnisko_ime: str
    zasifrirano_geslo: str
    igre: list
    
    @staticmethod
    def zasifriraj_geslo(geslo_v_cistopisu):
        return "XXX" + geslo_v_cistopisu[::-1] + "XXX"

    def ima_geslo(self, geslo_v_cistopisu):
        return self.zasifriraj_geslo(geslo_v_cistopisu) == self.zasifrirano_geslo
    
    def nastavi_novo_geslo(self, geslo_v_cistopisu):
        self.zasifrirano_geslo = self.zasifriraj_geslo(geslo_v_cistopisu)

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

    def preveri_uporabnika(self, uporabnisko_ime, geslo):
        if self.poisci_uporabnika(uporabnisko_ime) == None:
            return False
        else:
            if self.zasifrirano_geslo == geslo:
                return True
            else:
                return False

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
            uporabniki=[Uporabnik.iz_slovarja(sl) for sl in slovar["uporabniki"]]
        )

    def v_datoteko(self, ime_datoteke):
        with open(ime_datoteke, "w") as f:
            json.dump(self, f, ensure_ascii=False, indent=4)

    @classmethod
    def iz_datoteke(cls, ime_datoteke):
        with open(ime_datoteke, encoding="utf-8") as f:
            return cls.iz_slovarja(json.load(f))
    
        
    # malo sumljivo je, ker sploh nikjer nisem zašifriral gesla