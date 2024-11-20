Return-Path: <linux-spi+bounces-5788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDB9D4020
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D3D2812C8
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7714A098;
	Wed, 20 Nov 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5AU2CsS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5B749C;
	Wed, 20 Nov 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120429; cv=none; b=bzhCK14+C9edNM9J47eefZ3uNY06mInmvTyxX7C72E4Po+G5n415yTaRN2bzk8bcQrif5Ugu7SJYcJZ99YAKfTWbe7yjkd7+SzDJ9f5YD+uRSRrycFsMWPNdlzDAVv9UYjBxOa59BB3NpC75rQ4QgjmusqL2ECGoTzKoKoR5+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120429; c=relaxed/simple;
	bh=n+5vODGAGDD9QEQEgZkGtTp5+BjPoG6jyhPQ1lAoPkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSgy3jcWuQqQjjEnjIc6KoNiSZjKYIdKCdbu7TovOzcE2tsQMtq9Bk3UnubTlF4RA+3tOmsIpqZWLqboq3qFZtqN8kePAq8MaKyNiw3a7TvaU3uCVtOAGOLcFou0ZUwwalru9LkV6FJIDiXpRnHRYkk1y6eb04mQ6fqaYwz32is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5AU2CsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD74FC4CECD;
	Wed, 20 Nov 2024 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732120428;
	bh=n+5vODGAGDD9QEQEgZkGtTp5+BjPoG6jyhPQ1lAoPkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5AU2CsS5TRyOsX5iYkusYdvuTIVGw6PmVz+b1HrJE+7nGt1yhpaUxAufod3qn+m4
	 w31it/SotZncvTfngeEs+6wd7AV/rjuJMlY1eIO56Q3PXsKV7gwJ911ByRgMWjRTUk
	 1T1XY35mULjVkifoVI8HGiZwcMfaBQLsmvRunf0kNu/FHfIzFCqmd7UlRDH/nFtoMa
	 1lEwVXSsgtMlXWvEP8WtSTpRenAwxaLqxHZZ/UtqWiqPBSYzztHaLB9muJ5BCwOQnP
	 Kq1k9HNWN7FcZHGziXdLg8JYQrYe1v6HVtankPb0ciCew3H8uF5lAheom7+U8q7UpX
	 aEu5w663BC3vA==
Date: Wed, 20 Nov 2024 16:33:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vaishnav.a@ti.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com, srinivas.goud@amd.com, radhey.shyam.pandey@amd.com,
	srikanthboyapally2016@gmail.com, sai.krishna.potthuri@amd.com
Subject: Re: [PATCH 1/3] dt-bindings: qspi: cdns,qspi-nor: Add compatible
 string to support OSPI controller on Versal Gen2 platform
Message-ID: <20241120-sandpit-user-8e7f9c27ed80@spud>
References: <20241120120951.56327-1-srikanth.boyapally@amd.com>
 <20241120120951.56327-2-srikanth.boyapally@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GEhhCDNktsVy1V2F"
Content-Disposition: inline
In-Reply-To: <20241120120951.56327-2-srikanth.boyapally@amd.com>


--GEhhCDNktsVy1V2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 05:39:49PM +0530, Srikanth Boyapally wrote:
> Add compatible string to support OSPI controller device reset IP
> feature on Versal Gen2 platform.
>=20
> Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GEhhCDNktsVy1V2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4PZwAKCRB4tDGHoIJi
0vwFAP0RDnGs/VjuvsLTatyYsHE2BD/dvWMooZu279fAXs9zNwD/XF6JHns2xIZk
OhZHWGRY6UPKafxGqa6Awcf21PyPlQs=
=Q9dS
-----END PGP SIGNATURE-----

--GEhhCDNktsVy1V2F--

