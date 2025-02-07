Return-Path: <linux-spi+bounces-6655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACEA2C360
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 14:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304423A7138
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBE1DF738;
	Fri,  7 Feb 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXRnylWy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927D9454;
	Fri,  7 Feb 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934274; cv=none; b=Vfl8iKXWs/NvjGN2WWzmev8k5XMrfDJ7ffCPh5SbY9JYIL3fnjoBYaOqo8+oDvu9LSRvZnap+DyOmkjgOavB6pJrGiNUC+4p5EVujwMeWIs+CFFRXfYxP2Uo6iR96BkNvCa5B87qCr5C0M2bQGN7b5DBa5GTFl5m6UXA0ft7qEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934274; c=relaxed/simple;
	bh=IkN+91g2ry7/izxkr090QMoaPLLE7yTdLaQvubsVUeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3wcqcqf7W3qt+vh3FmyyzOPNtwBFsXUoohBrS/UCtDFypx7OZNEfqnd04U0eVhKWMVZi1ZGbA4wMUD7kLPKlbafTaejBO7IVPDLPOv5a6lqob1jtjVp+/DhdcOrxyTADAikpG2JYqMYqrVuKtwolQkTQneS+DJo9wYbyhPc0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXRnylWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA9DC4CED1;
	Fri,  7 Feb 2025 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738934273;
	bh=IkN+91g2ry7/izxkr090QMoaPLLE7yTdLaQvubsVUeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXRnylWyhvFxk5XU/P0YRWezrAu+XaZzF4i5/Ca9GakNTqAStcaxowAAxrbLYxslV
	 UwnunStOpd9y9+OwHqyqBNmM+yFZhlPaUOBPBMVSeU40ALmkhGG7Am2DmuWt2C2X4f
	 2tp4C4hKc4ReBB2uAN0HPEk78oLh825TtTTtTBDEqUXFKrHA423xvVPqG1BY2cYxN7
	 x3PD2BlNBL1EnTipjMxPMo8sEUKB4e4G3miCoowJbaUD4iaB+pWnY0rv96K7MJC3Rw
	 l8UQYRPKIL2lDJQn3q/JARtbLiX7qPaq7FCZhSz6/Grxc5xQ+8QeK6EBoJWk9qjpo7
	 Y+utI/Ogi0oGQ==
Date: Fri, 7 Feb 2025 13:17:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Durai Manickam KR <durai.manickamkr@microchip.com>,
	Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH resubmit2] spi: atmel-quadspi: remove references to
 runtime PM on error path
Message-ID: <6aaa852e-9a7b-45c4-a5d2-20ebd8f848f9@sirena.org.uk>
References: <20250207122145.162183-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N8auyasM2SC+L5Gh"
Content-Disposition: inline
In-Reply-To: <20250207122145.162183-2-csokas.bence@prolan.hu>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--N8auyasM2SC+L5Gh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 01:21:45PM +0100, Bence Cs=F3k=E1s wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> There is no need to call runtime PM put APIs on error path of
> `atmel_qspi_sama7g5_transfer()` as the caller (`atmel_qspi_exec_op()`)
> of it will take care of this if needed.

Please stop sending this out so often, this is the second resend in just
a couple of weeks.  Allow some time for review, having multiple copies
on the list makes it harder to keep track of any reviews that do happen.

--N8auyasM2SC+L5Gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemB/sACgkQJNaLcl1U
h9D7Wwf+M4ufdPA1DyzrOM/eDkbJJwzeNBiT4EENEGbaWFN3iNZZDY0apuK38f65
ATrs1UHVLOyubSTpifTtz5he9gGCtr5QxN5fwYWH4nSo6PmmoV4twtadyjUTsGt1
2D8Qa4tRD6Xwrda28O5tNjdouFD93jfMvhKlbOwucFGbjRXeL9ntYMV4hNqofixi
t9wrmuekt3pEASBcfr9gI86Ff5jQ6/BvOzIhpmr0RWk5F2jKQt+V6tM2AvtKnxzO
/oyV7gQAOSEhKMHGwWjW4bBrjaCEXQg9VIUOzGKXBqjaLChgX1s89T8dUcqhQtdY
rk1bz3zqBTYoiMHBeMGyfJRL4PH7RQ==
=QtKZ
-----END PGP SIGNATURE-----

--N8auyasM2SC+L5Gh--

