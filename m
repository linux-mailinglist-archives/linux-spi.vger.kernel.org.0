Return-Path: <linux-spi+bounces-3830-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52392D768
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 19:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD251C2114C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2D195F0D;
	Wed, 10 Jul 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzZ4wmsK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9751953A2;
	Wed, 10 Jul 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632491; cv=none; b=ipuf9PjnvR2TWA96qrpqLh587aJQzGJ7re1DrBjstdxUF1wX2eBaB6YLUCiV727ietsa1+fzqUtG1inMTjWUhcOOgH/N2IKGd5wG/OioqGvvfsANdcPrmGk9kA1233uvO2OG7SAbrxk4JyydPej/bVPRiAkYAKV6Ar01r4AyEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632491; c=relaxed/simple;
	bh=TovAVmB6/oTv4SDpavdVtNgdRBOtblsaAQ8gYCc68qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5etKB1GYW4iXGHlzatb6NGONIaFDxggQL3NiSTEMsMyC5TCe2Yml+3XSaHxp3hkcFPVisyoPBmpJ9wFT7IKT2Me5RYfWCIPoUbsAagvcWb9I/NU+N2BPjL8zwKhVoYNuDhdyxNusI2s0woYTeW2x/emISXBsVUU6A1xymkEjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzZ4wmsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA76C32786;
	Wed, 10 Jul 2024 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720632491;
	bh=TovAVmB6/oTv4SDpavdVtNgdRBOtblsaAQ8gYCc68qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzZ4wmsK40nn9HWqzSdtDjtnxDnP90uNr4o20/+FMAxKAatf55b4jGGmfcfNZAH5S
	 48EoHU4fkk9DWt3ig8Rd7oo+qJbxEFy2k5n4evTPKv6LKDc59IuH2POAqqZ559UQ1c
	 Uvw4+OVIdNRM2HP4ZepO5a9Xg7ItmxLBtxNp/17lSNpbyH2UBzudWn/jFDTXJaj8s/
	 SHmtEvCW938iGBGFGjseUQ14ETV6dg3ygGpZIuzfPZvVkFWFDf7YW0lXRxj9vXb2S8
	 hga5j+obOFQ36+tZh+5+RknSU8J+bJf7mlgYhIGOg/1BYuTtb7IsZox0iwaKUuiUdx
	 +/uxM8WZrd6IQ==
Date: Wed, 10 Jul 2024 18:28:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v10 4/9] spi: cadence: Add Marvell SDMA operations
Message-ID: <d1877cb1-fe64-4cd0-913e-b9192edbd17f@sirena.org.uk>
References: <20240709221211.2130456-1-wsadowski@marvell.com>
 <20240709221211.2130456-5-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MZi6E9iFwqntwOmk"
Content-Disposition: inline
In-Reply-To: <20240709221211.2130456-5-wsadowski@marvell.com>
X-Cookie: A penny saved is ridiculous.


--MZi6E9iFwqntwOmk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 03:12:06PM -0700, Witold Sadowski wrote:
> In Marvell xSPI implementation any access to SDMA register will result
> in 8 byte SPI data transfer. Reading less data(eg. 1B) will result in
> losing remaining bytes. To avoid that read/write 8 bytes into temporary
> buffer, and read/write whole temporary buffer into SDMA.

This breaks an x86 allmodconfig build:

/build/stage/linux/drivers/spi/spi-cadence-xspi.c: In function =E2=80=98m_i=
oreadq=E2=80=99:
/build/stage/linux/drivers/spi/spi-cadence-xspi.c:524:17: error: implicit d=
eclar
ation of function =E2=80=98ioread64_rep=E2=80=99; did you mean =E2=80=98ior=
ead32_rep=E2=80=99? [-Werror=3Dimplicit
-function-declaration]
  524 |                 ioread64_rep(addr, buf, full_ops);
      |                 ^~~~~~~~~~~~
      |                 ioread32_rep
/build/stage/linux/drivers/spi/spi-cadence-xspi.c: In function =E2=80=98m_i=
owriteq=E2=80=99:
/build/stage/linux/drivers/spi/spi-cadence-xspi.c:544:17: error: implicit d=
eclar
ation of function =E2=80=98iowrite64_rep=E2=80=99; did you mean =E2=80=98io=
write32_rep=E2=80=99? [-Werror=3Dimplic
it-function-declaration]
  544 |                 iowrite64_rep(addr, buf, full_ops);
      |                 ^~~~~~~~~~~~~
      |                 iowrite32_rep
cc1: all warnings being treated as errors

(and there were some issues from 0day, didn't check if they were the
same.)

--MZi6E9iFwqntwOmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaOxJ4ACgkQJNaLcl1U
h9BPxwf/QQoDqZsEG2zX2crLn29GyyHdSts/IoEOUbqhU7sMCHNFsJhbha9dhAsQ
V5Afc/UHB12QNpY5vlJg8OwT2ilKpM6BU1Lo3C2WMykZ7sCPv+/Qu73qWiDzQxgd
GXyeBSLCYaYX1pow3Gl7TNuucXjFIZy+C75kkrTqkICVCvVQo/0EGpUatlGyqqLl
LvwIgy0TDgroBHLfWmK/Sgtol3IKx659SSiDKCYzaxihWPT6L0hoUjLcWBHy2wPZ
Xymh4eBH6dUbWw+LZIppRHcyqTtyFxT/njUZNLBvYBy8/d6ru/kYfl3sAInbSkXF
8UnYnDzxJgrCSAItAfrxW8HaU+Q5mQ==
=zNLL
-----END PGP SIGNATURE-----

--MZi6E9iFwqntwOmk--

