Return-Path: <linux-spi+bounces-969-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A0845B91
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614C41C2A7C2
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22462141;
	Thu,  1 Feb 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmwztpI2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DEC12FF7A
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801329; cv=none; b=MxdEAZBX3nciiuSGRWT5RwgWsAUeJfs6OloB2HGID6rlrDUxo3+kxNvecXMeyAg64fFPmqIig1hMscvc4y72j9BXvIFXOHgAFa43NESEEFW/7C6gAAMNnRAMvN/tTa1nX50J/Ka8NDVuZxUsxtRwYpzn1VxetTq65j2raM+7Me8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801329; c=relaxed/simple;
	bh=5CkmtnYRZDwQa3AKcyQfp1dgmpBdKEsPqGGm8IacKsE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sN03aa5cvL09nVvDZjVIhvh/Ev2n3IwNsKbneQHnov+0emGtx9A1tPhYtm08AmO+rO9zKuYvZO8mxR+4MMiN752lEJKX/mLD1qXcr9q3z8mBW6vwcc9GBOJ+Q9JJq5by8QjcxQqPcM0QP5/rO5tj6hydJvi7XE1fP6dZQsyOuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmwztpI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804BDC433F1;
	Thu,  1 Feb 2024 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706801328;
	bh=5CkmtnYRZDwQa3AKcyQfp1dgmpBdKEsPqGGm8IacKsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MmwztpI2HyosWCOXTmGULnEUeBGD9b3mPGpgzTKZXtDcEt23A/c2F2rkbuDS2ThqV
	 q8VBH9/ktQUr4/y2ecSLpFSgxIFtQQ36wka8Il1FRFDXjTAi07xxZv6KgQx5CL2Bq8
	 Nzyz8WR5UZMuv/eqrrM06UtWCEvDyf1/7jbRwiyFwq/HPqRjGbXDzMLZH15b2zOGDB
	 gJb6aEf0gWHjLvefdU2VYozsYMdPA+G0oGgPgi6ffsIRy80qGBcdi3ZB8pEATr/Urx
	 gAbTlM5v8RCvriaaPmkMkMO5+TDrBaTfI5JuMh1k/h3LzSpgqI9G3JK/vvRS4fMCHS
	 EcTREXd3SO56w==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Feb 2024 16:28:44 +0100
From: Michael Walle <mwalle@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw,
 jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 3/9] mtd: spi-nor: core: Allow specifying the byte
 order in Octal DTR mode
In-Reply-To: <20240201094353.33281-4-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-4-jaimeliao.tw@gmail.com>
Message-ID: <1b726357f67c1e1a680326b821875031@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> From: JaimeLiao <jaimeliao@mxic.com.tw>

Same remark as for patch 2/9.

> Macronix swaps bytes on a 16-bit boundary when configured in Octal DTR.
> The byte order of 16-bit words is swapped when read or written in 
> 8D-8D-8D
> mode compared to STR modes. Allow operations to specify the byte order 
> in
> DTR mode, so that controllers can swap the bytes back at run-time to
> address the flash's endianness requirements, if they are capable. If 
> the
> controllers are not capable of swapping the bytes, the protocol is
> downgrade via spi_nor_spimem_adjust_hwcaps(). When available, the 
> swapping
> of the bytes is always done regardless if it's a data or register 
> access,
> so that we comply with the JESD216 requirements: "Byte order of 16-bit
> words is swapped when read in 8D-8D-8D mode compared to 1-1-1".
> 
> Merge Tudor's patch and add modifications for suiting newer version
> of Linux kernel.
> 
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/core.c | 5 +++++
>  drivers/mtd/spi-nor/core.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4129764fad8c..0076007e1cde 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -113,6 +113,11 @@ void spi_nor_spimem_setup_op(const struct spi_nor 
> *nor,
>  		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
>  		op->cmd.nbytes = 2;
>  	}
> +
> +	/* SWAP16 is only applicable when Octal DTR mode */
> +	if (nor->read_proto == SNOR_PROTO_8_8_8_DTR)

Why is it read_proto now? For all the former patches, the local
proto variable was used.

> +		if (nor->flags & SNOR_F_SWAP16)

Please fold this into the former condition.
if (proto == SNOR_PROTO_8_8_8_DTR && nor->flags & SNOR_F_SWAP16)
    op->data.swap16 = true;

-michael

> +			op->data.swap16 = true;
>  }
> 
>  /**
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index d36c0e072954..3c5190ac0a79 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -140,6 +140,7 @@ enum spi_nor_option_flags {
>  	SNOR_F_RWW		= BIT(14),
>  	SNOR_F_ECC		= BIT(15),
>  	SNOR_F_NO_WP		= BIT(16),
> +	SNOR_F_SWAP16		= BIT(17),
>  };
> 
>  struct spi_nor_read_command {

