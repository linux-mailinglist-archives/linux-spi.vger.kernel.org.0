Return-Path: <linux-spi+bounces-11948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F8CC45C1
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD29301A712
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38347314A7E;
	Tue, 16 Dec 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWZdWyYf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3A3126BE;
	Tue, 16 Dec 2025 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903068; cv=none; b=R+Cjc1QNPr5QevkUyx/6Oof68zhewD9eKY0bqSeyuKXnYQZBTDfEGq777yaWWDZIdKwLcdNbtaJirqrD4Eib2OjgrNMGDiLTIv5KcWESp+ZjUOD84LRNoKhil0XZIMbZB2jjG59lnBsgrxN4rHI0/yyVn/dEKlxTbskWdmDVwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903068; c=relaxed/simple;
	bh=nYJWKZc8hGDqabxo7wfURuONOr3X91wkOJ4WYpHZzrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIkyO1OEmH06MPq4ZJioCHoOz1Rli39+1iG93XzgVijZxEdmoFE3tDR0zWLOQDs8hRofK+oiZmaeIOQLPY5YxCfHczZGA9OtMEqSmcKcBRS1R180pDH8P9j5nvfOSG+7g+jCbdjd0gv3bpSDFNNuSYIgNkXdivry44SYaI0BTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWZdWyYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C81C4CEF1;
	Tue, 16 Dec 2025 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903068;
	bh=nYJWKZc8hGDqabxo7wfURuONOr3X91wkOJ4WYpHZzrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWZdWyYftoYqPB9H+jeYCrtipMpt766hW667M/8VGFaFB6wo9t3kWRMjIOyDs54sg
	 Ubkum2P8Qnc9YL3o5IMy9Kk9x4uY3/VEHgoXLipGNS7h5irL1Bk4z7X08VZ85pITo4
	 +yOHIfCZuUOuVYBVdOxL7mX2pVqkInhnKAxDGpSWc8NrI9VkvLkSFsB9fmq/ryN/M3
	 oscwj8mqHCwijK1ZxW9WO+fBPVjHh/BYO0kztRMAzTl1qBE2ks0biwkm/8IiYWjPaf
	 CBvb1k52Wmv43oOeZEmlz9OCdI1Qy4WEQ/4QKD9JT10lS0O68XPLpJvZDk8Cr417m9
	 CAqoD90++wv4g==
Date: Tue, 16 Dec 2025 16:37:44 +0000
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH V3 1/3] dt-bindings: spi: Add support for ATCSPI200 SPI
 controller
Message-ID: <20251216-outgoing-unfocused-12f4e850aa71@spud>
References: <20251215132349.513843-1-cl634@andestech.com>
 <20251215132349.513843-2-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnLKxpP1VyA0uivt"
Content-Disposition: inline
In-Reply-To: <20251215132349.513843-2-cl634@andestech.com>


--SnLKxpP1VyA0uivt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 09:23:47PM +0800, CL Wang wrote:
> Document devicetree bindings for the Andes ATCSPI200 SPI controller.
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>

pw-bot: not-applicable
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--SnLKxpP1VyA0uivt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUGK2AAKCRB4tDGHoIJi
0lT7AP43tH7JLEaYJsTrK+NQJUHYluUXxjG9fIEg/fauciKtFgD/UHrYYleLRbWO
LyEOqWhar7w1tSf5lNk2ZeWdhw8J+gw=
=ay8m
-----END PGP SIGNATURE-----

--SnLKxpP1VyA0uivt--

