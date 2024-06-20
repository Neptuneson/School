use std::env;
use std::iter::zip;

fn main() {
    let args: Vec<String> = env::args().collect();
    let path1 = &args[1];
    let path2 = &args[2];
    let text1 = std::fs::read_to_string(path1).unwrap();
    let chars1 = text1.chars();
    let text2 = std::fs::read_to_string(path2).unwrap();
    let chars2 = text2.chars();
    let iter = zip(chars1, chars2);
    let mut comp: String = "".to_owned();
    for (i,j) in iter {
        if i != j {
            comp.push_str("^");
        } else {
            comp.push_str(" ");
        }
    }
    print!("{}\n", text1);
    print!("{}\n", text2);
    print!("{}\n", comp);
}