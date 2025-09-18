Return-Path: <linux-spi+bounces-10123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F4B854B4
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ED87B24A5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE04306B28;
	Thu, 18 Sep 2025 14:39:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2C1EEA49;
	Thu, 18 Sep 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206377; cv=none; b=InFjDpKL36YrwRxWJTPIR12knYvDkSidd3jYSi7rPJBQubY72SG1vl5uB4JR50u+ncWdquvYmr2QzwBysJ+eQHH+2NLuHa4Wbh14Z3eUrQLALYq+qxdbhYXBKSFlvitU0VKkHXhmWsyKYPVc7D96Z9IkbtRzUu19JmI7RZVFrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206377; c=relaxed/simple;
	bh=xxZ24sDGr80iRFzPSfzitJqXmKEvjmCRweXwhzu4pgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnCZI4g1rxheU6ESNh3Z+xaShBky9bmxpLZn3MyVu04H055sBBY0Z1i6TH1XObIxInPH908voc3UGJ1bSdWpQtKXDPD9pY5DNS0d4iCJmPtqx7Ci3i7nVelGamIh45uOANnIAcRrTEOQ3s78h6qfi/1nNO/5GoGZUTOiPYQpo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 582DA34210D;
	Thu, 18 Sep 2025 14:39:34 +0000 (UTC)
Date: Thu, 18 Sep 2025 22:39:28 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
Message-ID: <20250918143928-GYB1274501@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>

Hi Alex,

On 08:45 Thu 18 Sep     , Alex Elder wrote:
> On 9/18/25 7:41 AM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > A few comments below which are mostly related to coding style or my personal taste
> 
> Great, thank you!  I plan to adopt several of your suggestions, but
> in a few cases I explain why the code looks the way it does.  And
> I ask for your response in some cases--I'm willing to change but
> want to know what you think after you read what I say.
> 
> > On 17:07 Wed 17 Sep     , Alex Elder wrote:
> >> This patch introduces the driver for the SPI controller found in the
> >> SpacemiT K1 SoC.  Currently the driver supports master mode only.
> >> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
> >> supports both PIO and DMA mode transfers.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >>   drivers/spi/Kconfig           |   8 +
> >>   drivers/spi/Makefile          |   1 +
> >>   drivers/spi/spi-spacemit-k1.c | 985 ++++++++++++++++++++++++++++++++++
> >>   3 files changed, 994 insertions(+)
> >>   create mode 100644 drivers/spi/spi-spacemit-k1.c
> >>
> >> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> >> index 82fa5eb3b8684..915a52407a85a 100644
> >> --- a/drivers/spi/Kconfig
> >> +++ b/drivers/spi/Kconfig
> >> @@ -577,6 +577,14 @@ config SPI_KSPI2
> >>   	  This driver can also be built as a module. If so, the module
> >>   	  will be called spi-kspi2.
> >>   
> >> +config SPI_SPACEMIT_K1
> > keep it sorted? seems you adjust the name but forget to reorder it
> 
> Could be.  It is my intention to keep this and many other things
> sorted.  I'll fix this.
> 
> >> +	tristate "K1 SPI Controller"
> >> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> >> +	depends on OF
> >> +	default ARCH_SPACEMIT
> >> +	help
> >> +	  Enable support for the SpacemiT K1 SPI controller.
> >> +
> >>   config SPI_LM70_LLP
> >>   	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
> >>   	depends on PARPORT
> >> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> >> index eefaeca097456..29d55eeb9abb4 100644
> >> --- a/drivers/spi/Makefile
> >> +++ b/drivers/spi/Makefile
> >> @@ -75,6 +75,7 @@ obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
> >>   obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
> >>   obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
> >>   obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
> >> +obj-$(CONFIG_SPI_SPACEMIT_K1)		+= spi-spacemit-k1.o
> > same, sort
> 
> Yes I'll put this in sorted order too, thanks for noticing.
> 
> >>   obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
> >>   obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
> >>   obj-$(CONFIG_SPI_KSPI2)			+= spi-kspi2.o
> >> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
> >> new file mode 100644
> >> index 0000000000000..6edf75efe7c68
> >> --- /dev/null
> >> +++ b/drivers/spi/spi-spacemit-k1.c
> >> @@ -0,0 +1,985 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Support for SpacemiT K1 SPI controller
> >> + *
> >> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
> >> + * Copyright (c) 2023, spacemit Corporation.
> > keep "(C)" consistent? capitalized
> > s/spacemit/SpacemiT/, or I'd suggest to keep it align with vendor-prefixes.yaml..
> 
> First, the (C) is verbatim what our company lawyer said to use.
> 
> Second, I did not want to change anything on the copyright that
> was originally provided by SpacemiT.  I agree with you (on both
> points, actually), but the SpacemiT one is not my copyright to
> modify.
> 
> So I intend to keep both of these as-is.
> 
ok, fine

