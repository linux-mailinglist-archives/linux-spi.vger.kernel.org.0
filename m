Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A7184BFF
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCMQHN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 12:07:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:34791 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMQHM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Mar 2020 12:07:12 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CA5DF23EC2;
        Fri, 13 Mar 2020 17:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584115630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdJOEklCGNc4MOP7NsgRfesvmIzFSxGDZJkVUdK2A1g=;
        b=Sbm3XzXtHK4jjR8MLIql6/oOrZb4dyCI6UiH8NYVS/daIn/crTPuvHn2VBpoGdsCkb/2sJ
        q5DE6ywjfxnN5mQsWgopjnwSuIoAUMwxhk+IzY71OzNnDs+u5eZsDFsNOTC3oRq6gdyPc5
        MTxr+ixZH8Jzp0Lxj0lDbLcsIzERa84=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Mar 2020 17:07:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <59b07b7d70603c6b536a7354ed0ea8d8@walle.cc>
References: <20200310125542.5939-1-olteanv@gmail.com>
 <615284875b709f602d57e4a4621a83c1@walle.cc>
 <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
 <59b07b7d70603c6b536a7354ed0ea8d8@walle.cc>
Message-ID: <4ba077c80143c8ec679066e6d8cedca2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: CA5DF23EC2
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-10 16:22, schrieb Michael Walle:
> Hi Vladimir,
> 
> Am 2020-03-10 15:56, schrieb Vladimir Oltean:
>>> (2) Also, reading the flash, every second time there is 
>>> (reproducibly)
>>> an
>>> IO error:
>>> 
>>> # hexdump -C /dev/mtd0
>>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>>> |huhu............|
>>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>>> |................|
>>> *
>>> 01000000
>>> # hexdump -C /dev/mtd0
>>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>>> |huhu............|
>>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>>> |................|
>>> *
>>> hexdump: /dev/mtd0: Input/output error
>>> 00dc0000
>>> # hexdump -C /dev/mtd0
>>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>>> |huhu............|
>>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>>> |................|
>>> *
>>> 01000000
>>> # hexdump -C /dev/mtd0
>>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>>> |huhu............|
>>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>>> |................|
>>> *
>>> hexdump: /dev/mtd0: Input/output error
>>> 00e6a000
>>> 
>> 
>> Just to be clear, issue 2 is seen only after you abort another
>> transaction, right?
> 
> No, just normal uninterrupted reading. Just tried it right after
> reboot. Doesn't seem to be every second time though, just random
> which makes me wonder if that is another problem now. Also the
> last successful reading is random.


Ok I guess I know what the root cause is. This is an extract of
the current code:

> static int dspi_transfer_one_message(struct spi_controller *ctlr,
> 				     struct spi_message *message)
> {
> ..
> 	/* Kick off the interrupt train */
> 	dspi_fifo_write(dspi);
> 
> 	status = wait_event_interruptible(dspi->waitq,
> 					  dspi->waitflags);
> 	dspi->waitflags = 0;
> ..
> }
> 
> static int dspi_rxtx(struct fsl_dspi *dspi)
> {
> 	dspi_fifo_read(dspi);
> 
> 	if (!dspi->len)
> 		/* Success! */
> 		return 0;
> 
> 	dspi_fifo_write(dspi);
> 
> 	return -EINPROGRESS;
> }

dspi_rxtx() is used in the ISR. Both dspi_fifo_write() and dspi_rxtx()
access shared data like, dspi->words_in_flight. In the EIO error case
the following bytes_sent is -1, because dspi->words_in_flight is -1.

> /* Update total number of bytes that were transferred */
> bytes_sent = dspi->words_in_flight * dspi->oper_word_size;

words_in_flight is always -1 after dspi_fifo_read() was called. In
the error case, the ISR kicks in right in the middle of the execution
of dspi_fifo_write() in dspi_transfer_one_message().

> static void dspi_fifo_write(struct fsl_dspi *dspi)
> {
> ..
> 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
> 		dspi_eoq_fifo_write(dspi);
> 	 else
> 		dspi_xspi_fifo_write(dspi);

Now if the ISR is executed right here..

> 
> 	/* Update total number of bytes that were transferred */
> 	bytes_sent = dspi->words_in_flight * dspi->oper_word_size;

.. words_in_flight might be -1.

> 	msg->actual_length += bytes_sent;

and bytes_sent is negative. And this causes an IO error because
the returned overall message length doesn't match.

> 	dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 8);
> ..
> }

I could not reproduce the issue with the following patch. I don't
know if I got the locking correct though or if there is a better
way to go.


diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8b16de9ed382..578fedeb16a0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -224,6 +224,7 @@ struct fsl_dspi {
         u16                                     tx_cmd;
         const struct fsl_dspi_devtype_data      *devtype_data;

+       spinlock_t lock;
         wait_queue_head_t                       waitq;
         u32                                     waitflags;

@@ -873,14 +874,20 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)

  static int dspi_rxtx(struct fsl_dspi *dspi)
  {
+       unsigned long flags;
+
+       spin_lock_irqsave(&dspi->lock, flags);
         dspi_fifo_read(dspi);

-       if (!dspi->len)
+       if (!dspi->len) {
                 /* Success! */
+               spin_unlock_irqrestore(&dspi->lock, flags);
                 return 0;
+       }

         dspi_fifo_write(dspi);

+       spin_unlock_irqrestore(&dspi->lock, flags);
         return -EINPROGRESS;
  }

@@ -950,7 +957,9 @@ static int dspi_transfer_one_message(struct 
spi_controller *ctlr,
         struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
         struct spi_device *spi = message->spi;
         struct spi_transfer *transfer;
+       unsigned long flags;
         int status = 0;
+       int i = 0;

         if (dspi->irq)
                 dspi_enable_interrupts(dspi, true);
@@ -1009,7 +1018,9 @@ static int dspi_transfer_one_message(struct 
spi_controller *ctlr,
                                 goto out;
                 } else if (dspi->irq) {
                         /* Kick off the interrupt train */
+                       spin_lock_irqsave(&dspi->lock, flags);
                         dspi_fifo_write(dspi);
+                       spin_unlock_irqrestore(&dspi->lock, flags);

                         status = wait_event_interruptible(dspi->waitq,
                                                           
dspi->waitflags);
@@ -1301,6 +1312,7 @@ static int dspi_probe(struct platform_device 
*pdev)
         ctlr->cleanup = dspi_cleanup;
         ctlr->slave_abort = dspi_slave_abort;
         ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+       spin_lock_init(&dspi->lock);

         pdata = dev_get_platdata(&pdev->dev);
         if (pdata) {



-michael
