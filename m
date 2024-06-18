Return-Path: <linux-spi+bounces-3436-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775D90D800
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24E51F23AE9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0A46450;
	Tue, 18 Jun 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EueEeINu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECB4D9FE;
	Tue, 18 Jun 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726549; cv=none; b=WrtkO90r94eNt0oJcVk3Cyl8KSBIwyEFPvrV6t/+2BGJT4muQ/PlP17xSJZ0SPY7fXqFOUeXSKUqgJeHbquZhXlwNBQJ42GLzox6j3UiwyseJUoPR7wnpP8ClsZF2JvxIpTDxnoGBXwNk/MEHiSE6OsuM0bECHbfR/mbFC5QmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726549; c=relaxed/simple;
	bh=P0EkuibLLQM6881oLW8ZeTp1e5SL8WudVRbATo+UWVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf4DYKqufVWI6iAJM2+9qJxXlZN/3wzHXVMONncWrB4Nzi2dT+w7uA534iWDptEbjGJWlaAGpmCPO2QxZGN3frUdZHcL7Z8ZZ8MwOiNp+2ElMJ7kdmWFK6oLOjXqquo9RAny8bSYHLmPK1DtcBxbjDBltc+IvknDK73fCBnUARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EueEeINu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B21C3277B;
	Tue, 18 Jun 2024 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718726549;
	bh=P0EkuibLLQM6881oLW8ZeTp1e5SL8WudVRbATo+UWVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EueEeINuPkdbqC6XvlKo2D38KyB3KKX0ZMzC2CARsD4jLiBIIl8lb4/RzS19nlncA
	 lUUPsfTx15WN6R3ogCiVasDxmHBVnnHb6MTB2jNZNBokZSBu0qZqUDurOprI55nPEX
	 0gRpIZNQvyg3VLRnPQhO1V63NvsTg0+UFHO8/EmRynwCgkJjqVEKLCPm4WcvsfD2NU
	 T7SqB9cDHa/lCnQ5kb3OtSo0rB27y6DGR4YO+sWh4ZAsRseNkvl6ENu77m6ZHsDUFj
	 hIM+cdhO8oEE+SiVbUPJuk/p4i7cGlXinhvyYR/GOczbrgggsil7uybFm06vhLVNdN
	 VpJ7uV9csirrg==
Date: Tue, 18 Jun 2024 17:02:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stefan Moring <stefan.moring@technolution.nl>,
	Adam Butcher <adam@jessamine.co.uk>,
	Benjamin Bigler <benjamin@bigler.one>,
	Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de,
	linux-kernel@vger.kernel.org, Stefan Bigler <linux@bigler.io>,
	linux-spi@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>,
	Clark Wang <xiaoning.wang@nxp.com>, linux-imx@nxp.com,
	kernel@pengutronix.de, Sebastian Reichel <sre@kernel.org>,
	shawnguo@kernel.org, Carlos Song <carlos.song@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <cd8d89d3-c304-4eb6-897f-b423e8196ef2@sirena.org.uk>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
 <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
 <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
 <20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de>
 <20240618-mature-private-peccary-29f0b6-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HCL5AFgU3xAQjc54"
Content-Disposition: inline
In-Reply-To: <20240618-mature-private-peccary-29f0b6-mkl@pengutronix.de>
X-Cookie: If you can read this, you're too close.


--HCL5AFgU3xAQjc54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2024 at 05:59:36PM +0200, Marc Kleine-Budde wrote:

> This patch (15a6af94a277 ("spi: Increase imx51 ecspi burst length based
> on transfer length")) is wrong and the 4 fixes on top of it don't
> finally fix it. I can send a series of 5 reverts, or a manually revert
> the burst length calculation to the original value in one patch.

A single revert should be fine and is probably clearer.

--HCL5AFgU3xAQjc54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxr40ACgkQJNaLcl1U
h9BzEAf+Jl0eb4Q5nY+1wKlAMLKnKNgVcOxauqcffLTpaS6I51LpIyAgeSztVpO+
GX9xSZECv7PbrDC0EnlhJ/B6aMc9MRP5G0kb1h33hhzevm/ewGE3OLZPQPQTWQKk
///4yxcVof/qQ4Mad94OBhUnWfWmDnwLvlimdBFIQ4hidvDwVNc9DFQ2hpMAwlMH
Vv9dwRhSk4XIsCwIzJknezIW9J6evnLL77dgHclDwzegyPz3pjay1hqIQX15hlY/
rr4EjXtV+Xdz9jo553K8CgZ+NaZKphL3Y/NJF0LqXJV7CuPN03ih31faAMSx0x9w
v0MHovnCagQbapX7gMZKxxf7Yf6rXQ==
=fduu
-----END PGP SIGNATURE-----

--HCL5AFgU3xAQjc54--

