Return-Path: <linux-spi+bounces-3663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01DA91BFF6
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A681F231B7
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4615D5A1;
	Fri, 28 Jun 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtfOJMUq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473B1E89A;
	Fri, 28 Jun 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582761; cv=none; b=HVP5UgCF8LeJYHIjibEYiByYp2UNqnwPbjvt9cralxYM3NiVan/Ac69xK+R1waqcQssA+trd7AEhmiwpYrP4g28vzJcBvq9FwhNSBSSIz9+O9t1gL76PeENnEiFST6FjpQGus1CSukvja3mBMiFLU5e9kJ2olnFgyPJky4MGnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582761; c=relaxed/simple;
	bh=QrLD6NwYv62ULzfSXLfedCtj42u+DCBUSMv9l6b6uUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8LB24qd2BS5kPuq6TTBviiE8jtB1ibq9iWY+QzKUGlFo6ZNdNyMAY0csI+J6B8Kci7jAW8HdJYtJXm476koYPSPiNcpcaMC0YQ4Ww/Bj8u+ANAYD2AVZOja4JqVsMvNoy+LNipoje4xw/oUC/Ie7hurOAasntY7m1w1wrlycgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtfOJMUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70813C116B1;
	Fri, 28 Jun 2024 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719582761;
	bh=QrLD6NwYv62ULzfSXLfedCtj42u+DCBUSMv9l6b6uUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtfOJMUq8TQHjHnw4nZkDZKeevRdRyc7lZG/YwrPWvw07lRf0zvt6+44Wt3KPbXNA
	 n43QPP7mlojZHl4wrk1mopAs7SWSEiUW/h0XKafYtTZreVjza0S+vajiN8f7Xx/Ch4
	 ZsxoUQdik6o9bz83SE4uVZ/+HoOK50El9Yd8vkFtQQtam3UYOjrgC4fXP/Y9F3d92U
	 TzeBgMpxjxlAS1OoELcBVzpzULPhXEyVwYcPX2rKXE0wD8qAdCjoNYdXyIRgBDMpN/
	 RLRMBpN7pY13qPuV4dpLrsu27Fy/0tY28GnNGb4FyyGrhh1owFEMYltgl92pe/2PHv
	 EqaYPgNJ2LIKA==
Date: Fri, 28 Jun 2024 14:52:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v9 4/9] spi: cadence: Add Marvell SDMA
 operations
Message-ID: <f3fd9ac0-3bcb-4281-94fa-cadfdc2b26af@sirena.org.uk>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
 <20240619141716.1785467-5-wsadowski@marvell.com>
 <67123003-9987-492f-b9ab-718e5dab0acc@sirena.org.uk>
 <CO6PR18MB40981FD7DB1DA13E851F9EEBB0D02@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+/hGhQrEAiEQUTFJ"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB40981FD7DB1DA13E851F9EEBB0D02@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: divorce, n:


--+/hGhQrEAiEQUTFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 01:45:13PM +0000, Witold Sadowski wrote:
> Hi Mark

> > > +	while (len) {
> > > +		tmp_buf = readq(addr);
> > > +		memcpy(buf, &tmp_buf, len > 8 ? 8 : len);
> > > +		len = len > 8 ? len - 8 : 0;
> > > +		buf += 8;
> > > +	}
> > > +}

> > Wouldn't it be more efficient and readable to only do the memcpy() for the
> > trailing bytes and just do this memcpy() for the final word?

> The whole problem is with SDMA end - addr in that case. If code will try to
> Read it in non 64b mode, all remaining bits, will be lost.
> For example - doing 1B read on that register, will return 1B, but SDMA will
> transfer 8B, dropping remaining 7B.
> I have tried memcpy approach, and it was not stable.

That's not what I'm suggesting, like I said above I'm suggesting to
*only* do the memcpy() for the trailing word.

--+/hGhQrEAiEQUTFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+wCMACgkQJNaLcl1U
h9DjuQf+IZSApslS3GD8CqaP8KF4OVAEFw2m2uoMAV2JZqzX5f9OUnE3QwWfQeZU
qMWPAhOE/gtBGNTB7LzQY5YANWjvUW3LqR4f2Fg9biwd/bHYmwx7bQuLFiUR3r5z
HNppZkmIMAmFaCRwGez4wYqP2V6E5VY13ylgflrVZCAwn6J7WW5jhPohsVg0N8/X
SC3QFc2xZiKkJNeAO1npEOwlCM5UGMGR0s3vrEthVQFbkluLL50n/MYCPIoar2Sz
2i71+q4jEU80QvoUZjhB7qtjcKAsfgTsLp3xI4oJOeU1vyzHCppBfqBnfk7fgbNW
zo+AmINxWzEgVxrj7E8DeZFie1jTvQ==
=OP4J
-----END PGP SIGNATURE-----

--+/hGhQrEAiEQUTFJ--

