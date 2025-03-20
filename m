Return-Path: <linux-spi+bounces-7255-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F9A6AA02
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3C7AD4D9
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F41E5203;
	Thu, 20 Mar 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW9+qHOC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377061E1308;
	Thu, 20 Mar 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484888; cv=none; b=dMl4AvGVzE9rzcuOodNDxXpixwnnXpefxDzvcWmJMYPZkw+ApY7OrUTsVc7GLLCNVWlom8XfgLCcyumg0RwYa4B2jQAnNHz0rIL6X2zdQ/zteOvHDx1rgezq180vJWVU6momrmKQZx+XNqZa7vsokQBb6kSgnonYbTK/YEowH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484888; c=relaxed/simple;
	bh=nx/p163f07edExsA0woGT2IjsxDJ/er9AElP7747juY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzMAZQT/qmt2yuEwtsDbICttfSvpUVi40C8PNWOO8OhA55YcNhUh3XWBfD1hjZC75LylJoqyuOnFE4T6zX1hjjcAgTRcblqM+BAGm7ItstMIlghwzD8TCAiWjjVr0wvDom30y1oxCBGxU8mBfEIVJ5K6yNuzgVVJZblq0LZcK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW9+qHOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B6C4CEDD;
	Thu, 20 Mar 2025 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742484887;
	bh=nx/p163f07edExsA0woGT2IjsxDJ/er9AElP7747juY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HW9+qHOCluPX4EtMsW3ihtAbRSgp3magi32Q6cUGoG2dQCJ3Il7ozoYbbWXdnqWRv
	 AZh0pBlkBMUhhixNdvaBGN1e0rPX5tR0mIA+D8cvY7stk0nhsj34ZCxTaJsdHRywDq
	 ta6b8AzSc5jbPtrGW4fv0sQtIHUlci488GnCUp7ZIEVjIoEl9mJJgctR6MBw+F93Nt
	 TTyTHoeRGT6M99K1TS7kt8Z1iiep8cJebX/JTEZQGIzEuWpl6APxr47pBZ0vKo/QIv
	 S62ucb+s+2SHHRugrEjP8XBcJbASBKUI8u+RIn8VHvDkmYdeFYb5YJ83JrUrWDKSpp
	 JuKhk8da9y2+w==
Date: Thu, 20 Mar 2025 15:34:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <9ac953ec-fba3-41a7-8e5d-b867abc1566f@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <20250320153536.44774a74@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y/v6Mq2ESqSItSVy"
Content-Disposition: inline
In-Reply-To: <20250320153536.44774a74@mordecai.tesarici.cz>
X-Cookie: Do not fold, spindle or mutilate.


--y/v6Mq2ESqSItSVy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:35:36PM +0100, Petr Tesarik wrote:

> CC'ing Robin Murphy, because there seem to be some doubts about DMA API
> efficiency.

Or possibly just documentation, the number of memory types we have to
deal with and disjoint interfaces makes all this stuff pretty miserable.

> > > The whole goal there is to try to avoid triggering another copy to do
> > > the DMA so just reverting rather than replacing with some other
> > > construct that achieves the same goal doesn't seem great.  I think
> > > possibly we should just not do the copy at all any more and trust the
> > > core to DTRT with any buffers that are passed in, I think we've got
> > > enough stuff in the core though I can't remember if it'll copy with
> > > things allocated on the stack well.  I'd need to page the status back
> > > in. =20

> No, I'm afraid kernel stack addresses (and many other types of
> addresses) cannot be used for DMA:

> https://docs.kernel.org/core-api/dma-api-howto.html#what-memory-is-dma-ab=
le

Right, that's what I thought.  Part of what spi_write_then_read() is
doing is taking the edge off that particular sharp edge for users, on
the off chance that the controller wants to DMA.

> > From what I found, there are two scenarios that may depend on
> > GFP_DMA today:

> >  a) a performance optimization where allocating from GFP_DMA avoids
> >     the swiotlb bounce buffering. This would be the normal case on
> >     any 64-bit machine with more than 4GB of RAM and an SPI
> >     controller with a 32-bit DMA mask.

> I must be missing something. How is a memcpy() in spi_write_then_read()
> faster than a memcpy() by swiotlb?

spi_write_then_read() is just a convenience API, a good proportion of
users will be using spi_sync() directly.

> I still believe the SPI subsystem should not try to be clever. The
> DMA API already avoids unnecessary copying as much as possible.

It's not particularly trying to be clever here?

--y/v6Mq2ESqSItSVy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcNZIACgkQJNaLcl1U
h9CDcQf+Ogp1qPlq56dC5SrDmEtd5EquAcn2KcBxMhu34rYV0L5L+M//nG24b9v/
Ulr0UQ91QqP8j22Ka8/bJlQz70fUZ2avFpxFHRw4pAxvI5b5+tCogMbzMVSqYjwM
TI6l6KtONNSIuZBOCJ5D4IHMi4gP7xNcranxcjcHCE4Ln/oAwL1L3HPc5aI1UpM3
2bciY5FNiSsIN3QXoAIq7/+aF9CvDULge1EQEzx+z++j4RICsQl9hYotTxPLouON
ReYbRvGrNIYcShaFiv2968ALb1jIMw/0OUyg5uGpWJTagBdwbwGuvY8zha3j5spE
F/4EPaEbevLsMnpj/7vt3cIVYdWh/g==
=ozYo
-----END PGP SIGNATURE-----

--y/v6Mq2ESqSItSVy--

