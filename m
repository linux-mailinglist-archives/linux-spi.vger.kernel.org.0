Return-Path: <linux-spi+bounces-6724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8164A2ED9C
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 14:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E816B163918
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15A225380;
	Mon, 10 Feb 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INz2Pkzd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023517557;
	Mon, 10 Feb 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193831; cv=none; b=Upx0B9JbRoZcOomvVnf0VWGofGc4OaKXOQiOC8yNDEMCLZLGGtjfv0/ChfoiIHm53mVN1bSDRIFgglWk3PvVjpeiluT6VkkSJInz76TbOjit/IGLF9OoWraNnDjFeVrxTT4EytQKuOV0kLv6/nLldxoqULDukvGdEOkLoIar0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193831; c=relaxed/simple;
	bh=Y3VnAjPcpvtraPLxFVav8kpsZk6gHNCgxWi8l3iTFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC/R30OrjMElrg5VhJUhdGnqbFORqZt1vWCW42BjK38YgpgMm5a3wtGUrf6qvg6Q5rF6GvZIDn6rjzIo1qFsqFaQthjhxATKImhV0b83nhSc+B1nsuDYT7EFL9/znckdJ/0tnr1fTVw4Yrxq3r85bOVUJHrP/1VQh+roTls4Rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INz2Pkzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCA0C4CED1;
	Mon, 10 Feb 2025 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739193830;
	bh=Y3VnAjPcpvtraPLxFVav8kpsZk6gHNCgxWi8l3iTFmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INz2PkzdF3dydAUsheI8aeft2xxJ+B7mQw9D0MLNqlf0zXGx26unNWV7PP+NQfzjG
	 2L2sRIfK2BKLo86SxJmXSi8yNkzko2BHHIuYYeLg9EGE/McmwSXKPsMqg9n+VYhf2k
	 Cg18HM8JVLu+SXg+7Umx7NTSLOx9TXuZ7UDzlV/TXQfVg9BclrzEWT9eve+FG4AG1p
	 jo5cHjxM30wtfrvjRQiTf1oquOI8VmHjDp3+U8QNpFBCxY850z8g001ehO7nW1eIO6
	 DX9FEsHVa5RFEoXF3/P+DCDvqJFM7THfv1lTEoAuj9v+LfNWff+kkc568hsbiHhemr
	 bWalo2X5W3TdQ==
Date: Mon, 10 Feb 2025 13:23:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH for-6.14 v4 0/2] Add more devm_ functions to fix PM
 imbalance in spi/atmel-quadspi.c
Message-ID: <e0087d48-c8d2-45c5-ab28-78879a07eb22@sirena.org.uk>
References: <20250210111008.248929-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSVsPF+JhA2IRy98"
Content-Disposition: inline
In-Reply-To: <20250210111008.248929-1-csokas.bence@prolan.hu>
X-Cookie: A beer delayed is a beer denied.


--JSVsPF+JhA2IRy98
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:10:05PM +0100, Bence Cs=F3k=E1s wrote:

> Bence Cs=F3k=E1s (2):
>   pm: runtime: Add new devm functions
>   spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

Since you've not copied me on the PM patch I'm not sure what the story
is with getting that merged.  I'd not expect new APIs to be merged as
part of a fix, but perhaps the APIs are small enough?

--JSVsPF+JhA2IRy98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmep/eAACgkQJNaLcl1U
h9C+PAf7BUluKVL8LhJBrCwdsziAE82+ORU8+jWviBfZfMhtV4lOsA5LDeq9L3rZ
D4vzWJunEcCFBqVQRYRFUtQTN0BvpqG2ELaEgZzKkkaP9J7PY7aFuNu1YBMwVYhk
BhkjzKr8RDcpkwaPLY2telDFB0Zb7N1/bzln1Q4QGWFl/f+xBj6W8k/7nQeGXmWb
hxbsesr6VLxSI8DwKJXZCYQYh1vtd1N8b01WYXfwA8yEJTlQzT+6Qw74F9T3ZbbG
OE0W8Ukd3VQHi+Z4XYdWrJM+CHqeApw34hR/whxnw9lhWUyVGX6q6CZJKKC01kRu
1Xi51tdbGeQW10KUD13OJKo83xOTDA==
=85Yu
-----END PGP SIGNATURE-----

--JSVsPF+JhA2IRy98--