> > 
> >> + */
> >> +
> >> +#include <linux/bitfield.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/device.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/dmaengine.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/reset.h>
> >> +#include <linux/scatterlist.h>
> >> +#include <linux/sizes.h>
> >> +#include <linux/spi/spi.h>
> >> +#include <linux/units.h>
> >> +
> >> +#include "internals.h"
> >> +
> >> +/* This is used if the spi-max-frequency property is not present */
> >> +#define K1_SPI_MAX_SPEED_HZ	25600000
> >> +
> >> +/* DMA constraints */
> >> +#define K1_SPI_DMA_ALIGNMENT	64
> >> +#define K1_SPI_MAX_DMA_LEN	SZ_512K
> >> +
> >> +/* SpacemiT K1 SPI Registers */
> >> +
> >> +/* SSP Top Control Register */
> >> +#define SSP_TOP_CTRL		0x00
> >> +#define TOP_SSE				BIT(0)		/* Enable port */
> >> +#define TOP_FRF_MASK			GENMASK(2, 1)	/* Frame format */
> >> +#define TOP_FRF_MOTOROLA			0	/* Motorola SPI */
> >> +#define TOP_DSS_MASK			GENMASK(9, 5)	/* Data size (1-32) */
> >> +#define TOP_SPO				BIT(10)		/* Polarity: 0=low */
> >> +#define TOP_SPH				BIT(11)		/* Half-cycle phase */
> >> +#define TOP_LBM				BIT(12)		/* Loopback mode */
> >> +#define TOP_TRAIL			BIT(13)		/* Trailing bytes */
> >> +#define TOP_HOLD_FRAME_LOW		BIT(14)		/* Master mode */
> >> +
> > it's hard to distinguish the register vs BIT definition,
> > how about putting extra space to slightly ajdust the arrange,
> > something like:
> > 
> > #define SSP_TOP_CTRL		0x00
> > #define  TOP_SSE				BIT(0)		/* Enable port */
> > #define  TOP_FRF_MASK			GENMASK(2, 1)	/* Frame format */
> 
> Both of the above two are fields within the SSP_TOP_CTRL register.
> 
> > ...
> 
> The formatting convention I used is (roughly):
> - One tab:	register offset
> - Two tabs:	bit/multi-bit field within register
> - Three tabs:	values relevant to a field
> 
> The TOP_FRF_MOTOROLA symbol is a meaningful value that can be
> assigned in the TOP_FRF_MASK, in the SSP_TOP_CTRL register.
> 
> In e-mail, the formatting doesn't all look as it should.
> 
oh, I see

