Return-Path: <linux-spi+bounces-10327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510DBA707D
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF2818965B0
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F41F1302;
	Sun, 28 Sep 2025 12:36:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1791C84A1;
	Sun, 28 Sep 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759062990; cv=none; b=avXGb2BL5QOprhJxe0/D3AQyMirmqTTijnDcAD43rrK2i87F4t3l0xPJz4yxZDk0YODhVTiLHhzNtxlX4L4T0BLOiWCfCfUWd47eO7RR2/Nf3Ct/7tXq56v0WzLRffIcRYnL0bGNy/DclHOD6cjbr4UZm8WqW0CIda12UDY+sTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759062990; c=relaxed/simple;
	bh=l9Q144PMpYoyc7MJ9uG80U7HLDSOpM3aAqyn15dVI/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8LqbX+DVpVdaApSWnLhi2gAgHcHlf6k2IN9ush9f/3Y9iZ3Btrd6dLmMFWag0LHiFbhVs71Y5vJQWdkuF1Kg6koTUyskcKkzMzgcU77D7/ahCLtk2NR2ggqstKsAYa6Ri9oTtQL2RcGqdrsdjyRNpMtLx9mi0K9nQv2LCgEPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BCC58340D91;
	Sun, 28 Sep 2025 12:36:27 +0000 (UTC)
Date: Sun, 28 Sep 2025 20:36:22 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <20250928123622-GYA1347020@gentoo.org>
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-3-elder@riscstar.com>
 <20250922230639-GYA1303776@gentoo.org>
 <786f4a5e-f62e-4cd0-a017-7b61408f34aa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786f4a5e-f62e-4cd0-a017-7b61408f34aa@riscstar.com>

Hi Alex,

On 07:49 Tue 23 Sep     , Alex Elder wrote:
> On 9/22/25 6:06 PM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > On 11:17 Mon 22 Sep     , Alex Elder wrote:
> >> This patch introduces the driver for the SPI controller found in the
> >> SpacemiT K1 SoC.  Currently the driver supports master mode only.
> >> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
> >> supports both PIO and DMA mode transfers.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
..
> 
> >> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
> >> new file mode 100644
> >> index 0000000000000..2b932d80cc510
> >> --- /dev/null
> >> +++ b/drivers/spi/spi-spacemit-k1.c
> >> @@ -0,0 +1,965 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Support for SpacemiT K1 SPI controller
> >> + *
> >> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
> >> + * Copyright (c) 2023, spacemit Corporation.
> >> + */
> 
> . . .
> 
> >> +static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
> >> +{
> >> +	struct k1_spi_driver_data *drv_data = dev_id;
> >> +	bool rx_done;
> >> +	bool tx_done;
> >> +	u32 val;
> >> +
> >> +	/* Get status and clear pending interrupts */
> >> +	val = readl(drv_data->base + SSP_STATUS);
> >> +	writel(val, drv_data->base + SSP_STATUS);
> >> +
> >> +	if (!drv_data->message)
> >> +		return IRQ_NONE;
> >> +
> >> +	/* Check for a TX underrun or RX underrun first */
> > s/RX underrun/RX overrun/
> 
> OK.
> 
> >> +	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
> >> +		/* Disable all interrupts on error */
> >> +		writel(0, drv_data->base + SSP_INT_EN);
> > should clear status of SSP_STATUS instead of disabling ISR, see commet below
> 
> The status is cleared immediately after reading, above.  We hold
> the status value so we can act on the current state of the FIFOs.
> 
I'm surprised by this, do you mean the status will be cleared by reading?
can you double checck and prove it? by reading twice and compare?

while according to the docs - 18.2.4.6 SSSR REGISTERS, the status bits has
two types: 
  R - Read only
  R/W1C - Read only, write 1 to clear

if you're right, then the docs should be fixed.

-- 
Yixun Lan (dlan)

