Return-Path: <linux-spi+bounces-7175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14AA6591C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF36189C42A
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516BF1C07DA;
	Mon, 17 Mar 2025 16:45:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0151598F4;
	Mon, 17 Mar 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229937; cv=none; b=KMvFyDy3J18LIVG8Xne7lBAUR0M8hTZ93ekskUJNcqAyREB7+vs+9R2AvP+kUrzjbSHXv63N67d40GAh6f7YJ4wWbUot5YpK6HZ4fs+ymZTE1Q0KEm34CJoNpJUAOGVcC277N2BamGaDSrQQHNnkqULWvJeARWSCI8b/+0ETflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229937; c=relaxed/simple;
	bh=sW7p6yAIC43a4CXaQR1ZUJBMyshB2eeHDlFeuGgfsf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flxRUfF/L+DwDKd3dfcIyXx4m+Hlapu4pw/eo3R2mf6/FFV3RpDZj4eMF3kMYXsWbMQwleaWmkYk1wYVl/jEj2AJnsUxELUQKVICuZuL1/5oIanTiG+VOkhqHq5DMCydikqgYGu5JEL4pEjN4HGcgtd5031pKLc5qbnvY3N6beA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C137C4CEE3;
	Mon, 17 Mar 2025 16:45:34 +0000 (UTC)
Date: Mon, 17 Mar 2025 16:45:31 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qYgAwiGF1NB1RqvD"
Content-Disposition: inline
In-Reply-To: <20250317-tegra-v1-1-78474efc0386@debian.org>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--qYgAwiGF1NB1RqvD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2025 at 08:44:01AM -0700, Breno Leitao wrote:
> My UEFI machines with tegra210-quad consistently report "device reset
> failed". Investigation showed this isn't an actual failure
> - __device_reset() returns -ENOENT because ACPI has no "*_RST" method.

That's not the case, it's returning an error because there is no reset
controller discoverable via any mechanism.  There's no specific handling
for ACPI here.  It's also not clear that this is a false positive, the
driver did indeed fail to reset the device and especially for the error
handling case that seems like relevant information.  At the very least
the changelog should be clarified.

--qYgAwiGF1NB1RqvD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYUaoACgkQJNaLcl1U
h9BJ2wf9FiQsRKGL3f3sfTxr45sRGw9pNwwhnsz7HWcbg7ZV2+N/GP/nAazTLgJY
Q6gt/hc9t8lYK0X9xZAgDU1F4ZyKbr0A8aDNZJPunA8eX4FN7Rw1uMkcYgh3gH88
5AiL8PZhVJqaaGmAI1xafqgw5K5ATVbVI2PjE66WS3Po8gnUxZL/hp+XRETcsyTz
aWyQqt9sJWNrb8P9ksEy/VvYwwy4eVGdtjsQ72XIy5soXoujyrcUsTVTfOhn6DqZ
b+zrGsvbEbRqhVtQ5wc6hFC68jwwZQtxDs/5VsWgekHCaulR7UIV3gC2NIwee7n2
61Kt/DKzxJYSMH/GEswzWiHEcLOeRQ==
=SyPC
-----END PGP SIGNATURE-----

--qYgAwiGF1NB1RqvD--

