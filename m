Return-Path: <linux-spi+bounces-3777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9D92A139
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A92812CD
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4FA7D08F;
	Mon,  8 Jul 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+k2dce5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD91DA23;
	Mon,  8 Jul 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438366; cv=none; b=G7g1x08UfedtYJKuvE8cFSYbjWwD4+qLO46gy2PpAjsHdiJai/DIJaCn67in//gZ0t9DcnQN00r9zL+EKIkkY9s5s2e0aGZWJfQcc87Dcto1tofkCv4EzE9NN/sHuQkFpCUGVdD3bzgPtz7ZH+mWpTC+zFIIfCdzegxf7ByEuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438366; c=relaxed/simple;
	bh=TaP69O1AcTHwGGnpWBb+wF1ItMcV2MzDgm63vJ/vqws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzgVbywkEVblOBzpNwPLHtbpDmOTvQDYjgnEaDYyGYajRARBxT5w7w9ZXs1+5A1Nc7F5abnUsARxfIt/yIb/OFrjxESQgagbE5YRu/NjmorrrciFmLUaEC+1o+RC5roaqD06Qyiwx4fPvyZIkvHLxlJzrHJU44mq8xwwy0JskMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+k2dce5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E097C116B1;
	Mon,  8 Jul 2024 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720438365;
	bh=TaP69O1AcTHwGGnpWBb+wF1ItMcV2MzDgm63vJ/vqws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+k2dce5TnT1WRk3788Sn38Aoem0o9jftgrTRomrVEtm0jrcR2nux9hbucmBGK0Oq
	 JrP+5xcfchMMeZ0Z6tWe2Q2cxWBC3GgHWGoaKeEC7ESFNkWHGsB5VlL5FVe3WbPXqT
	 e4lBrwFnBqgt4EVl39B96rGiMmmuvp5Li4xaMSS2TiBW61XWd2MvqET+benYLiFrHS
	 b3VKFcM9CUlPCQFfQ+8IjlfV2Zjlh4JN1jCB4HNt4OX91Yj1GC5/XURSTYUXbt52zy
	 v8VChEX9QD/X6BpmTr5j1JwDQipXr5DK4AsXkmm6imjZJ6kfWPUvH+fgGrYpCKhvoA
	 oDBQOzuHf43wg==
Date: Mon, 8 Jul 2024 12:32:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: add ch341a usb2spi driver
Message-ID: <5890754d-50a7-4db6-a33e-bba64ca1389d@sirena.org.uk>
References: <20240705145138.5827-1-jth@kernel.org>
 <aa3c79a0-ecbc-4f12-b540-6570350a7909@sirena.org.uk>
 <8a2467b9-4eb5-4ab4-a4c8-da37875fe4c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kxlYLbY8/HSZ+yg0"
Content-Disposition: inline
In-Reply-To: <8a2467b9-4eb5-4ab4-a4c8-da37875fe4c9@kernel.org>
X-Cookie: Many are cold, but few are frozen.


--kxlYLbY8/HSZ+yg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 10:04:41AM +0200, Johannes Thumshirn wrote:
> On 05/07/2024 19:41, Mark Brown wrote:

> > No validation of speed?

> TBH I haven't found a command that reads the current settings of the device.

Why would reading things from the device be relevant to validating what
we are writing?

--kxlYLbY8/HSZ+yg0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaLzlkACgkQJNaLcl1U
h9DnRwf+NTQGAhTVqssU45qKbbkktImuHudAFa8Bjn4ZP1dMFrSJ1ZxxpX6dHi7W
zRtP/gHvK2WYJ/tXPqvbDKl6qlGzMouUpKQ40pIBZRMNEBsZa+0UWGTIiTz7w+6T
mJYdjgv/wv8AawKE8+KcSeUCCZVEyPbtb5MerXc5yq328xv8phflMNdg5YTXVKPn
Sy+hrifX6Q7puMYrJG6vcFdONPWFTswSMrbzY0m8dla/Lvbq7KTzk/HafCRgmwEj
eoJ+N0K78E5n2CewDY/dHGFZOC+0PsIa7YXrUZoUGiwiwOEyrIpzXqLict4r2SpH
F93d6xnWNp6isRyDy+MJG1DoD3a0Ow==
=Vlwg
-----END PGP SIGNATURE-----

--kxlYLbY8/HSZ+yg0--

