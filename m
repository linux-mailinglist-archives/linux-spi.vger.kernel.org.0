Return-Path: <linux-spi+bounces-10699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49386BE4215
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AFA3BF82E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E93054C4;
	Thu, 16 Oct 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqYEJwnZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD891D554;
	Thu, 16 Oct 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627284; cv=none; b=Bd+rKi0c3xN+E8/jOzC7OWVfW2gN6inL1DNJHoHWfijqADSfhxYpfAnst2UM48aOsqrcr1fthlvcFAoOlUgPtQWlQEYgV/vCohHriJU9rdfWFHI7axH8rfUSTClr/AFgu9HZaB121V7Zoqmu4wJgA+8OkeQvby79u0akOH7fGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627284; c=relaxed/simple;
	bh=9uRFDjS7+x3BdeOr54o/KLXkg1iz2txFLMHKgJwlcVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl84j+UQy04TR/e636SRPLzIZXxkZ4oQxO0+EdxS7aM/wiZw1GABMBzPbJAz8XLhiGcjVdTfA3Yfc5QjWZLJ5w6H3kE5VuZYGmpaOYM0SUOFoLUNYekzuN1HYz/X1+7iY6gNqDus3wN/wGknEJj4LnSvByyRvji1a751zPbdaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqYEJwnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D8C4CEF1;
	Thu, 16 Oct 2025 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627283;
	bh=9uRFDjS7+x3BdeOr54o/KLXkg1iz2txFLMHKgJwlcVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqYEJwnZ9PaMkDSnk875mAyc7GIhHZvNahcwqpD0zMtBraAlDgHef9/zw6CM4Q+Nr
	 gmUkp175Hasp5o7BiFGTwL+H7eRH6p+Pr5gEqUS//72CSyGVTIWK/yeXhdeEV0bBDE
	 YftO8/7wbA5vimMubS4ECH391sHnZNtbpG3pwnwCtKYH59sOU6V0icj7Z4HMo35sYv
	 nT7qCj1guSL0XomnOb4YWEVUFwRLl3H4xm5ZbQ4Wikb3QO9cwgSdnH5V96dBoO8P9Y
	 c2wEOQunvZlbOwmga/RPRN7JOpAQ7/+M0sOyYoFalQmip65/xVyujrwGxsqsBCrqvd
	 xk/PrKp9WQfxg==
Date: Thu, 16 Oct 2025 16:07:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v10 02/16] spi: airoha: remove unnecessary restriction
 length
Message-ID: <0ccbe966-2e93-46a6-aad1-7715f289c275@sirena.org.uk>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <20251012121707.2296160-3-mikhail.kshevetskiy@iopsys.eu>
 <dbefe024-9b5c-4531-abb9-a1a7e9d3d769@sirena.org.uk>
 <177bcba2-2358-424a-a22c-9bd8b42cbeae@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJBUQKF41vwGzvXX"
Content-Disposition: inline
In-Reply-To: <177bcba2-2358-424a-a22c-9bd8b42cbeae@iopsys.eu>
X-Cookie: Whoever dies with the most toys wins.


--pJBUQKF41vwGzvXX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 04:39:19PM +0300, Mikhail Kshevetskiy wrote:

> Could you give me an advice?

> This patch series consist of:
> 1) bug fixes (patches 1, 3, 5, 6, 13)

I note that 13 isn't tagged as a fix.

> 2) removing of boot related dirty hack, absolutely necessary for older
> kernels (patch 12 and preparation patches 9-11)
> 3) improvements (patches: 2, 8)
> 4) cleanups (patches: 4, 7)
> 5) support of en7523 SoC (patches: 14-16)

Fixes, cleanups, general improvements, the new device support.

--pJBUQKF41vwGzvXX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjxCk0ACgkQJNaLcl1U
h9CYxQf/Zam73IWvHoogSMEqvn1+FjvwC3ymOKtI15IO14X1QPWD8W+JGl44lCA/
McicUAUY7SS/J/b9phJ5I9ubrseMWvT6IxzWovf7apQAOp7n96tf4xJT6qfOZPOJ
YqW8COZF2RzHVYgT5074JjOI2cgpnmXjEEmskwvK7y+VJbEl5rqYCEo5tF6rHQsl
VBnNVP/3RhBLOGdDJcoDEeHew+uRR4RGhYOAEB0VCJXK393VVNLdsaPzo59wFSH6
ilwlEkybKrX5pXVOaHNAEDMMBGRBalLgBIciNYqjz2nYrP1ugYAwFR/f4cRdo1qJ
Rd1gh0XVNefMf3rr6rq670m6gXtOhA==
=tBz1
-----END PGP SIGNATURE-----

--pJBUQKF41vwGzvXX--

