Return-Path: <linux-spi+bounces-871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4274E83E2BC
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3702829B6
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77041225AD;
	Fri, 26 Jan 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9XTMAEZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EF224F1
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298050; cv=none; b=RQmVtZOlsvTXbWJhcY7SI//QYnhpd8t9gFNwsOG33tlW6E5DQeb6+MECjLpScvXgjiKvOV6PrdtmzF2oN2VDzHnvJLKeCApinSehmUEMiYEmWN+FTQXEKlVcmVPwkdaN0lmGx/uSc6BAAaO9qAt4sLA5aSio8REX1i8tzMDRJkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298050; c=relaxed/simple;
	bh=OBj1MQ83FFOJOJoro90yvy1KezyhRGXOLXp4aKhIJAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2eLscf4QM20yBP5E7rtajB+OgyokuZlwyRxYHeFF8BtgAnAteforEV38bdJZMQ8O+VO6Xfc3FR85WnD6MSmynRv/tnpEt5KbvjwvV0KD+0sssW0jP22tNhlg82SsHiPUvIu14J+bkXhEJehpOBHVGQS02nKOBbH8eOe8rvLSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9XTMAEZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddc0c02665so527631b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706298048; x=1706902848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBbDvP0t0aTfbdb0HiCNofP6pAFpkV6GyeXeCF9Dz+g=;
        b=b9XTMAEZEi4xfew5FbLUpnFrl2/v2yCC9CEARW4JjrVbQB71ZS7HfzojwBaWwlRL3i
         o/lEp9arS7b5VsensJZBbvzqJKm2Pc1EU4AZ7wXFl5fjCuNNhZgA2k8rtLjRzP+SZnBA
         YyMzx9EpkhXPHjQDRwt6SdMTcMztNoO6iOkUFJA4r1eVLfkUDyaEdHsFUe+Z1BEo4y85
         9TinB+HSYsunGCBG/6TlJHz0BU0myzjII7eGehOj6DaDjazlj8dHyD1E60XJvYhZ9+5T
         FKCU3CKAb/xuiFGLBZkmOmfvxDwHNHawuEchwsK5/pS54MkjGhLFiEXGfau/17M1fsbk
         ZuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298048; x=1706902848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBbDvP0t0aTfbdb0HiCNofP6pAFpkV6GyeXeCF9Dz+g=;
        b=plIkZVKdUA3QtllPKzaNrEBk8AsWfHoICNMORhhV5ug//FJUak/SWRdV9hVWGeXtzd
         XbGvqZ3Qbczte4e+7GO3dCepHZjfTH1EaWTGVlfCtm6/JdfGGZpq75qXAxPOKOgM23ug
         tzc1h9KG5ndJZcny5xQRDVLnAzf5PYxXV7a2/oLOaI4Gc9YYDDM0OcBAijoayw9Bhi82
         2wjqOCuFEE89lHmcUgEDsczGHEotuIR/PUMeErS8rR6XrLVWCuTbj7MKdCl+QmWF1cPf
         tMxpY1JDM43xRjaf/JFWu/0oPrSAvUJafksaB1WSkAFh/iNNU1Pk6oLmkMA+AeDpC/tR
         E3vA==
X-Gm-Message-State: AOJu0Yw/dXcUT/y127lMqBVZsYwfFE4X+9Nmg+XV8ZI4g58zoHNDfB0r
	n11O7T0ut13bjdT9uRwR34XrhwxiCFFY1bPInc3f0Gj9z5k7Z62ZQ9DZPcplZcOF7o47Pf4Xnus
	bl7TGDKh4LEyiIcOeuri/4YTR6sD5PoOThH3hHA==
X-Google-Smtp-Source: AGHT+IEMMgoTsBz+FBptiMPa1pqE4iSooChOPZ0bqJTF6Z9PIPSATEYE9Y7LOnEFRlmJSEKdIL5mxk5heq+bSm7H+OE=
X-Received: by 2002:a05:6a00:b51:b0:6dd:7b96:b4b7 with SMTP id
 p17-20020a056a000b5100b006dd7b96b4b7mr378122pfo.41.1706298048159; Fri, 26 Jan
 2024 11:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-8-tudor.ambarus@linaro.org> <CAPLW+4kGGtG2BxeN0wRXMD5M2TR+eMUHZpL2KDaEFubBCP7jdg@mail.gmail.com>
 <cad69841-9ca2-45af-9db2-4c4aced63d5e@linaro.org>
