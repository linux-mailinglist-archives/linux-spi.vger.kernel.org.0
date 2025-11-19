Return-Path: <linux-spi+bounces-11303-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FBAC6E14C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7627B3859C8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317B126B2D3;
	Wed, 19 Nov 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bvq5utmD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F5331A43
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549425; cv=none; b=fx4Zg/4Qjif7IhP2RcBv0rzyoJalIAWofPcgH2ZCwrsl/71O8csyOOL4XXThYOgiCF949AFczss8yd/KkkHIhhscYOKfD8bFcaUCxIct9MKJfZjCpMth0ioGCdBr9qd2BhG5+6ZtlJXmNmK9lKBiPBi+F1dA9arbLP5kf7yKrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549425; c=relaxed/simple;
	bh=U0lZHlvs3oME19X+GdToGZ3Zc7DkUXF+0jdjnChjHjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv/WwumMFpELx/bms3NmwiUb4YT8iOxbK0zE0/m9ZLHzy2qaWm6wgxyPMx0v3kRYDKbUvh7ZNWMOf931rAB9x7ECZPr7EvZSE0ed8u91jhB1gPv7d81t+jszJuBbXMXLsUJZ5aD3BxiLCifAH6l5nhdN3UiWZTdHKXL7LrgEpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bvq5utmD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957db5bdedso6173536e87.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 02:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763549421; x=1764154221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0lZHlvs3oME19X+GdToGZ3Zc7DkUXF+0jdjnChjHjw=;
        b=bvq5utmDa7MhpzW1p9Q6KeFOGDNo2Qr7zqGo3xi9aIFQ2eB8UZTZdApoHSKFl/CMiT
         bgEjzdTwEyX1dy4+vYBbIHVxeQIg0/eA3+a0Y8mcjlKhs0M5jqPzbZs6iefl9AcEaJ54
         NdDzvU/8qNp/Duw479IECpWA6gwEtobwMWwvcuT3/Fqm9zD0V1hrbhlObaXqrtx7W7gY
         TZLjWfCqg32xxlhBqhyb3Kl7tplfUJlVm7QH2ZkgiqNOUYgvqWEr97/7tsZBvzE3rqvP
         mzcrCQt/ZD1ESXp7slC75d3hht4sFez7VrFcCymcc1A5tJHnjGHpYex2Bula0uqMFq7h
         AS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763549421; x=1764154221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0lZHlvs3oME19X+GdToGZ3Zc7DkUXF+0jdjnChjHjw=;
        b=dHp0NSj7ZGPLs/uZSUiYdElO8x0qpEt8FFJBq3Yw+FcNI3ecSQgzPNV19H3/3H5lGW
         Lv2NhoZZcAr9Wjc7glUQmh2Ms0KrKjIGpYQRV7bj4pDhS5bWcziAnp/U5qFzdzYNsSSa
         ItXUDWQU6H9eEYnk9j3gs/U4xHClgKVpPsB9HMDfXL5tpJPsWXLTH7zXdmFNu5XsWqx2
         0vbiQ+P54Sb+btikidvk+ZO7rBGm5uL3ZVe9rlcib5RULPyjtNZv68sWtujH5g8l75nG
         tsWvYzYGquhwAynU1hmXiTBOeC1ROlgmS9ppi6NSW2P0hd3m23rU9jvok7GtG1KHYEZr
         /h4g==
X-Forwarded-Encrypted: i=1; AJvYcCWyjOEdPA+70craH71kaVfiyO3peIw+l4D+x3Rf5wrHDlJhkCSJY5KrkskofAza7eQ3zqumlPnmeQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkmJUXag+Q8+dbagPePKtCz76TjGdu+k1L75lTRczcexeEWVKT
	Pb4EE5SP/lYmE0D34HE78LVNvYsElrEvlWIibKrEhTtTiofr2InKjQoaXk2+P+XlgdMUr17h3s2
	8wp4TaCyUdKRKcHqN+gOUTXO4aAqRzjKbIs69Bu+S8w==
X-Gm-Gg: ASbGnctztAMvjUMWCi2wXgz+6kbeMh2vbVesIBg/mHs4uGHlG9/oKwMN1m5vzVu503E
	DE0dugGwZ2pptBH+5FRRp4s3n7A6B8DzEKC/Y2uq7f0FbxLJwJojzGyzhK735OLXoQbB3sRMprv
	QZz4cBAUaKwLlAP5Tl4VOnp4g07WSMtYJguwxpAcFOBWJMkuCaO80cs2LOkCMrdxC11zQE3YGdr
	GL4QwG6gib8nRyI621zHZHkXUzg6+fm5vuKvRUl+tvYMSc9yKUPn+Vn5Jn+WH1dX5t0MWBdwXUa
	Jc6v21N1EgbuKoh9OCeYx/GqEXD/qSzp8+QyLQ==
X-Google-Smtp-Source: AGHT+IEByHLYhcIgvSanSM8tMwvF105FUFtD4D9NsQtnkjRof8Zbe/aWwLqy0tr4Fha/zwWmFa6Qnbhq5TLc/JANodQ=
X-Received: by 2002:a05:6512:12c7:b0:594:5000:4554 with SMTP id
 2adb3069b0e04-59604e3fdecmr640459e87.28.1763549421090; Wed, 19 Nov 2025
 02:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com> <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com>
In-Reply-To: <aR2gVzKhfN38MHAR@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 11:50:09 +0100
X-Gm-Features: AWmQ_bkpCln6zgbAXW2XRzVuci8BzZrDY9oELMmEyUcWmMTFoqhHCwA947yCtA4
Message-ID: <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:47=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 10:58=E2=80=AFAM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > > > > Hi Charles!
> > > > > >
> > > > > > Please give this a try. It's only build-tested so far. I hope I
> > > > > > understood correctly that it's the SPI driver that needs the "c=
s" GPIO
> > > > > > from the pinctrl.
> > > > >
> > > > > Unfortunately it fails with an -EBUSY on adding the MFD children.
> > > > > I will investigate a little more and report back.
> > > >
> > > > Does it fail in device_add_software_node() in MFD core? Is it possi=
ble
> > > > that the device already has a software node for some reason?
> > >
> > > Yeah it seems there is already a software node, although somewhat
> > > at a loss as to why, the only ones we add are inside the SPI
> > > driver. I will poke further and see if I can find out how it
> > > acquires that node.
> > >
> >
> > Let me know if you figure it out, I'll submit a v2 that doesn't drop
> > the undefined swnode.
>
> Cool, thanks for all your help here. Might take me a couple hours
> but I will get to the bottom of the EBUSY thing, and report back.
>

Sure. Could you just post the stack trace down to where the EBUSY is
returned in drivers/base/swnode.c? I'd like to analyze the logic
myself too if that's not too much work for you.

Bart

