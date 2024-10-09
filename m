Return-Path: <linux-spi+bounces-5170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051D1996764
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 12:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FEB271FB
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9118E751;
	Wed,  9 Oct 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6F2Dor2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BF18E041;
	Wed,  9 Oct 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470114; cv=none; b=XfjjPlkJRMCmr1O0T08HHizs8Wi3qiuYO0pgVV8VKwKUYGas199Br5JYQZV2Un4UoOTp1Tq5sk2euiapv3Nfc7HHg6Q4jqSRvOEATIfvpd1OUWMGsU7WUTgyjXUY5QEOTswAtp3tbP3lJbMIJMQ7Bee3iO3ZU8JUSpTHP5h95Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470114; c=relaxed/simple;
	bh=m6mJpysXApNGJei9mvRU4aXmO98VPQOAWYiaR6Igb54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aggcPUgbsoqW11En7AmBwfFVO/x3jDPi5ndgpGP/PvPTZSfpwIQBMFv0TR0j/tj8zVd2/zTi7NdRrD25/Dl3fk9fHSgWTHreiPEZUTcffKmCDZGxXCtEm/47NfIW4fF1KW35zPz4U7oG09kv1en/ccg3FGcSdAbr/tObppvZg3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6F2Dor2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B838C4CEC5;
	Wed,  9 Oct 2024 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470113;
	bh=m6mJpysXApNGJei9mvRU4aXmO98VPQOAWYiaR6Igb54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6F2Dor22DNGOa3IYCUqvbSDMtTMY3lRtrRBRh8iw2dD0lX4DQPAi1HhoG9ZxaSeG
	 DIMcgUvfPzUPNnw7W2ASWwRpOVlkErtI/FGby2ClBviA0C5owiD5vuy4q1P2UTKl7X
	 GfE2az73W/TlteimrN5oERQ8Ex3b32NxFYtFBxzPpLGTgR0aEPxzHerjKUv0mDSOyv
	 MIt/D2Xz2seWThy10ob+DmartceQdQeR1f3fjM/UOF1Ji9zaW6NFUSAjqjnZ7CuG2J
	 SZp5b7oED3oMm2OAJpJ94WgTC6p0cb75Ju2iWt5Ac4dzoscaGCm/NWi33W3nc2S4SC
	 lYXlmt5NUswXg==
Date: Wed, 9 Oct 2024 11:35:10 +0100
From: Mark Brown <broonie@kernel.org>
To: djakov@kernel.org
Cc: ruanjinjie@huawei.com, dmitry.baryshkov@linaro.org,
	dan.carpenter@linaro.org, naresh.kamboju@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] spi: geni-qcom: Fix boot warning related to pm_runtime
 and devres
Message-ID: <ZwZcXrfYRXlVQK5M@finisterre.sirena.org.uk>
References: <20241008231615.430073-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rreyULKR79Pw3vxk"
Content-Disposition: inline
In-Reply-To: <20241008231615.430073-1-djakov@kernel.org>
X-Cookie: Editing is a rewording activity.


--rreyULKR79Pw3vxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 02:16:15AM +0300, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
>=20
> During boot, users sometimes observe the following warning:
>=20
> [7.841431] WARNING: CPU: 4 PID: 492 at
> drivers/interconnect/core.c:685 __icc_enable
> (drivers/interconnect/core.c:685 (discriminator 7))
> [..]
> [7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
> [7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
> [7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
> [7.841502] pc : __icc_enable (drivers/interconnect/core.c:685

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--rreyULKR79Pw3vxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGXF0ACgkQJNaLcl1U
h9DkdQf+JqijhG2Gjh3D6EZukevRRU5wmFjpoiQof144lTjdE/98EKrbYi38EO39
1o/V+RfelYvHmi1gLBZRwVX5T5HG42LROwW4MdAAiTgkelwuKnUpIpL88w190tfg
LXaqPIbnFkfOJt+JZN/Qod4AfkxSm24CgSJQqI5JnKMuKNvKb43scXuaR1fZr7TZ
VaG9vjsec5SNNJzeUNwOWGU68XrLbsLaFb8iFtpoM9oxc9Qv9LOW7jC8VU6udDIW
CBIGs5FHQuUoUqREvyhWQR3zqjytMW4gjm4U0DVeVYSc1voJeG2dqhU4Cz5Yg9DN
UVgHQUngxGfFDPKTeOhDUuNpZcGvsA==
=o24g
-----END PGP SIGNATURE-----

--rreyULKR79Pw3vxk--

