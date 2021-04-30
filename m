Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4436FE2A
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhD3P5p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 11:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhD3P5o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Apr 2021 11:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9813D61107;
        Fri, 30 Apr 2021 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619798216;
        bh=Nfc0HJne/30VyMJlu8UUpYSryGNC1CXdu+AlSzucchs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaGQZ0Ro2H0wftqmIEXleFYY8xSr+hKdEkdmhsD7o5/6XuyRCWHMev7yqsI0tvkpP
         zOuk+6ytcNNBqFm6bwbGr2yl3/J5+BmzLhNpJn0sACPor6pHKb+th5XftBM0E79JxM
         prAIvFme4r1VAlhjwyQnBrC32hQHchixUv2ud5OCDYyYD3fUUxr7BnAYJg7Ad9frvH
         1Y1qn/Xh2G7+fllViqaeDTL5iuh4NsOqgVU2yJSqXCynTnaYiImVjgviqX39Hwde/G
         sftiD/trHVBKKVmjODEjnFWfDJDvfiSZF2itubKZ+8W0xTHs5hq9CiECOtG6z83lHx
         OxhYM0MrJh02A==
Date:   Fri, 30 Apr 2021 16:56:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH 1/3] spi: spi-mem: add automatic poll status functions
Message-ID: <20210430155623.GD5981@sirena.org.uk>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
 <20210426143934.25275-2-patrice.chotard@foss.st.com>
 <20210426162610.erpt5ubeddx7paeq@ti.com>
 <20210426165118.GH4590@sirena.org.uk>
 <28acedfd-6cd5-a8ad-0182-e61c3c30c27d@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <28acedfd-6cd5-a8ad-0182-e61c3c30c27d@foss.st.com>
X-Cookie: QOTD:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 04:22:34PM +0200, Patrice CHOTARD wrote:
> On 4/26/21 6:51 PM, Mark Brown wrote:
> > On Mon, Apr 26, 2021 at 09:56:12PM +0530, Pratyush Yadav wrote:

> > Is it possible there's some situation where you're waiting for some bits
> > to clear as well?

> Yes, we are waiting STATUS_BUSY bit to be cleared, see patch 2 which is m=
aking=20
> usage of this API.

Then the inverse question applies - is there no circumstance where we
might be waiting for a bit to be set?

> > We already have the core handling other timeouts.  We don't pass around
> > completions but rather have an API function that the driver has to call
> > when the operation completes, a similar pattern might work here.  Part

> So, if i correctly understood, you make allusion to what is already done
> in SPI core framework with spi_finalize_current_transfer() right ?

Yes, and _current_message().

> > of the thing with those APIs which I'm missing here is that this will
> > just return -EOPNOTSUPP if the driver can't do the delay in hardware, I
> > think it would be cleaner if this API were similar and the core dealt
> > with doing the delay/poll on the CPU.  That way the users don't need to
> > repeat the handling for the offload/non-offload cases.

> Sorry, i didn't catch what you mean here. In PATCH 2, that's the case,
> if spi_mem_poll_status() is not supported, the core is dealing with=20
> the delay/poll on the CPU in spinand_wait().

That's in the NAND core, not in spi-mem.  Any other users of spi-mem
will also need to open code stuff.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCMKKcACgkQJNaLcl1U
h9BnTgf9GjZoUqirpCoBPIQR86s2iqmzPr65s1+q3eChglLC4wjowsyrHWAGwVtq
nBgwxYF73lOPoum2okii05Jr8l5eSY/DVeUQApdLAVpZ68p2zdqx30NY5oxm1SeX
znj8hwmDKd6gabz9J5vBZ1mJr6OnIU/0noPe33s7sq3TdMa+0efV9v/uIG5Z+y/N
OW6ot8IyF8bhrg1E7I9YijsqeFcHuLlswP3w/vs8x8IbkIhfoVZi2EVmmdDKa7ni
e5rqCNafXMHwSRKe2qxaE/wv5NWYcxCVdcObqvvrfDinOvhbSw0kUQt4XjrEfcOP
o1Du7yptlLeUxurvc9FvZfTlWfffpQ==
=I/xG
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
