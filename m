Return-Path: <linux-spi+bounces-11836-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F9FCB0EBA
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 20:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91ABF30D70AD
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B61303CAB;
	Tue,  9 Dec 2025 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="s3ALBAht"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A5302CAB
	for <linux-spi@vger.kernel.org>; Tue,  9 Dec 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765308091; cv=none; b=izCvtbBzgIfQwWj/OY+bsCR1iIkzG6hwBDXR57Cd+8GdBdHxNnBtYY+vYdIOoCcTBgon2wcn+rIYoxDV1NnysviNVhB0TwS2KZh3pY9WAfNUxFN8YAMD6vuQjKpwcp0kd/lMCaoKia8s/ibbDdYEDXSDcp/qt2S/PqX+dB5DkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765308091; c=relaxed/simple;
	bh=5PxtoFss8Nzm9288Z9hEPeVWP+FLrFTtFpy7tSkm3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlqDQhWjZBfTCrsEgFj0CiKkOwLFMNRj5Xxd+jQhZNsfXUQV5Dig2eebSRBJl3ebnHUiutC9hQOPoPnt9lYRCY6PfGl+hBA0ZRBH+gLXVIdaQIOz3Q9lHa4FRBK1WJBp1WlMc7zut6Z7lh8MS9dNle/vsD6LUPpvU3oMDekc1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=s3ALBAht; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vT3Gw-002MC9-P0; Tue, 09 Dec 2025 20:21:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=KIgDEPgavVd3e3Kc3rPYzJ+AjSxRgZwgEJtanFK5XJk=; b=s3ALBAhtJkZew+FX4h9LR40pQn
	RMNBu89Z4uuSVkaE+emcrWA1AXqQFI97JFcmMg7Ua0hw5l5eR1+If2eHZSLu2T1WxDq4AQrSK/SFy
	fYEUw+OZmElYjiDQiaCcf2AuLJK/Xs1WSbweo5fqZp+TVtYwm/OO7LlGmBOjH95M4+HaAfpGrCLTY
	2A5hKmCsfobtcDMgU6/Q2zK80Jx59GjPH/AEiDO8rfhviAgBxtPIFtCORtBgiwBWs6/lmHXt8qcU5
	USda4R4KA96AUJ66T/nTi0gjo9le5xaT4zycKiCeAlRH5lJzydTMsXNKIh5d/ENYSaEV961rwpOET
	s5WzoRCA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vT3Gw-00009A-6I; Tue, 09 Dec 2025 20:21:18 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vT3Gg-00D2BL-2G; Tue, 09 Dec 2025 20:21:02 +0100
Date: Tue, 9 Dec 2025 19:20:59 +0000
From: david laight <david.laight@runbox.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: Frank.Li@nxp.com, broonie@kernel.org, daniel.baluta@nxp.com,
 andriy.shevchenko@intel.com, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-ID: <20251209192059.43d97a72@pumpkin>
In-Reply-To: <20251209055634.3845602-1-carlos.song@nxp.com>
References: <20251209055634.3845602-1-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Dec 2025 13:56:34 +0800
Carlos Song <carlos.song@nxp.com> wrote:

> Convert min_t() to simple min() for better readability.
> 
> Fixes: 9f0c21bac5a8 ("spi: spi-fsl-lpspi: fix watermark truncation caused by type cast")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 065456aba2ae..01c674d466ed 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -489,12 +489,9 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  	/*
>  	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
>  	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> -	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> -	 * for min_t() to avoid truncation.
> +	 * it caused wrong watermark set. Simple min() helps to do type cast.
>  	 */

That comment doesn't make any sense and can probably be deleted.
I'm not sure its did before either.
Looks like it was added because the code was originally min_t(u8, ...),
even then I looks like text for the commit message not a code comment.

With the current version of min() no casts are required, the comparison
uses the normal integer promotion rules, so u8 => int => unsigned int.
min() allows the comparison because both variables are unsigned.

	David

> -	fsl_lpspi->watermark = min_t(unsigned int,
> -				     fsl_lpspi->txfifosize,
> -				     t->len);
> +	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
>  
>  	if (fsl_lpspi_can_dma(controller, spi, t))
>  		fsl_lpspi->usedma = true;


