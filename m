Return-Path: <linux-spi+bounces-2488-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091918B0B87
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 15:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D74285085
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD715B15C;
	Wed, 24 Apr 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy4DhCtd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC015AABA
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966753; cv=none; b=plAfbHqo8cNOULbGLFXjR3TsfiRszQRrMBFuNCrMMwQWXFreGoIpNfU/CjjgG7fbJrS6Rf5x5WFk5mWx4blVUhYGVICMIX8CkiiDJ1dmB8efnSV9Y6exqKwDsM6JdlgQdegHz5WObIWlK3iJjtDq8PvzGq8FihtREhMULgyj5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966753; c=relaxed/simple;
	bh=KwUqZ5b3VatqNchJbtKfHK9H8iLfVlyu9gx9r7Cmz8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYWYNKw8jEMZaQZO1ANE6cwtfkxi5obAX6nIVVum6JPGE7yPkXMp1NxWQMBd7vsKzQQMA+iE1UzQwRQdOvezvfKwxn35aVvfgQloRIA3iyYwVqjgHOUuz+7tDk7HmCI4fDlQ01zPh8GJ8T9zgfuIxThd/39/HIfEXVkrJeXTRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy4DhCtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B199C113CD;
	Wed, 24 Apr 2024 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713966752;
	bh=KwUqZ5b3VatqNchJbtKfHK9H8iLfVlyu9gx9r7Cmz8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dy4DhCtdlkrj5RzZRe3IZNv327ycfOEfjujqTrR91Ocuc+U4NGt1oeqvegELKRoV0
	 rjry+r3o7Dmkfq3rFQD+3Rd+JI0CQ24Dn1HZxVyOzFn21Gfd0fLHiCL9RAuPs4NS4r
	 vZqRcNLkmiLvnTrtZRmLWJ9yaT6D6kXRBL0tTS6nLc1lg14keVpvpsKQIAYNXKAOxt
	 1l/LPfCjdSYVmr5VMW6w3rzExBFs8nml+6zJDmSJz3FDV8xz8S1eUw30/fjmlfs14R
	 yrrr25Fr0XgtbHJZQTlYOBnhL/dp84YKh3qh+ch0+w9ocyJ/x0DgZJZpQRyuM0bWCS
	 iEaTV5R/rbjRw==
Date: Wed, 24 Apr 2024 22:52:28 +0900
From: Mark Brown <broonie@kernel.org>
To: Heikki Keranen <heikki.keranen@bittium.com>
Cc: andy.shevchenko@gmail.com, linux-spi@vger.kernel.org,
	petri.tauriainen@bittium.com
Subject: Re: [PATCH v2] spi: mux: Fix master controller settings after mux
 select
Message-ID: <ZikOnAPi0K20quZS@finisterre.sirena.org.uk>
References: <ZieRYJat7Y0ISbks@surfacebook.localdomain>
 <20240424111647.81286-1-heikki.keranen@bittium.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1hdA+dkz3i/MG3aE"
Content-Disposition: inline
In-Reply-To: <20240424111647.81286-1-heikki.keranen@bittium.com>
X-Cookie: TANSTAAFL


--1hdA+dkz3i/MG3aE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 02:16:47PM +0300, Heikki Keranen wrote:
> In some cases SPI child devices behind spi-mux require different
> settings like: max_speed_hz, mode and bits_per_word.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--1hdA+dkz3i/MG3aE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYpDpsACgkQJNaLcl1U
h9CgQQf/e5eu8AUFeNi5eM4P8CMi5EXmaUqujm+vL3v8MocDYBwCXFAlS+VMn3UU
AcBh5Lcow1MwzEQIGctInAnx9LBVTxx08TFQBTYnXaB7W2uu+LMIAlcub7MfkpP9
XvIxYrTnM17HB90tgDIQrfvBf+9CNxZiLmyyGFCMPNb9XRi5WcyPj3Ji6JdxTjnq
kGOwOJ6M15Rr3lMV4ZhB6um+1e8npWnfc5ar/bkoF4MVaIybA5ItQ9pMWV7eLoTk
ztfo5/+vEvwAfy0VJlEUwREp0t7S5xQNCloHSmlDoxTE7Czy+d8nkFTOd9STZuB/
ZbZBm3/ghRNWZOLEpunRBOufhOHuHA==
=mNRv
-----END PGP SIGNATURE-----

--1hdA+dkz3i/MG3aE--

