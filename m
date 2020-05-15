Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235D51D554C
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEOP6O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgEOP6O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 11:58:14 -0400
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17464C061A0C
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 08:58:14 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D6AF910030DBE;
        Fri, 15 May 2020 17:58:11 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 96D0560AA8C2;
        Fri, 15 May 2020 17:58:11 +0200 (CEST)
X-Mailbox-Line: From d0dcbd098401b5d2a486eee7cf2f9dcabacf9605 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1589557526.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 15 May 2020 17:58:00 +0200
Subject: [PATCH 0/5] Raspberry Pi SPI unbind fixes
To:     Mark Brown <broonie@kernel.org>
Cc:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jingoo Han <jg1.han@samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series fixes ordering issues occurring on unbind of the
Raspberry Pi SPI drivers:

Turns out devm_spi_register_controller() is prone to
incorrect use and dozens of drivers have gotten it wrong.
I'm only documenting this gotcha here and fixing it in the
Raspberry Pi drivers.  Fixing the rest is for another day.

There's also an ordering issue in the core which has been
present for 8 years and affects all platforms (patch [1/5]).
Doesn't look like unbinding is tested all that often. :-)


Lukas Wunner (5):
  spi: Fix controller unregister order
  spi: bcm2835: Fix controller unregister order
  spi: bcm2835aux: Fix controller unregister order
  spi: bcm2835: Tear down DMA before turning off SPI controller
  spi: Document devm_spi_register_controller() gotcha

 drivers/spi/spi-bcm2835.c    |  8 +++++---
 drivers/spi/spi-bcm2835aux.c |  4 +++-
 drivers/spi/spi.c            | 10 +++++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.26.2

