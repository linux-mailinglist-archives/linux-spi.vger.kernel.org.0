Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA97772EF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjHJIdI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjHJIdH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C879FED
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:06 -0700 (PDT)
Received: from dggpemm100006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RM0VF6Vx8zqSr8;
        Thu, 10 Aug 2023 16:30:13 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 00/21] spi: switch to use modern name (part3)
Date:   Thu, 10 Aug 2023 16:29:43 +0800
Message-ID: <20230810083004.3988597-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/spi/spi-meson-spicc.c         | 106 ++++++------
 drivers/spi/spi-meson-spifc.c         |  94 +++++-----
 drivers/spi/spi-microchip-core-qspi.c |  14 +-
 drivers/spi/spi-microchip-core.c      |  90 +++++-----
 drivers/spi/spi-mpc512x-psc.c         |  54 +++---
 drivers/spi/spi-mpc52xx-psc.c         |  34 ++--
 drivers/spi/spi-mpc52xx.c             |  56 +++---
 drivers/spi/spi-mt65xx.c              | 190 ++++++++++-----------
 drivers/spi/spi-mt7621.c              |  70 ++++----
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
 21 files changed, 670 insertions(+), 670 deletions(-)

-- 
2.25.1

