Return-Path: <linux-spi+bounces-8310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED71AC4D59
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 13:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7973A9AAA
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F133D259C93;
	Tue, 27 May 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPajK+iP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69331DF270;
	Tue, 27 May 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345339; cv=none; b=YBOVaYu0q/ulFiiFdx8c22EisSLSBx9pstHxivhIqkUinnMtA5yI2HtFgQ7yxomwqkRudMdZr3vL+zDnC6+6xPV2EYNOoxFaQQdqEdFUTy4ew82ZBvmI13kIu/RV5RWRot9qli8q9dp7fTby+C1xu1yQnDJFXb9SM9KzEX7jo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345339; c=relaxed/simple;
	bh=rwmtje4bUGVaeN3ojBIVgWdhDOnFTHhqrxRv1ndILaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOeeQSQK5QefsviQ7q4snkh1I710M3dL2lgAUZQCGnMIrzXQ50Vchyj7GyQwPIbsrydOB+XO2AyhFSYnaH5q0LjQum0jWj+cP4gs7ExzAznofU7zVf43ehi7Re4NCUbcJpVs1GV9Fuxckx0+pue4VHJ9PQFp/F1yKXi78HxrCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPajK+iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F45DC4CEE9;
	Tue, 27 May 2025 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748345339;
	bh=rwmtje4bUGVaeN3ojBIVgWdhDOnFTHhqrxRv1ndILaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPajK+iPkSs8jQ8PgcxIFb4hWFdGUIlwgBs1j7xi6Wal/fN2pkyF0gdAIsJTffCsY
	 hQZJNIoxyHINaXcEjcDwfh1qWAXIF90fNTxmOhpzuCNN/h57mom+JW+5GbGDdAlxv9
	 Rxh7f3na5kL/fONhlgZGhY8NT6qNqeywVwLYCfNq4siJd+XeTtviLkZ/AmlXl5rt/6
	 HxKBJzBsLcPgK6Kj6O0i/hKLQukbjvzwz7zBiKwczLV/k+3EpEK0cCvJXe+9/C3xqr
	 Lh340o1TxoG8j/7+X5gFhW2SqJZhIEGuTz72PYffJbb17p+aNAfk9GQYnNU+XiyF2X
	 gQMM97Oh8IURA==
Date: Tue, 27 May 2025 12:28:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spi-qpic-snand: reallocate BAM transactions
Message-ID: <cc53dca0-74d1-42d2-936a-adc383bd571a@sirena.org.uk>
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-1-5fe528def7fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4heDsfrle+qDlMWp"
Content-Disposition: inline
In-Reply-To: <20250525-qpic-snand-avoid-mem-corruption-v1-1-5fe528def7fb@gmail.com>
X-Cookie: New customers only.


--4heDsfrle+qDlMWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 25, 2025 at 07:05:35PM +0200, Gabor Juhos wrote:

>   # reboot
>   [  877.178844] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
>   [  877.178913] Mem abort info:
>   [  877.186767]   ESR = 0x0000000096000005
>   [  877.189508]   EC = 0x25: DABT (current EL), IL = 32 bits
>   [  877.193312]   SET = 0, FnV = 0
>   [  877.198780]   EA = 0, S1PTW = 0

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--4heDsfrle+qDlMWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg1ofUACgkQJNaLcl1U
h9C4Bgf7BYX7fYSmMG+RLdZPEv1vQHP0zWlVNMcyOFXq5XSd+PWAdXwVdtd2t1rX
o4vrmXu8LUTwVjNQyjQHdNmAzWpJSgPgd1v+DVMJaRQ/7nlHOCgwEq3ZWbCXkPqK
EB2nLdapopuCG4ODGz6/rcFjfSuF/Opscmzks/wMtxHM6EEDED2ZydP1oTGQSYFw
l5X/eR1mki1uM2EcgflX8qu7bsSBF9wVDmvpfpiTREq3Hl0rYI/NbPwkJCnb1FKF
Pxj2qIxAflmoDS3KatQlAye8ylo/Y5Wm6L4EsxG0E27+i3X/9kbMFt+FV+0B0r1d
VQpUiRr0Z0wguo3kPj1VDtfnTXGTgA==
=smaR
-----END PGP SIGNATURE-----

--4heDsfrle+qDlMWp--

