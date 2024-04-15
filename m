Return-Path: <linux-spi+bounces-2347-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6D8A5700
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E101C224AC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E47F7D9;
	Mon, 15 Apr 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2k5xxXL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75C7F7C1;
	Mon, 15 Apr 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197044; cv=none; b=iGN5edCSGWva26gktTAGBe+A+Neo++1Mzy91aL4LpDTcMyjnASK8omLj7llV6kFgQqbu9jKwQiFlSL2wRSbAY1Vfv8MeafARCKU+WhuKYvt8AKw2NjHRM+rpo9kZACUq5pAVYwGSc9gbxITyPwUh+ZaBCO1YYUlw1wDLgQTU83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197044; c=relaxed/simple;
	bh=vKQQB/kQNxsfxqV52SjnDQrWdCTeXfpK2mB5tty3jPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq92g18OsZI0SUv2xN0dzJVPgMMKyQOSd3vNKYFXiY8L0z8tfFXNGUAPlCclA+Hg/cPQLN7GGIP8K0GbewjmQB6z/8dEjmpFnonwnGpdbqy23FZ4hXxfsrR76yEKlX3JavXjPybRQyfydB47Q7gmTQ0vG2Cn7sFNrZ19Nfx2ktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2k5xxXL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a526a200879so161136166b.1;
        Mon, 15 Apr 2024 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197038; x=1713801838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxrRX3hsv4yMm/yfYw+Q8TuTZyI8eHv3V8RiKJyvMrE=;
        b=S2k5xxXLR1ZflbeNC5Bj5TVcL7ZbndQYrfxHhR5EvbDEtl8QBTnQImE8FL2RUwtHBy
         rJWPXnX2B5kzcY5vOc5zonbwa/ToUIyWN9vDrniBdwz3ku2edlqg45jlu2JTwlIlzwzk
         d4yp9sRZYOQyrgDfm368GR67YnOE34s/bvOtUmds5O9DqJ84fzxRy6qYRxelnndOBjeN
         JBYU+7S2be8Dc3LxAXQB6/2wYX18ko3lsHysLFBiC99xEOFHUaSWlwO+n9L/bgTTQ4NM
         QqbyiNff4pPPDG2RSaufs9X5fsJiN9S8BF6V2tstj4Fn9D2xZuFR6S4jSbl4cZWsEDB+
         wJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197038; x=1713801838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxrRX3hsv4yMm/yfYw+Q8TuTZyI8eHv3V8RiKJyvMrE=;
        b=hRDXs1DFuciCwWeIeQco2d9/BC+TjYnMKZPOg5M6XJ9+8EMZaFyOKLt6ihUIM2SR81
         9y4wTon0sXB7dkt+G9z5TFUaNOHyWugD4YJXy4Ckr3wJoq3Bod3fDB5T+ep+hdN3476V
         i+oAJLLL6y+o6j/JPpZv7Kq9zgGF4JGG/Jr+gIMayAY1mrhlQB/K7/+Q4NI5/MZ0CJTt
         5OqGuHmds1XPSTlwIjWl+Sg7QKjYXLEFrxn70gayNnv2YxdngobjM7E+Qpn345xBMx/n
         y94VLqphZGMdxS0mcw2r8hZecK9gsVstjwmWb+leE/5M1BmAhD800Rh0MHhQWnBtz82r
         wHag==
X-Forwarded-Encrypted: i=1; AJvYcCU5JFIdObIbRPCgKnk/b0wUqgCaIa0kuJ9MwBIKHKSUGGzd+i4jS3M9T7b9wgdN75fvw62ONfPLAGkHsFa26x/n0JR1pPwvE17cKFWwDWzBN1qjaff9i9oVpc4tqxxKgqHIjulS3w==
X-Gm-Message-State: AOJu0YzPKTT1kht4uUPuKWtfELhl3aqKdljrph7KiaGUGDLmszCd6hsX
	UbqqPto/OB4yEi5tbNVQf813zWYLaxwNms9f8aelsG5Z9ZtHVFNr7Zv/t+GjIqrQpQcJosEHh6j
	Za5t+DgP6VcCE7pBS3OXLJoT9DPw=
