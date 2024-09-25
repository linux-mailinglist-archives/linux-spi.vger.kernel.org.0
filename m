Return-Path: <linux-spi+bounces-4956-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58C9856C4
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11982288008
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5761537B9;
	Wed, 25 Sep 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oK2KliJ3"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39313B284;
	Wed, 25 Sep 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258273; cv=none; b=hgje8Ex9PuNIdgKiFxyAQUsbvzsBeOxuQUw//JrsWHHFqOR7nW0+GFEAb4efY7+GJmnCChtkSdmfYE6o07TbG29Jpwr9F6Ry0Ql8jI8QoOUMgv5Haa+lKREdEenkQ+KSp891UNmGcqlNaoyQjno88qK8RuWJaGoD8cWFLgpgsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258273; c=relaxed/simple;
	bh=Dnr5JTATSDJ1XWIiCjvpCuE72azmyNZ7y6FEaY78JN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ib+X6rVahbcgO06EtVDkOk8zz+qjF0aEWLKNqMoypwlJDd3qHvej6G5fG+E9IIxtUMMnNRtSUIA5vg+eaDC7X+G9z49uiQy7htb2oCF4SyUQFu7R/MccgfmfhhyapUgQISQPrSUhb3QrPg0OvLmnzFxaqvlyAS34A1Jt3YEgmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oK2KliJ3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AAABE0004;
	Wed, 25 Sep 2024 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727258268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty4/y3Jxu7Plk8pWyWkojbI6PSWYseKcvwhL4r+Fr70=;
	b=oK2KliJ3sE2eBBPA18DPlVQIcj0IxjMMqXloudsKnqCy9lustdss2TdcROKN1CRJw2+YvT
	ZSIiwcHjHTR6xFc6Yum/4yxEi9a2cJ1X16WcU3P+FpncjQq9xFqHCwwnY5GlE4ZFvhBmqW
	lzmnULfYUcJfzV3gCwsw32zofU9oOsof1tn0Ncm1P5dKuMImziaQFemm9IWpqTh6QEfA6f
	BmgddcU9i1W9ke1JlxtEcQ6VIK2KMT0fKO0HZSiWDVqrJLgFgaWYRgm1g0h7h6TmVTv49Q
	admQ2l39BAcnLZENYsqnERVLSacWZHSwHh6jT3dBMBybE6xeuUELODycTqKing==
Date: Wed, 25 Sep 2024 11:57:46 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Alvin Zhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, richard@nod.at, vigneshr@ti.com,
 broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw, AlvinZhou
 <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>, Bough Chen
 <haibo.chen@nxp.com>
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal
 flash
Message-ID: <20240925115746.22cdd8fe@xps-13>
In-Reply-To: <79406f2b-8411-4059-b959-9e543944fb9c@linaro.org>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
	<20240718034614.484018-7-alvinzhou.tw@gmail.com>
	<97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
	<CAPhrvRR3U9=0DuG_FQ81ZJq+RLe6Bn9YO831Mx2n3NkeV3MCdA@mail.gmail.com>
	<368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org>
	<618e4514-791b-4a73-a1ba-45170a21e453@linaro.org>
	<79406f2b-8411-4059-b959-9e543944fb9c@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Alvin,

tudor.ambarus@linaro.org wrote on Tue, 24 Sep 2024 08:17:26 +0100:

> On 9/24/24 7:36 AM, Tudor Ambarus wrote:
> >=20
> >=20
> > On 9/24/24 7:26 AM, Tudor Ambarus wrote: =20
> >>
> >>
> >> On 9/24/24 4:25 AM, Alvin Zhou wrote: =20
> >>> Hi Tudor,
> >>>
> >>> Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B49=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:54=E5=AF=AB=E9=81=
=93=EF=BC=9A =20
> >>>>
> >>>> Hi, Alvin,
> >>>>
> >>>> I quickly skimmed over the previous 5 patches and they are looking f=
ine.
> >>>>
> >>>> I don't get this patch however.
> >>>>
> >>>> On 7/18/24 4:46 AM, AlvinZhou wrote: =20
> >>>>> From: AlvinZhou <alvinzhou@mxic.com.tw>
> >>>>>
> >>>>> Adding Manufacture ID 0xC2 in last of ID table because of
> >>>>> Octal Flash need manufacturer fixup for enabling/disabling
> >>>>> Octal DTR mode.
> >>>>>
> >>>>> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> >>>>> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> >>>>> ---
> >>>>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
> >>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/m=
acronix.c
> >>>>> index f039819a5252..1a8ccebdfe0e 100644
> >>>>> --- a/drivers/mtd/spi-nor/macronix.c
> >>>>> +++ b/drivers/mtd/spi-nor/macronix.c
> >>>>> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_par=
ts[] =3D {
> >>>>>               .name =3D "mx25l3255e",
> >>>>>               .size =3D SZ_4M,
> >>>>>               .no_sfdp_flags =3D SECT_4K,
> >>>>> -     }
> >>>>> +     },
> >>>>> +     /* Need the manufacturer fixups, Keep this last */
> >>>>> +     { .id =3D SNOR_ID(0xc2) }
> >>>>>  };
> >>>>> =20
> >>>>
> >>>> Could you please elaborate why you need just the manufacturer id her=
e? I
> >>>> would have expected to see a specific flash entry instead. =20
> >>>
> >>> Grateful to Michael for the valuable suggestion. This addition of the
> >>> Macronix manufacturer ID enables the fixup functions such as
> >>> macronix_nor_set_octal_dtr to be executed without the need to
> >>> create separate ID entries for each Octal DTR NOR Flash in the
> >>> flash_info.
> >>> =20
> >>
> >> Ah, nice. Okay then. I'm going to review the rest of the patches. They
> >> look promising ;). =20
> >=20
> > ah, but then you'll always have a matched ID, so you break the generic
> > flash probing for macronix. Is that correct? =20
>=20
> Answering myself: it's fine. Generic flash probe just fills a name,
> which we don't really care about.

I was also a bit surprised by the diff, would you mind filling a more
complete with details on the actual goal of this entry (having all
Macronix flashes to get the fixups, without creating separate ID
entries for each of the flashes)

Thanks,
Miqu=C3=A8l

