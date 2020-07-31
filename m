Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF22343BA
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgGaJxQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 05:53:16 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54779 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgGaJxQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 05:53:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 63D062800A279;
        Fri, 31 Jul 2020 11:53:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2CAA51812D; Fri, 31 Jul 2020 11:53:10 +0200 (CEST)
Date:   Fri, 31 Jul 2020 11:53:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] driver core: Use rwsem for kill_device()
 serialization
Message-ID: <20200731095310.xcyehzci33lfzvxx@wunner.de>
References: <cover.1594214103.git.lukas@wunner.de>
 <bf185285172a7b127424ac22fa42811eb2081cd4.1594214103.git.lukas@wunner.de>
 <20200730065326.GA3950394@kroah.com>
 <20200730095610.orkum2n6snb42uzs@wunner.de>
 <20200731064505.GH1508201@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731064505.GH1508201@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 08:45:05AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 30, 2020 at 11:56:10AM +0200, Lukas Wunner wrote:
> > On Thu, Jul 30, 2020 at 08:53:26AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jul 08, 2020 at 03:27:02PM +0200, Lukas Wunner wrote:
> > > > kill_device() is currently serialized with driver probing by way of the
> > > > device_lock().  We're about to serialize it with device_add() as well
> > > > to prevent addition of children below a device which is going away.
> > > 
> > > Why?  Who does this?  Shouldn't the bus that is trying to do this know
> > > this is happening?
> > 
> > AFAICS, at least spi and i2c are affected.  Any bus which
> > creates a device hierarchy with dynamic addition & removal needs
> > to make sure no new children are added after removal of the parent
> > has begun.
> 
> I thought the bus code itself had this type of serialization already...

An SPI device is inaccessible once the controller has been torn down,
yet drivers may need to reach SPI devices to unbind cleanly (e.g. to
quiesce interrupts on SPI devices).

Therefore SPI devices need to be unregistered first and the controller
last.  However with CONFIG_OF_DYNAMIC=y, an SPI device may be added
at runtime via of_spi_notify(), which does take a ref on the controller,
but otherwise runs lockless against spi_unregister_controller().

What can happen here is an SPI device gets instantiated below a
controller as it is being removed and the SPI device can't be unbound
or removed cleanly because it's inaccessible.

The bus code can't do anything about this.  It doesn't learn about the
controller going away until device_unregister() is called at the *end* of
spi_unregister_controller().

Anyway, the preliminary patch below should do the trick and I've also
cooked up something similar for i2c.  Needs to be tested still.

Thanks,

Lukas

-- >8 --

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6626587..b6876dd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -475,6 +475,12 @@ struct boardinfo {
  */
 static DEFINE_MUTEX(board_lock);
 
+/*
+ * Prevents addition of devices with same chip select and
+ * addition of devices below an unregistering controller.
+ */
+static DEFINE_MUTEX(spi_add_lock);
+
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -554,7 +560,6 @@ static int spi_dev_check(struct device *dev, void *data)
  */
 int spi_add_device(struct spi_device *spi)
 {
-	static DEFINE_MUTEX(spi_add_lock);
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
 	int status;
@@ -575,6 +580,12 @@ int spi_add_device(struct spi_device *spi)
 	 */
 	mutex_lock(&spi_add_lock);
 
+	if ((IS_ENABLED(CONFIG_OF_DYNAMIC) || IS_ENABLED(CONFIG_ACPI) ||
+	     IS_ENABLED(CONFIG_SPI_SLAVE)) && ctlr->unregistering) {
+		status = -ENODEV;
+		goto done;
+	}
+
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
 		dev_err(dev, "chipselect %d already in use\n",
@@ -2795,6 +2806,13 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	/* Prevent addition of new devices, then remove existing ones */
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC) || IS_ENABLED(CONFIG_ACPI) ||
+	    IS_ENABLED(CONFIG_SPI_SLAVE)) {
+		mutex_lock(&spi_add_lock);
+		ctlr->unregistering = true;
+		mutex_unlock(&spi_add_lock);
+	}
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 99380c0..6d95515 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -451,6 +451,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @irq_flags: Interrupt enable state during PTP system timestamping
  * @fallback: fallback to pio if dma transfer return failure with
  *	SPI_TRANS_FAIL_NO_START.
+ * @unregistering: Set on controller removal, prevents addition of new devices.
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -667,6 +668,8 @@ struct spi_controller {
 
 	/* Interrupt enable state during PTP system timestamping */
 	unsigned long		irq_flags;
+
+	unsigned int		unregistering:1;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
