Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8891E0D7A
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390145AbgEYLlg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 07:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbgEYLlf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 07:41:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B81B20723;
        Mon, 25 May 2020 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590406894;
        bh=Hp5SiSFZMaHLwFF7pNYpwJfqMDexLWEuy8QzRMos6CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QR/t+rfcpu+xpGud6KiaYPoqcRDfD0mP8LpY3rE2FAa7K6C0ccQj/KXn71xC81MM8
         dg9FHuQKOEuoLn2jD3+VZvMpNnliDD+eMMCCzOfWxgVonT1DwYmWbMO8MQiIMAxWFw
         x+9D1+0ajdS/O4YG8X28gbj0eALubKj7VxqurXDE=
Date:   Mon, 25 May 2020 12:41:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200525114132.GC4544@sirena.org.uk>
References: <20200522121820.GG5801@sirena.org.uk>
 <20200522123427.GD1634618@smile.fi.intel.com>
 <20200522124406.co7gmteojfsooerc@mobilestation>
 <20200522131013.GH5801@sirena.org.uk>
 <20200522132742.taf2ixfjpyd5u3dt@mobilestation>
 <20200522140025.bmd6bhpjjk5msvsm@mobilestation>
 <20200522143639.GG1634618@smile.fi.intel.com>
 <20200522144542.brhibh453wid2d6v@mobilestation>
 <20200522152241.GK5801@sirena.org.uk>
 <20200523083410.3qarkfkwsmodvxwk@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20200523083410.3qarkfkwsmodvxwk@mobilestation>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 23, 2020 at 11:34:10AM +0300, Serge Semin wrote:
> On Fri, May 22, 2020 at 04:22:41PM +0100, Mark Brown wrote:

> > Right, that definitely needs to be fixed then - 8MHz is indeed a totally
> > normal clock rate for SPI so people will hit it.  I guess if there's a
> > noticable performance hit to defer to thread then we could implement
> > both and look at how long the delay is going to be to decide which to
> > use, that's annoyingly complicated though so if the overhead is small
> > enough we could just not bother.

> As I suggested before we can implement a solution without performance drop.
> Just wait for the DMA completion locally in the dw_spi_dma_transfer() method and
> return 0 instead of 1 from the transfer_one() callback. In that function we'll
> wait while DMA finishes its business, after that we can check the Tx/Rx FIFO
> emptiness and wait for the data to be completely transferred with delays or
> sleeps or whatever.

No extra context switches there at least, that's the main issue.

> NOTE Currently the DW APB SSI driver doesn't set xfer->effective_speed_hz, though as
> far as I can see that field exists there to be initialized by the SPI controller
> driver, right? If so, strange it isn't done in any SPI drivers...

Yes.  Not that many people are concerned about the exact timing it turns
out, the work that was being used for never fully made it upstream.

> What do think about this?

Sure.

> patchset "spi: dw: Add generic DW DMA controller support" (it's being under
> review in this email thread) ? Anyway, if the fixup is getting to be that
> complicated, will it have to be backported to another stable kernels?

No, if it's too invasive it shouldn't be (though the stable people might
decide they want it anyway these days :/ ).

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7LrusACgkQJNaLcl1U
h9BHkwf/TTTAJk2mHPdO5NZrQT9dQh5jsvRQzSpRd0zmXjPtwJ4/eFABGGqh4ROh
PuBqrhJIHo4857AEsNADaQ7jct/N7UUXVSd/GcksNFlY1SqW09orfSC2g4quX5D6
uVWDk2ezt0ee4jSYGQA+xOEftZnSHgkQcX+DH3lpCDyHSVir15pGwsR8WwsUsm5k
ufa+Q7VF205bhagfk/BP+0GH8eB9C7E1F6jFfxyoYhIJPTsssbaDi+V75L83HW4F
FmGcX8cOPnpVu2teCxZiklIY2IeoWrka1lCv6MwrSP/h7efD25ruOV4mTdy4QfYl
srza2PJPnAviEJAwMyJgE5zpVaMC/Q==
=PX1y
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
