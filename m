Return-Path: <linux-spi+bounces-10601-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B678BD28A0
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 761114E4161
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175392FDC4F;
	Mon, 13 Oct 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wpw16AsA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42771FE451;
	Mon, 13 Oct 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350934; cv=none; b=rMf1Dm/W915bPHoINRvy3Rmk4bcGJg381fhYydHeBLWsACL6hg+m9P5e+rVrgSRTga4e20QjcvdKJcWunwn1zztcU6SS7vCyLyHLmnIHRML6TUnpS76IkY4lnslQoxJ2W8pF0e5JCqtJ/qXOLbVmuQ5uHt8+tXv/ntDkyxuQ6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350934; c=relaxed/simple;
	bh=Ha+XjhxGqCNF/jxkQ9GgocMSomyC+fzyaGHj5iGSOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKN3L0hh4QUZC7dAf5Lrs8fDI2MEyyllf792zE9ECDAubofCoNXNHFHqulI5cqbcrQEKcRG1mOrtURhHn4NZFE0bxFRUHsv+j7IaTJaanmoyQxAQ6tRvEdQbCqU5m1RqAnzSmS/UzCC1KPEpiPFFOzqKhK7v1jnorkQ9FWQ1Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wpw16AsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A45CC4CEE7;
	Mon, 13 Oct 2025 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760350933;
	bh=Ha+XjhxGqCNF/jxkQ9GgocMSomyC+fzyaGHj5iGSOEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wpw16AsAQC2BJBdk24GhDU22qs3mxS6gpYkq4cab7uEkFNLwT4lDTc1IIlUztYj3y
	 5PxnAJWTWrW2csat0IUh2eOtt/ZJ428AnuOpBBFXwAWxfqeq/kHqqMmTtkd70TESS6
	 j70nOlYxk0NQAED7IH33cd6QD6i0SxhV8AEN7Mhp5lZf79ZnklxdMJsp8uPHJiFMo6
	 1FuHuhfBQ3qj943dPR/JrHlbjCtkgi0Nuy/T3ae6FUgXgdMDRwZSwZCRxBrLsr6Yxt
	 ahzbOsGL+ppMEKYDcqI9zldOdGPHTAqyXal9h5VnEblzxEnQkr2LIHFPCsD/1gnXUY
	 7Y62gn4zOdzdA==
Date: Mon, 13 Oct 2025 11:22:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Message-ID: <eb66bb86-328f-4d43-96db-e0a31eb73ee8@sirena.org.uk>
References: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XwMN6qierxuC42Dj"
Content-Disposition: inline
In-Reply-To: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
X-Cookie: Custer committed Siouxicide.


--XwMN6qierxuC42Dj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2025 at 09:10:38AM +0200, Mattijs Korpershoek wrote:
> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
> we handle the error by jumping to probe_setup_failed.
> In that label, we call pm_runtime_disable(), even if we never called
> pm_runtime_enable() before.

This doesn't apply against current code, please check and resend.

--XwMN6qierxuC42Dj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjs0s8ACgkQJNaLcl1U
h9DUMQgAgG7yhj+uapZIfl6vEXkTD8tC6Gg8YUFWLbeCz7qjGUG9rsgyDSq2Hypu
sSQFQtIfgfFNst19B4amM8sZhyaOeDggXGE8LPnaXgNu7aqCnj9fgAAjTMhbafG/
zdlhFZ1NPTRrBIgrd1phNyVrISI4kfWxO4CTUgX/nLKrNcVD8VCExINxwaKx5CTZ
2c0ju84UYEXSA3MiwUIUI0hpb1Aae8Ab2bnUOoKZ+N3LoWObMM/Ssb7Kzegc1EuZ
LJeH+pcna0D6KmRi9eoVoqIjS0Dz5p5VSBmJ3ECru8omYQtfnaERx4Szxmxf++Sd
UaaiotenfGnV/d3DdELjn0cSwRymOg==
=fpq0
-----END PGP SIGNATURE-----

--XwMN6qierxuC42Dj--

