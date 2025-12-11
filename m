Return-Path: <linux-spi+bounces-11859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F5CCB4811
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 03:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2200730014E8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB772610;
	Thu, 11 Dec 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdCgnk5f"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B796296BA5;
	Thu, 11 Dec 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765418634; cv=none; b=PoPPfRYCD/zJpoyj7vE7FUQ49Sm0Y9JttC4I+sXMB3QmE3NZISSNdB7T3Zkiv4Jlv/ote1Cpuch+zrihlR3+twOdPjNu7OgC/j/yM79pRLq2soHA5W6c2/xEeyscTqmcTIMDQfP3S+w8H3ZaYevY0XfKO/U2e/hlECXt9mkgs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765418634; c=relaxed/simple;
	bh=PfABCHBuQxs6JSsRsLlCjnA2XQqe7tsm9POCd9VldsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRIzHCI+nl1nhlz/LNrdfJD+Tt++x1/aSdABfEQv8rpAFaSp2u6Nyw6hWxmFZY4dMvxnkTs6rieMCtSRVrbBvjg4Bj9vIi30TzTwtADyTqGObDMwrEzFUutvjiJlKukC5azdbkQgpq09zD/2K9BsEl9A69NV57mBzB0OZoDq4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdCgnk5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BF2C113D0;
	Thu, 11 Dec 2025 02:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765418634;
	bh=PfABCHBuQxs6JSsRsLlCjnA2XQqe7tsm9POCd9VldsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdCgnk5f/yQhFt4awJCDYh4BuXejOlOrAgavcyslqy+eYqxRhHLuCmeMX/smAKoGs
	 bIrUF0PVCFcJ31gVxZAC5XAi/Xhn6hRdEqpfv1VxKYOjE0VtubSkFnQDrY0ymoMLhu
	 OHGqCGJNVJLH+BfEK0wvhGQb1PGUb9F3wymnmWL3zigs222SFBvfkP49IvmQ7tgkc+
	 wMXHAA9TKb/NoIbIAQ4wSzst8P7VSYmPxniebSG6WXt1GdhyQk5mE1wCJqeQvQ2JNO
	 Lz36zsXQtH//QZeDvJBLLT0zPcO8/grRmvOrQJ9O8+RFtGSSUydtNcqOcgbdjYQHEh
	 FLhf7qEtp6tVQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id B60241ACB974; Thu, 11 Dec 2025 02:03:51 +0000 (GMT)
Date: Thu, 11 Dec 2025 11:03:51 +0900
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Michael Walle <mwalle@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 4/8] spi: spi-mem: Transform the read operation
 template
Message-ID: <aTomh0TJmxn9Raqt@sirena.co.uk>
References: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
 <20251205-winbond-v6-18-rc1-cont-read-v1-4-01bc48631c73@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sH0fLPh9o6r8ZzpK"
Content-Disposition: inline
In-Reply-To: <20251205-winbond-v6-18-rc1-cont-read-v1-4-01bc48631c73@bootlin.com>
X-Cookie: It's clever, but is it art?


--sH0fLPh9o6r8ZzpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2025 at 08:38:55PM +0100, Miquel Raynal wrote:
> As of now, we only use a single operation template when creating SPI
> memory direct mappings. With the idea to extend this possibility to 2,
> rename the template to reflect that we are currently setting the
> "primary" operation, and create a pointer in the same structure to point
> to it.
>=20
> From a user point of view, the op_tmpl name remains but becomes a
> pointer, leading to minor changes in both the SPI NAND and SPI NOR
> cores.
>=20
> There is no functional change.

Acked-by: Mark Brown <broonie@kernel.org>

--sH0fLPh9o6r8ZzpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk6JoYACgkQJNaLcl1U
h9Apggf+NLpfrOuDb9NLagToe5Ui9BBZrHFDahLhw6zxtnGzhcm/Le9SGK5MvTP8
5s3yAC7PKp/BraqVV8YKlWFbM3CsK4f2ml2KeZn9ndKUHOz10T1KhLx5p5mTpilI
Q6B4QPICU/Jp5sE1cE/j1bDGKYQZrP37MwCjRjn5HNI81ieAjEqaq5Q0U/PXeQCC
iQTavX3bnrFCBkUF1U+TVgEaR5/6iWIm2cHNvuLXzTHibRrFRUZ6+lKnilRgi+3H
gziVWO2WJANC1H86tDTL8KP+GqP4UrADZSjLPuiBdzaSOKGJMD31/RuRiB4rP8AN
p5EmiusQeqr8ha0cucrC5v5vLq9wlg==
=hBGJ
-----END PGP SIGNATURE-----

--sH0fLPh9o6r8ZzpK--

