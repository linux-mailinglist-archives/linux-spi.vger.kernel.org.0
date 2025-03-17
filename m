Return-Path: <linux-spi+bounces-7169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF333A65278
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B97176795
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030523F439;
	Mon, 17 Mar 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qutWab/T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62419D07A;
	Mon, 17 Mar 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220611; cv=none; b=Opa+aGVNNhgy5a3pV96b9dT/u1nlTGMrJb8VSh7RJcSIa/D1SpaUtjYqEFbbmj1JEhqWizuLgRAsnztI/6SKALIAen3MUgcmlj+7ilAhBjYl9W6bIzI8It4w7IO1SKjhun/UgXWk/rCq/8tIFKVsq6oyhvk/PBAbxWl+x3dXtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220611; c=relaxed/simple;
	bh=L9CTjG7G9nLgC1mxFiRCYSL1btZaSkw8ttOOCPruvGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSgoY2ueDFBemmzmogOQ2AH9LlYz5Ju2mJsXDBMujjVKvhzuiRrvyQb+KhdCkDWh2Ws3ne70BRZ53QtZofyLkYpxs5s4pgAi7xVJnNcv6qDclt0Oail6XahjqC/5gWoar/R3DB4aWNK8LFo1W36S0SYthBS5AUpQZc6qbMXbRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qutWab/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C13C4CEE3;
	Mon, 17 Mar 2025 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742220610;
	bh=L9CTjG7G9nLgC1mxFiRCYSL1btZaSkw8ttOOCPruvGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qutWab/T2ZSK2upZOEAUDryMkpWvnlRDJEBSXH0tkO+cwI9WokJvE2TngQMRIx8+c
	 et7kYrP2IFmWA+xwsNBLp1DN4KozNadjQlA7lsFVsaMgRcOSmSkVL+nmALAjbTM7Bu
	 l4b+fnMV7gyDRtwkVPJx1cQhz/OHxQjmH/xdRc7ELbayvx8n1ukM9xJKVnhqLm/kXQ
	 zuCuCdhOE+MhmSVpAuIkMUZMEioDrGaFOLuPIL2flcfsdnputryGbCS+5s/+Fu+Sxo
	 /ZRxXlN5myDxrCOLecE2guawnmFNhxePEYFbIAhVeX4ozuJdhSVqpgVEJonqH4WFNM
	 HgDuKo2Rt73Lw==
Date: Mon, 17 Mar 2025 14:10:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
Subject: Re: [PATCH 08/10] spi: espi_amd: Add support for IO/MMIO
 configuration
Message-ID: <b409f5e3-2259-4427-8d4a-1652e7fec135@sirena.org.uk>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <20250313183440.261872-9-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yjdKVU6i119KzzK"
Content-Disposition: inline
In-Reply-To: <20250313183440.261872-9-Raju.Rangoju@amd.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--6yjdKVU6i119KzzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2025 at 12:04:38AM +0530, Raju Rangoju wrote:

> Add support to configure the eSPI slave0 IO/MMIO address before
> initiating the peripheral channel IO/MMIO read and write operations.
> This patch introduces new IOCTLs to enable, disable and read IO/MMIO
> configurations.

This absolutely does not seem like something that should be exposed to
userspace, if there is some reason for this to be runtime configured it
needs to be clearly explained.

--6yjdKVU6i119KzzK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYLT0ACgkQJNaLcl1U
h9CkMAgAgKTIXBegLJbAuV0yAlXU4hPik0zKOZpf22MFuuykcXh2O3pWmv2eo6AR
Mk2njyQQ8bNxGwnhotnarojWkYYP1WPqP1feFfPpJ5OUoEPzmapTdTQN+Yp+Y2Dv
3TTLdbZIcgVXhmOze0CzqEtEVEfbQSMLZzyoKY9W4R6ur3kwbMuW5jNL/iqQGrIy
IzH5InJ7KiyzPFDWBpRW5ZVGQRbzfSjK9i0CIVW3b0eO4xvMwjVV7b8TbcRSCOod
3w4hy0p7Sx87j+OhezJHEk6cPQF7zQnILH6fnNpJRiZlpWyy+yT6WXizST6hAaJj
Kj3WuKiTwALVAhiu5dc6oZ0IX7WKPg==
=3cS5
-----END PGP SIGNATURE-----

--6yjdKVU6i119KzzK--

