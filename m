Return-Path: <linux-spi+bounces-7295-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E44A70196
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468D319A1266
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB2270EC7;
	Tue, 25 Mar 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdMZNpU1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6201B85FD;
	Tue, 25 Mar 2025 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906732; cv=none; b=hkqXrLgIuHpxdyNLDveiMHYg8tYrdlbv3JTwoDW0zgWx3xuKW7NxGE/lNPglH7S9Uk6udpU/Q9ObvcZ+l83TyCHjC16ZQIIYdKl/kv5m8xTpeoyBP+SjqWXrxHFsE6MWFeesTcQQbuXk+v51d13Px+p2iT+lmscY/VIuIFw3HDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906732; c=relaxed/simple;
	bh=etoP08AoKZtuZl84RAwLoOiSki62COEcAOZ7N/k0MIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+WitzP0WYENoUz96dDjO79Xz+z3X/vzsQy3nTbXLTjGvHsvLhBGk2XNwFo4OcW7zNiUXJD+HasZkzzdbRjkyTMUzsenoerYXm62pbcXVT8QBDzNDBrWqjODJhdu4LJZ6dIySWyaOe6L7PLR7P7VGJ5+0RuIPDBqVzrVrEHY8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdMZNpU1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so39525685e9.3;
        Tue, 25 Mar 2025 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742906729; x=1743511529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSa7I/akXEAX+WMr4yb3n8ucSGDNYu+Pa5yhxPlOXx0=;
        b=NdMZNpU1pw2VznRqMwq1+2KskrWQbIeBJkxIbF172aqHebfGtacCw5VlUhMxe4ho1R
         6xqzm/EQUMj+WoPF/owjud6R89g/vAIgJvA8JmSBAoCFlYCobNaDYFy8nXWj+68EaArO
         d8p276yQdE2fHzEQPgNMozu9SRc2P9+d/w2UsMREx0IpxRN7+mvjHZRuDvgglMsUx+op
         AlUAiYuFebrIDGrkTHik8KNS/MhIxc84qpYLR+VvvI70ucmpO4nmNoF3w0dpsfIYMhTq
         EVOBztfjizMZSmIq+wJ9o88dH4+gDDff3lT/7txaoeosoKes8zqco3Up5RvCI/Sn5OhU
         IDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742906729; x=1743511529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSa7I/akXEAX+WMr4yb3n8ucSGDNYu+Pa5yhxPlOXx0=;
        b=wyREASU3G+bPpbwaDhuU3Q8PoZypx/CynE1pY9znBSphndTmEKqJhM9AhCSlDcACvF
         RVNxAPam9iNCwfMjypAux7jEYUIvZVfjQNHcn4T9GuIaMYEPBuIy9AjHmHly34oJLvXp
         5is0RiTIM4PvwKVrSIYpd/Gq0mQxRnKopW1iM79MZP+WbDrebaNWObpcLrWVyvWwCqar
         kn3jlotPdj6J2BTgDP8CR6huBDsaLEWoG77S7n8S86ivTPx4c5SQZTA9qgFGvOLi8qF5
         xAjuGaeWQH2Qv5Q7zi8kQ1MNzY3wGxhD/W5foAINVp/SspI30aSCv99PCVHPaNO6lfhv
         EOmw==
X-Forwarded-Encrypted: i=1; AJvYcCUkB3tJJc4Hm3mE44Km2E3fLeIqlc0NV1O156Spq51sz1IHIrjdL4S5tlNowQlZ3+WC0qHMo8emNuH1hws=@vger.kernel.org, AJvYcCWQmoLnZV4A+N6JwxDFuI8EmmLv7/9OF68iXymvpiZidP3rVqBnweIGaQAlNQtqJ1II3hv5PRq2jn/v@vger.kernel.org, AJvYcCXHZs3ct38panvDVW7p8D9pf6uRGnDgoNnmcKM46iNtm4m3J5T2ckWPtWdg50qtL9LMEyrQOWncHQiJ57WP@vger.kernel.org, AJvYcCXLHijQM+7I+qGpU/QKC9rNTSHW8RaFYwlg9uwGmk4KlKmbSbpKZkl9hzUDBFgcRuIbtoib0UcFQxkU@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnoqAD7F2vWUNZi8+Opd9HbTZmzF2+hON6KY9BaskyAuNy+jl
	Rzk4HC5DqF7Dw2tVn9kMPshFPVGs4YClqvpZmDUC2TM0zLUI8934
X-Gm-Gg: ASbGncs/BUOAAs9oWXm/IbhQrVGf0J3xWgLppTwVP6xPx4lBsWvs0LxSnhE8/uYwKo4
	6leCwGo3owr1A9e7L1UTa/8jY5PiruCYtodgwga3IqmrI5T06j17UnCaxlLIdu/40E4YOmxSABV
	taGSTKc9XoHzMKr/UFs+ci0aq2iKRd8a4/+EqgUD1I6DFCbP34gAGmA4Y2R4tvRLnep5MvbB53Y
	x2ex0PQUV64v8eQvquh9CmH9zru1DR3M5LjiO7mTRZuzqbj92ix4UO8BgvbTVR8pL2t5xtgUoXw
	is/xrJ4pObMNP0jh8XeNqQcUJgG01z41d787eVFCfI8y8GU8jnL4YKgTxtJuYWcULoeCOMyaqC4
	P6m2rRV9pc9TJS0dD4qczWZqXGBPdJ1VtCJO8n6pyCQ==
