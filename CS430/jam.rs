use std::fs;

#[derive(Debug)]
struct Country {
    country: String,
    capital: String,
    latitude: f64,
    longitude: f64,
    capital_population: i32,
    area: f64,
    population_1960: i32,
    population_2021: i32,
}

fn main() {
    let data = fs::read_to_string("countries.csv").expect("Unable to read file");
    
    let countries: Vec<Country> = data.lines()
        .skip(1)
        .map(|line| {
            let fields: Vec<&str> = line.split(',').collect();
            Country {
                country: fields[0].to_string(),
                capital: fields[1].to_string(),
                latitude: fields[2].parse().unwrap(),
                longitude: fields[3].parse().unwrap(),
                capital_population: fields[4].parse().unwrap(),
                area: fields[5].parse().unwrap(),
                population_1960: fields[6].parse().unwrap(),
                population_2021: fields[7].parse().unwrap(),
            }
        })
        .collect();
        
    // Which country has the largest population change from 1960 to 2021?
    let (max_index, max_country) = countries.iter().enumerate()
        .fold((0, &countries[0]), |(max_idx, max_ctry), (idx, ctry)| {
            if ctry.population_2021 - ctry.population_1960 > max_ctry.population_2021 - max_ctry.population_1960 {
            (idx, ctry)
        } else {
            (max_idx, max_ctry)
        }
    });
    println!("Which country has the largest population change from 1960 to 2021?"); // "India": 961609263
    println!("{:?}: {:?}", max_country.country, max_country.population_2021 - max_country.population_1960);

    let (max_idx, max_name_ctry) = countries.iter().enumerate()
        .fold((0, &countries[0]), |(max_idx, max_name_ctry), (idx, ctry)| {
        if ctry.country.len() < max_name_ctry.country.len() {
            (max_idx, max_name_ctry)
        } else {
            (idx, ctry)
        }
    });

    println!("Which country has the longest name?"); // "Saint Vincent and the Grenadines": 32
    println!("{:?}: {:?}", max_name_ctry.country, max_name_ctry.country.len());

    // Which country has the smallest population change from 1960 to 2021?
    let (min_index, min_country) = countries.iter().enumerate()
        .fold((0, &countries[0]), |(min_idx, min_ctry), (idx, ctry)| {
            if ctry.population_2021 - ctry.population_1960 < min_ctry.population_2021 - min_ctry.population_1960 {
            (idx, ctry)
        } else {
            (min_idx, min_ctry)
        }
    });
    
    println!("Which country has the smallest population change from 1960 to 2021?"); // "Bulgaria": -989631
    println!("{:?}: {:?}", min_country.country, min_country.population_2021 - min_country.population_1960);

}
