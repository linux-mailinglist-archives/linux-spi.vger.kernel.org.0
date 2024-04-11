Return-Path: <linux-spi+bounces-2323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD28A1EA0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27521C23C67
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5754DEAF0;
	Thu, 11 Apr 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbxiMSuH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720B205E0F;
	Thu, 11 Apr 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859513; cv=none; b=l4O64UsihQrP7fbInaepcyeE194AkEVtQNVbfkvyWqzC1Q3eTHxY0jtLZAkJVVPXow8m7+fZjsltYiAy5OldgrRjMY8XsS4Pgy+9FC/ZhcPFYBtD8SDdPoLuqPeEK7Mkc10gj1H192vKEnSxHo60Zv5lM12uIGhjeoMt2frKz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859513; c=relaxed/simple;
	bh=DWz6ds98XTZXl/dyA7I6CROSsCsX1bFa0bV37znMc54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDR9c9AXfOdiDN0hZ64jPaN9TE1VvnRj3a3/l9KVpsPBhmGZ0pSO2OEzw1trYLZVHLxbTg/Y8fv/G2np64fFDR6SAJ+Eh27xaiwTwXwWmgv6k72mHsNUzHKMIDvEosjeeKuy0zyx6bPosNzJAUhn3WV6RAM4bvhhRx0qtB4Hsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbxiMSuH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so19272966b.1;
        Thu, 11 Apr 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712859510; x=1713464310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqk+5lHIDKGZlCZPAJEZ/csAmxJLvYum3JkMyziXAlQ=;
        b=EbxiMSuHYXDJ9zjx2zXUS2j23UT3H62pwxyoZCyghvdQZpv3wS/SRpaKGgk8tD4E0q
         uQx/JuYmTVsnEcN6OmblABdmgNQ90JpMWJN8hE9uQQzEBs7Y7L0OiWLHnN/d6UlATSF2
         fTvz67IEJjCgVFkAOegJFxW12bDr2GtgTYkjiAo+FxLzTy71pHi8V0W49SnZeqYV0m5F
         dnKfNe9IiiMGvWtkFc77Nga8ACpfTqPhaOBiiTWOoogbhYIALyO3VMNZJ5Ab0pGDeM9z
         6PFLey/ZjgmEG1A5XeVlgQpv+KVldVz1g9MHhK4OTlfqPtyi4KRoPshMSVMZimuh+5Av
         0wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859510; x=1713464310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqk+5lHIDKGZlCZPAJEZ/csAmxJLvYum3JkMyziXAlQ=;
        b=L4dYPcQbPwzzA4lhpnj4dIlzP9X5rleC+c8vYetJP+Og/AbusxIR3T23REjh/ygFNP
         R6mOKkmaxOAxLGarHYtjsUnsLgPLC2meUDjpTz/NRjAmAdUjxdCJqgAr+kdzTf/AQvRu
         ozcfENg2i4JvSqOhjN65KxiDvE9nmfmkOn2yUPzxFucEbKpCiA5jaJNcVIWmQHc1vsUw
         5xBdcPpyWNCKy7V69Ew+D84SPRh7RkXpsvNHTt3oUyK29DKIQh0Vc4s/eEykZSd+i3oc
         HTt5rl119+D0a3jP+ZN5z/61rmkBEMQ/HbMv1zotZbB43WeCbc6ZrPC4JoL61xJdVXF7
         1Clg==
X-Forwarded-Encrypted: i=1; AJvYcCU6vcLvYJJAKAKdoBnthG1l9CBOO4MtOt9I0C7WcDzGddSgfk2IGeMzYTOxAWDccXNAo7cYt/qN6ks7ZJu4nR+h5ZmIXYert6+v6e4mjLIQW1Xr0l0aVV3VKboEt2vrXLwh1Gf6rA==
X-Gm-Message-State: AOJu0Ywq9A9SqyZJObMny5eHqJ7ldGt7DFtOx+P1Z1W6Vc0ie4WZqlOh
	18h2btsc423BheuaNuFqtCjB+3ESxExggi2zzupeNA0ITbjCCv5FH0LXb0TTrc5Kh9RaCKHqvNO
	staOZWRVJBmYIxaNC3z+3GNQKpJg=
