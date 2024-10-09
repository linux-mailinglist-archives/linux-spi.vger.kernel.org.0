Return-Path: <linux-spi+bounces-5175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41D9971B3
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105621F2A7C8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31D1E0E1F;
	Wed,  9 Oct 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYpjPk0p"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015919C563;
	Wed,  9 Oct 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491372; cv=none; b=UBiSylZn2iUhuiyvFMztWbJ9bXHCbrJUuPMmYVZicTKUsqX57BGYsG6xx5raB4r/Dht8vDajMqvzzfdbbxv4JTZ4vQ3cNc/J79MzNp6DLA0vpVxNbLYHzxkL+egYImFdXXeGHCVcEvmATAgiFQkZD/Ku+OmlM5k2SdmtZ22hAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491372; c=relaxed/simple;
	bh=WpKDaxI/W+NgcFtv51vOUNwp4op6/pUKdULfxWhhdvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkUE3zLmUyW3oxONrboIThNjMyvKpiAesokQujjbN2eFXsyc8j+r3SYMr4TQF9eFlVydaNI6guwJFNR/eisqmBC6pH49B1AgUeeDCJTQPjeAFAM3YmWyjM8Y2dMYmJG1Oj4YqSj9TiJFebv4VIY6UcvcMmgiU4sR3PlClPb8Deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYpjPk0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA94C4CECE;
	Wed,  9 Oct 2024 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728491371;
	bh=WpKDaxI/W+NgcFtv51vOUNwp4op6/pUKdULfxWhhdvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYpjPk0pqIGNTD3ujE4Z/aMlU3dLX7DpVkbtdJCHTW2ff+r8vISInbPTpbzIQVw0b
	 n8pvIg8BtbsXlVSxqW9Pn2Ceym/nK3O15mB7o+RkIO/j3k2e9mfXkiooLJNJzwiavk
	 9PGEcj+Sd+6/pwvoB9lr/48uJuswyAJpJN9G8zlwCKLF3kuvG85cTF4SlLi5BSPZzp
	 eMJErYmjbY2hTXJjc9c1XXPjMD/bsEZwYt/NfxyZZwoJqvEAgfSCmH8zR6dpl47v8W
	 zqWcn7jXqaFYiecD3ycUFH/Uwn6kFQlTwRvc9wqxE/3vhAS6aIXGdpEpZmN4ZhTlad
	 tiSc6+s8RW5HA==
Date: Wed, 9 Oct 2024 17:29:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: stm32: fix missing device mode capability in
 stm32mp25
Message-ID: <ZwavaP0QHQCyDbtB@finisterre.sirena.org.uk>
References: <20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nhlvC0ehYU1eXsqp"
Content-Disposition: inline
In-Reply-To: <20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com>
X-Cookie: Editing is a rewording activity.


--nhlvC0ehYU1eXsqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2024 at 06:15:52PM +0200, Alain Volmat wrote:

> Fixes: a4e7908abf0c ("spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc")
> Cc: stable@vger.kernel.org

That SHA1 doesn't exist...

--nhlvC0ehYU1eXsqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGr2cACgkQJNaLcl1U
h9BQYwf8DJmILKbY03TZr3Z+bBleGn5Ey9cfwTqSEWz24LYOMrmDUe8h4EhJpwrv
/E3XpZC10q9Cj8nEJiTBOX8PW+sFKFZdKj8ej9DcufTn9ihaVrq4i6TzdX19cUFq
BBkbxj/6jyBJD3Hjk+c7jFoQHGPBkdV/6+/KbjpExWnSLZvv5yBRuVvVMusiFUmj
yfILJeZSYjAt3pHqeie+RMEiyw+5+ga+ZwKy13S5v56JG9HEEnre+9GPN7SW0cIm
B2ksBiCORK8O/BDdmfZAT4iFz0QivhByfRIGLLlL6OpfvK5oXXW9DO+qvt+r7g99
P9bWBZSNrbaIqlDvQEgvip+vdiLqMg==
=UQzM
-----END PGP SIGNATURE-----

--nhlvC0ehYU1eXsqp--

