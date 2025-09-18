Return-Path: <linux-spi+bounces-10118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627EB84E5E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0925C179F1A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4C21ABC9;
	Thu, 18 Sep 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dt5IJ3rs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FD1DB127
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203156; cv=none; b=pnvcEW9Pg5Xp1zkUdKOopGd8JlAqV2ZXjuOVmwJRh/1t2OIMuvb40QJcmnsnL39fKBx6DkuJKKTX5tWfJY28VruqgpM6DoyMtYlUDDv3pf4xrBnoOwdSFNiYBrtR2z1HW8RsOUuxf+vNmSMQQjKZ08VBrkgmqJLqB8E+rqUo2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203156; c=relaxed/simple;
	bh=zoohtks+gAHpkCQX/4wyN9/5D6X0DhkkRqpqFdxHqHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4/hjais1+flonwUfNfzZJIaqg141Mh+KpzBjpReEIG7Yp7TH/8bwlRp34Sb4gvzwgdhLUzqegVcO6ZXJn+jlIoy0DURJCiL77dRB2E7yYYsv+ZmJCBD30hHucvaHwAAlaqmfa5yqPoq+4jOYnVktL1XKC0PyUkvqt1Y/82Y0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dt5IJ3rs; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42408762dc3so4742185ab.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758203151; x=1758807951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUd/2fFxw8bFjz2tTtHt0Db/TTKMn6fkG5OOhxAaOTQ=;
        b=dt5IJ3rsREJHgz8ZJ4XKJ5nuxfB/zQJR9J3JVvvqbnq9H86/FQsouYbkNYLmMWoXu7
         zWHRtn9QPkraQvOsMLSvWSqfm4iOsbGDAYyypTXCnGVEIuvQls1ym32z7GhY4TY0FSdw
         83SRSaPAkQQJipxOe9myb/VDcpw4KlCo/CZBa3ogIJ7lIAC46TqeWFT4j8Yx2QweRl5H
         SdwrJIY3YpsldDuNjqOP0qLG7tJIqbgH3Nz1kXcKH9k63PYhLq2SBCj9seDmclkEY6Ad
         5JMKyikmCa/OPRCTx7ZVBquoBT2AXV7xRovYNvSThVSKXEmvd8s03Vfr1eDoyq9ttoMI
         C1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203151; x=1758807951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUd/2fFxw8bFjz2tTtHt0Db/TTKMn6fkG5OOhxAaOTQ=;
        b=KdIIxLOTSZFAH6hg0lv+PxjnfzwoLkePhdn/jd15fM9jnoyy9lHNhqCXAg2PqqQOs7
         A4IpFegaidXlTBte6jBw4VZhzYdCvjk4dIbVu2jpryfekwF3MNc2jL0/rCXfZ7hBfVvj
         67P2tRtHkuqGJ5LytOUBwPWLswqR96xXB9rmPG/lnanLHSZVnoXeCbWkT59PK9+cbU8b
         Y3VkDJFL9Ysdm878bUsKFRcL6PW1hrGPowjSyUuXO9/Jxh0IAu2xZrV4IZww9OI2WWsr
         SNyzB1CbTHszVx00K7ZqpGrrhKwSKaJPXn6sm2fwyFdODNHCioWoc0L7lF4cQkhus9Fi
         V1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/4ZOnTnOBrst/QcFl9iA5JLh2aPpeVsT+QzkyHW/iyy9DIUrgUw37F+S++iJ+/SMj+lDMZKz88Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweoPFAhn1CxdQi5oOdr1coXCNZZlySwz1toTOAeU2pooH9Xtvl
	ajXGkhbGM+1LOQ3PSBY7nFqyIcQmaZeWHZX2VyQ/XAYxAfyOluTqfA8xoy8jGgyfAjY=
X-Gm-Gg: ASbGncvf0WGbpG4iBItxn1y4kMuuFjEn/IRph2LC757w5iUrOLInATcm34yeXAaO+Vg
	KAvMk3Nvicd2c5to7wB8U52EetoNsDxAxPMna96ACekS2J8O/XjPRaw5+XAQ8Hkp4eTrf4rDsE9
	Dhmhu4Six03fRPf3uBgLY5nw2NLdqAMZ01EmYgP9L6yhNJsoBRR2e1x28Suo+UhcIYDTWKDB7d0
	QXJV6SCLYWVt9hL0ErO1yqkSlKtWlZ7lL+H1IYKb+iFBZnUP4lzdymKQrSywM27Qmv85UwvyASN
	SrWHMV+G2C0lEu62iRnO6BC9j5u2+hJ1aYzJESoeBI9w85bbkKUWthlqBh6+NgNaeUzCVMh5gIO
	vPiBFiIQd5CStpnKDdRLKcWyIVjSj+pRexUu1/8ccMGb/upK31ywWUz8vCg5ZQzMBTIg/jBJPPp
	wIKfic0I3idw+ZXFnU
