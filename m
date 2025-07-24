Return-Path: <linux-spi+bounces-9174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E015B10F4C
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A730B1C84655
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4B2EAB9C;
	Thu, 24 Jul 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0kwiAGh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360B2EAB96;
	Thu, 24 Jul 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372787; cv=none; b=kl2+SKQA9b3wdT+dEeOtXP6va/MCrXIQyYawuYZK7P57GxWx0l+Vf6vfzffTTkiCEW/eh8hn7QJkWznAcoNdC9xfP0ZZhkCyI+H079GHx56/IJyaxVL+pLaoODMXeRHudXalTjgrXEbn9au7/TrG4Y73dFTFfq8wWDSXzTlXDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372787; c=relaxed/simple;
	bh=TCxrppk5Sqsacw9rkv+pkbMykqomTkQ6EnUt5R+aGV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcbg2jsVIJzTVvFKaNUbvLt8DPKf5jVilBt8MwJiIgcJD44RVEqWtIZQgPXybW2BMO+F/+g4UxtlawFjqrkIPzyDnyfg7u0INEqQF2oeDy6UNmY+rNcx0Y2GUWc40Jrl6rvzDXH3GEOGygXZBOZ8xAIZ4jTW03v6WTeD48gcQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0kwiAGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9187C4CEF6;
	Thu, 24 Jul 2025 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372787;
	bh=TCxrppk5Sqsacw9rkv+pkbMykqomTkQ6EnUt5R+aGV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0kwiAGh7yOu9cxjg4uDaYW5BG0Ac+CfB2yu3gNej/m71fhphX30PUOmonPEe3l56
	 zjCkS0TR92UYTqi6KktEQSSPUmFUxYlzQAeIJ7I4ASAl8IoyRLs7YGnS5PolM4IKKS
	 /3hWsep9eDTByOsTskJThVuOe5hFSLpmO/SPQGgSft5ItimKGzakjMAY5eRbY3Fwkw
	 TYC6XXvbGIC3Cdf11Rzornij/TG0LGKRkiSOMuL0rXNf8McnXAHO0WjPcDFUPrxjrW
	 +QoFLNLth3C0f1rqUFLfXYByCqqB99AyL0r4fFPY1w3jtWGbDrMAPaBj5gONkSA9m8
	 qdq+rU8O6//Ag==
Date: Thu, 24 Jul 2025 16:59:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Czapiga <czapiga@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Konrad Adamczyk <konrada@google.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: intel: Allow writeable MTD partition with module
 param
Message-ID: <433a3da1-f0ff-4b04-86b7-3e2359498b6f@sirena.org.uk>
References: <20250717152851.3709744-1-czapiga@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apHfDe+POvhgKAkX"
Content-Disposition: inline
In-Reply-To: <20250717152851.3709744-1-czapiga@google.com>
X-Cookie: Use other side for additional listings.


--apHfDe+POvhgKAkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 03:28:51PM +0000, Jakub Czapiga wrote:
> The MTD device is blocked from writing to the SPI-NOR chip if any region
> of it is write-protected, even if "writeable=3D1" module parameter is set.
>=20
> Add ability to bypass this behaviour by introducing new module parameter
> "ignore_protestion_status" which allows to rely on the write protection
> mechanism of SPI-NOR chip itself, which most modern chips (since
> the 1990'+) have already implemented.

This doesn't compile:

/build/stage/linux/drivers/spi/spi-intel.c:196:2: error: expected identifier
  196 |         "Do not block SPI flash chip write access even if it is wri=
te-protected (default=3D0)");
      |         ^
/build/stage/linux/drivers/spi/spi-intel.c:194:1: error: type specifier mis=
sing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wi=
mplicit-int]
  194 | MODULE_PRAM_DESC(
      | ^
      | int
/build/stage/linux/drivers/spi/spi-intel.c:194:17: error: a function declar=
ation without a prototype is deprecated in all versions of C [-Werror,-Wstr=
ict-prototypes]
  194 | MODULE_PRAM_DESC(
      |                 ^
  195 |         ignore_protection_status,
  196 |         "Do not block SPI flash chip write access even if it is wri=
te-protected (default=3D0)");
      |                                                                    =
                        =20
      |                                                                    =
                         void

--apHfDe+POvhgKAkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiCWG4ACgkQJNaLcl1U
h9AzwQf/Rb5NtfekY/3oJt9gvtpUZj3IT4Kf+SYLJumqQ6X5rs4WyuSka+uWamHu
e5/fkkN1i7paTs9yzTEwPZWfoXG+IZtWnUk5nDk6FcRs4zGZYQshEGYqsgMUv+86
4wbUungWAoRalC4nccRVFIP9Zp08JwTtl+tWkqSu45WnJ/eAbQgY4WhZmSUISklc
tZo2x8VCDOtlLiN+nNeYCNyR/Nc7RoJxJX+kBt9Ql78Uc7ItvyN8hX556ShZu6w2
3SOFlQZA/sOIQI+UWRuRbhJOx61DaCv/I1BImqAmkde+//hiGmUpKNRKtUrmFLuI
1WZQXZyd+epOsrptPbPj95w6kdAMBQ==
=XJEB
-----END PGP SIGNATURE-----

--apHfDe+POvhgKAkX--

