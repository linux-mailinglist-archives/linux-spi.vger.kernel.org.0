Return-Path: <linux-spi+bounces-9242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F17B16646
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 20:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CA81AA773A
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872381E1A33;
	Wed, 30 Jul 2025 18:32:19 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58313881E;
	Wed, 30 Jul 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900339; cv=none; b=eR4V0QMTr/MLzLy40Mt/wvx4ikwqz57e07N0mJAxEFDXOYKnpFTY8/vGeSrgMCDeSf9bga/HLCVmacBNTkiVKbrZxoIMdhBWerMBiee3HtLF74z4picMEJ+6Nayl+3GOdPpNpmLEFfB2DbolCEX/iCF0PuBklDojrpLDHYuJ2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900339; c=relaxed/simple;
	bh=TErlSHiMyrHTkjY7/YqPiL0e5wco2YkxlrRHfKXiaGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGguVWvwqdK2rkkKG+ZsPufdA6piRH3Vgvna6ueeAgv8XCKHQgm6ccmjigsn07qWNePcfBmpPksqeeLzd/cscpw/eUFlZTuEzFz7K5UqfA2BPI7GUuXW/Os5uXgmm6a40+GFCizK387LKn4xy1kIxzotmPS0oW0A1GTeuX6pM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5390f4513e2so109108e0c.2;
        Wed, 30 Jul 2025 11:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900335; x=1754505135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipmEQYg9ZlbVKfpl84MWkPDb82lJxzygYorauqeRBaw=;
        b=GAiKhHNBwNaP4StJmHrAJN617+HVndbWP7CfxPEMROFYCgntKTPFSe7GANJCsqnR1E
         2ex0saP2otc8J5/MletfQ8kXgG5DCjTGJ50HCnnM1uJuioSw9S6lDkbVUBNSpCPIz8V7
         kiF1jWrVryqIxAPEZMxGgAj/i5EXhMj/3jdODC90swFNx7vXpf9C4ooIWnU9Rypo0uh+
         TyBuHBip+VYLwpDmeVMyp2LEII15UZ6t8EfJJ6bsF71QCUbogvpYr0Y+tcKXmGPBa5v/
         QqUPqVCMQ0lInS67u3i3Yf1aJIYzExONfr6FM8U8IpLj0m57enpvU7W241B/f54na/U8
         6wxA==
X-Forwarded-Encrypted: i=1; AJvYcCUMoNFdAMu5uerGEBCzD7Q48lfWf1I4XwwpRhXR3wYj9jz0FlahnTsWEkgmvBvUtKWVlCaTDI403eYJWBs=@vger.kernel.org, AJvYcCWQWLiY0Kl0rWmyxY2WmWFstlqlQq3hL/Mh7XSWOD5trpa6tpB4q2QF4a43ES1v0TubtkQYwb6nY/8c@vger.kernel.org
X-Gm-Message-State: AOJu0YwywNODYURhl1/0UTH5ZCLtUoqg5LjqKILf2mLq536qamPXfSIa
	W5MystK2ecfCVx/O9oiicH/1sZ4XF2AvLGwpxO+dl3DuQWQwJmnL1yV7bpGTv53G
X-Gm-Gg: ASbGncuITzyWDYspR/DHz+LYT5B6XXOljIEKvm/T6p0pLLp0FWVRP3CXHbwJJonAYpi
	I0500QxchZs/jLYaQVnubpKL90QDzyz1ZJxfmd5k8FG0VMljLxYbAiQbUfy4b+WVDaDt63Hj8Z0
	/p7cTpgTy6s/5UGEK7DYPDPaqL1Q/gFSt5i2o2VntkghozhAl6Q8oWxCF8ETKWTi5AAKoWRT/cm
	Y2CvAgdglEofkI/JQRGn6IvslCX5z6Aw1HfeITlr2nuf4OZqPTpj8dfR9+UFqU5tA4uypPBJN3d
	7oQuh6iN+No7OsvCQbY6Btqfgzt+MCEva0ZS1OjINEFP1oLsla52WPHxNhvnWApyonnj/at23vY
	PWKe+LKQ3yGVPE2ZEb2yIvKEe6dd8IStD+mhcTfza4ip6iVWWm4lZ11/IVqMS
