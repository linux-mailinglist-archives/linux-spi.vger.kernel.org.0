Return-Path: <linux-spi+bounces-4866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA797C617
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE811C21494
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298E1990AE;
	Thu, 19 Sep 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhyb38Zt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D351922DF;
	Thu, 19 Sep 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735421; cv=none; b=Jci704orh0DqZYqUxtNPwi1ycQ0DyYjm/sSpC1kSSqKAak9KqpzzSeEZCUBFUjWKB74h51RV5QfhW40bto740eXs3pBqRfAwdbFkDE2PW2W+EAZ4yvbqdqPcy41GE2WJr+hZE8iwVdhYLQZLokI28gf0LrbjCmagRECoTXJuovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735421; c=relaxed/simple;
	bh=qiCxtb7Z2/w/OjjdM+HeN2cTSbtkI5mDJpWRnGYCdic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4aovvDZTBp8GdzWu56VnxWXAzoTa175MKshS4i4vVEjgN5nm8BJMYA06zjyetIlXJfC22g47ax9t7BtyVA6fNkEo7ifWq/XCGqyW5L6c9yF9qsN9f3/krVOVaI1NueLb8pM4ie/0UxrEqaCcewP6K9wzfFF+5cw6M5C7TTDk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhyb38Zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD668C4CEC4;
	Thu, 19 Sep 2024 08:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726735421;
	bh=qiCxtb7Z2/w/OjjdM+HeN2cTSbtkI5mDJpWRnGYCdic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhyb38Zt3xv9jfcCWC7qq+tWDSTVccbnzrHm294NqO6xzmAcZOZEbXAwgoqWUUvtL
	 6na6nH6CbN0EOF0HE1tb4AAt0I3M3dCs8126lNpkHw5IAVquEi0zf1/eEx3jdeoSFI
	 P2PhbsWh2F1flTWY+5SjBxRUCFSzmqgfWf/t+WAwjeNag1CfHALsajmLsXzjw7XEQd
	 r9VvnyUaHhXtyDZiiCv46u0Sd0hb6lWxwmrjvDLInP4XcuVt93Ozb/3pPkuquOUBku
	 jHDrJZXwjcbq7wq3tEzaL4nX10KqrPpMz6S3y2xtABk+d57WyGJr8NUcuT2p8QktXF
	 rabxaWrD/oBqA==
Date: Thu, 19 Sep 2024 10:43:38 +0200
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	sanju.mehta@amd.com, krishnamoorthi.m@amd.com,
	akshata.mukundshetty@amd.com
Subject: Re: [PATCH 2/9] spi: spi_amd: Enable dual and quad I/O modes
Message-ID: <ZuvkOohXSzLZZAw7@finisterre.sirena.org.uk>
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
 <20240918105037.406003-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dn7ZpxzI3RYOl+ue"
Content-Disposition: inline
In-Reply-To: <20240918105037.406003-3-Raju.Rangoju@amd.com>
X-Cookie: Editing is a rewording activity.


--Dn7ZpxzI3RYOl+ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2024 at 04:20:30PM +0530, Raju Rangoju wrote:

>  {
>  	/* bus width is number of IO lines used to transmit */
> -	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
> -	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
> +	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 ||
> +	    op->data.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
>  		return false;

I'm not seeing anything where we tell the hardware about the width?

--Dn7ZpxzI3RYOl+ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbr5DkACgkQJNaLcl1U
h9BxVgf8Dy5y4hyw4JHqH+u9kKjOE5l9c4uXdQ6Z78HMY/1oWHIJmdZxEDc+rnNY
T+NFgGao/v1hBsg+8wSnLu9NITwCDhqJ/u3gipw+WJkPCEHzM9V3pJWd7PvwfM5K
YocRBm8aHSQc+p7HDi4ybOU0pKhkCCBHcympjpFiKmYpAkeRKYkid8aRj9S89mwR
MzDOOWAyBX8hYQsZsOf6RJ7zNmIyNmLftJUeZoAWiuZ8ghOx0VL6fjijlaTiexyB
Ml1VIDXWRFGSC3PIgReTCSatY92v7U1y3d6AkMD4kMaNa5IvZOq1pcgf/AND8+3p
DlO4usVMT6Oz3NII2m5/qewLn7y9aA==
=83N2
-----END PGP SIGNATURE-----

--Dn7ZpxzI3RYOl+ue--

