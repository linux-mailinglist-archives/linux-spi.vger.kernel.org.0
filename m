Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDBD28EAE9
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 04:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgJOCJh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 22:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJOCJh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 22:09:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE6BC0613B0;
        Wed, 14 Oct 2020 14:20:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so384817pld.5;
        Wed, 14 Oct 2020 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=EJ2PeMhfc4rmZlGA6v6wKoYQzDqFqC0A/22GiKcGyRg=;
        b=trE29uCY5w5HHbZlzdkeWcnWNM9IqcWz2fl3QTWt+Ug1H7p1DmtZy2RvTrCXHoYFa/
         mdCNe78aAoAYVL53Se/iq0m6mKwFdG0MHXsa7yCqdtWfwL0czVeAfjEwjH0RF7Nq6NRF
         GV0dk4+YMgm3ADnE6cnV2pK1CsyG7Zu5B1WZ2PBUUEzHKNHp3oXHe+P24sHIdELvmRSW
         iH2T7pqBygCIqPHBi/LSDF2SQpyGAcQFNbzFlU/NLNhcZ4PkhDnPziMLEPOABwwzcAor
         bhk4BEAYmQClZbEYfT2S9VxZkpnjoUBkhKmK9fw4ARUMLODQhtbFs4sM0r9PibcxpdJu
         CQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=EJ2PeMhfc4rmZlGA6v6wKoYQzDqFqC0A/22GiKcGyRg=;
        b=CQiQVhTdK2VljWPssIhiP1N6HvOxDTI6SxVk0Q1qsLwAMbx4nv2NP01NH/37epGbQ+
         XfRBsM1dsHl5kV95VQM2jbZvDSwz/jF2IusW17BcCHbxUBxRJe8qDcrCntmDZWTkCnWZ
         IYFe6tEBIGN12rLc/VyRG8fzIfEUqIr26ZkGVEO0CygzpnrB0rcU0wNBA1fySwbDcuxl
         Nuk0dklrC2N1k9ad66WJ3qi1U6sc5YG+rrcktDNeEwizdP2SwYS0goTwc2fNY2HtT0DY
         JhfQU4Lqi+r/8JvoJKv+ghvYD//D0GRDl6QtzwYP+eaNu77+z0QwNBI4fA+mC0dDM7DY
         vjRQ==
X-Gm-Message-State: AOAM5315lvaVe6NAG8JvnaAJK6a1chXSDEmIaDbs4GeNySY3UJegZoKa
        KBVKnjm2fGprqq311rywNg1J8CEzPEY=
X-Google-Smtp-Source: ABdhPJxXN/e/1JhF96FhdQmKgc6gLUpjqOfiAOxD1XyWmsKKtNJE9Y5LgL0bK6TVt7cKIrYXMv55rA==
X-Received: by 2002:a17:90a:9ec:: with SMTP id 99mr1079971pjo.138.1602710419036;
        Wed, 14 Oct 2020 14:20:19 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y13sm537705pfl.166.2020.10.14.14.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 14:20:18 -0700 (PDT)
Subject: Re: Use after free in bcm2835_spi_remove()
To:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de> <20201014194035.ukduovokggu37uba@skbuf>
 <20201014202505.GF4580@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <b094c266-99ce-4462-9041-7d1659b13300@gmail.com>
Date:   Wed, 14 Oct 2020 14:20:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014202505.GF4580@sirena.org.uk>
Content-Type: multipart/mixed;
 boundary="------------2A71BE36EEA37111A733C50F"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a multi-part message in MIME format.
--------------2A71BE36EEA37111A733C50F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 10/14/20 1:25 PM, Mark Brown wrote:
> On Wed, Oct 14, 2020 at 10:40:35PM +0300, Vladimir Oltean wrote:
>> On Wed, Oct 14, 2020 at 04:09:12PM +0200, Lukas Wunner wrote:
> 
>>> Apparently the problem is that spi_unregister_controller() drops the
>>> last ref on the controller, causing it to be freed, and afterwards we
>>> access the controller's private data, which is part of the same
>>> allocation as struct spi_controller:
> 
>>> bcm2835_spi_remove()
>>>   spi_unregister_controller()
>>>     device_unregister()
>>>       put_device()
>>>         spi_controller_release()  #  spi_master_class.dev_release()
>>> 	  kfree(ctlr)
>>>   bcm2835_dma_release(ctlr, bs)
> 
>> Also see these threads:
>> https://lore.kernel.org/linux-spi/20200922112241.GO4792@sirena.org.uk/T/#t
>> https://lore.kernel.org/linux-spi/270b94fd1e546d0c17a735c1f55500e58522da04.camel@suse.de/T/#u
> 
> Right, the proposed patch is yet another way to fix the issue - it all
> comes back to the fact that you shouldn't be using the driver data after
> unregistering if it was allocated as part of allocating the controller.
> This framework feature is unfortunately quite error prone.

Lukas, your patch works fine for me and is only two lines, so maybe
better suited for stable. How about the attached patch?
-- 
Florian

--------------2A71BE36EEA37111A733C50F
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-spi-bcm2835-Fix-use-after-free-in-bcm2835_spi_remove.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-spi-bcm2835-Fix-use-after-free-in-bcm2835_spi_remove.pa";
 filename*1="tch"

=46rom a4ee9da1ef09f9ddb04060e644b9c34fd532c189 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 14 Oct 2020 14:15:28 -0700
Subject: [PATCH] spi: bcm2835: Fix use-after-free in bcm2835_spi_remove()=


In bcm2835_spi_remove(), spi_controller_unregister() will free the ctlr
reference which will lead to an use after free in bcm2835_release_dma().

