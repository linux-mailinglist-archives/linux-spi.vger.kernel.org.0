Return-Path: <linux-spi+bounces-7303-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC69A707AA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CA116BD55
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9483262800;
	Tue, 25 Mar 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ZsP5QC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A3261385;
	Tue, 25 Mar 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922347; cv=none; b=WuU70QB04XbTPSW9aEp8tEy+5rsuM8xLAU/K5NVawrv5tGNRIxQcvrjZFOwQiJf8bhjMa8tbDXmwSaroNvYDGMqPMvvPOwoSNAIewVqP+XSDg9aXrikNeaHzNCuXU7KrNWetcEPDIm89APlDXXRYUAthlK9RYDAAm/GA1bHGpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922347; c=relaxed/simple;
	bh=L+dZh9VNjHig2YVj8zW9PJDGzaH1BlEcTcNOYS/YTLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E888ctoqVnkgXCldt832NoviNuKfadROPdILqwNcenLFBdSQwnaLbTk1+kXoIltr08uiOQNbZmPH+zxhCv8KzxGVJjIhLJLWTKfij+qrafjxp/xNkHj/tmq5kn+DYiMksl5wZTPpi0qvojVx5MEA7sZCGfmkCHFh2QLU5ptshd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ZsP5QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF8C4CEE4;
	Tue, 25 Mar 2025 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922346;
	bh=L+dZh9VNjHig2YVj8zW9PJDGzaH1BlEcTcNOYS/YTLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9ZsP5QCdkX3tNj/fzDABeyCKRsyBZtmKLP70K4rlNqHjjR5az54nRvAJTy7QcAfs
	 6Yj9TTU56HDWh+8Qzdfse3722dnPphGjyT/466M2wlf0jUKFdDha0b13rSLKQ1nAoc
	 zr0WjgDv718/WUVPdhsLNPKvZ5blXq0k3OaNoeAZ/y63Cq1pociB4MEfVFU8qNBZtl
	 IGWbv9PfDS1Qt66XFlpEQChiC5zG7Zq3/eRUkKyvW+4YVRAJ0l34Y1Rp6r3fi/HFkJ
	 siU2NdtiI3a52J5Eaik04Tg1zbwg3PFy+gymdzO0sS3MK1CcaR8x0N21npck4YZ5P3
	 xQ5C0d3BA+rNg==
Date: Tue, 25 Mar 2025 17:05:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
References: <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prBnnAYoF93QFDyr"
Content-Disposition: inline
In-Reply-To: <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
X-Cookie: Visit beautiful Vergas, Minnesota.


--prBnnAYoF93QFDyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 05:38:57PM +0100, Thierry Reding wrote:
> On Tue, Mar 25, 2025 at 03:55:02PM +0000, Mark Brown wrote:

> > Possibly?  I think I've lost track of what the use case is here, usually
> > for the spidev stuff DT overlays seem like they're the right thing but
> > perhaps this is different?  If we are doing this at runtime sysfs seems
> > like a reasonable way to trigger it, though you'd still need the DT to
> > describe the controller and the chipselects that are available.

> Heh... it's exactly the opposite for me. I feel like I don't understand
> the need for spidev with a specific compatible string. If you've got a
> compatible string (or in other words you have a device with a very
> specific SPI chip connected), then why would you want to access it from
> userspace? Isn't a proper kernel driver the better option in most cases?
> That usually allows for better abstraction via some other subsystem. I
> suppose there are cases where there may not be a subsystem, or for other
> reasons it's more convenient to have direct access from userspace to
> avoid the roundtrip. Or maybe users could be concerned about safety?

A lot of things would be happier with a driver, yes.  One of the use
cases that did make sense to me longer term was DSP/coprocessor type
things with flexible functions where distributing the firmware and
application that talks to it together makes sense.

> In other cases users may just want to connect something completely
> custom or just have a way to poke whatever they connect. There may not
> be a proper driver for it. Or it could perhaps even be used temporarily
> as a way to write a userspace driver conveniently before porting it to
> Linux.

> The way I imagine it, exporting would involve writing a chip-select to a
> specific SPI controller's "export" sysfs attribute to have a SPI device
> created for that particular chip-select and bind it to spidev.

My general feeling with those is that if you're building for them you're
probably either already modifiying your kernel or easily able to cope
with doing so.

--prBnnAYoF93QFDyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfi4mUACgkQJNaLcl1U
h9AAggf/ddwtkdC3foZB9TSzsiGjOcIsQSisMObY+BOUK68gMRWYjZrIOBjLJvjS
R9gp0DqQy84zwfVrXF2nOUP5t5MF+7f68Dit9O7fWHpjsgKLxzRcU3oonJljaUOt
LYTL6yjvqMyAjIrHA7Xa/NBZl49kDWA7GWDN+UUC4fYvlJoDJQ6jNdYQ5W2Ayf0H
nHPB+KFeSrrYtFxohEYp95eNWaAwBJifkOoLegcTaFDKRMSclmxL99rymODO3XnO
xNlgz1CRxJWdj4q6h2RhxiQtE4+PSbJm7nZ0DTYKEYRN9tdu9jm/XVa6edoPZLWI
x993RorsXphByfCOzewHTFZ6FAmUnA==
=zp+m
-----END PGP SIGNATURE-----

--prBnnAYoF93QFDyr--

