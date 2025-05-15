Return-Path: <linux-spi+bounces-8133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640BAB825D
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DFB1B61B80
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83656296721;
	Thu, 15 May 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN542K2t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE47295DB5;
	Thu, 15 May 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300799; cv=none; b=RWa+tvrHdwJbLV19NgiCkvh7bViwjXDj1AOzHTEOyGjZ4C2aRR+VHYWIZxx1bXhd+TuPuSdZDsDIoexUSbSOvV3GBZYp3j6PS8Gw6TcEJvZ2nCsE9a2Hc6a9wE71DTdYZ//RFPMcmmdM+hEePO1JaEjGXqwFJgJCaq2sYydGIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300799; c=relaxed/simple;
	bh=yAE5ZaqBHdVLWaZoDrZHlWAUy//bRfgw5fCUmaQcQXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBVUQa+CLxz8pYuQ5JATk7vY7tpBJWsFfOhywatPl2TYE9a4NwIEh7E1o2Fu/dDJZ4BdM06BJK2JdBYFqRbRwMn9njY8swrdwkjNsRBU9NPtDDt8FlKPueg2mNL5DyZh3bcTMENQ3WdjmfK/UEW5KmKoEAbrhykJ+XAEg5VJZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN542K2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E82C4CEE7;
	Thu, 15 May 2025 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300798;
	bh=yAE5ZaqBHdVLWaZoDrZHlWAUy//bRfgw5fCUmaQcQXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN542K2tpX5KeIGgI5eh1Qj9mt3QfJDXZrQxR2X5IRG3WttDFY3pHx2Zdv28uKO9h
	 NNRjgNVuZOptIjAmgcO8VBWBt0GFqfBETj3B2FbXWgZOXig/OF6cwo+mnAPtlNswzx
	 ny3y2JxKtfU7xKXsFBI2fasxxM3PmQmYgbasJol+hp7J051xlDPTXTN6jv54rMgqhA
	 wsfzNFh7LNm+pN0DgY+RcaVAKra0e0RJEoB0fpvO6yn/urlS9RCiGt0PgZYJk2AliY
	 g5j/+ekx6LRPo+sCcwI0tJJi1GPgD/g5P8SHQmf1HyjyerWvx5BMZUuQSaR+1K6g/l
	 LMWRL5Wcg1Ugg==
Date: Thu, 15 May 2025 11:19:54 +0200
From: Mark Brown <broonie@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Message-ID: <aCWxusdUYgeGRaqk@finisterre.sirena.org.uk>
References: <20250514-b4-upstream_ospi_reset_update-v5-1-7b5de0552c8c@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NvFxYeYGiMf1vQuJ"
Content-Disposition: inline
In-Reply-To: <20250514-b4-upstream_ospi_reset_update-v5-1-7b5de0552c8c@foss.st.com>
X-Cookie: Well begun is half done.


--NvFxYeYGiMf1vQuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 14, 2025 at 03:56:01PM +0200, Patrice Chotard wrote:

> This patch is dependent on commit 6b3754009f87
> ("reset: Add devm_reset_control_array_get_exclusive_released()")
> available on tag reset-for-v6.16.

When telling people about dependencies like this the standard thing is
to also specify the repostiory, or link to a pull request.  The git
repository is needed to actually pull the tag.  This appears to be the
PR at:

   https://lore.kernel.org/all/20250513092516.3331585-1-p.zabel@pengutronix.de/

which is the full reset pull request for v6.16.  The commit you
referenced isn't the tagged commit, it's further back in the history
but still has a whole new reset driver backed up behind it.  I'd have
expected that if this was expected to be pulled into other subsystems
it'd be on a topic branch and directly tagged?

--NvFxYeYGiMf1vQuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmglsbkACgkQJNaLcl1U
h9ClaQf/duEFMH9ku1tjFSWXgNBEHbSEBi9hfGtmNs2Vmy0bYAFCf/Ny5aHYrPmK
JJ7L1eHj3dfPW+ihDp5TgXjKgxHQdI5GMG2ywfUKCzT+I1Y12sb4g8F3CUWCAS1V
Wsu2gEje4X/5agpo3BprY1CgvAcuM9/u8/ycG7/DBXBmriq7BrYjbgxYIk8oxFpK
UAU49XCozl1o1It3RaLMSB3xnYnMyX+FaM2tMPrHXZJHLtAwuWChuCfQDo/qZIpa
yX7DwKID+h+/Lr5+EiUuaGLutyvNqjiC/kLtCi3LhSnVkgmFtvnfXQWZyCEZRkuL
J7OieaxVMHoILV2MPzAnMhSalQ5VGg==
=WTr9
-----END PGP SIGNATURE-----

--NvFxYeYGiMf1vQuJ--

