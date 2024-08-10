Return-Path: <linux-spi+bounces-4161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A894DEC1
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBCF1C20B74
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25713D50C;
	Sat, 10 Aug 2024 21:22:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416931DDC9;
	Sat, 10 Aug 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723324951; cv=none; b=lJ0DpR/cl0HZueZ0c2pBpFmsPL3AJvPP44fcqL2/VDkRLLT0a65j75p/3yZF+Nr8hJcjKK6SkzYGXbXV1rG/blQ409Kxt0QdraYzwA0es48UaeyrPwZP3qNKCoRHUYUfsjVXUhWr7gZzuNeXk0NFwzhUZNcxjPA04bhA+v6fiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723324951; c=relaxed/simple;
	bh=tfQYVG6dfjpn07Hx4X+zaIZBAEXbkgxDa+0avmdEAkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBQFSf5mp7e84df+SCBB4hMrHXhmef5TZ9m/FUWcuq56Ig1tEp2XLh7aeaNt6vjrVEspHb2eZBSilvKjPs25QcwuzvGsrtlTQpQJUCcqidljAdgE1Hcn9BTHMF8ygWQF6Ts8cmlGfm5vXoju28iK5oRc5NOmONUuDvWPH753uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sctXf-0007aI-0P; Sat, 10 Aug 2024 23:22:27 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: broonie@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/3] spi: spidev: Add an entry for elgin,jg10309-01
Date: Sat, 10 Aug 2024 23:22:25 +0200
Message-ID: <1893982.AB8Y2P6tQ1@diego>
In-Reply-To: <20240719111210.1287783-2-festevam@gmail.com>
References:
 <20240719111210.1287783-1-festevam@gmail.com>
 <20240719111210.1287783-2-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 19. Juli 2024, 13:12:09 CEST schrieb Fabio Estevam:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add the "elgin,jg10309-01" compatible string.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> Changes since v1:
> - Use a more specific compatible string. (Conor)
> 
>  drivers/spi/spidev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 05e6d007f9a7..316ed3664cb2 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -730,6 +730,7 @@ static int spidev_of_check(struct device *dev)
>  static const struct of_device_id spidev_dt_ids[] = {
>  	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
>  	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
> +	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
>  	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
>  	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
>  	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
> 





