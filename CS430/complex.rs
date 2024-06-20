use num::Complex;
use threadpool::ThreadPool;
use std::sync::mpsc::channel;
use image::{RgbImage, Rgb, ImageBuffer};

fn main() {
    let width: u32 = 1600;
    let height: u32 = 900;
    let mut img: RgbImage = ImageBuffer::new(width, height);

    let num_threads = num_cpus::get();
    let pool = ThreadPool::new(num_threads);

    let (sender, receiver) = channel();


    for r in 0..height {
        let sender = sender.clone();
        pool.execute(move || {
            for c in 0..width {
                let x: f64 = ((c as f64) / ((width as f64) / 2.0)) - 1.0;
                let y: f64 = ((r as f64) / ((height as f64) / 2.0)) - 1.0;
                let m: f64 = membership(x, y);
                let rgb = Rgb([((1.0 - m) * 120.0) as u8, ((1.0 - m) * 85.0) as u8, ((1.0 - m) * 255.0) as u8]);
                sender.send((c, r, rgb)).unwrap();
            }
        });
    }

    for _ in 0..(width * height) {
        let (c, r, rgb) = receiver.recv().unwrap();
        img.put_pixel(c, r, rgb);
    }

    img.save("julia_set6.png").unwrap();
}

fn membership(x: f64, y: f64) -> f64 {
    let max_iterations = 100;
    let config = Complex::new(-1.36833, -0.01357);
    let mut z = Complex::new(x, y);
    let mut iteration_count = 0;
    while z.norm() < 2.0 && iteration_count < max_iterations {
        z = z * z + config;
        iteration_count += 1;
    }
    let proportion: f64 = iteration_count as f64 / max_iterations as f64;
    1.0 - proportion
}
