Return-Path: <linux-spi+bounces-2311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7738A16A8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F63B22DD6
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028714EC53;
	Thu, 11 Apr 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxJ1Rgqa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391814E2F6;
	Thu, 11 Apr 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844314; cv=none; b=HpaFkwdGEouyynyBuzj5levJc7ZZ5E5y3m/IJKxUXSsioLlhqOZCb4vxkekUZm1fayzDRDkQk/5EpkhPbSqhcFdWbbARWIuxUNXSgus6QINut4ovKl4n7Lf6gziIUywQh6YxelBakHAzgcsiv0rlXLUuoo/ne7BsIPmGKnK0Ovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844314; c=relaxed/simple;
	bh=9hXbqyB4jg2/DiQ561L5PV9NuzfwVfJtmYrBjhk6Loc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgDm0i2oYViUqjfCLz2TIkdW0mSJzlfHEpUvIS7QeJ+nd7OcUeA/P1AEnmq8oOnxiHzRmlbBm336opWAsOy8wPo224EZponwvJPcfpmp9v4mnguqfBj3zyNJyth9dixrwrYUBMZ0sbvlBAcR7GTUW5osSGhKyjiJcc36xZJFp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxJ1Rgqa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a1c8d931so780409566b.0;
        Thu, 11 Apr 2024 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712844311; x=1713449111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMr2RdfaMHtCzd9z6n6a/XuN5kSoHB3m4+8tIANDQOQ=;
        b=AxJ1RgqawAEvQRgRx8h0LiIjrcccoY8ER9pgKUJB21WRiPvEKX170qtIJk1rysk/yq
         TAMRiZtkYAdkCGysOTXLJm1nB7MKL4SZvWlXwUX88Appd/U4w3LrS5D+NHSjIZsYRkBq
         Q3sdpYXxq0rxYtMZf+IrkrbcCz/YFd7+WAoYCKMsbZe5qSODALx06aXZGYevr1Fh1IAs
         bnlAkpEjq2ynAnnCpReQ/i64sAItW3Uwn7hR8h91rIk2NUa+blJzgqnlsV7PUlnmWocE
         eg4eA84t7l3awUBUcmVpYsFmkQLkuiTUP4Y0eCaUd6+4f4QTo/1KHTfOzK2N9qI/LNh2
         sw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844311; x=1713449111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMr2RdfaMHtCzd9z6n6a/XuN5kSoHB3m4+8tIANDQOQ=;
        b=plPL/BfDYunlu+o5ahzyf9TkQYh9CWAb4HohbdcCa4ZR3xSLm/Fvli+F+xkPqTHjEB
         9rOG1f2Pz33HsVQDYzArBd71awgj/mFVajpMreh7rMaGBIWRAH1ndQy6n5P9mihLQGFc
         y/v9vKDkE56H7t+Q9Oq4Yf9lGzKNSIQXS9mJEOtlFjA2y6n7tAfl8cnuH7i6OcqVPkfW
         jCuDqdjnyGhbtlGMexUkGL53+oSL/Dal54xMs6A3iYeL9IuuTX2jPo/U5lBcxGmEQ1Hb
         qLbSlcmUhvU60UGcbU5ZdWc3Tj+3IzRD9SjvsHo7ocqpiWG/XYTDEV9LN3oksluIPWpE
         rKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx45IgOoGh1QON5pIbbYkgqQRr/UuJDzIoBNguxgfXaSmewbn9ziOiqFO3SbgOxHcMIDBv+kaWgK6t9zkSNpIM9XZ+/ZZ9V/NeV8Ex8dVRWPdU5ogqUQ7STEfQzHkslxfJ60OETA==
X-Gm-Message-State: AOJu0Yy55Ap4A7yTRpxWKspK9qGRRhOyDjWrTN2h6ObZgw3MATaQpRd+
	NqseM5NCRdWWwXtMkaXVveMswQYFY4m9/4tEJFP4IBL5nVI94MMNW0DZ78rEoCQrCgz3pVD/KdI
	7hCpvUkgApbp088dZMIuL/Wo9pQu2+1RgXnQ=
