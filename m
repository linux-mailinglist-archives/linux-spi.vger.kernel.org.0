Return-Path: <linux-spi+bounces-7296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E1A701F3
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 14:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66858188E793
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A42561D7;
	Tue, 25 Mar 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGJDrosw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6F255E30;
	Tue, 25 Mar 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907908; cv=none; b=Gfc9x3Wau4/6BMafLAbE3g31FWP1FG/87bca+97rDx8aRoXWhdHV3kZZmsftRBpwEX0Z1xvinkpgxQv7H1o91iA5bHGUdg+vgFH7xYxoHUA1tV7lr55WtCt/ZaNOnrrC9gq3qtkJw29/zNqyaoAualvNJF1AfA+a6bMdd/Dsr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907908; c=relaxed/simple;
	bh=0QDNLH+sxP46MeDJIJ6Ee8uPjmsLeUfxsIeVfFxSUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXx5KqN97IKJUBnBpdZkS9K+Q061jgZRFFFozea/8sPLm/12x/8mtA70zmwT5io3q360xpgj0FQfd/EMGNlBKPgPMIGZAtnXwmsLvwTxFqIrpbbus/1wiLDUVK+t+yYF2KnD6CM6qaNhFCJsYIHbi01pM48Qm31EgI7pVau4RFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGJDrosw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3965c995151so2773542f8f.1;
        Tue, 25 Mar 2025 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742907905; x=1743512705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yU5t16C8uLoiRoKoFedR2Elw3f8Z8Xmjk69RnHTg+I=;
        b=JGJDrosw3R5iArQZ10TOfjlkaUihMQCrLM17ndZ4IeUmAgglynu8639uuwBWzuFy6C
         I4M0iz71oG32s3c1BgoG+l0iALy160w5dZbRpu2FD0dN70sRwYOV8P4z2VeUzDDt9muO
         B2pFxxHzfdvNfa9q46ucUuAPmrf6oI0CxQh0A1L8JNkcRDgaevMKfLRodk8PSoaJu5ga
         MXRz+/rGlWKCiVvkvOy+dyIkSrol3YmlwG7s9wVdHpXwSdEyI5zD08R5d/X0P7kGwtgI
         UtLY7pxPOQ3nR20u/ki1CamIkK2ZG9NobhTa56UVctwNBj9Z3ju4fPhl2kb6C3f3hy0S
         xT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907905; x=1743512705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yU5t16C8uLoiRoKoFedR2Elw3f8Z8Xmjk69RnHTg+I=;
        b=KlzdypB2JYJHjatiePNW93zO5Wd5plqo2keKqhcP4Q87ScBXxQ930tMwGXBuaFdk8a
         0KjCc8rflteFMIkDstlzyuAADin4ztuELNArBaFCSBkxejbn/QUTRlJdJhrFgRWjmJ/N
         vF2ucFVfeMdQYnGl2xSpjq0tZY8Lpe03U2PYor0qsT7Ct81hkL0VOZahz6L2Kv8tagA+
         /ohHANv7HMtH0yPZ8wiYA2zx+1JF/izanAnDSxFIfAtixxmAF/A3fbR+BmOGtt0F8ubF
         YCvH5e6C7hLVUg16tAptn0YmkaEFCXmLGRSRJ9wjENGU7KQUbOrefrq3uBEx0oBdYaWX
         34kw==
X-Forwarded-Encrypted: i=1; AJvYcCUgDzRePzLq/mQzpUoKxOh1ZO9Xl3xGpLSOxO7fCISlwIlhJ8KUc1Zw7+C6IBL9MWYSml5n960/4ymT@vger.kernel.org, AJvYcCVRgDVwM92p+XjeBN9QL2zuAgj+H6vxVSysjB8xrdjZffFtSBv+yd/zSsaYbddhs+4FOFfh3fYP90XW@vger.kernel.org, AJvYcCVRnjqUvRt6BgVINva/wXd2kf404nmaoQ1lJnQCDZIHwpP/+G1Q9v7/+vi+VoA0XZSe8V1JdiqWsq+faWU=@vger.kernel.org, AJvYcCWALWKqgh8lbnE+Y1nn6Uu27MBTUHU7sCwyRLEN41SlrkQpUVIsfnOvZ0RncjxwLTpcFu8kkZBp13gFdJJJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ps+4SMsrA3FBzHfBt0ewsdkpNMqpIi/7S723qmVRWhRDcq1h
	GIrwzYRVhDIIAZO5Yb/WqPA9usme72C1RFE/HtyJ3q+9RnMbvrgmbForlg==
