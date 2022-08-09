<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>

<div class="box">
    <div class="section">
        <form method="POST">
            <div class="field">
                <div class="columns is-mobile is-centered"><label class="title is-4" style="margin:20px;">Uporabniško ime:</label></div>
                <div class="columns is-mobile is-centered">
                    <p class="control has-icons-left" style="margin:10px;">
                        <input class="input is-medium" name="uporabnisko_ime" type="text" placeholder="uporabniško ime">
                        <span class="icon is-small is-left">
                            <i class="fas fa-user"></i>
                        </span>
                    </p>
                </div>
            </div>
            <div class="field">
                <div class="columns is-mobile is-centered"><label class="title is-4" style="margin:20px;">Geslo:</label></div>
                <div class="columns is-mobile is-centered">
                    <p class="control has-icons-left" style="margin:10px;">
                        <input class="input is-medium" name="zasifrirano_geslo" type="password" placeholder="geslo">
                        <span class="icon is-small is-left">
                            <i class="fas fa-lock"></i>
                        </span>
                    </p>
                </div>
            </div>
            <div class="columns is-mobile is-centered">
                <button class="button is-link is-medium" style="margin:30px;">Prijavi se</button>
            </div>
    
               
        </form>
    </div>
</div>
 % if napaka:
    <div class="columns is-mobile is-centered">
        <p class="title help is-3 is-danger">{{ napaka }}!</p>
    </div>
% end