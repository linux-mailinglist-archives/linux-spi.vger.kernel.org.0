Return-Path: <linux-spi+bounces-11845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D797CCB299A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 10:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E03305482E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9A26F46E;
	Wed, 10 Dec 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Tjo7BiKx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618542EA171
	for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360218; cv=none; b=of7UC0iLqmFb9Mp1oVSXDTl9C5A7EoLVKpwMLRh+tgmf9MczEP+pK8jjimvGJWzxcMFvv1Jr2lPx0TtB0lfFWCnaJAionvxtcrTvftITG43TK4mmyVg458vFZQ2zEqmTVz3pXkfR9q0XIX0lzpUnAXK+7qLfdqRS02czIAGsK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360218; c=relaxed/simple;
	bh=DAhy7+18z0hRT14nNWvE+nXvzMFcCHOonmxVfSqSvM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMkuCDx6TyyRry/9lUzggBJfjciSh9HmvIJtd6AaVAdE+uEwSwKO4KwmDOsWJ4NXnpjE3sE0YaOTdCnhoGi5Z9bNS/G3xpZgv87wScSmNPTVo5AxvmNczqT4SIBYyUZkULGaILhauXWSp3Hzg+gBv80uMK4BRCkhSI5PrEegJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Tjo7BiKx; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vTGpX-007ap0-Us; Wed, 10 Dec 2025 10:49:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=+1orBKHm47l/ZHuPL7ncTrPFFa1u/p2z7XukvtGBhl0=; b=Tjo7BiKxGZCEiUjnqWxox5kbrg
	SPwaJqZabNxajZI7n4UTHazIaVKRL8qy10tw0/YB0gcioB2JGh96U7hQmjU1USmNREORuqlbdNGKV
	5Qav3PB+z3oLv/ni8SfCTsJV0y2qfIhQH1qSi2RAUVcDlM6cserr8Itk6oXh1DlaRJCOOp6bCNnzY
	PHrttR7/ht/UUfABIvQf4z4M7lDbRPpAyJ8YZfPmLC+2aBOmT7FjDOPy2+bj3zDIA6pQIRLC2aOb3
	QPYOVsEiC4iIEGU07nYhziwZ2M20ykmlqbwn/zW2zrddUxQt3NzlN5LQOPuLtA6vY7jdrH6UgG8M2
	Ec+bz2IQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vTGpX-00074w-3y; Wed, 10 Dec 2025 10:49:55 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vTGpQ-00Eiw5-OT; Wed, 10 Dec 2025 10:49:48 +0100
Date: Wed, 10 Dec 2025 09:49:46 +0000
From: david laight <david.laight@runbox.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: Frank.Li@nxp.com, broonie@kernel.org, daniel.baluta@nxp.com,
 andriy.shevchenko@intel.com, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-ID: <20251210094946.6823aef2@pumpkin>
In-Reply-To: <20251210074115.3883180-1-carlos.song@nxp.com>
References: <20251210074115.3883180-1-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 15:41:15 +0800
Carlos Song <carlos.song@nxp.com> wrote:

> Current min() has supported comparison by normal integer promotion rules,
> so explicit type casts or min_t() are not needed.
> 
> Fixes: 9f0c21bac5a8 ("spi: spi-fsl-lpspi: fix watermark truncation caused by type cast")

I don't think it needs a 'Fixes' tag since it is just a cleanup, but apart from that:
Reviewed-by: David Laight <david.laight.linux@gmail.com>

> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change since v1:
> * remove unused comment according to David's comment
> * improve commit log according to Frank's comment
> ---
>  drivers/spi/spi-fsl-lpspi.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 065456aba2ae..8f45ead23836 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -486,15 +486,7 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
>  	}
>  
> -	/*
> -	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
> -	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> -	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> -	 * for min_t() to avoid truncation.
> -	 */
> -	fsl_lpspi->watermark = min_t(unsigned int,
> -				     fsl_lpspi->txfifosize,
> -				     t->len);
> +	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
>  
>  	if (fsl_lpspi_can_dma(controller, spi, t))
>  		fsl_lpspi->usedma = true;


