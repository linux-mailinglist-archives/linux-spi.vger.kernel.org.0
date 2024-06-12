Return-Path: <linux-spi+bounces-3392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61673905D22
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 22:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FA21F218D0
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466584E0A;
	Wed, 12 Jun 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgrkWcnv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B843144;
	Wed, 12 Jun 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225301; cv=none; b=TOqs6bUEfETx+8wVTv8QscxFkNEA82Ft74MGJJFzd0P0F5EZizhRqNEi3vB0oZCbje5bV0opedYItRGGRKw+OpoAVQ4UDq49L2cQoC2+s0i9djNUlLaxoIv2XpoDIjIIShs+jQr2t3lossyU9jKF1NkdaImfSqKLr5If/fAPfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225301; c=relaxed/simple;
	bh=MfGZFVPsFpf3+XCOO+MmYqSxn4sBXKGuxmCFvCgEDG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnLCAuYMSI6dKwKzBQTbHkqvQGF/yu6SxFkhFRwxKojg2jDB1Fq+L82Sb+cS69Wy6XBEIrqcpOAauFdEYbyhEMha2IAPtg5sExf7lJzajGeBACemBU7f5S11VmKTl+El4E+34h/r5k/iqvOsRmJPPRaP7yM4Fzihy12e7esKBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgrkWcnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3126C116B1;
	Wed, 12 Jun 2024 20:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718225300;
	bh=MfGZFVPsFpf3+XCOO+MmYqSxn4sBXKGuxmCFvCgEDG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgrkWcnvbcG+QCx5ZOYMW8duHqfdUz0RMpJBQxsDa3J/CS1kht88B60gsxIsW3A3k
	 KnKojcgQJMQLWvYpbWqsNcB/2ka8srXcU1BLFjr09Nryldm3DjaupHRjCqZVNyIHpE
	 +5GZyxy114uCqtB20n0g8S+RjZ0cZWzg9/YS60GaaDp5++zq5hCQUyKCveUWOEV9z8
	 5OyWEQMvUHS9Q2LjOU8M3PZZbUR8xk4m3L++O8kNBUodevnuI4JLumx2y+jjfDJlbS
	 XowRSqyOqDISCAQuWAdxBCSyZ2O0Lfx/ujN6Q0bWQegM8QzewB9TenZTRFMF2+iV5i
	 v6uNYH53jOokw==
Date: Wed, 12 Jun 2024 21:48:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, cyril.jean@microchip.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [RFC v1 2/3] spi: microchip-core-qspi: Add regular transfers
Message-ID: <20240612-spending-stalling-62070dbbcf3d@spud>
References: <20240612-brigade-shell-1f626e7e592f@spud>
 <20240612-uphold-dinner-a47b4c44be18@spud>
 <ZmnPh39YyfS4ocNU@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="biSQJgC0nBJ0ng09"
Content-Disposition: inline
In-Reply-To: <ZmnPh39YyfS4ocNU@finisterre.sirena.org.uk>


--biSQJgC0nBJ0ng09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 05:40:39PM +0100, Mark Brown wrote:
> On Wed, Jun 12, 2024 at 04:48:32PM +0100, Conor Dooley wrote:
>=20
> > +	//TODO: questionable robustness if both cs_change and cs_off toggle
> > +	list_for_each_entry(t, &m->transfers, transfer_list) {
> > +		//cs_change being set means we need to re-enable
>=20
> Is it not possible to implement prepare_message() and transfer_one()
> rather than open coding all this?

If I can, I will. I already found one issue with the cs toggling in the
code Cyril gave me and I need to figure out why there's a udelay(750)
required later on in the function anyway!

--biSQJgC0nBJ0ng09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmoJkAAKCRB4tDGHoIJi
0oIOAQCI5MxS5rORWIKfQ0df26eMH0LZJpvdduLKgF9ND2AMjwEAjwqa72ze/NHD
y6U4StWSZ8PThzRWia2S0or0/neQvA4=
=JRBj
-----END PGP SIGNATURE-----

--biSQJgC0nBJ0ng09--