X-Google-Smtp-Source: AGHT+IFo4ahINyTiNAkc8ZxPT4aiLvygUwkD0TE8D4xjHPRp1Y69sA6yEDf69lF/XOpAji+aqKfOIA==
X-Received: by 2002:a05:6e02:b26:b0:418:a784:5e1f with SMTP id e9e14a558f8ab-4241a512672mr74920465ab.16.1758203151200;
        Thu, 18 Sep 2025 06:45:51 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa6538sm940886173.51.2025.09.18.06.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:45:50 -0700 (PDT)
Message-ID: <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
Date: Thu, 18 Sep 2025 08:45:49 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918124120-GYA1273705@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 7:41 AM, Yixun Lan wrote:
> Hi Alex,
> 
> A few comments below which are mostly related to coding style or my personal taste

Great, thank you!  I plan to adopt several of your suggestions, but
in a few cases I explain why the code looks the way it does.  And
I ask for your response in some cases--I'm willing to change but
want to know what you think after you read what I say.

> On 17:07 Wed 17 Sep     , Alex Elder wrote:
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/Kconfig           |   8 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-spacemit-k1.c | 985 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 994 insertions(+)
>>   create mode 100644 drivers/spi/spi-spacemit-k1.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 82fa5eb3b8684..915a52407a85a 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -577,6 +577,14 @@ config SPI_KSPI2
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called spi-kspi2.
>>   
>> +config SPI_SPACEMIT_K1
> keep it sorted? seems you adjust the name but forget to reorder it

Could be.  It is my intention to keep this and many other things
sorted.  I'll fix this.

>> +	tristate "K1 SPI Controller"
>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on OF
>> +	default ARCH_SPACEMIT
>> +	help
>> +	  Enable support for the SpacemiT K1 SPI controller.
>> +
>>   config SPI_LM70_LLP
>>   	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
>>   	depends on PARPORT
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index eefaeca097456..29d55eeb9abb4 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -75,6 +75,7 @@ obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
>>   obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
>>   obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
>>   obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
>> +obj-$(CONFIG_SPI_SPACEMIT_K1)		+= spi-spacemit-k1.o
> same, sort

Yes I'll put this in sorted order too, thanks for noticing.

>>   obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
>>   obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
>>   obj-$(CONFIG_SPI_KSPI2)			+= spi-kspi2.o
>> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
>> new file mode 100644
>> index 0000000000000..6edf75efe7c68
>> --- /dev/null
>> +++ b/drivers/spi/spi-spacemit-k1.c
>> @@ -0,0 +1,985 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Support for SpacemiT K1 SPI controller
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
> keep "(C)" consistent? capitalized
> s/spacemit/SpacemiT/, or I'd suggest to keep it align with vendor-prefixes.yaml..

First, the (C) is verbatim what our company lawyer said to use.

Second, I did not want to change anything on the copyright that
was originally provided by SpacemiT.  I agree with you (on both
points, actually), but the SpacemiT one is not my copyright to
modify.

So I intend to keep both of these as-is.

