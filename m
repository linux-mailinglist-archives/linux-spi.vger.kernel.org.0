Return-Path: <linux-spi+bounces-9066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D9AFB3EA
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3FD3A7679
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17929B23D;
	Mon,  7 Jul 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auVZl2ME"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67A29B218;
	Mon,  7 Jul 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893559; cv=none; b=rURcy3tcLzN5dT4m337gVdONRBJkJGvYlIjkNVdodx0LCmCSGBfWEm5EvJ3y+3rmZmhpOzkjDRpLT61zOp0cwSjQ/92EqnUZpEH7/yL7VKAd4jOlieYOStcZoCNqOIRYyQQ+ykcS9XQhdUuK/W1tyYsBRITXtGNzJIU9eHM/B9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893559; c=relaxed/simple;
	bh=PuLkdsqUGDmezMVAO49b/CuVBHRcasZBx/jY/Y7ONeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDavrV0SuGSZR8BWJswMvyVZpL1g1HrDpWWZOrRmLVBAVrSOgCSe+WmrjOQrQzBoP/D3jODQDYXy0QYfZVLZhbjiAifBXliVnUWcx3ShLkbbWrzvzLmbkbD+cD0evYCw+/BuW3bAB80docpj2wHTm73B+WhBCOXuS1DY9/YxleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auVZl2ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C28C4CEE3;
	Mon,  7 Jul 2025 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751893558;
	bh=PuLkdsqUGDmezMVAO49b/CuVBHRcasZBx/jY/Y7ONeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auVZl2ME5ZhvPj5grOu5VjEFBMbi/SAqVXXpQHVX0V3478vEwPNBhTaGP08auugIt
	 oEu88gjSXXLi8nB8TnB5XFvk0FCkFPHwgPQCMtL5Ef1m+HEmx/BRyOJ3HTiAtlPMRY
	 BYv8x5LS/idAmMaRFpQ7fITg/TjwhRqZLdbW//BIMenxKnoBu8W4Yq2kggebe0Y5f2
	 46Vkwax1UGXn7Yqp6UceR/iSyKfUBuYZ74B6nyFKdOi7oFtxcEDCOsEnv1AJteWdRB
	 sqSkf7uxtuOOBGEnhN5/Ou56UuhvQ8RdqYBHBPK6Mg+WEi2aE2K4cwK7EfjlMgv3fs
	 dnpUkAWjl768w==
Date: Mon, 7 Jul 2025 14:05:53 +0100
From: Mark Brown <broonie@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
Message-ID: <3ac88119-9980-42df-9e1c-c0ec30bbaadd@sirena.org.uk>
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
 <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XuNRsNwpi0P6rBB3"
Content-Disposition: inline
In-Reply-To: <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
X-Cookie: We are what we are.


--XuNRsNwpi0P6rBB3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2025 at 10:59:33AM +0800, Xianwei Zhao via B4 Relay wrote:

> Introduced support for the new SPI IP (SPISG) driver. The SPISG is
> a communication-oriented SPI controller from Amlogic,supporting
> three operation modes: PIO, block DMA, and scatter-gather DMA.

This looks good, a few small things below but nothing major.

> +static bool aml_spisg_can_dma(struct spi_controller *ctlr,
> +			      struct spi_device *spi,
> +			      struct spi_transfer *xfer)
> +{
> +	return true;
> +}

Is it worth having a copybreak such that smaller transfers are done
using PIO?  With a lot of controllers that increases performance due to
the extra overhead of setting up DMA, talking to the DMA and interrupt
controllers can be as expensive as directly accessing the FIFOs.

> +static irqreturn_t aml_spisg_irq(int irq, void *data)
> +{
> +	struct spisg_device *spisg = (void *)data;
> +	u32 sts;
> +
> +	spisg->status = 0;
> +	regmap_read(spisg->map, SPISG_REG_IRQ_STS, &sts);
> +	regmap_write(spisg->map, SPISG_REG_IRQ_STS, sts);
> +	if (sts & (IRQ_RCH_DESC_INVALID |
> +		   IRQ_RCH_DESC_RESP |
> +		   IRQ_RCH_DATA_RESP |
> +		   IRQ_WCH_DESC_INVALID |
> +		   IRQ_WCH_DESC_RESP |
> +		   IRQ_WCH_DATA_RESP |
> +		   IRQ_DESC_ERR))
> +		spisg->status = sts;
> +
> +	complete(&spisg->completion);
> +
> +	return IRQ_HANDLED;

It'd be better to check if there's an interrupt actually flagged and
return IRQ_NONE if not, as well as supporting sharing that means that
the interrupt core can handle any errors that cause the interrupt to
latch on.

> +	ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq, 0, NULL, spisg);
> +	if (ret) {
> +		dev_err(&pdev->dev, "irq request failed\n");
> +		goto out_controller;
> +	}
> +
> +	ret = aml_spisg_clk_init(spisg, base);
> +	if (ret)
> +		goto out_controller;

Do we need the clocks for register access - if so what happens if the
interrupt fires as soon as it is registered?  I'd have expected
requesting the interrupt to be one of the last things done.

--XuNRsNwpi0P6rBB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhrxjEACgkQJNaLcl1U
h9BsIQf6A+9yaMYcp1gxZdLMx2jltWF7cHCNvSupFRmtYZ0ljM+gNdKkaigkOinq
rHrYqdyrb+tJLA7AKeFshHPiEVJi4v9hZXJTlVWSE9dO0GaZ+/C7wDGzFejo/V2V
ZD+3xVNkv/SO8hv/eeay1Y8eL4iMKfIcZZn3sBepyLR1Hlo6YrrmyxnYsvDOzVYH
RxE+wvzzB10bC/Bjsvg3HnkYpnmb01a9o0awWFw324+uDcv91wp5i+Bsv9NQLkBs
tmobLgDQjVj6WihO2nmXoB+2vbAmrWZQaFNl7FS2TnyanYBUwNRPkWi/UhGDwoHK
AqUULN21wUgdXzCXib52d1c67OyQYQ==
=dEip
-----END PGP SIGNATURE-----

--XuNRsNwpi0P6rBB3--

