Return-Path: <linux-spi+bounces-5073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B167798B444
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 08:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D371C23000
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A223A1BBBC4;
	Tue,  1 Oct 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="WBQKmLKl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C481BBBC3;
	Tue,  1 Oct 2024 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763973; cv=none; b=pADG5vuEktoJVdo0qm17rn20mZGj3y8pIwFFEEq7640D8ah/NGjiMPpPpNIxi/KlD4Frq39G5ynVKDoqQZ/DYEvrrmpyUekHdfsgWcpE9/Up0se/HZ+5KtkXBkKOMdZKn+xz4KHCCPMnibiC6VJYgbb+k/dzb2ziL1qxglSvJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763973; c=relaxed/simple;
	bh=E0ev0h51rFlOdHoMRDQSbGFY+v+92QG76SGxE5gpRMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgZnpbgQiuYzHcg/5iiO8RrUVO+kUIcYS8gK8NK5EDKfOLWNMK5abRX1iHIXU+84fsYIiE1C4DfaPBI/3ep9MS99FMAzrF5RWLkAdEP7/FyZ9Ov6O27cSxvjxdQJ4l/4/l5s/Lozam6um0HG/wzntWHUg6R5jBnqIvoni857HcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=WBQKmLKl; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D32D31486A58;
	Tue,  1 Oct 2024 08:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1727763962; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5Ci1UjobOhKebkG36SiLXY8QIHuytMlojuv090vfWSk=;
	b=WBQKmLKlNFmhanFpU/bGcYOOg281C/6MVA5DobI5q7IUY1XrlZZGXMwbyE1aYfQ78LIo/+
	pmm0DkK51uO4UDDO9Y56Vvob83ofTQBK1ccYd6avtBMc6MOYPQxwKx+6jxLot69o3HYOK5
	iGn9dMej0blZPkyAxb2gTeRHxlvq3s7RrsJzlzw8I9jIXLKR15KOhThD6vveRgdS60kHRl
	FC79Gt50SJUxPjrtSebflC3cSy5LagEMtLFENDfehWtQF9GZf9qjv97BqgWOk1EZFGc40K
	MFKDzQVXhU72h7KsrDT8kaskJQiVgU4joXQl8tCXs5R0GKJqufHmlufoQ6SxKQ==
Date: Tue, 1 Oct 2024 08:25:55 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] spi: atmel-quadspi: Fix wrong register value written to
 MR
Message-ID: <20241001-portly-showpiece-7cbfa71b6480@thorsis.com>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
References: <20240926090356.105789-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926090356.105789-1-ada@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Thu, Sep 26, 2024 at 11:03:56AM +0200 schrieb Alexander Dahl:
> aq->mr should go to MR, nothing else.
> 
> Fixes: 329ca3eed4a9 ("spi: atmel-quadspi: Avoid overwriting delay register settings")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Link: https://lore.kernel.org/linux-spi/20240926-macarena-wincing-7c4995487a29@thorsis.com/T/#u

I've seen the faulty patch 329ca3eed4a9 ("spi: atmel-quadspi: Avoid
overwriting delay register settings") gone not only to master where it
should be fixed before v6.12, but also to stable queue for 6.11,
6.10, and 6.6 so this fixup should go there too, right?

Greets
Alex

> ---
> 
> Notes:
>     based on today's master
> 
>  drivers/spi/atmel-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 4f288f07e38f..95cdfc28361e 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -377,7 +377,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
>  	 */
>  	if (!(aq->mr & QSPI_MR_SMM)) {
>  		aq->mr |= QSPI_MR_SMM;
> -		atmel_qspi_write(aq->scr, aq, QSPI_MR);
> +		atmel_qspi_write(aq->mr, aq, QSPI_MR);
>  	}
>  
>  	/* Clear pending interrupts */
> 
> base-commit: 11a299a7933e03c83818b431e6a1c53ad387423d
> -- 
> 2.39.5
> 
> 

