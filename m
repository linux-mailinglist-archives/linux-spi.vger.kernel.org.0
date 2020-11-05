Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75D2A8541
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgKERpJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 12:45:09 -0500
Received: from 10.mo52.mail-out.ovh.net ([87.98.187.244]:56391 "EHLO
        10.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKERpJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 12:45:09 -0500
X-Greylist: delayed 12002 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 12:45:04 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.76])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id DE01E203AF2;
        Thu,  5 Nov 2020 15:09:13 +0100 (CET)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 5 Nov 2020
 15:09:12 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-100R003373cfc29-c515-42c4-ac4a-007c75573a57,
                    5DF9D6D6E4C5608BB48A30C312C59CD2E053A3DC) smtp.auth=clg@kaod.org
Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <bbrezillon@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-spi@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
Date:   Thu, 5 Nov 2020 15:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 871e5090-e1f2-4092-a730-9fe2c3b1d8c0
X-Ovh-Tracer-Id: 542965232642526197
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehvddtueeuvdekleejleefjefhveegveelveeiudfghedvhefgtdevhfekteetgfenucffohhmrghinhepsghufhdrihhnnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegthhhinhdqthhinhhgpghkuhhosegrshhpvggvughtvggthhdrtghomh
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Chin-Ting,

Thanks for this driver. It's much cleaner than the previous and we should 
try adding support for the AST2500 SoC also. I guess we can keep the old 
driver for the AST2400 which has a different register layout.

On the patchset, I think we should split this patch in three : 

 - basic support
 - AHB window calculation depending on the flash size
 - read training support  

We should avoid magic values when setting registers. This is confusing 
and defines are much better.
 
AST2500 support will be a bit challenging because HW does not allow    
to configure a 128MB AHB window, max is 120MB This is a bug and the work 
around is to use user mode for the remaining 8MB. Something to keep in
mind.

I gave it a try on QEMU. It looks good. When I can revive my EVB, I will
do the same.

More comments below, 

Thanks,

C.


On 11/5/20 1:03 PM, Chin-Ting Kuo wrote:
> Add driver for ASPEED BMC FMC/SPI memory controller which
> supports spi-mem interface.
> 
> There are three SPI memory controllers embedded in an ASPEED SoC.
> Each of them can connect to two or three SPI NOR flashes. The first
> SPI memory controller is also named as Firmware Memory Controller (FMC),
> which is similar to SPI memory controller. After device AC on, MCU ROM
> can fetch device boot code from FMC CS 0. Thus, there exists additional
> registers for boot process control in FMC.
> 
> ASPEED SPI memory controller supports single, dual and quad mode for
> SPI NOR flash. It also supports two types of command mode, user mode
> and command read/write mode. User mode is traditional pure SPI operations
> where all transmission is controlled by CPU. Contrarily, with command
> read/write mode, SPI controller can send command and address automatically
> when CPU read/write related remapped address.
> 
> Besides, different wafer processes of SPI NOR flash result in different
> signal response time. This phenomenon will be enlarged when SPI clock
> frequency increases. ASPEED SPI memory controller provides a mechanism
> for timing compensation in order to satisfy various SPI NOR flash parts
> and PCB layout.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  v2: Fix sparse warnings reported by kernel test robot <lkp@intel.com>.
>  v3: Fix build warnings with x86 allmodconfig.
> 
>  drivers/spi/Kconfig      |  10 +
>  drivers/spi/Makefile     |   1 +
>  drivers/spi/spi-aspeed.c | 969 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 980 insertions(+)
>  create mode 100644 drivers/spi/spi-aspeed.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 5cff60de8e83..c848f2f7b694 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -70,6 +70,16 @@ config SPI_AR934X
>  	  This enables support for the SPI controller present on the
>  	  Qualcomm Atheros AR934X/QCA95XX SoCs.
>  
> +config SPI_ASPEED
> +	tristate "ASPEED FMC/SPI Memory Controller"
> +	depends on OF && HAS_IOMEM && (ARCH_ASPEED || COMPILE_TEST)

We will need to do something about the other driver. For the moment,
we can select both but that won't be the case anymore when we add
AST2500 support.

> +	help
> +	  Enable driver for ASPEED FMC/SPI Memory Controller.
> +
> +	  This driver is not a generic pure SPI driver, which
> +	  is especially designed for spi-mem framework with
> +	  SPI NOR flash direct read and write features.
> +
>  config SPI_ATH79
>  	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
>  	depends on ATH79 || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 6fea5821662e..9e62c650fca0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
>  obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
>  obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
>  obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
> +obj-$(CONFIG_SPI_ASPEED)		+= spi-aspeed.o
>  obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
>  obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
>  obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
> diff --git a/drivers/spi/spi-aspeed.c b/drivers/spi/spi-aspeed.c
> new file mode 100644
> index 000000000000..cfaaa0d5bac6
> --- /dev/null
> +++ b/drivers/spi/spi-aspeed.c
> @@ -0,0 +1,969 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * ASPEED FMC/SPI Memory Controller Driver
> + *
> + * Copyright (c) 2020, ASPEED Corporation.
> + * Copyright (c) 2015-2016, IBM Corporation.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sizes.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* ASPEED FMC/SPI memory control register related */
> +#define OFFSET_CE_TYPE_SETTING		0x00
> +#define OFFSET_CE_ADDR_MODE_CTRL	0x04
> +#define OFFSET_INTR_CTRL_STATUS		0x08
> +#define OFFSET_ADDR_DATA_MASK		0x0c
> +#define OFFSET_CE0_CTRL_REG		0x10
> +#define OFFSET_CE0_DECODE_RANGE_REG	0x30
> +#define OFFSET_DMA_CTRL			0x80
> +#define OFFSET_DMA_FLASH_ADDR_REG	0x84
> +#define OFFSET_DMA_RAM_ADDR_REG		0x88
> +#define OFFSET_DMA_LEN_REG		0x8c
> +#define OFFSET_DMA_CHECKSUM_RESULT	0x90
> +#define OFFSET_CE0_TIMING_COMPENSATION	0x94
> +
> +#define CTRL_IO_SINGLE_DATA	0
> +#define CTRL_IO_DUAL_DATA	BIT(29)
> +#define CTRL_IO_QUAD_DATA	BIT(30)
> +
> +#define CTRL_IO_MODE_USER	GENMASK(1, 0)
> +#define CTRL_IO_MODE_CMD_READ	BIT(0)
> +#define CTRL_IO_MODE_CMD_WRITE	BIT(1)
> +#define CTRL_STOP_ACTIVE	BIT(2)
> +
> +#define CALIBRATION_LEN		0x400
> +#define SPI_DAM_REQUEST		BIT(31)
> +#define SPI_DAM_GRANT		BIT(30)

