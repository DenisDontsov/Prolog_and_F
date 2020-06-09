open System.Drawing
open System.Windows.Forms

let form = new Form (Width = 426, Height = 320, Text = "Главная форма")
let button = new Button(Text = "Результат", Top = 240, Left = 320)
let richTextBox1 = new RichTextBox(Width = 400, Height = 30, Font = new Font(FontFamily("Times New Roman"), 12.0f, FontStyle.Bold), Top = 50)
let richTextBox2 = new RichTextBox(Width = 400, Height = 30, Font = new Font(FontFamily("Times New Roman"), 12.0f, FontStyle.Bold), Top = 148)
let inputLabel = new Label(Text = "Введите строку", Top = 5, ForeColor = Color.Black, Font = new Font(FontFamily("Times New Roman"), 16.0f, FontStyle.Regular))
inputLabel.Width <- 400
form.Controls.Add(inputLabel)
richTextBox1.Dock = DockStyle.Fill
richTextBox2.Dock = DockStyle.Fill
form.Controls.Add(richTextBox1)
form.Controls.Add(button)
let readstr =
    button.MouseClick
    |> Observable.map (fun ClickArgs -> let str = richTextBox1.Text
                                        let len = str.Length
                                        let rec compression string_i tmp ch schet = function
                                            l when (str.[len - 1] = str.[len-2] && (l = len)) -> let str4 = tmp.ToString() + ch.ToString() + schet.ToString()
                                                                                                 if (str4.Length > string_i.ToString().Length) then string_i
                                                                                                 else str4
                                            | l when ((str.[len-1] <> str.[len-2]) && (l = len)) -> let str3 = tmp.ToString() + ch.ToString() + "1"
                                                                                                    if (str3.Length > string_i.ToString().Length) then string_i
                                                                                                    else str3
                                            | n when str.[n] = ch -> compression string_i tmp ch (schet+1) (n+1)
                                            | n when str.[n] <> ch -> let str1 = tmp.ToString() + ch.ToString() + schet.ToString()
                                                                      compression string_i str1 (str.[n]) 1 (n+1)
                                        let z = compression str "" (str.[0]) 1 1
                                        richTextBox2.AppendText(z.ToString()))
readstr
|> Observable.add(fun x -> let outp = new Label(Text = "Построенная строка", Top = 97, ForeColor = Color.Black, Font = new Font(FontFamily("Times New Roman"), 16.0f, FontStyle.Regular))
                           outp.Width <- 401
                           form.Controls.Add(outp)
                           form.Controls.Add(richTextBox2))
do Application.Run(form)