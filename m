Return-Path: <linux-spi+bounces-8642-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42091ADECAD
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCF188D796
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15F2E3B16;
	Wed, 18 Jun 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMzFDvsP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D422E3AE5;
	Wed, 18 Jun 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249829; cv=none; b=Fo5BOdNdcNuIYQy5YdbA7Tv8xNRmw1OVV6lOhjZHHq67xqtEZ4/mH2fN1bZKsbsdBzMD+afabaxMwZ+drqP2adL8HURHJvrN0uUKno7acA8mViLwmBygpU6qg9RZBdqEXizafXLweTwaEtNT+QARLD4uCMYYWjZG6A7RBLHxmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249829; c=relaxed/simple;
	bh=D4rfI/dgpwr4p8/1Ep8pqKrbCEmpB4WZJuBHlVP4Le4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOGLAAOFSx8SB+w5lYj+haEABVs4aZ954+7uQ1+xR1CCdLoTt71mwLsd/AUvD90Y7nlwk3vFrQAudf2f0joyxFOOl9DAM3G/KtdJKTE/RbK2z+0PBoQVSL06ablTxguvRMQgTsRERr1TM37nqtb2NY+ciL5Yie5YKsjYd+h9M1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMzFDvsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FA8C4CEE7;
	Wed, 18 Jun 2025 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750249829;
	bh=D4rfI/dgpwr4p8/1Ep8pqKrbCEmpB4WZJuBHlVP4Le4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMzFDvsPqxLn1B9i3oamFf9T0SmQ9lxFf85hW0ar7mgg/euMF6HKelkctIIKfhypP
	 lEGHTTwlXhFmQdwLqAR1uPg0p2i9N3uRgcA+I7Ib7vhZevLLLuaJGD9FDWZfBsmrEO
	 XqnnTzTGwQ1p5+NV0RD9k/ZlsHY/JSkVXultVPRAsf1+/VBNWO+WOreuWShujmZ9w7
	 u2jArgUGYApvsx8TLqCj6T73EYiAlVQySCEYQOPRS8K66Y2bjxChYSjDom0STHp3hz
	 S/YgtQw7jBxTHfqqcMxtilue9twIbYg2GseKjRtTIvy9qJBndERtLcSTpS6Ii0APPl
	 2LQLRR/SghWtA==
Date: Wed, 18 Jun 2025 13:30:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Yogesh S <yogeshs@ti.com>,
	Santhosh Kumar K <s-k6@ti.com>, Steam Lin <STLin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/8] spi: spi-mem: Take into account the actual maximum
 frequency
Message-ID: <89c8da9d-8e4c-4e68-b306-5645154b4d60@sirena.org.uk>
References: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
 <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-2-513202126013@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RW5FZxWRZH+m65mW"
Content-Disposition: inline
In-Reply-To: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-2-513202126013@bootlin.com>
X-Cookie: This bag is recyclable.


--RW5FZxWRZH+m65mW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2025 at 02:14:19PM +0200, Miquel Raynal wrote:
> In order to pick the best variant, the duration of each typical
> operation is derived and then compared. These durations are based on the
> maximum capabilities of the chips, which are commonly the limiting
> factors. However there are other possible limiting pieces, such as the
> hardware layout, EMC considerations and in some cases, the SPI controller
> itself.

Reviewed-by: Mark Brown <broonie@kernel.org>

--RW5FZxWRZH+m65mW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhSsWAACgkQJNaLcl1U
h9BIRgf/ezr5jf2vKiJJqpU8isR3/C6aRXPA41Id7IowObzRPOdEL9epIfalMmCp
YMAC1Om50TEUuBWM7CnMYiyDJV4EdXSpUpmlHlF/G4Akx8aF9Lf5K/KAWE3m99sU
xe1rcn/TSU/RPGhFhF5IdLapcXvKsKWFoBIHY6i5kn7QvNydi3yUQEo+SQiYLSIp
tmhnPhveSC9JxKAWuRJiGU+n9VKfh0zPSgXKgnG2ZTUIILHOYlUfEnYEG8vK/Wxg
7cTRWmiWGf+Q3lZHycNl01PuziSPH/ZxnD5uk7dp1Kh1pcc5H+fPovTFJVDNu8s9
ztFngOPei544anpJxOtsmFcJ69H+AA==
=ZKto
-----END PGP SIGNATURE-----

--RW5FZxWRZH+m65mW--