What are these bits ? There is no documentation for them.

> +#define SPI_DMA_CALIB_MODE	BIT(3)
> +#define SPI_DMA_CALC_CKSUM	BIT(2)
> +#define SPI_DMA_ENABLE		BIT(0)
> +#define SPI_DMA_STATUS		BIT(11)
> +
> +enum aspeed_spi_ctl_reg_value {
> +	ASPEED_SPI_BASE,
> +	ASPEED_SPI_READ,
> +	ASPEED_SPI_WRITE,
> +	ASPEED_SPI_MAX,
> +};
> +
> +#define ASPEED_SPI_MAX_CS 5
> +
> +struct aspeed_spi_controller;
> +struct aspeed_spi_chip;
> +
> +struct aspeed_spi_info {
> +	uint32_t cmd_io_ctrl_mask;
> +	uint32_t max_data_bus_width;
> +	uint32_t min_decode_sz;
> +	void (*set_4byte)(struct aspeed_spi_controller *ast_ctrl, uint32_t cs);
> +	int (*calibrate)(struct aspeed_spi_controller *ast_ctrl, uint32_t cs);
> +	void (*adjust_decode_sz)(uint32_t decode_sz_arr[], int len);
> +	uint32_t (*segment_start)(struct aspeed_spi_controller *ast_ctrl,
> +				  uint32_t reg);
> +	uint32_t (*segment_end)(struct aspeed_spi_controller *ast_ctrl,
> +				uint32_t reg);
> +	uint32_t (*segment_reg)(struct aspeed_spi_controller *ast_ctrl,
> +				uint32_t start, uint32_t end);
> +};
> +
> +struct aspeed_spi_chip {
> +	void __iomem *ahb_base;
> +	phys_addr_t ahb_base_phy;
> +	uint32_t ahb_window_sz;
> +	uint32_t ctrl_val[ASPEED_SPI_MAX];
> +	uint32_t max_clk_freq;
> +};
> +
> +struct aspeed_spi_controller {
> +	struct device *dev;
> +	const struct aspeed_spi_info *info; /* controller info */
> +	void __iomem *regs; /* controller registers */
> +	void __iomem *ahb_base;
> +	phys_addr_t ahb_base_phy; /* physical addr of AHB window */
> +	uint32_t ahb_window_sz; /* AHB window size */
> +	uint32_t num_cs;
> +	uint64_t ahb_clk;
> +	struct aspeed_spi_chip *chips; /* pointers to attached chips */
> +};
> +
> +static uint32_t
> +aspeed_2600_spi_segment_start(struct aspeed_spi_controller *ast_ctrl,
> +			      uint32_t reg)
> +{
> +	uint32_t start_offset = (reg << 16) & 0x0ff00000;
> +
> +	return (uint32_t)(ast_ctrl->ahb_base_phy + start_offset);
> +}
> +
> +static uint32_t
> +aspeed_2600_spi_segment_end(struct aspeed_spi_controller *ast_ctrl,
> +			    uint32_t reg)
> +{
> +	uint32_t end_offset = reg & 0x0ff00000;
> +
> +	/* no decode range, set to physical ahb base */
> +	if (end_offset == 0)
> +		return ast_ctrl->ahb_base_phy;
> +
> +	return (uint32_t)(ast_ctrl->ahb_base_phy + end_offset + 0x100000);
> +}
> +
> +static uint32_t
> +aspeed_2600_spi_segment_reg(struct aspeed_spi_controller *ast_ctrl,
> +			    uint32_t start, uint32_t end)
> +{
> +	/* no decode range, assign zero value */
> +	if (start == end)
> +		return 0;
> +
> +	return ((start & 0x0ff00000) >> 16) | ((end - 0x100000) & 0x0ff00000);
> +}
> +
> +static void aspeed_spi_chip_set_4byte(struct aspeed_spi_controller *ast_ctrl,
> +				      uint32_t cs)
> +{
> +	uint32_t reg_val;
> +
> +	reg_val = readl(ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
> +	reg_val |= 0x11 << cs;
> +	writel(reg_val, ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
> +}
> +
> +static uint32_t aspeed_spi_get_io_mode(uint32_t bus_width)
> +{
> +	switch (bus_width) {
> +	case 1:
> +		return CTRL_IO_SINGLE_DATA;
> +	case 2:
> +		return CTRL_IO_DUAL_DATA;
> +	case 4:
> +		return CTRL_IO_QUAD_DATA;
> +	default:
> +		return CTRL_IO_SINGLE_DATA;
> +	}
> +}
> +
> +/*
> + * Check whether the data is not all 0 or 1 in order to
> + * avoid calibriate umount spi-flash.
> + */
> +static bool aspeed_spi_calibriation_enable(const uint8_t *buf, uint32_t sz)
> +{
> +	const uint32_t *buf_32 = (const uint32_t *)buf;
> +	uint32_t i;
> +	uint32_t valid_count = 0;
> +
> +	for (i = 0; i < (sz / 4); i++) {
> +		if (buf_32[i] != 0 && buf_32[i] != 0xffffffff)
> +			valid_count++;
> +		if (valid_count > 100)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static uint32_t
> +aspeed_2600_spi_dma_checksum(struct aspeed_spi_controller *ast_ctrl,
> +			     uint32_t cs, uint32_t div, uint32_t delay)
> +{
> +	uint32_t ctrl_val;
> +	uint32_t checksum;
> +
> +	writel(0xaeed0000, ast_ctrl->regs + OFFSET_DMA_CTRL);

You should use define for the magic value above ^

> +	if (readl(ast_ctrl->regs + OFFSET_DMA_CTRL) & SPI_DAM_REQUEST) {
> +		while (!(readl(ast_ctrl->regs + OFFSET_DMA_CTRL) &
> +			 SPI_DAM_GRANT))
> +			;
> +	}

What are these DAM bits for ? 

I don't think the AST2500 SPI controllers supports DMA. It would be better to
use a common method.

> +
> +	writel((uint32_t)ast_ctrl->chips[cs].ahb_base_phy,
> +	       ast_ctrl->regs + OFFSET_DMA_FLASH_ADDR_REG);
> +	writel(CALIBRATION_LEN, ast_ctrl->regs + OFFSET_DMA_LEN_REG);
> +
> +	ctrl_val = SPI_DMA_ENABLE | SPI_DMA_CALC_CKSUM | SPI_DMA_CALIB_MODE |
> +		   (delay << 8) | ((div & 0xf) << 16);
> +	writel(ctrl_val, ast_ctrl->regs + OFFSET_DMA_CTRL);
> +	while (!(readl(ast_ctrl->regs + OFFSET_INTR_CTRL_STATUS) &
> +		 SPI_DMA_STATUS))
> +		;
> +
> +	checksum = readl(ast_ctrl->regs + OFFSET_DMA_CHECKSUM_RESULT);
> +
> +	writel(0xdeea0000, ast_ctrl->regs + OFFSET_DMA_CTRL);
> +	writel(0x0, ast_ctrl->regs + OFFSET_DMA_CTRL);
> +
> +	return checksum;
> +}
> +
> +static int get_mid_point_of_longest_one(uint8_t *buf, uint32_t len)
> +{
> +	int i;
> +	int start = 0, mid_point = 0;
> +	int max_cnt = 0, cnt = 0;
> +
> +	for (i = 0; i < len; i++) {
> +		if (buf[i] == 1) {
> +			cnt++;
> +		} else {
> +			cnt = 0;
> +			start = i;
> +		}
> +
> +		if (max_cnt < cnt) {
> +			max_cnt = cnt;
> +			mid_point = start + (cnt / 2);
> +		}
> +	}
> +
> +	/*
> +	 * In order to get a stable SPI read timing,
> +	 * abandon the result if the length of longest
> +	 * consecutive good points is too short.
> +	 */
> +	if (max_cnt < 4)
> +		return -1;
> +
> +	return mid_point;
> +}
> +
> +/* Transfer maximum clock frequency to register setting */
> +static uint32_t
> +aspeed_2600_spi_clk_basic_setting(struct aspeed_spi_controller *ast_ctrl,
> +				  uint32_t *max_clk)
> +{
> +	struct device *dev = ast_ctrl->dev;
> +	uint32_t hclk_clk = ast_ctrl->ahb_clk;
> +	uint32_t hclk_div = 0x400; /* default value */
> +	uint32_t i, j = 0;
> +	bool found = false;
> +	/* HCLK/1 ..	HCLK/16 */
> +	uint32_t hclk_masks[] = { 15, 7, 14, 6, 13, 5, 12, 4,
> +				  11, 3, 10, 2, 9,  1, 8,  0 };
> +
> +	/* FMC/SPIR10[27:24] */
> +	for (j = 0; j < 0xf; i++) {
> +		/* FMC/SPIR10[11:8] */
> +		for (i = 0; i < ARRAY_SIZE(hclk_masks); i++) {
> +			if (i == 0 && j == 0)
> +				continue;
> +
> +			if (hclk_clk / (i + 1 + (j * 16)) <= *max_clk) {
> +				found = 1;
> +				*max_clk = hclk_clk / (i + 1 + (j * 16));
> +				break;
> +			}
> +		}
> +
> +		if (found) {
> +			hclk_div = ((j << 24) | hclk_masks[i] << 8);
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(dev, "found: %s, hclk: %d, max_clk: %d\n", found ? "yes" : "no",
> +		hclk_clk, *max_clk);
> +	dev_dbg(dev, "base_clk: %d, h_div: %d (mask %x), speed: %d\n", j, i + 1,
> +		hclk_masks[i], hclk_clk / (i + 1 + j * 16));
> +
> +	return hclk_div;
> +}
> +
> +/*
> + * If SPI frequency is too high, timing compensation is needed,
> + * otherwise, SPI controller will sample unready data. For AST2600
> + * SPI memory controller, only the first four frequency levels
> + * (HCLK/2, HCLK/3,..., HCKL/5) may need timing compensation.
> + * Here, for each frequency, we will get a sequence of reading
> + * result (pass or fail) compared to golden data. Then, getting the
> + * middle point of the maximum pass widow. Besides, if the flash's
> + * content is too monotonous, the frequency recorded in the device
> + * tree will be adopted.
> + */
> +static int
> +aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
> +				   uint32_t cs)
> +{
> +	int ret = 0;
> +	struct device *dev = ast_ctrl->dev;
> +	struct aspeed_spi_chip *chip = &ast_ctrl->chips[cs];
> +	uint32_t max_freq = chip->max_clk_freq;
> +	/* HCLK/2, ..., HCKL/5 */
> +	uint32_t hclk_masks[] = { 7, 14, 6, 13 };
> +	uint8_t *calib_res = NULL;
> +	uint8_t *check_buf = NULL;
> +	uint32_t reg_val;
> +	uint32_t checksum, gold_checksum;
> +	uint32_t i, hcycle, delay_ns, final_delay = 0;
> +	uint32_t hclk_div;
> +	bool pass;
> +	int calib_point;
> +
> +	reg_val =
> +		readl(ast_ctrl->regs + OFFSET_CE0_TIMING_COMPENSATION + cs * 4);
> +	if (reg_val != 0) {
> +		dev_dbg(dev, "has executed calibration.\n");
> +		goto no_calib;
> +	}
> +
> +	dev_dbg(dev, "calculate timing compensation :\n");
> +	/*
> +	 * use the related low frequency to get check calibration data
> +	 * and get golden data.
> +	 */
> +	reg_val = chip->ctrl_val[ASPEED_SPI_READ] & 0xf0fff0ff;
> +	writel(reg_val, ast_ctrl->regs + OFFSET_CE0_CTRL_REG + cs * 4);
> +
> +	check_buf = kzalloc(CALIBRATION_LEN, GFP_KERNEL);
> +	if (!check_buf)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(check_buf, chip->ahb_base, CALIBRATION_LEN);
> +	if (!aspeed_spi_calibriation_enable(check_buf, CALIBRATION_LEN)) {
> +		dev_info(dev, "flash data is monotonous, skip calibration.");
> +		goto no_calib;
> +	}
> +
> +	gold_checksum = aspeed_2600_spi_dma_checksum(ast_ctrl, cs, 0, 0);
> +
> +	/*
> +	 * allocate a space to record calibration result for
> +	 * different timing compensation with fixed
> +	 * HCLK division.
> +	 */
> +	calib_res = kzalloc(6 * 17, GFP_KERNEL);
> +	if (!calib_res) {
> +		ret = -ENOMEM;
> +		goto no_calib;
> +	}
> +
> +	/* From HCLK/2 to HCLK/5 */
> +	for (i = 0; i < ARRAY_SIZE(hclk_masks); i++) {
> +		if (max_freq < (uint32_t)ast_ctrl->ahb_clk / (i + 2)) {
> +			dev_dbg(dev, "skipping freq %d\n",
> +				(uint32_t)ast_ctrl->ahb_clk / (i + 2));
> +			continue;
> +		}
> +		max_freq = (uint32_t)ast_ctrl->ahb_clk / (i + 2);
> +
> +		checksum = aspeed_2600_spi_dma_checksum(ast_ctrl, cs,
> +							hclk_masks[i], 0);
> +		pass = (checksum == gold_checksum);
> +		dev_dbg(dev, "HCLK/%d, no timing compensation: %s\n", i + 2,
> +			pass ? "PASS" : "FAIL");
> +
> +		if (pass)
> +			break;
> +
> +		memset(calib_res, 0x0, 6 * 17);
> +
> +		for (hcycle = 0; hcycle <= 5; hcycle++) {
> +			/* increase DI delay by the step of 0.5ns */
> +			dev_dbg(dev, "Delay Enable : hcycle %x\n", hcycle);
> +			for (delay_ns = 0; delay_ns <= 0xf; delay_ns++) {
> +				checksum = aspeed_2600_spi_dma_checksum(
> +					ast_ctrl, cs, hclk_masks[i],
> +					BIT(3) | hcycle | (delay_ns << 4));
> +				pass = (checksum == gold_checksum);
> +				calib_res[hcycle * 17 + delay_ns] = pass;
> +				dev_dbg(dev,
> +					"HCLK/%d, %d HCLK cycle, %d delay_ns : %s\n",
> +					i + 2, hcycle, delay_ns,
> +					pass ? "PASS" : "FAIL");
> +			}
> +		}
> +
> +		calib_point = get_mid_point_of_longest_one(calib_res, 6 * 17);
> +		if (calib_point < 0) {
> +			dev_info(dev, "cannot get good calibration point.\n");
> +			continue;
> +		}
> +
> +		hcycle = calib_point / 17;
> +		delay_ns = calib_point % 17;
> +		dev_dbg(dev, "final hcycle: %d, delay_ns: %d\n", hcycle,
> +			delay_ns);
> +
> +		final_delay = (BIT(3) | hcycle | (delay_ns << 4)) << (i * 8);
> +		writel(final_delay, ast_ctrl->regs +
> +					    OFFSET_CE0_TIMING_COMPENSATION +
> +					    cs * 4);
> +		break;
> +	}
> +
> +no_calib:
> +
> +	hclk_div = aspeed_2600_spi_clk_basic_setting(ast_ctrl, &max_freq);
> +
> +	/* configure SPI clock frequency */
> +	reg_val = readl(ast_ctrl->regs + OFFSET_CE0_CTRL_REG + cs * 4);
> +	reg_val = (reg_val & 0xf0fff0ff) | hclk_div;
> +	writel(reg_val, ast_ctrl->regs + OFFSET_CE0_CTRL_REG + cs * 4);
> +
> +	/* add clock setting info for CE ctrl setting */
> +	for (i = 0; i < ASPEED_SPI_MAX; i++)
> +		chip->ctrl_val[i] = (chip->ctrl_val[i] & 0xf0fff0ff) | hclk_div;
> +
> +	dev_info(dev, "freq: %dMHz\n", max_freq / 1000000);
> +
> +	kfree(check_buf);
> +	kfree(calib_res);
> +
> +	return ret;
> +}
> +
> +/*
> + * AST2600 SPI memory controllers support multiple chip selects.
> + * The start address of a decode range should be multiple
> + * of its related flash size. Namely, the total decoded size
> + * from flash 0 to flash N should be multiple of flash (N + 1).
> + */
> +static void aspeed_2600_adjust_decode_sz(uint32_t decode_sz_arr[], int len)
> +{
> +	int cs, j;
> +	uint32_t sz;
> +
> +	for (cs = len - 1; cs >= 0; cs--) {
> +		sz = 0;
> +		for (j = 0; j < cs; j++)
> +			sz += decode_sz_arr[j];
> +
> +		if (sz % decode_sz_arr[cs] != 0)
> +			decode_sz_arr[0] += (sz % decode_sz_arr[cs]);
> +	}
> +}
> +
> +static int
> +aspeed_spi_decode_range_config(struct aspeed_spi_controller *ast_ctrl,
> +			       uint32_t decode_sz_arr[])
> +{
> +	struct aspeed_spi_chip *chip = ast_ctrl->chips;
> +	uint32_t i;
> +	uint32_t cs;
> +	uint32_t decode_reg_val;
> +	phys_addr_t start_addr_phy, end_addr_phy, pre_end_addr_phy = 0;
> +	uint32_t total_decode_sz = 0;
> +
> +	/* decode range sanity */
> +	for (cs = 0; cs < ast_ctrl->num_cs; cs++) {
> +		total_decode_sz += decode_sz_arr[cs];
> +		if (ast_ctrl->ahb_window_sz < total_decode_sz) {
> +			dev_err(ast_ctrl->dev, "insufficient decode size\n");
> +			for (i = 0; i <= cs; i++)
> +				dev_err(ast_ctrl->dev, "cs:%d %x\n", i,
> +					decode_sz_arr[i]);
> +			return -ENOSPC;
> +		}
> +	}
> +
> +	for (cs = 0; cs < ast_ctrl->num_cs; cs++) {
> +		if (chip[cs].ahb_base)
> +			devm_iounmap(ast_ctrl->dev, chip[cs].ahb_base);
> +	}
> +
> +	/* configure each CE's decode range */
> +	for (cs = 0; cs < ast_ctrl->num_cs; cs++) {
> +		if (cs == 0)
> +			start_addr_phy = ast_ctrl->ahb_base_phy;
> +		else
> +			start_addr_phy = pre_end_addr_phy;
> +
> +		chip[cs].ahb_base = devm_ioremap(ast_ctrl->dev, start_addr_phy,
> +						 decode_sz_arr[cs]);
> +		chip[cs].ahb_base_phy = start_addr_phy;
> +
> +		chip[cs].ahb_window_sz = decode_sz_arr[cs];
> +		end_addr_phy = start_addr_phy + decode_sz_arr[cs];
> +
> +		decode_reg_val = ast_ctrl->info->segment_reg(
> +			ast_ctrl, start_addr_phy, end_addr_phy);
> +
> +		writel(decode_reg_val,
> +		       ast_ctrl->regs + OFFSET_CE0_DECODE_RANGE_REG + cs * 4);
> +
> +		pre_end_addr_phy = end_addr_phy;
> +
> +		dev_dbg(ast_ctrl->dev, "cs: %d, decode_reg: 0x%x\n", cs,
> +			decode_reg_val);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct aspeed_spi_info ast2600_spi_info = {
> +	.max_data_bus_width = 4,
> +	.cmd_io_ctrl_mask = 0xf0ff40c3,
> +	/* for ast2600, the minimum decode size for each CE is 2MB */
> +	.min_decode_sz = 0x200000,
> +	.set_4byte = aspeed_spi_chip_set_4byte,
> +	.calibrate = aspeed_2600_spi_timing_calibration,
> +	.adjust_decode_sz = aspeed_2600_adjust_decode_sz,
> +	.segment_start = aspeed_2600_spi_segment_start,
> +	.segment_end = aspeed_2600_spi_segment_end,
> +	.segment_reg = aspeed_2600_spi_segment_reg,
> +};
> +
> +/*
> + * If the slave device is SPI NOR flash, there are two types
> + * of command mode for ASPEED SPI memory controller used to
> + * transfer data. The first one is user mode and the other is
> + * command read/write mode. With user mode, SPI NOR flash
> + * command, address and data processes are all handled by CPU.
> + * But, when address filter is enabled to protect some flash
> + * regions from being written, user mode will be disabled.
> + * Thus, here, we use command read/write mode to issue SPI
> + * operations. After remapping flash space correctly, we can
> + * easily read/write data to flash by reading or writing
> + * related remapped address, then, SPI NOR flash command and
> + * address will be transferred to flash by controller
> + * automatically. Besides, ASPEED SPI memory controller can
> + * also block address or data bytes by configure FMC0C/SPIR0C
> + * address and data mask register in order to satisfy the
> + * following SPI flash operation sequences: (command) only,
> + * (command and address) only or (coommand and data) only.
> + */
> +static int aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct aspeed_spi_controller *ast_ctrl =
> +		spi_controller_get_devdata(mem->spi->master);
> +	struct device *dev = ast_ctrl->dev;
> +	uint32_t cs = mem->spi->chip_select;
> +	struct aspeed_spi_chip *chip = &ast_ctrl->chips[cs];
> +	uint32_t ctrl_val;
> +	uint32_t addr_mode_reg, addr_mode_reg_backup;
> +	uint32_t addr_data_mask = 0;
> +	void __iomem *op_addr;
> +	const void *data_buf;
> +	uint32_t data_byte = 0;
> +	uint32_t dummy_data = 0;
> +
> +	dev_dbg(dev, "cmd:%x(%d),addr:%llx(%d),dummy:%d(%d),data_len:%x(%d)\n",
> +		op->cmd.opcode, op->cmd.buswidth, op->addr.val,
> +		op->addr.buswidth, op->dummy.nbytes, op->dummy.buswidth,
> +		op->data.nbytes, op->data.buswidth);
> +
> +	addr_mode_reg = addr_mode_reg_backup =
> +		readl(ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
> +	addr_data_mask = readl(ast_ctrl->regs + OFFSET_ADDR_DATA_MASK);
> +
> +	ctrl_val = chip->ctrl_val[ASPEED_SPI_BASE];
> +	ctrl_val &= ~ast_ctrl->info->cmd_io_ctrl_mask;
> +
> +	/* configure opcode */
> +	ctrl_val |= op->cmd.opcode << 16;
> +
> +	/* configure operation address, address length and address mask */
> +	if (op->addr.nbytes != 0) {
> +		if (op->addr.nbytes == 3)
> +			addr_mode_reg &= ~(0x11 << cs);
> +		else
> +			addr_mode_reg |= (0x11 << cs);

please use define.

> +
> +		addr_data_mask &= 0x0f;
> +		op_addr = chip->ahb_base + op->addr.val;
> +	} else {
> +		addr_data_mask |= 0xf0;

Disabling the address lanes needs an explanation.

> +		op_addr = chip->ahb_base;
> +	}
> +
> +	if (op->dummy.nbytes != 0) {
> +		ctrl_val |= ((op->dummy.nbytes & 0x3) << 6 |
> +			     (op->dummy.nbytes & 0x4) << 14);
> +	}
> +
> +	/* configure data io mode and data mask */
> +	if (op->data.nbytes != 0) {
> +		addr_data_mask &= 0xF0;
> +		data_byte = op->data.nbytes;
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			data_buf = op->data.buf.out;
> +		else
> +			data_buf = op->data.buf.in;
> +
> +		if (op->data.buswidth)
> +			ctrl_val |= aspeed_spi_get_io_mode(op->data.buswidth);
> +
> +	} else {
> +		addr_data_mask |= 0x0f;
> +		data_byte = 1;
> +		data_buf = &dummy_data;
> +	}
> +
> +	/* configure command mode */
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		ctrl_val |= CTRL_IO_MODE_CMD_WRITE;
> +	else
> +		ctrl_val |= CTRL_IO_MODE_CMD_READ;
> +
> +	/* set controller registers */
> +	writel(ctrl_val, ast_ctrl->regs + OFFSET_CE0_CTRL_REG + cs * 4);
> +	writel(addr_mode_reg, ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
> +	writel(addr_data_mask, ast_ctrl->regs + OFFSET_ADDR_DATA_MASK);
> +
> +	dev_dbg(dev, "ctrl: 0x%08x, addr_mode: 0x%x, mask: 0x%x, addr:%px\n",
> +		ctrl_val, addr_mode_reg, addr_data_mask, op_addr);
> +
> +	/* trigger spi transmission or reception sequence */
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		memcpy_toio(op_addr, data_buf, data_byte);
> +	else
> +		memcpy_fromio((void *)data_buf, op_addr, data_byte);
> +
> +	/* restore controller setting */
> +	writel(chip->ctrl_val[ASPEED_SPI_READ],
> +	       ast_ctrl->regs + OFFSET_CE0_CTRL_REG + cs * 4);
> +	writel(addr_mode_reg_backup, ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
> +	writel(0x0, ast_ctrl->regs + OFFSET_ADDR_DATA_MASK);
> +
> +	return 0;
> +}
> +
> +static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +				  uint64_t offs, size_t len, void *buf)
> +{
> +	struct aspeed_spi_controller *ast_ctrl =
> +		spi_controller_get_devdata(desc->mem->spi->master);
> +	struct aspeed_spi_chip *chip =
> +		&ast_ctrl->chips[desc->mem->spi->chip_select];
> +	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
> +
> +	if (chip->ahb_window_sz < offs + len) {
> +		dev_info(ast_ctrl->dev,
> +			 "read range exceeds flash remapping size\n");
> +		return 0;
> +	}
> +
> +	dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%zx\n",
> +		op_tmpl.cmd.opcode, offs, len);
> +
> +	memcpy_fromio(buf, chip->ahb_base + offs, len);
> +
> +	return len;
> +}
> +
> +static ssize_t aspeed_spi_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +				   uint64_t offs, size_t len, const void *buf)
> +{
> +	struct aspeed_spi_controller *ast_ctrl =
> +		spi_controller_get_devdata(desc->mem->spi->master);
> +	struct aspeed_spi_chip *chip =
> +		&ast_ctrl->chips[desc->mem->spi->chip_select];
> +	uint32_t reg_val;
> +	uint32_t target_cs = desc->mem->spi->chip_select;
> +	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
> +
> +	if (chip->ahb_window_sz < offs + len) {
> +		dev_info(ast_ctrl->dev,
> +			 "write range exceeds flash remapping size\n");
> +		return 0;
> +	}
> +
> +	dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%zx\n",
> +		op_tmpl.cmd.opcode, offs, len);
> +
> +	reg_val = ast_ctrl->chips[target_cs].ctrl_val[ASPEED_SPI_WRITE];
> +	writel(reg_val, ast_ctrl->regs + OFFSET_CE0_CTRL_REG + target_cs * 4);
> +
> +	memcpy_toio(chip->ahb_base + offs, buf, len);
> +
> +	reg_val = ast_ctrl->chips[target_cs].ctrl_val[ASPEED_SPI_READ];
> +	writel(reg_val, ast_ctrl->regs + OFFSET_CE0_CTRL_REG + target_cs * 4);
> +
> +	return len;
> +}
> +
> +static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
> +{
> +	int ret = 0;
> +	struct aspeed_spi_controller *ast_ctrl =
> +		spi_controller_get_devdata(desc->mem->spi->master);
> +	struct device *dev = ast_ctrl->dev;
> +	const struct aspeed_spi_info *info = ast_ctrl->info;
> +	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
> +	uint32_t decode_sz_arr[5];
> +	uint32_t cs, target_cs = desc->mem->spi->chip_select;
> +	uint32_t reg_val;
> +
> +	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN) {
> +		/* record original decode size */
> +		for (cs = 0; cs < ast_ctrl->num_cs; cs++) {
> +			reg_val = readl(ast_ctrl->regs +
> +					OFFSET_CE0_DECODE_RANGE_REG + cs * 4);
> +			decode_sz_arr[cs] =
> +				info->segment_end(ast_ctrl, reg_val) -
> +				info->segment_start(ast_ctrl, reg_val);
> +		}
> +
> +		decode_sz_arr[target_cs] = desc->info.length;
> +
> +		if (info->adjust_decode_sz)
> +			info->adjust_decode_sz(decode_sz_arr, ast_ctrl->num_cs);
> +
> +		for (cs = 0; cs < ast_ctrl->num_cs; cs++) {
> +			dev_dbg(dev, "cs: %d, sz: 0x%x\n", cs,
> +				decode_sz_arr[cs]);
> +		}
> +
> +		ret = aspeed_spi_decode_range_config(ast_ctrl, decode_sz_arr);
> +		if (ret)
> +			return ret;
> +
> +		reg_val = readl(ast_ctrl->regs + OFFSET_CE0_CTRL_REG +
> +				target_cs * 4) &
> +			  (~info->cmd_io_ctrl_mask);
> +		reg_val |= aspeed_spi_get_io_mode(op_tmpl.data.buswidth) |
> +			   op_tmpl.cmd.opcode << 16 |
> +			   ((op_tmpl.dummy.nbytes) & 0x3) << 6 |
> +			   ((op_tmpl.dummy.nbytes) & 0x4) << 14 |
> +			   CTRL_IO_MODE_CMD_READ;
> +
> +		writel(reg_val,
> +		       ast_ctrl->regs + OFFSET_CE0_CTRL_REG + target_cs * 4);
> +		ast_ctrl->chips[target_cs].ctrl_val[ASPEED_SPI_READ] = reg_val;
> +		ast_ctrl->chips[target_cs].max_clk_freq =
> +			desc->mem->spi->max_speed_hz;
> +
> +		ret = info->calibrate(ast_ctrl, target_cs);
> +
> +		dev_info(dev, "read bus width: %d [0x%08x]\n",
> +			 op_tmpl.data.buswidth,
> +			 ast_ctrl->chips[target_cs].ctrl_val[ASPEED_SPI_READ]);
> +
> +	} else if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT) {
> +		reg_val = readl(ast_ctrl->regs + OFFSET_CE0_CTRL_REG +
> +				target_cs * 4) &
> +			  (~info->cmd_io_ctrl_mask);
> +		reg_val |= aspeed_spi_get_io_mode(op_tmpl.data.buswidth) |
> +			   op_tmpl.cmd.opcode << 16 | CTRL_IO_MODE_CMD_WRITE;
> +		ast_ctrl->chips[target_cs].ctrl_val[ASPEED_SPI_WRITE] = reg_val;
> +
> +		dev_info(dev, "write bus width: %d [0x%08x]\n",
> +			 op_tmpl.data.buswidth,
> +			 ast_ctrl->chips[target_cs].ctrl_val[ASPEED_SPI_WRITE]);
> +	}
> +
> +	return ret;
> +}
> +
> +static const char *aspeed_spi_get_name(struct spi_mem *mem)
> +{
> +	struct device *dev = &mem->spi->master->dev;
> +	const char *name;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", dev_name(dev),
> +			      mem->spi->chip_select);
> +
> +	if (!name) {
> +		dev_err(dev, "cannot get spi name\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return name;
> +}
> +
> +/*
> + * Currently, only support 1-1-1, 1-1-2 or 1-1-4
> + * SPI NOR flash operation format.
> + */
> +static bool aspeed_spi_support_op(struct spi_mem *mem,
> +				  const struct spi_mem_op *op)
> +{
> +	struct aspeed_spi_controller *ast_ctrl =
> +		spi_controller_get_devdata(mem->spi->master);
> +
> +	if (op->cmd.buswidth > 1)
> +		return false;
> +
> +	if (op->addr.nbytes != 0) {
> +		if (op->addr.buswidth > 1 || op->addr.nbytes > 4)
> +			return false;
> +	}
> +
> +	if (op->dummy.nbytes != 0) {
> +		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
> +			return false;
> +	}
> +
> +	if (op->data.nbytes != 0 &&
> +	    ast_ctrl->info->max_data_bus_width < op->data.buswidth)
> +		return false;
> +
> +	if (!spi_mem_default_supports_op(mem, op))
> +		return false;
> +
> +	if (op->addr.nbytes == 4)
> +		ast_ctrl->info->set_4byte(ast_ctrl, mem->spi->chip_select);
> +
> +	return true;
> +}
> +
> +static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
> +	.exec_op = aspeed_spi_exec_op,
> +	.get_name = aspeed_spi_get_name,
> +	.supports_op = aspeed_spi_support_op,
> +	.dirmap_create = aspeed_spi_dirmap_create,
> +	.dirmap_read = aspeed_spi_dirmap_read,
> +	.dirmap_write = aspeed_spi_dirmap_write,
> +};
> +
> +/*
> + * Initialize SPI controller for each chip select.
> + * Here, only the minimum decode range is configured
> + * in order to get device (SPI NOR flash) information
> + * at the early stage.
> + */
> +static int aspeed_spi_ctrl_init(struct aspeed_spi_controller *ast_ctrl)
> +{
> +	int ret;
> +	uint32_t cs;
> +	uint32_t val;
> +	uint32_t decode_sz_arr[ASPEED_SPI_MAX_CS];
> +
> +	/* enable write capability for all CEs */
> +	val = readl(ast_ctrl->regs + OFFSET_CE_TYPE_SETTING);
> +	writel(val | (GENMASK(ast_ctrl->num_cs, 0) << 16),
> +	       ast_ctrl->regs + OFFSET_CE_TYPE_SETTING);
> +
> +	/* initial each CE's controller register */
> +	for (cs = 0; cs < ast_ctrl->num_cs; cs++) {
> +		val = CTRL_STOP_ACTIVE | CTRL_IO_MODE_USER;
> +		writel(val, ast_ctrl->regs + OFFSET_CE0_CTRL_REG + cs * 4);
> +		ast_ctrl->chips[cs].ctrl_val[ASPEED_SPI_BASE] = val;
> +	}
> +
> +	for (cs = 0; cs < ast_ctrl->num_cs && cs < ASPEED_SPI_MAX_CS; cs++)
> +		decode_sz_arr[cs] = ast_ctrl->info->min_decode_sz;
> +
> +	ret = aspeed_spi_decode_range_config(ast_ctrl, decode_sz_arr);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id aspeed_spi_matches[] = {
> +	{ .compatible = "aspeed,ast2600-fmc", .data = &ast2600_spi_info },
> +	{ .compatible = "aspeed,ast2600-spi", .data = &ast2600_spi_info },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_spi_matches);
> +
> +static int aspeed_spi_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +	struct spi_controller *spi_ctrl;
> +	struct aspeed_spi_controller *ast_ctrl;
> +	const struct of_device_id *match;
> +	struct clk *clk;
> +	struct resource *res;
> +
> +	spi_ctrl = spi_alloc_master(dev, sizeof(struct aspeed_spi_controller));
> +	if (!spi_ctrl)
> +		return -ENOMEM;
> +
> +	ast_ctrl = spi_controller_get_devdata(spi_ctrl);
> +
> +	match = of_match_device(aspeed_spi_matches, dev);
> +	if (!match || !match->data) {
> +		dev_err(dev, "no compatible OF match\n");
> +		return -ENODEV;
> +	}
> +
> +	ast_ctrl->info = match->data;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "spi_ctrl_reg");
> +	ast_ctrl->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ast_ctrl->regs))
> +		return PTR_ERR(ast_ctrl->regs);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "spi_mmap");
> +	ast_ctrl->ahb_base_phy = res->start;
> +	ast_ctrl->ahb_window_sz = resource_size(res);
> +
> +	ast_ctrl->dev = dev;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +	ast_ctrl->ahb_clk = clk_get_rate(clk);
> +	devm_clk_put(&pdev->dev, clk);
> +
> +	if (of_property_read_u32(dev->of_node, "num-cs", &ast_ctrl->num_cs)) {
> +		dev_err(dev, "fail to get chip number.\n");
> +		goto end;
> +	}
> +
> +	if (ast_ctrl->num_cs > ASPEED_SPI_MAX_CS) {
> +		dev_err(dev, "chip number, %d, exceeds %d.\n", ast_ctrl->num_cs,
> +			ASPEED_SPI_MAX_CS);
> +		goto end;
> +	}
> +
> +	ast_ctrl->chips =
> +		devm_kzalloc(dev,
> +			     sizeof(struct aspeed_spi_chip) * ast_ctrl->num_cs,
> +			     GFP_KERNEL);
> +
> +	platform_set_drvdata(pdev, ast_ctrl);
> +
> +	spi_ctrl->mode_bits =
> +		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
> +
> +	spi_ctrl->bus_num = -1;
> +	spi_ctrl->mem_ops = &aspeed_spi_mem_ops;
> +	spi_ctrl->dev.of_node = dev->of_node;
> +	spi_ctrl->num_chipselect = ast_ctrl->num_cs;
> +
> +	ret = aspeed_spi_ctrl_init(ast_ctrl);
> +	if (ret)
> +		goto end;
> +
> +	ret = devm_spi_register_master(dev, spi_ctrl);
> +
> +end:
> +	return ret;
> +}
> +
> +static int aspeed_spi_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_spi_controller *ast_ctrl = platform_get_drvdata(pdev);
> +	uint32_t val;
> +
> +	/* disable write capability for all CEs */
> +	val = readl(ast_ctrl->regs + OFFSET_CE_TYPE_SETTING);
> +	writel(val & ~(GENMASK(ast_ctrl->num_cs, 0) << 16),
> +	       ast_ctrl->regs + OFFSET_CE_TYPE_SETTING);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver aspeed_spi_driver = {
> +	.driver = {
> +		.name = "ASPEED_FMC_SPI",
> +		.bus = &platform_bus_type,
> +		.of_match_table = aspeed_spi_matches,
> +	},
> +	.probe = aspeed_spi_probe,
> +	.remove = aspeed_spi_remove,
> +};
> +module_platform_driver(aspeed_spi_driver);
> +
> +MODULE_DESCRIPTION("ASPEED FMC/SPI Memory Controller Driver");
> +MODULE_AUTHOR("Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>");
> +MODULE_AUTHOR("Cedric Le Goater <clg@kaod.org>");
> +MODULE_LICENSE("GPL v2");
> 