> 
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/sizes.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/units.h>
>> +
>> +#include "internals.h"
>> +
>> +/* This is used if the spi-max-frequency property is not present */
>> +#define K1_SPI_MAX_SPEED_HZ	25600000
>> +
>> +/* DMA constraints */
>> +#define K1_SPI_DMA_ALIGNMENT	64
>> +#define K1_SPI_MAX_DMA_LEN	SZ_512K
>> +
>> +/* SpacemiT K1 SPI Registers */
>> +
>> +/* SSP Top Control Register */
>> +#define SSP_TOP_CTRL		0x00
>> +#define TOP_SSE				BIT(0)		/* Enable port */
>> +#define TOP_FRF_MASK			GENMASK(2, 1)	/* Frame format */
>> +#define TOP_FRF_MOTOROLA			0	/* Motorola SPI */
>> +#define TOP_DSS_MASK			GENMASK(9, 5)	/* Data size (1-32) */
>> +#define TOP_SPO				BIT(10)		/* Polarity: 0=low */
>> +#define TOP_SPH				BIT(11)		/* Half-cycle phase */
>> +#define TOP_LBM				BIT(12)		/* Loopback mode */
>> +#define TOP_TRAIL			BIT(13)		/* Trailing bytes */
>> +#define TOP_HOLD_FRAME_LOW		BIT(14)		/* Master mode */
>> +
> it's hard to distinguish the register vs BIT definition,
> how about putting extra space to slightly ajdust the arrange,
> something like:
> 
> #define SSP_TOP_CTRL		0x00
> #define  TOP_SSE				BIT(0)		/* Enable port */
> #define  TOP_FRF_MASK			GENMASK(2, 1)	/* Frame format */

Both of the above two are fields within the SSP_TOP_CTRL register.

> ...

The formatting convention I used is (roughly):
- One tab:	register offset
- Two tabs:	bit/multi-bit field within register
- Three tabs:	values relevant to a field

The TOP_FRF_MOTOROLA symbol is a meaningful value that can be
assigned in the TOP_FRF_MASK, in the SSP_TOP_CTRL register.

In e-mail, the formatting doesn't all look as it should.

