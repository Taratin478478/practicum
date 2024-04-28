struct Figure {
    virtual ~Figure(){};
    virtual bool equals(const Figure* const) const = 0;
};

class Rectangle: public Figure {
    int a_, b_;
public:
    Rectangle(int a, int b) {
        a_ = a;
        b_ = b;
    }
    bool equals(const Figure* const fig) const {
        if (fig == nullptr) {
            return false;
        }

        const Rectangle* const other = dynamic_cast<const Rectangle* const>(fig);
        if (other == nullptr) {
            return false;
        }
        return (a_ == other->a_ && b_ == other->b_);
    }
};

class Triangle: public Figure {
    int a_, b_, c_;
public:
    Triangle(int a, int b, int c) {
        a_ = a;
        b_ = b;
        c_ = c;
    }

    bool equals(const Figure* const fig) const {
        if (fig == nullptr) {
            return false;
        }
        const Triangle* const other = dynamic_cast<const Triangle* const>(fig);
        if (other == nullptr) {
            return false;
        }
        return (a_ == other->a_ && b_ == other->b_ && c_ == other->c_);
    }
};