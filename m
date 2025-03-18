Return-Path: <linux-spi+bounces-7192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDCA67442
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 13:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9416A66D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE420C029;
	Tue, 18 Mar 2025 12:48:19 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36704207665;
	Tue, 18 Mar 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302099; cv=none; b=Q9P1ALS1ev7fXBla20a6uZ2FVFhRvW1cSuxG3SnDKAmTpIoAIwjxgoMGHqteq5nA8biIb+/yOBJW1gv8bNsp2mug3njhyUa56ZrygUYGjZvuPSRoM28UZafeug8fzpeX9s/8W/4gEsDYm4miScdaWEZe2pY4TreyZGPtuw7Ghw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302099; c=relaxed/simple;
	bh=3faFgUG06fJvuHLauvntDo9Gu0T+dtJ9lBtyzsqB6WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba2nmdxjPlu732Qsty0mV8BKp6ha+gSCZuVlqcwntaN82XBvhAHERpRUTT9HRt2LeUeWn9mXaWejwPa+40JMoiGcDxSKbAoIfD4ZIUE+weyRn5428ThpQmAorOPrwTbcMok5+pamPrUdkodca5YuwlqUba1dwK2f5dKnbeDo8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EAEC4CEE3;
	Tue, 18 Mar 2025 12:48:16 +0000 (UTC)
Date: Tue, 18 Mar 2025 12:48:13 +0000
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
Message-ID: <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tsyPoBwsXmYQu4eQ"
Content-Disposition: inline
In-Reply-To: <20250318-cuddly-translucent-teal-e2ac2d@leitao>
X-Cookie: Swim at your own risk.


--tsyPoBwsXmYQu4eQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 03:36:54AM -0700, Breno Leitao wrote:

> My assumptions, now:

>   1) This controller doesn't have _RST ACPI method by design.

>   2) It is OK to not have reset methods (!?)

Well, that's not clear to me.  It seems likely to work a lot of the time
on probe but I don't know how well it handles a warm reboot for example.
Like I say the error handling case seems more likely to be at least less
effective without a reset controller so it'd be worth logging.  In the
DT the reset controller is a required property which suggests the driver
might be assuming it's got the hardware into a known state.

--tsyPoBwsXmYQu4eQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZa4wACgkQJNaLcl1U
h9Bv5wf+N82bbh1liSyurdW/1RUom1a3pAPtuY0FVJaAhMBeDFXmSAos4YJ+xNAV
ERociJfQy36bj0mso2gsivrIj5tJKYYKdiXzbLJwUVeebL3gyGEmtAYXHiHeF1r0
5WmaglfjnRiDfBLYpiIRWuF5NWwtF5qFc+g0WxjoB57S6kpLu3u2t6vEiv/xoYgf
OguPUD1+kPXGsLlx46SSHh7M5IF4+7OWmSsNLd3rodY8xUOBCmhSMFlId5eubRpo
/++qPOeiclnRGr74Q1ZgAZLpNCnvNbVzPWAOn4Z+lB9tlf0BnvDQ9qoQrle6ZaDV
D5j+5uwwWBSZ9Dni3re0FZylh4z1hg==
=90Rd
-----END PGP SIGNATURE-----

--tsyPoBwsXmYQu4eQ--

