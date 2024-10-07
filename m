Return-Path: <linux-spi+bounces-5121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF72992F0D
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D871C1F228E4
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11F1D47AC;
	Mon,  7 Oct 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSTaUqw9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A31D363A;
	Mon,  7 Oct 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311156; cv=none; b=IORbAQcFZtFbNSB0lRXAN00QofiMLKW5054LwRu7P+TAzST0dud0uJ4yhXVFqLGWr07zqI77lQIJuUwC+cE3cONyhS3SFKC4kFjDDhLxUAfAKby/2Wh/Nt0OHFj+dNyZK5vmWe+Te2DX73dcxRsmaxnuB0DoK0abvP/0NzeLa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311156; c=relaxed/simple;
	bh=q+TPabjz1vfQ0pdnANMiA1HG/+NexC6E92sIdGx/rs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ+heZQuGcil2dZDNxKVg7L2ilzYf16VBOqK13oZNO6rdT1QWcE2po1xxnCTw7buCosZanT2e0TEMoeWyK7gsuyenFWbnzwQsbklyAd3I91SEJLevzji3SpK6tXZm+nAbrgHXpr9AJhcqaEJh9F4JFYXwtdkO+kLGkaO48VKUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSTaUqw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1EAC4CEC6;
	Mon,  7 Oct 2024 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311155;
	bh=q+TPabjz1vfQ0pdnANMiA1HG/+NexC6E92sIdGx/rs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSTaUqw9rr1vY36MLnEA+L2LA5JfdcFTh6jAYD/QV0pbzyARlXQclMtrL5zzAPHJU
	 ZazwejzBCgO3I6SXFcUWIDLU1/FnaghI3qKu/oJgeMeIaEupcS2Ahux+OeYo/GzyLP
	 ByDmfCtIs/n5FXhr9CfVaR8TD/XazTvECWmuAI+g87i4GY0RNZx5REKqDuMZhxYAS6
	 lCpw5XQbvoIfqZHmaZWEBYrufeYnXlRmn/J4e//Huk+OanzmZYWSWJfaa0+ZZao3et
	 qHqeBEUu12N06jKnAGr6pnjXEaOnkRiq0XXNB5lE4+HJDxqdvkftyDDdEx9KEJ2HUf
	 obazxL5jhDKIg==
Date: Mon, 7 Oct 2024 15:25:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	oss@helene.moe, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <ZwPvcFvK4l7JT1X9@finisterre.sirena.org.uk>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vXTeh0FEv5Mv84vz"
Content-Disposition: inline
In-Reply-To: <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
X-Cookie: Editing is a rewording activity.


--vXTeh0FEv5Mv84vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 11:21:16AM +0200, Dragan Simic wrote:
> Some drivers can still provide their functionality to a certain extent ev=
en
> some of their resource acquisitions eventually fail.  In such cases, emit=
ting
> errors isn't the desired action, but warnings should be emitted instead.
>=20
> To solve this, introduce dev_warn_probe() as a new device probe log helpe=
r,
> which behaves identically as the already existing dev_err_probe(), while =
it
> produces warnings instead of errors.  The intended use is with the resour=
ces
> that are actually optional for a particular driver.
>=20
> While there, copyedit the kerneldoc for dev_err_probe() a bit, to simplify
> its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), wi=
th
> the necessary wording adjustments, of course.

Greg, this makes sense to me - are you OK with me applying it?

--vXTeh0FEv5Mv84vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcD728ACgkQJNaLcl1U
h9B9PAf+MtoEs7Y3AEe2kOLgcFOEnHIrD1FSwcTxPFgyC+9e0NoaGcnc69ZkoxNi
1reeTBW5HHOHFgvPl1wNAPtp6kOofBkknTMmVIgC2olKO8F+7m6Gck0ZeG2gHJBy
gy/1rMI0sXn94sPTRz/wad+Ju570hxiLCI/7nwu78pgHElMo+7qR8V+npeK5TK9A
ZTjI7zb/AvxYA5STrDgodAer0oh3+PYEoShZS9gUJnBboB5WK7NX03p2+NrDHBJG
+1yKycD0eCt0bQBItFijpxcl2+u8E5voN8DKiRc2u01wC6rJ3pehopuAFzW7O9nr
iEyAfBS/WzxVRPUZWtw4Uo6NZFvvDg==
=mUTd
-----END PGP SIGNATURE-----

--vXTeh0FEv5Mv84vz--

