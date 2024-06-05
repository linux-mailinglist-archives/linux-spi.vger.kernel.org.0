Return-Path: <linux-spi+bounces-3252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2D8FD36B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32803B2582C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0821946DB;
	Wed,  5 Jun 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLZyCVBF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA019306C;
	Wed,  5 Jun 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606649; cv=none; b=eBMPf2sNXr7Z6WVNc+7lmbSgdwx/wQj9iGqDOFGIS5WSF1UR1C7V9uMgiDsIRlUWtnZwrH+ALspDaqdpOcEcN9Az9sxRKJHUkO9uFxZfLDii02yWWKsGPxoaBUeqwg0/jS0GzyndD4srbDFzsQCvqbgnRu4rBgzBM4aq1gE11GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606649; c=relaxed/simple;
	bh=FD27ViyGV18OSGUplRlcQnSe0DGwPMKCKxkI308y6hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm4eyXIS+FXdxerr2In0m2pUXQXKIo+V/KF4d2OF9UTcATH+x4mPDqcZD3Ss35hVLt4H6xvWFQmDr8iqGXYb7mjkhGdZgU77mCZU+Ub9//2Uz3IwFWbh6NkSiERDBWrrz3kS6j+oi6ka5REPd+srI9V4ij0y3dEG4uu9nb0/4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLZyCVBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E8C2BD11;
	Wed,  5 Jun 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717606648;
	bh=FD27ViyGV18OSGUplRlcQnSe0DGwPMKCKxkI308y6hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLZyCVBF3PgamwworMIf6AHsDmz8ehLWwHHzOfGtUvPqtJj9ryE4sE2Wqo6g/ANRF
	 xj1mgz55QDhgFjvLf7aIDlGktrKg7WkCFFHzW/qUFnU0EKx8PUiqERfdMmHCj0h7i2
	 50xI5WLC6SEiKWgjA6XbW4V9tIkmwAXN5v/R+IjFraOU668RDDRCmsMfpoueTTX7Kn
	 usxGyec9yH/bxMdvI9NbCoJky4tvf3qv6g18yzyPMjv2QpEu7LM0EXxoXJ/sMFTJIU
	 dFYoFfQmNkunf0/mDX8QuWFIN0/y7wVXmo48n7QVLa+YWFTQIW8HYipSbsINU1ukE/
	 w5rVKPZwZm3zQ==
Date: Wed, 5 Jun 2024 17:57:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: amlogic,a1-spifc: add missing
 power-domains
Message-ID: <20240605-angelic-stopping-1e122391a22e@spud>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bu7wGZEM//Ti79k+"
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org>


--Bu7wGZEM//Ti79k+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:37:45AM +0200, Neil Armstrong wrote:
> On the Amlogic A1, the SPI FC controller can require a power-domain to
> operate, add it as optional.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Bu7wGZEM//Ti79k+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCY9AAKCRB4tDGHoIJi
0theAP9jxeccC6BpCS7CpOK3U/rvoSkfEMhfqnZUhmHiwd8dnAD/Zb07r96Bs/+D
vUvyrPmEJZj7ALuOxVkjKLf4oWa+dgc=
=2DHM
-----END PGP SIGNATURE-----

--Bu7wGZEM//Ti79k+--

