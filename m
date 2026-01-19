Return-Path: <linux-spi+bounces-12486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE21D3AA7D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 14:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083943083FB3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE9368298;
	Mon, 19 Jan 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Yy+O9m"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D73659F3;
	Mon, 19 Jan 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768829833; cv=none; b=SnedwP7hZS+/NHbBhFpLGBRUOMGUV7Br5LSjeVReqie+z8x3ZI4Zbc/hP8YQcrKp3q3H00bJFEKf2fbMALTV/VObf4LVTsX/0ppLsl3JCWkWfIsG/h1KXX/U1jAAZLNrPGyvcMD5CsRUmhhaKZNrEykCod1DU95AGZQu+9DxTZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768829833; c=relaxed/simple;
	bh=NQhlNmakp9XzCvOKm+K/DiXWdOuvD8Ykc7UWybaRfrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sftnlAYGefWLTQB6js8nPNHePn7cKu2sqJ/WswQpAOTupGmseomJxn1yxE53Rc6VDbv3sVF6Lh7km5ccSgYK8lujiwjjBbuX6HAEKLRBPR3wdVJB8OG2e1c2uheaD3ToUjpR5zLRu3N7HHM/l6zZF2sBjsxRRy8oqL6TqqrgQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Yy+O9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E63C116C6;
	Mon, 19 Jan 2026 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768829833;
	bh=NQhlNmakp9XzCvOKm+K/DiXWdOuvD8Ykc7UWybaRfrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0Yy+O9m3bpEWejSb8AZVey2Vkiwx0Eax1Yq7MFX+zQfpIW9vXJjBQavwlH/TErRH
	 qW66JhnYseJiJfY2MKbXCI54CthEcjVWyI6bb/ms2w53GHTvZLz6J3jazd5/uSl2Ps
	 FTn7n87f/C1RBrwV1i6bt5ETR8tzAWb0QlnyYbPPk0g6AQe4B1dYCGNXRpxzsRjpvG
	 O/O1cX7wCx42r0asHpVNvtwg9Az048pE37WW7oOey/+uBFiI33P8bnOHzVHf9i0y12
	 XwB/K0dlvP1LZpCmhHgmmT6v5qbWg3jaahCpW3/N9FB90ik68JPzCM7hNszYr4JJ4q
	 hXVNgNbeGbjXQ==
Date: Mon, 19 Jan 2026 13:37:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, clg@kaod.org,
	boris.brezillon@bootlin.com, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 2/2] spi: aspeed: Add support for non-spi-mem devices
Message-ID: <e4f133db-928e-49ae-9ee8-99e119d14708@sirena.org.uk>
References: <20260117134216.595436-1-chin-ting_kuo@aspeedtech.com>
 <20260117134216.595436-3-chin-ting_kuo@aspeedtech.com>
 <3153512e-8325-4d0b-a869-a2a5062abefd@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gk42q0GFzUogNGdb"
Content-Disposition: inline
In-Reply-To: <3153512e-8325-4d0b-a869-a2a5062abefd@molgen.mpg.de>
X-Cookie: Does not include installation.


--gk42q0GFzUogNGdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 12:48:37AM +0100, Paul Menzel wrote:
> Am 17.01.26 um 14:42 schrieb Chin-Ting Kuo:
> > The ASPEED FMC/SPI controller may be shared by spi-mem devices and
> > other SPI peripherals that do not use the spi-mem framework.
> >=20
> > The driver currently assumes spi-mem semantics for all devices,
> > while the controller also supports direct user mode access commonly
> > used by non-spi-mem devices. This mismatch can result in incorrect
> > behavior when different types of devices share the same controller.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--gk42q0GFzUogNGdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluM4MACgkQJNaLcl1U
h9AOpAf+KY6H92cdg3gOoQqgQu7crH6a+7XIW9D8d4DUyutJ3AVxvUSJHgxNAl3c
V4ilv0msLOJJ6HpX/r5PQwBxtXyJ8B+4awixyqucFxMc5rOTbOhTUfSQs5CEk0Ye
ZA0i4zbi0ugsYRl329wp62zOsYNbdZu0zDZmaAwIGUnZhuyarMsk3xfSkg8i7oor
/uQhG8Z+bw1Y9rW5+WBFPLHsEiOhsf/o7pIIKUtTkaJkrE8hvfvszgIzObDQwKPM
EXIlzMbd2tlKgIHfwIRcRK+NzbpvC/BIHEBZmiYPR/Ura1meOTlsrD9UR0rpd5Gg
RrZG1vxcsH4KwCDJfTCUxBBlMfcFlg==
=Arfl
-----END PGP SIGNATURE-----

--gk42q0GFzUogNGdb--

