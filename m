Return-Path: <linux-spi+bounces-11465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1114C7CCD0
	for <lists+linux-spi@lfdr.de>; Sat, 22 Nov 2025 11:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F7BF34EF74
	for <lists+linux-spi@lfdr.de>; Sat, 22 Nov 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4632D063A;
	Sat, 22 Nov 2025 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="rNiz03ff"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397217E4;
	Sat, 22 Nov 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763808552; cv=none; b=NZYq7sRJF26mKoUtpVP00tWI96hwLuJtQzwprMmssWectW6AbYsB65QSeUQZyzH/qMDZwwdC/64jcqhdQ4QHzBKL3R21vXWmnYBLKIPZ/nWojPV3nmx4MoIAq858cuNOLFg9dvTEpEXV04fSsdboVQCDT8twR9nLhsqBnTzoZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763808552; c=relaxed/simple;
	bh=76YeoSJUJd0mRHIM3u2plyzKspu9qL9dq2Bi7t5DGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVLk2WY+O+0WDiHnEW//z3BlbhoKkfe+7S8XE+LdrqdH9OHCXopax6XXY5jIYHHna/7amiZxKf/HcJBmHimjRQDPGzsE50z0wsLvJ1XzBNpwU5TIn+JtiQFI0Jve8iU9XULvZU4ncCLFOUdrws2O9ehGCTaUCd8rMV/H7Zc1iwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=rNiz03ff; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vMlAm-00Em1b-5x; Sat, 22 Nov 2025 11:48:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=9YMGs+hF/ur3ghxcNlRi5n7uCXeUp235n6PE5uHGv3g=; b=rNiz03ffjuApfVsAl+M3cAm0UC
	bmgcdvqZ6npV8Gk1eJdqpAYyysau2Qknq2Clb+DEumvFY7HNjUBPDouwbtY12jqnV/MKmdX6pZ5Ys
	gqS4lOfMJOAEtSwNkaosr0QeH5C3RLZK6hxYvWavkQ+9R7nYuA9Mag2h23mkN6yAJ5KSzvSSQOns6
	Z3ZEAeVDsiywdlnu4LNLXsjEmhP6aCQIsmK4Xp8c1pJZuN+HEhUu+mGe5IjM+LSFOfKQi1wokLnCc
	RnCvmS98xBm9t8FvP0poRP3+CYRyb9GlNhJkLG1lz3jM5I+xvDSDXgRPicGXg2PS37qoz/NgrjBPA
	z9pi6kAw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vMlAl-00009E-7O; Sat, 22 Nov 2025 11:48:55 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vMlAd-003lX2-Jx; Sat, 22 Nov 2025 11:48:47 +0100
Date: Sat, 22 Nov 2025 10:48:42 +0000
From: david laight <david.laight@runbox.com>
To: carlos.song@nxp.com
Cc: Frank.Li@nxp.com, broonie@kernel.org, rongqianfeng@vivo.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <20251122104842.6a9cdbd1@pumpkin>
In-Reply-To: <20251117030355.1359081-1-carlos.song@nxp.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 11:03:55 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> 't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are
> u8. Using min_t with typeof(watermark) forces both values to be cast to
> u8, which truncates len when it exceeds 255. For example, len = 4096
> becomes 0 after casting, resulting in an incorrect watermark value.
> 
> Use a wider type in min_t to avoid truncation and ensure the correct
> minimum value is applied.

Also see my big patch that will detect this...

It usual that a simple min() will work fine.
(After the relaxation of the type comparison in min().)
If one of the values is a signed type (but positive) use umin(a,b).

This is a typical example of the type of the destination being used in min_t().
The real fix is to remove min_t() completely.

After all if the code had been:
	sl_lpspi->watermark = min(sl_lpspi->txfifosize,
		(typeof(fsl_lpspi->watermark))t->len);
a reviewer would have been likely to pick up the truncation.

Hiding the cast inside min_t() is a 'really bad idea' (tm).

I've found a pile of cases of:
	min_t(u8, value_32 / 2, 255)
in one driver (and the variable is pretty much called 'value_32'.

Looks like I've tried to compile this file yet.
'git diff' is currently outputting 8395 files for 358 files.

	David

> 
> Fixes: a750050349ea ("spi: spi-fsl-lpspi: use min_t() to improve code")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 8da66e101386..065456aba2ae 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -486,7 +486,13 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
>  	}
>  
> -	fsl_lpspi->watermark = min_t(typeof(fsl_lpspi->watermark),
> +	/*
> +	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
> +	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> +	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> +	 * for min_t() to avoid truncation.
> +	 */
> +	fsl_lpspi->watermark = min_t(unsigned int,
>  				     fsl_lpspi->txfifosize,
>  				     t->len);
>  


