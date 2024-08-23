#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>

const int n = 10;
const int INF = 65535;
double distance[n][n];
bool flag[n][n] = {false};
double minLength = 256;  //当前最短路径

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
        distance[i][j] = value;
      }

    }


    file.close();
    return;

}

bool isNessary(int a, int b){
    switch(a){
    case 0:
        if(b==1) return true;
        return false;
    case 1:
        if(b==0||b==2) return true;
        return false;
    case 2:
        if(b==2) return false;
        return true;
    case 3:
        if(b==4||b==9) return true;
        return false;
    case 4:
        if(b==3||b==7) return true;
        return false;
    case 5:
        if(b==6) return true;
        return false;
    case 6:
        if(b==5||b==8) return true;
        return false;
    case 7:
        if(b==4||b==9) return true;
        return false;
    case 8: 
        if(b==6) return true;
        return false;
    case 9:
        if(b==3||b==7) return true;
        return false;
    default: return false;
    }
}

//从节点1出发，回到节点9结束


void backtracking(int pos, double sum, std::vector<int> path, std::vector<std::vector<bool>> flag, int route) {


    
    if(path.size() && isNessary(pos, path.back())){
        route++;
        flag[pos][path.back()] = true;
        flag[path.back()][pos] = true;     //防止重复
    }
    path.push_back(pos);

    if (route == 8) {
        for(int i = 0; i<path.size(); i++){
            std::cout<<path[i]<<" ";
        }
        std::cout<<std::endl<<sum<<std::endl;
        minLength = sum;
        return;
    }

    for (int i=0; i<n; i++) {
        if(sum+distance[pos][i]<minLength && pos!=i && !flag[pos][i]){
            backtracking(i, sum+distance[pos][i], path, flag, route);
        }
    }
}


int main(){
    std::vector<std::vector<bool>> flag(10, std::vector<bool>(10, false));
    input();
    std::vector<int> path;
    backtracking(0, 0, path, flag, 0);
}
