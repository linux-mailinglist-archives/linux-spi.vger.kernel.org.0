Return-Path: <linux-spi+bounces-6110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1749F6C31
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF34C16D2E7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97691AA1DC;
	Wed, 18 Dec 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JcpQ5VQi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CF1F2C4C
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542277; cv=none; b=YNoyqpcVIyflE7zqpI1zGCG7ENDA/5xanC96mMU46Op4RbIelWsrAB4XZ3hy041TQC12sboPs7DyzS7pk9CZG1QxRbh06tonAOknsrp2nSbFT2kOiZ09/7GHBj5TMxsAfnYYUfroa8je2By8L23fe0iKTacetBLWpxm9Uvyf02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542277; c=relaxed/simple;
	bh=LLDHA2sudG5Mqc1YtHbssFSopYuM+9/meoa8scHfRr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPLCwKDqHHrj9dclkVx740qAXejFo1L0H3KNrj3brxKpR/i6gpMFyGvM06IYz54TXt70bhIj5xDCfwpT887oYuOQgMF9PD0WibcUCYcZ+J58WKpBAtv1p0v/OdC9ZUWcR6Fcj4xjbF2tS730wCFrkMiL3KSBXE4WOezXw8XWT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JcpQ5VQi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa543c4db92so76561366b.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734542272; x=1735147072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=49VD6LmHaGZZbbgit/Mj40zCjnRwikGLSqGKLTApTQQ=;
        b=JcpQ5VQivbI2FBK2vvw4/rYINJJIC4fRdViLMAwODjUWfHr9Kb01Qfg8oJ4CmmRm6O
         b6SMyOVhdIq+cPFMP9EGWqOUduKgUFL+zr/v/sbEOpQWpe9fLlqZBSf7yfw8ci7g8FLT
         R8EkfwZQamwWvZPANNOudHZ+m/bQwcWc2jdSAE0tRiuJWSjxjfY73XdTS6Pv4isbyY2H
         eIGNL4mlQKPRTof6ozz4DWiLXEBWIglVjeTCLUGWs4ODdrUNGdJF+2PaDz3jnGI8aM9c
         l3z5a1xzXyF/JXSKQlAuQcSKDLyDBp6BMqfceedfVheKGiuc7K1lJ+Ae25vsOhZ2Fheu
         ASMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734542272; x=1735147072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49VD6LmHaGZZbbgit/Mj40zCjnRwikGLSqGKLTApTQQ=;
        b=cmZHeL+NqXJBnVWQsH8fgjJVL9kCr2+DNQHBc6mflL7Z9/rOWw5Uexf3xAibIsPBfC
         dKpjJfnihHQ8WMUnX5oVU/Ir1+55WLAq1nL+htSwwsSOyyw9pbxG8DQdgD04UOCYl4gw
         gyoWS76KPbCA5zR7wg1QstC6oN1UYIagX6U3GVZyWUNHeNdouKEF+OiNWT9YViaptJYr
         Ecd1u0SH6oJ+/Kg2b96m3BDgkWToyFKI2vTdppWdN9aOmHAESCir+gDYUH2vpNm8cxp3
         R1vzaWoaaYjmdFDIKoIBzPggIyqgLYy1uYN8ndL2KTwze/peJ6VMyOjM9sRsiclMmsLG
         b7cg==
X-Forwarded-Encrypted: i=1; AJvYcCXpch4FECHh/nLYfZ5tUCidZarBwQYjCWn5X+W1H0h3c1TBXoMWKd0Gvw99zgfXwDNPRKgz+RrJmj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykdlA55D+yNdniER4rFdGqBg65Azrl56FUoS8X8iJ1iYA5h4v2
	A9ys4dw6KqJ75hKiHYhwLCL4joxiLIh6zzORAFJLWuj5Vrdk8wVWewTJgYNJKKU=
X-Gm-Gg: ASbGncst9lY46K8a0uw6jTalnnw7mACt3u0Yhbr7Hh5mYNubu/osJrwTBa8oz6GQ1V+
	PuPpa7JVnCA/MlEaW36aF/BYCGdNvfc54PjGRIkSZ8NtINicxmEK8AAUFbg15uDwduXx9gXlVXT
	iXXuVFZqSZr2ryBX6hCHE5Wc3Qkrzk78e/l+8hgyAuR+A5vZXufHwxmp957wrKbi+m8VU1VsLyH
	WwQ6DF2v3jRx0Mnj2+OKGw304fPzbqeiXvYbyoCsqjOKSG3W9uOcaiEf4mqGc688dj/WBZWlaPz
	h6ctO8jV3Eb5eFIG0y1KaJh1YHhQ2AsABvJySY6+uBuqyw==
X-Google-Smtp-Source: AGHT+IFw5p1aErzl1NNsSFSkOXAQoPvgB2MkuAsQ9/1uCZS/hhNdHQT7c+kzBm4n4NSZ5tyPIsMy3Q==
X-Received: by 2002:a17:906:310c:b0:aa6:668b:2733 with SMTP id a640c23a62f3a-aac07954ca7mr17960466b.33.1734542272368;
        Wed, 18 Dec 2024 09:17:52 -0800 (PST)
