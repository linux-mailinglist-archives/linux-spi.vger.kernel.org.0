Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3125EFC97
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2019 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfKELmd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Nov 2019 06:42:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbfKELmd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Nov 2019 06:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1VvOv5GWuCii/3i1LPuPX+IHlPj4QKMT48lK4e/IvbA=; b=CsyG9LqWuyOGheijEzh5KOYzq
        h2E+lYVLyOM1RpoSP0ShYu+aHVKj2frXlIG0NntIohBtKlroxadRFHQsdJ1IGOIhwyvRm0M9nvnnW
        tWDr+PwxzM7TUFxu5LbBvs1yi1fqG9gkL1EXWUbemjJSiO+l7kHuDFhiTQbClGnkcS8HE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRxEC-0006PG-BU; Tue, 05 Nov 2019 11:42:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6FD6C274301E; Tue,  5 Nov 2019 11:42:27 +0000 (GMT)
Date:   Tue, 5 Nov 2019 11:42:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi-mem and gpio chipselects
Message-ID: <20191105114227.GB4500@sirena.co.uk>
References: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
 <20191104124444.GB5238@sirena.co.uk>
 <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
X-Cookie: Genius is pain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2019 at 08:06:42PM +0000, Chris Packham wrote:
> On Mon, 2019-11-04 at 12:44 +0000, Mark Brown wrote:

> > That's only going to work in cases where the controller translates
> > things into a single SPI operation on the flash which I'm not sure is
> > always going to be the case.  We'd need a way to guarantee that the
> > controller is going to do that in order to avoid data corruption issues.

> In my particular case (spi-bcm-qspi.c) bcm_qspi_bspi_exec_mem_op() does
> seem to assert the native chip-select then do it's operation. As I
> understand the wait_for_completion_timeout() will schedule so other

The issue is what happens if the hardware translates the operations it's
being asked to do into multiple physical operations on the bus for some
reason.  It sounds like yours won't but we can't just unconditionally
push the chip select control out to software even if the normal SPI
modes support it.

> tasks may run but spi_mem_access_start() has taken an io_mutex so
> anything that accesses that spi bus will block.

That's guaranteed.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3BYCIACgkQJNaLcl1U
h9DUGAf6AgYGHHtC8fjKSGW1POmrYB0mCJNdi6rKRYZinsVOIroYP0LIhjZUqUNP
ZxMkM9qsd0D6LWIJSsBjInHzKMP1JnD/Wv8eKsfkmU/vXQ4zpGWtnJ7fKEgGUZOE
MMLj5vfAHtvwKMBdAHzAZn4/iRw8U0EgDnXA0KtlmACpxKUgPxJ4RAuxeDIDygc8
OSmebFYqYVOvJeCI+mokjyv6MNQqUuZW6u7WDAQp4vHp8JbHFULXuGOtLFNwXdv9
6JD7FcEXG1Q5QP3CkrrnPs7a3wTVCZllbNvZLQM7xI8+vVjwQFxqOyELnAmc/+uX
JdHNYU7Wd+KlbLB9SpXBPCpufwIi5Q==
=MtHO
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
