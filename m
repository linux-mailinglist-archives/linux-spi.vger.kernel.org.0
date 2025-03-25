Return-Path: <linux-spi+bounces-7299-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2380A70598
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 16:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1847F18885D1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6841ACED9;
	Tue, 25 Mar 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tij9wJA1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29318A6AB;
	Tue, 25 Mar 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918108; cv=none; b=NKFJpVuAkKsTU1re18DuxGDH1rV6YPUQU0SBjWO6Zh2lUJjbxAo3hhAFzvwp8XNvhEhwelpz5U60HDyPWcwhoDNFH3zpryBlSEwiiZzfTLEDzkYK0HZNEOkUjsDaYvbryAde38wQlill/kde0QRZ4v3YXSiVkoW2HniM4UR92RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918108; c=relaxed/simple;
	bh=/sWusNH0/d1dasvfDJ3IgNRXiLJFey3D01NjmmoGY1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6poz+5plDpqp8wJ2DdqNhNlhPewbu7KTD4Jgbss1jlz+S+XmofkbSG4oxiCZuUEw8KXjnNM7qJl6QqJHeL524G1Js1LM7FaIH+DkyFA/Q0kphICY6VCAJSiey6Q1z6oCOSS/luT1zcwrfhQXd7+yZ0XYltd+tjNO1NzdR+dREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tij9wJA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA5EC4CEE4;
	Tue, 25 Mar 2025 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742918107;
	bh=/sWusNH0/d1dasvfDJ3IgNRXiLJFey3D01NjmmoGY1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tij9wJA1v1Yh9o+hC/dgptP076g+fLxSWf1M+2I2y6vb8+Ynts5xup4zmTE62n7h6
	 wcEuQ0JXZWx8Ic/NpD3/wCylr0+g4Gg40zNHgXrrVpls5GVQ/SockmwgYhmwWYF2Zx
	 awAn4bYwVNfv2ybmaijmxr4W7oNzrH8X6HJg5RW0JStl/bq6yWZVWnkU2TjgRyl6pp
	 BSgOVEQY+OtRNB5q2gQXWEEOcXeDRqsMTpBULVRrpYAhhc5ExBQBw9DyYSzswGF2ca
	 qQiQYcbSNo9DQrrVOareNfbKxUvnhjfH5aiA3TUeKwMWplL2Q3xnM+eW7E6XJf4tES
	 FCd/4oB+FlSpw==
Date: Tue, 25 Mar 2025 15:55:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
References: <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F4WbcsPWDlVylFlJ"
Content-Disposition: inline
In-Reply-To: <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
X-Cookie: Visit beautiful Vergas, Minnesota.


--F4WbcsPWDlVylFlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 02:05:01PM +0100, Thierry Reding wrote:

> Mark, would another alternative be to add something like a sysfs export
> attribute? Something that you'd write a controller/chipselect pair to in
> order to create a spidev device? That has the benefit of removing this
> entirely from device tree where it doesn't belong, but still makes this
> option available to users that would otherwise have to resort to hacks.

Possibly?  I think I've lost track of what the use case is here, usually
for the spidev stuff DT overlays seem like they're the right thing but
perhaps this is different?  If we are doing this at runtime sysfs seems
like a reasonable way to trigger it, though you'd still need the DT to
describe the controller and the chipselects that are available.

--F4WbcsPWDlVylFlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfi0dUACgkQJNaLcl1U
h9ARpgf+IUdIkCNbqFahvFbW/Ee0iGxUVn8zZMvbwl5WkkiIDfyqOt10rfwVWjXR
gkJhcwUpBLZVSoYm9+f/8y+toWLCYqdvZeuIMHt3E6l/0tVrChLqScaH9PtHI6sD
0z+BybR/AxvcDlhn4sWXbCZBufdGIp+cUmUp47N/N36nRFGaforGi22UCIct+0g7
hfcGVHmSd9MzbK0FNa5f7xTQth9LE+lch1NNg1ZK6LxdvClsMtZ6elQW9bUjz6d8
RaYHUHlxuq6mvtJot8F+c7/GAwsb5U4vTfsXxul4phRgWDH40XzeQY7ocRJ5v/N1
TPEv31ss3uWqHlZZq51wMoxJM4Qlgg==
=hzVh
-----END PGP SIGNATURE-----

--F4WbcsPWDlVylFlJ--

