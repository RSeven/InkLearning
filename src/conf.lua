--Configuração
function love.conf(t)
  
  
    t.title = "INK LEARNING" 
    t.version  = "0.10.1"
    --definiçao da area da janela
    t.window.width = 1280
    t.window.height = 720
    
    
    --para debugging do Windows lembrar de mudar para false para o release
    t.console = true

  end
