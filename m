Return-Path: <linux-spi+bounces-11760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A18CA39E5
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 13:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A283034DE4
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C906336EFE;
	Thu,  4 Dec 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhoww7L3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F051330B3D;
	Thu,  4 Dec 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851599; cv=none; b=mFZa99w8FDbrI/Ej9I8w9gA2bw85IxZegEPaEgClUVkysGvQW/yLOeLvaCTZjY5gVd+kOBadrOYSvfiUmjv7CF/+Ah+sk7feMFwZDBeeF7IRo21nZ63MbAOSecBBHKEbxWNnbbH5a4HCkLf+xm+XItME/QNrVBJPXpR3TAGqZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851599; c=relaxed/simple;
	bh=HMmNty+P3NAdwwW+CTsFuvrWKjzzvhFXf2oLlXgTZdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP2uPfCL8hZS8fPwR4cNNuP8LKDJH41xygvdlt9TdrMFWH5qUULRsoUsC+LbA5tYeOUhDOHg5uxjCCyoqTfrkVfvRmjVaUOi2iilg0w+9B0sgaKssIFuc6mQWFaP0+5v/6yJFll/nu14uDMfMa41NFloeZSaV73krd5t905sii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhoww7L3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6C9C4CEFB;
	Thu,  4 Dec 2025 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764851598;
	bh=HMmNty+P3NAdwwW+CTsFuvrWKjzzvhFXf2oLlXgTZdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mhoww7L37d2+HcwPhCcqhSAJryHtEPS2AOdqGh0uX7eC/kFvp9GayA+htefzOvat2
	 wqk9wGjNGmal6eB/DbfxjUPDrKTQAMlwBSGhueHRBR3kHcACBpJ1zwB5yvlyxNepyi
	 0kE02L3xJGmtjhaF+YGnN9/ppksV743tYZKXU/BtCo12OVmIpDv0q/IPIvRgu75LfO
	 D2mNM+2Jt3QtbYGzCCorFzRtexXu2gn7eWT0z2J+cP6fk29xq3AFEBAR8hAZ36rbPr
	 MmJ8lgEn9HbH1i8Ed+LS/npN8mU6oeGyiIghuKbdZzf2lCzcNLB7dNlEeKlh5xTO2g
	 nfApDh32H3PkQ==
Date: Thu, 4 Dec 2025 12:33:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: tegra210-quad: downgrade the log when fall back to
 PIO
Message-ID: <cb9c67fa-c95e-44a3-b906-8f64bc4a9e29@sirena.org.uk>
References: <20251127130207.43754-1-kanie@linux.alibaba.com>
 <16bc32ff-2c10-448b-ab82-a21eaa91f4ce@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U0KhDSkCRerBZi8d"
Content-Disposition: inline
In-Reply-To: <16bc32ff-2c10-448b-ab82-a21eaa91f4ce@linux.alibaba.com>
X-Cookie: volcano, n.:


--U0KhDSkCRerBZi8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 09:46:26AM +0800, Guixin Liu wrote:
> Friendly ping...

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--U0KhDSkCRerBZi8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxf4kACgkQJNaLcl1U
h9BsjQf+OYhDV4Z7kPWKI01Q5eLXCDLd8NmrTIbce0ywnQsYHbXT6FP0G6oVZPwk
UsyTh6tToqKa3qnMKu4Fz0OC/s88WuEJq3kqClZ02eKVVXAUP+9PszTMPGsctpV/
Rc20S3NvDXMzBqMQK13TUcg44SBwf5eJHICI63r/zRkxY04BBf1EHMU1xCscF3Nr
LtVONTFiFBmpC/etV7R+qFPjRRrTzy7+XnIl0VbtjWCUdAHvoerCDNgxZ92JOIFn
yaQKD7IZi4pbwUxT7F5eWPjByMP6lcpU4XWJDwVHy5H+WjVF1Yh09YLwRjdZ7Nqf
nUSVGo5Ti/6v1B+/szCD4NKdlBSccg==
=5ORn
-----END PGP SIGNATURE-----

--U0KhDSkCRerBZi8d--

