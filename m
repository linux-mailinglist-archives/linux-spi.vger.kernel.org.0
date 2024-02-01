Return-Path: <linux-spi+bounces-968-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F1845B22
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC6D1C2A329
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814746217D;
	Thu,  1 Feb 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDPXnM+0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41662179
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800697; cv=none; b=UJR9puDdw+y04GJBlKgUsd5Pqyh98SRTTpgdMHFuIR+TE6jD2CB71n7JY+1C9RJ1H+ryWisOqdgzM57pAGkl/H7WMW8iXmVOet9FISGneymUvW+RqcWVC6+nA3ONpWFl0RQVHVPrTBTni6QwAWHxuC3kLdwUgS19DGj6AgGWvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800697; c=relaxed/simple;
	bh=lmRhxmDHzvLoaCUgcDTCJ9u+TMkemcWwqNv6zznEFRo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mLjwn2TPUquy7lrQ7Oq6/ZFvot36gDk+W4mrk+U+NMegis33M8xmIz4qwIzdc5GdpU804ZcpfFZwhsUY9BdBm9U1w8oIR2dpEADW56mXJ9uvF2YE/RToXzRk27SqiRRjSzH4nTsdmWk4GKmsgLAL1MuQfG3SQdpJmYBavg/Sx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDPXnM+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E42C433C7;
	Thu,  1 Feb 2024 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706800696;
	bh=lmRhxmDHzvLoaCUgcDTCJ9u+TMkemcWwqNv6zznEFRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDPXnM+0stYxaKgDsbpESo+ULmedE82hmPD3dImT0zWmUXm1MhuWUbq0hvdRqibFw
	 /ZErnatBJoWBaf80pWPnUP2og+2/EIxy8vSxFLZZPSVH931ch578JXydBJFsQsA7gp
	 X4Bp2QbbS6aF32u8FC4c1baLoy/hqDynsBCSCqra7j8bm4WCq6D4QFZeSILKlTJq1q
	 UAgdSyeS/mNB/4ObtgVXTMhwn1yPCrA2UxLzjWOPuwrLV5bdG0x/Sx1QkKQIVZ508p
	 VvDrMtqCpmmnRK/gt0RnlvF2LAUxW/rzoIlcLvfPeam5Y8ogAjWWAQQ4gXypAgMLfu
	 dn9Z5ZaJTULfQ==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Feb 2024 16:18:12 +0100
From: Michael Walle <mwalle@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw,
 jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 2/9] spi: spi-mem: Allow specifying the byte order in
 Octal DTR mode
In-Reply-To: <20240201094353.33281-3-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-3-jaimeliao.tw@gmail.com>
Message-ID: <e256a1842aeb911083021a2e25baa370@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> From: JaimeLiao <jaimeliao@mxic.com.tw>

I think Tudor told you to keep his name/mail here.

> There are NOR flashes (Macronix) that swap the bytes on a 16-bit
> boundary when configured in Octal DTR mode. The byte order of
> 16-bit words is swapped when read or written in Octal Double
> Transfer Rate (DTR) mode compared to Single Transfer Rate (STR)
> modes. If one writes D0 D1 D2 D3 bytes using 1-1-1 mode, and uses
> 8D-8D-8D SPI mode for reading, it will read back D1 D0 D3 D2.
> Swapping the bytes may introduce some endianness problems. It can
> affect the boot sequence if the entire boot sequence is not handled
> in either 8D-8D-8D mode or 1-1-1 mode. So we must swap the bytes
> back to have the same byte order as in STR modes. Fortunately there
> are controllers that could swap the bytes back at runtime,
> addressing the flash's endiannesses requirements. Provide a way for
> the upper layers to specify the byte order in Octal DTR mode.
> 
> Merge Tudor's patch and add modifications for suiting newer version
> of Linux kernel.
> 
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> ---
>  drivers/spi/spi-mem.c       | 4 ++++
>  include/linux/spi/spi-mem.h | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 2dc8ceb85374..f8120f6b288f 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -172,6 +172,10 @@ bool spi_mem_default_supports_op(struct spi_mem 
> *mem,
>  		if (!spi_mem_controller_is_capable(ctlr, dtr))
>  			return false;
> 
> +		if (op->data.swap16 &&
> +		    !spi_mem_controller_is_capable(ctlr, swap16))

Since you need to redo this anyway (see below):
This can now be one line. Please keep in mind that the 80char limit
was extended to 100 chars some time ago. And I think this reads
better if its just one line.

> +			return false;
> +
>  		if (op->cmd.nbytes != 2)
>  			return false;
>  	} else {
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index f866d5c8ed32..8df44fbc9d99 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -89,6 +89,8 @@ enum spi_mem_data_dir {
>   * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or 
> not
>   * @data.buswidth: number of IO lanes used to send/receive the data
>   * @data.dtr: whether the data should be sent in DTR mode or not
> + * @data.swap16: whether the byte order of 16-bit words is swapped 
> when read
> + *		 or written in Octal DTR mode compared to STR mode.

I think this was ordered alphabetically in the former patch, but since
you've renamed it to swap16 now the order would change. I don't have
any preference here, just wanted to point that out. I just noticed
because the new member "swap16" in spi_controller_mem_caps was added in
the middle, which looked odd.

>   * @data.ecc: whether error correction is required or not
>   * @data.dir: direction of the transfer
>   * @data.nbytes: number of data bytes to send/receive. Can be zero if 
> the
> @@ -123,6 +125,7 @@ struct spi_mem_op {
>  	struct {
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 swap16 : 1;
>  		u8 ecc : 1;
>  		u8 __pad : 6;

Still wrong, please go over all the previous remarks, to be clear you 
have
to use "__pad : 5" here.

Otherwise looks good. So with the above fixed:

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

>  		enum spi_mem_data_dir dir;
> @@ -296,10 +299,13 @@ struct spi_controller_mem_ops {
>  /**
>   * struct spi_controller_mem_caps - SPI memory controller capabilities
>   * @dtr: Supports DTR operations
> + * @swap16: Supports swapping bytes on a 16 bit boundary when 
> configured in
> + *	    Octal DTR
>   * @ecc: Supports operations with error correction
>   */
>  struct spi_controller_mem_caps {
>  	bool dtr;
> +	bool swap16;
>  	bool ecc;
>  };