In-Reply-To: <cad69841-9ca2-45af-9db2-4c4aced63d5e@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 13:40:36 -0600
Message-ID: <CAPLW+4mJ5BxwhKwi2Z2pMOu1D0N0KaaW7=C1sZ0PV51iOHSw8Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:24=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Thanks for the review feedback, Sam, great catches so far!
>
> On 1/25/24 19:04, Sam Protsenko wrote:
> > On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> of_device_id::data is an opaque pointer. No explicit cast is needed.
> >> Remove unneeded (void *) casts in of_match_table. While here align the
> >> compatible and data members.
> >>
> >> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 45 +++++++++++++++++++++++---------------=
-
> >>  1 file changed, 27 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 230fda2b3417..137faf9f2697 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -1511,32 +1511,41 @@ static const struct platform_device_id s3c64xx=
_spi_driver_ids[] =3D {
> >>  };
> >>
> >>  static const struct of_device_id s3c64xx_spi_dt_match[] =3D {
> >> -       { .compatible =3D "samsung,s3c2443-spi",
> >> -                       .data =3D (void *)&s3c2443_spi_port_config,
> >
> > I support removing (void *) cast. But this new braces style:
> >
> >       },
> >       {
>
> this style was there before my patch.
> >
> > seems to bloat the code a bit. For my taste, having something like },
> > { on the same line would be more compact, and more canonical so to
>
> I don't lean towards neither of the styles, I'm ok with both
>
> > speak. Or even preserving the existing style would be ok too, for that
> > matter.
> >
>
> seeing .compatible and .data unaligned hurt my eyes and I think that
> aligning them while dropping the cast is fine. I don't really want to do
> the style change unless you, Andi or Mark insist. Would you please come
> with a patch on top if you really want them changed?
>

But that would completely undermine the whole point of the review? I'd
prefer this style:

... =3D {
    {
        .compatible =3D
        .data =3D
    }, {
        .compatible =3D
        .data =3D
    },
    { /* sentinel */ },
};

That seems more canonical to me, and more compact too, with no
contradictions to your preference about alignment too. But that's only
my opinion, as a reviewer.

> > Assuming the braces style is fixed, you can add:
> >
> > Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> >
> >> +       {
> >> +               .compatible =3D "samsung,s3c2443-spi",
> >> +               .data =3D &s3c2443_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,s3c6410-spi",
> >> -                       .data =3D (void *)&s3c6410_spi_port_config,
> >> +       {
> >> +               .compatible =3D "samsung,s3c6410-spi",
> >> +               .data =3D &s3c6410_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,s5pv210-spi",
> >> -                       .data =3D (void *)&s5pv210_spi_port_config,
> >> +       {
> >> +               .compatible =3D "samsung,s5pv210-spi",
> >> +               .data =3D &s5pv210_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,exynos4210-spi",
> >> -                       .data =3D (void *)&exynos4_spi_port_config,
> >> +       {
> >> +               .compatible =3D "samsung,exynos4210-spi",
> >> +               .data =3D &exynos4_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,exynos7-spi",
> >> -                       .data =3D (void *)&exynos7_spi_port_config,
> >> +       {
> >> +               .compatible =3D "samsung,exynos7-spi",
> >> +               .data =3D &exynos7_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,exynos5433-spi",
> >> -                       .data =3D (void *)&exynos5433_spi_port_config,
> >> +       {
> >> +               .compatible =3D "samsung,exynos5433-spi",
> >> +               .data =3D &exynos5433_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,exynos850-spi",
> >> -                       .data =3D (void *)&exynos850_spi_port_config,
> >> +       {
> >> +               .compatible =3D "samsung,exynos850-spi",
> >> +               .data =3D &exynos850_spi_port_config,
> >>         },
> >> -       { .compatible =3D "samsung,exynosautov9-spi",
> >> -                       .data =3D (void *)&exynosautov9_spi_port_confi=
g,
> >> +       {
> >> +               .compatible =3D "samsung,exynosautov9-spi",
> >> +               .data =3D &exynosautov9_spi_port_config,
> >>         },
> >> -       { .compatible =3D "tesla,fsd-spi",
> >> -                       .data =3D (void *)&fsd_spi_port_config,
> >> +       {
> >> +               .compatible =3D "tesla,fsd-spi",
> >> +               .data =3D &fsd_spi_port_config,
> >>         },
> >>         { },
> >>  };
> >> --
> >> 2.43.0.429.g432eaa2c6b-goog
> >>

