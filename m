Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52A228E215
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJNOSl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 10:18:41 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50933 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgJNOSk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 10:18:40 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 10:18:40 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BD1232800B483;
        Wed, 14 Oct 2020 16:09:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A41F418764F; Wed, 14 Oct 2020 16:09:12 +0200 (CEST)
Date:   Wed, 14 Oct 2020 16:09:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201014140912.GB24850@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 13, 2020 at 04:48:42PM -0700, Florian Fainelli wrote:
> With KASAN now working on ARM 32-bit, I was able to get the following
> trace upon reboot which invokes bcm2835_spi_shutdown() calling
> bcm2835_spi_remove(), the same can be triggered by doing a driver unbind:

Thank you for the report.  Apparently the problem is that
spi_unregister_controller() drops the last ref on the controller,
causing it to be freed, and afterwards we access the controller's
private data, which is part of the same allocation as
struct spi_controller:

bcm2835_spi_remove()
  spi_unregister_controller()
    device_unregister()
      put_device()
        spi_controller_release()  #  spi_master_class.dev_release()
	  kfree(ctlr)
  bcm2835_dma_release(ctlr, bs)
  ...

However, when I submitted commit 9dd277ff92d0, I double-checked that
the kfree() happens after bcm2835_spi_remove() has finished and I
even wrote in the commit message:

   "Note that
    the struct spi_controller as well as the driver-private data are not
    freed until after bcm2835_spi_remove() has finished, so accessing them
    is safe."

I'm puzzled now that it doesn't work as intended.  I do not see any
recent commits which changed the behavior, so I must have made a
mistake and missed something.

The below patch should fix the issue.  Could you verify that?
Unfortunately I do not have access to a RasPi currently.

An alternative to this patch would be a devm function which acquires
a ref on the spi controller on ->probe() and automatically releases it
after ->remove() has finished.  This could be used by other SPI drivers
as well.

Thanks,

Lukas

-- >8 --

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 41986ac..5254fda 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1377,6 +1377,7 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	bcm2835_debugfs_remove(bs);
 
+	spi_controller_get(ctlr);
 	spi_unregister_controller(ctlr);
 
 	bcm2835_dma_release(ctlr, bs);
@@ -1386,6 +1387,7 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
 	clk_disable_unprepare(bs->clk);
+	spi_controller_put(ctlr);
 
 	return 0;
 }

