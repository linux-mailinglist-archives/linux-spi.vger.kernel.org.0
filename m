Return-Path: <linux-spi+bounces-3728-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974F92619E
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 15:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE79EB2BA50
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56917A589;
	Wed,  3 Jul 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZleCWzZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4383177981;
	Wed,  3 Jul 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012382; cv=none; b=Ju+ANW0Rx0PrU5+4J9FoyRl24I0eiDYUreO9j5eCouJVj3nDt0NVxi10YtukHff+CO4Vzpc9Lh363GnIMr3HY3EUTCGF5E/ZJRIAAmCVs9N3jKKOpM98fvPXmYP1633kkJm/N0SeLyqKYAiBdu6atWSBMuodue5DhCp6emGrr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012382; c=relaxed/simple;
	bh=XQh38zj8YkxwoSpU2bVUlQPlOmTJ8dlkgb/XN2Vm+8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7/ynRjEH3iYh7cJ1ao4x7+o8LF+pfdD2GS81QvU+yildr6dLlyHesFVmgkZOi9jmq0RFMxBN1r0xSzU0tPovugiJ2bVV3561iUfjqORLentLk8MHdr7JTm/EUOPs7vY9tz7IVNcSd0CawpWwkZvbJQit8XkGbMnSaGRwvyc/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZleCWzZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdea1387eso5905450e87.0;
        Wed, 03 Jul 2024 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720012379; x=1720617179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NKJh1yZ1elVP56CeXKI4BwpSL1VRHDS3kGX7TjqJRc=;
        b=VZleCWzZoG/PAxSg9zswvytDN2eirOyt9v8nI4xBNP5TPberfif92C8nocRDulTti7
         uYWgvDDHdjN9TmiQAxJXMxxFP0cQuTWJro8MKhYCSqikdUQMyQazIydibGNsolZgsiR2
         dgF0lDfP5ZQ0r8wutj/0Tjg30am5P1K7vGO5ASFkyV3nUsU77LwQqIuaY5H1qJgvE8xD
         KQuDjRB6CilRHuhNqxVIpWp3XIEdsUWomKgXWUQiAsTU/1S5zZsybYYwS+RW9eCyf7vG
         Kj7gWe++j/gZ+5CKZujsUsMmXC0uCbKxkGCb803x1j4cjemGT129RmMYwebDGqYeWKOy
         ni0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720012379; x=1720617179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NKJh1yZ1elVP56CeXKI4BwpSL1VRHDS3kGX7TjqJRc=;
        b=D4+Xu/s8uiHraa/ZVVF4lnSab14CGuE1KYV5UyKdbTu30BzBo3+/kRH8+npIBAzfVA
         mOUhKCMG56rWw3yetz01OawmgwkSMX+rZPQy5YlsVmSNVD+He4sfJoZUKohOMlww4zt/
         JywB4asciyr2ir9tx9Rqh+SpTsNlYlX0J3cuUY8Mg8MU364pS7U6FxIcMawZNGDM+H0j
         IU/Awl6XH7JYV9TiRYWw1ghDaNFY4tVZnH+K73bghE0L+X9kaeVnhL2CIsqZyMBTuhUv
         m4qANu8jfo9wUs61545KZPTYtMN3BvV6HLoOODjxci92xhodm7upswye1bzpED3AOsOs
         nqPg==
X-Forwarded-Encrypted: i=1; AJvYcCULRCb5RwA66aToxYI415m/jEIgk3iTqBF6dAcBxxDyNjuw1gTeWCWsU9RsLRQ/aDT0wsZrweboghwW0HhU3wP2VM6juTv4BawXGORZ+ZtYQsX+y0JOHo4kFNKuvGNS3oem5hHPdvNfacyykA6t2NaAVz3XwWP8Eu2wKc5Rpexuie8nfA==
X-Gm-Message-State: AOJu0Ywv/Z0TotpGx/EC8/0Af5jwp5sqK44VYfd88/DOIYp+e7TELvoq
	mq9ABv8QN/dJCpvMO4ANBGghpQ5ALrAwG/+iM8AWKinkit1gjG6Xi7C0pIkacQbV5g8hz2YieEn
	3E7pBMyms9UzJNs37Ot86E28X3wuz9TOZ
