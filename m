Return-Path: <linux-spi+bounces-7228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89364A68F37
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8A816147A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D3919DF99;
	Wed, 19 Mar 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLbt49Ol"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F25374EA;
	Wed, 19 Mar 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394814; cv=none; b=tCPtRoZP4C5x6u1UmLfSoTZQE1dcpGsir811ysHn+JRUqpWfPVlL2vUDsxOvFwzgm2tCqRnGsXpPAZkP6lyGDy8oU83I9GeZcjvwgyScw6sB4URf6MMr3nK9jWIG5xW0ZV/y7c8ihlHH9gPro6bJpdcnOxG4j3amrbM7l7oHxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394814; c=relaxed/simple;
	bh=fhDmQctvr+W+q+QODYaPwKjF/eWPKKc2nXSEetXTyVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGSDQI3yJ1PDNvD4c9KXD1uOnTWLSA9IMac8Y1V16rwe9hYu7We4LAR7ujoiJzAAmWNa4/exKDQ/5eXvZazV3Spo7HnCU3Ak4LitsSlGkpiaXNgR0pqZz+yYfdio6L+UI60WGYot9Fek0wm+LifmmqQ4cqzAsF7+/EkWYbcVp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLbt49Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C850BC4CEE4;
	Wed, 19 Mar 2025 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742394813;
	bh=fhDmQctvr+W+q+QODYaPwKjF/eWPKKc2nXSEetXTyVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLbt49OlCn+ojKPiKgJVu/vC2wnaVQmpM36bUIu2gb97MkIY3C0yWFd3rKxgNsiHq
	 DdGjjN0FlN5J6jTq2Xmuhhmy9hMmXYz+N+ARMZHossK77y/fUYP0fPBNKfabQ4xZRk
	 BYvo9C/x2GQPTir+IysjEOOrJtauYE+9Np+58YLsZUqxVG/hEblRneDRYhwDgXaNu3
	 25SYEk2MryM7y6sJmf6pSbOXGPgIHAYk+nvMhe22rIsM+dR7sxxx0kpzwp9mLWu44w
	 yEmGrCQOxRdnfFZ6cxOmKYcmGf8O1lhAlsy8+Rx1WSNfR2AgDIE4uRmL7kKCs1c3hJ
	 DisFP3zY34+3g==
Date: Wed, 19 Mar 2025 14:33:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Rengarajan.S@microchip.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy
 implementation for x64 and bcm2711 processors
Message-ID: <9f386a6d-5921-4bcf-a020-c20f9752d2d2@sirena.org.uk>
References: <20250224125153.13728-1-rengarajan.s@microchip.com>
 <188ffb7d-47e2-45fd-80b1-b31ca58f0c0b@sirena.org.uk>
 <a322bf90b6b02f6dd96023e34d32eb78b1c23ca9.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Eznv66N6sKUvCOv"
Content-Disposition: inline
In-Reply-To: <a322bf90b6b02f6dd96023e34d32eb78b1c23ca9.camel@microchip.com>
X-Cookie: Chairman of the Bored.


--2Eznv66N6sKUvCOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 01:58:38PM +0000, Rengarajan.S@microchip.com wrote:
> Hi Mark,
>=20
> Thanks for reviewing the patch and apologies for delayed response.
>=20
> On Mon, 2025-02-24 at 14:30 +0000, Mark Brown wrote:
> > [Some people who received this message don't often get email from
> > broonie@kernel.org. Learn why this is important at=20
> > https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe

You have not quoted any context from the message you're replying to so I
don't really know what you're talking about.

> I went through several patches related to similar issues, and mostsuggest=
 handling it on a SoC basis. The reasoning is that a system
> may have an affected PCIe root complex while still having other
> devices in the SoC that can, or even require, 64-bit accesses.

> The following are some of the patches that I had looked into:
> https://lore.kernel.org/lkml/20210226140305.26356-2-nsaenzjulienne@suse.d=
e/T/#u

That's a adding a generic 64bit-mmio-broken property - that's an example
of something that's not quirking off the SoC compatible.  Doesn't seem
to have reached mainline though.

> https://lore.kernel.org/linux-arm-kernel/c188698ca0de3ed6c56a0cf7880e1578=
aa753077.camel@suse.de/T/#u

> Can you please suggest any alternate methods that we could use to
> handle this in a more generic manner instead of making it Soc-specific.

That thread seems to be going down a similar direction - adding a
generic quirk that the accesses are broken.  Both these threads seem to
be suggesting something like what I was thinking of, you've got a
generic DT property or some other indication that the device can't use
64 bit accesses on this platform.

--2Eznv66N6sKUvCOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfa1bgACgkQJNaLcl1U
h9CPGwf/X3wdZ5a7nfDj2bVSwbseWdKKlMlHKaGOgn6Tng/CBEU0FzvrceyX7q1h
UUFdBa8hlKw4GISC1F9HQ5l/KpmZ22k9aG9+WVm08UH6c025syVMJmEarfstiWWx
VSHQlbRg3gpIp9fEeQ8iUthD+56ew6HRNoSqtAPemVPZWyslelICi2qOzl6XaS11
t7Y5lt1lMixEV1HU9s63qC24ZOz2Cw3zcX5pHCcVU4saQFfWHg76s+26GYWsLRp/
G+P4OLRaCfl2dkKrJVwycXaCUMGa15/t+ACCEZi6//mICv7EWADr8IF1rs/j6yFs
dPHgxgLNfwVCBo+Cm+UFnB1Uu+F3tw==
=5X/s
-----END PGP SIGNATURE-----

--2Eznv66N6sKUvCOv--