X-Gm-Gg: ASbGncs4l5r7ttP8ITr6r8wGRV1r5kUblEMgIkeVlLkJprkTrkBPS0PlsCYwW0xlP4z
	S1+agDPxia4SK3BTD/j8nXRaaTrVDiSPo+vJZ/IBTMCTEzaRujY723pWlMI8Q7GNidThsV8LtUM
	IdaXE/6emWLb4yNSYr91b/4x3Cra9LhyQLSMGcFWeBH69B49mt9poHBkJUs7EJ9fVoPY4j47CZN
	U/qi3IKm/RLtF1rr8WMr0ynM0czrpK7ZvcVLBzYpgbQp0hNpv9bqs2nxmewgXOotnBpJLXBVh/N
	qjOqiykzMb92ykcmuETYk5aGlVf3Ba+PyfJnBDYUV3ToTc6k+NuU3z/c0DeHb4F3D2cFhE2VJAF
	RWJb1M91RRRs9tGVIRCkAJEBrH0Jve4SrgQBfo4wIvQ==
X-Google-Smtp-Source: AGHT+IEGibM2+7Y+vK26boa3HLWMCcHmOw8sIojyepErpqcBPUsXp1BRlA/IoTuMQ88eEqX9dJSSyA==
X-Received: by 2002:a05:6000:1ace:b0:39a:ca59:a626 with SMTP id ffacd0b85a97d-39aca59a880mr1323556f8f.28.1742907904343;
        Tue, 25 Mar 2025 06:05:04 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5b8dsm13887347f8f.59.2025.03.25.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:05:03 -0700 (PDT)
Date: Tue, 25 Mar 2025 14:05:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kx5s7u4cc743aks2"
Content-Disposition: inline
In-Reply-To: <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>


--kx5s7u4cc743aks2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 01:45:26PM +0100, Thierry Reding wrote:
> On Tue, Mar 25, 2025 at 12:10:19PM +0000, Mark Brown wrote:
> > On Tue, Mar 25, 2025 at 10:36:29AM +0000, Jon Hunter wrote:
> > > On 27/11/2024 17:31, Mark Brown wrote:
> >=20
> > > > You can put 'spidev' in as the compatible and get the warning, we d=
on't
> > > > require specific compatibles if the Linux device ID is good enough.=
  If
> > > > you genuinely just have bare wires you're probably able to cope wit=
h the
> > > > warning.  If something is actually connected you should use the
> > > > compatible for whatever that is, if spidev makes sense for it then
> > > > that'd be OK to add to spidev.
> >=20
> > > We finally got back to this. Looks like just having 'spidev' as the
> > > compatible does not work. Apparently, it use to work and yes you woul=
d get
> > > the warning, but that no longer seems to be the case. I see a few oth=
ers
> > > have been doing similar things and hacking their device-trees in diff=
erent
> > > ways [0].
> >=20
> > Huh, OK.  I don't recall any deliberate SPI change for that.
>=20
> People in the discussion that Jon linked to indicated that it was this
> patch that caused the "regression":
>=20
> commit 6840615f85f6046039ebc4989870ddb12892b7fc
> Author: Mark Brown <broonie@kernel.org>
> Date:   Thu Sep 23 18:00:23 2021 +0100
>     spi: spidev: Add SPI ID table
>    =20
>     Currently autoloading for SPI devices does not use the DT ID table, i=
t uses
>     SPI modalises. Supporting OF modalises is going to be difficult if not
>     impractical, an attempt was made but has been reverted, so ensure that
>     module autoloading works for this driver by adding an id_table listin=
g the
>     SPI IDs for everything.
>    =20
>     Fixes: 96c8395e2166 ("spi: Revert modalias changes")
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>     Link: https://lore.kernel.org/r/20210923170023.1683-1-broonie@kernel.=
org
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>=20
> If you say that the regression wasn't deliberate, maybe we should look
> at fixing this so that people don't have to work around stuff?