>> +/* SSP FIFO Control Register */
>> +#define SSP_FIFO_CTRL		0x04
>> +#define FIFO_TFT_MASK			GENMASK(4, 0)	/* TX FIFO threshold */
>> +#define FIFO_RFT_MASK			GENMASK(9, 5)	/* RX FIFO threshold */
>> +#define FIFO_TSRE			BIT(10)		/* TX service request */
>> +#define FIFO_RSRE			BIT(11)		/* RX service request */
>> +
>> +/* SSP Interrupt Enable Register */
>> +#define SSP_INT_EN		0x08
>> +#define SSP_INT_EN_TINTE		BIT(1)		/* RX timeout */
>> +#define SSP_INT_EN_RIE			BIT(2)		/* RX FIFO */
>> +#define SSP_INT_EN_TIE			BIT(3)		/* TX FIFO */
>> +#define SSP_INT_EN_RIM			BIT(4)		/* RX FIFO overrun */
>> +#define SSP_INT_EN_TIM			BIT(5)		/* TX FIFO underrun */
>> +
>> +/* SSP Time Out Register */
>> +#define SSP_TIMEOUT		0x0c
>> +#define SSP_TIMEOUT_MASK		GENMASK(23, 0)
>> +
>> +/* SSP Data Register */
>> +#define SSP_DATAR		0x10
>> +
>> +/* SSP Status Register */
>> +#define SSP_STATUS		0x14
>> +#define SSP_STATUS_BSY			BIT(0)		/* SPI/I2S busy */
>> +#define SSP_STATUS_TNF			BIT(6)		/* TX FIFO not full */
>> +#define SSP_STATUS_TFL			GENMASK(11, 7)	/* TX FIFO level */
>> +#define SSP_STATUS_TUR			BIT(12)		/* TX FIFO underrun */
>> +#define SSP_STATUS_RNE			BIT(14)		/* RX FIFO not empty */
>> +#define SSP_STATUS_RFL			GENMASK(19, 15)	/* RX FIFO level */
>> +#define SSP_STATUS_ROR			BIT(20)		/* RX FIFO overrun */
>> +
>> +/* The FIFO sizes and thresholds are the same for RX and TX */
>> +#define K1_SPI_FIFO_SIZE	32
>> +#define K1_SPI_THRESH		(K1_SPI_FIFO_SIZE / 2)
>> +
>> +struct k1_spi_io {
>> +	enum dma_data_direction dir;
>> +	struct dma_chan *chan;
>> +	void *buf;
>> +	unsigned int resid;
>> +	u32 nents;
>> +	struct sg_table sgt;
> can you reorder the struct members to make it slightly more neat?
> I know people tend to keep struct first and group same functions together..

I ordered them first logically, and second based on alignment.
- The direction and channel are directly related to DMA
- The buffer is and its residual byte count are related
- The nents is the number of entries mapped in the SGT;
   I put it before the SGT because it and the residual
   count above fit within 8 bytes

If you feel strongly the readability is too bad I can change
the order to be Christmas tree like, or something.  Please
advise.

>> +};
>> +
>> +struct k1_spi_driver_data {
>> +	struct spi_controller *controller;
>> +	struct device *dev;
>> +	void __iomem *ioaddr;
> I'd prefer s/ioaddr/base/

Actually I prefer that too.  This came from the
vendor and I never changed it.  Good suggestion,
I will change it.

>> +	unsigned long bus_rate;
>> +	struct clk *clk;
>> +	unsigned long rate;
>> +	u32 rx_timeout;
>> +	int irq;
>> +
>> +	struct k1_spi_io rx;
>> +	struct k1_spi_io tx;
>> +
>> +	void *dummy;			/* DMA disabled if NULL */
> this variable really make me confused, and the comment here hardly helps,
> can you think of a better name? will it be used in DMA mode or also in PIO mode?

The name "dummy" matches a similar field in the SPI core code.
It is a buffer used (only) for DMA transfers when the target
(in or out) is a NULL pointer.

The comment is a statement of how a null pointer is interpreted
(implemented by k1_spi_dma_enabled()).

I'm OK with the name, but if you have a different one that you
would not find confusing, please let me know.

>> +	u32 data_reg_addr;		/* DMA address of the data register */
> s/data_reg_addr/ssp_data/? I just feel uncomfortable with redundant 'reg_addr'

My convention is normally "virt" or maybe "base" to represent
a virtual address, and "addr" to represent I/O addresses.

This symbol represents the physical address that underlies the
"SSP Data Register", which fills the TX FIFO when written and
drains the RX FIFO when read.

How about "data_addr"?  I know you wouldn't like "reg_addr".

>> +
>> +	struct spi_message *message;	/* Current message */
>> +
>> +	/* Current transfer information; not valid if message is null */
>> +	unsigned int len;
>> +	u32 bytes;			/* Bytes used for bits_per_word */
>> +	bool dma_mapped;
>> +	struct completion completion;	/* Transfer completion */
>> +};
>> +
>> +static bool k1_spi_dma_enabled(struct k1_spi_driver_data *drv_data)
>> +{
>> +	return !!drv_data->dummy;
>> +}
>> +
>> +static bool k1_spi_map_dma_buffer(struct k1_spi_io *io, size_t len, void *dummy)
>> +{
>> +	struct device *dmadev = io->chan->device->dev;
>> +	unsigned int nents = DIV_ROUND_UP(len, SZ_2K);
>> +	struct sg_table *sgt = &io->sgt;
>> +	void *bufp = io->buf ? : dummy;
> simply s/bufp/buf/, embed pointer info into variable doesn't really help
> let's leave compiler to check

I called it "buf" originally and changed it to "bufp" because it
actually advances through the buffer (either the one in the IO
structure or the dummy buffer) in the loop.

I don't understand your comment about the compiler.

>> +	struct scatterlist *sg;
>> +	unsigned int i;
>> +
>> +	if (nents != sgt->nents) {
>> +		sg_free_table(sgt);
>> +		if (sg_alloc_table(sgt, nents, GFP_KERNEL))
>> +			return false;
>> +	}
>> +
>> +	for_each_sg(sgt->sgl, sg, nents, i) {
>> +		size_t bytes = min_t(size_t, len, SZ_2K);
>> +
>> +		sg_set_buf(sg, bufp, bytes);
>> +		if (bufp != dummy)
>> +			bufp += bytes;
>> +		len -= bytes;
>> +	}
>> +	io->nents = dma_map_sg(dmadev, sgt->sgl, nents, io->dir);
>> +
>> +	return !!io->nents;
>> +}

. . .

>> +static bool k1_spi_transfer_start_dma(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct dma_async_tx_descriptor *rx_desc;
>> +	struct dma_async_tx_descriptor *tx_desc;
>> +	struct device *dev = drv_data->dev;
>> +	void __iomem *virt;
> s/virt/reg/, more natural

Not more natural to me.  It is a virtual address mapped to
I/O memory.

>> +	u32 val;
>> +
>> +	rx_desc = k1_spi_prepare_dma_io(drv_data, &drv_data->rx);
>> +	if (!rx_desc) {
>> +		dev_err(dev, "failed to get DMA RX descriptor\n");
>> +		return false;
>> +	}
>> +
>> +	tx_desc = k1_spi_prepare_dma_io(drv_data, &drv_data->tx);
>> +	if (!tx_desc) {
>> +		dev_err(dev, "failed to get DMA TX descriptor\n");
>> +		return false;
>> +	}
>> +
>> +	virt = drv_data->ioaddr + SSP_TOP_CTRL;
>> +	val = readl(virt);
>> +	val |= TOP_TRAIL;	/* Trailing bytes handled by DMA */
>> +	writel(val, virt);
> 
> I'd prefer to do like this, it's more easy for people to grep..
> 	val = readl(drv_data->ioaddr + SSP_TOP_CTRL) | TOP_TRAIL;
> 	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);

