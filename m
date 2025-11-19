Return-Path: <linux-spi+bounces-11294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8CC6DCEE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAD694E4F92
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E94A2E1730;
	Wed, 19 Nov 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pFBDWU7N"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8333DEF5
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545248; cv=none; b=ONrAPsNQF5skqUmPX8+qBScrPZJ1G1ydKgy6RMHaeGtR1Xdhm58DXDzut0Bd5OnDkB/TCmcfpGXojonbogUKH7hl7W+ZtgWccnLvzV85lAEYS7KvzyH5S/aNSl5Cz4OBl8Nz4Y3p/nmtuR0xCpWSksCpUN1hEOmsZNtmBahqmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545248; c=relaxed/simple;
	bh=BJFj7wxxyKRZ51w2Row95Z4hdVR73BFZbsO74yruv8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiVZyTO5bmRCIHQbPOR2VzCJaKw064p+F2vsKXJO64csMTa9zSf/kc5I+Kd33IPLy6BSowOHTii9K0Di6BITjdYHmrn+9n/nEYtCybPdoXTPvk6HhL0NV67rg5vIqwaGwkhvgToAqwlCO/1MEZ1Qj2W4/gWukOGG1Z6sviMuUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pFBDWU7N; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957db5bdedso6108993e87.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 01:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763545243; x=1764150043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBHgHrDZye5yPLQaEJga9ExMy8DO6FtO4ttyOjsB1yw=;
        b=pFBDWU7NVCoxsLoKcr6SRP7vUvaEnM/FjaNdOe83zehk8HT0HgZYlMXdmgxwjOCh80
         Eap6+6sLWbFcyVkwEADhTEOLV7rsfScjM5pA4OVlFxrXY6Bd9mQPqJN6gXCBhUSj7cnR
         LzgjvyIhi2jXcF1e6n3UMPT9qQpgQ28xy0t0qnNhWyZneO/tCGUQGkevZBlNmDXl/cSY
         x5UOpGHCqBS+HNo61uKbDOL9nSsUGyVl4ebifhrkGTC/it6FY7Zy+n9Sz6NArW/JWm4u
         9O/an81efoMy+5mp8rNpq7Uu6xhc7KCCiNC2R6F3vdAz0cobX3VvozyM4HunvdEkJ5Rw
         P8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545243; x=1764150043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBHgHrDZye5yPLQaEJga9ExMy8DO6FtO4ttyOjsB1yw=;
        b=FWGPlq/SisTgj4Ql0L0KBMzZa5o/T5Cnonfjz5zSmgnVE/hixmX0l1ogBx9A9mudBY
         xvytwzl+/Hnj7o24D1kW3V8L/9uN547WGHNWsrpojoqP5ywXlyBQUr1tgWsGYGaDmLxd
         2XAVV2iHPpCn6U8/as8028hsuIOCApdmsJe9yFTqj8uW0LsDmJetPLBEu1Vte5NVe9IB
         hDCamuk1EeBSBHlix6lFzItSGmjvbJ2fIAXSsdsIk0ZjAMofSNUDy4V8jBwM61dy10Rf
         L8ZoZHaTbCIwmuLcbxOzjuFEcDeyru4CicMKghWz/8zydesUJUZcSfgwjR+XR5A0g51u
         OI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+BcLlpDk/9sUi1mW7ItoMsyEGxbBfUs5C6tWkmglwsoICeHIEFeL01gqPXn2/viaieltgEDEh7C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+772GHYw52wpsO+j2gO4dgPf6SkFMyI/LiGLmwIUrW00vDwf
	NJOypxgue98MKTm4TyudSHRmTsLdDiXrFpJS+8VzKCAYMIstwpvTfkaNGOrOJbb26jWD7lbRQpM
	9EDQgu0FxEHrfrigSLFyiNe0QqxJjGAzS8R+dAm6jLg==
