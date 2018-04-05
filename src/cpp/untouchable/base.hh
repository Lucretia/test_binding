// TODO: How do we handle "= deleted" methods and && move semantics?
// TODO: Copying

class Base {
public:
  Base();
  Base(const int v);
  virtual ~Base();

  virtual void DoOne() = 0;
  virtual void DoTwo();

  int Value() const;
  void SetValue(const int v);

  // TODO: Add a static object
  // static Base Ten;

private:
  int val;
};
