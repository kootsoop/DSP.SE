#include <iostream>
#include <vector>
#include <cassert>
using namespace std;

void
Scramble(std::vector<uint8_t> &u8vIn)
{
    uint32_t m_nLSR = 0;
    uint8_t bit;
    std::vector<uint8_t> buffer(u8vIn.size());
    for(unsigned int i = 0; i < u8vIn.size(); i++)
    {
        bit = u8vIn[i]^((m_nLSR >> 12) & 1)^((m_nLSR >> 17) & 1);
        m_nLSR = (m_nLSR << 1) | bit;
        buffer[i] = bit;
    }
    u8vIn.clear();
    u8vIn = buffer;
}

void
Descramble(std::vector<uint8_t> &u8vIn)
{
    uint32_t m_nLSR = 0;
    uint8_t bit;
    std::vector<uint8_t> buffer(u8vIn.size());
    for(unsigned int i = 0; i < u8vIn.size(); i++)
    {
        //bit = (m_nLSR & 1)^((m_nLSR >> 12) & 1)^((m_nLSR >> 17) & 1);
        bit = u8vIn[i]^((m_nLSR >> 12) & 1)^((m_nLSR >> 17) & 1);
        m_nLSR = (m_nLSR << 1) | u8vIn[i];
        buffer[i] = bit;
    }
    u8vIn.clear();
    u8vIn = buffer;
}

void
GenRand(int nLength, std::vector<uint8_t> &u8vIn)
{
    // PRBS 7 : x^7 + x^6 + 1
    uint8_t  nPRBS7Start  = 0x7f;
    uint8_t  nPRBS7Out    = nPRBS7Start;
    for(int i = 0; i < nLength; i++)
    {
        uint8_t newbit = (((nPRBS7Out >> 6) ^ (nPRBS7Out >> 5)) & 1);
        nPRBS7Out = ((nPRBS7Out << 1) | newbit) & 0x7f;
        u8vIn.push_back(newbit);
    }
}

int
Bert(std::vector<uint8_t> u8Seq1, std::vector<uint8_t> u8Seq2)
{
    assert(u8Seq1.size() == u8Seq2.size());
    int errors = 0;
    for(unsigned int i = 0; i < u8Seq1.size(); i++)
        errors += u8Seq1[i]^u8Seq2[i] ? 1:0;
    return errors;
}


int main()
{
    // Generate random data
    std::vector<uint8_t> prbs, buff;
    GenRand(128,prbs);
    buff = prbs;

    for (int i=0; i<128; i++)
	cout << unsigned(prbs[i]);
    cout << endl;

    // G3RUH Scrambling
    Scramble(prbs);

    for (int i=0; i<128; i++)
	cout << unsigned(prbs[i]);
    cout << endl;

    // G3RUH Descrambling
    Descramble(prbs);

    for (int i=0; i<128; i++)
	cout << unsigned(prbs[i]);
    cout << endl;

    for (int i=0; i<128; i++)
	cout << unsigned(buff[i]);
    cout << endl;

    // BERT
    int errors = Bert(buff,prbs);
    cout << "NumErrors=" << errors<< endl;
    return 0;
}
