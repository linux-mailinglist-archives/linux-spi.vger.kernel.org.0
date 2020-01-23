Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F051460A9
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 03:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAWCQi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 21:16:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:56725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAWCQh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jan 2020 21:16:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 18:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,352,1574150400"; 
   d="scan'208";a="400197161"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2020 18:16:35 -0800
Received: from [10.226.38.32] (unknown [10.226.38.32])
        by linux.intel.com (Postfix) with ESMTP id 8C8FC58033E;
        Wed, 22 Jan 2020 18:16:32 -0800 (PST)
Subject: Re: [PATCH v7 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        dan.carpenter@oracle.com, cheol.yong.kim@intel.com,
        "qi-ming.wu@intel.com; ley.foon.tan@intel.com; grmoore"@opensource.altera.com
References: <20200122091340.43986-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200122091340.43986-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qswkbD2bc2QBzt=pHd5OyT00sYqffoEYe4Aiij_vMWxZZw@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <197d5054-f595-02ab-a987-7f47ebcf278f@linux.intel.com>
Date:   Thu, 23 Jan 2020 10:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAAh8qswkbD2bc2QBzt=pHd5OyT00sYqffoEYe4Aiij_vMWxZZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 22/1/2020 5:58 PM, Simon Goldschmidt wrote:
> On Wed, Jan 22, 2020 at 10:15 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
> In a previous thread, you wrote this was tested on Intel and TI SoCs. Does that
> mean this is not yet tested for Altera SoCs (or Intel FPGAs if you like) using
> this IP?
Currently Intel, TI and Altera-FPGA based SoC's use the same IP as well 
as same driver in the path: drivers/mtd/spi-nor/cadence-quadspi.c
This driver file supports to spi-nor framework only, it didn't support 
other SPI based flash memories(like spi-nand).

we didn't change the existing functionalities from the mentioned driver 
file., but we have adapted the same driver w.r.t SPI-MEM based
framework to support  SPI-NOR/SPI-NAND.

The SPI based  flash memories already using and going to use the spi-mem 
based framework in the future, So Vignesh and myself decided to
use the existing spi-mem based framework instead of SPI based legacy 
SPI-NAND and SPI-NOR different drivers in different paths.

To avoid the duplication of drivers and maintenance issues in different 
places for the same IP,  We have written the  driver from
cadence-quadspi.c and tested on TI and Intel, it's working fine.

Hopefully, it will work on Altera-FPGA platform as well, Let me add them 
in the mail chain as well.

Thanks! a lot for Query

Regards
Vadivel
>
> Regards,
> Simon
>
>> This driver does not support generic SPI and also the implementation
>> only supports spi-mem interface to replace the existing driver in
>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>> flash memory.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>   drivers/spi/Kconfig               |    8 +
>>   drivers/spi/Makefile              |    1 +
>>   drivers/spi/spi-cadence-quadspi.c | 1563 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1572 insertions(+)
>>   create mode 100644 drivers/spi/spi-cadence-quadspi.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 870f7797b56b..6d48a89737a4 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -193,6 +193,14 @@ config SPI_CADENCE
>>            This selects the Cadence SPI controller master driver
>>            used by Xilinx Zynq and ZynqMP.
>>
>> +config SPI_CADENCE_QUADSPI
>> +       tristate "Cadence Quad SPI controller"
>> +       depends on OF && (ARM || ARM64 || COMPILE_TEST || X86)
>> +       depends on MTD || MTD_SPI_NOR || MTD_SPI_NAND
>> +       help
>> +         Cadence QSPI is a specialized controller for connecting an SPI
>> +         Flash over 1/2/4/8-bit wide bus. This enables support for the Quad SPI
>> +
>>   config SPI_CLPS711X
>>          tristate "CLPS711X host SPI controller"
>>          depends on ARCH_CLPS711X || COMPILE_TEST
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index bb49c9e6d0a0..288f5fa903fe 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_SPI_BCM_QSPI)            += spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.
>>   obj-$(CONFIG_SPI_BITBANG)              += spi-bitbang.o
>>   obj-$(CONFIG_SPI_BUTTERFLY)            += spi-butterfly.o
>>   obj-$(CONFIG_SPI_CADENCE)              += spi-cadence.o
>> +obj-$(CONFIG_SPI_CADENCE_QUADSPI)      += spi-cadence-quadspi.o
>>   obj-$(CONFIG_SPI_CLPS711X)             += spi-clps711x.o
>>   obj-$(CONFIG_SPI_COLDFIRE_QSPI)                += spi-coldfire-qspi.o
>>   obj-$(CONFIG_SPI_DAVINCI)              += spi-davinci.o
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> new file mode 100644
>> index 000000000000..94c84b3d9c8d
>> --- /dev/null
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -0,0 +1,1563 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Driver for Cadence QSPI Controller
>> + *
>> + * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
>> + * Copyright Intel Corporation (C) 2019-2020. All rights reserved.
>> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>> +#include <linux/sched.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/spi/spi-mem.h>
>> +#include <linux/timer.h>
>> +
>> +#define CQSPI_NAME                     "cadence-qspi"
>> +#define CQSPI_MAX_CHIPSELECT           16
>> +
>> +/* Quirks */
>> +#define CQSPI_NEEDS_WR_DELAY           BIT(0)
>> +#define CQSPI_DISABLE_DAC_MODE         BIT(1)
>> +
>> +/* Capabilities*/
>> +#define CQSPI_SUPPORTS_OCTAL           BIT(0)
>> +
>> +struct cqspi_st;
>> +
>> +struct cqspi_flash_pdata {
>> +       struct cqspi_st *cqspi;
>> +       u32             clk_rate;
>> +       u32             read_delay;
>> +       u32             tshsl_ns;
>> +       u32             tsd2d_ns;
>> +       u32             tchsh_ns;
>> +       u32             tslch_ns;
>> +       u8              inst_width;
>> +       u8              addr_width;
>> +       u8              data_width;
>> +       u8              cs;
>> +       bool            registered;
>> +};
>> +
>> +struct cqspi_st {
>> +       struct platform_device  *pdev;
>> +
>> +       struct clk              *clk;
>> +       unsigned int            sclk;
>> +
>> +       void __iomem            *iobase;
>> +       void __iomem            *ahb_base;
>> +       resource_size_t         ahb_size;
>> +       struct completion       transfer_complete;
>> +
>> +       struct dma_chan         *rx_chan;
>> +       struct completion       rx_dma_complete;
>> +       dma_addr_t              mmap_phys_base;
>> +
>> +       int                     current_cs;
>> +       unsigned long           master_ref_clk_hz;
>> +       u32                     fifo_depth;
>> +       u32                     fifo_width;
>> +       u32                     bus_num;
>> +       u32                     num_chipselect;
>> +       bool                    rclk_en;
>> +       u32                     trigger_address;
>> +       u32                     wr_delay;
>> +       bool                    use_dac_mode;
>> +       struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>> +};
>> +
>> +struct spi_mem_op_cadence {
>> +       const void      *tx_buf;
>> +       void            *rx_buf;
>> +       u32             len;
>> +       u32             tx_nbits:3;
>> +       u32             rx_nbits:3;
>> +};
>> +
>> +struct cqspi_driver_platdata {
>> +       u32 hwcaps_mask;
>> +       u8 quirks;
>> +};
>> +
>> +/* Operation timeout value */
>> +#define CQSPI_TIMEOUT_MS                       500
>> +#define CQSPI_READ_TIMEOUT_MS                  10
>> +
>> +/* Instruction type */
>> +#define CQSPI_INST_TYPE_SINGLE                 0
>> +#define CQSPI_INST_TYPE_DUAL                   1
>> +#define CQSPI_INST_TYPE_QUAD                   2
>> +#define CQSPI_INST_TYPE_OCTAL                  3
>> +
>> +#define CQSPI_DUMMY_CLKS_PER_BYTE              8
>> +#define CQSPI_DUMMY_BYTES_MAX                  4
>> +#define CQSPI_DUMMY_CLKS_MAX                   31
>> +
>> +#define CQSPI_STIG_DATA_LEN_MAX                        8
>> +
>> +/* Register map */
>> +#define CQSPI_REG_CONFIG                       0x00
>> +#define CQSPI_REG_CONFIG_ENABLE_MASK           BIT(0)
>> +#define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL      BIT(7)
>> +#define CQSPI_REG_CONFIG_DECODE_MASK           BIT(9)
>> +#define CQSPI_REG_CONFIG_CHIPSELECT_LSB                10
>> +#define CQSPI_REG_CONFIG_DMA_MASK              BIT(15)
>> +#define CQSPI_REG_CONFIG_BAUD_LSB              19
>> +#define CQSPI_REG_CONFIG_IDLE_LSB              31
>> +#define CQSPI_REG_CONFIG_CHIPSELECT_MASK       0xF
>> +#define CQSPI_REG_CONFIG_BAUD_MASK             0xF
>> +
>> +#define CQSPI_REG_RD_INSTR                     0x04
>> +#define CQSPI_REG_RD_INSTR_OPCODE_LSB          0
>> +#define CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB      8
>> +#define CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB       12
>> +#define CQSPI_REG_RD_INSTR_TYPE_DATA_LSB       16
>> +#define CQSPI_REG_RD_INSTR_MODE_EN_LSB         20
>> +#define CQSPI_REG_RD_INSTR_DUMMY_LSB           24
>> +#define CQSPI_REG_RD_INSTR_TYPE_INSTR_MASK     0x3
>> +#define CQSPI_REG_RD_INSTR_TYPE_ADDR_MASK      0x3
>> +#define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK      0x3
>> +#define CQSPI_REG_RD_INSTR_DUMMY_MASK          0x1F
>> +
>> +#define CQSPI_REG_WR_INSTR                     0x08
>> +#define CQSPI_REG_WR_INSTR_OPCODE_LSB          0
>> +#define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB       12
>> +#define CQSPI_REG_WR_INSTR_TYPE_DATA_LSB       16
>> +#define        CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK       3
>> +#define        CQSPI_REG_WR_INSTR_TYPE_DATA_MASK       3
>> +#define        CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS     8
>> +
>> +#define CQSPI_REG_DELAY                                0x0C
>> +#define CQSPI_REG_DELAY_TSLCH_LSB              0
>> +#define CQSPI_REG_DELAY_TCHSH_LSB              8
>> +#define CQSPI_REG_DELAY_TSD2D_LSB              16
>> +#define CQSPI_REG_DELAY_TSHSL_LSB              24
>> +#define CQSPI_REG_DELAY_TSLCH_MASK             0xFF
>> +#define CQSPI_REG_DELAY_TCHSH_MASK             0xFF
>> +#define CQSPI_REG_DELAY_TSD2D_MASK             0xFF
>> +#define CQSPI_REG_DELAY_TSHSL_MASK             0xFF
>> +
>> +#define CQSPI_REG_READCAPTURE                  0x10
>> +#define CQSPI_REG_READCAPTURE_BYPASS_LSB       0
>> +#define CQSPI_REG_READCAPTURE_DELAY_LSB                1
>> +#define CQSPI_REG_READCAPTURE_DELAY_MASK       0xF
>> +
>> +#define CQSPI_REG_SIZE                         0x14
>> +#define CQSPI_REG_SIZE_ADDRESS_LSB             0
>> +#define CQSPI_REG_SIZE_PAGE_LSB                        4
>> +#define CQSPI_REG_SIZE_BLOCK_LSB               16
>> +#define CQSPI_REG_SIZE_ADDRESS_MASK            0xF
>> +#define CQSPI_REG_SIZE_PAGE_MASK               0xFFF
>> +#define CQSPI_REG_SIZE_BLOCK_MASK              0x3F
>> +
>> +#define CQSPI_REG_SRAMPARTITION                        0x18
>> +#define CQSPI_REG_INDIRECTTRIGGER              0x1C
>> +
>> +#define CQSPI_REG_DMA                          0x20
>> +#define CQSPI_REG_DMA_SINGLE_LSB               0
>> +#define CQSPI_REG_DMA_BURST_LSB                        8
>> +#define CQSPI_REG_DMA_SINGLE_MASK              0xFF
>> +#define CQSPI_REG_DMA_BURST_MASK               0xFF
>> +
>> +#define CQSPI_REG_REMAP                                0x24
>> +#define CQSPI_REG_MODE_BIT                     0x28
>> +
>> +#define CQSPI_REG_SDRAMLEVEL                   0x2C
>> +#define CQSPI_REG_SDRAMLEVEL_RD_LSB            0
>> +#define CQSPI_REG_SDRAMLEVEL_WR_LSB            16
>> +#define CQSPI_REG_SDRAMLEVEL_RD_MASK           0xFFFF
>> +#define CQSPI_REG_SDRAMLEVEL_WR_MASK           0xFFFF
>> +
>> +#define CQSPI_REG_WR_COMPLETION_CTRL           0x38
>> +#define CQSPI_REG_WR_DISABLE_AUTO_POLL         BIT(14)
>> +
>> +#define CQSPI_REG_IRQSTATUS                    0x40
>> +#define CQSPI_REG_IRQMASK                      0x44
>> +
>> +#define CQSPI_REG_INDIRECTRD                   0x60
>> +#define CQSPI_REG_INDIRECTRD_START_MASK                BIT(0)
>> +#define CQSPI_REG_INDIRECTRD_CANCEL_MASK       BIT(1)
>> +#define CQSPI_REG_INDIRECTRD_DONE_MASK         BIT(5)
>> +
>> +#define CQSPI_REG_INDIRECTRDWATERMARK          0x64
>> +#define CQSPI_REG_INDIRECTRDSTARTADDR          0x68
>> +#define CQSPI_REG_INDIRECTRDBYTES              0x6C
>> +
>> +#define CQSPI_REG_CMDCTRL                      0x90
>> +#define CQSPI_REG_CMDCTRL_EXECUTE_MASK         BIT(0)
>> +#define CQSPI_REG_CMDCTRL_INPROGRESS_MASK      BIT(1)
>> +#define CQSPI_REG_CMDCTRL_WR_BYTES_LSB         12
>> +#define CQSPI_REG_CMDCTRL_WR_EN_LSB            15
>> +#define CQSPI_REG_CMDCTRL_ADD_BYTES_LSB                16
>> +#define CQSPI_REG_CMDCTRL_ADDR_EN_LSB          19
>> +#define CQSPI_REG_CMDCTRL_RD_BYTES_LSB         20
>> +#define CQSPI_REG_CMDCTRL_RD_EN_LSB            23
>> +#define CQSPI_REG_CMDCTRL_OPCODE_LSB           24
>> +#define CQSPI_REG_CMDCTRL_WR_BYTES_MASK                0x7
>> +#define CQSPI_REG_CMDCTRL_ADD_BYTES_MASK       0x3
>> +#define CQSPI_REG_CMDCTRL_RD_BYTES_MASK                0x7
>> +
>> +#define CQSPI_REG_INDIRECTWR                   0x70
>> +#define CQSPI_REG_INDIRECTWR_START_MASK                BIT(0)
>> +#define CQSPI_REG_INDIRECTWR_CANCEL_MASK       BIT(1)
>> +#define CQSPI_REG_INDIRECTWR_DONE_MASK         BIT(5)
>> +
>> +#define CQSPI_REG_INDIRECTWRWATERMARK          0x74
>> +#define CQSPI_REG_INDIRECTWRSTARTADDR          0x78
>> +#define CQSPI_REG_INDIRECTWRBYTES              0x7C
>> +
>> +#define CQSPI_REG_CMDADDRESS                   0x94
>> +#define CQSPI_REG_CMDREADDATALOWER             0xA0
>> +#define CQSPI_REG_CMDREADDATAUPPER             0xA4
>> +#define CQSPI_REG_CMDWRITEDATALOWER            0xA8
>> +#define CQSPI_REG_CMDWRITEDATAUPPER            0xAC
>> +
>> +/* Interrupt status bits */
>> +#define CQSPI_REG_IRQ_MODE_ERR                 BIT(0)
>> +#define CQSPI_REG_IRQ_UNDERFLOW                        BIT(1)
>> +#define CQSPI_REG_IRQ_IND_COMP                 BIT(2)
>> +#define CQSPI_REG_IRQ_IND_RD_REJECT            BIT(3)
>> +#define CQSPI_REG_IRQ_WR_PROTECTED_ERR         BIT(4)
>> +#define CQSPI_REG_IRQ_ILLEGAL_AHB_ERR          BIT(5)
>> +#define CQSPI_REG_IRQ_WATERMARK                        BIT(6)
>> +#define CQSPI_REG_IRQ_IND_SRAM_FULL            BIT(12)
>> +
>> +#define CQSPI_IRQ_MASK_RD              (CQSPI_REG_IRQ_WATERMARK        | \
>> +                                        CQSPI_REG_IRQ_IND_SRAM_FULL    | \
>> +                                        CQSPI_REG_IRQ_IND_COMP)
>> +
>> +#define CQSPI_IRQ_MASK_WR              (CQSPI_REG_IRQ_IND_COMP         | \
>> +                                        CQSPI_REG_IRQ_WATERMARK        | \
>> +                                        CQSPI_REG_IRQ_UNDERFLOW)
>> +
>> +#define CQSPI_IRQ_STATUS_MASK          0x1FFFF
>> +
>> +static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
>> +{
>> +       u32 val;
>> +
>> +       return readl_relaxed_poll_timeout(reg, val,
>> +                                         (((clr ? ~val : val) & mask) == mask),
>> +                                         10, CQSPI_TIMEOUT_MS * 1000);
>> +}
>> +
>> +static bool cqspi_is_idle(struct cqspi_st *cqspi)
>> +{
>> +       u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>> +
>> +       return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
>> +}
>> +
>> +static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
>> +{
>> +       u32 reg = readl(cqspi->iobase + CQSPI_REG_SDRAMLEVEL);
>> +
>> +       reg >>= CQSPI_REG_SDRAMLEVEL_RD_LSB;
>> +       return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
>> +}
>> +
>> +static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
>> +{
>> +       struct cqspi_st *cqspi = dev;
>> +       unsigned int irq_status;
>> +
>> +       /* Read interrupt status */
>> +       irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
>> +
>> +       /* Clear interrupt */
>> +       writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
>> +
>> +       irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
>> +
>> +       if (irq_status)
>> +               complete(&cqspi->transfer_complete);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static u32 cqspi_cmd2addr(const unsigned char *addr_buf, u32 addr_width)
>> +{
>> +       unsigned int addr = 0;
>> +       int i;
>> +
>> +              /* Invalid address return zero. */
>> +       if (addr_width > 4)
>> +               return 0;
>> +
>> +       for (i = 0; i < addr_width; i++) {
>> +               addr = addr << 8;
>> +               addr |= addr_buf[i];
>> +       }
>> +
>> +       return addr;
>> +}
>> +
>> +static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
>> +{
>> +       u32 rdreg = 0;
>> +
>> +       rdreg |= f_pdata->inst_width << CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB;
>> +       rdreg |= f_pdata->addr_width << CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB;
>> +       rdreg |= f_pdata->data_width << CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
>> +
>> +       return rdreg;
>> +}
>> +
>> +static int cqspi_wait_idle(struct cqspi_st *cqspi)
>> +{
>> +       const unsigned int poll_idle_retry = 3;
>> +       unsigned int count = 0;
>> +       unsigned long timeout;
>> +
>> +       timeout = jiffies + msecs_to_jiffies(CQSPI_TIMEOUT_MS);
>> +       while (1) {
>> +               /*
>> +                * Read few times in succession to ensure the controller
>> +                * is indeed idle, that is, the bit does not transition
>> +                * low again.
>> +                */
>> +               if (cqspi_is_idle(cqspi))
>> +                       count++;
>> +               else
>> +                       count = 0;
>> +
>> +               if (count >= poll_idle_retry)
>> +                       return 0;
>> +
>> +               if (time_after(jiffies, timeout)) {
>> +                       /* Timeout, in busy mode. */
>> +                       dev_err(&cqspi->pdev->dev,
>> +                               "QSPI is still busy after %dms timeout.\n",
>> +                               CQSPI_TIMEOUT_MS);
>> +                       return -ETIMEDOUT;
>> +               }
>> +
>> +               cpu_relax();
>> +       }
>> +}
>> +
>> +static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
>> +{
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       int ret;
>> +
>> +       /* Write the CMDCTRL without start execution. */
>> +       writel(reg, reg_base + CQSPI_REG_CMDCTRL);
>> +       /* Start execute */
>> +       reg |= CQSPI_REG_CMDCTRL_EXECUTE_MASK;
>> +       writel(reg, reg_base + CQSPI_REG_CMDCTRL);
>> +
>> +       /* Polling for completion. */
>> +       ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_CMDCTRL,
>> +                                CQSPI_REG_CMDCTRL_INPROGRESS_MASK, 1);
>> +       if (ret) {
>> +               dev_err(&cqspi->pdev->dev,
>> +                       "Flash command execution timed out.\n");
>> +               return ret;
>> +       }
>> +
>> +       /* Polling QSPI idle status. */
>> +       return cqspi_wait_idle(cqspi);
>> +}
>> +
>> +static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
>> +                             const struct spi_mem_op *op)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       u8 *rxbuf = op->data.buf.in;
>> +       u8 opcode = op->cmd.opcode;
>> +       size_t n_rx = op->data.nbytes;
>> +       size_t addrlen = op->addr.nbytes;
>> +       const u8 *addrbuf = (u8 *)op->addr.val;
>> +       unsigned int rdreg;
>> +       unsigned int reg, addr_value;
>> +       size_t read_len;
>> +       int status;
>> +
>> +       if (!n_rx || n_rx > CQSPI_STIG_DATA_LEN_MAX || !rxbuf) {
>> +               dev_err(&cqspi->pdev->dev,
>> +                       "Invalid input argument, len %zu rxbuf 0x%p\n",
>> +                       n_rx, rxbuf);
>> +               return -EINVAL;
>> +       }
>> +
>> +       reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
>> +       if (cqspi->use_dac_mode) {
>> +               rdreg = cqspi_calc_rdreg(f_pdata);
>> +               writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
>> +       }
>> +
>> +       reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
>> +
>> +       if (addrlen) {
>> +               reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
>> +               reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
>> +                       << CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
>> +               addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
>> +               writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
>> +       }
>> +
>> +       /* 0 means 1 byte. */
>> +       reg |= (((n_rx - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
>> +               << CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
>> +       status = cqspi_exec_flash_cmd(cqspi, reg);
>> +       if (status)
>> +               return status;
>> +
>> +       reg = readl(reg_base + CQSPI_REG_CMDREADDATALOWER);
>> +
>> +       /* Put the read value into rx_buf */
>> +       read_len = (n_rx > 4) ? 4 : n_rx;
>> +       memcpy(rxbuf, &reg, read_len);
>> +       rxbuf += read_len;
>> +
>> +       if (n_rx > 4) {
>> +               reg = readl(reg_base + CQSPI_REG_CMDREADDATAUPPER);
>> +
>> +               read_len = n_rx - read_len;
>> +               memcpy(rxbuf, &reg, read_len);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
>> +                              const struct spi_mem_op *op)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       const u8 opcode = op->cmd.opcode;
>> +       const u8 *txbuf = op->data.buf.out;
>> +       size_t n_tx = op->data.nbytes;
>> +       unsigned int reg;
>> +       unsigned int data;
>> +       size_t write_len;
>> +
>> +       if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
>> +               dev_err(&cqspi->pdev->dev,
>> +                       "Invalid input argument, cmdlen %zu txbuf 0x%p\n",
>> +                       n_tx, txbuf);
>> +               return -EINVAL;
>> +       }
>> +
>> +       reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
>> +
>> +       if (op->addr.nbytes) {
>> +               reg |= (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
>> +               reg |= ((op->addr.nbytes - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
>> +               << CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
>> +
>> +               writel(op->addr.val, reg_base + CQSPI_REG_CMDADDRESS);
>> +       }
>> +
>> +       if (n_tx) {
>> +               reg |= (0x1 << CQSPI_REG_CMDCTRL_WR_EN_LSB);
>> +               reg |= ((n_tx - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
>> +                       << CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
>> +               data = 0;
>> +               write_len = (n_tx > 4) ? 4 : n_tx;
>> +               memcpy(&data, txbuf, write_len);
>> +               txbuf += write_len;
>> +               writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
>> +
>> +               if (n_tx > 4) {
>> +                       data = 0;
>> +                       write_len = n_tx - 4;
>> +                       memcpy(&data, txbuf, write_len);
>> +                       writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER);
>> +               }
>> +       }
>> +
>> +       return cqspi_exec_flash_cmd(cqspi, reg);
>> +}
>> +
>> +static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
>> +                           const struct spi_mem_op *op, const u8 *addrbuf)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       size_t dummy_bytes = op->dummy.nbytes;
>> +       size_t addrlen = op->addr.nbytes;
>> +       unsigned int reg, addr_value;
>> +       unsigned int dummy_clk = 0;
>> +
>> +       if (addrlen) {
>> +               addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
>> +               writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
>> +       }
>> +
>> +       reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
>> +       if (cqspi->use_dac_mode) {
>> +               reg |= cqspi_calc_rdreg(f_pdata);
>> +
>> +               /* Setup dummy clock cycles */
>> +               dummy_clk = op->dummy.nbytes * 8;
>> +               if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
>> +                       dummy_clk = CQSPI_DUMMY_CLKS_MAX;
>> +
>> +               if (dummy_clk / 8)
>> +                       reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
>> +                              << CQSPI_REG_RD_INSTR_DUMMY_LSB;
>> +       } else {
>> +               reg |= (CQSPI_INST_TYPE_QUAD & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
>> +                       CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
>> +
>> +               if (dummy_bytes) {
>> +                       if (dummy_bytes > CQSPI_DUMMY_BYTES_MAX)
>> +                               dummy_bytes = CQSPI_DUMMY_BYTES_MAX;
>> +
>> +                       reg |= BIT(CQSPI_REG_RD_INSTR_MODE_EN_LSB);
>> +
>> +                       writel(0xFF, reg_base + CQSPI_REG_MODE_BIT);
>> +
>> +                       dummy_clk = dummy_bytes * CQSPI_DUMMY_CLKS_PER_BYTE;
>> +                       dummy_clk -= CQSPI_DUMMY_CLKS_PER_BYTE;
>> +
>> +                       if (dummy_clk)
>> +                               reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
>> +                                       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
>> +               }
>> +       }
>> +       writel(reg, reg_base + CQSPI_REG_RD_INSTR);
>> +
>> +       /* Set address width */
>> +       reg = readl(reg_base + CQSPI_REG_SIZE);
>> +       reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
>> +       reg |= (op->addr.nbytes - 1);
>> +       writel(reg, reg_base + CQSPI_REG_SIZE);
>> +
>> +       /* disable auto-polling */
>> +       reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
>> +       reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
>> +       writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
>> +
>> +       return 0;
>> +}
>> +
>> +static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
>> +                                      u8 *rxbuf, loff_t from_addr,
>> +                                      const size_t n_rx)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       struct device *dev = &cqspi->pdev->dev;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       void __iomem *ahb_base = cqspi->ahb_base;
>> +       unsigned int remaining = n_rx;
>> +       unsigned int mod_bytes = n_rx % 4;
>> +       unsigned int bytes_to_read = 0;
>> +       u8 *rxbuf_end = rxbuf + n_rx;
>> +       int ret = 0;
>> +
>> +       writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
>> +       writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
>> +
>> +       /* Clear all interrupts. */
>> +       writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
>> +
>> +       writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
>> +
>> +       reinit_completion(&cqspi->transfer_complete);
>> +       writel(CQSPI_REG_INDIRECTRD_START_MASK,
>> +              reg_base + CQSPI_REG_INDIRECTRD);
>> +
>> +       while (remaining > 0) {
>> +               if (!wait_for_completion_timeout(&cqspi->transfer_complete,
>> +                                                msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
>> +                       ret = -ETIMEDOUT;
>> +
>> +               bytes_to_read = cqspi_get_rd_sram_level(cqspi);
>> +
>> +               if (ret && bytes_to_read == 0) {
>> +                       dev_err(dev, "Indirect read timeout, no bytes\n");
>> +                       goto failrd;
>> +               }
>> +
>> +               while (bytes_to_read != 0) {
>> +                       unsigned int word_remain = round_down(remaining, 4);
>> +
>> +                       bytes_to_read *= cqspi->fifo_width;
>> +                       bytes_to_read = bytes_to_read > remaining ?
>> +                                       remaining : bytes_to_read;
>> +                       bytes_to_read = round_down(bytes_to_read, 4);
>> +                       /* Read 4 byte word chunks then single bytes */
>> +                       if (bytes_to_read) {
>> +                               ioread32_rep(ahb_base, rxbuf,
>> +                                            (bytes_to_read / 4));
>> +                       } else if (!word_remain && mod_bytes) {
>> +                               unsigned int temp = ioread32(ahb_base);
>> +
>> +                               bytes_to_read = mod_bytes;
>> +                               memcpy(rxbuf, &temp, min((unsigned int)
>> +                                                        (rxbuf_end - rxbuf),
>> +                                                        bytes_to_read));
>> +                       }
>> +                       rxbuf += bytes_to_read;
>> +                       remaining -= bytes_to_read;
>> +                       bytes_to_read = cqspi_get_rd_sram_level(cqspi);
>> +               }
>> +
>> +               if (remaining > 0)
>> +                       reinit_completion(&cqspi->transfer_complete);
>> +       }
>> +
>> +       /* Check indirect done status */
>> +       ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTRD,
>> +                                CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
>> +       if (ret) {
>> +               dev_err(dev, "Indirect read completion error (%i)\n", ret);
>> +               goto failrd;
>> +       }
>> +
>> +       /* Disable interrupt */
>> +       writel(0, reg_base + CQSPI_REG_IRQMASK);
>> +
>> +       /* Clear indirect completion status */
>> +       writel(CQSPI_REG_INDIRECTRD_DONE_MASK, reg_base + CQSPI_REG_INDIRECTRD);
>> +
>> +       return 0;
>> +
>> +failrd:
>> +       /* Disable interrupt */
>> +       writel(0, reg_base + CQSPI_REG_IRQMASK);
>> +
>> +       /* Cancel the indirect read */
>> +       writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
>> +              reg_base + CQSPI_REG_INDIRECTRD);
>> +       return ret;
>> +}
>> +
>> +static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
>> +                            const struct spi_mem_op *op, const u8 *addrbuf)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       size_t addrlen = op->addr.nbytes;
>> +       const u8 *txbuf = &op->cmd.opcode;
>> +       unsigned int reg;
>> +
>> +       if (cqspi->use_dac_mode) {
>> +               /* Set opcode. */
>> +               reg = op->cmd.opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
>> +               writel(reg, reg_base + CQSPI_REG_WR_INSTR);
>> +               reg = cqspi_calc_rdreg(f_pdata);
>> +               writel(reg, reg_base + CQSPI_REG_RD_INSTR);
>> +       } else {
>> +               reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +               reg &= ~(CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL);
>> +               reg &= ~(CQSPI_REG_CONFIG_DMA_MASK);
>> +               writel(reg, reg_base + CQSPI_REG_CONFIG);
>> +
>> +               /* Set opcode. */
>> +               reg = txbuf[0] << CQSPI_REG_WR_INSTR_OPCODE_LSB;
>> +               reg |= BIT(CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS);
>> +               /* Configure the mode for address */
>> +               reg |= (CQSPI_INST_TYPE_QUAD & CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK) <<
>> +                       CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
>> +
>> +               /* Configure the mode for data */
>> +               reg |= (CQSPI_INST_TYPE_QUAD & CQSPI_REG_WR_INSTR_TYPE_DATA_MASK) <<
>> +                       CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
>> +               writel(reg, reg_base + CQSPI_REG_WR_INSTR);
>> +               /* Setup write address. */
>> +               reg = cqspi_cmd2addr(&addrbuf[0], addrlen);
>> +               writel(reg, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
>> +       }
>> +
>> +       reg = readl(reg_base + CQSPI_REG_SIZE);
>> +       reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
>> +       reg |= ((addrlen - 1) & CQSPI_REG_SIZE_ADDRESS_MASK);
>> +       writel(reg, reg_base + CQSPI_REG_SIZE);
>> +       return 0;
>> +}
>> +
>> +static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>> +                                       loff_t to_addr, const u8 *txbuf,
>> +                                       const size_t n_tx)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       struct device *dev = &cqspi->pdev->dev;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       unsigned int remaining = n_tx;
>> +       unsigned int write_bytes;
>> +       int ret;
>> +
>> +       writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
>> +       writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
>> +
>> +       /* Clear all interrupts. */
>> +       writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
>> +
>> +       writel(CQSPI_IRQ_MASK_WR, reg_base + CQSPI_REG_IRQMASK);
>> +
>> +       reinit_completion(&cqspi->transfer_complete);
>> +       writel(CQSPI_REG_INDIRECTWR_START_MASK,
>> +              reg_base + CQSPI_REG_INDIRECTWR);
>> +       /*
>> +        * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
>> +        * Controller programming sequence, couple of cycles of
>> +        * QSPI_REF_CLK delay is required for the above bit to
>> +        * be internally synchronized by the QSPI module. Provide 5
>> +        * cycles of delay.
>> +        */
>> +       if (cqspi->wr_delay)
>> +               ndelay(cqspi->wr_delay);
>> +
>> +       while (remaining > 0) {
>> +               size_t write_words, mod_bytes;
>> +
>> +               write_bytes = remaining;
>> +               write_words = write_bytes / 4;
>> +               mod_bytes = write_bytes % 4;
>> +               /* Write 4 bytes at a time then single bytes. */
>> +               if (write_words) {
>> +                       iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
>> +                       txbuf += (write_words * 4);
>> +               }
>> +               if (mod_bytes) {
>> +                       unsigned int temp = 0xFFFFFFFF;
>> +
>> +                       memcpy(&temp, txbuf, mod_bytes);
>> +                       iowrite32(temp, cqspi->ahb_base);
>> +                       txbuf += mod_bytes;
>> +               }
>> +
>> +               if (!wait_for_completion_timeout(&cqspi->transfer_complete,
>> +                                                msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
>> +                       dev_err(dev, "Indirect write timeout\n");
>> +                       ret = -ETIMEDOUT;
>> +                       goto failwr;
>> +               }
>> +
>> +               remaining -= write_bytes;
>> +
>> +               if (remaining > 0)
>> +                       reinit_completion(&cqspi->transfer_complete);
>> +       }
>> +
>> +       /* Check indirect done status */
>> +       ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTWR,
>> +                                CQSPI_REG_INDIRECTWR_DONE_MASK, 0);
>> +       if (ret) {
>> +               dev_err(dev, "Indirect write completion error (%i)\n", ret);
>> +               goto failwr;
>> +       }
>> +
>> +       /* Disable interrupt. */
>> +       writel(0, reg_base + CQSPI_REG_IRQMASK);
>> +
>> +       /* Clear indirect completion status */
>> +       writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
>> +
>> +       cqspi_wait_idle(cqspi);
>> +
>> +       return 0;
>> +
>> +failwr:
>> +       /* Disable interrupt. */
>> +       writel(0, reg_base + CQSPI_REG_IRQMASK);
>> +
>> +       /* Cancel the indirect write */
>> +       writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
>> +              reg_base + CQSPI_REG_INDIRECTWR);
>> +       return ret;
>> +}
>> +
>> +static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       unsigned int chip_select = f_pdata->cs;
>> +       unsigned int reg;
>> +
>> +       reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +       reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
>> +
>> +       /* Convert CS if without decoder.
>> +        * CS0 to 4b'1110
>> +        * CS1 to 4b'1101
>> +        * CS2 to 4b'1011
>> +        * CS3 to 4b'0111
>> +        */
>> +       chip_select = 0xF & ~(1 << chip_select);
>> +
>> +       reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
>> +                << CQSPI_REG_CONFIG_CHIPSELECT_LSB);
>> +       reg |= (chip_select & CQSPI_REG_CONFIG_CHIPSELECT_MASK)
>> +           << CQSPI_REG_CONFIG_CHIPSELECT_LSB;
>> +       writel(reg, reg_base + CQSPI_REG_CONFIG);
>> +}
>> +
>> +static unsigned int calculate_ticks_for_ns(const unsigned int ref_clk_hz,
>> +                                          const unsigned int ns_val)
>> +{
>> +       unsigned int ticks;
>> +
>> +       ticks = ref_clk_hz / 1000;      /* kHz */
>> +       ticks = DIV_ROUND_UP(ticks * ns_val, 1000000);
>> +
>> +       return ticks;
>> +}
>> +
>> +static void cqspi_delay(struct cqspi_flash_pdata *f_pdata)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       void __iomem *iobase = cqspi->iobase;
>> +       const unsigned int ref_clk_hz = cqspi->master_ref_clk_hz;
>> +       unsigned int tshsl, tchsh, tslch, tsd2d;
>> +       unsigned int reg;
>> +       unsigned int tsclk;
>> +
>> +       /* calculate the number of ref ticks for one sclk tick */
>> +       tsclk = DIV_ROUND_UP(ref_clk_hz, cqspi->sclk);
>> +
>> +       tshsl = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tshsl_ns);
>> +       /* this particular value must be at least one sclk */
>> +       if (tshsl < tsclk)
>> +               tshsl = tsclk;
>> +
>> +       tchsh = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tchsh_ns);
>> +       tslch = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tslch_ns);
>> +       tsd2d = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tsd2d_ns);
>> +
>> +       reg = (tshsl & CQSPI_REG_DELAY_TSHSL_MASK)
>> +              << CQSPI_REG_DELAY_TSHSL_LSB;
>> +       reg |= (tchsh & CQSPI_REG_DELAY_TCHSH_MASK)
>> +               << CQSPI_REG_DELAY_TCHSH_LSB;
>> +       reg |= (tslch & CQSPI_REG_DELAY_TSLCH_MASK)
>> +               << CQSPI_REG_DELAY_TSLCH_LSB;
>> +       reg |= (tsd2d & CQSPI_REG_DELAY_TSD2D_MASK)
>> +               << CQSPI_REG_DELAY_TSD2D_LSB;
>> +       writel(reg, iobase + CQSPI_REG_DELAY);
>> +}
>> +
>> +static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
>> +{
>> +       const unsigned int ref_clk_hz = cqspi->master_ref_clk_hz;
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       u32 reg, div;
>> +
>> +       /* Recalculate the baudrate divisor based on QSPI specification. */
>> +       div = DIV_ROUND_UP(ref_clk_hz, 2 * cqspi->sclk) - 1;
>> +
>> +       reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +       reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
>> +       reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
>> +       writel(reg, reg_base + CQSPI_REG_CONFIG);
>> +}
>> +
>> +static void cqspi_readdata_capture(struct cqspi_st *cqspi,
>> +                                  const bool bypass,
>> +                                  const unsigned int delay)
>> +{
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       unsigned int reg;
>> +
>> +       reg = readl(reg_base + CQSPI_REG_READCAPTURE);
>> +
>> +       if (bypass)
>> +               reg |= (1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
>> +       else
>> +               reg &= ~(1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
>> +
>> +       reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
>> +                << CQSPI_REG_READCAPTURE_DELAY_LSB);
>> +
>> +       reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
>> +               << CQSPI_REG_READCAPTURE_DELAY_LSB;
>> +
>> +       writel(reg, reg_base + CQSPI_REG_READCAPTURE);
>> +}
>> +
>> +static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
>> +{
>> +       void __iomem *reg_base = cqspi->iobase;
>> +       unsigned int reg;
>> +
>> +       reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +
>> +       if (enable)
>> +               reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
>> +       else
>> +               reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
>> +
>> +       writel(reg, reg_base + CQSPI_REG_CONFIG);
>> +}
>> +
>> +static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
>> +                           unsigned long sclk)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       int switch_cs = (cqspi->current_cs != f_pdata->cs);
>> +       int switch_ck = (cqspi->sclk != sclk);
>> +
>> +       if (switch_cs || switch_ck)
>> +               cqspi_controller_enable(cqspi, 0);
>> +
>> +       /* Switch chip select. */
>> +       if (switch_cs) {
>> +               cqspi->current_cs = f_pdata->cs;
>> +               cqspi_chipselect(f_pdata);
>> +       }
>> +
>> +       /* Setup baudrate divisor and delays */
>> +       if (switch_ck) {
>> +               cqspi->sclk = sclk;
>> +               cqspi_config_baudrate_div(cqspi);
>> +               cqspi_delay(f_pdata);
>> +               cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
>> +                                      f_pdata->read_delay);
>> +       }
>> +
>> +       if (switch_cs || switch_ck)
>> +               cqspi_controller_enable(cqspi, 1);
>> +}
>> +
>> +static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
>> +                             const struct spi_mem_op *op)
>> +{
>> +       f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
>> +       f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
>> +       f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
>> +
>> +       if (op->data.dir == SPI_MEM_DATA_IN) {
>> +               switch (op->data.buswidth) {
>> +               case 1:
>> +                       f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
>> +                       break;
>> +               case 2:
>> +                       f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
>> +                       break;
>> +               case 4:
>> +                       f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>> +                       break;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
>> +                          const struct spi_mem_op *op, const u8 *addrbuf)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       loff_t to = op->addr.val;
>> +       size_t len = op->data.nbytes;
>> +       const u_char *buf = op->data.buf.out;
>> +       int ret;
>> +
>> +       ret = cqspi_set_protocol(f_pdata, op);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = cqspi_write_setup(f_pdata, op, addrbuf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (cqspi->use_dac_mode && ((to + len) <= cqspi->ahb_size)) {
>> +               memcpy_toio(cqspi->ahb_base + to, buf, len);
>> +               return cqspi_wait_idle(cqspi);
>> +       }
>> +
>> +       return cqspi_indirect_write_execute(f_pdata, to, buf, len);
>> +}
>> +
>> +static void cqspi_rx_dma_callback(void *param)
>> +{
>> +       struct cqspi_st *cqspi = param;
>> +
>> +       complete(&cqspi->rx_dma_complete);
>> +}
>> +
>> +static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>> +                                    u_char *buf, loff_t from, size_t len)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       struct device *dev = &cqspi->pdev->dev;
>> +       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>> +       dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
>> +       int ret = 0;
>> +       struct dma_async_tx_descriptor *tx;
>> +       dma_cookie_t cookie;
>> +       dma_addr_t dma_dst;
>> +
>> +       if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
>> +               memcpy_fromio(buf, cqspi->ahb_base + from, len);
>> +               return 0;
>> +       }
>> +
>> +       dma_dst = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
>> +       if (dma_mapping_error(dev, dma_dst)) {
>> +               dev_err(dev, "dma mapping failed\n");
>> +               return -ENOMEM;
>> +       }
>> +       tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
>> +                                      len, flags);
>> +       if (!tx) {
>> +               dev_err(dev, "device_prep_dma_memcpy error\n");
>> +               ret = -EIO;
>> +               goto err_unmap;
>> +       }
>> +
>> +       tx->callback = cqspi_rx_dma_callback;
>> +       tx->callback_param = cqspi;
>> +       cookie = tx->tx_submit(tx);
>> +       reinit_completion(&cqspi->rx_dma_complete);
>> +
>> +       ret = dma_submit_error(cookie);
>> +       if (ret) {
>> +               dev_err(dev, "dma_submit_error %d\n", cookie);
>> +               ret = -EIO;
>> +               goto err_unmap;
>> +       }
>> +
>> +       dma_async_issue_pending(cqspi->rx_chan);
>> +       if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
>> +                                        msecs_to_jiffies(len))) {
>> +               dmaengine_terminate_sync(cqspi->rx_chan);
>> +               dev_err(dev, "DMA wait_for_completion_timeout\n");
>> +               ret = -ETIMEDOUT;
>> +               goto err_unmap;
>> +       }
>> +
>> +err_unmap:
>> +       dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
>> +
>> +       return ret;
>> +}
>> +
>> +static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
>> +                         const struct spi_mem_op *op, const u8 *addrbuf)
>> +{
>> +       struct cqspi_st *cqspi = f_pdata->cqspi;
>> +       loff_t from = op->addr.val;
>> +       size_t len = op->data.nbytes;
>> +       u_char *buf = op->data.buf.in;
>> +       int ret;
>> +
>> +       ret = cqspi_set_protocol(f_pdata, op);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = cqspi_read_setup(f_pdata, op, addrbuf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (cqspi->use_dac_mode && ((from + len) <= cqspi->ahb_size))
>> +               return cqspi_direct_read_execute(f_pdata, buf, from, len);
>> +
>> +       return cqspi_indirect_read_execute(f_pdata, buf, from, len);
>> +}
>> +
>> +static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +       struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
>> +       struct cqspi_flash_pdata *f_pdata;
>> +       unsigned int tmpbufsize, n_trans = 0;
>> +       struct spi_mem_op_cadence ops[2] = { };
>> +       struct spi_mem_op_cadence *addr_ops = NULL;
>> +       u8 *tmpbuf;
>> +
>> +       f_pdata = &cqspi->f_pdata[mem->spi->chip_select];
>> +       cqspi_configure(f_pdata, mem->spi->max_speed_hz);
>> +
>> +       tmpbufsize = sizeof(op->cmd.opcode) + op->addr.nbytes +
>> +                       op->dummy.nbytes;
>> +       tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
>> +       if (!tmpbuf)
>> +               return -ENOMEM;
>> +
>> +       tmpbuf[0] = op->cmd.opcode;
>> +       ops[n_trans].tx_buf = tmpbuf;
>> +       ops[n_trans].len = sizeof(op->cmd.opcode);
>> +       ops[n_trans].tx_nbits = op->cmd.buswidth;
>> +
>> +       n_trans++;
>> +       if (op->addr.nbytes) {
>> +               int i;
>> +
>> +               for (i = 0; i < op->addr.nbytes; i++)
>> +                       tmpbuf[i + 1] = op->addr.val >>
>> +                                       (8 * (op->addr.nbytes - i - 1));
>> +
>> +               ops[n_trans].tx_buf = tmpbuf + 1;
>> +               ops[n_trans].len = op->addr.nbytes;
>> +               ops[n_trans].tx_nbits = op->addr.buswidth;
>> +       }
>> +       if (!cqspi->use_dac_mode)
>> +               addr_ops = &ops[1];
>> +       else
>> +               addr_ops->tx_buf = NULL;
>> +
>> +       if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
>> +               if (!op->addr.nbytes)
>> +                       return cqspi_command_read(f_pdata, op);
>> +
>> +               return cqspi_read(f_pdata, op, addr_ops->tx_buf);
>> +       }
>> +
>> +       if (!op->addr.nbytes || !op->data.buf.out)
>> +               return cqspi_command_write(f_pdata, op);
>> +
>> +       return cqspi_write(f_pdata, op, addr_ops->tx_buf);
>> +}
>> +
>> +static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +       int ret;
>> +
>> +       ret = cqspi_mem_process(mem, op);
>> +       if (ret)
>> +               dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
>> +
>> +       return ret;
>> +}
>> +
>> +static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>> +                                   struct cqspi_flash_pdata *f_pdata,
>> +                                   struct device_node *np)
>> +{
>> +       if (of_property_read_u32(np, "cdns,read-delay", &f_pdata->read_delay)) {
>> +               dev_err(&pdev->dev, "couldn't determine read-delay\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "cdns,tshsl-ns", &f_pdata->tshsl_ns)) {
>> +               dev_err(&pdev->dev, "couldn't determine tshsl-ns\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "cdns,tsd2d-ns", &f_pdata->tsd2d_ns)) {
>> +               dev_err(&pdev->dev, "couldn't determine tsd2d-ns\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "cdns,tchsh-ns", &f_pdata->tchsh_ns)) {
>> +               dev_err(&pdev->dev, "couldn't determine tchsh-ns\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "cdns,tslch-ns", &f_pdata->tslch_ns)) {
>> +               dev_err(&pdev->dev, "couldn't determine tslch-ns\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
>> +               dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>> +{
>> +       struct device *dev = &cqspi->pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
>> +               dev_err(dev, "couldn't determine fifo-depth\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "cdns,fifo-width", &cqspi->fifo_width)) {
>> +               dev_err(dev, "couldn't determine fifo-width\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "cdns,trigger-address",
>> +                                &cqspi->trigger_address)) {
>> +               dev_err(dev, "couldn't determine trigger-address\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "bus-num",
>> +                                &cqspi->bus_num)) {
>> +               dev_err(dev, "couldn't determine bus number\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_property_read_u32(np, "num-chipselect",
>> +                                &cqspi->num_chipselect)) {
>> +               dev_err(dev, "couldn't determine number of chipselect\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (cqspi->use_dac_mode)
>> +               cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
>> +
>> +       return 0;
>> +}
>> +
>> +static void cqspi_controller_init(struct cqspi_st *cqspi)
>> +{
>> +       cqspi_controller_enable(cqspi, 0);
>> +
>> +       /* Configure the remap address register, no remap */
>> +       writel(0, cqspi->iobase + CQSPI_REG_REMAP);
>> +
>> +       /* Disable all interrupts. */
>> +       writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
>> +
>> +       /* Configure the SRAM split to 1:1 . */
>> +       writel(cqspi->fifo_depth / 2, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
>> +
>> +       /* Load indirect trigger address. */
>> +       writel(cqspi->trigger_address,
>> +              cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
>> +
>> +       /* Program read watermark -- 1/2 of the FIFO. */
>> +       writel(cqspi->fifo_depth * cqspi->fifo_width / 2,
>> +              cqspi->iobase + CQSPI_REG_INDIRECTRDWATERMARK);
>> +       /* Program write watermark -- 1/8 of the FIFO. */
>> +       writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
>> +              cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
>> +
>> +       if (!cqspi->use_dac_mode) {
>> +               u32 reg;
>> +
>> +               reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>> +               reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>> +               writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>> +
>> +               reg = readl(cqspi->iobase + CQSPI_REG_WR_COMPLETION_CTRL);
>> +               reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
>> +               writel(reg, cqspi->iobase + CQSPI_REG_WR_COMPLETION_CTRL);
>> +       }
>> +
>> +       cqspi_controller_enable(cqspi, 1);
>> +}
>> +
>> +static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>> +{
>> +       dma_cap_mask_t mask;
>> +
>> +       dma_cap_zero(mask);
>> +       dma_cap_set(DMA_MEMCPY, mask);
>> +
>> +       cqspi->rx_chan = dma_request_chan_by_mask(&mask);
>> +       if (IS_ERR(cqspi->rx_chan)) {
>> +               int ret = PTR_ERR(cqspi->rx_chan);
>> +
>> +               if (ret == -EPROBE_DEFER)
>> +                       dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
>> +               cqspi->rx_chan = NULL;
>> +
>> +               return ret;
>> +       }
>> +       init_completion(&cqspi->rx_dma_complete);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct spi_controller_mem_ops cqspi_mem_ops = {
>> +       .exec_op = cqspi_exec_mem_op,
>> +};
>> +
>> +static int cqspi_setup_flash(struct cqspi_st *cqspi)
>> +{
>> +       struct platform_device *pdev = cqspi->pdev;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct cqspi_flash_pdata *f_pdata;
>> +       unsigned int cs;
>> +       int ret;
>> +
>> +       /* Get flash device data */
>> +       for_each_available_child_of_node(dev->of_node, np) {
>> +               ret = of_property_read_u32(np, "reg", &cs);
>> +               if (ret) {
>> +                       dev_err(dev, "Couldn't determine chip select.\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (cs >= CQSPI_MAX_CHIPSELECT) {
>> +                       dev_err(dev, "Chip select %d out of range.\n", cs);
>> +                       return -EINVAL;
>> +               }
>> +
>> +               f_pdata = &cqspi->f_pdata[cs];
>> +               f_pdata->cqspi = cqspi;
>> +               f_pdata->cs = cs;
>> +
>> +               return cqspi_of_get_flash_pdata(pdev, f_pdata, np);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int cqspi_probe(struct platform_device *pdev)
>> +{
>> +       const struct cqspi_driver_platdata *ddata;
>> +       struct reset_control *rstc, *rstc_ocp;
>> +       struct device *dev = &pdev->dev;
>> +       struct spi_master *master;
>> +       struct resource *res_ahb;
>> +       struct cqspi_st *cqspi;
>> +       struct resource *res;
>> +       int ret;
>> +       int irq;
>> +
>> +       master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
>> +       if (!master) {
>> +               dev_err(&pdev->dev, "spi_alloc_master failed\n");
>> +               return -ENOMEM;
>> +       }
>> +       master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA | SPI_TX_QUAD |
>> +                               SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL;
>> +
>> +       master->mem_ops = &cqspi_mem_ops;
>> +       master->dev.of_node = pdev->dev.of_node;
>> +
>> +       cqspi = spi_master_get_devdata(master);
>> +
>> +       cqspi->pdev = pdev;
>> +
>> +       /* Obtain configuration from OF. */
>> +       ret = cqspi_of_get_pdata(cqspi);
>> +       if (ret) {
>> +               dev_err(dev, "Cannot get mandatory OF data.\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       /* Obtain QSPI clock. */
>> +       cqspi->clk = devm_clk_get(dev, "qspi");
>> +       if (IS_ERR(cqspi->clk)) {
>> +               dev_err(dev, "Cannot claim QSPI clock.\n");
>> +               return PTR_ERR(cqspi->clk);
>> +       }
>> +
>> +       /* Obtain and remap controller address. */
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       cqspi->iobase = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(cqspi->iobase)) {
>> +               dev_err(dev, "Cannot remap controller address.\n");
>> +               return PTR_ERR(cqspi->iobase);
>> +       }
>> +
>> +       /* Obtain and remap AHB address. */
>> +       res_ahb = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +       cqspi->ahb_base = devm_ioremap_resource(dev, res_ahb);
>> +       if (IS_ERR(cqspi->ahb_base)) {
>> +               dev_err(dev, "Cannot remap AHB address.\n");
>> +               return PTR_ERR(cqspi->ahb_base);
>> +       }
>> +       cqspi->mmap_phys_base = (dma_addr_t)res_ahb->start;
>> +       cqspi->ahb_size = resource_size(res_ahb);
>> +
>> +       init_completion(&cqspi->transfer_complete);
>> +
>> +       /* Obtain IRQ line. */
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0)
>> +               return -ENXIO;
>> +
>> +       pm_runtime_enable(dev);
>> +       ret = pm_runtime_get_sync(dev);
>> +       if (ret < 0) {
>> +               pm_runtime_put_noidle(dev);
>> +               return ret;
>> +       }
>> +
>> +       ret = clk_prepare_enable(cqspi->clk);
>> +       if (ret) {
>> +               dev_err(dev, "Cannot enable QSPI clock.\n");
>> +               goto probe_clk_failed;
>> +       }
>> +
>> +       /* Obtain QSPI reset control */
>> +       rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
>> +       if (IS_ERR(rstc)) {
>> +               dev_err(dev, "Cannot get QSPI reset.\n");
>> +               goto probe_reset_failed;
>> +       }
>> +
>> +       rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
>> +       if (IS_ERR(rstc_ocp)) {
>> +               dev_err(dev, "Cannot get QSPI OCP reset.\n");
>> +               goto probe_reset_failed;
>> +       }
>> +
>> +       reset_control_assert(rstc);
>> +       reset_control_deassert(rstc);
>> +
>> +       reset_control_assert(rstc_ocp);
>> +       reset_control_deassert(rstc_ocp);
>> +
>> +       cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> +       ddata  = of_device_get_match_data(dev);
>> +       if (ddata) {
>> +               if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
>> +                       cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>> +                                               cqspi->master_ref_clk_hz);
>> +               if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
>> +                       master->mode_bits |= SPI_RX_OCTAL;
>> +               if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>> +                       cqspi->use_dac_mode = true;
>> +       }
>> +
>> +       ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>> +                              pdev->name, cqspi);
>> +       if (ret) {
>> +               dev_err(dev, "Cannot request IRQ.\n");
>> +               goto probe_reset_failed;
>> +       }
>> +
>> +       cqspi_wait_idle(cqspi);
>> +       cqspi_controller_init(cqspi);
>> +       cqspi->current_cs = -1;
>> +       cqspi->sclk = 0;
>> +       master->num_chipselect = cqspi->num_chipselect;
>> +       master->bus_num = cqspi->bus_num;
>> +
>> +       ret = cqspi_setup_flash(cqspi);
>> +       if (ret) {
>> +               dev_err(dev, "failed to setup flash parameters %d\n", ret);
>> +               goto probe_setup_failed;
>> +       }
>> +
>> +       if (cqspi->use_dac_mode) {
>> +               ret = cqspi_request_mmap_dma(cqspi);
>> +               if (ret == -EPROBE_DEFER)
>> +                       goto probe_setup_failed;
>> +       }
>> +
>> +       ret = devm_spi_register_master(dev, master);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
>> +               goto probe_setup_failed;
>> +       }
>> +
>> +       return 0;
>> +probe_setup_failed:
>> +       cqspi_controller_enable(cqspi, 0);
>> +probe_reset_failed:
>> +       clk_disable_unprepare(cqspi->clk);
>> +probe_clk_failed:
>> +       pm_runtime_put_sync(dev);
>> +       pm_runtime_disable(dev);
>> +       return ret;
>> +}
>> +
>> +static int cqspi_remove(struct platform_device *pdev)
>> +{
>> +       struct cqspi_st *cqspi = platform_get_drvdata(pdev);
>> +
>> +       cqspi_controller_enable(cqspi, 0);
>> +
>> +       if (cqspi->rx_chan)
>> +               dma_release_channel(cqspi->rx_chan);
>> +
>> +       clk_disable_unprepare(cqspi->clk);
>> +
>> +       pm_runtime_put_sync(&pdev->dev);
>> +       pm_runtime_disable(&pdev->dev);
>> +
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int cqspi_suspend(struct device *dev)
>> +{
>> +       struct cqspi_st *cqspi = dev_get_drvdata(dev);
>> +
>> +       cqspi_controller_enable(cqspi, 0);
>> +       return 0;
>> +}
>> +
>> +static int cqspi_resume(struct device *dev)
>> +{
>> +       struct cqspi_st *cqspi = dev_get_drvdata(dev);
>> +
>> +       cqspi_controller_enable(cqspi, 1);
>> +       return 0;
>> +}
>> +
>> +static const struct dev_pm_ops cqspi__dev_pm_ops = {
>> +       .suspend = cqspi_suspend,
>> +       .resume = cqspi_resume,
>> +};
>> +
>> +#define CQSPI_DEV_PM_OPS       (&cqspi__dev_pm_ops)
>> +#else
>> +#define CQSPI_DEV_PM_OPS       NULL
>> +#endif
>> +
>> +static const struct cqspi_driver_platdata cdns_qspi = {
>> +       .quirks = CQSPI_DISABLE_DAC_MODE,
>> +};
>> +
>> +static const struct cqspi_driver_platdata k2g_qspi = {
>> +       .quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>> +static const struct cqspi_driver_platdata am654_ospi = {
>> +       .hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
>> +       .quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
>> +       .quirks = CQSPI_DISABLE_DAC_MODE,
>> +};
>> +
>> +static const struct of_device_id cqspi_dt_ids[] = {
>> +       {
>> +               .compatible = "cdns,qspi-nor",
>> +               .data = &cdns_qspi,
>> +       },
>> +       {
>> +               .compatible = "ti,k2g-qspi",
>> +               .data = &k2g_qspi,
>> +       },
>> +       {
>> +               .compatible = "ti,am654-ospi",
>> +               .data = &am654_ospi,
>> +       },
>> +       {
>> +               .compatible = "intel,lgm-qspi",
>> +               .data = &intel_lgm_qspi,
>> +       },
>> +       { /* end of table */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, cqspi_dt_ids);
>> +
>> +static struct platform_driver cqspi_platform_driver = {
>> +       .probe = cqspi_probe,
>> +       .remove = cqspi_remove,
>> +       .driver = {
>> +               .name = CQSPI_NAME,
>> +               .pm = CQSPI_DEV_PM_OPS,
>> +               .of_match_table = cqspi_dt_ids,
>> +       },
>> +};
>> +
>> +module_platform_driver(cqspi_platform_driver);
>> +
>> +MODULE_DESCRIPTION("Cadence QSPI Controller Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" CQSPI_NAME);
>> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
>> +MODULE_AUTHOR("Graham Moore <grmoore@opensource.altera.com>");
>> +MODULE_AUTHOR("Vadivel Murugan R <vadivel.muruganx.ramuthevar@intel.com>");
>> +MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
>> --
>> 2.11.0
>>
