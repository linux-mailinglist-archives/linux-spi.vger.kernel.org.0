Return-Path: <linux-spi+bounces-6363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7395A12BBD
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 20:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CB5165825
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83C1AAA09;
	Wed, 15 Jan 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipFsqzCl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E219343B;
	Wed, 15 Jan 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736969609; cv=none; b=giAZAi5XofSAunNEc4yyvn9lQvHynXtRhnmZwb6H/7jv7LrrXuVs0pR8clLWyRrgHdRBQ+4H6r0OxbU74Ic9Drfx2lTpWyhP6jPYdwQACGIew4TaO0w0NpzCcVa4vgNNHfjDCUWzBMZ/ZubZtHg7ZjX6EqFtuC458bfz9yu7pNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736969609; c=relaxed/simple;
	bh=xbHaDKAejIGBc/Kx0g9Ig49FtFN06DiopR3XXDpO52c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4xqSxS8q9yJLqGHx/d5VXIJVpKQJDlj82TLjO37dS25kmQrvrrgDrzgG6JvMiWwbVc89zKgbyjm5w+WjxgyMaawmBDJPV4HTHU3GomExPGn3zSYlnGyFZQjVkYP2Q5XUBozfh9yLpECbwaPLm7XpgNoPFN+NJX1uYh4uKNAG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipFsqzCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E06DC4CED1;
	Wed, 15 Jan 2025 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736969608;
	bh=xbHaDKAejIGBc/Kx0g9Ig49FtFN06DiopR3XXDpO52c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipFsqzClylU3dKM8xOPxcHt/9Km6FC2uo17Xjh4mbEhito6+YWMlQriz30HZFwQCr
	 I8Z/j6d89nAp/WtenDlhdjP/Pb/6F0bpJnzG3opeP23zwLtZc5IxLuAwYTkQmLJjmE
	 7BKHzc9pW3wDR2ZbGgFAGbr/6yOUnKJRiwuuxW7d6GOsg+77smCoJmUrh0tkRWtJ9F
	 krfpCyKoXg5RgYv/VEzBAdH+XueI53iNJ8ttAICpiixqf2u3rgrjN2UC8kUIsNMFfQ
	 5YP0AITbgIdmqp2QcDkrAEfqsMAL8BrtxkT0/QBIav/DKXIjZ1lBbFasyGv/HK2G9Z
	 gNTiNONP8eHCQ==
Date: Wed, 15 Jan 2025 19:33:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-spi@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: microchip-core: prevent RX overflows when transmit
 size > FIFO size
Message-ID: <40aecf85-1d30-464f-bd67-59eb8fc62700@sirena.org.uk>
References: <20250114-easiness-pregame-d1d2d4b57e7b@spud>
 <33b35815-3575-490a-92de-4d1c2228257e@sirena.org.uk>
 <20250115-resubmit-glove-ca6ce06c9d4f@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NX+2FTbs77mJtl1u"
Content-Disposition: inline
In-Reply-To: <20250115-resubmit-glove-ca6ce06c9d4f@spud>
X-Cookie: Phasers locked on target, Captain.


--NX+2FTbs77mJtl1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2025 at 06:22:55PM +0000, Conor Dooley wrote:

> Moving it out of the interrupt handler entirely probably makes the code
> a lot easier to reason about, so I think I'd actually rather do that.
> That said, I don't think I would want that change going into fixes as it's
> a pretty intrusive change, although given where we are in the cycle it
> ain't as much of a problem since I'd not be sending it until after 6.13
> is released anyway.

OTOH the patch you sent will lock up hard if the RX FIFO gets stuck for
some other reason which is always a bit concerning...

--NX+2FTbs77mJtl1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeIDYMACgkQJNaLcl1U
h9AdSQf+OR3eLYWYNcjkFs2ylPfa0eFzIAGyLEjSOGEpW8Er56TZgiZcL5cE27tL
Om3qEeEIi5/wBrpzurGQk6rEHQC6ZhyoK1gcfst13pIVBsZMVVgkc1cOMjbPWfEP
kNYXQVWLJCuJmg9ZT9X4XRf6tM77GIYUKWlX3nqVmOdQ3azatN8MRmlD52dUjs/a
QEdmMb0lIVOtHBK/gMsBlMsmVt6X0r10ehvqePrssnn7JYomE7yJgwlkBBVZncSF
VGaF+xxjs3UTDKdxtU9xEpzukfIRrGoAhBT91CcgJ46yF02vYED9vPCYq7IwDOi0
Skd6yXdRIYx0dBC6aiS71ETZazMxQg==
=YekG
-----END PGP SIGNATURE-----

--NX+2FTbs77mJtl1u--

