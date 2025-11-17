Return-Path: <linux-spi+bounces-11264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38585C6586D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88EBF4F354F
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D63019A6;
	Mon, 17 Nov 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgJuR/c+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2642FD1B3;
	Mon, 17 Nov 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400574; cv=none; b=AsW2dVUxKT2KNMv75Bdsmsn9TNP3PEwCZ+6IccH+1jLgVJUtuzWOhMP2wS98uyYMCsT5ThduheTFRr0HB9fqGIEFo1QlNKKz/LHa9juYOpS1eLBtdKdSA3vzlX5eJqSi9QbOk7h+5Bs85GwAKtfF0EtFnsBPQ+8WMZe2pRcKCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400574; c=relaxed/simple;
	bh=sOp17L8TXGrBT68Gk1FYiZFu8MGJxPs9uEsAQ4QJxcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VncWcqETFXLV+NWqmt9ww/RKSNIdo6J6I/Wgn+NwJ5ZXOOKlSouNj6ihQleriMprE07ZfYZNAoUYUyrZKmbylf4dZ/2QC2y6Xh6SoJHjcGzaBGYLciq6zSNDeUhb46D1PLPEnYjqw/xaGpPjp6hbVVYvcfNXr0eINBheKe58eFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgJuR/c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C413BC19421;
	Mon, 17 Nov 2025 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400574;
	bh=sOp17L8TXGrBT68Gk1FYiZFu8MGJxPs9uEsAQ4QJxcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgJuR/c++aD3WLg6amWm0FKFNYlKUgEMSPK5f+I3hl76ISErifTh+EIpiLFlAZHpo
	 hzAwvS7RUcl+oA+pvUFJioclAfxl+YhmPQkIdteJF4/0HBXNUnOD4LfigqJydoacii
	 +2RVMgLugYAwHsQ1al+BxwLk8isXQFT8sHARsRDo9tTknYwtQcTfzxNb4eODvV4ngh
	 B7/bY8Sp2FjPVCChATE0opKH5OHOxBF295nXhXS+Daak2rBEud3fZ5l6KfDp6NScJk
	 gVLz+X/4x40VZofXJtkRAVkbPjnbt58oy4nYtz0IEXtOkNeEp6No4ZdYc+fnUEMMs1
	 e+gAkUL0TKEuQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 29EA51ACCCAA; Mon, 17 Nov 2025 17:29:30 +0000 (GMT)
Date: Mon, 17 Nov 2025 17:29:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Hang Zhou <929513338@qq.com>
Cc: jonas.gorski@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: bcm63xx: fix premature CS deassertion on RX-only
 transactions
Message-ID: <aRtbeo0pFSFQCR9d@sirena.co.uk>
References: <aRpF3jRTs23YrPgC@sirena.co.uk>
 <tencent_AD45099B2ACD2FBFA150B8AF87074644C705@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0r3Au2IfTm8vNw48"
Content-Disposition: inline
In-Reply-To: <tencent_AD45099B2ACD2FBFA150B8AF87074644C705@qq.com>
X-Cookie: marriage, n.:


--0r3Au2IfTm8vNw48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 03:53:38AM +1100, Hang Zhou wrote:

> I initially picked 0xFF because in most case, the SPI bus is high when it's idle, but in practice 0x00 works just as well here.

> If you prefer, I'm happy to switch the dummy value to 0x00 for consistency and respin this as v3.

No, it's OK - if this hardware defaults to keeing the signal high then
0xff is a better choice.  Most hardware defaults to keeping the line
low.

--0r3Au2IfTm8vNw48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkbW3kACgkQJNaLcl1U
h9DMfQf/aZtLMHyWPYS+OvJaOWHD8cgbSk/IK25F8BO5ohdBqiiPLZzza1WrjCcq
iWKXKiNapnC4QtvrPj+hTsCKMlHaIrtWoNlE7eqjOZaArIZXHMwEB1NAArDDd5UN
eXko6FYEimPZxzQl1rg5eYUv5c1X3VaKdM9r8MIMv9TrnqKPn/eudCjqJYLspjJ/
+4hZtnnh78Ah4BN+8OCffL5fHrpLYk8CyOjK+Ns2NFxloWh9/qYIyQSNkieMHCuh
BYiz47HKVg5iCqNQIhAmXBZuja3sqzjvMfo0Ll+PH5sDMedy3jGd8CQY1nZweGbE
Ylw2G/Nl7ndq89+3QfZtsshAnm48fA==
=wCJB
-----END PGP SIGNATURE-----

--0r3Au2IfTm8vNw48--

