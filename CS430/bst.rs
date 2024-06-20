#![allow(dead_code)]
#![allow(unused_variables)]
use std::fmt::Display;
use std::ops::RangeInclusive;

enum Tree<T> {
    Empty,
    Node {
        value: T,
        left: Box<Tree<T>>,
        right: Box<Tree<T>>
    },
}

impl<T: PartialOrd> Tree<T> {
    fn contains(&self, target: T) -> bool {
        match self {
            Tree::Empty => false,
            Tree::Node { value, left, right } => {
                if target < *value {
                    left.contains(target)
                } else if target > *value {
                    right.contains(target)
                } else {
                    true
                }
            },
        }
    }

    fn add(&mut self, new_value: T) {
        match self {
            Tree::Empty => {
                *self = Tree::Node {
                    value: new_value,
                    left: Box::new(Tree::Empty),
                    right: Box::new(Tree::Empty),
                };
            },
            Tree::Node { value, left, right } => {
                if new_value < *value {
                    left.add(new_value);
                } else if new_value > *value {
                    right.add(new_value);
                }
            },
        }
    }
}

impl<T> Tree<T> {
    fn len(&self) -> usize {
        match self {
            Tree::Empty => 0,
            Tree::Node {value: _, left , right} => {
                1 + left.len() + right.len()
            },
        }
    }
}

impl<T: Display> Tree<T> {
    fn print(&self) {
        match self {
            Tree::Empty => {},
            Tree::Node {value , left , right} => {
                left.print();
                print!("{} ", value);
                right.print();
            },
        }
    }
}

impl<T: PartialOrd + Copy> Tree<T> {
    fn between(&self, range: &RangeInclusive<T>, vec: &mut Vec<T>) {
        match self {
            Tree::Empty => {},
            Tree::Node {value , left , right} => {
                if value < range.start() {
                    right.between(range, vec);
                } else if value > range.end() {
                    left.between(range, vec);
                } else {
                    vec.append(*value);
                    left.between(range, vec);
                    right.between(range, vec);
                }
            },
        }
    }
}


fn main() {
    let mut tree = Tree::<i32>::Empty;
    tree.add(7);
    tree.add(4);
    tree.add(9);
    tree.add(13);
    println!("{}", tree.len());
    tree.print();
    println!("");
    let range = RangeInclusive::<i32>::new(3, 7);
    let mut vec  = Vec::<i32>::new();
    tree.between(&range, &mut vec);
    println!("{:?}", vec);
}