Return-Path: <linux-spi+bounces-10233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81AB94FCF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 10:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D6B18A6771
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8A31BCA3;
	Tue, 23 Sep 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7EdvDgV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62331A546;
	Tue, 23 Sep 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616071; cv=none; b=gR5YeCcupRlngNqBE13DmSof+f1nbznOWwtT1EgaXcJJMrvYy+5IFlAOxb4TfNfkC1f92odF3PjTZMuj83pBuEptTB/nFhG/IvfLxzDjrMgYIxHorTMSAztKnV8kPPb9TStBCZqaDz/2BHf/9wK9dtsa81XLlgJb8mzzB0i4qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616071; c=relaxed/simple;
	bh=DpOw3esgxv6fryqqMWiEbCIzH82geJydVvITLMOkr54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3mHwTi2BHZNsJhcSE1rvJaA/B/M+n+YZT8IWKCHVhzuW+RLUYSEn1TbvnXCjj3mnJlhvc8QHiyQM9OAghJyZks2L+eTAcPY7e0K9HCIlHwION1cGH/lDHVcB2yjqRd/HU472kaMAdfBIs/znml1KnCA9ONdbDgK7Ct9oBVJX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7EdvDgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2770DC4CEF7;
	Tue, 23 Sep 2025 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616070;
	bh=DpOw3esgxv6fryqqMWiEbCIzH82geJydVvITLMOkr54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7EdvDgVwmk0J7sjYuIr5k+k1hAX1ayYzxWUkv9BJ2K+XHyLuvkeBcPHlOHWtSY7j
	 GU1uxKJwDKI2vmRC0ZQkEPEJg9ChqJeTTE6DojnEJWRXbaTkymc525jUGu/9EqjpWG
	 19jftow50k0Slyg09ReA5iifXwDu71SRTnOrAw50BWhY9Jnv8U2e83ZSdLx2eb/fOO
	 M/Cz+13FQjZNlE+GqPskVnNKOmUVqRcKztDDdoBDLParnFPZWD8c29gt2Ij4+oJtpS
	 Ab8HfCaQd4rURk33a0wctqwdYQ5O6nF71AFKY5AKuhP47cUi+GUGgCjHCfcjVF/QCR
	 5qds8jkpkA4DQ==
Date: Tue, 23 Sep 2025 10:27:45 +0200
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <aNJaAQXdoDlytTDy@finisterre.sirena.org.uk>
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-3-elder@riscstar.com>
 <20250922230639-GYA1303776@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6HpbpinsD42eNuLJ"
Content-Disposition: inline
In-Reply-To: <20250922230639-GYA1303776@gentoo.org>
X-Cookie: Filmed before a live audience.


--6HpbpinsD42eNuLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 07:06:39AM +0800, Yixun Lan wrote:
> Hi Alex,
>=20
> On 11:17 Mon 22 Sep     , Alex Elder wrote:
> > This patch introduces the driver for the SPI controller found in the
> > SpacemiT K1 SoC.  Currently the driver supports master mode only.
> > The SPI hardware implements RX and TX FIFOs, 32 entries each, and
> > supports both PIO and DMA mode transfers.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--6HpbpinsD42eNuLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjSWgAACgkQJNaLcl1U
h9Ag9Qf/agE9cLG7wxZYtQSASbZ9xoCAx98tPfyf7p5VPkN7z7QMkc8/+v5EAuZ4
YpdaixFWN/I5CPMJG9ERW+ly0OleInqkzNX6DXwLwITABENCMHtC7zIRoSQGSl7b
iMAhL0728G9SMt3GQYj8XYiPA7/4e6meb62W17h/W0aabrxuPi614O86fGS/puJt
47uLgJlJuTTHKRt70Z5PeY1sy2oQZpmGTmbstGNS9P5/n2Xs3GL5C1lLyVfac/S+
VIB7+AHD9FJORL4oiBtEHyjZ3L8OS7xk5Pds0PYKVCtvFdBXd73QXlTbCfsGtG4l
HU6g8m1YlQpcZ+62tVSSBAdQ4PJtMQ==
=Wogy
-----END PGP SIGNATURE-----

--6HpbpinsD42eNuLJ--

