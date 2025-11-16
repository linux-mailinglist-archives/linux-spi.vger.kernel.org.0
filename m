Return-Path: <linux-spi+bounces-11245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926BC61A7B
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6E173571BE
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557B22D4D3;
	Sun, 16 Nov 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSi7FKFR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C801E0B9C;
	Sun, 16 Nov 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317164; cv=none; b=KUaeUGDmtkMymLvUH4+GUNvJfbn2BP/oJe+0CANvn03KGcE7JboZO3Nr3JVMWVma/Bpey9kHNmBfMQNy/lS/0GxqUfPdriGwYlh/DbVHkuWl+zfFX55oGYH2KUPDwpkbM7Cw2EHQ+9+SfACAlLcq36Clx/9C/N0vZHl+g5B3VGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317164; c=relaxed/simple;
	bh=dEgW1rRC+aV4R5Ukz5J6zVPHu6vjYC2y2EAyWUhddoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOcSPXwieszipGqlAyQABgrsZI4lxe5O8EJGP7jCelF/paQSP1+d+1gYZ7gGQuev8TBcwZx3oNno/DW8z71E+daGkQrNcXgv126/1CtO10viWzqDezXYPUYBwMYC9RtsPKdcfE2Ol3VtrUJFPCTlTeBe4LXCDkeb3IrK8Fyh+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSi7FKFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81E5C4CEF1;
	Sun, 16 Nov 2025 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763317163;
	bh=dEgW1rRC+aV4R5Ukz5J6zVPHu6vjYC2y2EAyWUhddoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSi7FKFRHP4Ad+VAlITP7/J6SSBMdsbE4vUro/7SbibOD8oPHLNSLMHF9SbCtIXvr
	 ZyMdL872/xepUnVZfxG63K6l6NTgsUtFExlLZLjmCDG0YDj6W6DfMEVW2hXnc0X94J
	 XmzsVl1DYGxPN6sF2vHMhAtdSHp7b28pDcWi1WsiQkGDa1wxZWyMPI+5LAhIsSPJQm
	 GKG5aqQEFqBOsw88fMe75jV8TpYPj61haUrTJKVse196/f22gWRS6SpuJMmt2qLRvx
	 iCM+0xkZDfTGHVW1ep1aiLGoVq8E2YXKaEUryZdgQxM84akd/q0dD3qBJXDuncmM+4
	 4pH0+VsTnjIrg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 1DE341ACCC98; Sun, 16 Nov 2025 18:19:21 +0000 (GMT)
Date: Sun, 16 Nov 2025 18:19:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <aRoVqVtYLJJAPCia@sirena.co.uk>
References: <20251114185745.2838358-1-elder@riscstar.com>
 <20251114185745.2838358-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m79HQmrzkmVitIUm"
Content-Disposition: inline
In-Reply-To: <20251114185745.2838358-3-elder@riscstar.com>
X-Cookie: marriage, n.:


--m79HQmrzkmVitIUm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2025 at 12:57:43PM -0600, Alex Elder wrote:

> This patch introduces the driver for the SPI controller found in the
> SpacemiT K1 SoC.  Currently the driver supports master mode only.
> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
> supports both PIO and DMA mode transfers.

This looks mostly good but there's a bit of open coding that looks like
the driver could make more use of the core.

> @@ -0,0 +1,966 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SpacemiT K1 SPI controller driver
> + *
> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
> + * Copyright (c) 2023, spacemit Corporation.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static bool k1_spi_map_dma_buffer(struct k1_spi_io *io, size_t len, void *dummy)
> +{
> +	struct device *dmadev = io->chan->device->dev;
> +	unsigned int nents = DIV_ROUND_UP(len, SZ_2K);
> +	struct sg_table *sgt = &io->sgt;
> +	void *bufp = io->buf ? : dummy;
> +	struct scatterlist *sg;
> +	unsigned int i;

The SPI core can do DMA mapping for you, the only thing this is doing
that's unusual is that it's imposing a fixed 2K limit on block sizes.
If this limit comes from the DMA controller (which looks to be the case
since we feed the entire table into the DMA controller at once?) the
core will already DTRT here, assuming the DMA controller correctly
advertises this restriction.

> +static bool k1_spi_map_dma_buffers(struct k1_spi_driver_data *drv_data)
> +{

...

> +	/* Don't bother with DMA if we can't do even a single burst */
> +	if (drv_data->len < dma_burst_size)
> +		return false;
> +
> +	/* We won't use DMA if the transfer is too big, either */
> +	if (drv_data->len > K1_SPI_MAX_DMA_LEN)
> +		return false;

The core has a can_dma() callback for this.

> +static int k1_spi_transfer_one_message(struct spi_controller *host,
> +					   struct spi_message *message)
> +{

...

> +	/* Hold frame low to avoid losing transferred data */
> +	val = readl(drv_data->base + SSP_TOP_CTRL);
> +	val |= TOP_HOLD_FRAME_LOW;
> +	writel(val, drv_data->base + SSP_TOP_CTRL);

This looks like it should be a set_cs() operation?

> +
> +	list_for_each_entry(transfer, &message->transfers, transfer_list) {
> +		reinit_completion(completion);
> +
> +		/* Issue the next transfer */
> +		if (!k1_spi_transfer_start(drv_data, transfer)) {
> +			message->status = -EIO;
> +			break;
> +		}
> +
> +		k1_spi_transfer_wait(drv_data);
> +
> +		k1_spi_transfer_end(drv_data, transfer);

Why not just implement the transfer_one() callback?  This just looks
like it's duplicating code.

> +static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
> +{

> +	/* Get status and clear pending interrupts */
> +	val = readl(drv_data->base + SSP_STATUS);
> +	writel(val, drv_data->base + SSP_STATUS);

This unconditionally acknowledges all interrupts even if we didn't
handle anything...

--m79HQmrzkmVitIUm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkaFagACgkQJNaLcl1U
h9B8Pgf/Zmjhqwvzz1HwGWIb7Kl/LZ6HBUoyYaZVe4SZCCreL+g9lu2juH2Nzs4r
mZzkYbZx4Xt+bbnKjx/QNjA2I+3oBNzOjpN4HydZatG/yQN9W7Bx64Xous2fXeU6
0RH400LlVzR10eCpPAVWUOg9v9zbotGBAN7hgY6pLm+9AOWkJf4HDqaymiY1ZUSZ
uusOILxXFySQ1/k4itKYVrzybcTEBfOqf3t2I3jAv/q1ADCHnsgI5NDvY1eIi5eX
4GPg14RiN7PXIyjUWERuVyjA9hvpXLhJQYeMgHa8ads9/t1Av1zkN+b904rMYDKQ
pn/l2ypyAVEkMGgblGryYghc4WPYtw==
=fc2P
-----END PGP SIGNATURE-----

--m79HQmrzkmVitIUm--

