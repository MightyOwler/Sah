<! ---% rebase('osnova.tpl') --->
<! -- tu nima smisla rebase, saj te stvari ni na  osnovni strani>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">

<form method="POST">
    <div class="field">
        <label class="label" style="margin:10px;">Uporabniško ime</label>
        <div class="control has-icons-left">
            <input class="input" name="uporabnisko_ime" type="text" placeholder="uporabniško ime" style="width: 20%; margin:10px;">
            <span class="icon is-small is-left">
                <i class="fas fa-user"></i>
            </span>
        </div>
        % if napaka:
        <p class="help is-danger">{{ napaka }}</p>
        % end
    </div>
    <div class="field">
        <label class="label" style="margin:10px;">Geslo</label>
        <div class="control has-icons-left">
            <input class="input" name="zasifrirano_geslo" type="password" placeholder="geslo" style="width: 20%; margin:10px;">
            <span class="icon is-small is-left">
                <i class="fas fa-lock"></i>
            </span>
        </div>
    </div>
    <div class="field is-grouped">
        <div class="control">
            <button class="button is-link is-medium" style="margin:10px;">Prijavi se</button>
        </div>
    </div>
</form>