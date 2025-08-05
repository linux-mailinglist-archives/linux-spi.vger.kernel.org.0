Return-Path: <linux-spi+bounces-9293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD3B1B77B
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA51892640
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CF224F6;
	Tue,  5 Aug 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pgUOwV3k"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29614747F;
	Tue,  5 Aug 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407829; cv=none; b=eMIDIXfRpr8dbRn0i77lhIl26pL2cz+20tsTHf5hnzpKviQeLUidmsY9L/kcewVzmp6q9XAaLzINd1UemmqjQaf3FKFC6B9FKJ5y+5zu2PaTYM+dDWOtSK2lKPavPMKVG2ztaaMJWFshaQP4cJKOuKZVJEJAwBV4yIyObU8aRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407829; c=relaxed/simple;
	bh=Kw7eMyWY5zW7INntokk4JGSpcNbA8RU/Mez2RPQZKBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kH1rGV6p+3ywMZ6cm1aqkfg9NzFG8YNlrCyYl+K+bZWrBWnm9UzJI/hamcs7MhFrUnkVthaZirSxnK2Ygf6V+ABssXSBno261nfaIf3cF41bkelHNKLdM6Gml6dQDgISgVfLgwGZCiHxRXz1pnte+ECRvg6bi8XLKOP3HSkvMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pgUOwV3k; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6530C43A0E;
	Tue,  5 Aug 2025 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754407819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SgEzWtcjDyKuxbmCqKV4hy0KTKvQ/vKyVEQYqrgBHyY=;
	b=pgUOwV3ki0x/OqoP8gQIxOi/isGPmWOV76dFtkEXV+TRXpoHunlxrIRxHGPgqisHsTEJx7
	xooSvd5EkjdxOhz2p8XGcG7qnHFeLP8ovBJ1RCP9hy92NnIxjxJq/05hbSGMvhdlCQDKHw
	LxvcYugBw+2nhYzfuBqmxU2mv5tOw6sOi43GzDeN9tan1gpYH7dcQDdTqqn97cdYsye68c
	Rb2hS2ElRdng1BobEiNXBwy0XLVVyP1RA/qUFM4Hp98k1tBQQEVJ/IwrrNZcssi+o3a/oZ
	LdxY/vWLvk4pDG3VBNBLafNe+BiVf4vdZna5sUWeMSyPVUkAgG8KC+WTsDMicg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Ray Liu
 <ray.liu@airoha.com>,  Mark Brown <broonie@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Martin Kurbanov
 <mmkurbanov@salutedevices.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers: mtd: spi-nand: try a regular dirmap if
 creating a dirmap for continuous reading fails
In-Reply-To: <20250804192132.1406387-3-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Mon, 4 Aug 2025 22:21:30 +0300")
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
	<20250804192132.1406387-3-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 05 Aug 2025 17:30:16 +0200
Message-ID: <87jz3hhjlj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfelkedvveffleeuhfeigfdvvefhgfejgffghfeiteegteeiudegfedtjeehkeefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhhikhhhrghilhdrkhhshhgvvhgvthhskhhihiesihhophhshihsrdgvuhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrhidrlhhiuhesrghirhhohhgrrdgtohhmpdhrtghpthhtohepsghrohhonhhivgesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhmkhhurhgsrghnohhvsehsrghluhhtvgguvghvihgtvghsrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On 04/08/2025 at 22:21:30 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> wrote:

> Continuous reading may result in multiple flash pages reading in one
> operation. Typically only one flash page has read/written (a little bit
> more than 2-4 Kb), but continuous reading requires the spi-controller
> to read up to 512 Kb in one operation without togling CS in beetween.
>
> Roughly speaking spi-controllers can be divided on 2 categories:
>  * spi-controllers without dirmap acceleration support
>  * spi-controllers with dirmap acceleration support
>
> Usually, first of them have no issues with large reading support.
> Second group often supports acceleration of single page only reading.
> Thus enabling of continuous reading can break flash reading.

I would be more conservative, I believe it is very implementation
dependent; many controller drivers do not even advertise a max size.

I agree though that controllers with dirmap support may express
limitations such as the mapped size which may lead to splitting
operations into smaller chunks, possibly leading to CS changes which
would break the continuous read mode on the chip's side.

> This patch tries to create dirmap for continuous reading first and
> fallback to regular reading if spi-controller refuses to create it.

no '-'                              ^

>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index b42c42ec58a4..ff6a1e2fcfdc 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1114,11 +1114,32 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
>  
>  	spinand->dirmaps[plane].wdesc = desc;
>  
> -	if (spinand->cont_read_possible)
> +	desc = NULL;
> +	if (spinand->cont_read_possible) {
> +		/*
> +		 * spi-controllers may return an error if info.length is
> +		 * too large
> +		 */
>  		info.length = nanddev_eraseblock_size(nand);
> -	info.op_tmpl = *spinand->op_templates.read_cache;
> -	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> -					  spinand->spimem, &info);
> +		info.op_tmpl = *spinand->op_templates.read_cache;
> +		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> +						  spinand->spimem, &info);
> +	}
> +
> +	if (IS_ERR_OR_NULL(desc)) {

Here if the problem is continuous reading, I expect an error and not a
NULL pointer.

> +		/*
> +		 * continuous reading is not supported by flash or

Not by the flash, here if we get an error, it is the spi controller
(still without '-' ;) ) that fails (please fix the comment).

> +		 * its spi-controller, try regular reading
> +		 */
> +		spinand->cont_read_possible = false;
> +
> +		info.length = nanddev_page_size(nand) +
> +			      nanddev_per_page_oobsize(nand);
> +		info.op_tmpl = *spinand->op_templates.read_cache;
> +		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> +						  spinand->spimem, &info);
> +	}
> +
>  	if (IS_ERR(desc))
>  		return PTR_ERR(desc);

