Return-Path: <linux-spi+bounces-11824-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DDCADBC5
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBD9E301C653
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35402E92B4;
	Mon,  8 Dec 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2wXssGH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D792E8B7A;
	Mon,  8 Dec 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210995; cv=none; b=NM2T176aUfQCt2pS4YYgvvs/Nd1hPiJ5O3fDDlZwki02VD33ck6O1sPMd485ch5mt8/O1zOSdKDk1BXHI7lehyyRYOliePEbBFnzBqhMI28SvKAkdPLK11NpXauejabNsohNMRkQiOImSgBNawrWHiQCIEVX8QgVsuZl+zHLTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210995; c=relaxed/simple;
	bh=+NtQkaPiW9U2Wn9e0OyvKDvF2to4uVN5uoc1DZKXqtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av7pAbxjzlI8yQJgrxcK28CwPBtFF17zK8cy9cNvwHgDKLB877h9hqCNG+xM6oXZ5ZYZ7ka8nl3vtLG1R7qfFHQ7HcJjKPaxTnvq0YTRRDvATAVcyJKoyTRgU7qmME7SIAY25yweN68zVzDJXMV9RmO0tjP6Z1DcpdAm7ZJufuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2wXssGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AD5C4CEF1;
	Mon,  8 Dec 2025 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765210995;
	bh=+NtQkaPiW9U2Wn9e0OyvKDvF2to4uVN5uoc1DZKXqtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2wXssGHjalB9Jkwov9594Yx4tM8Zx94Ats0PRMzozd9QRiXK1S3qyZSm/qnvThb3
	 KdG2wCdNNBf1eDidzhOC4MqVoLKekWdMRiUY/Id0nOpe8BDNISMfNl4Vi7heSYKSfB
	 CYl5iDIkCQNOLeH/ckOu3U/9cIKR1j3KzEJNP7TYR6IPTfzyK1QmQdhnQ6r/vJ3PQG
	 a+JTfTmetqQJLDOGM4sybzL6F/XY2hgtXj+6QUSweV+ras01OboWBCQ991fGjT5AXu
	 iH0vw8h21B0Z5nKHn0j1ES09eoQvmY4Y1AxL2HuA9oqjiiJMBLMCwRXAAmSH94WDfa
	 xRQpfrgHaVFqQ==
Date: Mon, 8 Dec 2025 16:23:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: microchip-core: Fix an error handling path in
 mchp_corespi_probe()
Message-ID: <20251208-pounce-scaling-42dd8a174901@spud>
References: <a7aaff1f28a83303a288de2914724a874fe1a11e.1764969247.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZjQYG6il/wPDbo31"
Content-Disposition: inline
In-Reply-To: <a7aaff1f28a83303a288de2914724a874fe1a11e.1764969247.git.christophe.jaillet@wanadoo.fr>


--ZjQYG6il/wPDbo31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2025 at 10:14:10PM +0100, Christophe JAILLET wrote:
> mchp_corespi_init() calls mchp_corespi_enable_ints(), so
> mchp_corespi_disable_ints() should be called if an error occurs after
> calling mchp_corespi_init(), as already done in the remove function.
>=20
> Fixes: 059f545832be ("spi: add support for microchip "soft" spi controlle=
r")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ZjQYG6il/wPDbo31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTb7awAKCRB4tDGHoIJi
0hwAAQCozyor2O9vx8dRHp6weQondI1wDiYt/OVfxZMH/bYYAgD9F3KYY5fcF6ux
Upcw2qVwoE55Y7lVoWv6I2lHImySVAE=
=ffMp
-----END PGP SIGNATURE-----

--ZjQYG6il/wPDbo31--

