Return-Path: <linux-spi+bounces-12091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8AFCD9A28
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF61E3075C24
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CB33A714;
	Tue, 23 Dec 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZPDahTj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852B32E14F;
	Tue, 23 Dec 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500102; cv=none; b=CUO5psHwyqhUxK3151uXIBhH1M3131hFHZnicQipAaAJGT7tSb1Jkr/E7S/zhHCTI/ZBDNU2cKi81yIhI+P/y2SXdTPCWTTTp4M7DX2SiCrygVyqkSRWhUt3dnypgFo3sQ3476kw8dFMiev1GYnfH0pk9c7F+spcANNJ5dporC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500102; c=relaxed/simple;
	bh=8sp6zj+eEy3xsLA2JaPO6/21bRqAq2RJ2kgOcwn6g5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nu4diz25dw4lPXFcL1m9YV2YXtaIeQGEmFrDt/+9apD6Jwm/r1GfwdW/Wm2Ub78ef3OlHVlyof2h3uQhO7uHX8fooy4Yv0JejNX8cqZ8LPoqWMeorhZaKEKG/79B+kHKO4NQ8pKgZzz6BKqJTUxhc3UOSKYO/43yfRSATRhDspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZPDahTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12981C113D0;
	Tue, 23 Dec 2025 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500100;
	bh=8sp6zj+eEy3xsLA2JaPO6/21bRqAq2RJ2kgOcwn6g5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KZPDahTjkYrUfYnHQhmIRsMzmn7le6EskbK/sAeXdV9CDMn4lVJLlC4hjIad83uBR
	 bccH4aeLDhPzWGKV3m3EXuaN1JDswQ1fqrWwhH6QeGyVLKTWfml4kZx42R7AHaj3yJ
	 6JftLMPBkPqgk4NVhNB4wiD3E64ZSZP1+vixKs62DFNus92BR0V4HcTmWb/56CtkW+
	 hxT2bB9h/SWKYzHyAtfkytelHR861AYeMZ7uEwo308rXMZEs2YOPIuwbwih/ZwMyrQ
	 JviIxepsznZBtlzZPDMNa2uGnW6w2GxllR5wK3ROtx4TWsNYY/MOr+PlVRLAaE03w7
	 HG8P8pLZCdSmQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] spi: cadence-qspi: Fix style and improve readability
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-3-8ad505173e44@bootlin.com>
	(Miquel Raynal's message of "Fri, 19 Dec 2025 20:22:05 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-3-8ad505173e44@bootlin.com>
Date: Tue, 23 Dec 2025 15:28:13 +0100
Message-ID: <86pl85b7cy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025, Miquel Raynal (Schneider Electric) wrote:

> It took me several seconds to correctly understand this block. I
> understand the goal: showing that we are in the if, or in one of the two
> other cases. Improve the organization of the code to both improve
> readability and fix the style.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index e16a591e1f20..90387757fb6b 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -376,13 +376,13 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
>  			complete(&cqspi->transfer_complete);
>  			return IRQ_HANDLED;
>  		}
> +	} else {
> +		if (!cqspi->slow_sram)
> +			irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
> +		else
> +			irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
>  	}
>  
> -	else if (!cqspi->slow_sram)
> -		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
> -	else
> -		irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
> -

I suppose you can further simplify the if-else chain to:


	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
		irq_status = ddata->get_dma_status(cqspi);
	else if (cqspi->slow_sram)
		irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
	else
		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;

	if (irq_status)
		complete(&cqspi->transfer_complete);

	return IRQ_HANDLED;

Note that I swapped the latter two if statements to get rid of the
unnecessary negation of slow_sram. I suppose the overloading of
irq_status isn't the nicest thing, but I still find this easier to read.

>  	if (irq_status)
>  		complete(&cqspi->transfer_complete);

-- 
Regards,
Pratyush Yadav

