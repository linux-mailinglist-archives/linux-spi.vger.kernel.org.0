Return-Path: <linux-spi+bounces-11619-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA27C8E13A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E02B4E29A2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511F32C31C;
	Thu, 27 Nov 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUbR5IUV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEE22F76F;
	Thu, 27 Nov 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243831; cv=none; b=R2Pc8dvo1lyDkvST1OYM6u4Vi8nixguezRrM403quhVBygN5YQcXyRDM05Pwv4WUc2mhhhc/L8RNz2EtBtY3zOc2phk1//CXPS2xqDUmWzg/uO5CIp7xyXXUVm8V1p8muCPzaxmWH9ZiQbQ7AWjZZov11gEajRrF13tChh9MiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243831; c=relaxed/simple;
	bh=B0zXTatWlGYyQ1fBUHQXGdNueG6uZZH9fh8FR1yj2BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txlJ8H6IAWApVeRIG55PM5nP9ZMPXkav24HCODUqpFEmL8ZNUJBkoF/RQTcUecutRB0TnZwLCcMMc3f3AMpbnbnicT56aEjWBy5VLRX+JJq2Ufanp4FY5aSZS0Sgk5mhEE7ap+MA1jDOabCAxAipE9nLEszjLA2sruUuDufHkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUbR5IUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F2C4CEF8;
	Thu, 27 Nov 2025 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764243830;
	bh=B0zXTatWlGYyQ1fBUHQXGdNueG6uZZH9fh8FR1yj2BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUbR5IUVev/SAp7VYELq0Hv79ogO6ZOFkZVGU256mA2FfeVCqS2uQJ9JMT5H5C4lT
	 7SXPDMl7BaxkXpaBlkyQdPWIzTi/oTO3tdAsbDxC+OtZI0RCtkKYIYOdae4nt8Opnd
	 IsYppPe2fSMuI0M2mwE6IVU7JDhAId3/AG/p4stdPVTcrDjDq++nhBomfC7p5B0w8s
	 ptg2jBunufvrag5X6By3hDg+jaD5z12h99FxfwOKN4PoRpiwEayG53jskNt0reExmF
	 kMPTlvazu0zb1OzxZ5rq2bWQWPqesyDZkhOhnBpCUBMIFAUy6Po4zJTzOBJtZ7v+O+
	 zZSksJJEDNrAg==
Date: Thu, 27 Nov 2025 11:43:44 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: spi: airoha: add compatible for
 EN7523
Message-ID: <671fb90c-2076-4901-94fc-1eadd1742516@sirena.org.uk>
References: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125234047.1101985-3-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hZjdanbYJIzm7qaB"
Content-Disposition: inline
In-Reply-To: <20251125234047.1101985-3-mikhail.kshevetskiy@iopsys.eu>
X-Cookie: But they went to MARS around 1953!!


--hZjdanbYJIzm7qaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 02:40:46AM +0300, Mikhail Kshevetskiy wrote:
> Add dt-bindings documentation of SPI NAND controller
> for Airoha EN7523 SoC platform.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--hZjdanbYJIzm7qaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkoOXAACgkQJNaLcl1U
h9Cw6gf9E93O4G2Sv2weW+jNdofoptCvmy7ha8GrfKyTY6UTeiTqpxs+zFNzl0gu
urBvRIvfaQKLBAeVwyUPBEHCrG3/s1XmYfdezQx7ktFk3uIX57bH6Rddx3zvobVV
oUKwNBv/NSZ2GCCZWMQPXSTbIAYPc2Y1JCNs5CMkEDYHe6WoZyHhH+AQA8HF+3lq
Eat5qvzfO2gQZrY3ko+I1FhMKumgIHYnGw+0MN94DpGwlY7HbS4d5VZavBXRQ1eD
oo5iU/PW6xLI3EHKfrz/lfw2s6gG5fst4g+HiGSQtLgUKvJbkzmwysrdWY9OgzxI
01gcZJaSTzg9FYi8wYwZJ52+blYMHQ==
=mqNc
-----END PGP SIGNATURE-----

--hZjdanbYJIzm7qaB--