Hm... there's also this:

commit f6f6a6320eeeb3e80e1393f727f898f8ca976bfd
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Fri Nov 19 13:11:39 2021 +0100
    spi: docs: improve the SPI userspace API documentation

    This doc is fairly outdated and only uses legacy device instantiation
    terminology. Let us update it and also mention the OF and ACPI device
    tables, to make easier for users to figure out how should be defined.

    Also, mention that devices bind could be done in user-space now using
    the "driver_override" sysfs entry.

    Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
    Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
    Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
    Link: https://lore.kernel.org/r/20211119121139.2412761-1-javierm@redhat=
=2Ecom
    Signed-off-by: Mark Brown <broonie@kernel.org>

That explicitly says that the linux,spidev or spidev compatible strings
are no longer supported, but also mentions the sysfs interface to bind
spidev to a given device.

Jon, I take it that the current sysfs is not enough for our use-case
because it only works if a device is predefined (i.e. the sysfs doesn't
allow specifying the chipselect)? Maybe we could enhance sysfs to allow
adding a generic spidev client, similar to how other busses (USB, PCI, I
think) allow using configfs to create these devices at runtime.

I2C has a different mechanism that could perhaps be used to achieve
something similar, except that it exposes each controller as a device
with a set of defined IOCTLs. That would be another option, but given
that there's already a spidev interface that doesn't seem like a good
fit for SPI.

Mark, would another alternative be to add something like a sysfs export
attribute? Something that you'd write a controller/chipselect pair to in
order to create a spidev device? That has the benefit of removing this
entirely from device tree where it doesn't belong, but still makes this
option available to users that would otherwise have to resort to hacks.

Thierry

--kx5s7u4cc743aks2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfiqfkACgkQ3SOs138+
s6EawRAAj60yE1rshoLP+65u+7bXPy/2DmRFZEdjQwZI6tRDlkqdRYLg8kRCeJ0n
4DzJggKQZ8dM9g3laEatxJv0z6zNrlUkmy3oVnpi7Xl9mHMPhEDtV9NLFpo8uFT6
IE91gzWjmkG/uEqxIR+J4/eOY1+dc6aeqIjdc6UgQYPAorTmpAJT/ji94Km79md3
sauNqDAw4ZLZd//owuSBHdiVDhHMnH3bptNWwNKPg2RaDzKlJSNixdz/mSIUNjBV
ke8bbIuZyZHkpDEmlZ1CJjQq1mnPgwvuMA8S/O5A0P+KRvo2gNaPgqJjikYveZE+
AN9ZqAqXggEkBGqIwjXotARcrBO7ag5Z25rpidd9Wnip3JCR97D8eFBPD5bVDArT
k4006AhzWmHyM5WbnC8w9nHMxL0cVKwP+PcgChd45f11IT01NFikDhr4fsp+390j
RfYZWVcvg4rUJKqNXE9VtfcDs5SC7afj65/6BwVXkLjB3BsPofIn5SD3QrgtPh+S
UkuTMAI74u3jIq/oe3EJlNUSCv+O/rlyEaR0Ju/TzsU7tW6d5WIhmFHLCtKkHL3u
wWILU5qt33M3n+3ZYsDmsx7BEnksbMbFtC1eiCbhyyingVl1gGvb8EJqpLHXw7aY
Boug7cWxIv6wxWvFO7w3Cn0+ALu+hgxl8gICT3scZpYPAXvfR/c=
=cr0m
-----END PGP SIGNATURE-----

--kx5s7u4cc743aks2--

