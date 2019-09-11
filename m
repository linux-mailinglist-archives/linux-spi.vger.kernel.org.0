Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C7AFA44
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfIKKZZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:25:25 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:46855 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKKZZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:25:25 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 06:25:24 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D39DB101903B3;
        Wed, 11 Sep 2019 12:16:00 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 98ABC6124A0B;
        Wed, 11 Sep 2019 12:16:00 +0200 (CEST)
X-Mailbox-Line: From f45920af18dbf06e34129bbc406f53dc9c5d1075 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Extend the BCM2835 SPI driver to handle simplex transfers internally,
thereby reducing their latency and CPU usage and obviating the need to
have the SPI core convert to full-duplex via SPI_CONTROLLER_MUST_TX/RX.


Changes since v2:

* Patch [03/10]: Round up struct spi_controller to cacheline size
  instead of putting it behind the driver-private data. (Mark Brown)

* Move patch "spi: bcm2835: Work around DONE bit erratum" to the front
  of the series to ease backporting to stable. (Mark Brown)
  (I don't think it's necessary to backport it, hence it's not marked
  for stable, but it might be autoselected by Sasha Levin's AI.)

* Add all collected Acked-by and Tested-by tags, rebase on for-5.4.


Link to v1:

https://lore.kernel.org/dmaengine/20190910112141.GM2036@sirena.org.uk/T/#t


Lukas Wunner (10):
  dmaengine: bcm2835: Allow reusable descriptors
  dmaengine: bcm2835: Allow cyclic transactions without interrupt
  spi: Guarantee cacheline alignment of driver-private data
  spi: bcm2835: Work around DONE bit erratum
  spi: bcm2835: Drop dma_pending flag
  spi: bcm2835: Cache CS register value for ->prepare_message()
  spi: bcm2835: Speed up TX-only DMA transfers by clearing RX FIFO
  dmaengine: bcm2835: Document struct bcm2835_dmadev
  dmaengine: bcm2835: Avoid accessing memory when copying zeroes
  spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO

 drivers/dma/bcm2835-dma.c |  38 +++-
 drivers/spi/spi-bcm2835.c | 407 +++++++++++++++++++++++++++++++-------
 drivers/spi/spi.c         |  11 +-
 3 files changed, 384 insertions(+), 72 deletions(-)

-- 
2.23.0

