Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63672AF8AA
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 20:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKKTHE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 14:07:04 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:53119 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKTHE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 14:07:04 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 5989810190FCD;
        Wed, 11 Nov 2020 20:07:01 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C3695609762E;
        Wed, 11 Nov 2020 20:07:01 +0100 (CET)
X-Mailbox-Line: From 5e31a9a59fd1c0d0b795b2fe219f25e5ee855f9d Mon Sep 17 00:00:00 2001
Message-Id: <cover.1605121038.git.lukas@wunner.de>
In-Reply-To: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Nov 2020 20:07:00 +0100
Subject: [PATCH 0/4] Use-after-free be gone
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Here's my proposal to fix the use-after-free bugs reported by
Sascha Hauer and Florian Fainelli:

I scrutinized all SPI drivers in the v5.10 tree:

* There are 9 drivers with a use-after-free in the ->remove() hook
  caused by accessing driver private data after spi_unregister_controller().

* There are 8 drivers which leak the spi_controller in the ->probe()
  error path because of a missing spi_controller_put().

I'm introducing devm_spi_alloc_master/slave() which automatically
calls spi_controller_put() on ->remove().  This fixes both classes
of bugs while at the same time reducing code amount and complexity
in the ->probe() hook.

I propose that spi_controller_unregister() should no longer release
a reference on the spi_controller.  Instead, drivers need to either
do it themselves or use one of the devm functions introduced herein.
The vast majority of drivers can be converted to the devm functions.
See the commit message of patch [1/4] for the rationale and details.

Enclosed are patches for 3 Broadcom drivers.
Patches for the other drivers are on this branch:
https://github.com/l1k/linux/commits/spi_fixes

@Florian Fainelli:  Could you verify that there are no KASAN splats or
leaks with these patches?  Unfortunately I do not have any SPI-capable
hardware at my disposal right now, so can only compile-test.  You may
want to augment spi_controller_release() with a printk() to log when
the spi_controller is freed.

@Mark Brown:  Patches [2/4] to [4/4] reference the SHA-1 of patch [1/4]
in their stable tags.  Because the hash is unknown to me until you apply
the patch, I've used "123456789abc" as a placeholder.  You'll have to
replace the hash if/when applying.  Alternatively, only apply patch [1/4]
and I'll repost the other patches with the hash fixed up.

Thanks!


Lukas Wunner (4):
  spi: Introduce device-managed SPI controller allocation
  spi: bcm2835: Fix use-after-free on unbind
  spi: bcm2835aux: Fix use-after-free on unbind
  spi: bcm-qspi: Fix use-after-free on unbind

 drivers/spi/spi-bcm-qspi.c   | 34 ++++++++-------------
 drivers/spi/spi-bcm2835.c    | 24 +++++----------
 drivers/spi/spi-bcm2835aux.c | 21 +++++--------
 drivers/spi/spi.c            | 58 +++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h      | 19 ++++++++++++
 5 files changed, 103 insertions(+), 53 deletions(-)

-- 
2.28.0

