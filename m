Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996928ECD2
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 07:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgJOFnu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgJOFnu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Oct 2020 01:43:50 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Oct 2020 22:43:50 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0ECC061755
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2020 22:43:50 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id ED8363000C9B0;
        Thu, 15 Oct 2020 07:38:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D141C1C023C; Thu, 15 Oct 2020 07:38:29 +0200 (CEST)
Date:   Thu, 15 Oct 2020 07:38:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201015053829.GA2461@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
 <20201014194035.ukduovokggu37uba@skbuf>
 <20201014202505.GF4580@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014202505.GF4580@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[cc += Sascha]

On Wed, Oct 14, 2020 at 09:25:05PM +0100, Mark Brown wrote:
> > On Wed, Oct 14, 2020 at 04:09:12PM +0200, Lukas Wunner wrote:
> > > Apparently the problem is that spi_unregister_controller() drops the
> > > last ref on the controller, causing it to be freed, and afterwards we
> > > access the controller's private data, which is part of the same
> > > allocation as struct spi_controller:
> 
> Right, the proposed patch is yet another way to fix the issue - it all
> comes back to the fact that you shouldn't be using the driver data after
> unregistering if it was allocated as part of allocating the controller.
> This framework feature is unfortunately quite error prone.

How about holding a ref on the controller as long as the SPI driver
is bound to the controller's parent device?  See below for a patch,
compile-tested only for lack of an SPI-equipped machine.

Makes sense or dumb idea?

If this approach is deemed to be a case of "midlayer fallacy",
we could alternatively do this in a library function which drivers
opt-in to.  Or, given that the majority of drivers seems to be affected,
make it the default and allow drivers to opt-out.

-- >8 --

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239..5afa275 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2399,6 +2399,11 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
 extern struct class spi_slave_class;	/* dummy */
 #endif
 
+static void __spi_controller_put(void *ctlr)
+{
+	spi_controller_put(ctlr);
+}
+
 /**
  * __spi_alloc_controller - allocate an SPI master or slave controller
  * @dev: the controller, possibly using the platform_bus
@@ -2414,6 +2419,7 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
  * This call is used only by SPI controller drivers, which are the
  * only ones directly touching chip registers.  It's how they allocate
  * an spi_controller structure, prior to calling spi_register_controller().
+ * The structure is accessible as long as the SPI driver is bound to @dev.
  *
  * This must be called from context that can sleep.
  *
@@ -2429,6 +2435,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 {
 	struct spi_controller	*ctlr;
 	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
+	int ret;
 
 	if (!dev)
 		return NULL;
@@ -2449,6 +2456,13 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	pm_suspend_ignore_children(&ctlr->dev, true);
 	spi_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
 
+	spi_controller_get(ctlr);
+	ret = devm_add_action(dev, __spi_controller_put, ctlr);
+	if (ret) {
+		kfree(ctlr);
+		return NULL;
+	}
+
 	return ctlr;
 }
 EXPORT_SYMBOL_GPL(__spi_alloc_controller);
