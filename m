Return-Path: <linux-spi+bounces-9047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82937AF949C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 15:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2951CA4919
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023330B99D;
	Fri,  4 Jul 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWRM1iZD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2C302062;
	Fri,  4 Jul 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637029; cv=none; b=FAFGaXvk2WDD6KAMuNTjZ4yV2Tct/SymMjncmIKW/gbOLEwkGmbUBFRMyVyofpCcRAIK57+elFKf8KQiQTfj2Z/mxC9pGXYJVMBbq0uuNdYbVK07WGGVq2bY/9Fiucmt5lm0ZR3DFeKlNvp+BD58PVxdrKiE3Ts2LQPts8zQ3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637029; c=relaxed/simple;
	bh=H8pS8KHBQfQCZOxaW9Nq6KsExgCXwxkJothpg5OYWxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqQj2BrCGuGIS0NW0xws47sw1ba5H/FmB4PBYTqgs7bWsKnsx2hEsAogJvEE2y05QHBbseQGqMDag+KErkVlrzHagagHbrUT6cvNqGDe6i17/+KuomMqWD9lPWSVrR4GUNm/5ziVay1mZMsClkUENWpFCEmTzMXE86+j1mtj2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWRM1iZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAFAC4CEEE;
	Fri,  4 Jul 2025 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637029;
	bh=H8pS8KHBQfQCZOxaW9Nq6KsExgCXwxkJothpg5OYWxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWRM1iZDqc8SoZaQPC8XvcPUt2jHoSFrYDSEVTnheFxunM40lgJSfNI9Cx1HXts/P
	 97RoWcEjhifrX+fWcApr5fRkNtO8+oXdBgQCRd8DOZLsGieMB7oboGkk5GZoiSeLme
	 I8JZgiYMgEKeup10LZ7lJZian7zgFkHq7xTGazB1AvXxyr9RBnjVfZ5fKPauEueK7z
	 StABYyemKJTjlPsIbyjzh3Qh1GjXwWEjUlJi8Or54bb5mAaojIHE/Vh3GnQhUukFGa
	 cISdUHoazFZfLMOa6RDlihqD0VkIOJmbMZ6YukcsS7/r0WLIe+Ja/dJBX3iIaDURHi
	 XVVWokqBV7jQQ==
Date: Fri, 4 Jul 2025 14:50:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: stm32-ospi: Use
 of_reserved_mem_region_to_resource() for "memory-region"
Message-ID: <1e33e6b6-845a-44bf-a398-4a9fb895a125@sirena.org.uk>
References: <20250703183537.2075746-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lr37qIzB0o1A4+Ag"
Content-Disposition: inline
In-Reply-To: <20250703183537.2075746-1-robh@kernel.org>
X-Cookie: f u cn rd ths, itn tyg h myxbl cd.


--Lr37qIzB0o1A4+Ag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2025 at 01:35:37PM -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.

This breaks an allmodconfig build:

/build/stage/linux/drivers/spi/spi-stm32-ospi.c:775:23: error: unused variable 'rmem' [-Werror,-Wunused-variable]
  775 |         struct reserved_mem *rmem = NULL;
      |                              ^~~~
/build/stage/linux/drivers/spi/spi-stm32-ospi.c:776:22: error: unused variable 'node' [-Werror,-Wunused-variable]
  776 |         struct device_node *node;
      |                             ^~~~

--Lr37qIzB0o1A4+Ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhn3CAACgkQJNaLcl1U
h9DVRQf8D1AxmRv5Ojv+GEHol13LiGp7nkJN0LfuSBN6gWwV5TqcAVMFganzfiNP
XEh8akPtA7v3GAW0p3oNRN2/IrzP3kJ/XMkd65XCNMjL/eSWkhumXlAm2eG3x4I1
9QVOAHniUh7usC0bnhTMaNHvq7NQIrg0DSrWH3GkN5Zu53mYnWo8CXCYxqBEtJ/Z
vyJEvDWeyvubDhQT/rjARru7quA0vGfW9Kk5Z8tUJVrJYv6EhU3UKjfSr+FxNLsA
0ZAPRipto6tHlUe4f+BZfvvI2vAJ9r6d/vd4y+J29NAxB7/YF81V2qcs3Km7SdUS
vU4DbbrSRKtZlkaS1N4s9BYJIhO5ig==
=4Mpz
-----END PGP SIGNATURE-----

--Lr37qIzB0o1A4+Ag--

