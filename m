Return-Path: <linux-spi+bounces-11589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E44C89AE6
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C313A51C5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37432549B;
	Wed, 26 Nov 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIi98YGj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789F3203B2;
	Wed, 26 Nov 2025 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158726; cv=none; b=nWU1Ru5OuAoqKB/Kghav0s/W2xVy3pjoPM4BexZv7u8pLXUoBnt8pdhTcDUurQKyzmTblKc+tzUOOiFM2Xgl5A08TfEWv2IpPpmASTGb1vjwqytETPtkHHT6S8NSAYHrCh3Nxxo0FxAQCcLSGEBlX1P3rYRUv6haqtozVObK6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158726; c=relaxed/simple;
	bh=WIpGzrVFgHunKp1xwPD63zz5yulphG7CNmzLxHDjyjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk2oDLSiwXCsXsVSq9n0Movx3das/klESJTYEKTmex3LEW+5nlpjtbWG8ojrTf7ZZklpebJo99InBPfzTTxqRa3bZpth9qV3425EefjXQQt1avayLdPpcqy6Pc90cAQ8k8R9EKjBBQhWX7UO10FDwqSlLoiQqf4tmvw/7sEUtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIi98YGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6E8C113D0;
	Wed, 26 Nov 2025 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764158726;
	bh=WIpGzrVFgHunKp1xwPD63zz5yulphG7CNmzLxHDjyjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIi98YGj6OkSRzsw+QLGVGtcdZCh1YiAobd/IgLKOI0pFqFTgANx3BuEPNMiYuyNW
	 APkV1dUzad+7+vmZay2TEx9vI5AHxE/LH8Tmph5H3AeLIM3mMmYjigNp+dIYVasxLt
	 0qYCxIuWlvdDefri4mNuvqRgl7zc2Y3KWamOTDE5LAVxuqwsJX7DN20BaVrfT9oykZ
	 NkwSlnPLC2H3K0ejdJpMTz1jBGDLTlNzavDK6QqtMDesshrNQ5PQiPyEhBlEDNkxB0
	 kR6+ljWn+ULWIx5pWSCoLam63WDLHwvO1Nbwy9KHR1ixJz4F4wg1DBzQNngtHodF8Q
	 K85jlT3YwmU5w==
Date: Wed, 26 Nov 2025 12:05:22 +0000
From: Mark Brown <broonie@kernel.org>
To: david laight <david.laight@runbox.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HgT28zdSZ+BCiKz/"
Content-Disposition: inline
In-Reply-To: <20251126092145.2f8e4c8d@pumpkin>
X-Cookie: Murphy was an optimist.


--HgT28zdSZ+BCiKz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:

> I'm not sure I don't prefer the version with one writeb() call.
> How about:
> 		writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> 			spi->regs + MCHP_CORESPI_REG_TXDATA);

Please don't abuse the ternery operator like this, just write normal
conditional statements.

--HgT28zdSZ+BCiKz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkm7QEACgkQJNaLcl1U
h9DSIwf/TNxkTWgPOuilJ2qM+ayvfyrVIfj+ne2x1JfsnvSertt+9TCDVMEJE2GT
cm/6ALNHHH9KCj4L7UWamhUT0XiPe4YdUvBhS1wfoVsG0LtqipLvNUFwRrmsbTmx
6JwzdBwqTll+V/69UMEzBupJZdF0k9FJpjymen2Bh3dfmo4Yz8aJXtb6qeAkgUcp
MKl9mkzq1mAFdAal5XrW+UDEVyi8MCd59Gka1yCgP18WBfw9vwN9k8Rn8vPXYZQM
B+/evMRL2VXyMMB2WfRAOlvgPmquYTw2Z7DMwhOF4BStrKBeldYTKYcYC9KPU5kd
Fybz6eMLLEYi709cFPYCzzk5n/IvYA==
=HbWl
-----END PGP SIGNATURE-----

--HgT28zdSZ+BCiKz/--

