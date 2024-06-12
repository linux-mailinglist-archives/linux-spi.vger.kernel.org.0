Return-Path: <linux-spi+bounces-3382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A81905085
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180F21C20E7A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F416E86E;
	Wed, 12 Jun 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKoXmOv2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DC36B17;
	Wed, 12 Jun 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188679; cv=none; b=liHU3vCR/+Knj9AunC9YBVu5jc88Bj5T6D1xkR5cjkTyBANf+NS2ziXq0SdFPse/bOkP02jsSA9IYM66zoo84ScsnPi7MSvjjDaYzDMuqsGjWQU/Xy+KojFis4l+PxxRv7DJSVbJEvjH59XgxCxmcvhhxxn8TTpSuwCROz2DoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188679; c=relaxed/simple;
	bh=Dgr9OLLY+PSC/5YLhctw2RDGe2fb8/W3urbkH1caWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqVKCKc/AXFFLp8cDEJWsOeK2KU8K/DlCiiCQJ41KcvZhKR4Tii62Yo2F3OyfwWxYq9mW7vzPFXaxuArvHKhOd2An/GVPadfwQU7dlsyPF+0A6VkJVX6ZKb7Qfq+W+lz02vuaye8HChmw7EHVmRt4eHG7dxm30c1w1CdaBme6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKoXmOv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40713C3277B;
	Wed, 12 Jun 2024 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718188678;
	bh=Dgr9OLLY+PSC/5YLhctw2RDGe2fb8/W3urbkH1caWQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKoXmOv2yaDVO6tW5t5sUYdD6+tBgOHZ1yy56yytT8uxS/A2ezRdxEDm7+LZkmODp
	 txQ39MhakyHAM+pB1ShyZdkPkK1QtTeVWN3qEgrqNfL4HAS46MD97mDmS+F+3PftDe
	 +Iy4rlP4Yv/6W5JYnMDEN8dld5QkQacItd7BFGQZdMKJ7X+GT55i2rfT0bFBmzkjgC
	 XbHTrzbH8aBhYvFjeOew1IGDln8uYFasl87o7IguC309Dfne6JSKfw70XdTCI1wvOH
	 k41fpMuu5OQCNdBjpygndxFG22SOvZR8ksB6+fc+7WzLg9cUHr0+WpCgk5p3Wvxpzp
	 9WLjMpsH7MiNw==
Date: Wed, 12 Jun 2024 11:37:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v8 4/4] spi: cadence: Add MRVL overlay
 xfer operation support
Message-ID: <Zml6hP4dFZCLKW6T@finisterre.sirena.org.uk>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-5-wsadowski@marvell.com>
 <ZmcnhGH2fcmrXn1G@finisterre.sirena.org.uk>
 <CO6PR18MB40985A453930C40DCB5C5845B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ZRgvf4m5HjFamLb"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB40985A453930C40DCB5C5845B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: Your love life will be... interesting.


--/ZRgvf4m5HjFamLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 10:02:33PM +0000, Witold Sadowski wrote:

> > > +		cdns_xspi->in_buffer = txd + 1;
> > > +		cdns_xspi->out_buffer = txd + 1;

> > Oh?

> You are asking about that 1 byte offset? It is caused by way that
> SDMA is handled in that specific case - all data except of first
> byte is transferred via SDMA, the first byte is send in command, and
> SDMA is not involved in that.

That needs a comment I think.

--/ZRgvf4m5HjFamLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpeoMACgkQJNaLcl1U
h9Cjuwf+OgYxhFF3XTDKO7HdVZN+wR6dsy4rlYmK3xQ1fDXw28tRy1ocShUUZmFp
RjI19gtoB4paLMSs9XXqXUavXGp/ORv52MgEnV8NrfSUFJXU9hyIdmVD1ZsDK1KJ
u0dOxcn6rgPeFSDl5KAEbqRdpvLbCpBWGX8ZM40CPoKHbNTFpsNXZvHiybcp1Amh
Qu7SrFp7a4NzVNAsup1364kiCOqTRa+wtpxWpv/frFaICrMTN/Fr6dK5mHfNp+Aa
jswuPR/NmEF/1O/V4Ci+D6SBv+8dXPQ+YIYi4ARHzflHkkOSVX1KMyc/PFgzn7uS
g0KQVeY5h6UTsDAYwI2fXQoAOjbOlQ==
=SSUM
-----END PGP SIGNATURE-----

--/ZRgvf4m5HjFamLb--

