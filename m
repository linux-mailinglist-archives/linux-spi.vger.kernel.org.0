Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D803942F5
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhE1MyX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 08:54:23 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:39953 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhE1MyX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 08:54:23 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C88CC2800B3C2;
        Fri, 28 May 2021 14:52:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BA67986D7E; Fri, 28 May 2021 14:52:45 +0200 (CEST)
Date:   Fri, 28 May 2021 14:52:45 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-spi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH for-5.13] spi: Cleanup on failure of initial setup
Message-ID: <20210528125245.GC17551@wunner.de>
References: <f76a0599469f265b69c371538794101fa37b5536.1622149321.git.lukas@wunner.de>
 <YLC4XWxfmjgizyvz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLC4XWxfmjgizyvz@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 28, 2021 at 12:31:09PM +0300, Andy Shevchenko wrote:
> On Thu, May 27, 2021 at 11:10:56PM +0200, Lukas Wunner wrote:
> > Commit c7299fea6769 ("spi: Fix spi device unregister flow") changed the
> > SPI core's behavior if the ->setup() hook returns an error upon adding
> > an spi_device:  Before, the ->cleanup() hook was invoked to free any
> > allocations that were made by ->setup().  With the commit, that's no
> > longer the case, so the ->setup() hook is expected to free the
> > allocations itself.
> > 
> > I've identified 5 drivers which depend on the old behavior and am fixing
> > them up hereinafter: spi-bitbang.c spi-fsl-spi.c spi-omap-uwire.c
> > spi-omap2-mcspi.c spi-pxa2xx.c
> > 
> > Importantly, ->setup() is not only invoked on spi_device *addition*:
> > It may subsequently be called to *change* SPI parameters.  If changing
> > these SPI parameters fails, freeing memory allocations would be wrong.
> > That should only be done if the spi_device is finally destroyed.
> > I am therefore using a bool "initial_setup" in 4 of the affected drivers
> > to differentiate between the invocation on *adding* the spi_device and
> > any subsequent invocations: spi-bitbang.c spi-fsl-spi.c spi-omap-uwire.c
> > spi-omap2-mcspi.c
> > 
> > In spi-pxa2xx.c, it seems the ->setup() hook can only fail on spi_device
> > addition, not any subsequent calls.  It therefore doesn't need the bool.
> > 
> > It's worth noting that 5 other drivers already perform a cleanup if the
> > ->setup() hook fails.  Before c7299fea6769, they caused a double-free
> > if ->setup() failed on spi_device addition.  Since the commit, they're
> > fine.  These drivers are: spi-mpc512x-psc.c spi-pl022.c spi-s3c64xx.c
> > spi-st-ssc4.c spi-tegra114.c
> > 
> > (spi-pxa2xx.c also already performs a cleanup, but only in one of
> > several error paths.)
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # pxa2xx
> 
> I'm not sure how this can be applied now without reconsidering what is in
> for-5.14.

I originally developed this patch against for-5.14, then realized that
c7299fea6769 went into v5.13-rc3, so I backported it to for-5.13.
I was able to cherry-pick the patch cleanly from 5.14 to 5.13,
so it seems there won't be any merge conflicts.  And I did go through
spi-pxa2xx.c's ->setup() hook once more when backporting and
double-checked all the error paths.

That said, it would definitely help if you or someone else at Intel
could test the patch, if only to raise the confidence.

Thanks!

Lukas
