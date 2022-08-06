<! ---% rebase('osnova.tpl') --->
<! -- tu nima smisla rebase, saj te stvari ni na  osnovni strani>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">

<div class="box">
    <div class="section">
        <form method="POST">
            <div class="field">
                <div class="columns is-mobile is-centered"><label class="label" style="margin:10px;">Uporabniško ime:</label></div>
                <div class="columns is-mobile is-centered">
                    <input class="input is-medium" name="uporabnisko_ime" type="text" placeholder="uporabniško ime" style="width: 20%; margin:10px;">
                    <span class="icon is-small is-left">
                        <i class="fas fa-user"></i>
                    </span>
                </div>
    
            </div>
            <div class="field">
                <div class="columns is-mobile is-centered"><label class="label" style="margin:10px;">Geslo:</label></div>
                <div class="columns is-mobile is-centered">
                    <input class="input is-medium" name="zasifrirano_geslo" type="password" placeholder="geslo" style="width: 20%; margin:10px;">
                    <span class="icon is-small is-left">
                        <i class="fas fa-lock"></i>
                    </span>
                </div>
            </div>
            <div class="columns is-mobile is-centered">
                <button class="button is-link is-medium" style="margin:10px;">Prijavi se</button>
            </div>
    
               
        </form>
    </div>
</div>
 % if napaka:
                <div class="columns is-mobile is-centered">
                    <p class="title help is-3 is-danger">{{ napaka }}!</p>
                </div>
                % end