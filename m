Return-Path: <linux-spi+bounces-11999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3BFCCAC17
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61E07300BB95
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB93423AE62;
	Thu, 18 Dec 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwV3hKNz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFB139579;
	Thu, 18 Dec 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044864; cv=none; b=YjUAjhto7YasrX0eESr6/p3oBPBeUguJmfJhxBuT5tjshNgWIHmATte2gXClU6DpsKpkByZtmyjuYsC7002GFcgao/pAGTeXnb4mvlhwbCiFQUVm7UEie263YAbDBONpXZvo1FGuO1cyLBsNcpFYiTV72b5f7eRvtZQ9UIAycTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044864; c=relaxed/simple;
	bh=HHlYP/1oT2kinphPQ9/3fzfi/qcVW054/WKuEsDPs0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxrnVrsOZI9gDegiBnCfDr67nZmB1u952kP7jtDKNfvNf7h1w2w6H+odCcT8bed9foFlmyiI1G6VX0h572Cgo9Ywrl4qBP9Vm0fZE7QtetKhRVjrdv2hTAi9LBKiNcHRM0Bl8HpPK2MR5MMSx1tzPeQt/YtQFm/9EWpSPRQuSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwV3hKNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDE6C4CEFB;
	Thu, 18 Dec 2025 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766044862;
	bh=HHlYP/1oT2kinphPQ9/3fzfi/qcVW054/WKuEsDPs0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwV3hKNzLZdlo15r6xATauOc2HzLW5FLvt0Sy/qcHArFX7+rnS1maXD1iZWc48330
	 dkKqbS/udUDkqWveQYdACybLxBc6QoEuNVqLBVYED4s/AqqzvnwD305wSeeO3OMxvS
	 k/lb3xWkNTasd02uI9ETI0UjGHrCw25GfgI6uYSccJjTgyjIqC6poTL5J5oACHwtJx
	 mTnwOQKDrdOBba96aUGdQ93nJM5rTkOzUdBFyps3w6c6NnGHgBKFUbqa7iAua948NN
	 umZyshCU9oNNtN7gnx27obLHQOM7MFudQ89pJfWtBc5oe7/ta8cz82JFUjOmI2JeGC
	 Y/fvFaTu+9+5A==
Date: Thu, 18 Dec 2025 08:00:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] spi: stm32: properly fail on dma_request_chan error
Message-ID: <129a4deb-ec9c-41f0-910c-57cd43d17fcd@sirena.org.uk>
References: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
 <20251217-stm32-spi-enhancements-v1-3-943348b8ff66@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdYKEQLQFnGb8Mm8"
Content-Disposition: inline
In-Reply-To: <20251217-stm32-spi-enhancements-v1-3-943348b8ff66@foss.st.com>
X-Cookie: Close cover before striking.


--xdYKEQLQFnGb8Mm8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 10:51:33PM +0100, Alain Volmat wrote:
> Correct handling of the dma_request_chan call in order to avoid
> misleading warn message if no DMA is provided within the device-tree
> and moreover fail if dma_request_chan has returned a valid error.

Bug fixes should go at the start of serieses to avoid spurious
dependencies on new or cleanup changes.

--xdYKEQLQFnGb8Mm8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlDtLgACgkQJNaLcl1U
h9C+xQf/f0u/7bqNRt7Lu7GnVRORacWjnXmidDhHzPASrPGgt/BgyySgqqLUtsT3
RZnxPRAkHkYlSW+Q5OlSlxnIXV+BBEK80tAUKZmTOSruQQBgkDUm+YJx932XBSUA
jqRZMpuH3zoYwVrWociYeo2PJClBKdsP8NYvQqj62Ns/xrNy/eM9Ow1afZgt+DQI
KKE+YHtIFNgTXUOokDuWbNQ6oR1BiP1UYw4M0iIgdSFAJ80q5bDf6EafpZ8s3UN8
NL6NiqggvpS0sSIJ4PFSheZnwNrdiNoH0I0kvjvuKpmQRBbBE2Jecrzy9WY+G0lA
brTbY9z8iMKd3oSOP4L64sMAhd1u3A==
=gJz4
-----END PGP SIGNATURE-----

--xdYKEQLQFnGb8Mm8--

