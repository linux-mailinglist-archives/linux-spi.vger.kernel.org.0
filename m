Return-Path: <linux-spi+bounces-3354-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D8F9009AD
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC4287C7C
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA255199EB4;
	Fri,  7 Jun 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6nk7L8h"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379B196C6C;
	Fri,  7 Jun 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775727; cv=none; b=KA9oIbqRnSQm0kUL9T+FWEpkl8Dh7DH7BOGeCSO2lc1nReQF6WPY+2q1GeCUgdhQu2UrfjDrXOw4ahjynvpFWFhyF7wNfxsjmGuWWS0nzsM2BcHcc2Xzs0scfypYky8nv44KhO30B4i+AdK/xNbzlFxGBcAs7Z4UnWjPB+G/wA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775727; c=relaxed/simple;
	bh=xOhvRrUwDuC1Lk1Zuk8ngN5rgaOSWInQ819VOlEP/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIRQNTkp4HlZF0AeFqFXewthGMiVz6MQU0Cuik3GBNsCvXC3MuXlYDhaLVlor7IV+apszphNjqLU7t2Ev88IcpY9BgaySlhVL9Ldq0RaHFX24T/s+qVUghDDI7Q0NNRvbtBJCoJKJ16HrN+tGq+Zn2RXfpIoKdE2X7waY5T/Qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6nk7L8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52E0C3277B;
	Fri,  7 Jun 2024 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717775727;
	bh=xOhvRrUwDuC1Lk1Zuk8ngN5rgaOSWInQ819VOlEP/pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6nk7L8hG6D8Tp1B1C4AaE+9n+1am4qeelXE6BcB3H007R9KkwWTfbOEnanKTw00S
	 FPy5gpquzgY/IQjivBfPP+tkTuORdn6DhRClF+QWNqtt+ajbFHZzCWBWB6MjuNo5gQ
	 vrcOUG6I2S0VlACXHYLWv2OyDu8eETVCW67uqSbErcYYCwPpDlfTgR2Y9k86m9LIfT
	 WtBQXcwdsGW4vIP3dWfj2+BkJiFWnHGAUTkR6kThhoHG5zspmgDEXF2qOuc1q/wfgi
	 JWFRH4Qsqxj1Z9ZOsjEWO06ZkyjxYHfPWeX7M5PEHixupBDEokRZodKY0eXPUp84EH
	 vCVHgzEkJZGMg==
Date: Fri, 7 Jun 2024 16:55:23 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <ZmMta036RTH4CTng@finisterre.sirena.org.uk>
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
 <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
 <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
 <e8837fe0-e93c-4133-aac1-f8f0a010f6de@sirena.org.uk>
 <30944fda-6d18-4fc1-8c73-bcda4814a417@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jVB9davYYuXPVNQ+"
Content-Disposition: inline
In-Reply-To: <30944fda-6d18-4fc1-8c73-bcda4814a417@freemail.hu>
X-Cookie: Your love life will be... interesting.


--jVB9davYYuXPVNQ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 05:31:10PM +0200, Sz=C5=91ke Benjamin wrote:

> As i understand "axi_quad_spi@a00a0000" can be mapped via udev to a custom
> symlink name but in a new adaptive SoC HWs like AMD ZynqMP, Intel Stratix,
> Microchip PolarFire Soc etc. it is not possible and not good solution
> because this axi reg address can be different and become to
> non-deterministic in day to next when there is a new PL FW update for the=
ir
> FPGA part in the silicon.

> What udev rules have to use for it if you say it can be perfectly done via
> udev and "axi_quad_spi@a00a0000" cannot be used for making this rule?

This feels like something I'd expect the FPGA tools to help with, having
to run around adding random properties to individual bindings to figure
out what the IPs that the tooling has decided to instantiate doesn't
seem scalable.

> > > DT binding would need to be documented later in a separated patch as a
> > > guideline mentioned it in Linux repo.

> > No, that needs to happen along with the code change.

> The official documentation says totally different:
> "The Documentation/ and include/dt-bindings/ portion of the patch should =
be
> a separate patch. ..."

In the same series.  We can document bindings without code but we don't
take code without bindings.

> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/submitting-patches.rst

> By the way where can i find .yml or .txt dt-bindings documentation of spi=
dev driver?

The binding documentation describes the hardware, spidev is an
implementation detail of Linux so should not have a binding.  A bunch of
the devices should be in the trivial bindings document.

--jVB9davYYuXPVNQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjLWIACgkQJNaLcl1U
h9BFZAf+LlGVWXXbcXDfyaer7OdhD7BBWlnH/BtblDtd2c/cAHJJLzyiTRq9rnwe
5giPGCGAK4j/56/G+pvVo99yUhsytQk8UzWYNLcleavf/x2OhBn4kZt8oo+Bi01X
P1B0IRVbYNSEF11NUcql30W2VKWC61B89rVrKREXjiWfb2DUizShBXCSIs6dmmHz
bAxoJntmkNLHis5LMJZr+MykWqm5CZp/YYj83Y8T4FLwD2XSGYH8crTcUQxexiAd
hoC0aQGd0w08QhMqIceW1LVZBlhz7SZ4vGYtwH5fweNgQP8VSlx97TvYCMXfZe4C
/9gicxZHAEBAYDFxzVTGh+uj+H16nA==
=ddyZ
-----END PGP SIGNATURE-----

--jVB9davYYuXPVNQ+--

