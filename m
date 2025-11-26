Return-Path: <linux-spi+bounces-11607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9500C8B2F9
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 18:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F143A7F78
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD1275AF0;
	Wed, 26 Nov 2025 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qav/Zqax"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FCC13B;
	Wed, 26 Nov 2025 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177893; cv=none; b=OjZCzXr9AerbKyccrXXBa37zdP9/IWa6frYJge3Pxgi7pw9mAFYBeyNtw/YosmJ68tAxDPeQbzTHRwbuljPEsznEEVbIf/wsdEotaQ3S7D2WLrUKlQJrL8KoVE3etNTt72UyPZg3zij26XNtvU/57zgloSDvJL/CL7Utw7gsrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177893; c=relaxed/simple;
	bh=Vdt3pSSRjcgs5ec1693fk1O6x6zbpIqqptMs0WHNRoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtOwPPjlIZDWLi/oVzZVoGLYmTALNdzSaECDtuzmWQMek5QfZ0xJqzNHzkFmnH/ihFpSQvsE1lGUqGiptHk5grwazWsI6r7xJHKtLHRkbUSshHDNz49uiQ7JXDAF0AnJWxjgaBnMV1gPcRxkIpXs09ZDSacjy5o5fwC+eLpUE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qav/Zqax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489B2C4CEF7;
	Wed, 26 Nov 2025 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177893;
	bh=Vdt3pSSRjcgs5ec1693fk1O6x6zbpIqqptMs0WHNRoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qav/ZqaxajBWzhiiHNU1zBrakfX6zINm3iXUIbJmJWaGCJWmnbeQWJi0KdtcFZ5zf
	 fHXN60Ab/0v+QMouGQGyoARGUlpQ6oj1s+Lv9PTjQJID1/tfZNUPMR6yx8MO20UlFt
	 o6MurLHpBEboR9+0emsqGz9uZ5JKCU40u6i7V42+7TfWbFBacOxfCSRHqPGjx6bnSh
	 reWS82rweNs6tOVqA2RoxWdn23GbmB9eJciQKsoDb7DK3Fyb/tF1KV1JymkYx//9Eo
	 /zLEKGMHf8F9j7rQ0BEqL8ZIqiINXt3YUWJnVLq8d2vpgQmVMxSsVV3UolKegpyFMZ
	 66+E01MIOswiQ==
Date: Wed, 26 Nov 2025 17:24:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Conor Dooley <conor@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <31ef355a-9b72-4c78-aac2-b632f5e22c07@sirena.org.uk>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
 <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
 <aSafnlEbZt-yFzbv@smile.fi.intel.com>
 <72130514-d9a6-4cbe-ae7e-7e23abc95286@sirena.org.uk>
 <aScqY4s5EFgvw_5g@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="36iuZCXeInYoRHRU"
Content-Disposition: inline
In-Reply-To: <aScqY4s5EFgvw_5g@smile.fi.intel.com>
X-Cookie: Murphy was an optimist.


--36iuZCXeInYoRHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 06:27:15PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 26, 2025 at 12:03:40PM +0000, Mark Brown wrote:

> > It'd seem better to make the OF APIs better if
> > there's some big win there.

> I dropped it in v2. Can that be applied instead?

The microchip people do usually review stuff.

--36iuZCXeInYoRHRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmknN+AACgkQJNaLcl1U
h9CJhQf9HuW0ktRVUNJNUkuEhyhViYid0rA8/6C0ih96baD7NkKhnC3aIqCP9dsS
JFM2BTxHGlDt8DEY9FfE9PiV5+3U1B9EsCl+pzzvmS5lZthIK67jE+PzCznWWX74
00dDUT0O+kswDHt8xpZC34/haalr4L6YmcMZYnYs+gq6d611eLo9xTt0nUUaFNU1
alL/C6mSrxSC+2lKED1FvolMl4Caj1e6ImT4SERm9apTsWJQacY83N1fzsySOhdu
zzr2ud9ng5+xuskQ56UP7kJU59L5Ab/HqRdv1Lxd5tf3XH+pWYaOPmQKLK5wr+T8
/XJFN2gnUP+OP+K5d99+DPGIRevo5A==
=RvPq
-----END PGP SIGNATURE-----

--36iuZCXeInYoRHRU--

