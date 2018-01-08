void f (int g)
{
  g++;
  g--;
}

void copy (int a[], int b[], int n){
  for (int i=0; i<n; ++i){
    a[i] = b[i];
  }
}

int main(int argc, char** argv)
{
  int i=3;
  if (i > 0)
    {while(--i);}
  else
    {f(3);}
  return 0;
}