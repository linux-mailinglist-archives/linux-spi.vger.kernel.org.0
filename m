Return-Path: <linux-spi+bounces-7207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3677A67BFE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0B117FB17
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E11DE2C8;
	Tue, 18 Mar 2025 18:35:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55177151990;
	Tue, 18 Mar 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322923; cv=none; b=ImxufXiFPZLNJJasDvJ+RiVVvCHtjhSn5kc+jghrmYVLtksuOGU2xwQq4TPKdt5WbASafklqtBi/U3lVhs6Yo5zxPKhpfhxwniCuQ6QvlUKylG1gJsOutWH950Zeyv/LnDbi+PPuVWjxMe934z1k5FWO5rtzoPaXJoOhNiw1OOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322923; c=relaxed/simple;
	bh=X3qQ7diWgRtTE/GPFF6KcKC9OKrEHPSPv3sQnnKzuy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpDsrUMZrrjj9Usj5hVySPavURqWM+JBS1fW1oz/o7M2I8jaKx73ZctlcGMVle4O9JD+Sccri2V2fm2YFH1bAeDhFC70ea32857fbUcyH3HWXwFNlvRowbN3zWFiTEQ/OCbZTmgklH2RHMk9RaRZ6fAQe7dVAQrYwOOh3ZteqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CA2C4CEEE;
	Tue, 18 Mar 2025 18:35:20 +0000 (UTC)
Date: Tue, 18 Mar 2025 18:35:18 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <7f2ac489-51e5-4798-a38a-a8b7ef3d4c83@sirena.org.uk>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DrO3bviP+vpWDCqZ"
Content-Disposition: inline
In-Reply-To: <20250318-boisterous-adorable-chowchow-cea03b@leitao>
X-Cookie: Swim at your own risk.


--DrO3bviP+vpWDCqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 11:29:26AM -0700, Breno Leitao wrote:
> On Tue, Mar 18, 2025 at 05:34:55PM +0000, Mark Brown wrote:
> > On Tue, Mar 18, 2025 at 10:02:47AM -0700, Breno Leitao wrote:

> > > Regarding this patchset, I understand that patch #1 is not ideal as
> > > discussed above, what about patch 2 and 3?

> > If I didn't say anything they're probably fine.

> Do you want me to resend those two separately, or, is this thread
> enough?

Please resend.  I think I was anticipating a new version of this patch
with a clarified changelog and some rework to tone down the logging
that's generated similar to the other patches rather than just silently
ignoring the lack of a reset controller.

--DrO3bviP+vpWDCqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZvOUACgkQJNaLcl1U
h9An6gf6A4kPFqQZRrxqka8zwUNiFavNnEAO35P1Gd1Zu+9FfcFM1flvUmDUlBgD
RRJaa/DyEShu63oxdkdj36hdQp8mCYKREKT8FfcsJzaQ4hjQdFyJ3PNbUUB01bdr
T5szWlFM9bX/LCN76bazslzVv1yUeSBlhKFUCp1WpT1UWuqoXmyUsx6qz5+fL+8/
07c8Pd838OKLNVtpIAHk8BSsRA0zpiS9M0l7lNAufbRZ2IElOli9iMSkHsHh1hos
jilbIwR3ZTiHXMcPwKNLgXjkfpcWeLADYWv2DlMgQ55tCXzFJ4RxeurEXmfiiwL/
a4AMIkpYCKnCI0k1hXwlldFZi1MEWQ==
=LfO1
-----END PGP SIGNATURE-----

--DrO3bviP+vpWDCqZ--

