Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7470220DBF
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgGONKo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 09:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730868AbgGONKn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 09:10:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE0420657;
        Wed, 15 Jul 2020 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594818643;
        bh=pY2aTpiDZTdC6aeil7mlvqDRiK5xcbKTqBLafGtkabk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXC8jjMMtnAd9ik+gnB9/r9quQXE3QeBEZcJ1nxHvMccL0X4h0jsV3MocfmE4FpxF
         y+7qXsyurvVnIn3T/s1ewHbCiJopITtuIJEb17kRSoeOqz3JaeGZttxZNTEvhFZcqR
         tN5zvFQaUnqRIRP37BwpMrxsM4PEro9ATXlkCx/8=
Date:   Wed, 15 Jul 2020 14:10:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200715131033.GF5431@sirena.org.uk>
References: <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
 <20200714192907.GJ4900@sirena.org.uk>
 <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
 <20200715113609.GD5431@sirena.org.uk>
 <824b8479-e204-d087-7887-a2dbefa0f844@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <824b8479-e204-d087-7887-a2dbefa0f844@kontron.de>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 01:45:51PM +0200, Frieder Schrempf wrote:
> On 15.07.20 13:36, Mark Brown wrote:

> > Hey, I proposed other solutions you didn't want to implement!

> Right, but you have to admit that the other solutions turned out to be
> rather out of scope for someone like me who merely wants to use the spidev
> driver.

> But I don't blame you. I'm now having a better idea of how things are (or
> aren't) supposed to look like. So thanks for your patience!

I'm not sure platforms like this are a great fit for DT TBH - the
trouble with DT is that it turns things into ABIs regardless of if it's
really a finished thing, platform data based systems were a lot more
flexible here.

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8PAEkACgkQJNaLcl1U
h9Ao7Af+ILdbHVUAjGqFK0kjVIvRBVQmrtMuVvJUElx26xVjUNSaA9pPaUpWVQMU
3kvIuwar56ByNPhPH+FJ7+NoE88dySjua0+mrLbufymXgD58aIzWPQoLPakoDg5y
TXB3bJ1bTbg6GOZQ3AVJ/hr8wbl13tqgX0/NGy2XCCrMvholDmiXGCGSwiFm09tj
dzvPrE6qWk5w1h8A9gD0fvtNb9WREq2ePDedQNmi0IByRYl1DVIbfa5+CHVurPDS
zgtw4XwVgOFNAS8EJoRXGcQmFi+qZWROQ3N9geLAIopwCz1/Tp6jk+EQ1nk7jnux
gInzPWYYlJ6/hnK+zfw3YHozO5DnYA==
=BSsn
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
