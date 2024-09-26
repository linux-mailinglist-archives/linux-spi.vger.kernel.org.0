Return-Path: <linux-spi+bounces-4979-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF2986B2E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 05:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56D71F22B9C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 03:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5913B7BE;
	Thu, 26 Sep 2024 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpUrEbyd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFC610B;
	Thu, 26 Sep 2024 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320063; cv=none; b=E6QnONTA3xX5pgZ3qLYLnlEMxBfwDSjfaVPVqizfG+cywfIx7vjBXOO6kCVnj1ItNr4bGhkS6bJpFWhD9MOSYW2y8kHkyaWRAfWHAB/Qqe+Gr1QL6/kU5cNCh4+th5V/uGWxBLl3NZkDJN/GPqQAFyFpx4J9Caye+AQcJLJX8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320063; c=relaxed/simple;
	bh=ALZuawAv6RfhRY6+vfLFnO27Tn6WraHoyicrJ8XdUYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvsdVlA0KQ2rzQZ9hbReEu6qPRgGFknF6GXYVvgVXRl1atswB7zDSAEx/XGNZ/oRS5U2GmwideJFqsY853GUpj3Dryl/XcLWbFvFZQ9Ram6cPj4CsRk6KTKLKT93I0V1/yCjYMDcjW09IDN8eYoeUgGSGhNuEtd2ymusZZiMfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpUrEbyd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a90188ae58eso61104666b.1;
        Wed, 25 Sep 2024 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727320059; x=1727924859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjHLO3lK/OQsJDE6OFm+7r5Bk5tao2ttjn7ToVjtLbE=;
        b=mpUrEbydil0BbHIjknbZIei/rLF21sxIl6tS3je/Rs9UjfECutGm16qb7GD8otAGN3
         PuR8McG7hkE5hvnV5U7q4Cn3dh2qvTj82ouOAZGYhqr/1BW21bKyMHY2uihXMNtmO8tp
         SIQx0nzVCKo69j7XD+uEnPIaiMFk3GKskLycoU+5ldzyinE1cpushisYdZ+J0E3Z3cXm
         dLDe30X67P/3sdyQISsw2+rg9g2Uav/f5sLRyatqGJ3wRPnVmKN2iD2RlXN2shwjOum1
         MCr2cdZTRQ1Kh7FifpuQU5BYsRUW1yv9YnPMxwztirZsGkXs3D/OAZ0QfjJXpD6eZ0kj
         s/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727320059; x=1727924859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjHLO3lK/OQsJDE6OFm+7r5Bk5tao2ttjn7ToVjtLbE=;
        b=fb4YzwfqInqSEfUcDAvzNFUg6nhbq6PyTxfGtfGYlBeG1fqw5GqeNpe7/59pw0aCeE
         p4i492iR9USKaOcoRkZhbkZywJQJE0wvTxHfLs3yEehAKU1vJCyLJA4c2JtVPO1nojYS
         0JHidYTKqEUh6TX7avjXPq5RnHMX8dxOWlbYE4XCnwpwwY7jbtmNh7+QAzQFmHJg4BYr
         b9CDPDf9GmxtJP+HX5xKv+aZLhAPhX0pExGJIpdje9aOz8PhZ4dMk1WrKaa3xiJwb7cj
         RYVwYvESZR1P5y/j/zuwnMktUUaBhvaRDaedPUnJ/3TFNQXUvr+AIWHDdKSO05B50Lji
         K88A==
X-Forwarded-Encrypted: i=1; AJvYcCUaMX51afnWp0sZ0iDu7F4iNPQgwQyA3nLECxqoHo5yDmGNHV1Ic3wXpuYNrYrSNwrjcGYggi31T9YZ@vger.kernel.org, AJvYcCXJmDgQc+SUnIXKEHIsAdKrldV61wCR2Ay3FRplG5KlFmIq+VHicIhIoQSrNIQEMSXRLuRyXlnEHcOR4Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3UpPFnt1DM3f44j01aiMuzAHvnelg230F7lV54vKWvDosadI
	uCgvBQRSXqNZQj1iWZ6tpzH2MfJD5ATQgUDk42nptShf3CxPCAWr88M3K4nh7xHyCEprnUB1pWS
	CnI2MC3xkOwyWUaN5A1AdaDUrdGM=
