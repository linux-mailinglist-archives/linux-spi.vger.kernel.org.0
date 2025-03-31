Return-Path: <linux-spi+bounces-7368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8DA76648
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 14:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0466D168363
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201E20298E;
	Mon, 31 Mar 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYdmsiPd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2F35966;
	Mon, 31 Mar 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425081; cv=none; b=ATtUrVtEoZo3lY8iXL2+Y4ykJ4n7QvKWK8iA6WQRiABTh7elnbSX1AJaSfF98eFytyFL4mWwUdoSu8hzPhxesxFTNoo3QtGFeQMOjK/7NvwQT4aFUjiqvGSc/q6uYZf0uqiQbX1ZnthYyigMwvCmzbgdW//BKE1Gj8oEiYhMXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425081; c=relaxed/simple;
	bh=LiC9k2vhB9XdHbN17GPbp55Zc0upnEh+TTU+H1Hlzto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APoZb4TnJLEJKnNliDtTfq7KdR1Y9QJx+6/r3ZIxUd3PceoVuxCkZu2sCJgm5vLhSwR2n6H4xMY9sCald2qD7AdXxqSbonc+xbwwyiDfz9Ltk0gjBEvge1UMfHx9VRTpYM2WzAjg1VLZDCpAQsvWJhM5p/EesZxza5nV8ae5awg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYdmsiPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DACC4CEE3;
	Mon, 31 Mar 2025 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743425081;
	bh=LiC9k2vhB9XdHbN17GPbp55Zc0upnEh+TTU+H1Hlzto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYdmsiPdlulSlQaawINVpx61LR3YLSvr7scqcF6xslY3x4jDunbKxGxZDbq5MW398
	 aLvupg35Rpf+w+A1duXL5oux2VM0gwmhowCvGgKnTJWLT23UEdQ6wd6GtcbV62z77u
	 2P4Hx42mEeSvnjdHwluGz5PxoWc32psDnvRiWKisXRANzGeiParkzAA2DAwU24VMHj
	 1qA8wyA8NF+c0Ykxik5Awg0CEQ/AZxOQFIAYUAYRbkq7xsLlD2OXhNKxiStLUKEt48
	 /7gDzdZpyPnN8HIFpF4cw0zEACf+f78nRzbsZn324uB/8s1t9jQDSaKjyD45N8xgqf
	 VHZ/FkJqS7Tsw==
Date: Mon, 31 Mar 2025 13:44:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Vishwaroop A <va@nvidia.com>,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <3b0f4fee-d46b-4086-9d63-f4093b52748e@sirena.org.uk>
References: <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
 <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
 <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
 <9760cd70-cbd6-4865-92b9-b48eb2cdea55@sirena.org.uk>
 <69aaba89-10c6-408e-b328-c3e31a1aeaf7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6zwW9LXBH0p4nz1"
Content-Disposition: inline
In-Reply-To: <69aaba89-10c6-408e-b328-c3e31a1aeaf7@nvidia.com>
X-Cookie: The Ranger isn't gonna like it, Yogi.


--m6zwW9LXBH0p4nz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2025 at 01:34:21PM +0100, Jon Hunter wrote:
> On 27/03/2025 15:33, Mark Brown wrote:
> > On Wed, Mar 26, 2025 at 12:16:53PM +0000, Jon Hunter wrote:

> > > That's definitely what we do today, modify the kernel directly to achieve
> > > what we need. I am trying to avoid carrying too many out of tree patches for
> > > stuff like this and have something in the kernel that works by default. This
> > > is even more important for 3rd party Linux distros that will not accept
> > > non-upstream code.

> > Overlays should work well for that case too!

> If you mean device-tree overlays, I don't see how that will work today.
> Unless we are to use one of the existing compatible strings, but that feels
> wrong because we are not using any of those devices and like I mentioned,
> just using 'spidev' alone in device-tree does not work with the latest
> kernels.

Why would you need to use a compatible string for anything?  I'd expect
the overlay to add the entire new device, compatible and all.

--m6zwW9LXBH0p4nz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfqjjMACgkQJNaLcl1U
h9A9zwf/SV7SuhD12XjxoXQRf2JlgLw704FPkh0p8xsmddViLGqrfVBxUYfRR8jK
rdhv9MIXoQrYNRv1sUN6jqJcA6jpDx/hFmvTJ2R+tiOHUY775Nb5zkFXgMAwWQx5
rSilot1iRqT0p64la029FfWSt6fyANAy4z0FI6K/RK6tBW5XIf/cdYdVxha7wMNK
68rKpslMhzT6S9jwU0RavadaQPfYJpYYul1uBztOr5G7j7nRtPR+JaNpwwY/6Tw/
tv6nL3hhFVcgHreRO8VghckKTGjVqnQsoqXILhubEym+jq90uuYa7jznzIZAL7or
x7310Rbi5LeTtHdF2tKq+4sWapBLfw==
=Esdb
-----END PGP SIGNATURE-----

--m6zwW9LXBH0p4nz1--

