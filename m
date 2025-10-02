Return-Path: <linux-spi+bounces-10426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D061BB381B
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 11:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB11C6633
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73D53009F2;
	Thu,  2 Oct 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqUEdovp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A132EAB94;
	Thu,  2 Oct 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398300; cv=none; b=kjLSIG3M0y6hNvA/AivuPN/G34gfukYLq5LQvD3Tp/hKKwouWRmn7TDihNLkYUWPg9X1v1u6JmmGhXQjhq+/tvwGCmBZdFJGRjIFLHrtTdKFIV2+wKo00RvKZgrUO9qsfK9Qw+aUQ5u+rnHq7FKM3wlA6FzvO5ry3HJ9+mynExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398300; c=relaxed/simple;
	bh=t93drVVKAotBUg+WKPJcU7hqKum1hFKWPlrIcqVBjdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0tfT2JXzoZgf7V3oYeVYMcc19uy7UtJipRofo6tzyryEJU27Q35S2Z/wftNRUTE094QGc12/w3ojmFlpG3G4HpEtsWUJSzGZntG0BBa7bfJ8UMSQ++qpGXZ/opgLzMj5Zy10i+7dBsh6olus+ZZLfi1zHi68KnOFb3q4AmU6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqUEdovp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126F5C4CEF4;
	Thu,  2 Oct 2025 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759398300;
	bh=t93drVVKAotBUg+WKPJcU7hqKum1hFKWPlrIcqVBjdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqUEdovp75uhgWzmgp6wTuN9Y9mvnhMNN2WaUeaQjNCPeMcB6XM6Ma9Gdx0azwuIE
	 xlqI6HZ3NeHVMtnGYQzwu1p0PAJ5RxbyEjHv+bXpHzgZ346/7LcMbVOEk4i/w3byg8
	 W1hCo3mx4xnarWqVkEYjx/RHsohU80NUUgE7/WPzNl38FKTah4ALnaRSpKywcPCblu
	 ivU8th9oludVPFDsuwqaVBJJhi8qLzRi8ca9L/00kEw2XoVaxAHCBUbur1YluydiP5
	 ngtgV2dya5fPZulwn97nOHYIu7usNTZyVmzE3/qTLE7GWkkvSay5xllmE7AUt4sGyk
	 krEKmorLDs0Iw==
Date: Thu, 2 Oct 2025 10:44:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Jun Guo <Jun.Guo@cixtech.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] arm64: dts: xilinx: add soc-specific spi
 compatibles for zynqmp/versal-net
Message-ID: <20251002-unloving-unrobed-b35543f729f2@spud>
References: <20251001-basics-grafting-a1a214ef65ac@spud>
 <20251001-cheesy-shucking-c55431bbcae3@spud>
 <101a83ba-cd2b-4080-aaa3-630652c33786@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5l2glOle2OF9pEWG"
Content-Disposition: inline
In-Reply-To: <101a83ba-cd2b-4080-aaa3-630652c33786@amd.com>


--5l2glOle2OF9pEWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 08:06:47AM +0200, Michal Simek wrote:
> On 10/1/25 20:31, Conor Dooley wrote:
> >   arch/arm64/boot/dts/xilinx/versal-net.dtsi | 4 ++--
> >   arch/arm64/boot/dts/xilinx/zynqmp.dtsi     | 4 ++--
>=20
> Acked-by: Michal Simek <michal.simek@amd.com>
>=20
> Do you expect to go via SPI tree or via SOC tree?

Via SOC would be preferred, there's no functional change and I don't
think the dtbs_check warnings are worth doing something abnormal, as
long as what's in linux-next is clean.

--5l2glOle2OF9pEWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN5JlwAKCRB4tDGHoIJi
0h4RAP96k4tDLO0xTAF/l6ozGWzNdANIQavjstn7ipfFMnBx/AEA5qgye2Cic4lt
7ym3em2EmaVuzRaYJRWXVvj0m3vuPQU=
=KW56
-----END PGP SIGNATURE-----

--5l2glOle2OF9pEWG--

