Return-Path: <linux-spi+bounces-11349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CAAC70196
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F287928D15
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61D36921E;
	Wed, 19 Nov 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AHXs3e/g"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FC2356C7
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569752; cv=none; b=sFrIDV2zYIXdoNOrA4U2mMnS5vt6yRUE9kgVp/+AgiOjpgdpH6KK7yTffPcs9A1C6F2b8MEKEJSm5UECkynCzxOuOS+5V3OjSifo3mYsVmwl8RO5Imx+tC5QsfRQjThQ47M8JUX8/2WoAjdn4PZsBWQLKmjyv7tsqptBWZ/Z4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569752; c=relaxed/simple;
	bh=6r79QLXYlyDvCyfHUeGlAL4yjWn51Ex6V0gBW9l5SNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7+JT+BfJfvD2Cl0D3DaMnlqsYvGXU7Ee9nnHJjnhJ4c5dQ4JjZFxpUKIxKEuFQSE0Bc0XHv2gB0cTh2Hmz9eHM0+s6CKuwQbgAzL70ctF9Dd3siY8Dqq2mJeYME+8KnKXrigTNjPvYNlFKM9xG9VNrIWOWySz341TVsyylIPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AHXs3e/g; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37b96cbd875so48769071fa.3
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 08:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763569748; x=1764174548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8m8lS6jSW5nbHLHJawUmSvFPi8QtFsw/O9XwHZ3miw=;
        b=AHXs3e/gbeATM+61OoaQh/KK80IIwzmwrzwQgSAlHKwecHV9kEgoszoJqfs/S1HhXH
         z5Hv0/zgZSHuxymDyzcFLnKcPTQ0paP/vgSxPAXyqwOdG/oL8bElGDwo6l5lPwAafO3J
         XD7cxWkkeUqcQziRRIs7xwQgdgtHsI//u8hDEO2SnsjzjIpajQt+K1QeCo8LXbP9xvxM
         RQQEcskj2SvF6RDb1O0HOYGhIK/YcD5D/WWXFkZUep0YcUxgM19b0HKjWz70vhZersAq
         wG32nS9wf/osdSrMwasT/z0XrkZ2j68O3OQuEfv9y6CFpoUr7xgJOdWMeO/Kzcx/HPoP
         zyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569748; x=1764174548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8m8lS6jSW5nbHLHJawUmSvFPi8QtFsw/O9XwHZ3miw=;
        b=P9PedTeH7GC+OpmO750aHU/aOe47s2ItZelyvrUSYKwh1vqQN9xDOl3EB92XbuIXQs
         CGTxyUyGIi6zHqPymwf3zZQW0J+RKUT+56Oi9k3WQM9qtfWK/uOD4eIRjZfHSUYucIZ6
         Ya5jwCeZOl+zZ0hh/GO+LgUe2qLXllzCoj5oQxI0FGNfrOeo2lrV4vaxxTx0W+C1kV7q
         Wihu6kZsJv7pbwK5CGmdbYNLU6wnRj1gtxbpipEBwZMZH0fkwj2M84buAk4sNnmRmCm7
         b+c1W5yRZNTvMpX/7BUul0ziu2NO8tqfovMuCOEQzIAwGLd2S5KrI6KsGGCS3S6w+fXY
         R4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Md5RZ8zfWSOOgex61PfUPt93ZHbvLyYHxnDS3bnRQpx5z5sKrKX6mRSRbeTL+rKsZmAM/YxzYNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFU+Y+caUib69NjyO+IAUNU54/PQ92ePqnikvO0tDv83ENySi
	rUyicDMN6Ujd+nkeP6pv4kZCWdduRbwDNPsatGP+w6ttr9freLcOyrrvTLL26CgLMMIenwbXp3T
	AreMfUeNh9iLuEcq/JL5NcHqFkigkK6zhzrvVSUQ+Lg==
X-Gm-Gg: ASbGncvYW5Wmy9JyWn0Q65LFx5rkPPe79OUWUPgSJn+AGBqyLk10nxbdLYlGZf46wUZ
	CAR5hdbcsyNbuAy1X8iWu+1080YXx2KR0CQJ1OxxCT9+gE3XXOgeeMcHMmQam0Rf0jkgjetKhYX
	t4sShEvgsEnJYFC+ep8SqMLwFigYJmdanPqOuu6Y3deFfwW14kW4nqywKoGxgxeYUhIFCJNyh+u
	ZjKU9k2sk1u5USs29JZK011giOv0f7L3L+bUnEZKeTHCgnlxpsZAApRUOtAUlsLVNuD2dGK/l46
	W6534hwqgrGtAyMff81qi4xIx/k=
