#include <stdlib.h>
#include <iostream>
#include <sstream>
#include <fstream>
#include <algorithm>
#include <cstring>

const int n = 10;

bool visit[n] = {false};
double dist[n];
int parent[n];

double distance1[n][n];

int sum = 0;

double Prim(int pos){
    dist[pos] = 0;
    visit[pos] = true;
    int cur = 1;

    int rectangle = 0;

    for(int i=1; i<n; i++){

        for(int a=1; a<n; a++){
            if(!visit[a] /*&& (rectangle==12 || a!=5)*/){
                cur = a;
                break;
            }
        }
        for(int j=1; j<n; j++){
            if(!visit[j] && (dist[j]<dist[cur])/* && (rectangle==12 || j!=5)*/){ 
                cur = j;}
        }

        sum += dist[cur];
        std::cout<<parent[cur]<<"->"<<cur+1<<std::endl;
        visit[cur] = true;
        if(cur>5) rectangle++;
        for(int k=1; k<n; k++){
            if(!visit[k] && distance1[cur][k]<dist[k]) {
                dist[k]=distance1[cur][k];
                parent[k] = cur+1;
            }
        }
        
    }
    return sum;

}

void input(){
    std::string filename = "input.txt";
    std::ifstream file(filename);

    if (!file.is_open()) {
        std::cerr << "Failed to open file." << std::endl;
        return;
    }

    double value;
    std::string line;

    for(int i=0; i<n; i++){

      std::getline(file, line);
      std::istringstream iss(line);

      for(int j=0; j<n; j++){
        iss>>value;
        distance1[i][j] = value;
      }

    }


    file.close();
    return;

}


int main(){
    input();
    std::memcpy(dist, distance1[0], sizeof(dist));
    for(int i=0; i<n; i++){
        parent[i] = 1;
    }
    std::cout<<Prim(0);
    return 0;
}