X-Google-Smtp-Source: AGHT+IEsEnP+o+E3aPkKA4pw2NwqlqZ0rOIzES4FvnThCKWzpZkZA/d51neize/l4n+YgUrHxQPBRg==
X-Received: by 2002:a05:6122:134b:b0:531:2906:7519 with SMTP id 71dfb90a1353d-5391cf0bec1mr3116738e0c.5.1753900335001;
        Wed, 30 Jul 2025 11:32:15 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e288d3c0sm2881915e0c.31.2025.07.30.11.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:32:14 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4dfa2aeec86so111483137.1;
        Wed, 30 Jul 2025 11:32:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWifWouxmsijm4mh7PQscTksd1e8AsOcfyHP6Nwdd/P4PkPwXMHSZFmwekla0tLxoGgqL6xXnvhu1jOtI=@vger.kernel.org, AJvYcCWpGeT/MviBlgWWLEGyHPRJ+mgzSj50fRIqSXLweixGcLSNHLknbDgkj48AIl9ADRYtjLu1n0TR5qov@vger.kernel.org
X-Received: by 2002:a05:6102:808a:b0:4fa:8327:703d with SMTP id
 ada2fe7eead31-4fbe878c9efmr2951543137.19.1753900334252; Wed, 30 Jul 2025
 11:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
 <CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com> <b3395812-6000-4e23-9b25-dbbc97547acd@gmail.com>
In-Reply-To: <b3395812-6000-4e23-9b25-dbbc97547acd@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 20:32:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9jbV344NDdq41ypqdmeh_eqdrTvnAn8PZcfqHc1OESA@mail.gmail.com>
X-Gm-Features: Ac12FXySOljeScBWyBqDn8jLIcw_-mmNdEY4F0xBVNIh1NPrzod3yx677ryIiFo
Message-ID: <CAMuHMdW9jbV344NDdq41ypqdmeh_eqdrTvnAn8PZcfqHc1OESA@mail.gmail.com>
Subject: Re: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais=2DPou?= <rgallaispou@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rapha=C3=ABl,

On Wed, 30 Jul 2025 at 17:38, Rapha=C3=ABl Gallais-Pou <rgallaispou@gmail.c=
om> wrote:
> Le 28/07/2025 =C3=A0 09:35, Geert Uytterhoeven a =C3=A9crit :
> > On Tue, 10 Jun 2025 at 16:59, Raphael Gallais-Pou <rgallaispou@gmail.co=
m> wrote:
> >> Letting the compiler remove these functions when the kernel is built
> >> without CONFIG_PM_SLEEP support is simpler and less error prone than t=
he
> >> use of #ifdef based kernel configuration guards.
> >>
> >> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> >
> > Thanks for your patch, which is now commit 7d61715c58a39edc ("spi:
> > rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()") in spi/for-next.
>
> Did you mean commit 6f8584a4826f ("spi: st: Switch from CONFIG_PM_SLEEP
> guards to pm_sleep_ptr()", 2025-06-09) ?

Oops, you are right. Sorry for the confusion.

> 7d61715c58a39edc ("spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()")
> points to another reference, authored by you. :)>
> >> --- a/drivers/spi/spi-st-ssc4.c
> >> +++ b/drivers/spi/spi-st-ssc4.c
> >> @@ -378,8 +378,7 @@ static void spi_st_remove(struct platform_device *=
pdev)
> >>          pinctrl_pm_select_sleep_state(&pdev->dev);
> >>   }
> >>
> >> -#ifdef CONFIG_PM
> >> -static int spi_st_runtime_suspend(struct device *dev)
> >> +static int __maybe_unused spi_st_runtime_suspend(struct device *dev)
> >
> > The __maybe_unused can be removed, too...
> >
> >> @@ -429,7 +426,6 @@ static int spi_st_resume(struct device *dev)
> >>
> >>          return pm_runtime_force_resume(dev);
> >>   }
> >> -#endif
> >>
> >>   static const struct dev_pm_ops spi_st_pm =3D {
> >>          SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
> >
> > ... if you would update these, too:
> >
> >      -    SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
> >      -    SET_RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_res=
ume, NULL)
> >      +    SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
> >      +    RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume,=
 NULL)
> >
> >> @@ -445,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
> >>   static struct platform_driver spi_st_driver =3D {
> >>          .driver =3D {
> >>                  .name =3D "spi-st",
> >> -               .pm =3D &spi_st_pm,
> >> +               .pm =3D pm_sleep_ptr(&spi_st_pm),
> >
> > This should use pm_ptr() instead, as spi_st_pm defines not only system
> > sleep ops, but also Runtime PM ops.
>
>
> Anyway, that is indeed a good catch.  I actually got lost between
> CONFIG_PM and CONFIG_PM_SLEEP, which is now clarified.
>
> I made a fix, but will send it after my summer break.

OK, looking forward to it!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

