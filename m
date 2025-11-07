Return-Path: <linux-spi+bounces-11120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A582C40F83
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 18:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0418D4E2E86
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74B2248B9;
	Fri,  7 Nov 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiD6Wk42"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEB38DEC;
	Fri,  7 Nov 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534843; cv=none; b=Wm7O4G4rIydJo+bt9kFXG2Qvg86uBB6yptuBLOtADjVcgl3+iuI+jHLAXGYCrhmB/IKbcge05szTbxiSsT2lT7FHY30LqFe4JvRM/PYzfoPappn3qcmjKvtqOndvEAPioj2M6jJrBjVv4VhkhaaQRdoZB3BZ0PCr+hCeHrUhTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534843; c=relaxed/simple;
	bh=CrlVePztH8nTQSA2LjyBVfwXsj1YcNT+in2aDO2QsRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOA6RdDSz0tbsUszzWZOReuZJ//uLeJ5OmuPDooTHYyoUZZfS0VrFtqqWn+Wm+xGq0IPj/vko0CmAEtguf5/B282fmlDp4od7C0/wVB514FFiKfpgUJkF0ml9R12/xR2OQWNKoPqb18Qylwxqe2d0CxMarWFavjKGfnwW6egFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiD6Wk42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8D2C4CEF8;
	Fri,  7 Nov 2025 17:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762534843;
	bh=CrlVePztH8nTQSA2LjyBVfwXsj1YcNT+in2aDO2QsRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiD6Wk42k76uZNmvKVgFryuD3Bx+Dl2OWXtKLC5yVbkrakTswJZcUdzWQddB5K+5S
	 oCagByaaoI0j3CEissAL+aXxA1tYPrB//3ZUqMgZ5U1K0Qkxf93PBEoxEXndxe2AyN
	 Wd6F/oCob/9/SQQba+2FGXFhee3U5X72pfLDrshKKPQ6di8QruJwffxqqffyJJYYo/
	 z6GA3vQLyDZ1w1GBIOdxxE31NFhNkoxBHAcHzNvE2wAo/19tBx4h2+cTBZdTnV1N+i
	 JoTUwq64X4PAf56soPTIU+1EEAoD44V3SbPdYh4Rx6VjzWpITyqyz7He1ksSZzTdmS
	 g0khZd3yWbIXQ==
Date: Fri, 7 Nov 2025 17:00:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
Message-ID: <20251107-overprice-reselect-c3a742a2d8b3@spud>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251105091401.1462985-12-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251106-anchovy-font-33e9a3b4efe8@spud>
 <TYYPR01MB10512F74C2D89BFE757AC7E0C85C2A@TYYPR01MB10512.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8dYth6u/2Yr8gI8Q"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB10512F74C2D89BFE757AC7E0C85C2A@TYYPR01MB10512.jpnprd01.prod.outlook.com>


--8dYth6u/2Yr8gI8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 06:02:01PM +0000, Cosmin-Gabriel Tanislav wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Thursday, November 6, 2025 7:58 PM
> > To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Mark Brown <broon=
ie@kernel.org>; Rob Herring
> > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dool=
ey <conor+dt@kernel.org>; Geert
> > Uytterhoeven <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.=
com>; Michael Turquette
> > <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Philipp Zab=
el <p.zabel@pengutronix.de>;
> > linux-spi@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicetre=
e@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-clk@vger.kernel.org; Conor Dooley <conor.=
dooley@microchip.com>
> > Subject: Re: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: docume=
nt RZ/T2H and RZ/N2H
> >=20
> > On Wed, Nov 05, 2025 at 11:13:55AM +0200, Cosmin Tanislav wrote:
> > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four =
SPI
> > > peripherals.
> > >
> > > Compared to the previously supported RZ/V2H, these SoCs have a smaller
> > > FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
> > > being the clock from which the SPI transfer clock is generated, is the
> > > equivalent of the TCLK from V2H.
> > >
> > > Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
> > > entirely compatible.
> > >
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.co=
m>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Why is this a v1 with my ack?
>=20
> I forgot to bump the version to V2. I've sent V3 afterwards to amend it.

Ah, I didnt notice that. Thanks.

--8dYth6u/2Yr8gI8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ4ltQAKCRB4tDGHoIJi
0p0VAQCHn+nh9KAR8Ekz0Y8X0sS0lpxjC3Wvj8Iie/dDNKAWYwEA4vWuKYtGRFGT
9WvuIoAJHuKnwtdBfC4q5WumjAlwFg4=
=fA0E
-----END PGP SIGNATURE-----

--8dYth6u/2Yr8gI8Q--

