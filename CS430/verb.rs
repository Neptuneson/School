use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    let input = &args[1];
    if let Some((inf, _)) = input.rsplit_once("ar") {
        print!("I {}o\n", inf);
        print!("You {}as\n", inf);
        print!("He, She, It {}a\n", inf);
        print!("We {}amos\n", inf);
        print!("They {}an\n", inf);
    } else if let Some((inf, _)) = input.rsplit_once("er") {
        print!("I {}o\n", inf);
        print!("You {}es\n", inf);
        print!("He, She, It {}e\n", inf);
        print!("We {}emos\n", inf);
        print!("They {}en\n", inf);
    } else if let Some((inf, _)) = input.rsplit_once("ir") {
        print!("I {}o\n", inf);
        print!("You {}es\n", inf);
        print!("He, She, It {}e\n", inf);
        print!("We {}imos\n", inf);
        print!("They {}en\n", inf);
    } else {
        print!("Irregular Verb")
    }
}