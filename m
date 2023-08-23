Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BE784F41
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHWDdh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHWDdh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C5CF2
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:34 -0700 (PDT)
Received: from dggpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVsCp2SYGzNn7y;
        Wed, 23 Aug 2023 11:29:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:32 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 00/21] spi: switch to use modern name (part3)
Date:   Wed, 23 Aug 2023 11:29:42 +0800
Message-ID: <20230823033003.3407403-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I'm trying to rename the legacy name to modern name used in SPI drivers,
this is part3 patchset.

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. Each patch compile test passed.

v1 -> v2:
In patch #3, #4, #5, #6, #7, #11,
keep some registers and comments using old name to fit with documentation.

Yang Yingliang (21):
  spi: lm70llp: switch to use modern name
  spi: lp-8841: switch to use modern name
  spi: meson-spicc: switch to use modern name
  spi: meson-spifc: switch to use modern name
  spi: microchip-core-qspi: switch to use modern name
  spi: microchip-core: switch to use modern name
  spi: mpc512x-psc: switch to use modern name
  spi: mpc52xx-psc: switch to use modern name
  spi: mpc52xx: switch to use modern name
  spi: mt65xx: switch to use modern name
  spi: mt7621: switch to use modern name
  spi: mtk-nor: switch to use modern name
  spi: mtk-snfi: switch to use modern name
  spi: mux: switch to use spi_alloc_host()
  spi: mxic: switch to use modern name
  spi: mxs: switch to use modern name
  spi: npcm-pspi: switch to use modern name
  spi: nxp-fspi: switch to use modern name
  spi: oc-tiny: switch to use modern name
  spi: omap-uwire: switch to use modern name
  spi: omap2-mcspi: switch to use modern name

 drivers/spi/spi-lm70llp.c             |  20 +--
 drivers/spi/spi-lp8841-rtc.c          |  56 +++---
 drivers/spi/spi-meson-spicc.c         |  90 +++++-----
 drivers/spi/spi-meson-spifc.c         |  66 +++----
 drivers/spi/spi-microchip-core-qspi.c |  10 +-
 drivers/spi/spi-microchip-core.c      |  74 ++++----
 drivers/spi/spi-mpc512x-psc.c         |  54 +++---
 drivers/spi/spi-mpc52xx-psc.c         |  34 ++--
 drivers/spi/spi-mpc52xx.c             |  56 +++---
 drivers/spi/spi-mt65xx.c              | 190 ++++++++++-----------
 drivers/spi/spi-mt7621.c              |  50 +++---
 drivers/spi/spi-mtk-nor.c             |  14 +-
 drivers/spi/spi-mtk-snfi.c            |   6 +-
 drivers/spi/spi-mux.c                 |   2 +-
 drivers/spi/spi-mxic.c                |  68 ++++----
 drivers/spi/spi-mxs.c                 |  70 ++++----
 drivers/spi/spi-npcm-pspi.c           |  68 ++++----
 drivers/spi/spi-nxp-fspi.c            |  30 ++--
 drivers/spi/spi-oc-tiny.c             |  30 ++--
 drivers/spi/spi-omap-uwire.c          |  32 ++--
 drivers/spi/spi-omap2-mcspi.c         | 236 +++++++++++++-------------
 21 files changed, 628 insertions(+), 628 deletions(-)

-- 
2.25.1

