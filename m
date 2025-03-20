Return-Path: <linux-spi+bounces-7242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D573A6A4E0
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E770A1697A6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C421C19F;
	Thu, 20 Mar 2025 11:23:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CF1EB5CA;
	Thu, 20 Mar 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469825; cv=none; b=rfAldVgZs4hb5rHcPZWYbD1z1PcPpAdiHDdqGIoH8OXcMTBssGX33I9i00F1mfGX+01b93THw3yh0HupTn5qzdPtT8JdKTguiHgrWuW+ha47zSEEQRRkqd2B7Pvs3u1swGapClLMb7H4IypV9kZ/sOnqvFnNiSj7G3JehTlxN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469825; c=relaxed/simple;
	bh=J7A+/71KBu+WQyltiXCGLnLeM3H9ojVI/AKurNjS9UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiD8JVC7M3fBZVLv4QqskNh396r4w6pSfsajlm/o+VyKRAf2MjNdZn8bj0a2baih5CqY3t6Y9rGr+L/MikDxc4VYicvB3beH9JIKA0pVtJq9GNb50c47Vr/0hCOx6IZ+YYGpEyk3mIZcDUb4FG8VfYlZCtkGfrTZdA423Zc5YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA7C4CEDD;
	Thu, 20 Mar 2025 11:23:42 +0000 (UTC)
Date: Thu, 20 Mar 2025 11:23:39 +0000
From: Mark Brown <broonie@debian.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc: Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Dmitrii Osipenko <dmitry.osipenko@collabora.com>,
	Urja <urja@urja.dev>, Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	stable@vger.kernel.org
Subject: Re: SPI transfers in atomic context [Was: Re: [PATCH v1 1/1] mfd:
 rk8xx: Fix shutdown handler]
Message-ID: <b635f31c-3987-4201-b271-53ca00dbfc60@sirena.org.uk>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Dmitrii Osipenko <dmitry.osipenko@collabora.com>,
	Urja <urja@urja.dev>, Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	stable@vger.kernel.org
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <20240801131823.GB1019230@google.com>
 <ih7hiojzuvqzpyipj66mgu5pmcderltabim7s5dnfzm6qpztbh@jqkst5tfw5ra>
 <sg5kgo5qjqyzfyk5nyjbkpgvbx6sfb7agc67ch6wsdq3etrsbf@h6xbtfs45k4w>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3mHT6aMzMB1WBIG"
Content-Disposition: inline
In-Reply-To: <sg5kgo5qjqyzfyk5nyjbkpgvbx6sfb7agc67ch6wsdq3etrsbf@h6xbtfs45k4w>
X-Cookie: Do not fold, spindle or mutilate.


--x3mHT6aMzMB1WBIG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:10:47AM +0100, Uwe Kleine-K=F6nig wrote:

> Mark, are there concerns from your side?=20

I didn't spot anything but I only have partial context here.

--x3mHT6aMzMB1WBIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfb+roACgkQJNaLcl1U
h9BoXwf8CyNc+fhTrUdMmQykgnzhZDsDmXQugwuEIIwmJ/cavHj0kAuqp/8NKNRZ
wuL2wMR9ZnvdJT1ShMAbOKbFlMeaJuWiSHbmb8cQTATnXb4ly4yosc96ZhhoVwja
BqdFOksWlP7kISS73aoneIbEpR1ino2conTZCsVZBZ45Xomss6sUIkkfl/Y4tv8Q
oJKn/L/Nk0u2l/wO7C9OiMUnR0jtsr3O1IwPabp7Asit0Y+Ip0q/x1knSZnrGxak
QR/P0Jg6ODM6XVn+KVvA+9gbDOHAiiGPYkWVvdGtQ5LRMKOXWGfiA7mOvoy4Jkba
WpW3WPcspteFZW8ZTkjaQaBARI7/cg==
=HqGW
-----END PGP SIGNATURE-----

--x3mHT6aMzMB1WBIG--

