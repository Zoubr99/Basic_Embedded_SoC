#include "uart_core.h"

// here we will implement the uart classes defined in the uart_core.h
// explanations of the mthods used here are in uart_core.h



//constructor
UartCore::UartCore(uint32_t core_base_addr)
{
base_addr = core_base_addr; // when a uart obj is instantiated it will be automatically passed the <<get_slot_addr>> macro
set_baud_rate(9600); // 9600 is gonna be the default baud rate
}


//destructor
UartCore::~UartCore(){}


// baud rate = sys_clk_freq/16/(dvsr+1)
void UartCore::set_baud_rate(int baud) // baud -> dvsr -> io_write
{
    uint32_t dvsr; 
    dvsr = SYS_CLK_FREQ*1000000 / 16 / baud - 1; // to calculate the dvsr to be written onto the dvsr reg
    io_write(base_addr, DVSR_REG, dvsr); // the macro to write to the dvsr reg
}


// receiver fifo empty check
void UartCore::rx_fifo_empty() 
{
    uint32_t rd_word;
    int empty;

    rd_word = io_read(base_addr, RD_DATA_REG);
    empty = (int) (rd_word & RX_EMPTY_FIELD) >> 8;
    return (empty);
}


// transmitter fifo full check
void UartCore::tx_fifo_full () 
{   
    uint32_t rd_word;
    int full;

    rd_word = io_read(base_addr, RD_DATA_REG);
    full = (int) (rd_word & TX_FULL_FIELD);
    return (full);
}


// 8 bit (byte) writting into the transmitting fifo method
void UartCore::tx_byte(uint8_t byte)
{
    // fifo busy loop
    while(tx_fifo_full){};
    io_write(base_addr, WRR_DATA_REG, (uint32_t) byte);
}


// 8 bit (byte) reading from the receicing fifo method
int UartCore::rx_byte()
{
    uint32_t data;

    if(rx_fifo_empty())
    {
        return (-1);
    }

    else
    {
        data = io_read(base_addr, RD_DATA_REG) & RX_DATA_FIELD;
        io_write(base_addr, RM_RD_DATA_REG, 0); // this is the dummy data reg
        return ((int) data);
    }

}