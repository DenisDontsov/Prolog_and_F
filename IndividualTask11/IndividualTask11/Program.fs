open System.Drawing
open System.IO
open System.Windows.Forms

let form = new Form(Width = 640, Height = 480, Text = "Главная форма", Menu = new MainMenu())
let button = new Button(Text = "Кнопка", Top = 410, Left = 540)
form.Controls.Add(button)
let image = new PictureBox(SizeMode = PictureBoxSizeMode.Zoom, Size = new Size(640,360), Top = 1)
let rec slide count =
    match count with
    | var when var < 9 -> let clickButton = 
                            button.MouseClick
                            |> Observable.map (fun clickArgs -> let string1 = @"C:\Games\pictures"
                                                                let string2 = string1 + string((char)92) + string(count) + ".PNG" 
                                                                if (File.Exists(string2)) then 
                                                                    image.ImageLocation <- string2
                                                                else 
                                                                    let string3 = string2.TrimEnd('P','N','G') + "JPG"
                                                                    if (File.Exists(string3)) then
                                                                        image.ImageLocation <- string3
                                                                    else ())
                          clickButton
                          |> Observable.add(fun x -> form.Controls.Add(image)
                                                     slide(count + 1))
    | _ -> button.Hide()
           let label = new Label(Text = "Картинки кончились", Top = 400, Left = 420, ForeColor = Color.Black, Font = new Font(FontFamily("Times New Roman"), 15.0f,FontStyle.Regular))
           label.Width <- 400
           form.Controls.Add(label)
slide 0
do Application.Run(form)