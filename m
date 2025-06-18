Return-Path: <linux-spi+bounces-8662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B34ADF20F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E747A343B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C42F0024;
	Wed, 18 Jun 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzrhKUIF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750B2ED150;
	Wed, 18 Jun 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262370; cv=none; b=dnRKIMxomEigc75nW3JorG7XoZuxWexoWKj6r6vmFp4bGFU2QpRXXtsiiuVJSatRkETMZgJpDrR5pinFwOooPW1HHWCwIT2SYUje1zfDBqtEsYIYEF6BKZVMC++27Zn3MY1svRSba+4D944j0ZVD0tnMD+EnbPwDW8yDKqhGCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262370; c=relaxed/simple;
	bh=Wtb8tXk3Nd9IYbRIl8BcSYz5FJ+EhtSHNfMIyCzbAz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDeO3R22K50r2TLT1NSWYD2RcRIdnuy5vXg46eQA0GIjtR+Q9fLtQZI6emYWymqIs3aT/S/rQX8w6c0RyAm3nnlvrivunQKS9n76oMyV5v5PEw9+S9oaeKPCOaLo4P0d5LmJYz1lnl3xgIXA/z8UxPR3rVNf49viCVDZDbo1u5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzrhKUIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91689C4CEE7;
	Wed, 18 Jun 2025 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750262369;
	bh=Wtb8tXk3Nd9IYbRIl8BcSYz5FJ+EhtSHNfMIyCzbAz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzrhKUIFDPECt7gIRMmvqCTDKzg/kngQ+xraRJ1Mu3OefcR18v8gJ7uYGHr0pgOiF
	 7EMh0xflezt0LLQ63WQnpPaS1ZfKPsMQGVfxFgbxrT0YGYqzeGmCcpwp+eGUze4MQ/
	 910UsRP+2RdyhooqomAJaniuwOsl/SVin8DdynGFitYBSd8lf0fUfM/PMJYHUvzTAE
	 jTD0La3e6CEviozKybSMEZJZC24QJj3pREtWvx8Lvmp53njD7TEHt3uxjpXsptOAZ0
	 D+NLgEqxMbhVq2qCQCviVMhVM5plnItMju6FfW7G/cFBxFApmq0sxtBLTzXygoTnmR
	 EpJfQJJzzUTQQ==
Date: Wed, 18 Jun 2025 16:59:25 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add binding document of Amlogic
 SPISG controller
Message-ID: <20250618-sermon-unluckily-364512d7ee05@spud>
References: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
 <20250617-spisg-v2-1-51a605a84bd5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j3A6DDGHly87vWDS"
Content-Disposition: inline
In-Reply-To: <20250617-spisg-v2-1-51a605a84bd5@amlogic.com>


--j3A6DDGHly87vWDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--j3A6DDGHly87vWDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFLiXQAKCRB4tDGHoIJi
0vFbAQDkAoiyjJWHA9/lV1bpTRiJToatKdq34ZG1aRKkIaWyugEAwan+KTlmc37u
Db0V7HH6rDbsJ8C4rkutrGQxo2xVpA4=
=gh78
-----END PGP SIGNATURE-----

--j3A6DDGHly87vWDS--

