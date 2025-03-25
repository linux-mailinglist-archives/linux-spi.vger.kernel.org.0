Return-Path: <linux-spi+bounces-7300-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1805A70728
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A191696F6
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79225D8EC;
	Tue, 25 Mar 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMDm25ca"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC91804A;
	Tue, 25 Mar 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920745; cv=none; b=O2JlbocwzjpSX4ezutYVk6BNth7aXXS5ScH8BbLl5p6UGLIFtrn4KumWygKnc0UD7UStUBaHX783RZSPNPGG3yD+Y7z5t++//SyrZUs6cqmtrHbE9hc87B5iAz84imULW/17UumfGr5VIUGuvIm53k3TL3BRtwgm5COsJaghoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920745; c=relaxed/simple;
	bh=O67uqwz41bvTsQ/w+4Qr+fkUTt3Ccki+7Xra6I2mles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOuriuHpDFW4BXPSt05UQ0zSaDaXQAIhH8DTEXeFPhSmeYjhPmYn+/+HiZZBY2RV9aWo2jNLqtIC9HP6iP+HqEpS2g9bZf23Sb5ACqgPWdJlC/pl00Fq/x5HTpL9qLaPD4MvV+Yf5pzOWYZ4FeX+33UBVx9FZAQf7FxFTGe+7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMDm25ca; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so3333308f8f.2;
        Tue, 25 Mar 2025 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742920742; x=1743525542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMJ41FyYD/4c0fD9f5Z2RaP+F8M+llDgF+i5jY4Lt6g=;
        b=JMDm25ca5JYVN/t3oV2KOZcNw1TU/rnICHc+oriMM9HZv1Oo5cGaHbEJDGKHh+ziW1
         oN2HOaJJOrmlv4L5Hak8Po35cnkyU9eII8MwezGtAaMCM6KJJ7KNHbYevd7FOspPi6z2
         e0vdNmtYlDndsv/45l54XGhxhY4WwzBoOMeZ3nSMFznWKzAoIb7WxBkd7cTT3PxJ/xSv
         g6moGXZFY1Q8NeIv74bRFKx8bRVd1t+upQ3TV9i4qSCWrhNkeSTWPyDjruHmEWT5kHuK
         /BkZPPDrXftHysswxAW7Tq4iXAIhYwY2+JQDoFtYiVOi6lEr/OazyDUinX5SwMsI/CvG
         JZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920742; x=1743525542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMJ41FyYD/4c0fD9f5Z2RaP+F8M+llDgF+i5jY4Lt6g=;
        b=cz2U8QJ59UkPQMwH624LbTKBObk28L4IUKwqBzX7+ZbumtrUxY1H8LUZmEnl0lNRJY
         EtZP6hVlXsEHqxqafKwGVMyzbJNNyF4ihAOiBN1GSo3lpHcrZ0Ut2S+Aj3R7d4rK/+lS
         JekM8fhmyYsiUUA+zdtdbGD2pksYsQZG9xpgsT5ud3K5idouphcgSxMnPfuKLfzXuQHW
         3Hrzf+PHPwMBx2XBkOszs60uOKS52kqerzxSwVJwyOYss02VJWUKxRCi5ojae6ZDSWKS
         S7UPozWO/jnJj8Xnz7yp1foMZ0xRxyt7Wt7ytMCPZJVr0/dz73HWFpaq0dHYOr3hRQ7G
         mWdg==
X-Forwarded-Encrypted: i=1; AJvYcCVDfIIZk9gsXNiq2jCemvgN8sG01BxGgPk3i/Vd54oBa43+300xO3jUXNKIuKOHFlNR3dQzS2h12So33Je0@vger.kernel.org, AJvYcCWAugr/tPuql14AIMOVyz4gVVjPu5ZdUItARWs1uDLgeTxUatWhBwtuV+NMg6wCZYvLjxnpXIKStzKG@vger.kernel.org, AJvYcCXotHrkKeClSEEeHUUwm9q9IkEcD5VH5Kr71Evy+M9vXh+7HGAbG3Pbs6PgZ/v6//83B7Gffu9ueQrd@vger.kernel.org, AJvYcCXv4p5kGX2+EtFOwrHCx8izd4yxpR4Tj6Q0HZVRg+QQ+3lJ4yCDqg26mcZsgEGmcUVyuQU85AYqVOCQpyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkS2Vem790mgW3t+D6VuqEmk/5Bajm//ttyuDcHcQVFs4PrB8v
	M4bOTLg4qpYJiT+OAYFDiCB1XUhlLm8FBcSEoWS1VVUVVtNbj7uE