X-Google-Smtp-Source: AGHT+IFqPWLUOtioPyFA+9Eq0kLdAP+RccNs7V2f/lcdodkfeqXLfwisGeyRHS5Z8KiI8LsDkzA6B1xMIlmHldBp2KA=
X-Received: by 2002:a17:906:6a1d:b0:a52:5230:b076 with SMTP id
 qw29-20020a1709066a1d00b00a525230b076mr5114005ejc.2.1713197037899; Mon, 15
 Apr 2024 09:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-5-ckeepax@opensource.cirrus.com> <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
 <ZhgaK9vhtvy3/YpU@ediswmail9.ad.cirrus.com> <CAHp75Vc-f13sOghXkuqEVYsmnP3hT6ewLZwLr4mJJbruSqoxXw@mail.gmail.com>
 <Zh0uH64AlEMJQyzz@ediswmail9.ad.cirrus.com>
In-Reply-To: <Zh0uH64AlEMJQyzz@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 19:03:20 +0300
Message-ID: <CAHp75Veqr290PKBNi+QhuSAR+_me+WXBSvYQSSrkpw-fTrV0zA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:39=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Apr 11, 2024 at 09:17:53PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 8:13=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Thu, Apr 11, 2024 at 05:04:33PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> > > > <ckeepax@opensource.cirrus.com> wrote:

...

> > > > > +               ret =3D software_node_register(&cs42l43_gpiochip_=
swnode);
> > > > > +               if (ret) {
> > > > > +                       return dev_err_probe(priv->dev, ret,
> > > > > +                                            "Failed to register =
gpio swnode\n");
> > > > > +               }
> > > > > +
> > > > > +               ret =3D device_create_managed_software_node(&priv=
->ctlr->dev,
> > > > > +                                                         cs42l43=
_cs_props, NULL);
> > > > > +               if (ret) {
> > > > > +                       dev_err_probe(priv->dev, ret, "Failed to =
add swnode\n");
> > > > > +                       goto err;
> > > > > +               }
> > > >
> > > > Wouldn't it miss the parent fwnode? I mean that you might probably
> > > > need to call...
>
> Ok I am pretty sure this is all fine,

But have you checked this?

> I don't think we can pass a
> parent into device_create_managed_software_node since it requires
> a parent software node, but in this case there isn't one. This is
> the root node here, since the "parent" would be ACPI stuff here.

No, this is done implicitly by so called primary and secondary fwnode.
If you have no fwnode is added to the device (via let's say
device_set_node() call), it most likely has no "primary" fwnode which
is usually points to the "physical" one (from ACPI or DT), while
secondary one will be pointing to swnode:

Ex.

# ls -ld /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/*_node
lrwxrwxrwx    1 root     root             0 Jan  1 00:01
/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/firmwar
e_node -> ../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:08
lrwxrwxrwx    1 root     root             0 Jan  1 00:01
/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/softwar
e_node -> ../../../../kernel/software_nodes/node0

> > > > > +       } else {
> > > > > +               device_set_node(&priv->ctlr->dev, fwnode);
> > > >
> > > > ...this one always. Have you checked it? How does sysfs look like
> > > > before and after this change on the device in question?
> > >
> > > I will check this.
>
> We can't always call device_set_node. Firstly, we would need to
> set it to the software node, however that is never returned from
> device_create_managed_software_node. Secondly, the set_secondary_node
> called in device_create_managed_software_node will set the primary
> node anyway since there isn't a valid primary node on the device.

That was basically my question above. If the device has a primary
fwnode (or one shared with a parent) it would be nice to propagate it.
OTOH it might have a side effect of using properties from that in the
code.

> Finally, we don't want the primary node set to the ACPI node anyway
> since we want to override those settings here with our bridged amp
> settings.
>
> > Basically in the expected case there should be two symlinks: to
> > physical node and to swnode.

> I think the sysfs all looks reasonable to me, I can see the SPI
> devices in /sys/bus/spi/devices, under those devices I can see a
> symlink to the software node.

OK.


--
With Best Regards,
Andy Shevchenko

