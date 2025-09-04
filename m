Return-Path: <linux-spi+bounces-9912-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BEB43F8B
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7926C3A37EA
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E571D27B6;
	Thu,  4 Sep 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkImFZJa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEEF15746F;
	Thu,  4 Sep 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997367; cv=none; b=PRU4cfPE0frpEDj2oEGqHpyAm+GGCe0RsGEWPk/5SNbLXJSbuqqNJeqwsZc8XD/j2DOR36jIBDKYBUQE79Crd/g5/Br6jgBGlaYm8c7vqX3rD25xslkdloJleSQIzfmYosbHxP6LzJlO16XwcjIR9YD4gl6FeQJK0nSd5tUon2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997367; c=relaxed/simple;
	bh=Azk0tAraQ0d7oriDkI/Tr3K7G06o7GOIuL+xO3iXZaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVnPFI76LD5i01ywPYcAysqzFnwHsbgM3P6aLdrkfm24wqW7feS4mBQilCe2IrFYYG2xgRayHIDS8PGn9hDYy6ApVg5LhJGWaoBHTJJVR5zJPItJ6OnHOKkpPfMwAO69lzllacAidBG5X9+5yjbagcPTjT1NRcZgIaKU4wZ/sQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkImFZJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76711C4CEF0;
	Thu,  4 Sep 2025 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997366;
	bh=Azk0tAraQ0d7oriDkI/Tr3K7G06o7GOIuL+xO3iXZaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OkImFZJaox2soFzr1ZRvsOHN+KC3niJHgl949nid0jenrECTdaADwqOvC7Cu3omFN
	 0foaw8dywDeIRumIfH/d1zVv/vofQRIavpd++5qtZ0Hay9ZlNuGmFdcBRJJr1cD5tz
	 AsBuV2rPwjMvJeDDxUmJGFxYHY4L2X6piUkX/gDujAbNj/LJhXPi7mRZxU1q9DQQGv
	 jshpb4gkGauQp2eoj4GumA5rDaFPUyqdWGrJ8b6PyVRUg5qj5rXUW1+prpI200Ttr6
	 hLbwi3PCa2+dFwPTi3t5XFQ1E0Ods5O89Gu6ymeAhgccNqvgOxA8e/THnrsG9gwv3L
	 HSH3Y9lqoURWQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <miquel.raynal@bootlin.com>,  <broonie@kernel.org>,  <vigneshr@ti.com>,
  <marex@denx.de>,  <computersforpeace@gmail.com>,
  <grmoore@opensource.altera.com>,  <theo.lebrun@bootlin.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <praneeth@ti.com>,  <p-mantena@ti.com>,  <a-dutta@ti.com>,
  <u-kumar1@ti.com>
Subject: Re: [PATCH 4/4] spi: cadence-quadspi: Use BIT() macros where possible
In-Reply-To: <20250904133130.3105736-5-s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
	<20250904133130.3105736-5-s-k6@ti.com>
Date: Thu, 04 Sep 2025 16:49:23 +0200
Message-ID: <mafs0bjnqtgr0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025, Santhosh Kumar K wrote:

> From: Vignesh Raghavendra <vigneshr@ti.com>
>
> Convert few open coded bit shifts to BIT() macro for better readability.
> No functional changes intended.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

I see there are total 7 hits for the pattern "1 <<". Why not convert
them all while you're at it?

> ---
>  drivers/spi/spi-cadence-quadspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index da3ec15abb3e..b18f095516f2 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -335,7 +335,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
>  {
>  	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>  
> -	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);
> +	return reg & BIT(CQSPI_REG_CONFIG_IDLE_LSB);
>  }
>  
>  static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
> @@ -571,7 +571,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
>  		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
>  		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
>  
> -	reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
> +	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
>  
>  	/* 0 means 1 byte. */
>  	reg |= (((n_rx - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
> @@ -1191,7 +1191,7 @@ static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>  		 * CS2 to 4b'1011
>  		 * CS3 to 4b'0111
>  		 */
> -		chip_select = 0xF & ~(1 << chip_select);
> +		chip_select = 0xF & ~BIT(chip_select);
>  	}
>  
>  	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK

-- 
Regards,
Pratyush Yadav

