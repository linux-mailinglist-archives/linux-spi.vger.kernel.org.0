Return-Path: <linux-spi+bounces-971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AF845BBC
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A731F2BE1C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404DC5D46D;
	Thu,  1 Feb 2024 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdFw1h6L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9262145
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801979; cv=none; b=N53H0amK9CCFp7FrR/pNaFgRbRYGFXZuWTTzeT8V9cGluIEm92XxSioTv8TcKsoWpUHVNivbhDUP56nQIEEsvyGFa4HgZl/0BaYs/NcaPpmsopNVhGI0Z3N7984t8Pc02fCLCrO2103Q/wBp96n8zd9PxojPdpK66b1Zcu8EkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801979; c=relaxed/simple;
	bh=XoLv9C+DJd3qb4dNm0ZUOh/6NcnIi4gjK0PvdVFdsis=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Sm/Ev1HduEj6/MBHKgF/ftng9V/ufJpGJ7tED2GoTWZTD3s3skQ+l5qvy+v4qeUiZpMNrcqXlcaWA39/YC1ltJH8w8lLNjbnngbJHMfBBrb90ZoEJ1eJ8HC+HV14F4q6JaFeF1JQI8pAwIJOxDf3EIPwKcNkUkAn1XN0i5M3t3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdFw1h6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FA0C43390;
	Thu,  1 Feb 2024 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706801977;
	bh=XoLv9C+DJd3qb4dNm0ZUOh/6NcnIi4gjK0PvdVFdsis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdFw1h6LTHMX6kYgfafJTUxqISulNOh2JrJ9xFJHfibFXwGSqFZW9DAvfQpcfdBd5
	 u1m7GV+bHOhc0mLTKN7TNI1Yh3ehoLacnpYWnlDDZqYEzqxhUtvZ4vYiPJDmFwSYt5
	 oMJv+Pyss09TrKB/b5qW6E2CQbIK0GOAC5qQybxDsPcKEkz3qL1hr/RlCKRgLo6wOc
	 jbZ7J9bui2I44uJBeoS1SGy00dTsX2yfTHQSwkuyF00FTV8Bn9jtyQdXC2tk0RUFGG
	 nijpfFVtIA2QGSNxG7lP841wqKifw11WtVnGJPw+iIDZzJ15WNoje0QVXJsetvUanZ
	 Ed+sfWR5zB/rQ==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Feb 2024 16:39:32 +0100
From: Michael Walle <mwalle@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw,
 jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 5/9] spi: mxic: Add support for swapping byte
In-Reply-To: <20240201094353.33281-6-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-6-jaimeliao.tw@gmail.com>
Message-ID: <8e834cd19cf896d792a0338a3fb5465c@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> From: JaimeLiao <jaimeliao@mxic.com.tw>
> 
> Some SPI-NOR flash swap the bytes on a 16-bit boundary when
> configured in Octal DTR mode. It means data format D0 D1 D2 D3
> would be swapped to D1 D0 D3 D2. So that whether controller
> support swapping bytes should be checked before enable Octal
> DTR mode. Add swap byte support on a 16-bit boundary when
> configured in Octal DTR mode for Macronix xSPI host controller
> dirver.
> 
> According dtr_swab in operation to enable/disable Macronix
> xSPI host controller swap byte feature.
> 
> To make sure swap byte feature is working well, program data in
> 1S-1S-1S mode then read back and compare read data in 8D-8D-8D
> mode.
> 
> This feature have been validated on byte-swap flash and
> non-byte-swap flash.
> 
> Macronix xSPI host controller bit "HC_CFG_DATA_PASS" determine
> the byte swap feature disabled/enabled and swap byte feature is
> working on 8D-8D-8D mode only.
> 
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> ---
>  drivers/spi/spi-mxic.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> index 60c9f3048ac9..8ac302e48c9f 100644
> --- a/drivers/spi/spi-mxic.c
> +++ b/drivers/spi/spi-mxic.c
> @@ -294,7 +294,8 @@ static void mxic_spi_hw_init(struct mxic_spi *mxic)
>  	       mxic->regs + HC_CFG);
>  }
> 
> -static u32 mxic_spi_prep_hc_cfg(struct spi_device *spi, u32 flags)
> +static u32 mxic_spi_prep_hc_cfg(struct spi_device *spi, u32 flags,
> +				bool swap16)
>  {
>  	int nio = 1;
> 
> @@ -305,6 +306,11 @@ static u32 mxic_spi_prep_hc_cfg(struct spi_device 
> *spi, u32 flags)
>  	else if (spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
>  		nio = 2;
> 
> +	if (!swap16)
> +		flags |= HC_CFG_DATA_PASS;
> +	else
> +		flags &= ~HC_CFG_DATA_PASS;

Again, not my driver and I don't care too much, but you are changing
the behavior of this driver. If I had to guess, with this patch applied,
you'd read data (in octal mode) with the bytes swapped compared to 
kernel
without this patch.
And compared to the former version, you just made it harder to read
by using negated logic.

-michael

> +
>  	return flags | HC_CFG_NIO(nio) |
>  	       HC_CFG_TYPE(spi_get_chipselect(spi, 0), HC_CFG_TYPE_SPI_NOR) |
>  	       HC_CFG_SLV_ACT(spi_get_chipselect(spi, 0)) | 
> HC_CFG_IDLE_SIO_LVL(1);
> @@ -397,7 +403,8 @@ static ssize_t mxic_spi_mem_dirmap_read(struct 
> spi_mem_dirmap_desc *desc,
>  	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>  		return -EINVAL;
> 
> -	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0), mxic->regs + HC_CFG);
> +	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, 
> desc->info.op_tmpl.data.swap16),
> +	       mxic->regs + HC_CFG);
> 
>  	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
>  	       mxic->regs + LRD_CFG);
> @@ -441,7 +448,8 @@ static ssize_t mxic_spi_mem_dirmap_write(struct 
> spi_mem_dirmap_desc *desc,
>  	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>  		return -EINVAL;
> 
> -	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0), mxic->regs + HC_CFG);
> +	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, 
> desc->info.op_tmpl.data.swap16),
> +	       mxic->regs + HC_CFG);
> 
>  	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
>  	       mxic->regs + LWR_CFG);
> @@ -518,7 +526,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem 
> *mem,
>  	if (ret)
>  		return ret;
> 
> -	writel(mxic_spi_prep_hc_cfg(mem->spi, HC_CFG_MAN_CS_EN),
> +	writel(mxic_spi_prep_hc_cfg(mem->spi, HC_CFG_MAN_CS_EN, 
> op->data.swap16),
>  	       mxic->regs + HC_CFG);
> 
>  	writel(HC_EN_BIT, mxic->regs + HC_EN);
> @@ -572,6 +580,7 @@ static const struct spi_controller_mem_ops 
> mxic_spi_mem_ops = {
> 
>  static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
>  	.dtr = true,
> +	.swap16 = true,
>  	.ecc = true,
>  };

