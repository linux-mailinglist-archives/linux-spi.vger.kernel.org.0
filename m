Return-Path: <linux-spi+bounces-10780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9CBFD999
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 781464E453F
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A52C2358;
	Wed, 22 Oct 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq80/uHD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690B2C21F7;
	Wed, 22 Oct 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154455; cv=none; b=VJ5pyQt8SKaR/OHUb7indNrAn1su1yLlEKerFWypacrPbFWdcz+7XVjpTOpXsLTmk5YY6OzaCiw9z24SfCFAfNk8aWy4r+yn9Nl9HdFJ6n75/nnvmhHGRFqm7q3HZfsSbAPhKyG3HGS9W9MOyA9vhR3d76GDusty5l+X97ABJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154455; c=relaxed/simple;
	bh=IwwIW3BEI8nbvSzJkmoBQXNv8KNbBLMtxPFTZovswOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ3ibQMvlIKKmP3//R+DTLRW8txxGukk2uQoJf8GznfI+q5p9CvZavUzdxr7xZit6g2nQ1aBx8B+/9ugnzaVlKUF19QjiMM6zKjvt2zSsp7JtEg9ccV35x586zAuNYSrdfHySHjd9EDhJb3I5TJf38QGjrwQSvRmUfRdlqbBdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq80/uHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F0CC4CEE7;
	Wed, 22 Oct 2025 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154455;
	bh=IwwIW3BEI8nbvSzJkmoBQXNv8KNbBLMtxPFTZovswOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zq80/uHD81ACUaIBjoDguxKIBaV0cx4h8HWWgxW7Va8n0CDRtWZxbo3IGQYQrqenF
	 6x/cAj8ehd/sJAWa7QqSMFR4D2cx/M19Fs9Oed2+vIiWiAnWsRwC8Ci37r2+IUI7B7
	 +A7MzQUXh276Z4eLnxW8+LnCWWrHfZ/lX/M/xyi2t2+ybq3miqDl3v/MgZzjCy+YBP
	 5YvWmItjtIJiXK6xC2pEak0h1oTvfkp6a/Uhr9OJVsAvSxCmHZoG8Y96ALr8R+4ncP
	 kat0ohAfogDwi079V5RtW6oIYRmDgD5wI938sOA79n47CIfxL2XgcvMAWponK/dN7C
	 ZSe7QkVMHb1cA==
Date: Wed, 22 Oct 2025 18:34:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: spi-rockchip: Add RK3506 compatible
Message-ID: <20251022-fifteen-jolliness-eeeaa5d74d58@spud>
References: <20251022004200.204276-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y33srT0fleC7re05"
Content-Disposition: inline
In-Reply-To: <20251022004200.204276-1-heiko@sntech.de>


--y33srT0fleC7re05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--y33srT0fleC7re05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkVkgAKCRB4tDGHoIJi
0uv8AQCg+B7in0rxKZmiRavHVO1DhquZm9zLiamKC1Pj3BWsggEAi1FL15GdPWKm
okez5gyKLRA+AIlysXTjHOUW+d7m6Qw=
=LeqB
-----END PGP SIGNATURE-----

--y33srT0fleC7re05--

