Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3317668EE
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjG1JfI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjG1JfI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0374A2
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:06 -0700 (PDT)
Received: from dggpemm100006.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RC2X11shzz1GDLh;
        Fri, 28 Jul 2023 17:34:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 00/21] spi: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:00 +0800
Message-ID: <20230728093221.3312026-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller.

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

