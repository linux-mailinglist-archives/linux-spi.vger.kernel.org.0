Return-Path: <linux-spi+bounces-10465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB7BC4A4C
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F563B0EE7
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C3D2F2602;
	Wed,  8 Oct 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euxddDZa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1D1DE3C7;
	Wed,  8 Oct 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924570; cv=none; b=M9H5B66gs6IpJMrv3v3jSE2DirrWcCaZFMkC3xO7R0Z2VTFmWbMlZBDHYKTS49m7Gi9Mqi9w18Ge2FDpPzILSXC6dgn3gImHJ8Wkait67OTs7q0n9r5bfr1vtkoxf9DjmXnpkFriJm5nV4wpctAiVBi0cY/hbnE16R0vPjE/Qys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924570; c=relaxed/simple;
	bh=fPe4aF41+U4Pnlt9KF5p+zAC4JgghKrMehUrSb2m82s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na/LTnPJePgtFLpFYVLafMyOT5cMqAycq6xpUIZDDmckOQSMV2JX43umjsi1igPPw1Gx2xkqYRZ12ClGV7P+7aSJqNo+3sXDNU8fmAcZq1XpWtN2LlGfrwM6CepjYmaS2PvNrLll1KBgMnvBLLz0LZa1qwO84mU3q461A1LMe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euxddDZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD65C4CEF4;
	Wed,  8 Oct 2025 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759924570;
	bh=fPe4aF41+U4Pnlt9KF5p+zAC4JgghKrMehUrSb2m82s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euxddDZaw0+qUdIKNXxMy/0gEXEJBYYP5D+6qHXUyHhEnPaRTykxvcN3eo18vrO+L
	 ihipNS4XAJ1f5d7kyEqSDSOKu0ZvVUPlf6mtSghUoJQKG42b1Zr2OsnDRWAIMcIF0S
	 maIUfeMnUpyHf7hYQUFvKVkaF05PbwPDt2WyGVwemVAIvzbXA+Rn5+RYAPEOwXzIVh
	 /QiCjh+xR5a5556176npyW4Xgw133KyeksvKp96ZB5yU63P666hQL8Wm0T4bxoCEwr
	 uk2g+SOYc1m3C3rwPlIOcuNa/Zl41hfGZG1ELJcF74gN1GERoaJAWPueug+cKowAtq
	 /1xaPlu55PHvA==
Date: Wed, 8 Oct 2025 12:56:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: sprd-adi: Remove code for storing the reboot
 mode
Message-ID: <e66bcca7-8bd5-434e-b804-72c8025e2361@sirena.org.uk>
References: <20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de>
 <20251007-sc27xx-mfd-poweroff-v1-2-89a2f919b731@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XkSPenbP86HLZaQl"
Content-Disposition: inline
In-Reply-To: <20251007-sc27xx-mfd-poweroff-v1-2-89a2f919b731@abscue.de>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--XkSPenbP86HLZaQl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 08:14:20PM +0200, Otto Pfl=FCger wrote:
> This functionality is now provided by the PMIC driver. Ideally, the
> entire reboot code should be removed since it does not belong in the bus
> driver, but it is kept for now since there is no driver for the PMIC
> watchdog on SC2731 yet.

Acked-by: Mark Brown <broonie@kernel.org>

--XkSPenbP86HLZaQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjmUVQACgkQJNaLcl1U
h9DYJQf9HvcgJljnfdoA9UaCvc0EDuuQwWvPHYHMCvdmVa0hHlQA90jIDpqwcdDA
3DJHG//dT8dvForOU2SuhNW4GhTJApFP/XVlaB+Llhc8cBUQH9w4hFTVMNfRoYPR
bgxSFzlVeJgLcA2qPPyLZwKuyZCuMYkdPvvUHhyEuHcB31UOw4Ob7MbiZlcwRZqE
X2FYzmv14PEl68a1xbrZ1ug3ibT1MQldtMkb+TZE8/C7D9VHC6Q/VM13NCz5dB/f
SxBB+dFGwWEDWhKSXcnaZ+kLuG5NI7c7o68PHDcQ0X3PhNzWzyCjLO8ZPZrv/8hM
Nrxu8Fyg8PO4HaLjlLr+S/AJ5woNfw==
=w96P
-----END PGP SIGNATURE-----

--XkSPenbP86HLZaQl--

