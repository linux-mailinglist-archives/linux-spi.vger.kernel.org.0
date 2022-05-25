Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85AB533F31
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiEYO3n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiEYO3m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 10:29:42 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E91146B
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=JRIU1D2gVcE7WecOJZLB+34H02WFFD/z9G1eWPodXic=;
        b=GuX6QWZNDLFctSE6rgNjQSpma1ITjY5bO/uK4vb5py5/8kEi+O3D/1rYET4QtWsLuVGOAzUG9FEO8
         dlKOolxOXDn5NwQiIndkXjEnwLEID1fg7NA69yJuX6Dv7pHU46b+KYLhu/w+hqtWHBebdu7QT7zw8r
         kwFXp5jhoaGj9xnNnvI8HzSEIsnyRYM82PK0pkpHRxni+FbijDMr1UiHw5GN/i08Np0E4SJuOCvlkd
         u6HWE0UuoCIwvvKfH0FpwsjOnVyWo1MXqtCeFllmEU+RHLm8KFrXCWqNX29Isrn44+NpQmUa6hupqc
         ZV6X94iGmy/qyA/wsyLXflGwXWNpOyg==
X-MSG-ID: 1a68e90c-dc37-11ec-b450-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [RFC] [PATCH 0/3] Optimize spi_sync path
Date:   Wed, 25 May 2022 16:29:25 +0200
Message-Id: <20220525142928.2335378-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These patches optimize the spi_sync call for the common case that the
worker thread is idle and the queue is empty. It also opens the
possibility to potentially further optimize the async path also, since
it doesn't need to take into account the direct sync path anymore.

As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
controller attached (MCP2518FD), the time the interrupt line stays
active (which corresponds roughly with the time it takes to send 3
relatively short consecutive spi_sync messages) is reduced from 98us to
only 72us by this patch.

Unfortunately though, this optimization requires a small and hopefully
innocuous API change. This change is contained in the first patch, and
it replaces the function spi_finalize_current_message() with
spi_finalize_message(), which takes the message instead of its
controller as argument. Without this change, it is not possible to avoid
touching the controller message queue, which is what this is all about.

A note about message ordering:

This patch series should not change the behavior of message ordering when
coming from the same context. This means that if a client driver issues
one or more spi_async() messages immediately followed by a spi_sync()
message in the same context, it can still rely on these messages being
sent out in the order they were fired.

David Jander (3):
  drivers: spi: API: spi_finalize_current_message ->
    spi_finalize_message
  drivers: spi: spi.c: Move ctlr->cur_msg_prepared to struct spi_message
  drivers: spi: spi.c: Don't use the message queue if possible in
    spi_sync

 Documentation/spi/spi-summary.rst             |   4 +-
 .../media/pci/netup_unidvb/netup_unidvb_spi.c |   2 +-
 drivers/media/usb/msi2500/msi2500.c           |   2 +-
 drivers/spi/spi-amd.c                         |   2 +-
 drivers/spi/spi-ar934x.c                      |   2 +-
 drivers/spi/spi-axi-spi-engine.c              |   2 +-
 drivers/spi/spi-bcm63xx-hsspi.c               |   2 +-
 drivers/spi/spi-bcm63xx.c                     |   2 +-
 drivers/spi/spi-cavium.c                      |   2 +-
 drivers/spi/spi-falcon.c                      |   2 +-
 drivers/spi/spi-fsi.c                         |   2 +-
 drivers/spi/spi-fsl-dspi.c                    |   2 +-
 drivers/spi/spi-fsl-espi.c                    |   2 +-
 drivers/spi/spi-fsl-spi.c                     |   2 +-
 drivers/spi/spi-mpc512x-psc.c                 |   2 +-
 drivers/spi/spi-mt7621.c                      |   2 +-
 drivers/spi/spi-mtk-nor.c                     |   2 +-
 drivers/spi/spi-mux.c                         |   2 +-
 drivers/spi/spi-mxs.c                         |   2 +-
 drivers/spi/spi-omap-100k.c                   |   2 +-
 drivers/spi/spi-pic32-sqi.c                   |   2 +-
 drivers/spi/spi-pl022.c                       |   4 +-
 drivers/spi/spi-sc18is602.c                   |   2 +-
 drivers/spi/spi-sh-hspi.c                     |   2 +-
 drivers/spi/spi-tegra114.c                    |   2 +-
 drivers/spi/spi-tegra20-sflash.c              |   2 +-
 drivers/spi/spi-tegra210-quad.c               |   2 +-
 drivers/spi/spi-ti-qspi.c                     |   2 +-
 drivers/spi/spi-xcomm.c                       |   2 +-
 drivers/spi/spi.c                             | 269 ++++++++++--------
 drivers/staging/greybus/spilib.c              |   2 +-
 include/linux/spi/spi.h                       |  21 +-
 32 files changed, 206 insertions(+), 148 deletions(-)

-- 
2.32.0

