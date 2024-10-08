Return-Path: <linux-spi+bounces-5153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D409A995533
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984CA286FB6
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CF1E0E09;
	Tue,  8 Oct 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sElErNoZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CF1E1024;
	Tue,  8 Oct 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406806; cv=none; b=b+ExCnkYET1h7l8MK+08DiyWW+3SJeTk7kJJTfzi2lJakzjvWBv2eUVWCYEAF+xmvau8XD0oQ0EN6FajYde3OKgjZKqBdual+yrvUh5JW+inkWSSyYNDi7zOyV93hRmjKpnBTm85XT4jQt5dESTgDk2tNaiUqKs+fjgSUbGCTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406806; c=relaxed/simple;
	bh=ilNygfwAr+c6HawWam7RWUXOjmWcDkBEry6nZ3GjjFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3w2H5JYPTzSS0fHMBAv0J9WVPOqtntiry+p7aKqyBwIbkAh+rZcdujigppxQQ/FmbvIbEwZaFjGlDgbrYXhNTDIj4/MT+turK+ddH6KasQ3L98Ivs6flIMRJ+0N+/bZ8OMfNQJ2RVdfVFUbHJeP8B4YOVERa0DPOhPLQBa7/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sElErNoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B180FC4CEC7;
	Tue,  8 Oct 2024 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728406806;
	bh=ilNygfwAr+c6HawWam7RWUXOjmWcDkBEry6nZ3GjjFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sElErNoZbiv37nRnBW2MU9Pgqb7CG3i1JoUGzmuhVQ3x5wd7cI3e8Gm1LF9Lfb6AH
	 HWe9x1CH4G3VqVW5xGLewPrxjdf43OPhCvFCaWaz+wPhqlWtXEyG26qwbBMU8sjYVy
	 RAFfO0/PaXe1yn4OPMgkOev/ZuOfSNPglknFIs8cI+8Z8s4HF3rHNYZYBN9Dq5JSVv
	 9Lz4MYNEkBaWYz2WyQlhxfovyPu6CQcbI/ZXgPgA/eCIIClYi3fKX27LR34bNJCTjx
	 ms+L8LM8PUjqlukl60t2gLIxrHdY6U3f/CpIoKuN8pQlj0HDg1pwW2bwjcY6z1Nivx
	 GL/qntinx1KQw==
Date: Tue, 8 Oct 2024 18:00:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	oss@helene.moe, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <ZwVlE9bgHYNT8J7J@finisterre.sirena.org.uk>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
 <e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lRqd+6XvOQTtUjE0"
Content-Disposition: inline
In-Reply-To: <e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org>
X-Cookie: Editing is a rewording activity.


--lRqd+6XvOQTtUjE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 06:18:46PM +0200, Dragan Simic wrote:

> I just spotted a couple of small typos, noted below, and I hope you won't
> mind to apply the fixes by hand before applying this patch, please?

Sorry, your mail arrived after I'd already published the changes -
please send an incremental patch for the one in the comments.

--lRqd+6XvOQTtUjE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcFZRIACgkQJNaLcl1U
h9CjOgf/YdYsIumY/c+kP3vXgm7bvxtlgtOfE5LJQjZQYzGjfxM0kQ+PuKn3AbCO
4lp9A4x7pDHgx9WAnyX4l/ILms/OoUu1wTgid7R/3jeDNzwcVCKdDNQI7zx9CUun
Zve7qeu6Tk+1tdM5TrduLh7U78SwXYEdAOT/ET/q/9cMSMwWv2hVJqG+BMCeXSjT
WQGgHkJXXW+w/pmIDmNbzWnvEM1OWyXpxtG9Rf3chM8DxEJBIvVhxhXGnwPMqOx6
QT82NcYOzOaiqdkq4mMtxAOUmMDXDm4Pt38T4YSSKF0jO5DgBq/8+r//47KkEb9p
XdDnNuV9l55UFJrV7O9IKPMQbjMVMA==
=5llK
-----END PGP SIGNATURE-----

--lRqd+6XvOQTtUjE0--