This is an idiom I use to make it very clear that:
- The address being read is exactly the same as what's being
   written
- The value read is being updated with bits/values

I find that putting the "| TOP_TRAIL" on the same line as the
readl() call obscures things a bit.  Like my eye doesn't notice
it as readiliy somehow...

Yours is a pure coding style comment.  There are two pieces, and
I'd like you to tell me how strongly you feel about them:
- Using virt to grab the address being written and read (versus
   just using drv_data->ioaddr + SSP_TOP_CTRL twice)
- Put the "| TOP_TRAIL" on the same line as the readl() (versus
   having that be assigned on a separate line).
To me, the second one is more important than the first.

Let me know how strongly you feel about these and I'll update
my convention througout.

> 
>> +
>> +	virt = drv_data->ioaddr + SSP_FIFO_CTRL;
>> +	val = readl(virt);
>> +	val |= FIFO_TSRE | FIFO_RSRE;
>> +	writel(val, virt);
>> +
>> +	/* When RX is complete we also know TX has completed */
>> +	rx_desc->callback = k1_spi_callback;
>> +	rx_desc->callback_param = &drv_data->completion;
>> +
>> +	dmaengine_submit(rx_desc);
>> +	dmaengine_submit(tx_desc);
>> +
>> +	dma_async_issue_pending(drv_data->rx.chan);
>> +	dma_async_issue_pending(drv_data->tx.chan);
>> +
>> +	return true;
>> +}


. . .

>> +static bool k1_spi_read(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct k1_spi_io *rx = &drv_data->rx;
>> +	unsigned int count;
>> +	u32 val;
>> +
>> +	if (!rx->resid)
>> +		return true;	/* Nothing more to receive */
>> +
>> +	/* We'll read as many slots in the FIFO as there are available */
>> +	val = readl(drv_data->ioaddr + SSP_STATUS);
>> +	/* The number of open slots is one more than what's in the field */
>> +	count = FIELD_GET(SSP_STATUS_RFL, val) + 1;
>> +
>> +	/* A full FIFO count means the FIFO is either full or empty */
>> +
>> +	if (count == K1_SPI_FIFO_SIZE)
>> +		if (!(val & SSP_STATUS_RNE))
>> +			return false;	/* Nothing available to read */
>> +
>> +	count = min(count, rx->resid);
>> +	while (count--)
>> +		k1_spi_read_word(drv_data);
>> +
>> +	return !rx->resid;
>> +}
>> +
>> +static void k1_spi_write_word(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct k1_spi_io *tx = &drv_data->tx;
>> +	u32 bytes;
>> +	u32 val;
> u32 val = 0;

There is no need to initialize val.  The value of bytes
will only be 1, 2, or 4.

But I suppose the compiler (or a static analyzer) might
complain, so I'll do as you suggest...

>> +
>> +	bytes = drv_data->bytes;
>> +	if (tx->buf) {
>> +		if (bytes == 1)
>> +			val = *(u8 *)tx->buf;
>> +		else if (bytes == 2)
>> +			val = *(u16 *)tx->buf;
>> +		else if (bytes == 4)
>> +			val = *(u32 *)tx->buf;
>> +		tx->buf += bytes;
> ..
>> +	} else {
>> +		val = 0;	/* Null writer; write 1, 2, or 4 zero bytes */
>> +	}
> for the logic, assign val = 0 at first place? then you can kill this 'else'

Yes I'll do that (drop the else block) too.

>> +
>> +	tx->resid -= bytes;
>> +	writel(val, drv_data->ioaddr + SSP_DATAR);
>> +}
>> +
>> +static bool k1_spi_write(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct k1_spi_io *tx = &drv_data->tx;
>> +	unsigned int count;
>> +	u32 val;
>> +
>> +	if (!tx->resid)
>> +		return true;	/* Nothing more to send */
>> +
>> +	/* See how many slots in the TX FIFO are available */
>> +	val = readl(drv_data->ioaddr + SSP_STATUS);
>> +	count = FIELD_GET(SSP_STATUS_TFL, val);
>> +
>> +	/* A zero count means the FIFO is either full or empty */
>> +	if (!count) {
>> +		if (val & SSP_STATUS_TNF)
>> +			count = K1_SPI_FIFO_SIZE;
>> +		else
>> +			return false;	/* No room in the FIFO */
>> +	}
>> +
>> +	/*
>> +	 * Limit how much we try to send at a time, to reduce the
>> +	 * chance the other side can overrun our RX FIFO.
>> +	 */
>> +	count = min3(count, K1_SPI_THRESH, tx->resid);
>> +	while (count--)
>> +		k1_spi_write_word(drv_data);
>> +
>> +	return !tx->resid;
>> +}

