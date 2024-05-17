Return-Path: <linux-spi+bounces-2918-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177A8C8AE9
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C14281660
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234413DBA2;
	Fri, 17 May 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5hRCUIj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0F38DD6;
	Fri, 17 May 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966683; cv=none; b=YlbcdPPDWkEfKrpXsQszbVC1/hCY4rVTs8Edw3tUP5hmn61/fx6z6qmMLz1LBeTW/T52sQRftpardiItuq+qg/YRPe3YHiYo+V3ha0ZBargytUsdq6LozpUCxbQRc47dvH/yX+mIWYhIFK+jh95ez+1de3P3ejDH8NDcNYMkcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966683; c=relaxed/simple;
	bh=rjTs1bN+hgsUK6tXA1jKQzxe9KRIcBfqG1Hp0wZaUbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC+C4AXu2Q7xTb0QBiyteczK+lfbsbWp5+ssUE06N0CuO5nPKcrrOJXhkv2kVPe7jC/NOq8o1gESWTSIrtyU8XGULstQm9xDlqVqdc4STxTGZ0LRwCWJshiztCdRMuN0WNOye3SY/ZxZNpnTjVpTdE4HzO7kc3YUHP8PbJ9bDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5hRCUIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BACC2BD10;
	Fri, 17 May 2024 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966682;
	bh=rjTs1bN+hgsUK6tXA1jKQzxe9KRIcBfqG1Hp0wZaUbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5hRCUIjC9rVrZwTGH2u6b8M8J93C9mUq6Ubs923sLq747034VxoBbds4Ebnw0A0k
	 37M1vm9bDfDzm15Voz3iUqflqKvqGmsXSMqbr54U+ZaXE59eoVoDb/4ZSrUy2aXICv
	 jUYtDnHX/agDZIs5BMMS46zYKiUxoG7wkABQz/KkO33wx3t31uS1HH3o2QmXd3WmhS
	 vO+ti7w1BIrn6O7m72Rp0qsjdzWH+HdhaM219dgY2qB1OABitAXi17VAklciDmdd5T
	 gfv/a783xy85MpepntAdmuUCCWBmd2HeScUEJ4BdK7imRdaZGq3DoAkeC9U2z6n4kG
	 UvowbL+WniRIg==
Date: Fri, 17 May 2024 18:24:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Move PXA SSP bindings to the correct
 folder
Message-ID: <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk>
References: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yglz+J6siImMAjPA"
Content-Disposition: inline
In-Reply-To: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Function reject.


--yglz+J6siImMAjPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 08:11:03PM +0300, Andy Shevchenko wrote:
> SSP stands for Serial Synchronous Protocol and has nothing to do with
> UART, also known as USART, where 'A' stands for Asynchronous.
>=20
> Move the SSP bindings to where it belongs.

It's a serial device which is also used for other applications (the
other one upstream being audio) so I can see where the current binding
comes from and it's not super obvious that spi is especially better
here.

--yglz+J6siImMAjPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZHktQACgkQJNaLcl1U
h9Dkegf+PfmAzJMnJ7JxbPX21j0FUyCOCV8ZS8xqbV52T3VQ0lfj0ocnx7b4gTFc
G/brmViTfVU6isTz1SEMEkYm04dRfcCkzCQNi22abMDops27xiKvIhOhw6WlrzUN
vljrkpudj8MI+Gb76u/dY/MXjnjASj5o3qFSIAZZoZO7B8ws6ofjLeAdynAY/Re9
z0dokasDuiujuIeO4QY70ZNj4jezgFN/8Wnp+DUpa07XyQvTV6lvplKIRBVUbOPt
gREMbGy996hEf55KgEwsr3Nft6HahmHVd1T4CVI6gnTHYE1OzoXzTbFmUyHeXb08
ffJckIM6CffQdDRBbmCEeYSH/HPaaA==
=Argb
-----END PGP SIGNATURE-----

--yglz+J6siImMAjPA--

