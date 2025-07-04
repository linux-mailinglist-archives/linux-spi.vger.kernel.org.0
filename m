Return-Path: <linux-spi+bounces-9043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8278AF8D8F
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0924D171FAD
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430682F3C39;
	Fri,  4 Jul 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZXa7AFu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191582BEFFC;
	Fri,  4 Jul 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619516; cv=none; b=Y9e+cl3ej6YhQCZ+Vf7ji8t87W4dCXUDcIbtOFD3aZY+XgmEk4SToWmmGvmkwP2P9htrkyOkcoXzaip0WUJDikMx+iVFHOMBLCshjTLkQ9P0s4ipXarU5iclP56n8HG5AtvhllfPbwWEohT46oUoIwLUFNvZ7jmjfTAaKl/LmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619516; c=relaxed/simple;
	bh=YEWPjPHyxC4ki3E1ZcSIs12Qc+kPMyzDvtMNGFalXck=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=iQo2I4eyFVSh8b/YsBq1ju18HyyiR5lbjeDIbaXwRqZOFOrqi6tiSWBs8x30NHBcWmhQRLnmVQV1rspF0G7S2UoVfyk4bQ36/eyf0uk7Kc4WC8z+z/ecLVMEJ78nZLLcQ9zH7LxK7wIwlayEVcLuzjTPZweZVrWyp+ZbxiPMKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZXa7AFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E205C4CEE3;
	Fri,  4 Jul 2025 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751619514;
	bh=YEWPjPHyxC4ki3E1ZcSIs12Qc+kPMyzDvtMNGFalXck=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=kZXa7AFuiO9Mbm4KecZRo8CE86DRTPUUVQjIxBiVromrDHsdkpJGxSwNLQWefyUxD
	 qZCx2lWs7nQmIaeYGfJhpk4Pg3tEzmIWZeAlD20PP4bnh70oDncMmpnX+rda1IOXW9
	 IA+s4ma91ozX541uiuH9YpyEvAVIhujZu7TtDSsNQD0b0vV6EqOd0m2qKWL3qlKyAc
	 KprlRxBuVd6eNyOHxGVDO3wV1ZEw8/GjvGlrEk5MKN12EIK9tT1NdChQBE0wTn+ZQv
	 TND5pM+oPla8J0iFsu0MvDm/9G952yIt1ZHWRZ2ARLshqDNmICmiH2DC4dr7SjW7BZ
	 sWjGl9hb7lsKA==
Content-Type: multipart/signed;
 boundary=f1bf53852a9581c47b96d6d99d0456e5b24ae45dd2cbc634967c2f1601e1;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 04 Jul 2025 10:58:30 +0200
Message-Id: <DB35AME44OW7.8Q673KOM4PD2@kernel.org>
Subject: Re: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime
 unbalance
Cc: "Mark Brown" <broonie@kernel.org>, "open list:SPI SUBSYSTEM"
 <linux-spi@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "Matthew Gerlach" <matthew.gerlach@altera.com>, "Khairul Anuar Romli"
 <khairulanuar.romli@altera.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 <khairul.anuar.romli@altera.com>
X-Mailer: aerc 0.16.0
References: <cover.1749601877.git.khairul.anuar.romli@altera.com>
 <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com> <ab51dfce-a7d1-4eb3-b469-af35529dfbbb@sabinyo.mountain> <62b9964d-0f2c-4d26-9b35-bb7af3aa5c4f@suswa.mountain>
In-Reply-To: <62b9964d-0f2c-4d26-9b35-bb7af3aa5c4f@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--f1bf53852a9581c47b96d6d99d0456e5b24ae45dd2cbc634967c2f1601e1
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > -	ret =3D devm_pm_runtime_enable(dev);
> > > -	if (ret) {
> > > -		if (cqspi->rx_chan)
> > > -			dma_release_channel(cqspi->rx_chan);
> > > +	pm_runtime_enable(dev);
> > > +
> > > +	if (cqspi->rx_chan) {
> > > +		dma_release_channel(cqspi->rx_chan);
> > >  		goto probe_setup_failed;
> > >  	}
> >=20
> > This will totally break the driver.  It was supposed to be

Yeah. I've just stumbled on that.

> >=20
> > 	if (ret) {
> > 		if (cqspi->rx_chan)
> > 			dma_release_channel(cqspi->rx_chan);
> > 		goto probe_setup_failed;
> >   	}
> >=20
> > In other words, if we failed there was some slightly complicated
> > cleanup to do.  But now it will do the cleanup and free things on the
> > success path if we're in cqspi->use_direct_mode.
> >=20
>
> I suck at email.  What I meant was delete the if block:
>
> -	if (cqspi->rx_chan) {
> -		dma_release_channel(cqspi->rx_chan);
> -		goto probe_setup_failed;
> -	}
> -

Shouldn't the DMA channel be freed if spi_register_controller()
fails?

-michael

--f1bf53852a9581c47b96d6d99d0456e5b24ae45dd2cbc634967c2f1601e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaGeXtxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i0JgF9FznWGJoujoxWAi2/IDO3S/aDf2xZW07L
8kQbeOSDmcoNlRm9rcQv7nXFYwbcaSjrAX9VP0FIsAd6opId6FRfDC4txmPDPk7l
TgEWLBC9h0dNrO01kdt82GFcj9mGgFKvg5I=
=ug21
-----END PGP SIGNATURE-----

--f1bf53852a9581c47b96d6d99d0456e5b24ae45dd2cbc634967c2f1601e1--