. . .

>> +static void k1_spi_host_init(struct k1_spi_driver_data *drv_data, int id)
>> +{
>> +	struct device_node *np = dev_of_node(drv_data->dev);
>> +	struct spi_controller *host = drv_data->controller;
>> +	struct device *dev = drv_data->dev;
>> +	u32 bus_num;
>> +	int ret;
>> +
>> +	host->dev.of_node = np;
>> +	host->dev.parent = drv_data->dev;
>> +	if (!of_property_read_u32(np, "spacemit,k1-ssp-id", &bus_num))
>> +		host->bus_num = bus_num;
>> +	else
>> +		host->bus_num = id;
>> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
>> +	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>> +	host->num_chipselect = 1;
>> +
>> +	if (k1_spi_dma_enabled(drv_data))
>> +		host->dma_alignment = K1_SPI_DMA_ALIGNMENT;
>> +	host->cleanup = k1_spi_cleanup;
>> +	host->setup = k1_spi_setup;
>> +	host->transfer_one_message = k1_spi_transfer_one_message;
>> +
> ..
>> +	ret = of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
>> +	if (ret < 0) {
>> +		if (ret != -EINVAL)
>> +			dev_warn(dev, "bad spi-max-frequency, using %u\n",
>> +				 K1_SPI_MAX_SPEED_HZ);
> the err msg does't really usefull..

You mean there should be no error message, or that it
should say something else?

>> +		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;
>> +	}
> so in any case, there will be an assignment, I'd rather simplify it as
> 
> 	if (of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
> 		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;

I add the warning so it's clear we're using something different
than is specified in the DT.

I really appreciate your careful review.

					-Alex

> 
>> +}
>> +
>> +/* Set our registers to a known initial state */
>> +static void
>> +k1_spi_register_reset(struct k1_spi_driver_data *drv_data, bool initial)
>> +{
>> +	u32 val = 0;
>> +
>> +	writel(0, drv_data->ioaddr + SSP_TOP_CTRL);
>> +
>> +	if (initial) {
>> +		/*
>> +		 * The TX and RX FIFO thresholds are the same no matter
>> +		 * what the speed or bits per word, so we can just set
>> +		 * them once.  The thresholds are one more than the values
>> +		 * in the register.
>> +		 */
>> +		val = FIELD_PREP(FIFO_RFT_MASK, K1_SPI_THRESH - 1);
>> +		val |= FIELD_PREP(FIFO_TFT_MASK, K1_SPI_THRESH - 1);
>> +	}
>> +	writel(val, drv_data->ioaddr + SSP_FIFO_CTRL);
>> +
>> +	writel(0, drv_data->ioaddr + SSP_INT_EN);
>> +	writel(0, drv_data->ioaddr + SSP_TIMEOUT);
>> +
>> +	/* Clear any pending interrupt conditions */
>> +	val = readl(drv_data->ioaddr + SSP_STATUS);
>> +	writel(val, drv_data->ioaddr + SSP_STATUS);
>> +}
>> +
>> +static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
>> +{
>> +	struct k1_spi_driver_data *drv_data = dev_id;
>> +	void __iomem *virt;
>> +	bool rx_done;
>> +	bool tx_done;
>> +	u32 val;
>> +
>> +	/* Get status and clear pending interrupts */
>> +	virt = drv_data->ioaddr + SSP_STATUS;
>> +	val = readl(virt);
>> +	writel(val, virt);
>> +
>> +	if (!drv_data->message)
>> +		return IRQ_NONE;
>> +
>> +	/* Check for a TX underrun or RX underrun first */
>> +	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
>> +		/* Disable all interrupts on error */
>> +		writel(0, drv_data->ioaddr + SSP_INT_EN);
>> +
>> +		drv_data->message->status = -EIO;
>> +		complete(&drv_data->completion);
>> +
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	/* Drain the RX FIFO first, then transmit what we can */
>> +	rx_done = k1_spi_read(drv_data);
>> +	tx_done = k1_spi_write(drv_data);
>> +
>> +	/* Disable interrupts if we're done transferring either direction */
>> +	if (rx_done || tx_done) {
>> +		virt = drv_data->ioaddr + SSP_INT_EN;
>> +
>> +		/* If both are done, disable all interrupts */
>> +		if (rx_done && tx_done) {
>> +			val = 0;
>> +		} else {
>> +			val = readl(virt);
>> +			if (rx_done)
>> +				val &= ~(SSP_INT_EN_TINTE | SSP_INT_EN_RIE);
>> +			if (tx_done)
>> +				val &= ~SSP_INT_EN_TIE;
>> +		}
>> +		writel(val, virt);
>> +	}
>> +
>> +	if (rx_done && tx_done)
>> +		complete(&drv_data->completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int k1_spi_probe(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct reset_control *reset;
>> +	struct spi_controller *host;
>> +	struct resource *iores;
>> +	struct clk *clk_bus;
>> +	int ret;
>> +
>> +	host = devm_spi_alloc_host(dev, sizeof(*drv_data));
>> +	if (!host)
>> +		return -ENOMEM;
>> +	drv_data = spi_controller_get_devdata(host);
>> +	drv_data->controller = host;
>> +	platform_set_drvdata(pdev, drv_data);
>> +	drv_data->dev = dev;
>> +	init_completion(&drv_data->completion);
>> +
>> +	drv_data->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +								  &iores);
>> +	if (IS_ERR(drv_data->ioaddr))
>> +		return dev_err_probe(dev, PTR_ERR(drv_data->ioaddr),
>> +				     "error mapping memory\n");
>> +	drv_data->data_reg_addr = iores->start + SSP_DATAR;
>> +
>> +	ret = devm_k1_spi_dma_setup(drv_data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "error setting up DMA\n");
>> +
>> +	k1_spi_host_init(drv_data, pdev->id);
>> +
>> +	clk_bus = devm_clk_get_enabled(dev, "bus");
>> +	if (IS_ERR(clk_bus))
>> +		return dev_err_probe(dev, PTR_ERR(clk_bus),
>> +				     "error getting/enabling bus clock\n");
>> +	drv_data->bus_rate = clk_get_rate(clk_bus);
>> +
>> +	drv_data->clk = devm_clk_get_enabled(dev, "core");
>> +	if (IS_ERR(drv_data->clk))
>> +		return dev_err_probe(dev, PTR_ERR(drv_data->clk),
>> +				     "error getting/enabling core clock\n");
>> +
>> +	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>> +	if (IS_ERR(reset))
>> +		return dev_err_probe(dev, PTR_ERR(reset),
>> +				     "error getting/deasserting reset\n");
>> +
>> +	k1_spi_register_reset(drv_data, true);
>> +
>> +	drv_data->irq = platform_get_irq(pdev, 0);
>> +	if (drv_data->irq < 0)
>> +		return dev_err_probe(dev, drv_data->irq, "error getting IRQ\n");
>> +
>> +	ret = devm_request_irq(dev, drv_data->irq, k1_spi_ssp_isr,
>> +			       IRQF_SHARED, dev_name(dev), drv_data);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "error requesting IRQ\n");
>> +
>> +	ret = devm_spi_register_controller(dev, host);
>> +	if (ret)
>> +		dev_err(dev, "error registering controller\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void k1_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data = platform_get_drvdata(pdev);
>> +
>> +	k1_spi_register_reset(drv_data, false);
>> +}
>> +
>> +static struct platform_driver k1_spi_driver = {
>> +	.driver = {
>> +		.name	= "k1x-spi",
>> +		.of_match_table = k1_spi_dt_ids,
>> +	},
>> +	.probe = k1_spi_probe,
>> +	.remove = k1_spi_remove,
>> +};
>> +
>> +module_platform_driver(k1_spi_driver);
>> +
>> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.48.1
>>
> 


