Return-Path: <linux-spi+bounces-6570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D213A221CC
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3653A5BEC
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C51DF998;
	Wed, 29 Jan 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ3nZdMz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153E1DF977;
	Wed, 29 Jan 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168217; cv=none; b=ogVXPAZCLdunK2oC8UytoSSMc3mgpGSX1dX1LuDBPTWI/qhfpEvGjWDfN4hIr910VRisHYfAHyl/r/aIusOwpELBktA3/itC1S64U7G3wWnktOnW8d2t726I2EV9Ksw6LWUF5qsGfzE+Le1NzrQHLq/f/syyme1NmA9JK5WuSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168217; c=relaxed/simple;
	bh=XBKV226QwIzNLBsc6JzzKYsqk+ccH95LIx4MTJCSsI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/oZZkD6JKvow9/j4ckFoGmCt5aLuwF5RkYSWkBkEBTFUPoTv9gv8me/D+iBDVVl5zdrL7234jonA4izfcO3QMZiiVmUWk2tLsKnOvy8ffZSRp0w/Tt0VXsAEgxpswdbb6KYzSqJFAFUIgdxHYKvdamzaLS+eGF/ezsnSAgZ2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ3nZdMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A47DC4CED1;
	Wed, 29 Jan 2025 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738168217;
	bh=XBKV226QwIzNLBsc6JzzKYsqk+ccH95LIx4MTJCSsI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ3nZdMzNZutFhtpawCD5v4BCdySXwYZPjqtdY/M8q6rVZCNQwIMDFgqISz5y7t0i
	 0fbGFizkHXDEYqp49R5ZcMxZvUzaDLqDsM/b5ye5dZ2SCJ/KvIGoMV11RlYjcLJnpE
	 ENq+UKdgrQ9VO/si7J/2KoJdSZdzaFyuT5aI6HJKcbhxJbioFd23CJxMRE7T7xTXI9
	 drYC43Bzr2M6mTQ4oggSFqLHHDVPvHrgo4tiSIRF/x3tWEV9hMHXDw4sY7MCxmhB3C
	 P8u/pVUdjty9Tk44DIfpeHVp9VVQXzjB6IZheBs1Bs4w9+px+Zw7rs46738hhsWNHi
	 TKtrt7Suno1BQ==
Date: Wed, 29 Jan 2025 16:30:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: linux-spi@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: microchip-core: prevent RX overflows when transmit
 size > FIFO size
Message-ID: <20250129-automaker-relative-0594f50e8fc9@spud>
References: <20250114-easiness-pregame-d1d2d4b57e7b@spud>
 <3e8c08fb-ec3a-4d00-a3e9-43c299dcf942@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uufWA+lOZb6bSUfD"
Content-Disposition: inline
In-Reply-To: <3e8c08fb-ec3a-4d00-a3e9-43c299dcf942@quicinc.com>


--uufWA+lOZb6bSUfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 29, 2025 at 06:57:34PM +0530, Mukesh Kumar Savaliya wrote:
> On 1/14/2025 10:43 PM, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> Not sure why this "From:" is coming here, should be not coming.

It is there because the sending address was not the author address. It's
fairly normal and required to set the correct address in git were Mark
to apply the patch.

--uufWA+lOZb6bSUfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5pXlQAKCRB4tDGHoIJi
0kO2AQDPvPubF8tAoclgHVE2P98E9m5ZF7SpU00IK6eIAUAOBgD8CuFnNik1104E
0i0bAtyRYN6ND3X84j0guTEEUFfmPAs=
=gWPT
-----END PGP SIGNATURE-----

--uufWA+lOZb6bSUfD--

