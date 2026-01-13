Return-Path: <linux-spi+bounces-12353-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28428D1B085
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 20:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E88293013302
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1E36AB51;
	Tue, 13 Jan 2026 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4pHT8CB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8535F8B3;
	Tue, 13 Jan 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332362; cv=none; b=lP7x+nuXn1NmCca6bj81sPsHExtdmW2hxdKAQdCWEuV1etgQgZ2q56yAOQ3b3cxXKbST0DjlKVgjHvKMFXNdYg2qtsdb5MDyQvwtDVM5vtKsIIJZQYOF2ropcKyLd4IpIDuQ+DkHRlyepu+NBOIuWuYr+ghz2RSYDO9DEoPNlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332362; c=relaxed/simple;
	bh=QfE9tdDld62jcRONc3G5Wfpg9QgF5mvAscqXx3Y8ssg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDsNDwScwY9KSjVV+zOvI3e4vQFQ7WZnjYcNHWdneYnjEzFIratJGraGoYUWDoL2mA6+PwlTOmv+U+tFBaus9orceROL5glCXMMlThWNx+bP9Fea4p9P2B7fdZa1j1nnrq+0txm94o3tyNTe/8BNpYMkknK8ySqXQiUcducHThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4pHT8CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98ECC19422;
	Tue, 13 Jan 2026 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768332362;
	bh=QfE9tdDld62jcRONc3G5Wfpg9QgF5mvAscqXx3Y8ssg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4pHT8CBEdXSkeDUsLsNHhwAyrm51GavxZ/Q6TOUWzqFxBR3jZoLGJVzeajUY9Npp
	 JPBnnGeyWBwgoPm0auCkj4pQ6P2fCYQeZLl1XwAwr3KAmmcrUdc0mHWIPhI8Irpmj6
	 uayeg13bPvmTQMrWHR0rZD735sWFI7zN4cJ/nycB1pOSJRidYMAcpEFKl5UoLa4O3t
	 CF9XuYyD8NUcA67hCFHtAo1UVESnKc26KvUsKzUDgw97r4RzmJIjQZ8wFPT8C9n0dJ
	 VAWBMpGU1OQxZUYD8yNgZ91jspyPwpxkmGQq0mht5GHh6/cSUCFfcQx55MyGIN+s5Z
	 4TOzW0bu9X+OA==
Date: Tue, 13 Jan 2026 19:25:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Felix Gu <gu_0233@qq.com>, linux-spi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH v2] spi: spi-sprd-adi: Fix double free in probe error path
Message-ID: <24f98b92-af03-4a5a-9f22-e83045289c7e@sirena.org.uk>
References: <176830457213.25724.9815535994112539882.b4-ty@kernel.org>
 <1c068a91-e0a9-4edd-b5d0-c7fde56999f7@web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O/SrnPaEPrZwexDk"
Content-Disposition: inline
In-Reply-To: <1c068a91-e0a9-4edd-b5d0-c7fde56999f7@web.de>
X-Cookie: All models over 18 years of age.


--O/SrnPaEPrZwexDk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 08:20:29PM +0100, Markus Elfring wrote:

> See also once more:
> Check =E2=80=9CBAD_FIXES_TAG=E2=80=9D
> https://elixir.bootlin.com/linux/v6.19-rc4/source/scripts/checkpatch.pl#L=
3231-L3269

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--O/SrnPaEPrZwexDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlmnEUACgkQJNaLcl1U
h9CafAf/XCYWfQBwsp+Cg343Z9xX5S2BrTbieAtFS/Nj8KUIkK57jjR6duOXDOjb
PU6gfdbTZ0lx78hDMAvZmR9c16HipZOpXm2x6WWhyO7tSCyMlalXkwOkIUeFdutu
r7eLHJiHQW2QDy2aM5Blnxt3aBN2Eh5Z2Fctim37nMyGhK88fZRktS3PZl+sc+A7
oDSpwXMWJCqN7kyuBmqeJcYFCVqk3XJTOajxem9OysYN17v+Qv+eEMaE6kBWVtB0
DBwAXmk3VD5cPds+EfYnslgs00KAZctzUhXE1zR/zgDkVmPyWhRIu1J9gCAcjLQA
MBKaIpPt8E3y2mPahqPmhpVqBNI69g==
=eMuY
-----END PGP SIGNATURE-----

--O/SrnPaEPrZwexDk--

