Return-Path: <linux-spi+bounces-5801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A09D604F
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 15:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87670B232E6
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5917580C;
	Fri, 22 Nov 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="EOA1thI+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E287080E;
	Fri, 22 Nov 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285988; cv=none; b=Q9zTEFytYaEz1wtiKm8kbFpv0ed+a0grIDW7kkgCER0PNySkPdGKGilIgHMEJMW4MaEocU6SfL+9CGUmYsyxLfzRN8UskbFXMM6hR3xbcP66z6hgwVHZHlIYyZKjUi5/0QR8xJL+JtE+q0ytDhttJS5235DFg9QsA70+w0+ls/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285988; c=relaxed/simple;
	bh=0WjofnI+16r29wcpK2ZZb5qFASadH9xswLnIaUm7gbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTarFsJT1yFEnF31gWmwep+Aq8CmzD1iOXlJR8SLZw/itmjVieLnzIslPOcGdTcgW8zyNe0hRST1kvnigw9p2fzvEXSRp5VlFrnIm8I0dnbuQRMcJOI19I0wtOPFASSLOohW96ltIrPRlRaE0VzL4XCCXKjH8UD2u9qxXedu/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=EOA1thI+; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A82F1483473;
	Fri, 22 Nov 2024 15:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1732285556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol/8URh2FBPj8F5l8LvLrhCsPIrfEw/h/Cx/SKJh1iY=;
	b=EOA1thI+YywyhD5Gc55IqLdgcCKKbxGqZZj+jb0dI9j/OcuZiq3mB15Y6w7pUOyr/1FNlT
	RQ1iCXHuqzYZoiZW6TSoJnZ+Igdj78Gl/5H2hQegRM4SEeGJ2tqJaxbTsfJpS4XXrp5jHT
	AD9/e/GTTn9npk/iCtHCnIpbcOILTH4eqDb9a8+afFZCzEesWZdPw+VmweixTH2IpgXA6n
	jw363d4z1sm7z91MARmC1W4Vo+GQylJzS1XR99KHidV3Kp2M1E9+qCiubbqAW8IZtzjMgS
	DbHNs9xo8Ek9zqAbn2hdugLPdhV6TihSbADEaLuK/ReRUd17mYWwSiL9HHj/wQ==
Date: Fri, 22 Nov 2024 15:25:47 +0100
From: Alexander Dahl <ada@thorsis.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] spi: atmel-quadspi: Fix register name in verbose logging
 function
Message-ID: <20241122-zips-module-d0e6c6a1e69b@thorsis.com>
Mail-Followup-To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20241122141302.2599636-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122141302.2599636-1-csokas.bence@prolan.hu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Fri, Nov 22, 2024 at 03:13:02PM +0100 schrieb Csókás, Bence:
> `atmel_qspi_reg_name()` is used for pretty-printing register offsets
> for verbose logging of register accesses. However, due to a typo
> (likely a copy-paste error), QSPI_RD's offset prnts as "MR", the
> name of the previous register. Fix this typo.
> 
> Fixes: c528ecfbef04 ("spi: atmel-quadspi: Add verbose debug facilities to monitor register accesses")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>  drivers/spi/atmel-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 91108ddfaef2..316bce577081 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -183,7 +183,7 @@ static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
>  	case QSPI_MR:
>  		return "MR";
>  	case QSPI_RD:
> -		return "MR";
> +		return "RD";
>  	case QSPI_TD:
>  		return "TD";
>  	case QSPI_SR:

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex


