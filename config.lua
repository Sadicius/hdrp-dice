Config = {}
-- Debug y Notificaciones (Config.Debug y Config.Notify): Configuraciones para habilitar o deshabilitar la depuración y seleccionar el tipo de notificaciones que se mostrarán al jugador.
-- Configuración de Dados (Config.DiceAdv y Config.DeleteDice): Opciones relacionadas con el lanzamiento de dados, como la versión avanzada y el tiempo para eliminar los dados después del lanzamiento.
-- Webhooks Adicionales (Config.Webhooks): Enlaces para webhooks que se pueden utilizar para enviar datos o notificaciones a un servidor de Discord u otro servicio web.

Config.Debug = false          -- Used for Debug
Config.Notify = 'rnotify'     -- 'ox_lib' / 'rnotify' / 'RSG' (solo success and inform notify player, but notify errors all in ox_lib)

-------------------------
-- DICE ROLL ITEM
-----------------------
Config.DiceAdv = true         -- 'false' version simple / 'true' Version full with change cameras 
Config.DeleteDice = 3000      -- 10s

-------------------------
-- EXTRA Webhooks / RANKING
-----------------------
Config.Webhooks = {
  ["dice"] = "https://discord.com/api/webhooks/1108532436498923551/qyAG5A2wTInFy9D_nfZc4KS5l5nyWWj9mFFSgovoghg4xVJGEosuU8azdTwChLRkN4Zl",
}