X-Google-Smtp-Source: AGHT+IHQnslP5PPXpBtyd2X2lFAmGTpsIvv0uQ/zlGvwN5ExqoTvexqaymYpjsuH9T2eLl+rbj3GyIp5sEfE5Sm7rPE=
X-Received: by 2002:a17:907:e6d8:b0:a77:cbe5:413f with SMTP id
 a640c23a62f3a-a93a03247a9mr349784066b.4.1727320059072; Wed, 25 Sep 2024
 20:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-7-alvinzhou.tw@gmail.com> <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
 <CAPhrvRR3U9=0DuG_FQ81ZJq+RLe6Bn9YO831Mx2n3NkeV3MCdA@mail.gmail.com>
 <368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org> <618e4514-791b-4a73-a1ba-45170a21e453@linaro.org>
 <79406f2b-8411-4059-b959-9e543944fb9c@linaro.org> <20240925115746.22cdd8fe@xps-13>
In-Reply-To: <20240925115746.22cdd8fe@xps-13>
From: Alvin Zhou <alvinzhou.tw@gmail.com>
Date: Thu, 26 Sep 2024 11:06:41 +0800
Message-ID: <CAPhrvRR2_j=KhFJHWyU48z998q0wkoZJYCBAUuv8ejp7xnkWiQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, linux-mtd@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, pratyush@kernel.org, 
	mwalle@kernel.org, richard@nod.at, vigneshr@ti.com, broonie@kernel.org, 
	chengminglin@mxic.com.tw, leoyu@mxic.com.tw, 
	AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>, 
	Bough Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=88=
25=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Alvin,
>
> tudor.ambarus@linaro.org wrote on Tue, 24 Sep 2024 08:17:26 +0100:
>
> > On 9/24/24 7:36 AM, Tudor Ambarus wrote:
> > >
> > >
> > > On 9/24/24 7:26 AM, Tudor Ambarus wrote:
> > >>
> > >>
> > >> On 9/24/24 4:25 AM, Alvin Zhou wrote:
> > >>> Hi Tudor,
> > >>>
> > >>> Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B49=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:54=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > >>>>
> > >>>> Hi, Alvin,
> > >>>>
> > >>>> I quickly skimmed over the previous 5 patches and they are looking=
 fine.
> > >>>>
> > >>>> I don't get this patch however.
> > >>>>
> > >>>> On 7/18/24 4:46 AM, AlvinZhou wrote:
> > >>>>> From: AlvinZhou <alvinzhou@mxic.com.tw>
> > >>>>>
> > >>>>> Adding Manufacture ID 0xC2 in last of ID table because of
> > >>>>> Octal Flash need manufacturer fixup for enabling/disabling
> > >>>>> Octal DTR mode.
> > >>>>>
> > >>>>> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> > >>>>> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> > >>>>> ---
> > >>>>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
> > >>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor=
/macronix.c
> > >>>>> index f039819a5252..1a8ccebdfe0e 100644
> > >>>>> --- a/drivers/mtd/spi-nor/macronix.c
> > >>>>> +++ b/drivers/mtd/spi-nor/macronix.c
> > >>>>> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_p=
arts[] =3D {
> > >>>>>               .name =3D "mx25l3255e",
> > >>>>>               .size =3D SZ_4M,
> > >>>>>               .no_sfdp_flags =3D SECT_4K,
> > >>>>> -     }
> > >>>>> +     },
> > >>>>> +     /* Need the manufacturer fixups, Keep this last */
> > >>>>> +     { .id =3D SNOR_ID(0xc2) }
> > >>>>>  };
> > >>>>>
> > >>>>
> > >>>> Could you please elaborate why you need just the manufacturer id h=
ere? I
> > >>>> would have expected to see a specific flash entry instead.
> > >>>
> > >>> Grateful to Michael for the valuable suggestion. This addition of t=
he
> > >>> Macronix manufacturer ID enables the fixup functions such as
> > >>> macronix_nor_set_octal_dtr to be executed without the need to
> > >>> create separate ID entries for each Octal DTR NOR Flash in the
> > >>> flash_info.
> > >>>
> > >>
> > >> Ah, nice. Okay then. I'm going to review the rest of the patches. Th=
ey
> > >> look promising ;).
> > >
> > > ah, but then you'll always have a matched ID, so you break the generi=
c
> > > flash probing for macronix. Is that correct?
> >
> > Answering myself: it's fine. Generic flash probe just fills a name,
> > which we don't really care about.
>
> I was also a bit surprised by the diff, would you mind filling a more
> complete with details on the actual goal of this entry (having all
> Macronix flashes to get the fixups, without creating separate ID
> entries for each of the flashes)

Thank you for the reminder, I will incorporate more detailed
explanations.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Alvin

