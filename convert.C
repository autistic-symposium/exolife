#include <iostream>
#include <TH1.h>
using namespace std;
TH1D *h;


void convert(){

const char namefile[1000] = "data1.txt";
const char output[1000] = "data1.root";
char name[1000] = "data1";

h = new TH1D(name,name,1000, 0.4819182-3.64e-4/2.0, 0.845982-3.64e-4/2.0);

ifstream f; 
f.open(namefile);
  
double t, v, p, first;
double nlines = 0.0;

while (1) {
      if (f.eof()) break;
      f >> t >> v ;
      cout << t << " " << v << endl;
      if(nlines==0) first = t; 
      h->Fill(t,v);
      nlines++;
 }

TFile *final = new TFile(output,"RECREATE");    
h->Write();  
final->Close(); 

}




