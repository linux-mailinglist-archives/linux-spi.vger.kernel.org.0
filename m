Return-Path: <linux-spi+bounces-9652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD69B3316E
	for <lists+linux-spi@lfdr.de>; Sun, 24 Aug 2025 18:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B503E1717F0
	for <lists+linux-spi@lfdr.de>; Sun, 24 Aug 2025 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71738275AED;
	Sun, 24 Aug 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tTpqh9yA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2862D6E68;
	Sun, 24 Aug 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756052792; cv=none; b=plBwy//BwgPQ1lqWRrgjvQf1oZNSfvP0md2Mb9Pjj2JTXaEmKg3RqkraUKx2h/8lDbwpxgdRRTg/KigKpSNHJsrqvMlam0NmbCP0hS5iHWBtK/UC4MmytoiWdX2AD42sZbTGX40RLmOLD7K3vfspk27JgyLctCdFswEhc8VSDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756052792; c=relaxed/simple;
	bh=61sJ4t1YC46A9aX1qpG0FOBFZ5RPRfBho01NVov3yTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Do2W/9H5MmGnccKGWTM0g+uTqgvFjLziYtM24Lrg37ZTi3sjLGE1BQgzOdl2ke31gVRnGvmIqT+Vfti6Ap6OQsXmSUBh5Uto1rxu4hzcqylZTI9K3rs105/6+IlLEDoaBollSoG0yMU32Jcjk6JcXLGTrVBau0TmuC1o70ZPd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tTpqh9yA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 800BE1A0C63;
	Sun, 24 Aug 2025 16:26:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 536E2605F1;
	Sun, 24 Aug 2025 16:26:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEE511C228BA3;
	Sun, 24 Aug 2025 18:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756052786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EN2uw03uQCiUxP4yNZYaMtufKIXdaP5nDTBBVTj3pDM=;
	b=tTpqh9yAUftbHe5jJ5v7pD6DihH4ClLMkGFI3HnLY1dUZrsP65Et6en3YfPH/dwVXbWqgV
	+Qe/N6TTN9SOPyfIr5ewMTfKD6pTqNifDUR5N6ja/4heN/0bKdK9U5Wa+fIRsWH9Q48b6e
	+7cf9N2mHxBesIDY9k+3oltMXYCVcKZaYv6i1FAwJ6voWtaqcR+2OhHxCASw3P/d2WF/og
	ZP9T813d3PUFl28E8njmgmTry3epu+3UNe2EnuoqyI4MBBAQUHTECBWuAvNtaaJbqXtaO/
	kDqvpjX8UuY4RWMyzeaqBp/YsKFf19vPHZVCsH8I8SAXcxDTpYe/i6NFyoDRMw==
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
Subject: Re: [PATCH RESEND v2 2/4] mtd: spinand: try a regular dirmap if
 creating a dirmap for continuous reading fails
In-Reply-To: <20250814065423.3980305-3-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Thu, 14 Aug 2025 09:54:21 +0300")
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
	<20250814065423.3980305-3-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 18:26:16 +0200
Message-ID: <87jz2sit3r.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/08/2025 at 09:54:21 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> Continuous reading may result in multiple flash pages reading in one
> operation. Typically only one flash page has read/written (a little bit
> more than 2-4 Kb), but continuous reading requires the spi controller
> to read up to 512 Kb in one operation without toggling CS in beetween.
>
> Roughly speaking spi controllers can be divided on 2 categories:
>  * spi controllers without dirmap acceleration support
>  * spi controllers with dirmap acceleration support
>
> Usually, first of them have no issues with large reading support.
> Second group often supports acceleration of single page only reading.
> Thus enabling of continuous reading can break flash reading.
>
> This patch tries to create dirmap for continuous reading first and
> fallback to regular reading if spi controller refuses to create it.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 09dd6e40e308..0f8636047365 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1093,6 +1093,39 @@ static int spinand_mtd_block_isreserved(struct mtd=
_info *mtd, loff_t offs)
>  	return ret;
>  }
>=20=20
> +static struct spi_mem_dirmap_desc *spinand_create_rdesc_helper(

Can we drop _helper from the name? Just spinand_create_rdesc() sounds
as useful.

> +					struct spinand_device *spinand,
> +					struct spi_mem_dirmap_info *info)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +	struct spi_mem_dirmap_desc *desc =3D NULL;
> +

Looks good otherwise.

Thanks,
Miqu=C3=A8l