X-Google-Smtp-Source: AGHT+IHXIUy8L84jzPJTOkXGhQgUvhdYF/X+G/ueaYKKffDqQeBdQIKdGW6LdvuVSymnu3jqZXtlw7awYUde864tHlg=
X-Received: by 2002:a17:907:2d2c:b0:a4f:b398:2f47 with SMTP id
 gs44-20020a1709072d2c00b00a4fb3982f47mr3394804ejc.25.1712859509855; Thu, 11
 Apr 2024 11:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-5-ckeepax@opensource.cirrus.com> <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
 <ZhgaK9vhtvy3/YpU@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhgaK9vhtvy3/YpU@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 21:17:53 +0300
Message-ID: <CAHp75Vc-f13sOghXkuqEVYsmnP3hT6ewLZwLr4mJJbruSqoxXw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:13=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Apr 11, 2024 at 05:04:33PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:

...

> > > +static const struct software_node ampl =3D {
> > > +       .name                   =3D "cs35l56-left",
> > > +};
> > > +
> > > +static const struct software_node ampr =3D {
> > > +       .name                   =3D "cs35l56-right",
> > > +};
> >
> > Still I fail to see how these are used. They provide just a static
> > swnode with name and no properties. How is that different from the
> > no-fwnode case? Can you test without these being defined?
>
> The code in the last patch will pick up the name and use it to
> name the amps that are registered. This means when those amps are
> referred to by the audio machine driver code we will know what
> they are called. Admittedly that audio machine driver change
> isn't in this series as it is a bit of a work in progress and not
> technically necessary for just registering the amps as this
> series does.

Thank you for the patience, now I realise how it's connected. But
wouldn't the simple spi-<SPI ID>-<bus number>.<chip select> work?
Thinking loudly: Probably not as bus number is dynamic nowadays,

...

> > > +static const struct software_node cs42l43_gpiochip_swnode =3D {
> > > +       .name                   =3D "cs42l43-pinctrl",
> > > +};
> >
> > On the contrary I understand this one (however, using that generic
> > name prevents more than one or two drivers from being instantiated).
>
> Yeah that might need to change in the future, however there is no
> obvious use-cases for using multiple cs42l43's in a single system
> so at the moment we are not doing the work to support that case.
> There are plenty other things that would need fixed to support
> that as well.

I see, just be aware that names for "root" swnodes must be globally
unique. Otherwise they will clash over sysfs folder namings.

...

> > > +       SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
> >
> > gpio/property.h for this one.
>
> Sorry, still not quite following this one, are you just reminding
> me to include the header when I move the swnode_gpio_undefined
> definition or are you asking for something more?

Yes, when you have moved the newly added exported variable there,
include itt in addition to gpio/consumer.h.

...

> > > +               acpi_handle handle =3D ACPI_HANDLE_FWNODE(child_fwnod=
e);
> >
> > > +               if (!handle)
> > > +                       continue;
> >
> > This is _almost_ redundant check. handle =3D=3D NULL is for the global
> > root object which quite unlikely will have the _ADR method. The
> > specification is clear about this: "The _ADR object is valid only
> > within an Augmented Device Descriptor." That said, the check makes
> > sense against the (very) ill-formed DSDT.
>
> I am willing to be guided here, but given it would result in a
> null pointer dereference I am inclined to keep the check
> personally.

There is no NULL pointer dereference. That's the point. And I
explained how ACPICA treats this.

...

> > > +       if (has_sidecar) {
> > > +               ret =3D software_node_register(&cs42l43_gpiochip_swno=
de);
> > > +               if (ret) {
> > > +                       return dev_err_probe(priv->dev, ret,
> > > +                                            "Failed to register gpio=
 swnode\n");
> > > +               }
> > > +
> > > +               ret =3D device_create_managed_software_node(&priv->ct=
lr->dev,
> > > +                                                         cs42l43_cs_=
props, NULL);
> > > +               if (ret) {
> > > +                       dev_err_probe(priv->dev, ret, "Failed to add =
swnode\n");
> > > +                       goto err;
> > > +               }
> >
> > Wouldn't it miss the parent fwnode? I mean that you might probably
> > need to call...
> >
> > > +       } else {
> > > +               device_set_node(&priv->ctlr->dev, fwnode);
> >
> > ...this one always. Have you checked it? How does sysfs look like
> > before and after this change on the device in question?
>
> I will check this.

Basically in the expected case there should be two symlinks: to
physical node and to swnode.

--=20
With Best Regards,
Andy Shevchenko