X-Google-Smtp-Source: AGHT+IFdARdk+/q7cuJYaSe5KqZD7COsq6XvV6kr3Ih+IpEeyty+QcYuulDT663rN+ubH6y7PNuClg==
X-Received: by 2002:a05:600c:1d8f:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43d509f44f2mr176018735e9.16.1742906729241;
        Tue, 25 Mar 2025 05:45:29 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd0a9sm151377025e9.38.2025.03.25.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:45:28 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:45:26 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vishwaroop A <va@nvidia.com>, 
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juqd7brllbpcvgf2"
Content-Disposition: inline
In-Reply-To: <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>


--juqd7brllbpcvgf2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 12:10:19PM +0000, Mark Brown wrote:
> On Tue, Mar 25, 2025 at 10:36:29AM +0000, Jon Hunter wrote:
> > On 27/11/2024 17:31, Mark Brown wrote:
>=20
> > > You can put 'spidev' in as the compatible and get the warning, we don=
't
> > > require specific compatibles if the Linux device ID is good enough.  =
If
> > > you genuinely just have bare wires you're probably able to cope with =
the
> > > warning.  If something is actually connected you should use the
> > > compatible for whatever that is, if spidev makes sense for it then
> > > that'd be OK to add to spidev.
>=20
> > We finally got back to this. Looks like just having 'spidev' as the
> > compatible does not work. Apparently, it use to work and yes you would =
get
> > the warning, but that no longer seems to be the case. I see a few others
> > have been doing similar things and hacking their device-trees in differ=
ent
> > ways [0].
>=20
> Huh, OK.  I don't recall any deliberate SPI change for that.

People in the discussion that Jon linked to indicated that it was this
patch that caused the "regression":

commit 6840615f85f6046039ebc4989870ddb12892b7fc
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Sep 23 18:00:23 2021 +0100
    spi: spidev: Add SPI ID table
   =20
    Currently autoloading for SPI devices does not use the DT ID table, it =
uses
    SPI modalises. Supporting OF modalises is going to be difficult if not
    impractical, an attempt was made but has been reverted, so ensure that
    module autoloading works for this driver by adding an id_table listing =
the
    SPI IDs for everything.
   =20
    Fixes: 96c8395e2166 ("spi: Revert modalias changes")
    Signed-off-by: Mark Brown <broonie@kernel.org>
    Link: https://lore.kernel.org/r/20210923170023.1683-1-broonie@kernel.org
    Signed-off-by: Mark Brown <broonie@kernel.org>

If you say that the regression wasn't deliberate, maybe we should look
at fixing this so that people don't have to work around stuff?

Thierry

--juqd7brllbpcvgf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfipWIACgkQ3SOs138+
s6EEeRAAvrnIRjGZ4twQvpRENci9TEsWE7Q8l9qO4bVt2DlFaAD9AtKmLPkay7Gb
GKV+MbGhtg0v2x2Xjmh/p/XN8vw1xE2Zb7TvwZUEHfq8ILvkLeTXszIIgNcLGzu5
NuQKT9Nu3IXQm/79t4FeFr8xroQwVpj9t3w9sZMi29fxC5GMzKnXzAM0Pji/8efr
V6n7lSl6Jg8Nj3rn0vAubMlSnXT/2/YrEFQ6zcUUJnNQD6NO/oWNF/KDrg9Vi1S4
7E6FuT05edRhODgRogOFpn0FWbPIaqEcGz/5asck04du5IhZ+54iwSNcjQ/aoi19
99sNQCOLK99QwbfA0eigeZiBrbhfkTdQNFxWPgUP4PWeofoC2zYd5KF8RPhgS0Vq
9mRSkHl1R6npGLBXFVxKj4H4DjaYPXtbNYvz7hT4so2iSXv9FL3bRGvKpJs+51Mh
Kgp/17DUK9TtauU75m+09fVshB0mJXHZaKbhU2bqKbdonQYSla3soWyGZ+YwjyIH
YHZaxTCxF/OVVmSqUDTKEOIFsOf+8lx28aOWBxlBvYjmlnqpimbTgHCa0Kd2m/eW
o7IUC5ButbfbLNwPmowFGv8Msg9xfVZrSIotvMq5exucMi42PYPbSedGVCqnNP3N
EfjsQGFCE1ldOE13Bm1AB3cWr/k9Ak8WFErUuXUecisivAgFAvI=
=/BYC
-----END PGP SIGNATURE-----

--juqd7brllbpcvgf2--

