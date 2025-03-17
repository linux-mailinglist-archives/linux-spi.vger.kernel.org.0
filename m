Return-Path: <linux-spi+bounces-7170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FFA65298
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4653B1895974
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81FC24113E;
	Mon, 17 Mar 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7jU9tDH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62F241129;
	Mon, 17 Mar 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220877; cv=none; b=u3HLc9WTXNUL3XXRuPTed03xC/m7DOqseHdsBADZSmCd4HVs9mXzdeLvxLPNsaZ7kCknwhdOHeO6TWz2gGEBTJ8mDV+LiK8Sc4uANFSr0fmsAOMAbYPzuEvkHe+LKugxL5I1yvdiQo/n+QoUbdX2+OToLfrDMUwBPlHiNR70j9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220877; c=relaxed/simple;
	bh=pY1JxRicJZEiI7Ph2Tc1BOaW/F125agZaK4g2a7BjCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpBARPFmuO/b8GE26q8DU8hmm6+bRq91G3RgGoAi4l9Cv2Ht0IYiKeU/r0M3M+PCKdF4323VXsfapgz2oEwgF4a4cpdLFWShwipMRxA6K40+5s5OE38p/qMOD+nngbFJSMsi9sVLwZJfZw3fLfKjWv/+0f1A6G8MlQhZRsC0ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7jU9tDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED4BC4CEE3;
	Mon, 17 Mar 2025 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742220877;
	bh=pY1JxRicJZEiI7Ph2Tc1BOaW/F125agZaK4g2a7BjCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7jU9tDHKQsu4264eOxVqCtFefQ+3hHlSdlzuyA62F5dujjc0J8y8YcXXwUbzzAjv
	 6mJV8B0MlCCWnrdcJz+nPJOREaUhEQP1Ccw2212uEEyHficjeEzDxXmhWxs/udbsuZ
	 Syak/ALU8+PfWUTpLfJ45USpTfc1c1fvhGaanG9ufQY/wlT2HzUTL3BoF86xqoyOAo
	 fPhIQywP3DDvkSZAuX27cm0q8HUNGDPR8Tfgj4Jrgsk9fe1IaSlfC8fbkJKp0Ad+1c
	 2GLTvk7pt6LS+CQ+Uamg9GbzIjC/jJ83/GocWqKRvx0k6cbDCh4Ie9xifFql9Twkfe
	 kEPQ3bZnyrYsg==
Date: Mon, 17 Mar 2025 14:14:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
Subject: Re: [PATCH 00/10] spi: Add driver to support AMD eSPI controller
Message-ID: <e41947bb-7a2d-4b64-b680-d38dd9935a00@sirena.org.uk>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RLLAKZMqeKdynpzg"
Content-Disposition: inline
In-Reply-To: <20250313183440.261872-1-Raju.Rangoju@amd.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--RLLAKZMqeKdynpzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2025 at 12:04:30AM +0530, Raju Rangoju wrote:
> The eSPI protocol serves as a communication interface between the main
> processor and peripheral devices in computer systems. It offers several
> advantages over the traditional LPC bus, including higher data transfer
> rates, increased scalability and improved system management capabilities.
> The eSPI protocol supports multiple channels, each serving a specific
> purpose in the communication process.

I see nothing in this series that registers a SPI controller with the
SPI core.  You need to use the standard frameworks the kernel offers to
provide standard functionality.

--RLLAKZMqeKdynpzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYLkgACgkQJNaLcl1U
h9CvFQf/a8knKTfIgOI8IOHCct/yutOUa+x9Lzw7GkfqwWr+cM3ZAc4zWfpkSHHV
3pg577VvDocl+JNmfid77IqcuseOxmnhl/wI0ZL2hGJtOgpAa3KZ0wOlNvuVgLvA
naYxpUHm0SXQiUA2iPXTTyuCZztcqxCKt2slDi7fr0tnjIGZec9Xt3WL+yE65YEv
it8nbDQ9rcWRBe7VG9y5kgCWGGvhxX6K47VU5IrqnqWrP3dQf20jJrUlpiny54BF
wRmDZ715b4+OXKBlYBfc12OS5gm/whQFGlWsBJEoKS70GTzaBDDu4mAok7U8kT0A
J8yhDe3wtRWuDcqOMKheFWZkCLTK8w==
=wmJA
-----END PGP SIGNATURE-----

--RLLAKZMqeKdynpzg--

