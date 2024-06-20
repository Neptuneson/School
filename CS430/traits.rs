#![allow(dead_code)]
trait Element {
    fn to_html(&self) -> String;
}

struct Document {
    elements: Vec<Box<dyn Element>>,
}

impl Document {
    fn new() -> Self {
        Document {
            elements: Vec::new(),
        }
    }

    fn generate(&self) -> String {
        let mut html = String::new();

        html.push_str("<html>\n<body>\n");

        for element in &self.elements {
            html.push_str(&element.to_html());
        }

        html.push_str("</body>\n</html>\n");

        return html;
    }
}

fn main() {
    let mut doc = Document::new();
    let html = doc.generate();
    println!("{}", html);
}