> >> +/* SSP FIFO Control Register */
> >> +#define SSP_FIFO_CTRL		0x04
> >> +#define FIFO_TFT_MASK			GENMASK(4, 0)	/* TX FIFO threshold */
> >> +#define FIFO_RFT_MASK			GENMASK(9, 5)	/* RX FIFO threshold */
> >> +#define FIFO_TSRE			BIT(10)		/* TX service request */
> >> +#define FIFO_RSRE			BIT(11)		/* RX service request */
> >> +
> >> +/* SSP Interrupt Enable Register */
> >> +#define SSP_INT_EN		0x08
> >> +#define SSP_INT_EN_TINTE		BIT(1)		/* RX timeout */
> >> +#define SSP_INT_EN_RIE			BIT(2)		/* RX FIFO */
> >> +#define SSP_INT_EN_TIE			BIT(3)		/* TX FIFO */
> >> +#define SSP_INT_EN_RIM			BIT(4)		/* RX FIFO overrun */
> >> +#define SSP_INT_EN_TIM			BIT(5)		/* TX FIFO underrun */
> >> +
> >> +/* SSP Time Out Register */
> >> +#define SSP_TIMEOUT		0x0c
> >> +#define SSP_TIMEOUT_MASK		GENMASK(23, 0)
> >> +
> >> +/* SSP Data Register */
> >> +#define SSP_DATAR		0x10
> >> +
> >> +/* SSP Status Register */
> >> +#define SSP_STATUS		0x14
> >> +#define SSP_STATUS_BSY			BIT(0)		/* SPI/I2S busy */
> >> +#define SSP_STATUS_TNF			BIT(6)		/* TX FIFO not full */
> >> +#define SSP_STATUS_TFL			GENMASK(11, 7)	/* TX FIFO level */
> >> +#define SSP_STATUS_TUR			BIT(12)		/* TX FIFO underrun */
> >> +#define SSP_STATUS_RNE			BIT(14)		/* RX FIFO not empty */
> >> +#define SSP_STATUS_RFL			GENMASK(19, 15)	/* RX FIFO level */
> >> +#define SSP_STATUS_ROR			BIT(20)		/* RX FIFO overrun */
> >> +
> >> +/* The FIFO sizes and thresholds are the same for RX and TX */
> >> +#define K1_SPI_FIFO_SIZE	32
> >> +#define K1_SPI_THRESH		(K1_SPI_FIFO_SIZE / 2)
> >> +
> >> +struct k1_spi_io {
> >> +	enum dma_data_direction dir;
> >> +	struct dma_chan *chan;
> >> +	void *buf;
> >> +	unsigned int resid;
> >> +	u32 nents;
> >> +	struct sg_table sgt;
> > can you reorder the struct members to make it slightly more neat?
> > I know people tend to keep struct first and group same functions together..
> 
> I ordered them first logically, and second based on alignment.
> - The direction and channel are directly related to DMA
> - The buffer is and its residual byte count are related
> - The nents is the number of entries mapped in the SGT;
>    I put it before the SGT because it and the residual
>    count above fit within 8 bytes
> 
> If you feel strongly the readability is too bad I can change
> the order to be Christmas tree like, or something.  Please
> advise.
> 
keep it logicially is good, I have no strong opinion to force use
Christmas tree style
> >> +};
> >> +
> >> +struct k1_spi_driver_data {
> >> +	struct spi_controller *controller;
> >> +	struct device *dev;
> >> +	void __iomem *ioaddr;
> > I'd prefer s/ioaddr/base/
> 
> Actually I prefer that too.  This came from the
> vendor and I never changed it.  Good suggestion,
> I will change it.
> 
> >> +	unsigned long bus_rate;
> >> +	struct clk *clk;
> >> +	unsigned long rate;
> >> +	u32 rx_timeout;
> >> +	int irq;
> >> +
> >> +	struct k1_spi_io rx;
> >> +	struct k1_spi_io tx;
> >> +
> >> +	void *dummy;			/* DMA disabled if NULL */
> > this variable really make me confused, and the comment here hardly helps,
> > can you think of a better name? will it be used in DMA mode or also in PIO mode?
> 
> The name "dummy" matches a similar field in the SPI core code.
> It is a buffer used (only) for DMA transfers when the target
> (in or out) is a NULL pointer.
> 
> The comment is a statement of how a null pointer is interpreted
> (implemented by k1_spi_dma_enabled()).
> 
> I'm OK with the name, but if you have a different one that you
> would not find confusing, please let me know.
> 
I haven't investigated.. so will leave you or others to decide

> >> +	u32 data_reg_addr;		/* DMA address of the data register */
> > s/data_reg_addr/ssp_data/? I just feel uncomfortable with redundant 'reg_addr'
> 
> My convention is normally "virt" or maybe "base" to represent
> a virtual address, and "addr" to represent I/O addresses.
> 
> This symbol represents the physical address that underlies the
> "SSP Data Register", which fills the TX FIFO when written and
> drains the RX FIFO when read.
> 
> How about "data_addr"?  I know you wouldn't like "reg_addr".
> 
another idea here, instead of introducing a variable here,
how about simply using plain iores->start + SSP_DATAR?

so you can cache "iores" instead..

> >> +
> >> +	struct spi_message *message;	/* Current message */
> >> +
> >> +	/* Current transfer information; not valid if message is null */
> >> +	unsigned int len;
> >> +	u32 bytes;			/* Bytes used for bits_per_word */
> >> +	bool dma_mapped;
> >> +	struct completion completion;	/* Transfer completion */
> >> +};
> >> +
> >> +static bool k1_spi_dma_enabled(struct k1_spi_driver_data *drv_data)
> >> +{
> >> +	return !!drv_data->dummy;
> >> +}
> >> +
> >> +static bool k1_spi_map_dma_buffer(struct k1_spi_io *io, size_t len, void *dummy)
> >> +{
> >> +	struct device *dmadev = io->chan->device->dev;
> >> +	unsigned int nents = DIV_ROUND_UP(len, SZ_2K);
> >> +	struct sg_table *sgt = &io->sgt;
> >> +	void *bufp = io->buf ? : dummy;
> > simply s/bufp/buf/, embed pointer info into variable doesn't really help
> > let's leave compiler to check
> 
> I called it "buf" originally and changed it to "bufp" because it
> actually advances through the buffer (either the one in the IO
> structure or the dummy buffer) in the loop.
> 
> I don't understand your comment about the compiler.
> 
for the compiler to check the type.. because people could even name it as
	u32 bufp;
you can't tell it's a pointer from its name

> >> +	struct scatterlist *sg;
> >> +	unsigned int i;
> >> +
> >> +	if (nents != sgt->nents) {
> >> +		sg_free_table(sgt);
> >> +		if (sg_alloc_table(sgt, nents, GFP_KERNEL))
> >> +			return false;
> >> +	}
> >> +
> >> +	for_each_sg(sgt->sgl, sg, nents, i) {
> >> +		size_t bytes = min_t(size_t, len, SZ_2K);
> >> +
> >> +		sg_set_buf(sg, bufp, bytes);
> >> +		if (bufp != dummy)
> >> +			bufp += bytes;
> >> +		len -= bytes;
> >> +	}
> >> +	io->nents = dma_map_sg(dmadev, sgt->sgl, nents, io->dir);
> >> +
> >> +	return !!io->nents;
> >> +}
> 
> . . .
> 
> >> +static bool k1_spi_transfer_start_dma(struct k1_spi_driver_data *drv_data)
> >> +{
> >> +	struct dma_async_tx_descriptor *rx_desc;
> >> +	struct dma_async_tx_descriptor *tx_desc;
> >> +	struct device *dev = drv_data->dev;
> >> +	void __iomem *virt;
> > s/virt/reg/, more natural
> 
> Not more natural to me.  It is a virtual address mapped to
> I/O memory.
> 
literally, it's all virtual address when CPU comes to access I/O memory

> >> +	u32 val;
> >> +
> >> +	rx_desc = k1_spi_prepare_dma_io(drv_data, &drv_data->rx);
> >> +	if (!rx_desc) {
> >> +		dev_err(dev, "failed to get DMA RX descriptor\n");
> >> +		return false;
> >> +	}
> >> +
> >> +	tx_desc = k1_spi_prepare_dma_io(drv_data, &drv_data->tx);
> >> +	if (!tx_desc) {
> >> +		dev_err(dev, "failed to get DMA TX descriptor\n");
> >> +		return false;
> >> +	}
> >> +
> >> +	virt = drv_data->ioaddr + SSP_TOP_CTRL;
> >> +	val = readl(virt);
> >> +	val |= TOP_TRAIL;	/* Trailing bytes handled by DMA */
> >> +	writel(val, virt);
> > 
> > I'd prefer to do like this, it's more easy for people to grep..
> > 	val = readl(drv_data->ioaddr + SSP_TOP_CTRL) | TOP_TRAIL;
> > 	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);
> 
> This is an idiom I use to make it very clear that:
> - The address being read is exactly the same as what's being
>    written
> - The value read is being updated with bits/values
> 
> I find that putting the "| TOP_TRAIL" on the same line as the
> readl() call obscures things a bit.  Like my eye doesn't notice
> it as readiliy somehow...
fair, let's put it into another line