X-Gm-Gg: ASbGnctaTYpRkX5trC9Fr3/DEWyLvuuNmmjTWcA0W+fcfvaG9OmthH5KaYA5985Qo8d
	9kDkhYnkAJ6B56v9mDtkMWtMIXE2p8/QYqo286P483plOlemVdcAROrkai8mcdtF0XcSbOku8LY
	NTG1DoqQT4olK6HKr8zFiK/By7q8gdpNvlq/wnLtWCudRbxJ8VLff9LiZC5Rx3PLcl1WxKJaIO+
	vEUjiUXxtSHqysblulBvyGhT8D5/7ANDXX+gqeQvaTnGqri/rZ0VfOZL8Oa1ZDbZryiaG7ZcE2u
	T5RUJNF81Cy9YVTN/jrLhvN7zVN9IG1Z/gO9fLrOj6OE6ncWmteXyYcOffUGWc1JteB+Ht4t60a
	qeVoKJCleEJwrrQ+YbPT5g0xX2ndXaJY=
X-Google-Smtp-Source: AGHT+IFVcCVJnTUXEut1ikW+C/l8Yj7wjuU/SW5HUBXClt3SPKkvCUFZteQaJFfyIcYXYM+q1IOLGA==
X-Received: by 2002:a05:6000:2cd:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-3997f92d09bmr14701614f8f.42.1742920740989;
        Tue, 25 Mar 2025 09:39:00 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef063sm13932843f8f.83.2025.03.25.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:38:59 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:38:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vishwaroop A <va@nvidia.com>, 
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
References: <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zmryrux2zh7gaduh"
Content-Disposition: inline
In-Reply-To: <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>


--zmryrux2zh7gaduh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 03:55:02PM +0000, Mark Brown wrote:
> On Tue, Mar 25, 2025 at 02:05:01PM +0100, Thierry Reding wrote:
>=20
> > Mark, would another alternative be to add something like a sysfs export
> > attribute? Something that you'd write a controller/chipselect pair to in
> > order to create a spidev device? That has the benefit of removing this
> > entirely from device tree where it doesn't belong, but still makes this
> > option available to users that would otherwise have to resort to hacks.
>=20
> Possibly?  I think I've lost track of what the use case is here, usually
> for the spidev stuff DT overlays seem like they're the right thing but
> perhaps this is different?  If we are doing this at runtime sysfs seems
> like a reasonable way to trigger it, though you'd still need the DT to
> describe the controller and the chipselects that are available.

Heh... it's exactly the opposite for me. I feel like I don't understand
the need for spidev with a specific compatible string. If you've got a
compatible string (or in other words you have a device with a very
specific SPI chip connected), then why would you want to access it from
userspace? Isn't a proper kernel driver the better option in most cases?
That usually allows for better abstraction via some other subsystem. I
suppose there are cases where there may not be a subsystem, or for other
reasons it's more convenient to have direct access from userspace to
avoid the roundtrip. Or maybe users could be concerned about safety?

I think the more common use-case is for things like these semi-standard
expansion headers you see on embedded devices that expose things like
GPIOs, I2C and SPI pins. In some cases users might end up installing
off-the-shelf expansion boards and they will be happy to add device tree
overlays to add whatever is available on that board. Again, for these I
suspect a kernel driver matching on that compatible string is more
appropriate.

In other cases users may just want to connect something completely
custom or just have a way to poke whatever they connect. There may not
be a proper driver for it. Or it could perhaps even be used temporarily
as a way to write a userspace driver conveniently before porting it to
Linux.

The way I imagine it, exporting would involve writing a chip-select to a
specific SPI controller's "export" sysfs attribute to have a SPI device
created for that particular chip-select and bind it to spidev.

Thierry

--zmryrux2zh7gaduh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfi3B4ACgkQ3SOs138+
s6ERQA//YX4iV9Xly1eAImPC0drzufKbcWTY0M5xNe8b9FO8Fz09aZRDIyGWPO9R
8c8EhbZqRXA3u/owvTNbPI4iA19Z1mxtrw/V8rEUv0WhFlETm7PIa5j57gLo8q8O
mvX0FXDJRCTTzCGzGeyz/D2jZ+VjsSjVvovY1qdOxyicRFva97b9C657GYP1dWsZ
bGWnS5CwDb+uHfI0Y6LRh5axKRfX+B4Ro7owIijYVhEVG8VrQutEO4kgoTo2x/9o
qHLgaWOWdP3jr1QbaqWr/WPylGO9Nnz5xDQLTPkbhFlKcp8EFdbXScwLjXR6u5oq
7a/ivRhmkpcauEvn2KUxgOXSjbWsoDxLwgJeOQ88PRS2KAnOHID5TWvVZvUuG+4e
qWbhyS2mxTmjtBzNx8chruI5LxCI0DXpAri3+r45P6D6Wc9h5YagcyuO6GOYnjDt
7ZMiWpsldlQr82/TC9qrgiFSORaiIWrd7CYxiwlFe2zPjnaci/UFFTrV40ewMA/g
fNzHsR2QLu7eoUPPhnrO81SI3zKmUilyPXofmp7Vw2lbMC5Bi6nDZw7YEsU/8jet
lzZ94gvu5FpCPWPLZ32QmnAx+mnwuYjxoPxCiNT6p+EuSPbh62oD7J2MzDXZmqDZ
w4DaLiZmfuUuA+0gmIfR/J+6kgSduxlBDG9Ml3GyZB5PSG0Nupk=
=pWS2
-----END PGP SIGNATURE-----

--zmryrux2zh7gaduh--

