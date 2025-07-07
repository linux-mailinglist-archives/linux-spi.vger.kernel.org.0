Return-Path: <linux-spi+bounces-9070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C85AFBC9F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91946179A65
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C95219A6B;
	Mon,  7 Jul 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+johErD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0CA932;
	Mon,  7 Jul 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920670; cv=none; b=RPfVKL4UwT8Z91+TXsr3DJ5NEUbijCPaiTqnlgIVyBmCEnE6HZJnHDFGjNEdOaN+xXorf9NXJTPcajs0FqUX4bWkAOj/d8PtM2GeahUmFA2191TeVU8K8o8oZcCV+PIiprWitZs3/5/tvzjZ0eCi6kRaHMBcLkJwM92hofTGT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920670; c=relaxed/simple;
	bh=2WVnxaMFwH3aEP5B+pE46qp6kq5KDL59M/OkpatTSfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGnW/Ly8z7o6DjyyBP1tlBHlTvtU3WTxf4v6zWn8cwgZYtFk3ZwuZsVERiFkwx/uWDdVrUBfboIcmuXCFKuyIWuB2k4cWFchXlRPpISVEkSQ2/f1b9nS0hM5jzo1MbAjdvOImisV6Y0zj5uH57+rd4KsMPfi/yVCnbNVp4KJnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+johErD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F02C4CEE3;
	Mon,  7 Jul 2025 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751920669;
	bh=2WVnxaMFwH3aEP5B+pE46qp6kq5KDL59M/OkpatTSfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+johErDv6y4tsdHj2JzxIy2MqvXYTXULLu+C+N+ntlOiAs48icy84G1TROZ3GdM6
	 S9J02eYinhKpIiBBbRFYTb6Fv+Nk+v4YzFJ+lczR8lMP6kD+chS3HuJ8Lfg6jk4Ujc
	 G81rRbkFZckDz3cZROqLyvf64HnpRjnjzI/6UE4amEYpVBwtUwyLbEpPQhaRJ6S2v/
	 36ioOtX83uppbYcQ2VAaLvp61ZJzcgFV+LzdhwVTvmeLBbR4eQ0SWQX0RFAKwDuEMg
	 3j2F/2NFjJUbMW7WkhE6T7TN/JjQh89RKjrofd94bCQlDn5eZ74e3JyK8UA+ymSEgz
	 cGPuDQ6tEmwfQ==
Date: Mon, 7 Jul 2025 21:37:45 +0100
From: Mark Brown <broonie@kernel.org>
To: "Hohn, Torben" <Torben.Hohn@bruker.com>
Cc: "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
	"frogger@hardanger.blackshift.org" <frogger@hardanger.blackshift.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>
Subject: Re: AW: [PATCH v2] spi: Raise limit on number of chip selects
Message-ID: <93f4bc95-80d6-4a97-9c5f-32ce033c1162@sirena.org.uk>
References: <FR4P281MB343441EB901D3DD286B923D6837AA@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
 <aF553GU_btT81_b_@finisterre.sirena.org.uk>
 <FR4P281MB34343BD0D260C127866768298346A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OZNpcDAZjeEIKzHp"
Content-Disposition: inline
In-Reply-To: <FR4P281MB34343BD0D260C127866768298346A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
X-Cookie: We are what we are.


--OZNpcDAZjeEIKzHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 07:30:29AM +0000, Hohn, Torben wrote:

> I do now believe, that the proper fix is to remove this check, and then r=
educe SPI_CS_CNT_MAX to 4 again.
> Because it was increased to 16 only to satify this condition here. The co=
de however does not depend on ctrl->num_chipselects being smaller
> than SPI_CS_CNT_MAX. The only occurence of this in struct spi_controller =
is the last_cs stuff, which just requires array sizes of the maximum
> number a device might have.

Ah, good - thanks for checking.  That does make sense, I didn't look
properly (it's been quite a while since I looked at this code) but we
seem to mostly be writing to last_cs[] in the controller and not reading
=66rom it in the normal path.  The main use is to avoid duplicate and
invalid device registrations which we should do but there will be a
better way, and even if we use an array the use is localised enough that
we should readily be able to support dynamically sizing for the
controllers.

> I guess the define should get a better name that makes this relationship =
more clear. like SPI_CS_CNT_MAX_PER_DEV or something ?
> We have discovered the b4 web submit and are now able to post proper patc=
hes. Will do that once we have tested this here.

Yeah, the naming should be clearer.  Off the top of my head
SPI_MAX_DEV_CS or something.  We do also use it to size an array in the
controller which ought to be bigger, something like _MAX_CTRL_CS or
soemthing, and has a more pressing need to be dynamic since you can add
GPIO chip selects to most controllers fairly easily (even if the board
design issues get impractical).  That's just a first pass at naming, I'm
not attached to my option and your idea isn't the end of the world
either.  Devices are more common than controllers and should have a
lower limit if there is a limit so just detaching the two counts would
get us a long way.

--OZNpcDAZjeEIKzHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhsMBgACgkQJNaLcl1U
h9CNOAf/S4x5OV6yMkDI+OkgQEi40Ri1QZAnUhmpB/PFnd9AoWkOaiUIKJbD/QTb
QlXS3p8XCjO5UVyeaIH8i5pcmnDpLjbXnpzpcYH2Mfy6UoX4Y1HiBX8dkIUP3Msl
cvWe7s5Re+DlAUL/xvSDZqNwYy1eMkJcBdm66bySGMpT4pTdZ5jKyqswrL8vzOB0
6zX5sCT2GepLER2fupCHWWqgl3TmeRYW0jNJyY8cExLHzC8wBt+Udg9pc0IkAX9p
x1xHkvOB/lHxcoRauifu84Q6hJdERVZe9uT7zevvfUqjtoRUwUWMKoCaIHhb4zLy
l0cIVm8sZ9J6PQZZJjjXP/0IXelfdQ==
=fJQk
-----END PGP SIGNATURE-----

--OZNpcDAZjeEIKzHp--

