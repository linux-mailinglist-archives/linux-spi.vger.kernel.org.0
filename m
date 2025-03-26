Return-Path: <linux-spi+bounces-7329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A12A71D3B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B65116E6E7
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE923BD0A;
	Wed, 26 Mar 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9G9Ab8A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19921F4E5F;
	Wed, 26 Mar 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010491; cv=none; b=bnE0CZdWUmzbQ3A/TP1z4LdUKZLRX/yKiO2oKLSA+sHp6unvIgyWda339i4c6JixtUt1gwWNjp2RNEjtk4avEWkqqnm1OxmLa3qpm8DaYMM3BAfBxChr741fSbGHbU4GLiLMLjCBWZJQ8mAw+IZK4b2WG0ABY7W6abTVmbc/32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010491; c=relaxed/simple;
	bh=IA3VVan9JDdi0Jpz7trFZPJfMehAmi+QTlVRkh32LMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqx+EBee5X8GN5HiiJr3EVA798Ljz1aOXPkR5szre+B9OLcRwXCboVEfnYyZbqkcTltdedyadMDPs6A4XrrCqaSJP6uay2FxLg5ZH8PDYCyMRaTtw0NPJRdpNEE8rXDHNZ6UaBCiefl06aMA3n3fhAm8XZZTWHL+knk/SLoPwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9G9Ab8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA682C4CEE2;
	Wed, 26 Mar 2025 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743010491;
	bh=IA3VVan9JDdi0Jpz7trFZPJfMehAmi+QTlVRkh32LMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9G9Ab8AQPFVzzyvNBBDchidmLn9AkStmMEEnYnF3cWD1TaD4N/SEymbp1W9V4HST
	 VXS0OV/ohp24Ogt72Kb03yZj19j19JvE91djE7NEXZ9y7Xo9XRb0c0fxkVUXxnjRYm
	 MFZqYydRmDcLVv+cVue5ooPEbOxTqkNL/xnkDn8zVbepNNf589SBiSecErssC1Tq2R
	 RgU3THGjnVcDhXwqXRKLmLdfBtvzk4ASym8EOv/iDkShOPuT7b6KxEqzF5r96TSW3j
	 wDawGcEgevwF39vy7xPaIUudvRAlvi9Odfzd9qPutOsxd9yCmkCLzHFOqRF+Hplclt
	 wEADlLnYWkXxg==
Date: Wed, 26 Mar 2025 17:34:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spidev: Add compatible for LWE's btt device
Message-ID: <83685ed2-f41a-456c-8a22-0ac069304386@sirena.org.uk>
References: <20250326174228.14dfdf8c@wsk>
 <20250326172445.2693640-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zKe5HkPWNi4XHZkV"
Content-Disposition: inline
In-Reply-To: <20250326172445.2693640-1-lukma@denx.de>
X-Cookie: To err is humor.


--zKe5HkPWNi4XHZkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 06:24:45PM +0100, Lukasz Majewski wrote:

> Changes for v2:
> - Use 'lwn' vendor prefix instead of 'lwe' (as the former one is already
>   well used in Linux sources).

Are you sure?

Note also that as previously mentioned I expect to see a binding
document update too which doesn't appear to be here.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--zKe5HkPWNi4XHZkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkOrcACgkQJNaLcl1U
h9Demgf7BCHSQ8IOd6alX4Cu/7qDm1yKbDRxbS0CAoI+dXZjlTYfZQfuzY8NJ9oI
BVHT8R4eBrkP8huveZEo48nClXhIjz+wKqLvS13bi7ctmRdseM7RigGbJE2bqtVT
JXIDNLDLDqa1MzT6IeZ4gPj/H25GwG2vXRVMVxMqxtMw3jEWXk/tmv//pcIt61H4
8g+ACcTqZDDFJGOcvq7W37GEE9eZ4mdbUqAsaVg/V0JuJENurwCEBFoavBtmdP/L
PTpnHDroKR5ezt0S/qAXaQPpH219+0A/pwOFDR98z6WNCOWeNmlPb9d8pbBPF0FW
bVjTW4ITiHcdP7bTvLMG6YY/uOGa0A==
=en6H
-----END PGP SIGNATURE-----

--zKe5HkPWNi4XHZkV--

