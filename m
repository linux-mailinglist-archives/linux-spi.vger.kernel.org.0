Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585A577271C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHGOKQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjHGOKP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39A9E
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:14 -0700 (PDT)
Received: from dggpemm100017.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKJ6f3CC5z1Z1Wh;
        Mon,  7 Aug 2023 22:07:22 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100017.china.huawei.com (7.185.36.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 00/21] spi: switch to use modern name (part1)
Date:   Mon, 7 Aug 2023 22:06:56 +0800
Message-ID: <20230807140717.3484180-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I'm trying to rename the legacy name to modern name used in SPI drivers,
this is part1 patchset.

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. Each patch compile test passed.

v1 -> v2:
  patch #10 rebase on latest next branch.

Yang Yingliang (21):
  spi: amd: switch to use modern name
  spi: aspeed: switch to use modern name
  spi: spi-axi-spi-engine: switch to use modern name
  spi: bcm-qspi: switch to use modern name
  spi: bcm2835: switch to use modern name
  spi: bcm2835aux: switch to use modern name
  spi: bcm63xx-hsspi: switch to use modern name
  spi: bcm63xx: switch to use modern name
  spi: butterfly: switch to use modern name
  spi: cadence-quadspi: switch to use modern name
  spi: cadence-xspi: switch to use modern name
  spi: cadence: switch to use modern name
  spi: clps711x: switch to use modern name
  spi: octeon: switch to use modern name
  spi: spi-cavium-thunderx: switch to use modern name
  spi: coldfire-qspi: switch to use modern name
  spi: davinci: switch to use modern name
  spi: dln2: switch to use modern name
  spi: dw: switch to use modern name
  spi: hisi-kunpeng: switch to use modern name
  spi: npcm-fiu: switch to use modern name

 drivers/spi/spi-amd.c             |  50 ++++++-------
 drivers/spi/spi-aspeed-smc.c      |  14 ++--
 drivers/spi/spi-axi-spi-engine.c  |  58 ++++++++--------
 drivers/spi/spi-bcm-qspi.c        |  64 ++++++++---------
 drivers/spi/spi-bcm2835.c         | 112 +++++++++++++++---------------
 drivers/spi/spi-bcm2835aux.c      |  84 +++++++++++-----------
 drivers/spi/spi-bcm63xx-hsspi.c   |  86 +++++++++++------------
 drivers/spi/spi-bcm63xx.c         |  68 +++++++++---------
 drivers/spi/spi-butterfly.c       |  18 ++---
 drivers/spi/spi-cadence-quadspi.c |  44 ++++++------
 drivers/spi/spi-cadence-xspi.c    |  30 ++++----
 drivers/spi/spi-cadence.c         |  70 +++++++++----------
 drivers/spi/spi-cavium-octeon.c   |  32 ++++-----
 drivers/spi/spi-cavium-thunderx.c |  32 ++++-----
 drivers/spi/spi-clps711x.c        |  42 +++++------
 drivers/spi/spi-coldfire-qspi.c   |  66 +++++++++---------
 drivers/spi/spi-davinci.c         |  76 ++++++++++----------
 drivers/spi/spi-dln2.c            |  94 ++++++++++++-------------
 drivers/spi/spi-dw-core.c         | 112 +++++++++++++++---------------
 drivers/spi/spi-dw-dma.c          |  22 +++---
 drivers/spi/spi-dw-mmio.c         |  10 +--
 drivers/spi/spi-dw.h              |   4 +-
 drivers/spi/spi-hisi-kunpeng.c    |  84 +++++++++++-----------
 drivers/spi/spi-npcm-fiu.c        |  20 +++---
 24 files changed, 646 insertions(+), 646 deletions(-)

-- 
2.25.1

