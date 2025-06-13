Return-Path: <linux-spi+bounces-8496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C44AD8A22
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E397C1899FA7
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446ED2D320C;
	Fri, 13 Jun 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZlWlYN3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6591E5B65;
	Fri, 13 Jun 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813291; cv=none; b=VNmXnqoG+rovGh2NYv6Q5lMGp+jPIOD08eEPLMbE2aYnQnqxT0TH8ol1aSqmVj+T/qG7yz07VrUHhTYjXdwj85HckU2I69cOM1eiy/aiqDKZWw1tkih+RRz7us6B5W+R3+0qojdTi+t2Ma340PFPMavjZM60bBIL/r9NH2ofXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813291; c=relaxed/simple;
	bh=FKjY/JRxG0t/4YuVMn8LL5ecTBH2Uc/XSt4a6UISysg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL7ty714Y+ETEzAOv2A2xOmGh8G5uRXA1DhP4SbCajKXSckmNX9OlwmwgKOs6tEU44nhKk3irvuiKqfOevyfgcADPyitKtdsEzz0+tzQnRV6iSpoXAEEVgGuOzX3/3dV5xoR0hlyqRJF2MxlhbCrZPzyfxPEYvc9NaEPfeN3vkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZlWlYN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5BBC4CEE3;
	Fri, 13 Jun 2025 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749813290;
	bh=FKjY/JRxG0t/4YuVMn8LL5ecTBH2Uc/XSt4a6UISysg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZlWlYN3WxpjO+/2zefu7CdLwjlrfaa2zEbeRs0cNj5NoLHPqrEU7LXsgKEUFyeLv
	 jfShyjPAv8zSjaCoZQ74EOgscaF862E+pKT/waz8imxo12Q42187vprw+KJngCPz1B
	 +kEzdJyXq+7tCilQE1+RLsfnYEOg2/+8HHpp1XLt8Wp89LDzAKEXK6/BXrMJs0gOUP
	 xrsnUv773GFPNNKa4zTYhPUU2BTFdhAiTf45943nuwfm0ZApxrY7VFZycGvnhH6hiA
	 HdRqZsoemdDnCwkf+0hd8Liz6ciJQ7cLEG1GorNWkuO+/1Ar2RuoLlMN5H5MHiZP2H
	 SuU/x9nUAErbQ==
Date: Fri, 13 Jun 2025 12:14:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 for-next] spi: spi_pci1xxxx: Add support for
 per-instance DMA interrupt vectors
Message-ID: <4dfcea41-2bfe-4f4a-91fb-94d9b636add7@sirena.org.uk>
References: <20250613023236.126770-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FvOZODbIGUHLXI0o"
Content-Disposition: inline
In-Reply-To: <20250613023236.126770-1-thangaraj.s@microchip.com>
X-Cookie: When among apes, one must play the ape.


--FvOZODbIGUHLXI0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2025 at 08:02:36AM +0530, Thangaraj Samynathan wrote:
> Add support for dedicated DMA interrupt vectors for each SPI hardware
> instance in the pci1xxxx driver. This improves scalability and interrupt
> handling for systems using multiple SPI instances with DMA.

This doesn't apply against current code, please check and resend.

--FvOZODbIGUHLXI0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhMCCYACgkQJNaLcl1U
h9CBXQf/dQVd+pQTA247VlEhTCYeV8vwKkcLvPJzoZRkGCZrk1bGlaHVDFKVdfvp
1HG44mibqiiE/jTtn1OPcYhDqkeQNbZPl+3Yj5ut3M6I0qPuVMd2rHJqhsY4uBna
HxygNAnQ40zIg4pQvH7oBMv2YZ6sHcbwlhcy4IpFyIrQJdTCQ2p8Z+clSvGpfpQU
r9V4HSAez3eScUKLPvqpYhQVlOzwIZerlrlvAPnFfY3FLn85HR78mZ7vQeY4f/1s
8zaVxUchwwgOPa+uEzvjIHgXfkBQuMoEZFl/QilmvgNQhfBeIaWeQUwS8lezfD0c
EdkiblKqaZJecCoa5BJVC/57xRx8fA==
=Q5dk
-----END PGP SIGNATURE-----

--FvOZODbIGUHLXI0o--