X-Google-Smtp-Source: AGHT+IGtA7p8xwDiVp15r0e1pAZdVymjz9sBTuUKRdb3O0LaUqjpr9iuF91dQoPUQBSxoN1QkZyzeXiFdCf5i7Unt9c=
X-Received: by 2002:a17:907:7249:b0:a52:1770:965 with SMTP id
 ds9-20020a170907724900b00a5217700965mr2942806ejc.42.1712844310448; Thu, 11
 Apr 2024 07:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com> <20240411090628.2436389-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240411090628.2436389-5-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 17:04:33 +0300
Message-ID: <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
>
> On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually.
>
> Check for the presence of the "01fa-cirrus-sidecar-instances" property
> in the SDCA extension unit's ACPI properties to confirm the presence
> of these two amplifiers and if they exist add them manually onto the
> SPI bus.

...

> +static const struct software_node ampl =3D {
> +       .name                   =3D "cs35l56-left",
> +};
> +
> +static const struct software_node ampr =3D {
> +       .name                   =3D "cs35l56-right",
> +};

Still I fail to see how these are used. They provide just a static
swnode with name and no properties. How is that different from the
no-fwnode case? Can you test without these being defined?

...

> +static const struct software_node cs42l43_gpiochip_swnode =3D {
> +       .name                   =3D "cs42l43-pinctrl",
> +};

On the contrary I understand this one (however, using that generic
name prevents more than one or two drivers from being instantiated).

...

> +       SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),

gpio/property.h for this one.

...

> +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> +{
> +       static const u32 func_smart_amp =3D 0x1;
> +       struct fwnode_handle *child_fwnode, *ext_fwnode;
> +       unsigned int val;
> +       u32 function;
> +       int ret;
> +
> +       fwnode_for_each_child_node(fwnode, child_fwnode) {
> +               acpi_handle handle =3D ACPI_HANDLE_FWNODE(child_fwnode);

> +               if (!handle)
> +                       continue;

This is _almost_ redundant check. handle =3D=3D NULL is for the global
root object which quite unlikely will have the _ADR method. The
specification is clear about this: "The _ADR object is valid only
within an Augmented Device Descriptor." That said, the check makes
sense against the (very) ill-formed DSDT.

> +               ret =3D acpi_get_local_address(handle, &function);
> +               if (ret || function !=3D func_smart_amp)
> +                       continue;
> +
> +               ext_fwnode =3D fwnode_get_named_child_node(child_fwnode,
> +                               "mipi-sdca-function-expansion-subproperti=
es");
> +               if (!ext_fwnode)
> +                       continue;
> +
> +               ret =3D fwnode_property_read_u32(ext_fwnode,
> +                                              "01fa-cirrus-sidecar-insta=
nces",
> +                                              &val);
> +
> +               fwnode_handle_put(ext_fwnode);
> +               fwnode_handle_put(child_fwnode);
> +
> +               if (!ret)
> +                       return !!val;
> +       }
> +
> +       return false;
> +}

...

> +       if (has_sidecar) {
> +               ret =3D software_node_register(&cs42l43_gpiochip_swnode);
> +               if (ret) {
> +                       return dev_err_probe(priv->dev, ret,
> +                                            "Failed to register gpio swn=
ode\n");
> +               }
> +
> +               ret =3D device_create_managed_software_node(&priv->ctlr->=
dev,
> +                                                         cs42l43_cs_prop=
s, NULL);
> +               if (ret) {
> +                       dev_err_probe(priv->dev, ret, "Failed to add swno=
de\n");
> +                       goto err;
> +               }

Wouldn't it miss the parent fwnode? I mean that you might probably
need to call...

> +       } else {
> +               device_set_node(&priv->ctlr->dev, fwnode);

...this one always. Have you checked it? How does sysfs look like
before and after this change on the device in question?

> +       }

--=20
With Best Regards,
Andy Shevchenko