X-Gm-Gg: ASbGncvGsY0Axsr9EyMliEQYkD2PONEEscZFdekYVGDU/gGeRpxFRys0nmdnzwKYOBw
	0aWsAGVdXDpJ6601xMePaxc+zUIPxCtZlOqLfPuZogtfT06gtfafcDvG6hkZqw4sYKh4rV9Hs4U
	Adx04yfRAMLl/7yXkykho0UZoa2Nmekc/YwdXG13LZGkU6MyaWw811+S6Rb5f0+0rNTtMPcngBY
	pl0xrGkEwbiTqLm6RGyXvjLbkmIEP+BUiS5gU57/CWX88sDnH3dLS9EQqlOn1HRxhXQ/+2eT98M
	9HwI+EAdu3BZO8iTlvm7Aq5ZBu0=
X-Google-Smtp-Source: AGHT+IEGoO3fL0ecZ1AY8GUBLT25Sn8bHTlHf1SBOYk9VDf5XPqET34r8wc2V4tfWXPa8mxDUa00tpV4/1tvjo49G/Y=
X-Received: by 2002:a05:6512:31d3:b0:594:2654:5e3f with SMTP id
 2adb3069b0e04-5960382ed4bmr753172e87.12.1763545243378; Wed, 19 Nov 2025
 01:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org> <aR2OU4se7lxcMtGW@opensource.cirrus.com>
In-Reply-To: <aR2OU4se7lxcMtGW@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 10:40:30 +0100
X-Gm-Features: AWmQ_bmv6FTo3b-CGfQ-DjpMx9N6kq87b-YAvaUrmBKqhWvA5NQ7Ya0H7RtNhs0
Message-ID: <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 10:31=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Nov 19, 2025 at 10:10:24AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Currently the SPI driver sets up a software node rerefencing the GPIO
> > controller exposing the chip-select GPIO but this node never gets
> > attached to the actual GPIO provider. The lookup uses the weird way GPI=
O
> > core performs the software node lookup by the swnode's name. We want to
> > switch to a true firmware node lookup so the actual link must exist.
> > Move the configuration to the MFD core and connect the SPI and pinctrl
> > sub-devices with software node references.
> >
> > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirrus.=
com/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > Hi Charles!
> >
> > Please give this a try. It's only build-tested so far. I hope I
> > understood correctly that it's the SPI driver that needs the "cs" GPIO
> > from the pinctrl.
>
> Unfortunately it fails with an -EBUSY on adding the MFD children.
> I will investigate a little more and report back.
>

Does it fail in device_add_software_node() in MFD core? Is it possible
that the device already has a software node for some reason?

> > +static const struct software_node cs42l43_gpiochip_swnode =3D {
> > +     .name =3D "cs42l43-pinctrl",
> > +};
> > +
> > +static const struct property_entry cs42l43_cs_props[] =3D {
> > +     PROPERTY_ENTRY_GPIO("cs-gpios", &cs42l43_gpiochip_swnode, 0, GPIO=
_ACTIVE_LOW),
> > +     { }
> > +};
>
> This drops the undefined node, that is important as it lets the
> SPI core know that device is using an internal chip select rather
> than a GPIO.
>

I really dislike the whole concept of this undefined software node.
This driver is literally the only user and I'd love to just get rid of
it. HOW exactly does it let the driver know to use internal chip
select? Can we do it differently?

> > +static const struct software_node cs42l43_spi_swnode =3D {
> > +     .properties =3D cs42l43_cs_props,
> > +};
> > +
> >  static const struct mfd_cell cs42l43_devs[] =3D {
> > -     { .name =3D "cs42l43-pinctrl", },
> > -     { .name =3D "cs42l43-spi", },
> > +     {
> > +             .name =3D "cs42l43-pinctrl",
> > +             .swnode =3D &cs42l43_gpiochip_swnode,
> > +     },
> > +     {
> > +             .name =3D "cs42l43-spi",
> > +             .swnode =3D &cs42l43_spi_swnode,
>
> I will need to think about this a little more but I suspect this
> no longer being conditional on the magic ACPI properties could
> cause issues if a system was to use the SPI controller more
> traditionally and actually have CS GPIOs in the firmware.
> Although maybe that real node would take preference over the
> swnode?
>

The lookup goes to the primary firmware node first, it would typically
be DT or ACPI node. Then if no match, it will go to the secondary
node.

Bart

