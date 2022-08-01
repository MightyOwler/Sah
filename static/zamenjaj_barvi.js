//zamenjamo vrednost polj
function zamenjaj_barvi() {
    beli = document.getElementById('beli');   
    crni = document.getElementById('crni');
    vrednost_beli = beli.value;
    vrednost_crni = crni.value;
    beli.value = vrednost_crni;
    crni.value = vrednost_beli;
    if (beli.readOnly){
      beli.readOnly = false;
    } else {beli.readOnly = true;}
    if (crni.readOnly){
      crni.readOnly = false;
    } else {crni.readOnly = true;}
}