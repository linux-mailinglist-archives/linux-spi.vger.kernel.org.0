Return-Path: <linux-spi+bounces-2850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396A8C5ADA
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226E61F2254C
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA291802C6;
	Tue, 14 May 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cstGi7Ii"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53731E487;
	Tue, 14 May 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710475; cv=none; b=lD2tVHi32Xd1UBv4RODOWJm1dR+glXjHx5p1Li6IfITjqD+GDe2SD+sIZOGqF6L/mBvpvBrvHX017FP7nGx8z2PkXXJm0nXKPulG4Pgi85SjxT1pdqBE46XGsMCclfV+GQjujC0lqlzqRTm7pitX4iv5WpqSuSn8cPwAdR1KYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710475; c=relaxed/simple;
	bh=VssbbyI+gkA1o0zfxZ+4js+iYNswBLxQl72XkvWlMMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTTQs7hIGq3i/a4Ik6HYGOYxuCoWRXUGOgvN6WrA3nD2pLAv4GPnLrnVOMvValC9RJY5u4555eDfyJDZobnHLD3+pePEupsbmlUTkB3EKKw21WpTCBY7/Pa4J2QCdRT95IEYIP62cdPENVpzztJ7MRAKtZ4LHlU8GOAQ65JRISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cstGi7Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB4DC2BD10;
	Tue, 14 May 2024 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715710475;
	bh=VssbbyI+gkA1o0zfxZ+4js+iYNswBLxQl72XkvWlMMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cstGi7Ii/SrnjZJvX0IFhRoVZEmlun3DfKG8Y6tMOnLTWmP3TE+UpnEnmjQ99nL+b
	 AISl+G0584xoJ898kwnWkjUezHXAScOMJgeTehV2GFeziUmJPEnJxx5IBIcduYVyWU
	 rXimsXlQH3erLw317Nnfsrd4/vA0qMTKqN6frmvjb6lLtmbjf+jZysVx/Hi6IWPOH7
	 m+PVVhlnaPhcCXq5Aq2j/bGcsQ+zinEp+jUnq3IRXS5dK/6N3DNrrhk+M+r/I0Tzvk
	 U0Vy0C4lPvMmq2Gbtsugn92UXgj7cqQBFnm0uOXJOfWZukhGoA8se2u+lx3XmddpcE
	 UMKUOaSvjFgxw==
Date: Tue, 14 May 2024 19:14:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: wahrenst@gmx.net, Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spi: brcm,bcm2835-spi: convert to
 dtschema
Message-ID: <20240514-sitting-ritzy-498d35eb5ac8@spud>
References: <20240514070051.2959-1-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3dV2fBsKbC6sQUnx"
Content-Disposition: inline
In-Reply-To: <20240514070051.2959-1-kanakshilledar111@protonmail.com>


--3dV2fBsKbC6sQUnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2024 at 12:30:47PM +0530, Kanak Shilledar wrote:

> Changes in v3:
> - Updated DCO email address

I was really hoping you'd tell me why you'd not used the same email
address, rather than just sending another version. My ulterior motive is
that I wrote the section in email-clients.rst saying that protonmail had
WKD issues with kernel.org accounts but apparently proton added a
workaround and have yet to be sent an email that confirmed that the
workaround fixed things. (I'm not sure that the WKD issues ever applied
as there's no GPG key posted for conor+dt@kernel.org, only
conor@kernel.org).

The patch is fine IMO though, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--3dV2fBsKbC6sQUnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOqBQAKCRB4tDGHoIJi
0kpvAQDcGvNDk6ZrW1c45wG/DoF5G4tLZYigtXDaEZsz4+u0CwD/UHy0NzAyHKuA
1U4VOiE4ctcuad3gUMsuD3QyXFSorwo=
=vpO3
-----END PGP SIGNATURE-----

--3dV2fBsKbC6sQUnx--

