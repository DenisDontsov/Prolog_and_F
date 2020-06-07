open System

let rec sumF list = 
    match list with
    | [] -> 0
    | h::t -> let tail = sumF t
              h + tail

let rec max h t =
    match t with
    | [] -> h
    | head::tail -> if (head > h) then max head tail
                    else max h tail

let rec newList list ma mi = 
    match list with
    | [] -> []
    | h::t -> let tail = newList t ma mi
              if ((h > mi) && (h < ma)) then h::tail
              else tail

let rec readList n = 
    if n = 0 then []
    else Convert.ToInt32(Console.ReadLine())::readList(n-1)

let middle list size =
    match list with
    | [] -> 0
    | h::t -> sumF list / size

let rec writeList list = 
    match list with
    |[] -> Console.Write("\n")
           let z = Console.ReadKey()
           0
    |h::t -> Console.Write(h.ToString())
             Console.Write("   ")
             writeList t

let launchF list size = 
    match list with
    | [] -> []
    | h::t -> Console.Write("Результирующий список --  ")
              newList list (max h t) (middle list size)

[<EntryPoint>]
let main argv = 
    Console.Write("Введите размерность списка: ")
    let size = Convert.ToInt32(Console.ReadLine())
    Console.Write("Введите список из ")
    Console.Write(size.ToString())
    Console.Write(" элементов\n")
    writeList(launchF(readList size) size)