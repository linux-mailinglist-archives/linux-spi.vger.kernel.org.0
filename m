Return-Path: <linux-spi+bounces-2669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720348B7F2F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 19:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B38F1C23514
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500E1802D7;
	Tue, 30 Apr 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIYnCcZg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B631802CE;
	Tue, 30 Apr 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499152; cv=none; b=fsWUVvY5ac2nVQoJj99rrmDyhop4eUxdmcqBhth+fnI61gKcDRZkJKmN2Ehv4acCgJLUAxOhwmYyzGwtr5a71a4N24eBZCtJv0yCkzMFAYGNQz6oJE6vYmKRz8bv/lSoj9TEacm/q/RJtHXOjBVC0S/s1WVqPSl4diqIR2YTols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499152; c=relaxed/simple;
	bh=WLEQ3N5wFvW2Z5YFU/JwG9a/A9m5nkkvWveppFX+lUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGWxkngj8aLJyLOfXHQ3vwTOPWrAgNRwPN82VTygqZa84tYfVZvKEqXfMa3DGJRJ59bintMHzUj7NPX1V/+fZbdxTJ1IFe6fRHC2wc2Sbuk+1nk2JpI32y2XPiJQitiVlNrQ6DZw3r3QpaNnZxSz9lvShXaXUg3FX5l4id9hyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIYnCcZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D50C2BBFC;
	Tue, 30 Apr 2024 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714499151;
	bh=WLEQ3N5wFvW2Z5YFU/JwG9a/A9m5nkkvWveppFX+lUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIYnCcZgBL6SbYhqhuHjI/ULrBsu2trohxUQAMwlBmbIubR5wSam/5s7WWWVETG2z
	 MmFg+yzm68XFQE4Gisp50y+YiEjQhn8q6JR/Q267OIMUR6/EWvhOChe5BesBSF5muH
	 gywcidWKeXG1nLmKXJRfdYFL14SCTRKyA7jKgOTQxZFr0AD4iGRRy2FImvEVfVNOBk
	 0tGSVDznW+NDX3O18B3t7XeR56W777QDl2bljTfNLL7akVrj67zkAtO+tQuugfaWAG
	 EPkTzycCM8R40y0VKoYrZeO97NJnbSloMY/2Ry9b6QbDVwiYKYU60UEzC3tbJ3fhby
	 EuriAzNxJkFvw==
Date: Tue, 30 Apr 2024 18:45:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: ads7846: Add hsync-gpios
Message-ID: <20240430-balance-cider-ff632766ae98@spud>
References: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
 <20240430-gpio-leds-miscarm-v1-2-9c94d7711f6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r3SrJfZiYCTF1xBf"
Content-Disposition: inline
In-Reply-To: <20240430-gpio-leds-miscarm-v1-2-9c94d7711f6c@linaro.org>


--r3SrJfZiYCTF1xBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 09:03:48AM +0200, Linus Walleij wrote:
> The TI ADS7846 emits a horizontal sync signal that is usually
> connected to a GPIO for polling. Add a binding for this.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--r3SrJfZiYCTF1xBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEuSwAKCRB4tDGHoIJi
0tPqAQCmTyw4ducaa0PWz+LC/g51/tToWzvQkPQIqyXLMDGZggD9H2VbzZrIINb4
aX+Jw2Sz8VKUtXwd7oVmAO0X7hhfXAQ=
=W5di
-----END PGP SIGNATURE-----

--r3SrJfZiYCTF1xBf--

