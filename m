Return-Path: <linux-spi+bounces-7347-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B94A735B5
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA033BE30D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02418FC67;
	Thu, 27 Mar 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSS9HWM2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A90140E30;
	Thu, 27 Mar 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089610; cv=none; b=mbzN4zCw1xgQzQwR+7znyWVLqN5z7cnzG++md+wDWUQ6+bFd1deVwPX2fgZQuM8ErjFR1dgDjd9LBaQcQuEXl8OZ+GZYucnjEM6sM62FbYaJNshLeANbcvnYgx7/2HH4ca8IsOIK6kYjSkCiAfakdo7C6K43En+vn7+K1XRKGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089610; c=relaxed/simple;
	bh=0KDQW9+C3D+KXwtbTogcCrI3F0K6VvQRKUDhTMU1Lp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzR7J1vqRZgqiIoFUNiUBdhTUCcHVfUFXipX4efUx94k8EBZrz/7KOwUayiWHx7xyd5McQn+zVxWF4WCnyr/R8HemmlYQLVHdvOt0qwmYOTJb+X60Kpa3XZHqyhS6SScozEjw8NVmO2AkypJwDPs4gNjjSgW7oQbnAl/rZztRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSS9HWM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A6AC4CEDD;
	Thu, 27 Mar 2025 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743089610;
	bh=0KDQW9+C3D+KXwtbTogcCrI3F0K6VvQRKUDhTMU1Lp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSS9HWM2nAIfW9XwGL5KbsuKDnmV4IJY9eoebBhcfR9Hu4Xe2hypKXmDN7Ai3m7Ls
	 XvkQMaFSrnMy3V2Fr+xi1j6B8btyM4iZzX95/oCTN/IQii+O3wSrB7UD8usykj/zYx
	 b1xzwGK5r5R2vpMFz5xiXtje+GtORpYRz2O0I187ZhfqikrzJ86ZdHkIdbTG7KkkbT
	 EVGdXE2ARUoJ7ZCsLh7bGRTUXlamgbjv2ET7MFMkFrS5TuJQSP4cQZyeCCTF2blvMt
	 0iowcCqtqLlMR54RbBKdel2b2SJB24WTkkq/46MhZcRG25RbzNofTjxwjUVAvR5FCJ
	 cglV8hkYoRY9g==
Date: Thu, 27 Mar 2025 15:33:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Vishwaroop A <va@nvidia.com>,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <9760cd70-cbd6-4865-92b9-b48eb2cdea55@sirena.org.uk>
References: <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
 <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
 <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V6enJj/euRlY3UZ2"
Content-Disposition: inline
In-Reply-To: <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
X-Cookie: Multics is security spelled sideways.


--V6enJj/euRlY3UZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 12:16:53PM +0000, Jon Hunter wrote:
> On 25/03/2025 17:05, Mark Brown wrote:

> > > The way I imagine it, exporting would involve writing a chip-select to a
> > > specific SPI controller's "export" sysfs attribute to have a SPI device
> > > created for that particular chip-select and bind it to spidev.

> > My general feeling with those is that if you're building for them you're
> > probably either already modifiying your kernel or easily able to cope
> > with doing so.

> That's definitely what we do today, modify the kernel directly to achieve
> what we need. I am trying to avoid carrying too many out of tree patches for
> stuff like this and have something in the kernel that works by default. This
> is even more important for 3rd party Linux distros that will not accept
> non-upstream code.

Overlays should work well for that case too!

> Our devkits, very much like Raspberry PI, allow users to connect various
> hardware for development and so having an easy way to connect a SPI device
> is useful. For any production systems, users will definitely want a proper
> device and device-tree bindings. So I am just trying to explore what would
> be acceptable. If it is acceptable to have a sysfs interface for creating a
> SPI device at runtime, then we can look into that.

The main issue I see with the sysfs thing is that you have to describe
the presence of the device somehow which currently needs a device of
some kind there, it's not like I2C where you can just use the address.

--V6enJj/euRlY3UZ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmflb8MACgkQJNaLcl1U
h9DsHQf+NXjnU8ML3q8LwR6HQSbPEMS/nn66hHJ7e1y2wdqwvw94h4+/K4wKEU2P
RZ8O344/O37YkKwHYkB0x9g2dlnPxxU4bsmAF8+/+E3E+LU0cz0rS6mBZQro7XTs
ZIvKeQ0bccC+I5yulZ+j3dCtbXEeFhtz1fXUq2s0J+602XBfHYnx2pYGOPrOmFvY
aAbF/lgMi2eRUWkxXHqDxXSFRmz+cPxZh4vOPG4OqKqiFhi3CU135eDxzAO3Lh3L
9OIoBZlADkghIluiOo/DHUk4rmvNdOPjjecMQJJlVawNT770QeZswZDaRHMforCa
8u0plKE9d9ramj7w1Yvb/zdG+JCFOA==
=YS3V
-----END PGP SIGNATURE-----

--V6enJj/euRlY3UZ2--

