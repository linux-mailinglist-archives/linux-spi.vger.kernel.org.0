Return-Path: <linux-spi+bounces-11121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362BC4100A
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 18:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA642421D03
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D4334C36;
	Fri,  7 Nov 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/CxTtZJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFD3346A5;
	Fri,  7 Nov 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535717; cv=none; b=mmelQjqE6q3EP6hFmS7QNBwlBOtJvH1bulFdlfkQT95EbxQY71yzcEt80iF0uHlrYN6/Fu36mgksqNfG6nxx7WyEdF3D2tIUaeVqX2OccawDjQcHam/CoINdZ0SPRSdo0+gvJbJXplVHqJWwCn9NsA58VhxHYE1PRWg0qJdBc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535717; c=relaxed/simple;
	bh=wROMYKg2N1OjiujHzH/OALnykfRakpiHN3hWWRaj9DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9EVhkf8VGNVI3aiH9aRn5AuhaQ7++HoxpWayoqKwCe9Qgz13tP3sNflEtwZXfYhCNPRHMiYEnWbSfow4+PN2XmibqhFIC6O7DS2WXVuphgS9eAjqZVFh3NPy0B3sVPXhLGdLQ41XMjmwm1OcmM4iYGPtNISZ7ZBnwnfevtVfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/CxTtZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668E1C2BC9E;
	Fri,  7 Nov 2025 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762535716;
	bh=wROMYKg2N1OjiujHzH/OALnykfRakpiHN3hWWRaj9DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/CxTtZJ/D87CBIw/f3F/dg+S7KD+lIqG2aknSC1mS6Q6YKlcVmZEXM050harUpZ0
	 CTtSRbs70TkSHCO9MVS/uLfJfelrwUGKJfQ4GsrEEJ+67x556cv7l8oopZDR7Iuw4X
	 eDhfZVdzvsUejoidssQhBp9ozWuh8HH3KYf8HcgWp4EnRuiYB4XUJ7sy/hUPvrPr9t
	 aN+9qTkY61ZdBbwQu5qAsX9J1QPWGzU7sYtNvIAb3ISF7tib8NwHDB1H1+aZzZpRag
	 m9kMXcx2WeWhJ/gFlCCYhdhuAYJCv3rjvOVoZhm44qng2f4sfl0YqjONvk4ZZvyeyk
	 LY2CP8GwwygWg==
Date: Fri, 7 Nov 2025 17:15:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v3 3/3] spi: add support for microchip "soft" spi
 controller
Message-ID: <20251107-emit-slip-b1ab5f7d5591@spud>
References: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
 <20251107122104.1389301-4-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wc23uQNPEgglFmMF"
Content-Disposition: inline
In-Reply-To: <20251107122104.1389301-4-prajna.rajendrakumar@microchip.com>


--wc23uQNPEgglFmMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 12:21:04PM +0000, Prajna Rajendra Kumar wrote:
> Introduce driver support for the Microchip FPGA CoreSPI IP.
>=20
> This driver supports only Motorola SPI mode and frame size of 8-bits.
> TI/NSC modes and wider frame sizes are not currently supported.
>=20
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--wc23uQNPEgglFmMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ4pHwAKCRB4tDGHoIJi
0n6GAQDgNSLwY3dMGjRyvG52Ssh+BfQDNYV/qknCblCQ2pc1uQD+J9rpCjsz1X12
HuGnNEZO8BVKo3bchTzlWFUolLDK3wk=
=hcVO
-----END PGP SIGNATURE-----

--wc23uQNPEgglFmMF--

