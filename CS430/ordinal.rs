fn ordinal (num: u32) -> String {
    if num % 10 == 1 && (num > 20 || num < 10) {
        format!("{}st", num)
    } else if num % 10 == 2 && (num > 20 || num < 10) {
        format!("{}nd", num)
    } else if num % 10 == 3 && (num > 20 || num < 10) {
        format!("{}rd", num)
    } else {
        format!("{}th", num)
    }
}

fn main() {
    for i in 1..131 {
        print!("{}\n", ordinal(i));
    }
}