To avoid this use after free, allocate the bcm2835_spi structure with a
different lifecycle than the spi_controller structure such that we
unregister the SPI controller, free up all the resources and finally let
device managed allocations free the bcm2835_spi structure.

Fixes: 05897c710e8e ("spi: bcm2835: Tear down DMA before turning off SPI =
controller")
Fixes: 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers meetin=
g certain conditions")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 41986ac0fbfb..d66358e6b5cd 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -847,42 +847,41 @@ static bool bcm2835_spi_can_dma(struct spi_controll=
er *ctlr,
 	return true;
 }
=20
-static void bcm2835_dma_release(struct spi_controller *ctlr,
-				struct bcm2835_spi *bs)
+static void bcm2835_dma_release(struct bcm2835_spi *bs,
+				struct dma_chan *dma_tx,
+				struct dma_chan *dma_rx)
 {
 	int i;
=20
-	if (ctlr->dma_tx) {
-		dmaengine_terminate_sync(ctlr->dma_tx);
+	if (dma_tx) {
+		dmaengine_terminate_sync(dma_tx);
=20
 		if (bs->fill_tx_desc)
 			dmaengine_desc_free(bs->fill_tx_desc);
=20
 		if (bs->fill_tx_addr)
-			dma_unmap_page_attrs(ctlr->dma_tx->device->dev,
+			dma_unmap_page_attrs(dma_tx->device->dev,
 					     bs->fill_tx_addr, sizeof(u32),
 					     DMA_TO_DEVICE,
 					     DMA_ATTR_SKIP_CPU_SYNC);
=20
-		dma_release_channel(ctlr->dma_tx);
-		ctlr->dma_tx =3D NULL;
+		dma_release_channel(dma_tx);
 	}
=20
-	if (ctlr->dma_rx) {
-		dmaengine_terminate_sync(ctlr->dma_rx);
+	if (dma_rx) {
+		dmaengine_terminate_sync(dma_rx);
=20
 		for (i =3D 0; i < BCM2835_SPI_NUM_CS; i++)
 			if (bs->clear_rx_desc[i])
 				dmaengine_desc_free(bs->clear_rx_desc[i]);
=20
 		if (bs->clear_rx_addr)
-			dma_unmap_single(ctlr->dma_rx->device->dev,
+			dma_unmap_single(dma_rx->device->dev,
 					 bs->clear_rx_addr,
 					 sizeof(bs->clear_rx_cs),
 					 DMA_TO_DEVICE);
=20
-		dma_release_channel(ctlr->dma_rx);
-		ctlr->dma_rx =3D NULL;
+		dma_release_channel(dma_rx);
 	}
 }
=20
@@ -1010,7 +1009,7 @@ static int bcm2835_dma_init(struct spi_controller *=
ctlr, struct device *dev,
 	dev_err(dev, "issue configuring dma: %d - not using DMA mode\n",
 		ret);
 err_release:
-	bcm2835_dma_release(ctlr, bs);
+	bcm2835_dma_release(bs, ctlr->dma_tx, ctlr->dma_rx);
 err:
 	/*
 	 * Only report error for deferred probing, otherwise fall back to
@@ -1291,12 +1290,17 @@ static int bcm2835_spi_probe(struct platform_devi=
ce *pdev)
 	struct bcm2835_spi *bs;
 	int err;
=20
+	bs =3D devm_kzalloc(&pdev->dev, sizeof(*bs), GFP_KERNEL);
+	if (!bs)
+		return -ENOMEM;
+
 	ctlr =3D spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
 						  dma_get_cache_alignment()));
 	if (!ctlr)
 		return -ENOMEM;
=20
-	platform_set_drvdata(pdev, ctlr);
+	spi_controller_set_devdata(ctlr, bs);
+	platform_set_drvdata(pdev, bs);
=20
 	ctlr->use_gpio_descriptors =3D true;
 	ctlr->mode_bits =3D BCM2835_SPI_MODE_BITS;
@@ -1308,7 +1312,6 @@ static int bcm2835_spi_probe(struct platform_device=
 *pdev)
 	ctlr->prepare_message =3D bcm2835_spi_prepare_message;
 	ctlr->dev.of_node =3D pdev->dev.of_node;
=20
-	bs =3D spi_controller_get_devdata(ctlr);
 	bs->ctlr =3D ctlr;
=20
 	bs->regs =3D devm_platform_ioremap_resource(pdev, 0);
@@ -1362,7 +1365,7 @@ static int bcm2835_spi_probe(struct platform_device=
 *pdev)
 	return 0;
=20
 out_dma_release:
-	bcm2835_dma_release(ctlr, bs);
+	bcm2835_dma_release(bs, ctlr->dma_tx, ctlr->dma_rx);
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
 out_controller_put:
@@ -1372,14 +1375,19 @@ static int bcm2835_spi_probe(struct platform_devi=
ce *pdev)
=20
 static int bcm2835_spi_remove(struct platform_device *pdev)
 {
-	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
-	struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
+	struct bcm2835_spi *bs =3D platform_get_drvdata(pdev);
+	struct spi_controller *ctlr =3D bs->ctlr;
+	struct dma_chan *tx_chan =3D ctlr->dma_tx;
+	struct dma_chan *rx_chan =3D ctlr->dma_rx;
=20
 	bcm2835_debugfs_remove(bs);
=20
 	spi_unregister_controller(ctlr);
=20
-	bcm2835_dma_release(ctlr, bs);
+	/* ctlr is freed by spi_unregister_controller() use the cached dma_chan=

+	 * references.
+	 */
+	bcm2835_dma_release(bs, tx_chan, rx_chan);
=20
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
--=20
2.25.1


--------------2A71BE36EEA37111A733C50F--
