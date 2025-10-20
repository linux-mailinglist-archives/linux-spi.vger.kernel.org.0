Return-Path: <linux-spi+bounces-10742-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623DBF2F8E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 20:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3D44F916C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6892C0268;
	Mon, 20 Oct 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctr6YqQA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C71F1932;
	Mon, 20 Oct 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985593; cv=none; b=bCrTIM3PDvNg/69GQzxW+6Gub4H1RnCvj7NRWMRieei+PyFKbj8KbM/OKqlocPcqjdlaOSKdf/EbaW6mnF8wHivej6emBmCzyBpmSiAQSVrx/Zh3pV8OxnbPwgSajNztr6F2l/rhKY6sMRd8MOUb2XbUUFi84MrHyqdxrlAYTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985593; c=relaxed/simple;
	bh=6ZobidfUZRr5YPSXECJ1ntZWp1zK3/rG9AFA9LwreOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNwY2K1F9FVVrgbgwJJypgtAtY4ukABOXidJM8VtJaQBFMcYwmEwTYL2KPbmOLVOs2RFz1qOs9QHzxX67EYIJor5+lJKJ1q6w7RtXc1uiql9G2MedVrOhfJbzrixJZFIgFKq43pnLopua4nAPyemzJj5DFyyhY6nc2a5Xi85BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctr6YqQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5788FC113D0;
	Mon, 20 Oct 2025 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760985593;
	bh=6ZobidfUZRr5YPSXECJ1ntZWp1zK3/rG9AFA9LwreOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctr6YqQA+4Vz9znc5SmDWjoWNoC7vIiLZeSCug4aqfz60YDh/3MgX3T5+A0/Wsk89
	 N5ck19xRI1ebu6nsXI2NkXBC3FXm8hkGiQt1AOMbbeI4BAifAlDocjsGZho39tGSJl
	 hNa9jMP1IC2xDf5EujbJf4kPUpO7IN4Iqab5+efkAOSXyapYApU4K+tC+BiZlfKD0P
	 XtOGsecGDA9unwpOsMgLeldBOnZq2WKodKTFBU+1S76PWzdpTvuxjn/4NKtbIKeOiK
	 DFserqdy/ZWzQpRn+nhSjmpVLmt+wTFcR75VX4a8IVoGurwo+piXrGO6jrdCioIyjm
	 hDEX+Wa7SEfCw==
Date: Mon, 20 Oct 2025 19:39:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, han.xu@nxp.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <20251020-florist-campus-a397bf94d129@spud>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
 <20251020-blinked-primary-2b69cf37e9fe@spud>
 <b28d71c4-d632-4ee5-8c4b-270649fca882@riscstar.com>
 <710c36f2-3551-4738-a965-f1564416348c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K0j4x5+NWZnVy7rE"
Content-Disposition: inline
In-Reply-To: <710c36f2-3551-4738-a965-f1564416348c@sirena.org.uk>


--K0j4x5+NWZnVy7rE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 07:26:17PM +0100, Mark Brown wrote:
> On Mon, Oct 20, 2025 at 01:06:46PM -0500, Alex Elder wrote:
> > On 10/20/25 12:39 PM, Conor Dooley wrote:
>=20
> > > > +          - spacemit,k1-qspi
>=20
> > > Are the newly added resets mandatory for the spacemit platform?
>=20
> > This is interesting.  I never even tried it without specifying them.
>=20
> > I just tried it, and at least on my system QSPI functioned without
> > defining these resets.  I will ask SpacemiT about this.  If they are
> > not needed I will omit the first patch (which added optional resets),
> > and won't use them.
>=20
> It might be safer to describe them, otherwise things are vulnerable to
> issues like the bootloader not leaving things in a predictable state.

Yeah, if a linux driver requires that a bootloader set up a clock or
de-assert a reset etc, then the binding should mark them required since,
as you say, a bootloader change might do away with that de-assertion.
Additionally, the stage doing that de-assertion etc could be U-Boot
or barebox, which import devicetrees from Linux, so making sure that
the resets are present has that benefit too.


--K0j4x5+NWZnVy7rE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPaB8AAKCRB4tDGHoIJi
0j7DAQCssl1u//5OdqF2WI3Y8/8tpB69AxoA9vxxUcT06wOMOwEA4jhf4n774nNx
AWp2GcFRl/p1el8AYLR8ebrER5zBeQ8=
=rH4o
-----END PGP SIGNATURE-----

--K0j4x5+NWZnVy7rE--

