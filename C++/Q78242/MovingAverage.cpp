#include <stdint.h>
#include <iostream>

using namespace std;

template<uint32_t WINDOW_SIZE>
class MovingAverage{
    public:
        MovingAverage(){
            for(uint32_t elem = 0; elem < WINDOW_SIZE; elem++){
                buffer[elem] = 0;
            }
            input_value = 0;
            sum = 0;
            average = 0;
            index = 0;
        }
        
        void setInput(float input){
            input_value = input;
        }
        
        void calculate(){
            sum -= buffer[index];
            buffer[index] = input_value;
            sum += buffer[index];
            average = sum/WINDOW_SIZE;
            index = (index + 1) % WINDOW_SIZE;
        }
        
        float getOutput(){
            return average;
        }
        
    private:
        float buffer[WINDOW_SIZE];
        float input_value;
        float sum;
        float average;
        uint32_t index;
};

int main() {
	MovingAverage<32> mvAvg;

	for (int i = 0; i < 32; i++) {
		mvAvg.setInput(514);
		mvAvg.calculate();
	}

	for (int i = 0; i < 128; i++) {
		mvAvg.setInput(128);
		mvAvg.calculate();
	}

	cout << mvAvg.getOutput() << endl;
	return 0;
}
