Return-Path: <linux-spi+bounces-8050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A3AB20B2
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 03:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0839E4E2807
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62272620E5;
	Sat, 10 May 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biF76MiK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD3261593;
	Sat, 10 May 2025 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746839780; cv=none; b=HrSpbs9zEKhVW6aZGW7gFFZfmX2tF7fgGvLUKbF9Varqgbu/0Mar0Nz0eF/oA19Uo5KZVgQBouOtmy9a2pjymHM0pyqrzJdQIKwQCB3SX1L/79MlTq9r8fQNiIUflzx+fTEiazx5CoZFOv9gkkKn6gAB6p0NVL/Aazxo31c4lBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746839780; c=relaxed/simple;
	bh=Cr7kOpBeEmjU58lN9waN/hhTA9O3udOAM2Wdfip/lS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtF/zkFmFxqFtTK3dLrsQLkVEUfTn0242IGvny+NTA6DmdVrpaKEhK0D/zb8xUmxUuxwynZUObfrAfnCO69j3JLiYSaF8IvQFNLXy6Q/6QCE2ggNlh3mwHROxD8MoHnSWkAZiHBR2+ex8LFGiBVYr37feLtaMyBlPjsbbOxJL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biF76MiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B9C4CEE4;
	Sat, 10 May 2025 01:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746839777;
	bh=Cr7kOpBeEmjU58lN9waN/hhTA9O3udOAM2Wdfip/lS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biF76MiKuqAhCnaxuiCHsh4idFRdF83MXH7JHmY0miXb6cTuwcyaXkuIWIbVSXWiz
	 E4Ei0ZXiwVo7DH/NvXmUcNCziKyf9DBeJ1G61gxMY2datbZ8W7qjTcO5ma0Rlx4qB7
	 csLVWI7j/TuRbOGV1Z+sUAqvACQfg9IGr7KOdX8bTFGSOIuRJ++FHj7tMsjB8JV1IM
	 RCwQPTbOHm7UkejiTBp/Awess8EYmcxKou8SfzyHugqLwbivoOAfirgjby5f0iL7p8
	 t257YG9c9nxyF4ChwTnjTycxsBV50W1E4YL08zJ2OXU9oGw0++04h5S3O4sJUvX8qp
	 xLc/8jRr42zXA==
Date: Sat, 10 May 2025 10:16:14 +0900
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com,
	arnd@linaro.org, andrei.stefanescu@nxp.com,
	dan.carpenter@linaro.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xulin Sun <xulin.sun@windriver.com>
Subject: Re: [PATCH 03/14] spi: spi-fsl-dspi: restrict register range for
 regmap access
Message-ID: <aB6o3lKghAMAasMC@finisterre.sirena.org.uk>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-3-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixuD5kGB4Ce7Ycqb"
Content-Disposition: inline
In-Reply-To: <20250509-james-nxp-spi-v1-3-32bfcd2fea11@linaro.org>
X-Cookie: Well begun is half done.


--ixuD5kGB4Ce7Ycqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 12:05:50PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>=20
> DSPI registers are NOT continuous, some registers are reserved and
> accessing them from userspace will trigger external abort, add regmap
> register access table to avoid below abort:

Fixes should go at the start of the series so they can be applied as
such without spurious dependencies on non-fix patches.

> Internal error: synchronous external abort: 96000210 1 PREEMPT SMP
> Modules linked in: fuse dummy tun hse sch_fq_codel openvswitch nsh
> nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> CPU: 2 PID: 18231 Comm: read_all Not tainted 5.2.33-yocto-standard #1
> Hardware name: Freescale S32G275 (DT)
> pstate: 20000085 (nzCv daIf -PAN -UAO)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--ixuD5kGB4Ce7Ycqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgeqNsACgkQJNaLcl1U
h9ALtAgAhqoLROAk68XqIAIUNwakSx5Hu9BxJ02NLgTZGWVExJnivI8g19E2t1UW
oIwWu+532ZBP+Yoj2J9umF8bs10ztAJk7d3QhQyqZnR1lWYEw8RPesDJBQWz6/iP
sgyr70mJ/x67QTyB1KDd7DYLyJwYvCYhO44uhB44ggCmWZif4Gy/bhseqGTlU6V1
G4gS0LeM5ycTdwnvFa3Otw/I+u9faB/AhgGzgZEQM36lEg5nRy0FFKHIlCEOmelm
Sk5ql08Npgra2J0LmPTf0NSTA4BMj9+D5tIU7wnl95ZugOD1AvJFUKNguNiqpeEV
4Xar4GrEAWnBeiSjtReU+CO52H8c5g==
=47Yh
-----END PGP SIGNATURE-----

--ixuD5kGB4Ce7Ycqb--

