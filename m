Return-Path: <linux-spi+bounces-7371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD709A7676D
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7C7A2D1E
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C572135CE;
	Mon, 31 Mar 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJsyv5B8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F53234;
	Mon, 31 Mar 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430160; cv=none; b=NgeEl3dD9Lo/mKecy4Pq2ljc4JTMMdT0YW+NDhWSBxtcnF5trrbukqv0sJkGbhOUpnYz363wTSlzYh/RczftvEzHD13m4u2NLQpsvFEiKylgOdschv5fIgZB62nG1VlnKYUC/LKzrIHb90Vl8fMWepnabyMxoac400zQIjv0y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430160; c=relaxed/simple;
	bh=d28ybu49teeHHXEma/cD2nF7x0uH3LgBVcfGEuOwjbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS0qF+Mw9rEiI4AZmHmhhsYUnfW2/idTA+KN3hHHfZilCARvwQhLp54tkO7nDmFxyefQvAfG+M8k+XSnmJNy7xSB4oRwQkvcIaV+ysx9JUu09uWvMJgtrvwZzX4MnO3hBG+rOLwkaA3+S64CHZbqruzE8EXkEu9bbggBwoqKh5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJsyv5B8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078C7C4CEE3;
	Mon, 31 Mar 2025 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743430158;
	bh=d28ybu49teeHHXEma/cD2nF7x0uH3LgBVcfGEuOwjbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJsyv5B8dLZkZGa7j+YmqIbYg8TyZD/rV3JehPm1CK3LhAYpxWZnnc38UCQTssY6/
	 U7apE7igeCqbQeD9GS/4NO7wuOWNV0tCeuTet24j4jjnoUX1JST/hX98V7Q1QEAmFe
	 zifFk6540qBSD8U/mx63BRrf8KLGConpstX45SUGhZmP6ieNVXDZlWpgj+rG9vPldq
	 /CPg/PVQCPR1aUARxrRKUaGhXATrq4DZ9G+FSW/FqtDpTKB9ofXmdPQD37oa/B0Qn/
	 OFkV5uDtH1D4PtOZUSMNMu6y5YIkhkqyHhrV/Y0BsbyIsX8vj2+TgUl5bzg/fULWEb
	 LeWwpe7cxuAag==
Date: Mon, 31 Mar 2025 15:09:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Vishwaroop A <va@nvidia.com>,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <99e23453-04a3-489a-b50d-c4c8eec9c326@sirena.org.uk>
References: <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
 <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
 <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
 <9760cd70-cbd6-4865-92b9-b48eb2cdea55@sirena.org.uk>
 <69aaba89-10c6-408e-b328-c3e31a1aeaf7@nvidia.com>
 <3b0f4fee-d46b-4086-9d63-f4093b52748e@sirena.org.uk>
 <c81d7e8b-bcce-46a8-8938-c1ead71a988d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NN1C5YwfL50hWv5J"
Content-Disposition: inline
In-Reply-To: <c81d7e8b-bcce-46a8-8938-c1ead71a988d@nvidia.com>
X-Cookie: The Ranger isn't gonna like it, Yogi.


--NN1C5YwfL50hWv5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2025 at 02:11:35PM +0100, Jon Hunter wrote:
> On 31/03/2025 13:44, Mark Brown wrote:

> > Why would you need to use a compatible string for anything?  I'd expect
> > the overlay to add the entire new device, compatible and all.

> We need a compatible string for the SPI device in device-tree. Sorry, but I
> am not sure how we can add a SPI device without one.

> Can you confirm what you mean by 'overlay'? To me an overlay, is purely a
> device-tree overlay and even if we have a device-tree overlay, we are still
> missing the kernel driver part that matches the compatible string.

I would expect the overlay to be a device tree overlay and to add the
entire definition of the device, not just patch the compatible in an
existing half constructed device.  I would expect the driver portion of
supporting the device to happen as normal, if spidev makes sense for
whatever devices these are then then that could be upstreamed without
adding them to any board.

--NN1C5YwfL50hWv5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfqogkACgkQJNaLcl1U
h9Bpjwf/XOd6Yi/IMXBqmmEYx3YawbjauWiLhFVNVXsRuyG8pqImhTrg1c18lkBK
5UA3ZR61auRwTT5eLKNIXen1mH265jaVk6yxuxtr/H8/SqVQql3f9tz89muqaR1K
AE5Q+cxD3A/vUuVxbrWwRePOc0eXxNA6JQekGmcrooDmGCGy7xQsJCGME8q5t4Yr
34kYYHH89MjNZkMdhpOQiaIAqBWndVh+FexqiY2saR/o+iDvhzgoacMym9XhdM5f
p51rcOniKwi1cqGDeqMiqKS5BVaQuvmENng9Ptx2f6ZLNdmZrgTFVqguKHxTtmcl
aDDuCgMU3RCig4CJ/iHueWEtiu4DnQ==
=Kfc4
-----END PGP SIGNATURE-----

--NN1C5YwfL50hWv5J--

