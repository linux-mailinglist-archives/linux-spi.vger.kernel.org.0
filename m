Return-Path: <linux-spi+bounces-9294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2202B1B7AA
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2951818A6FC3
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D1272E53;
	Tue,  5 Aug 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OJMRPIB0"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F702242D9D;
	Tue,  5 Aug 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408199; cv=none; b=qwoAq/TaLhaeSodiVWWlfZS1Wb2mGRjMkSUeSoBfqG2OXFgtKWPsbU+p+zLnwqjnu9uhrLQeFfipVedNE+AfCYe4GmJDbhN8BhJRWXOj1JtMD6MqFM4KmmhlkhHJFYCgcybEyQA99Gk4SCiYEaBNm6eKb/9g0vttzAUKH2QhEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408199; c=relaxed/simple;
	bh=N0cA2ipKRu37B7BgJXFmMxgzozOcatcMu9xWLMEdF28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=inb1USlyK2vhbKdk6jvVkOn7LbYEK12jH4+Mckm4frPwUc3SrgWAD1wTvbhGiCajDehAPMshy03SZOAfEa62knXLtAEcHBSyvZFyp53s42mHdcH+A6gYm/1ByK+8joNkZs+j5P6qqWKS+hqGitpopdhVmm9HaSUYIM4wElRKspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OJMRPIB0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0464043913;
	Tue,  5 Aug 2025 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754408189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZcPDMkJ+pPommrt/oJ4Duet/sc/kc8Z/rAj63Jyev8=;
	b=OJMRPIB0vCWnZyP1Ih+XiHQtPyCjsi7tq/VM5VkDiIGRKSWcw9OotSyUJDJTup6V/6SpTb
	9y98FQEJVax+Fl7XnbhVvcIAEuRmEjcbevuVs7G/YHtiYwPDG5CoG6XYrZsJ+BQnFzbPSi
	mhtVYo1anHTJGqw5jq+1FbF9hRnfyEBT95GZwpSGFNpi8gG6ANtbMwqE7JG07mvSwNTOlk
	RkAgzuXlOZb8IbbfrT2y99gMWSo335fpsSptE5JffHvc40MvwqCsCUTVoV9udOdMrO+J27
	ycc8Aw5oja8WOpQo0VDR1+3Y0f/AcUH+B/+YrSaFC4wceYpNSpQ1cBVjI2QITQ==
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
Subject: Re: [PATCH 3/4] drivers: mtd: spi-nand: repeat reading in regular
 mode if continuous reading fails
In-Reply-To: <20250804192132.1406387-4-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Mon, 4 Aug 2025 22:21:31 +0300")
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
	<20250804192132.1406387-4-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 05 Aug 2025 17:36:27 +0200
Message-ID: <875xf1hjb8.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehmihhkhhgrihhlrdhkshhhvghvvghtshhkihihsehiohhpshihshdrvghupdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrgihrdhlihhusegrihhrohhhrgdrtghomhdprhgtphhtthhopegsrhhoohhnihgvs
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehmmhhkuhhrsggrnhhovhesshgrlhhuthgvuggvvhhitggvshdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 04/08/2025 at 22:21:31 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> Continuous reading may result in multiple flash pages reading in one
> operation. Unfortunately, not all spi-nand controllers support such
> large reading. They will read less data. Unfortunately, the operation
> can't be continued.
>
> In this case:
>  * disable continuous reading on this (not good enough) spi controller
>  * repeat reading in regular mode.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index ff6a1e2fcfdc..88e4c00cccc4 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -431,7 +431,7 @@ static int spinand_read_from_cache_op(struct spinand_=
device *spinand,
>  		 * Toggling the CS during a continuous read is forbidden.
>  		 */
>  		if (nbytes && req->continuous)
> -			return -EIO;
> +			return -E2BIG;
>  	}
>=20=20
>  	if (req->datalen)
> @@ -893,15 +893,26 @@ static int spinand_mtd_read(struct mtd_info *mtd, l=
off_t from,
>  	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
>  	struct mtd_ecc_stats old_stats;
>  	unsigned int max_bitflips =3D 0;
> -	int ret;
> +	int ret =3D -E2BIG;
>=20=20
>  	mutex_lock(&spinand->lock);
>=20=20
>  	old_stats =3D mtd->ecc_stats;
>=20=20
> -	if (spinand_use_cont_read(mtd, from, ops))
> +	if (spinand_use_cont_read(mtd, from, ops)) {
>  		ret =3D spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips=
);
> -	else
> +		if (ret =3D=3D -E2BIG) {
> +			/*
> +			 * Some spi controllers may not support reading up to
> +			 * erase block size. They will read less data than
> +			 * expected. If this happen disable continuous mode

                                             happens,

> +			 * and repeat reading in normal mode.
> +			 */
> +			spinand->cont_read_possible =3D false;
> +		}
> +	}
> +
> +	if (ret =3D=3D -E2BIG)

While I agree with the overall logic, I find pretty unreadable to
perform the regular read upon a return value that is an error code set
in the init sequence. Can you please propose an alternate implementation?

>  		ret =3D spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
>=20=20
>  	if (ops->stats) {

Thanks!
Miqu=C3=A8l

