Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A667032D350
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 13:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCDMgd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 07:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233218AbhCDMgN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 07:36:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95B564EF6;
        Thu,  4 Mar 2021 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614861333;
        bh=EkeZUZO/3whI1YQlQvZZ+yLF1lahGtpnZIGIom+hslc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TW17k1FzZlqya+rwuPIALsn+dOaBmxAEEXpa5x72LPd7/qiNda7IEEHvfiIHIJbBz
         MfK8jIBZMIU0924x/Uo8I75172YdXv3rlP0colBqF3uM8oho9huXEaUvNcDnkexUY3
         sgc6GSCsKB+6/iadBa4dv/apWr2PHkaZF03Ql6cRSk5Q3ScOSVdhqQgX1hoUWKvBrS
         vq+dNucew/F7AFl9W6UPGVREJFPsPQNdqyhspk6VvSW9JN2la9QRpKpSgpw274ZeMh
         5SY0xGDur/CfNGl/WiiNzXkr/9LKkln7W9NugVHouTufY1I5ZetFOLzfVD7ayTvzml
         Ia9cBFWPLub9g==
Date:   Thu, 4 Mar 2021 12:34:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Fangjian (Jay)" <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, huangdaode@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210304123425.GA4731@sirena.org.uk>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
 <79a0bb79-654b-8afc-f34a-c3a08bae275c@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <79a0bb79-654b-8afc-f34a-c3a08bae275c@huawei.com>
X-Cookie: I think my career is ruined!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 04, 2021 at 10:54:40AM +0800, Fangjian (Jay) wrote:
> On 2021/3/1 21:54, Mark Brown wrote:
> > On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:

> > > +/* Disable IRQ bits */
> > > +static void hisi_spi_mask_intr(struct hisi_spi *hs, u32 mask)
> > > +{
> > > +	u32 new_mask;
> > > +
> > > +	new_mask = readl(hs->regs + HISI_SPI_IMR) | mask;
> > > +	writel(new_mask, hs->regs + HISI_SPI_IMR);
> > > +}

> > This is a read/modify/write cycle and appears to be called from at least
> > process and interrupt context but I'm not seeing anything that stops two
> > different callers of it or the matching unmask function from running at
> > the same time.

> Those mask/unmask will not be called at the same time from process and
> interrupt context. In process context, unmask will be called after SPI
> controller be Disable and Flush (interrupt handing has ended).

Given that this is disabling the interrupt that doesn't sound like it's
going to be entirely robust - if we need to disable the interrupt
presumably there's some chance it might fire.

> > > +	struct hisi_spi *hs = spi_controller_get_devdata(master);
> > > +
> > > +	hs->n_bytes = hisi_spi_n_bytes(transfer);
> > > +	hs->tx = (void *)transfer->tx_buf;
> > If there's a need to cast to void * something is very wrong here.

> Yes, fix compile warning.

This cast just masks whatever the problem is, if the compiler is
complaining about using a void pointer it's spotted an issue.

> > > +	/* Ensure the data above is visible for all CPUs */
> > > +	smp_mb();

> > This memory barrier seems worrying...  are you *sure* this is the best
> > way to sync, and that the sync is best done here if it is needed rather
> > than after everything else is set up?

> The commit 0b6bfad ("spi: spi-dw: Remove extraneous locking") explains
> why memory barrier is needed here. And put it here to make it easier to
> understand.

The reader of this code won't have any kind of pointer to that commit,
this needs to be clearer.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBA09EACgkQJNaLcl1U
h9BjtAf6A6uZA32MFUJjJ1X9No5n7z58lnrZ3ROGdda+JhWLlYKtrbbPnUVADo0q
g/omw34V4+gqOi0O2Iy7BY8IiRXDWgGgIQE42b4QiZ7NZIbbk5wNKCGtTMBwedGC
NmU+sxTkznqt8vxjXW2O2KfCzuGvX4ogyStRbXvMcguETokcJgBDt7t1zm/IkVZy
WM8Y5dksofqXYQPWpyy6eHSoLEvBYEV/PxgIMoOaSxT5/3DPQS6wrkWSULkk2kMv
2NdA1L5kUIJam0z72WTa/BEC1oAvK3r4OMkRlsBVEVMUYPIkzuwVtCvXnqf6k62B
BbWAYZVnf/UI7eaUN6759R+/RfLOMg==
=BGMO
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
