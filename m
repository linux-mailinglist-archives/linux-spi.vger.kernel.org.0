Return-Path: <linux-spi+bounces-9292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131FB1B76F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A422626990
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00A2279DC5;
	Tue,  5 Aug 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ci72ZknI"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984C2777F9;
	Tue,  5 Aug 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407505; cv=none; b=iZ/PLV/15p5piSe39eehKlzPqnHDYBFXAz5HNnf3ENjy6awRmtDF8kq7mElVsW2AGLMw7fnk3RJfcMw12prqB2chjhrupJ0ZVVMckw6SRYw6hLm5vUs13QVwOq2EJeernshGyRlmKfosCZs28Eq60XkyD9PHnvDcrAZUGQ6FTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407505; c=relaxed/simple;
	bh=f7v+PL9KoQa/FLM1Pk8mXOovI9NWywm4Mp/BQByiACo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2/6ol3HqBJrC6UiPvX916XetsdIYeM4w6MgAmPLmR1FNmjgCw6/8OKg3TujH89Tn/bGq6NeJASUdoad9HhWH6M9zD0KTqN4SBZ/bUpGLg2tyB7INSt02CBZVYEgJqpuwPU/gNTnq2JUVEHslcOV0UUYBGmoBOM5Zmu9HaJtp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ci72ZknI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C703438DF;
	Tue,  5 Aug 2025 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754407495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bR0VckSoN9YaJX4wlOvB009sshe3mAwoA7HDDGUCpI=;
	b=Ci72ZknI4OXBeJS8vhqNr/IUn2BHA2NeY694ItlWgUdkWtdHx0y4S+KYkdzppkzW0cVwpK
	kBWY9e4b29rek3ZdCzZtlIDgwHk2MrV68RC64LfmiSIGG4/gUaU9VxnMia3Eex+wdt6Ajv
	7C/i0N3DLleoUJldMMTEZo2//+zf0J3VSHMdvICfy3CDa/kx4h04G8zaSwi0CFbqMOTcXe
	xRTIuc98AQ/k1S4UiVqS+29CX/A37APSl6fsKJPEE7IoIgDgpp6hFu3qmGCM0633s2TWU/
	bd2sGoZvfT09zx0Bl0XsrBSsKBQs783ttrhMwkeZDgxWkV4h0TrSJrs+GRR/zw==
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
Subject: Re: [PATCH 1/4] drivers: mtd: spi-nand: fix direct mapping creation
 sizes.
In-Reply-To: <20250804192132.1406387-2-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Mon, 4 Aug 2025 22:21:29 +0300")
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
	<20250804192132.1406387-2-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 05 Aug 2025 17:24:50 +0200
Message-ID: <87sei5hjul.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugfeuiefghffhiedvveejuefgueffvedugeevjeejgeetgfefgeffveetgefgleenucffohhmrghinhepohhppghtmhhplhdruggrthgrnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhhikhhhrghilhdrkhhshhgvvhgvthhskhhihiesihhophhshihsrdgvuhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrhidrlhhiuhesrghirhhoh
 hgrrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhmkhhurhgsrghnohhvsehsrghluhhtvgguvghvihgtvghsrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Mikhail,

Thanks a lot for this series!

On 04/08/2025 at 22:21:29 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> Continuous mode is only supported for non-raw data reads, thus raw I/O
> or non-raw writing requires only single flash page mapping.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index b0898990b2a5..b42c42ec58a4 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1103,9 +1103,6 @@ static int spinand_create_dirmap(struct spinand_dev=
ice *spinand,
>  	};
>  	struct spi_mem_dirmap_desc *desc;
>=20=20
> -	if (spinand->cont_read_possible)
> -		info.length =3D nanddev_eraseblock_size(nand);
> -
>  	/* The plane number is passed in MSB just above the column address */
>  	info.offset =3D plane << fls(nand->memorg.pagesize);
>=20=20
> @@ -1117,6 +1114,8 @@ static int spinand_create_dirmap(struct spinand_dev=
ice *spinand,
>=20=20
>  	spinand->dirmaps[plane].wdesc =3D desc;
>=20=20
> +	if (spinand->cont_read_possible)
> +		info.length =3D nanddev_eraseblock_size(nand);
>  	info.op_tmpl =3D *spinand->op_templates.read_cache;
>  	desc =3D devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>  					  spinand->spimem, &info);
> @@ -1132,6 +1131,9 @@ static int spinand_create_dirmap(struct spinand_dev=
ice *spinand,
>  		return 0;
>  	}
>=20=20
> +	// ECC reading/writing always happen in non-continuous mode

This comment does not sound helpful, at least I do not understand it?
(and the comment style should be /* */)

> +	info.length =3D nanddev_page_size(nand) + nanddev_per_page_oobsize(nand=
);
> +
>  	info.op_tmpl =3D *spinand->op_templates.update_cache;
>  	info.op_tmpl.data.ecc =3D true;
>  	desc =3D devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,

May I suggest to use two different dirmap infos? One with a large size
(for reads) and a page-sized one for other cases (including the fallback
you're introducing in PATCH 2).

Thanks,
Miqu=C3=A8l