> 
> Yours is a pure coding style comment.  There are two pieces, and
> I'd like you to tell me how strongly you feel about them:
> - Using virt to grab the address being written and read (versus
>    just using drv_data->ioaddr + SSP_TOP_CTRL twice)
> - Put the "| TOP_TRAIL" on the same line as the readl() (versus
>    having that be assigned on a separate line).
> To me, the second one is more important than the first.
> 
> Let me know how strongly you feel about these and I'll update
> my convention througout.
> 
I'd strongly prefer not to introduce 'virt', so be something like this:
 	val = readl(drv_data->ioaddr + SSP_TOP_CTRL);
 	val |= TOP_TRAIL;
 	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);

> > 
> >> +
> >> +	virt = drv_data->ioaddr + SSP_FIFO_CTRL;
> >> +	val = readl(virt);
> >> +	val |= FIFO_TSRE | FIFO_RSRE;
> >> +	writel(val, virt);
> >> +
> >> +	/* When RX is complete we also know TX has completed */
> >> +	rx_desc->callback = k1_spi_callback;
> >> +	rx_desc->callback_param = &drv_data->completion;
> >> +
> >> +	dmaengine_submit(rx_desc);
> >> +	dmaengine_submit(tx_desc);
> >> +
> >> +	dma_async_issue_pending(drv_data->rx.chan);
> >> +	dma_async_issue_pending(drv_data->tx.chan);
> >> +
> >> +	return true;
> >> +}
> 
> 
> . . .
> 
> >> +static bool k1_spi_read(struct k1_spi_driver_data *drv_data)
> >> +{
> >> +	struct k1_spi_io *rx = &drv_data->rx;
> >> +	unsigned int count;
> >> +	u32 val;
> >> +
> >> +	if (!rx->resid)
> >> +		return true;	/* Nothing more to receive */
> >> +
> >> +	/* We'll read as many slots in the FIFO as there are available */
> >> +	val = readl(drv_data->ioaddr + SSP_STATUS);
> >> +	/* The number of open slots is one more than what's in the field */
> >> +	count = FIELD_GET(SSP_STATUS_RFL, val) + 1;
> >> +
> >> +	/* A full FIFO count means the FIFO is either full or empty */
> >> +
> >> +	if (count == K1_SPI_FIFO_SIZE)
> >> +		if (!(val & SSP_STATUS_RNE))
> >> +			return false;	/* Nothing available to read */
> >> +
> >> +	count = min(count, rx->resid);
> >> +	while (count--)
> >> +		k1_spi_read_word(drv_data);
> >> +
> >> +	return !rx->resid;
> >> +}
> >> +
> >> +static void k1_spi_write_word(struct k1_spi_driver_data *drv_data)
> >> +{
> >> +	struct k1_spi_io *tx = &drv_data->tx;
> >> +	u32 bytes;
> >> +	u32 val;
> > u32 val = 0;
> 
> There is no need to initialize val.  The value of bytes
> will only be 1, 2, or 4.
> 
> But I suppose the compiler (or a static analyzer) might
> complain, so I'll do as you suggest...
> 
> >> +
> >> +	bytes = drv_data->bytes;
> >> +	if (tx->buf) {
> >> +		if (bytes == 1)
> >> +			val = *(u8 *)tx->buf;
> >> +		else if (bytes == 2)
> >> +			val = *(u16 *)tx->buf;
> >> +		else if (bytes == 4)
> >> +			val = *(u32 *)tx->buf;
> >> +		tx->buf += bytes;
> > ..
> >> +	} else {
> >> +		val = 0;	/* Null writer; write 1, 2, or 4 zero bytes */
> >> +	}
> > for the logic, assign val = 0 at first place? then you can kill this 'else'
> 
> Yes I'll do that (drop the else block) too.
> 
> >> +
> >> +	tx->resid -= bytes;
> >> +	writel(val, drv_data->ioaddr + SSP_DATAR);
> >> +}
> >> +
> >> +static bool k1_spi_write(struct k1_spi_driver_data *drv_data)
> >> +{
> >> +	struct k1_spi_io *tx = &drv_data->tx;
> >> +	unsigned int count;
> >> +	u32 val;
> >> +
> >> +	if (!tx->resid)
> >> +		return true;	/* Nothing more to send */
> >> +
> >> +	/* See how many slots in the TX FIFO are available */
> >> +	val = readl(drv_data->ioaddr + SSP_STATUS);
> >> +	count = FIELD_GET(SSP_STATUS_TFL, val);
> >> +
> >> +	/* A zero count means the FIFO is either full or empty */
> >> +	if (!count) {
> >> +		if (val & SSP_STATUS_TNF)
> >> +			count = K1_SPI_FIFO_SIZE;
> >> +		else
> >> +			return false;	/* No room in the FIFO */
> >> +	}
> >> +
> >> +	/*
> >> +	 * Limit how much we try to send at a time, to reduce the
> >> +	 * chance the other side can overrun our RX FIFO.
> >> +	 */
> >> +	count = min3(count, K1_SPI_THRESH, tx->resid);
> >> +	while (count--)
> >> +		k1_spi_write_word(drv_data);
> >> +
> >> +	return !tx->resid;
> >> +}
> 
> . . .
> 
> >> +static void k1_spi_host_init(struct k1_spi_driver_data *drv_data, int id)
> >> +{
> >> +	struct device_node *np = dev_of_node(drv_data->dev);
> >> +	struct spi_controller *host = drv_data->controller;
> >> +	struct device *dev = drv_data->dev;
> >> +	u32 bus_num;
> >> +	int ret;
> >> +
> >> +	host->dev.of_node = np;
> >> +	host->dev.parent = drv_data->dev;
> >> +	if (!of_property_read_u32(np, "spacemit,k1-ssp-id", &bus_num))
> >> +		host->bus_num = bus_num;
> >> +	else
> >> +		host->bus_num = id;
> >> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> >> +	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
> >> +	host->num_chipselect = 1;
> >> +
> >> +	if (k1_spi_dma_enabled(drv_data))
> >> +		host->dma_alignment = K1_SPI_DMA_ALIGNMENT;
> >> +	host->cleanup = k1_spi_cleanup;
> >> +	host->setup = k1_spi_setup;
> >> +	host->transfer_one_message = k1_spi_transfer_one_message;
> >> +
> > ..
> >> +	ret = of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
> >> +	if (ret < 0) {
> >> +		if (ret != -EINVAL)
> >> +			dev_warn(dev, "bad spi-max-frequency, using %u\n",
> >> +				 K1_SPI_MAX_SPEED_HZ);
> > the err msg does't really usefull..
> 
> You mean there should be no error message, or that it
> should say something else?
> 
> >> +		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;
> >> +	}
> > so in any case, there will be an assignment, I'd rather simplify it as
> > 
> > 	if (of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
> > 		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;
> 
> I add the warning so it's clear we're using something different
> than is specified in the DT.
> 
I personally do not really care about the msg as long as there is a known good value,
but you could weigh this..

further I feel the warning message isn't accurate, if spi-max-frequency is
"bad", why not let user fix it? does "bad" means invalid or overflow?

I don't want to have bikeshedding on this, feel free to pick my suggestion
or keep yours, there is no much real difference

thanks for your efforts to work on this

-- 
Yixun Lan (dlan)

