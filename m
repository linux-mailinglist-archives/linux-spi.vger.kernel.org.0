Return-Path: <linux-spi+bounces-4092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30394113F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A581F238CB
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279AE198856;
	Tue, 30 Jul 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncG+KNp9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4218C336;
	Tue, 30 Jul 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340692; cv=none; b=gAI8Nbl+dOmB5vfak4+AEg3ytXdNZhM/fOsd64wEiRqK1Oc722AWH4sa4oZKQg0S5g6CTc3VbA3PgGHLEhFnq6Rvq6tuenE3YlwC8ITsylgcLepzKq203GfVlNbPg7vupbTgXOoAKIy5nDMPz5EsOLtj2FoZCvyegUPn+rKJB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340692; c=relaxed/simple;
	bh=QCRV+HO4HfFuk2Lh/bwAdGUHfm4BiYLjptM/EFcg/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRVXRi9c/JihL3e2gTAsUGlml84WzMk1DCLeqPty4FtqYYEt9+A/rsm7OFxiMd8TnR9XBk6X3nEsN5NFk0yUBlPwKagYXGzeMWlzzcBFBActUXFHEBNFvp3Gax3jzztDw4LwbJD/nlc/mRAaixT7fnMgG/j0o3BmRRRBlYds/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncG+KNp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B89C32782;
	Tue, 30 Jul 2024 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722340691;
	bh=QCRV+HO4HfFuk2Lh/bwAdGUHfm4BiYLjptM/EFcg/Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncG+KNp9JBToStFnRaxZL4cqdcf/5MZAzSfj9d9eLNetJ2tnIEURwNHO1sNvacM/R
	 pqDr+7kXh653KScmk+/sDfqdGGdhn5Zp3zy/obM8x17LKao0Vh9DIAXq7VxyighQpU
	 N34uMuZJ5GqUKIjv41EjhsmBHmGzNEUh7dkjVU0YaSCyLy0Kzq+ai60z9xUNi45slU
	 9tBhKsbhbSJqwR0+qKbG+vWYjbnaTMvf/4jHprxbmsaASi9fpzR5Ipm1yHuDyjd1UX
	 0zZwrErBaXHzrkD9uD4QSTacshPnqSeNUyYJqvT4H6v56fd/amFBxAmKzAqircO0dZ
	 KNTs2w+/LgARw==
Date: Tue, 30 Jul 2024 12:58:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v12 0/9] Marvell HW overlay support for Cadence xSPI
Message-ID: <6f8adf04-54e7-4fd6-bead-60122c7302a3@sirena.org.uk>
References: <20240730114534.1837077-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jdJNAghlgs10BfuP"
Content-Disposition: inline
In-Reply-To: <20240730114534.1837077-1-wsadowski@marvell.com>
X-Cookie: Don't SANFORIZE me!!


--jdJNAghlgs10BfuP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2024 at 04:45:24AM -0700, Witold Sadowski wrote:
> This patch series adds support for the second version of the Marvell
> hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
> change made around the original xSPI block. It extends xSPI features with
> clock configuration, interrupt masking, and full-duplex, variable-length SPI
> operations.

Ah, sorry - I see this was for an already applied series.  In that case
you should send an incremental patch fixing the issue.

--jdJNAghlgs10BfuP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmao1U0ACgkQJNaLcl1U
h9DCQgf+K6aUaC5UfLcXWgQJ1karPCVcjxu4NLt9QFzMGLMsnZF3dbdYx9nWN9nF
oNXliuiCRG2FzPY9aIG+0PHmKQyEPiktdJH4vhkd7DiN0VMSWJhA1L9kehZxdIwR
uNpSQEb//kf3D1PM5vn5dMyxeN/aAJCdhDmxztLWNekLIBIob/PHWjQP3VPs5JwE
dUt87nlCkczGoFRHRDY4C8obN5Qk1+FlyXiL6HoCnoedBRX3K4/Do3XQjX5PgBNE
eEPT0IixZhCT4U8S+ARFKuvweDsAffbKTKzzRO5QjN60xglc5lhjCNlLpBZhsJN3
8N0SeKlMYxUA9El94DlLzZ2Uv9/AYg==
=dXNC
-----END PGP SIGNATURE-----

--jdJNAghlgs10BfuP--

