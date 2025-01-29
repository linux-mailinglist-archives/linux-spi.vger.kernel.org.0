Return-Path: <linux-spi+bounces-6575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BC5A22379
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 18:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968373A057E
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A01E0DD0;
	Wed, 29 Jan 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU+nGcuT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121791DFE16;
	Wed, 29 Jan 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173244; cv=none; b=exDYUhJ9iItRhL/YElxCI463X+0PmidirRJ76WQY6A+gQ6zCU++v5Kn8SCW4qolS8K14GlEn7tXPjQ1zDr8T/qMZsEtGoP44vzl/b8iLpD2jYXec0TFI4+GBG/fqJJU9zAscQZgjEL0XyEIKjsZ3wlNbHuLkX2GxyM5RRGXWALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173244; c=relaxed/simple;
	bh=Zyf2Hutc5cy0T89YVPvTglk6LxkQN6P68b7+zGZ837w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub+/lFn8dmgTZ77IkJyuiW3N0BOYbeN5zc9+uWOlcM90tT8tl5WbGdQ9nGwm+C7xU9kiAXsJw4W9no7QrOl5uDW75FMysIq7qDIDECDpI8j6fiZWBW6FlpkUzSwqH6jVT+O1cX2Nie1uqRxGfmgLfDHuDV7kwJnj1IZ+NanZxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU+nGcuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454BFC4CED1;
	Wed, 29 Jan 2025 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738173243;
	bh=Zyf2Hutc5cy0T89YVPvTglk6LxkQN6P68b7+zGZ837w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BU+nGcuTtFSX63zvw1OdWg01bkYPv85CIq9lThHNzW8t3mpk5pTpn0NqgjviFTmRG
	 9uVfhz8se45xyyaEoJqxNWNjKuRHlArPi8QK/gm8W4zzZRChSe5OMBBJs4YmF6Xk01
	 sPPyyCDIlHHO8uk0UwfddpjuVyJA/DKOtpq6iajj1opHiHc44poT3PnxtTO9Wvohzn
	 lL6dN2TRIQYh2GV3Uk1SIrsvbOp91L6c7FJTLx3O2QtGJ7nQ+mVSh+Ti7kAb9zQvj2
	 Q4jA3SJG9OJICbc50j21pWb8Of7cSotac9oTJ3OYI880BfnboqeSHWj3FWLzUXsC/j
	 HDAusBlf+F/iw==
Date: Wed, 29 Jan 2025 17:53:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add STM32 OSPI controller
Message-ID: <20250129-feminize-spotlight-2cee53f8b463@spud>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-2-patrice.chotard@foss.st.com>
 <20250128-panama-manly-a753d91c297c@spud>
 <e3d01bce-a7d4-4690-8a2f-3bbb1ee5ccb7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="klBchq5Iv61GqXw7"
Content-Disposition: inline
In-Reply-To: <e3d01bce-a7d4-4690-8a2f-3bbb1ee5ccb7@foss.st.com>


--klBchq5Iv61GqXw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 06:40:23PM +0100, Patrice CHOTARD wrote:
> On 1/28/25 19:02, Conor Dooley wrote:
> > On Tue, Jan 28, 2025 at 09:17:23AM +0100, patrice.chotard@foss.st.com w=
rote:
> >> +  memory-region:
> >> +    maxItems: 1
> >=20
> > Whatever about not having descriptions for clocks or reg when there's
> > only one, I think a memory region should be explained.
>=20
> ok i will add :
>=20
>     description: |

The | isn't needed here.

>       Memory region to be used for memory-map read access.

I don't think that's a good explanation, sorry. Why's a memory-region
required for read access?

> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  resets:
> >> +    items:
> >> +      - description: phandle to OSPI block reset
> >> +      - description: phandle to delay block reset
> >> +
> >> +  dmas:
> >> +    maxItems: 2
> >> +
> >> +  dma-names:
> >> +    items:
> >> +      - const: tx
> >> +      - const: rx
> >> +
> >> +  st,syscfg-dlyb:
> >> +    description: phandle to syscon block
> >> +      Use to set the OSPI delay block within syscon to
> >> +      tune the phase of the RX sampling clock (or DQS) in order
> >> +      to sample the data in their valid window and to
> >> +      tune the phase of the TX launch clock in order to meet setup
> >> +      and hold constraints of TX signals versus the memory clock.
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >=20
> > Why do you need a phandle here? I assume looking up by compatible ain't
> > possible because you have multiple controllers on the SoC? Also, I don't
>=20
> Yes, we got 2 OCTOSPI controller, each of them have a dedicated delay blo=
ck
>  syscfg register.

:+1:=20

> > think your copy-paste "phandle to" stuff here is accurate:
> >       st,syscfg-dlyb =3D <&syscfg 0x1000>;
> > There's an offset here that you don't mention in your description.
>=20
> I will add it as following:
>=20
>   st,syscfg-dlyb:
>     description:
>       Use to set the OSPI delay block within syscon to
>       tune the phase of the RX sampling clock (or DQS) in order
>       to sample the data in their valid window and to
>       tune the phase of the TX launch clock in order to meet setup
>       and hold constraints of TX signals versus the memory clock.
>     $ref: /schemas/types.yaml#/definitions/phandle-array
>     items:
>       - description: phandle to syscfg
>       - description: register offset within syscfg

:+1:

> >> +  access-controllers:
> >> +    description: phandle to the rifsc device to check access right
> >> +      and in some cases, an additional phandle to the rcc device for
> >> +      secure clock control
> >=20
> > This should be described using items rather than a free-form list.
>=20
>   access-controllers:
>     description: phandle to the rifsc device to check access right
>       and in some cases, an additional phandle to the rcc device for
>       secure clock control
>     items:
>       - description: phandle to bus controller or to clock controller
>       - description: access controller specifier
>      minItems: 1
>      maxItems: 2

These updates look fine to me.

--klBchq5Iv61GqXw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5prNQAKCRB4tDGHoIJi
0tiOAQDd9BF6yvC5/EHySEFWBLCC14sZW3m0j9Y5sHG+IFLYJQD/SiGc3aoOaqRR
GvI0wjS/7qTgY+FgXginJwblZbIzNAs=
=C2X+
-----END PGP SIGNATURE-----

--klBchq5Iv61GqXw7--

