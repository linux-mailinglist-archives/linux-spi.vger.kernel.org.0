Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91C1E8832
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgE2Twr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 15:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgE2Twq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 15:52:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924D4206F1;
        Fri, 29 May 2020 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590781966;
        bh=04z1TRbYww9g8DWS9mimfMTUFU9QOLcUlLldf657ARY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0MbN2o5P/YvRYUgOIVqe3DMQe451yNOi7rBV6roFy6nyi+mi9vzWJUGKm/bsBJBQ
         KOOZaehMUQVmIo1B6bCKd+O1r3JgGeJ1fT+LuIXq6QHtO0+qSN7jpAta7GyGiHTAw8
         ZSH493DLtCWZMIJ2SY2XwGi/v7AvmF5DcokWZWec=
Date:   Fri, 29 May 2020 20:52:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
Message-ID: <20200529195243.GV4610@sirena.org.uk>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
 <20200529184050.bkn72tash33zgoo4@mobilestation>
 <20200529184955.GY1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uzkapz4/HjIvV4VZ"
Content-Disposition: inline
In-Reply-To: <20200529184955.GY1634618@smile.fi.intel.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Uzkapz4/HjIvV4VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 09:49:55PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 09:40:50PM +0300, Serge Semin wrote:

> > > -	struct dw_dma_slave slave = {
> > > -		.src_id = 0,
> > > -		.dst_id = 0
> > > -	};

> > > +	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> > > +	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;

> > You know my attitude to these changes.) But anyway what's the point in having
> > the *tx and *rx pointers here? Without any harm to the readability you can use
> > the structures names directly, don't you?

> I will wait for Mark to decide.

Like I said before I don't particularly care either way, I've queued the
patch to apply but really I'd rather that the people working on the
driver could come to some sort of agreement here.

--Uzkapz4/HjIvV4VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RaAoACgkQJNaLcl1U
h9C21wf+LXI28hOvMLta0LtNgNlhNns7lPXx5cyVbt2tkGasnpCLft6/AfwB+Bvn
aGV2Y0FFVhAtU1W17ZUVl5BBhspkf+XFlPPPFRNtYVO1FeOavvAQjG2lr6L145ku
IJPgp4IYkCdsSO02cRQzZM5ffOR4RKJHBGbW+QgdqWGJAECNrx7HOQ3Yl3OBnHMs
vXMUR37vkwUYQ+4an9yV4X8eDVAQNOCOYeZvcm7LWtzlzcfMkI9bWYkG9SZQMSYK
EjuRW9tBolJUd5lLxUxInU6opuhimtai7YojgG5dfBVxM55mzoekHWHf9Ax6IbzE
AVm6zBRdq1IRjYPXYmh8fgrhbTzwLw==
=m651
-----END PGP SIGNATURE-----

--Uzkapz4/HjIvV4VZ--
