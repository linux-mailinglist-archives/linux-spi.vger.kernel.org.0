Return-Path: <linux-spi+bounces-6997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C707A4C11E
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 13:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7980316312A
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148273BBD8;
	Mon,  3 Mar 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOs8Hjgt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE91FFC60
	for <linux-spi@vger.kernel.org>; Mon,  3 Mar 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006771; cv=none; b=q+Akwh/CTCLt3fdrRq7woZzJ2x7Udh35KCRxTElF9Fyv8cKu/WYS8DBCP4EXQOZGoImHG+wDlsoQFMslrvISrqISEq/NUmWtRNzPKc4tB3VaA+ErJw3ALqaBz8+hqPHo/HjtpBWQMCvENN+OsUA1ITSXRCAh8w9xrRGPlDINKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006771; c=relaxed/simple;
	bh=SACjaJP3LzVSYFFi96zU/B6kw9WLTEN39+YzS9/aXek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGTujou4w7mS89Fu837UpdKGIUCWq9KQKpywQ6n3I3C1UsLD1xSH71/xInqgJi7BltNZJXcfcP7ybTNa/kY8RIbxV3ZyJD+AIbXLZfI1NxkPbreVPHHt6f6Cc8FmLikaeMr9s4l6TKZ3+ZyKaW7P99ZAsXpnWv5UVz8NN6dKruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOs8Hjgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79191C4CED6;
	Mon,  3 Mar 2025 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006770;
	bh=SACjaJP3LzVSYFFi96zU/B6kw9WLTEN39+YzS9/aXek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOs8HjgtIb7qazxI7+UF7XzJHAdL/BkEYWyTwQr8vO+l5bfVWCEeWzoVe0ERBipw9
	 LXJtNHGQcQK9KcXFl+f4XmUcrnMYqqD/QcBUqQiSO8WHuKUxwiviTVO1WNOmiLGXD0
	 L7G8PASLSN3ovnwY7mh6D4qiDu9+Oxq1u4qIAPjnu6MOItdLegFGoBc/5v2M0aIY9w
	 /1e7OT5721z2+whvTNzoo/Er+6JLTgxeVhRHM+34zm/qZxNnTRBVBx7PqduunS7kyC
	 FWfflccJWM1vGNMXgZG9FhMulI8wypoExFAd2ApaGFHVONferhWxryn2AsBjcDy6rn
	 YFVBMXkg+Cj6g==
Date: Mon, 3 Mar 2025 12:59:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: cve@kernel.org, linux-spi@vger.kernel.org
Subject: Re: CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on
 SPI buses
Message-ID: <ba898656-ea9c-47a2-9ee5-0b5428cd1a8e@sirena.org.uk>
References: <ee5f2de4a84c04df92644ea720b88497528004dc.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcM9yuu2T+YTJAso"
Content-Disposition: inline
In-Reply-To: <ee5f2de4a84c04df92644ea720b88497528004dc.camel@decadent.org.uk>
X-Cookie: You will be awarded some great honor.


--zcM9yuu2T+YTJAso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2025 at 07:03:30PM +0100, Ben Hutchings wrote:

> The commit fixes a deadlock during addition of an SPI device.  Since SPI
> does not support auto-discovery, I think that adding such a device
> requires CAP_SYS_ADMIN privilege (but I'm not certain).

> Since it is intended that a user with CAP_SYS_ADMIN can deny service
> through the reboot system call, I don't think additional ways to do this
> are security flaws.

It doesn't require CAP_SYS_ADMIN since some SPI buses are themselves on
pluggable modules (eg, USB) which can be hotplugged and will then
register the SPI controller, bus and devices.  However those will
themselves require physical access and I don't know how many of those
are upstream.

--zcM9yuu2T+YTJAso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfFp60ACgkQJNaLcl1U
h9A9vgf/RmWBZZhiBc4yW6L+yW4ooIj4hTdE4z6ZY1DeFgwNHZfPUKlCNdDEIrdR
chQzVsne5IhX0CF2uOQoBNv8ke7vgm3c4RMpmNPtZ+QxiQ5NRRry9p6Eieb8jRor
gjRjE3D8wQshtESV99JnYd46mRHBpduh0NYRsJILBcKjS46Cn1VgTT3Xp4zxGrjF
8vPnxDqbOOxMZ4SgNseFNhViou6Ya9O5iPDZrW1X7GiJtdB7f6tqGBZbBGL+Gie5
rFbni4JqghDrGZZ+Yq8TpkVPIzJz/dQBdfhXOr38WFVAKLf9zkHcVf7GzFL1WeYF
HHH0QsPMaGYM9rj+N8995/hU/BQ1mw==
=Kk2h
-----END PGP SIGNATURE-----

--zcM9yuu2T+YTJAso--