X-Google-Smtp-Source: AGHT+IEKCloal0IFPzdNkFkI2Hak2EZ742ax7plHna9yjqGCtPy3jRYVNeZ8SGON8Mm/M4XafoTTnS7CcgCDH0A9M9M=
X-Received: by 2002:a05:6512:60c:b0:52e:9b92:4999 with SMTP id
 2adb3069b0e04-52e9b924c0cmr234740e87.2.1720012378657; Wed, 03 Jul 2024
 06:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com> <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
 <23gvjkszxvf6zehiqetjfmtf67nlpnnfmhgx234jnxwrtmbdpr@4yv64sz2kpcs> <20240703-garbage-explicit-bd95f8deb716@wendy>
In-Reply-To: <20240703-garbage-explicit-bd95f8deb716@wendy>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Wed, 3 Jul 2024 18:42:46 +0530
Message-ID: <CAGLn_=tieSCGWix-0mGC7n8MnD46WPxuWh9xhtB6r+YZry463g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
So, I will drop this patch.
In the next version (i.e. v2) of this patchset, do I need to include
the dt-binding patch as it is already in for-next.
I am waiting for comments on the devicetree files before sending the
v2 (if required).

Thanks and Regards,
Kanak Shilledar

On Wed, Jul 3, 2024 at 12:59=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, Jul 01, 2024 at 09:57:20PM +0300, Serge Semin wrote:
> > Hi folks
> >
> > On Mon, Jul 01, 2024 at 08:17:29AM -0500, Samuel Holland wrote:
> > > Hi Kanak,
> > >
> > > On 2024-07-01 7:13 AM, Kanak Shilledar wrote:
> > > > updated the struct of_device_id dw_spi_mmio_of_match to include
> > > > the updated compatible value for TH1520 SoC ("thead,th1520-spi")
> > > > to initialize with dw_spi_pssi_init().
> > > >
> > > > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Separated from a single patch file.
> > > > ---
> > > >  drivers/spi/spi-dw-mmio.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > > index 819907e332c4..39e3d46ebf5d 100644
> > > > --- a/drivers/spi/spi-dw-mmio.c
> > > > +++ b/drivers/spi/spi-dw-mmio.c
> > > > @@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of=
_match[] =3D {
> > > >   { .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init=
},
> > > >   { .compatible =3D "canaan,k210-spi", dw_spi_canaan_k210_init},
> > > >   { .compatible =3D "amd,pensando-elba-spi", .data =3D dw_spi_elba_=
init},
> > > > + { .compatible =3D "thead,th1520-spi", .data =3D dw_spi_pssi_init}=
,
> > >
> > > Your binding requires snps,dw-apb-ssi as a fallback compatible string=
, which is
> > > already supported by this driver and uses the same match data. So you=
 don't need
> > > this patch; its only effect is to make the kernel larger.
> >
> > Agree with Samuel comment. Indeed there is no point in adding the
> > vendor-specific device-name supported in the driver if the fallback
> > compatible works as-is.
>
> FWIW, Mark picked up the binding alone so I think there's nothing for
> Kanak to do here & the driver patch should just be forgotten about :)
>
> > >From that perspective we shouldn't have merged in the patch adding the
> > Renesas RZN1 SPI device name support, since the generic fallback
> > compatible works for it. On the contrary the Microsemi Ocelot/Jaguar2
> > SoC SPI DT-bindings shouldn't have been defined with the generic
> > fallback compatible since should the device be bound via the generic
> > name it won't work as expected.
> >
> > Although, it's better to hear out what Rob, Conor or Krzysztof think
> > about this.
>
> I agree with what you've written. If the fallback works identically, then
> the specific compatible shouldn't be added here. And if the fallback
> will cause the device to misbehave (or not behave at all), then it
> should not have been added.
> I'm not sure if the Microsemi stuff is in the "won't work {,properly}"
> camp or in the "will work in a limited fashion" camp. The latter would
> be suitable for a fallback, the former not.
>
> Cheers,
> Conor.
>