X-Google-Smtp-Source: AGHT+IE2QD4vNSKtDl9s3gywRzN+MyS6IMs7+o3AgZ4a/bIhYSgI8wp5G8/PxTLo2z9TqHV+YnaSCd701MPH97DrpAI=
X-Received: by 2002:a05:651c:40db:b0:37b:aafa:5af6 with SMTP id
 38308e7fff4ca-37cc6794a3fmr108831fa.16.1763569747867; Wed, 19 Nov 2025
 08:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-lookup-v1-0-029b1d9e1843@linaro.org>
 <20251119-cs42l43-gpio-lookup-v1-2-029b1d9e1843@linaro.org>
 <CAMRc=Md4jHrHxHUOM=eFuWRSaEO9jFEoHGTjEEJLj9w6E53gOA@mail.gmail.com> <aR3noZXxma9vOXEI@opensource.cirrus.com>
In-Reply-To: <aR3noZXxma9vOXEI@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 17:28:54 +0100
X-Gm-Features: AWmQ_blzP_C981ge0JD5PSwRAPxVinTRGKJse_DL2JrYXyTvS7IsFo-VaZxY2fY
Message-ID: <CAMRc=MdYJ0+yXziHB5ok40yUJMyYPKPt0K5COXDm3tM6dWqAJQ@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC 2/2] mfd: cs42l43: use GPIO machine lookup for cs-gpios
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:52=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Nov 19, 2025 at 04:35:07PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 4:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Currently the SPI driver sets up a software node referencing the GPIO
> > > controller exposing the chip-select GPIO but this node never gets
> > > attached to the actual GPIO provider. The lookup uses the weird way G=
PIO
> > > core performs the software node lookup by the swnode's name. We want =
to
> > > switch to a true firmware node lookup in GPIO core but without the tr=
ue
> > > link, this driver will break.
> > >
> > > We can't use software nodes as only one software node per device is
> > > allowed and the ACPI node the MFD device uses has a secondary node
> > > already attached.
> > >
> > > Let's switch to GPIO machine lookup instead.
> > >
> > > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > > Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirru=
s.com/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >
> > > +static struct gpiod_lookup_table cs42l43_gpio_lookup =3D {
> > > +       .dev_id =3D "cs42l43-spi",
> > > +       .table =3D {
> > > +               GPIO_LOOKUP("cs42l43-pinctrl", 0, "cs", GPIO_ACTIVE_L=
OW),
> > > +               GPIO_LOOKUP(INIT_ERR_PTR(-ENOENT), 0, "cs", 0),
> >
> > I sent the wrong version, sorry. This should have been:
> >
> > GPIO_LOOKUP_IDX("cs42l43-pinctrl", 0, "cs", 0, GPIO_ACTIVE_LOW),
> > GPIO_LOOKUP_IDX(INIT_ERR_PTR(-ENOENT), 0, "cs", 1, 0),
> >
> > Charles: Can you fix it up yourself before testing?
>
> Yeah can do, but I am still very nervous about how this approach
> interacts with device tree and ACPI systems doing things
> normally. Is this also ignored if the firmware specifies the
> properties correctly? I feel like if we go this route I am going
> to have to bring up a few extra things to test on as its quite a
> big change.
>

The machine lookup always comes after the firmware node lookup. Even
after the secondary node. It's the last-ditch effort to find a match
actually.

> Apologies for the delay on my suggestion but something weird is
> happening deep in the swnode stuff and its taking me ages to peel
> back all the layers of in abstraction there. It seems something
> copies all the properties and somehow the fwnode I want doesn't
> make it through that process. But the basic idea is like:
>
> props =3D devm_kmemdup(priv->dev, cs42l43_cs_props,
>                      sizeof(cs42l43_cs_props), GFP_KERNEL);
> if (!props)
>         return -ENOMEM;
>
> args =3D devm_kmemdup(priv->dev, cs42l43_cs_refs,
>                     sizeof(cs42l43_cs_refs), GFP_KERNEL);
> if (!args)
>         return -ENOMEM;
>
> args[0].fwnode =3D fwnode;
> props->pointer =3D props;
>
> ie. As your patches add support for using the geniune firmware
> node just do so.
>

But do you have the firmware node at the time of doing the above? The
software node must first be registered with the swnode subsystem to
become an actual firmware node. Only then can you reference it by its
firmware node address.

Bart

