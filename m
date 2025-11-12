Return-Path: <linux-spi+bounces-11170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9AC52C69
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C070D348831
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B72C08D0;
	Wed, 12 Nov 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFtHcz/n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772112B2DA;
	Wed, 12 Nov 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958412; cv=none; b=ICret55VJoQPaUW8ldfvqly8uwax/Bzi9UpYOvVmUu/fGVmGddBTm2B3sNPQ01EGJqpc+5CAnUmr97wgk3cn0+JM7QqEpwbfe9wUzzHjGvYL/DFQyaT5hoFqLPEwBy4Czd7SIf1bI4tXvd/rboVQ1dgdVRBJXSY4X70RhQ04Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958412; c=relaxed/simple;
	bh=gFZwBjqnrl19OxTrYC0mLSsa806uq14xs/QzjVBVgVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIsSLFFYKZkTUXHfqP0hckCNp4P8dUwqOBQl0bF0EVyhOhztTdbgXdpOxKd9iS0ayCk/w22A+cavKa2ue3YSokU2BzlpYbPPpY8oCYSUhOWujm5pDlOwty6Sot4xT5SYC0TJJ+oF5EfxaIY46qxKJeMBx1PgUVSsF90YjrZLTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFtHcz/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975F8C16AAE;
	Wed, 12 Nov 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958411;
	bh=gFZwBjqnrl19OxTrYC0mLSsa806uq14xs/QzjVBVgVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFtHcz/nDVI4vRMyJ6ir9z+uaWieVNvrv/urkCN3hmP1T5Z5sEfQWQSTCHi97Iv1D
	 m1L6ydPm7G2Dn2bKK8ZfTJst7ba8leenJH6Gzg4fU4RSnKu0l8XgoMk9scaB9SUPmY
	 Hkx4w1MpppUSdlO+t+1wLUFXHqv1NCJQcU4YXtx36/j63SBS3X+yHetDj6I6EHv11v
	 d4zmY01N9C8O84EaQF8lBEFqYXNTfTD96kfrYGF18zS7An4EAmitwR57t1QwI7iJ4r
	 9BPzzTDWqHCEE7NbG+ZVccUAIre5wrycWBcZKS3bId4P7GatzFSI8Pw/52qn4QfHvm
	 j7oTVUA3zxMvQ==
Date: Wed, 12 Nov 2025 14:40:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v3 3/3] spi: add support for microchip "soft" spi
 controller
Message-ID: <20251112-eradicate-onslaught-f6cab44cc6b0@spud>
References: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
 <20251107122104.1389301-4-prajna.rajendrakumar@microchip.com>
 <20251107-emit-slip-b1ab5f7d5591@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="myID+3ZAXg5EfgBj"
Content-Disposition: inline
In-Reply-To: <20251107-emit-slip-b1ab5f7d5591@spud>


--myID+3ZAXg5EfgBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 05:15:12PM +0000, Conor Dooley wrote:
> On Fri, Nov 07, 2025 at 12:21:04PM +0000, Prajna Rajendra Kumar wrote:
> > Introduce driver support for the Microchip FPGA CoreSPI IP.
> >=20
> > This driver supports only Motorola SPI mode and frame size of 8-bits.
> > TI/NSC modes and wider frame sizes are not currently supported.
> >=20
> > Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.co=
m>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Now that I think about it, this should probably have been
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--myID+3ZAXg5EfgBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRScRwAKCRB4tDGHoIJi
0mziAQCy9+R2tv3ebHyzPAgKiOwVWpPQKfWM3B1FLvgEnXVZnAEAsFs9Vv2zmO69
zEn3f0mnZEZG6betXCnkGJ/XCk4uNQ8=
=pcfB
-----END PGP SIGNATURE-----

--myID+3ZAXg5EfgBj--