Received: from localhost (p200300f65f10dd00ac8b2892888467c6.dip0.t-ipconnect.de. [2003:f6:5f10:dd00:ac8b:2892:8884:67c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabfa6a2e3bsm76715366b.26.2024.12.18.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:17:51 -0800 (PST)
Date: Wed, 18 Dec 2024 18:17:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and
 spidev_dt_ids[]
Message-ID: <tk6wlbylk7aqfd3sys2jitpnbdz4xomdg2yr7hsppxyptgbek5@3vtvajq7krun>
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
 <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zespltodbb3kayz4"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>


--zespltodbb3kayz4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and
 spidev_dt_ids[]
MIME-Version: 1.0

On Wed, Dec 18, 2024 at 11:32:16AM +0100, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Tue, Dec 17, 2024 at 12:42=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > There is a 1:1 correspondance between the list of spi device-ids and the
> > devicetree compatibles. The latter is ordered alphabetically by vendor
> > and device. To simplify keeping the two lists in sync, mention the
> > vendor in a comment for the spi device-ids and order alphabetically,
> > too.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -698,20 +698,24 @@ static const struct class spidev_class =3D {
> >         .name =3D "spidev",
> >  };
> >
> > +/*
> > + * The spi device ids are expected to match the device names of the
> > + * spidev_dt_ids array below. Both arrays are kept in the same orderin=
g.
> > + */
> >  static const struct spi_device_id spidev_spi_ids[] =3D {
> > -       { .name =3D "bh2228fv" },
> > -       { .name =3D "dh2228fv" },
> > -       { .name =3D "jg10309-01" },
> > -       { .name =3D "ltc2488" },
> > -       { .name =3D "sx1301" },
> > -       { .name =3D "bk4" },
> > -       { .name =3D "bk4-spi" },
> > -       { .name =3D "dhcom-board" },
> > -       { .name =3D "m53cpld" },
> > -       { .name =3D "spi-petra" },
> > -       { .name =3D "spi-authenta" },
> > -       { .name =3D "em3581" },
> > -       { .name =3D "si3210" },
> > +       { .name =3D /* cisco */ "spi-petra" },
>=20
> Pity we can't use
>=20
>      { .name =3D strchr("cisco,spi-petra", ',') + 1 },

My suggestion is nice enough IMHO.

> else we could do some macros on top to keep the tables in sync...

I thought about that already before sending this patch. The best one I
came up with is:

static const struct spi_device_id spidev_spi_ids[] =3D {
#define DEVICE(vendor, devname) { .name =3D devname },
#include "spidevices.c"
#undef DEVICE
	{}
};
MODULE_DEVICE_TABLE(spi, spidev_spi_ids);

static const struct of_device_id spidev_dt_ids[] =3D {
#define DEVICE(vendor, devname) { .compatible =3D vendor "," devname, .data=
 =3D &spidev_of_check },
#include "spidevices.c"
#undef DEVICE
        {}
};
MODULE_DEVICE_TABLE(of, spidev_dt_ids);

where spidevices.c looks as follows:

	DEVICE("cisco", "spi-petra")
	DEVICE("dh", "dhcom-board")
	DEVICE("elgin", "jg10309-01")
	DEVICE("lineartechnology", "ltc2488")
	DEVICE("lwn", "bk4")
	DEVICE("menlo", "m53cpld")
	DEVICE("micron", "spi-authenta")
	DEVICE("rohm", "bh2228fv")
	DEVICE("rohm", "dh2228fv")
	DEVICE("semtech", "sx1301")
	DEVICE("silabs", "em3581")
	DEVICE("silabs", "si3210")

I didn't like that enough to propose it.

Also I didn't test, but I think this could work.

Best regards
Uwe

--zespltodbb3kayz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdjA7sACgkQj4D7WH0S
/k6QpQf/W9PqvkqBbzXt2mZGuj+ugE5oabaLqhV1OgFan3mkYfoj0YlwRc3J6Vpn
8+LORotSdo2aFpF1ZRHXnqt0ClSJnm5WRzsufwEz+h4o/Rh9we1PD05Z1Qed74A4
rb6HiGSFxymcl3AjshULuECuopygwEpajiVM46ViJkIG84HFkkf7onf3eVR2ZCa/
4/kWSEtgqIOsARllhMCcPrpT5sWQn+bHMJBcR8mNI10tBl9S15TeKJgtp8apsDH/
ozPqrprUy6xEqyGhkmeyAaotuIYN4doYEbtwy3koH+sXROPSXTEyhL4dU3EDtuit
owOm4TomLdKt4G7eMLqgiIsBVOZ8mw==
=ZSp4
-----END PGP SIGNATURE-----

--zespltodbb3kayz4--

