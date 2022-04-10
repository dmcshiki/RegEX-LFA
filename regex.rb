def regex(texto)
  #Hora menos fuso horário para bater com horário Brasil
  time = Time.new - 10800
  
  dia = texto.match(/\d{1,2}\/\d{1,2}[\/(\d{2}|\d{4})]*|[0-9]+\sde [a-zA-Z]+(\sde\s\d+)*/)
  tag = texto.match(/#\w+/)
  hora = texto.match(/\d+:\d+|\d+\s\d+|\d+\shora[s]?|[àa]s\s\d+/)
  pessoa = texto.match(/com\s[a-zA-Zà-úÀ-Ú]+(\se\s[a-zA-Zà-úÀ-Ú]+)*/)
  
  if dia == nil
    dia = texto.match(/ontem|hoje|amanhã|depois de amanhã/)
    if dia != nil
      if dia[0] == "ontem"
        dia = time - 86400
      elsif dia[0] == "hoje"
        dia = time
      elsif dia[0] == "amanhã"
        dia = time + 86400
      elsif dia[0] == "depois de amanhã"
        dia = time + 86400*2
      end
      
      dia = dia.strftime("%d/%m/%Y")
    end
  end
  puts"Dia: #{dia}", "Horário: #{hora}","Tag: #{tag}", "Pessoa: #{pessoa}\n\n"
end

textos = ["Agendar com José e lucas reunião às 10 ontem #trabalho #casa",
          "Agendar com José reunião as 10 amanhã #trabalho",
          "Agendar com Lucas reunião 10 00",
          "Agendar com José e lucas reunião 10:00 20/02/20 #trabalho",
          "Agendar com José e lucas reunião às 10 20 de fev #trabalho",
          "Agendar com José e Julia reunião às 10 20 de fev de 2021 #trabalho",
          ]

puts "Quer marcar um novo agendamento? (S ou N)"
x = gets

if x.chomp == "S" or x.chomp == "s"
  puts "Digite seu texto: "
  texto = gets
  textos.append(texto)
  regex(texto.chomp)
end

puts "\nSeus agendamentos: "
textos.each do |texto|
  regex(texto)
end
