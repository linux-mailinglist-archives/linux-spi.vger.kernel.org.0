Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09821E0E5D
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgEYMZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390360AbgEYMZI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 08:25:08 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D5C061A0E
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 05:25:07 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id C57D410189CEA;
        Mon, 25 May 2020 14:25:04 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 88E8E6029C6E;
        Mon, 25 May 2020 14:25:04 +0200 (CEST)
X-Mailbox-Line: From 58b2ac6942ca1f91aaeeafe512144bc5343e1d84 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1590408496.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 25 May 2020 14:25:00 +0200
Subject: [PATCH 0/3] Intel SPI unbind fixes
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix unbind ordering issues in the Designware and PXA2xx SPI controllers
built into Intel SoCs.

To test, you'll also need the following commit:
https://git.kernel.org/broonie/spi/c/84855678add8

This is compile-tested only, so please review and test thoroughly.

Pay particular attention to the IRQ handlers dw_spi_irq() and ssp_int():
Both drivers request the interrupt with IRQF_SHARED, so the IRQ handler
may run even though the SPI controller itself hasn't signalled an
interrupt.  The IRQ is requested before registering the controller and
freed after unregistering the controller.  Thus, the IRQ handler should
immediately bail out if the controller is not yet or no longer registered,
e.g. by checking in the controller's registers whether an interrupt is
actually pending.  The drivers may need to disable interrupts in the
controllers' registers upon unbinding and they need to make sure that
the registers are accessible until the IRQ is freed.

I don't have a datasheet for these SPI controllers but I hope someone
who is more familiar with them will be able to check for correctness
of the IRQ handling.

Lukas Wunner (3):
  spi: dw: Fix controller unregister order
  spi: pxa2xx: Fix controller unregister order
  spi: pxa2xx: Fix runtime PM ref imbalance on probe error

 drivers/spi/spi-dw.c     | 4 +++-
 drivers/spi/spi-pxa2xx.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.0

