Return-Path: <linux-spi+bounces-7168-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA92FA65250
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B70216902C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFC2356D0;
	Mon, 17 Mar 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoma5/tF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450122E41D;
	Mon, 17 Mar 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220466; cv=none; b=FYLATO3yNv7vMRwg7eKiAViQvHlYzhD8038BOzTADbLpftTEcpBfYJ2KE8frvP+rSztfaVXVP9Kw1zd9TRPt187Ro0ReYgvBVjPaXJ855FAdO8SH3uv7z8vhf4leTDKX61jf3babRKOqBZcXCzSBSWhB463mrUlNi7O2DMgsbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220466; c=relaxed/simple;
	bh=TwByakabURcwGOlpLMaFyoNlbn9/Q64Y4T7QGboNyoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAsfQ7Z167wY9dP/o8JzxcnKRKgKnw9n9g+/p3kkFn7EMib6TbxcJvZg9Ua+7GC3szV7J354rRqvINSWzAjSwLyBXoaTlMBLfJRFB0wcIV/LIWLNCKTAbeYYSUrKU8NACQZPlcOBo0zV8fvM3Dd/mP0On4Od/UJv5lcT0M1sCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoma5/tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE9EC4CEE3;
	Mon, 17 Mar 2025 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742220465;
	bh=TwByakabURcwGOlpLMaFyoNlbn9/Q64Y4T7QGboNyoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoma5/tF28LhvLalQsmG4UBY7zYrr5I9+GCDf+CSrUrsdMyOIvCZ3cuaDnukKBE+0
	 6skE7RbpNplo1dNXS+zqleHYkx9m/CFYBw5VMzB7/bSjU7QjS7Y2dW0eskioTUqoQT
	 yaSoxvj8J/wcoZrSw5enSOzB0FdgQhVjkZ3eurVxzJUJKep8w03uoBtl1el/MRHIvz
	 cO8QSaA+Xm8wtPS2D1rGUAmnP5jr0K9+7Ri7HueO1ld1n4AmJJReS2quRBIh9ttbFt
	 3cQJwU01MjWseGTQsueFKc8YZOXrNMNViZkiq8pVHFI0RPMw8t4FIu64DOOK3o1heH
	 9+5zJczuRruEQ==
Date: Mon, 17 Mar 2025 14:07:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
Subject: Re: [PATCH 02/10] spi: espi_amd: Add eSPI set config IOCTL command
Message-ID: <6c09f5e0-d8a2-419c-8813-8a1bb4f39428@sirena.org.uk>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <20250313183440.261872-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e2tWOeFA4wEelCnd"
Content-Disposition: inline
In-Reply-To: <20250313183440.261872-3-Raju.Rangoju@amd.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--e2tWOeFA4wEelCnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2025 at 12:04:32AM +0530, Raju Rangoju wrote:

> This patch introduces an IOCTL command to set the configuration of the
> eSPI controller and eSPI slave0. The configuration options include
> parameters like frequency, channel, and IO mode. The new IOCTL command
> allow users to dynamically configure the eSPI controller and slave.

Why?  We have spidev...

--e2tWOeFA4wEelCnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYLK0ACgkQJNaLcl1U
h9Cx/Af+JCLinuCLjivkN1a3VwavHrRx9w945iJA/QAD5Q2G3EgxJUw3GzExuYef
yJ67CtGebt5wGGwyZQGHnTtENt0+O+/7vn7po13ELVFoqZAcRXjA6P6FX3oeJ/bG
Yjod/HuqW5IebuNxXumgMEGrBstsSun4NDVa/zMSFCR6Ajs1ob/7vC+UiGMY92+Y
zMYcgB8KJMj+5Qyd1EtufuXI5DWZXqmIxSVs59qlVJ9JGBrsvEf7k7A8haSSrVlg
z9gVAuBe48H8/6BF3eCuT151U830ptaFYkhmitr8L293HzHKrJvL3Q1gnXMrUXIC
1cwKzllM69IbLsyXgfbXsBUZCZw50A==
=kbNb
-----END PGP SIGNATURE-----

--e2tWOeFA4wEelCnd--

