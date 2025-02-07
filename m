Return-Path: <linux-spi+bounces-6656-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D1A2C364
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459941642AE
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D181DF738;
	Fri,  7 Feb 2025 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekP5Lsbi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EE9454;
	Fri,  7 Feb 2025 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934329; cv=none; b=A5Ch+GtWpjUq29XLDZ14KvgYqtELLcpblGO8063g0143DMX9wA1ai/Km0bdJjop0ti0KNzWu9j//ycu9iOa37PnlGoQ/bePMGC+PvUhxAG2BwtiovQtfMiaVUibxytyv6jKly5BiPY1Nvz6kZ/L46Rutqxyp+p2AxwggQsPhamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934329; c=relaxed/simple;
	bh=eFIZAVuxn5LNa4zpyntsKVLMFZa8gU8T5EHqVMiE4xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1o/UQQthTWVY9OWrZx1fQnj0paF/x/DUy1//k/DAOWgRhX8dpHKcyPDfEjw2jzyZoSxlt7I3QZZUuWlWIBEfVwyuy7vknV57QIJv7EBkLHU91deX0f9nz8+oZEbxaHxVUfNh+gOhygLaRpvv2C5ZOW69De5wOZfHOAxreMS+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekP5Lsbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D19C4CED1;
	Fri,  7 Feb 2025 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738934329;
	bh=eFIZAVuxn5LNa4zpyntsKVLMFZa8gU8T5EHqVMiE4xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekP5Lsbih4Qrni6R8KYuVNRJ8WRlBAeWg+Hu0ONFhF6aBh51clA7BNtyaooC8i1e0
	 IAmVPKamC8BBigHoQMzjldd/m/rlgckmQaV/RVU6z+QVnnJzcGmj7vjTX65HuDyNfJ
	 YgAfkv1OvdxhFW7kqg/U5JTZ8gUSB2NCVKdKdqcVQSH2AKxOYDSrp1M54LwJiAskUn
	 9kCEd6/QBw5cHMhu6/8FfvO+11p74OOWW5bdWQbT2bi88J5mbBg2JDNDtJr+CL0GVy
	 aA0e2KK0z8LJurpjLJQ8FTZ9WOH6efVoCPlAYlX5B4E2Ih/aQxD8jQao5S8TpcFIOH
	 ptCuv/sgMmehg==
Date: Fri, 7 Feb 2025 13:18:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH for-6.14 v3 3/4] spi: atmel-quadspi: Use
 `devm_dma_request_chan()`
Message-ID: <175b903c-59c9-40d6-baff-d5b8dc996318@sirena.org.uk>
References: <20250207124802.165408-1-csokas.bence@prolan.hu>
 <20250207124802.165408-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yBiLvRP78GmtPzGu"
Content-Disposition: inline
In-Reply-To: <20250207124802.165408-4-csokas.bence@prolan.hu>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--yBiLvRP78GmtPzGu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 01:47:58PM +0100, Bence Cs=F3k=E1s wrote:
> Leave releasing of DMA channels up to the devm
> facilities. This way we can eliminate the rest
> of the "goto ladder".

This is just a code cleanup, it's not suitable for a bug fix.

--yBiLvRP78GmtPzGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemCDQACgkQJNaLcl1U
h9BPmgf+PzP0hQysLpvxFfaX3oeQdksaEVIPruNAjK9B1f8EI048STKEjrQuZdrA
bvp2WDGRMPu20hr9XeavQTfF0nfNt6fmjdD6ZOolH+pGJg6roepiZfRl9ALIdjQp
3Wve+bFF3/nYUJqj0jlG/H+Pyx//sJTaBFKTHGe+dTkCGw6sJ/Nd7poI5DE9dMbX
zPyuUVFqLEXAueYDdDb1pzaAwcNip3eAfcAtj+EtO42lWRIPL03cr5Ap+i/f0DX2
X0+OUpNFy77gmoMauGmQAZ0HuFOwKizFq+mTkbSRUQBtSF/z6RqKZ9W3bwlUAYqS
aG9u9rdrdC3/wcxaJNW+c1A0suIVUw==
=82/r
-----END PGP SIGNATURE-----

--yBiLvRP78GmtPzGu--

