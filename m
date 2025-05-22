Return-Path: <linux-spi+bounces-8238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D111AC0A50
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 13:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468AF9E6409
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48646288535;
	Thu, 22 May 2025 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmg2Rhey"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27F1A23A6;
	Thu, 22 May 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912165; cv=none; b=EM68q8l6C+pQc4RJb4+NM8Vmo0Kjk/0NGiqsYm4nAIHekDSxHvPgp/fcRoCFqcRfquXq6CjoFfSVZfGZtFKHk8F1wGFrFzL08Uk7ThxLRhSY1S5JHy8JgTQO+Qxh1BbI008UzG8IqEyNCCWtQRRte65ObEVBRxPcVt9IdqM5rBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912165; c=relaxed/simple;
	bh=yoWHBWhpiEiX/r5YWh5daWh5u+Cy1FA3kk8m4cbjdl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK3Mm6L2/1dmKN8BULq1ytjnZP/2a8DBjYdoJWwLbdNJCvCLwxODwnpmzxPi815Ca8hSfdoAHjQeGlEyGNL7nZJeZTg0YViOL9wRaECDzi/DM+4dY+o+QNZrt7rASycqnYQ9W0+P5uQVNKa58ysSyBoPNpizqiVOv8u6DY9uJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmg2Rhey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BD6C4CEE4;
	Thu, 22 May 2025 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747912164;
	bh=yoWHBWhpiEiX/r5YWh5daWh5u+Cy1FA3kk8m4cbjdl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mmg2RheyBISEMeicS6dGrIUyF7h2rylzt75yGAikB810eHqNu1CHhq0REBM4rZpmn
	 m4KFNhoCbEGGKB7zqDHAi/6fFF1kV92tQWCP9to4vc2CkgLpMH0P4BN89huaz44Icc
	 OnE8aLKbvpJkbcSbCcbTnANB1z0WMKC7+NJSVmlDMs4URM4/7ZsUzGaI7fHPa3cOxi
	 aK/xMCxPjwzSNEsmBAIl+eSzBph2znmtI8OuD7zLSNduYzC2LnlIZJmak3Gn9r56BQ
	 to0C+HxuyMkvAPtvak6Ui4wTKMDzp42dOV7eNyZ/LMxA2WJcTbmfNOdyPHHL7/yR2P
	 6uiQD2m5lbaLg==
Date: Thu, 22 May 2025 12:09:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Message-ID: <dc42e07e-0b0a-4fb8-a3a5-8d7a1736a031@sirena.org.uk>
References: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M+QrpgYzZEzNFwnK"
Content-Disposition: inline
In-Reply-To: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
X-Cookie: Beware of dog.


--M+QrpgYzZEzNFwnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2025 at 04:17:45PM +0530, Amit Kumar Mahapatra wrote:
> The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires only
> one reset entry. To reflect this, the maxItems for "resets" and
> "reset-names" has been set to 1 for AMD Versal SoCs, and the minItems for
> these properties has also been updated to 1.

Acked-by: Mark Brown <broonie@kernel.org>

--M+QrpgYzZEzNFwnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgvBd4ACgkQJNaLcl1U
h9COOQf8DRjQ0IczWD3R+1hRDigvz/TFkDIgiAx2hOcbVIvfw6HhiBNC3YaQLSq9
vOEmuxqR8KdWosklngbFgMwVevH/kp/jZu/17Avoo/H6B0S5mUAd70OYueW1BAoN
eizSzFV6rIkq5G0rHo1qlNbzgpR1ldugRzPlVtxWO3rEp0VuVNR7EU3x1Z56eLTd
d2B+VA/SB9XSQL/TzTg2QlR9AGg1CH5NER9VwYD9J5n2nTaX3hWM35AcNiZcXpQn
IVg2xdlBKvO3XgixcnpfjX6MXcejdThAGJnsm/3C+VDc1eF3yu9FACr3RcWRlYnX
uieTksEWjOcVFegpfZ3HMBZOYyT6Jw==
=zVYO
-----END PGP SIGNATURE-----

--M+QrpgYzZEzNFwnK--

