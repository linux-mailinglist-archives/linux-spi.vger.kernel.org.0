Return-Path: <linux-spi+bounces-8118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDCAB7139
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 18:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D8A3ACD86
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037227FD7E;
	Wed, 14 May 2025 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFNZUBSs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4D27FD4F;
	Wed, 14 May 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239909; cv=none; b=PhzXJYeTCirTiQ0xBDYO5ynbiLuHjRXi5I0uSflNVd11dn1W8sd5LV1nszp1plmqxS5AINiHjfs9pGzbO0SUdtsw2H2nv1t6nMy29xCEZwJLeu+Qnaw5fyrWYRVqQpYz5Cayoc+IxL0+3M8jOYyj2ZwF3IhVRLitZi3KVocUCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239909; c=relaxed/simple;
	bh=8YOc48xEuXr4DJ2sYcMuh/KPNLlwfh6kUwEIoaMrSoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxe/r3gzDaz/6iiTZrEgYqsBcRGxCCvbtMl3ts4hYVgTYuzLqaXzD5DsYlp4xhgW7JpmcNbWZrgUUdHn1t6HVbteGQGE7jTQD7hGXYhD0KmRrp80hnyKvsSXHXfiH2PEDJmqzgZfRxlH4q9eKWx+l1I/vBVvPFBccYSM9vqWEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFNZUBSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F2AC4CEE3;
	Wed, 14 May 2025 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239908;
	bh=8YOc48xEuXr4DJ2sYcMuh/KPNLlwfh6kUwEIoaMrSoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFNZUBSs18u7vNTlMtcWiIJ8SvP2FFDkbpHlQrN+YoDFwueqYt+X6WcXB1yFHQtTr
	 aVku4Tyavvh6Bv+6WOoMfBnz4VbdDC0T+hYE04Nb3HuLpnt04x2Cjxs23JmA4wwaTR
	 v/SaYkB7Fzuob4sgAeMa49ka8t2xajp2Bj15IhADoeujJ50oyQDDv5kZ6KTStdPThy
	 rz7ZFuPdNpI47t8nz/TOx3xAQFJUWfaiwu+M+CcGjdD/8nFebdDoRClVveb7r6VZYp
	 eEu0xX1iGdNvbkcr1a96/VKeJ/ED49wWQ2HjThtvMtFT/cT3ENLei+/I4FnQFLoNqv
	 iVV2CK+CwZouQ==
Date: Wed, 14 May 2025 17:25:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: krzk@kernel.org, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com, bgriffis@nvidia.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/2] dt-bindings: spi: tegra: Document IOMMU property
 for Tegra234 QSPI
Message-ID: <20250514-shrimp-ranged-14b4529eb997@spud>
References: <20250513200043.608292-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DQh+ciSLDM9qG+dk"
Content-Disposition: inline
In-Reply-To: <20250513200043.608292-1-va@nvidia.com>


--DQh+ciSLDM9qG+dk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 08:00:42PM +0000, Vishwaroop A wrote:
> Add the 'iommus' property to the Tegra QSPI device tree binding.
> The property is needed for Tegra234 when using the internal DMA
> controller, and is not supported on other Tegra chips, as DMA is
> handled by an external controller.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--DQh+ciSLDM9qG+dk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCTD3wAKCRB4tDGHoIJi
0t2XAP4/BH7fs0e/BmQhWpvWaKGS3RlpZ6n1pIQr0ApCchqAXgEAqGfukdfko0bU
H52InxlNzKSfABdad/KmdkSjoHLYTQ8=
=b50c
-----END PGP SIGNATURE-----

--DQh+ciSLDM9qG+dk--

