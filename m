Return-Path: <linux-spi+bounces-9946-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C5B4963D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 18:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBAA3B7139
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31030F7F5;
	Mon,  8 Sep 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2ynJhaj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710442FF65D;
	Mon,  8 Sep 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350521; cv=none; b=pliEeYdcL7tSCO1wXI7SzsbVm4AIEMzXbP93IaJOO+qYgOeJ49Xiex3EW0Ux5cjMuzH5nWOHPGFBNDqmnOaQGgNJWaC0MxluLH5AnLHy/ELlss9aPhABNTzdpOGUZ51+GT2CwDWWNETJFyRMgYRt/pfDH39XsI7vj7pBbwQVLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350521; c=relaxed/simple;
	bh=N7pBRflNbpZRPZMuii9nwONjoWuvr1R3Jr0vP87Whsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o62HtfbHCm/7pnuFuyr1TdjJLvqRPQ70g1uU+OXMlS9G0AvNnE48fSngUVZ2dBFQqIYbbTioy1TCCUFknPpfqE1pemMSFzwOWRON2S7WFkfrX6udkWGNC4o5SA2pbFoqVugcRPJ08uEX944fqIWPOf1XxK5/CEe5vZU2ENQQLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2ynJhaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47313C4CEF1;
	Mon,  8 Sep 2025 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350521;
	bh=N7pBRflNbpZRPZMuii9nwONjoWuvr1R3Jr0vP87Whsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2ynJhajh0iJUzWLvuY8fgkhCn//kD7ghrkUA87oVkxkpijFJ66cSd6cYFl3bGqlE
	 JeRDnK9TfGjmRtQh40EXtr5iKATQRpsqjK7MvFN4I9Oa6utDu8QTEqyDUOxdbGsBbD
	 uL0ZDDVwoYOlHYock+ZQd524f+ngfg5Cc6Fr9B8aHDn8/9H1aGBJetlJx0MlDiSV3Q
	 eoUnQ4mBe/v7UkSdYQg74i2k+n4PKfoJczGhwzsLydxxTR/lsphDmshMEMAtD+E4mN
	 zfYllwth+GGOdRZ8QYuUZWCqrR02rCLNCtzWQE7skpwkM094pPOQsrZ5U/TNNvPuJR
	 Awr3dhXofwYsQ==
Date: Mon, 8 Sep 2025 17:55:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 2/3] spi: amlogic: add driver for Amlogic SPI Flash
 Controller
Message-ID: <e010ff93-574a-45d9-a5dc-0942b3fc90f2@sirena.org.uk>
References: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
 <20250829-spifc-v4-2-1e57fd39f584@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLQf2sl8yZV7v94v"
Content-Disposition: inline
In-Reply-To: <20250829-spifc-v4-2-1e57fd39f584@amlogic.com>
X-Cookie: Parsley


--PLQf2sl8yZV7v94v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 01:16:14PM +0800, Xianwei Zhao wrote:
> From: Feng Chen <feng.chen@amlogic.com>
>=20
> This driver provides support for the SPI mode of the Amlogic
> Flash Controller. It supports both SPI NOR flash and SPI NAND
> flash. For SPI NAND, the Host ECC hardware engine can be enabled.

This breaks an x86 allmodconfig build with clang-19 for me:

/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:592:7: error: variabl=
e 'is
_datain' is used uninitialized whenever 'if' condition is false [-Werror,-W=
somet
imes-uninitialized]
  592 |                 if (!buf) {
      |                     ^~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:601:12: note: uniniti=
alize
d use occurs here
  601 |                                        is_datain ? sfc->info_buf : =
NULL,
      |                                        ^~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:592:3: note: remove t=
he 'i
f' if its condition is always true
  592 |                 if (!buf) {
      |                 ^~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:13: error: variab=
le 'is_datain' is used uninitialized whenever 'if' condition is false [-Wer=
ror,-Wsometimes-uninitialized]
  590 |         } else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:601:12: note: uniniti=
alized use occurs here
  601 |                                        is_datain ? sfc->info_buf : =
NULL,
      |                                        ^~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:9: note: remove t=
he 'if' if its condition is always true
  590 |         } else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:568:16: note: initial=
ize the variable 'is_datain' to silence this warning
  568 |         bool is_datain;
      |                       ^
      |                        =3D 0
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:13: error: variab=
le 'buf' is used uninitialized whenever 'if' condition is false [-Werror,-W=
sometimes-uninitialized]
  590 |         } else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:600:38: note: uniniti=
alized use occurs here
  600 |         ret =3D aml_sfc_dma_buffer_setup(sfc, buf, op->data.nbytes,
      |                                             ^~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:9: note: remove t=
he 'if' if its condition is always true
  590 |         } else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:566:11: note: initial=
ize the variable 'buf' to silence this warning
  566 |         void *buf;
      |                  ^
      |                   =3D NULL
3 errors generated.

--PLQf2sl8yZV7v94v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi/CnMACgkQJNaLcl1U
h9AFIQf/f76yjg7V+ltEyf/0nt8AgNdYiP6VUdfMQJowsncIUdiTKd13aXljtg9n
d4uzj9vpTGUZaE9CXSKzYoEySvqalTaZ3XvrCYzK1JpMXcvZB1Mk3xVhSCTOlVje
t7o0Iy5enTcG9jN4yuuTxSxA2MOKA/wD+w9HPRL8gWVVa+YKW9vjOv3e0da2pkXC
7ydiS8/kpdAhoaW0Z1ziRwwDr16yeh/9XKSFOd6VDJDEOwL5yVdId9EozmY/SP/L
0TTHSrOf7i5stNtdgnvRd+pyUuw3WTjMc6t2p0JPk44vhnnBD5W6IkLvhVlCqFLz
mI021XiGLDP6F+IorwAhjYyrANfWqA==
=qXe/
-----END PGP SIGNATURE-----

--PLQf2sl8yZV7v94v--

