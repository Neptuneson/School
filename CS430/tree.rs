#![allow(dead_code)]
#![allow(unused_variables)]
enum Tree<T> {
    Empty,
    Node {
        value: T,
        left: Box<Tree<T>>,
        right: Box<Tree<T>>,
    },
}

impl<T: PartialOrd> Tree<T> {
    fn add(&mut self, item: T) {
        match self {
            Tree::Empty => {
                *self = Tree::Node {
                    value: item,
                    left: Box::new(Tree::Empty),
                    right: Box::new(Tree::Empty),
                };
            },
            Tree::Node { value, left, right } => {
                if item < *value {
                    left.add(item);
                } else if item > *value {
                    right.add(item);
                }
            },
        }
    }
}

fn main() {
    let mut tree = Tree::<i32>::Empty;
    tree.add(5);
}