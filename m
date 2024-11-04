Return-Path: <linux-spi+bounces-5612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C919BBD91
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8663B1C21A8C
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE701CB9E5;
	Mon,  4 Nov 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQWik+ae"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57318622;
	Mon,  4 Nov 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746624; cv=none; b=rbVrYobM2uqrN58Xj1p/ggDBXRyEevDzt+gx1ByUS0lrioDJg0J7qBi4VtMz+nmkBJuVIy0IN7+P/pCD/AteiufpxzyCXQ3cslvvxw9O/Vhb7YTFc2jvwuoaqCPZZ7PoXMJ2+ibS9o+eq7Ybc+Vhre9TgPdJ/juZBKX3en2Hbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746624; c=relaxed/simple;
	bh=klRNM2QW6fTskX6MxVeh5Eu1pMzs7Vd2pwb5fH/5Csw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghcMyXBHDSKq/kZM5nZ0I9xGDFy9zjx4fAMyoj9DH9CLtQfT8G+zzWlA99DuX6rclSr6BIoie3LOFLbRWUFwY9nYZ5+EHniiDZeKHjtp0qzslJO9T5BCbVUCgnd7ff8rm7j2MUBIKRa0ydQOzkatDegizwP9KENTwBFM+gbeOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQWik+ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A845BC4CECE;
	Mon,  4 Nov 2024 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730746624;
	bh=klRNM2QW6fTskX6MxVeh5Eu1pMzs7Vd2pwb5fH/5Csw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQWik+aeNFU8ogWjtCmkss7kGZP/iF2OtVuPVfEaR5VODM9vL3G3aKKMvmMIB9DCq
	 Su81izEMPMGM/6dJW9MbWy4OPcuBjnU5JSqcB63+Qe4a4dHlTTsfEE1E5HfVnjTw+d
	 JmXLHkwrzQIktGJXSApVm8iGz5uw57EYxNiyPhnIESREtOxDFHxJ6gErnS6EDhDvTY
	 2hGGCKlF8Px6FZ3kDzEBfOGexlCjrLOpJJWZcoPxoCyBaHR5aOfpHt719W+wqmXlqq
	 RcJg1Ky8pIsRTdh9zTNG0WFqzrmefvsBt+hmTfE8VRxeXdfrM/vsx+EhR+iMiVtU3l
	 hJ5lR5Ye/z8iA==
Date: Mon, 4 Nov 2024 18:56:59 +0000
From: Conor Dooley <conor@kernel.org>
To: j@jannau.net
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: apple,spi: Add binding for
 Apple SPI controllers
Message-ID: <20241104-retract-wife-e1abe7425cc8@spud>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDkNDo8k+C4oOoqZ"
Content-Disposition: inline
In-Reply-To: <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>


--eDkNDo8k+C4oOoqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2024 at 08:26:12PM +0100, Janne Grunau via B4 Relay wrote:
> +      spi: spi@39b104000 {

nit: the label here serves no purpose, and could be dropped. No need to
respin for that obviously.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--eDkNDo8k+C4oOoqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZykY+wAKCRB4tDGHoIJi
0hkyAQCYza7XuxDWpE6cI+SQHeNqZ9LyGEb4tyHPUXhBQfj65AD/Yw6470Q9ai91
Pki+/cTol7qQomfJQSdCFz2ZZaADigo=
=XGu/
-----END PGP SIGNATURE-----

--eDkNDo8k+C4oOoqZ--

