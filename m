Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7477246E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjHGMoM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjHGMoL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803CC10F7
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:09 -0700 (PDT)
Received: from dggpemm100019.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKGCM0WN9z1Z1WG;
        Mon,  7 Aug 2023 20:41:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100019.china.huawei.com (7.185.36.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 00/20] spi: switch to use modern name (part2)
Date:   Mon, 7 Aug 2023 20:40:45 +0800
Message-ID: <20230807124105.3429709-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
this is part2 patchset.

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. All compile test passed.

Yang Yingliang (20):
  spi: amlogic-spifc-a1: switch to use devm_spi_alloc_host()
  spi: au1550: switch to use modern name
  spi: ep93xx: switch to use modern name
  spi: falcon: switch to use modern name
  spi: fsi: switch to use spi_alloc_host()
  spi: fsl-dspi: switch to use modern name
  spi: fsl-espi: switch to use modern name
  spi: fsl-lpspi: switch to use modern name
  spi: fsl-qspi: switch to use modern name
  spi: fsl-spi: switch to use modern name
  spi: gpio: switch to use modern name
  spi: gxp: switch to use modern name
  spi: bcmbca-hsspi: switch to use modern name
  spi: hisi-sfc-v3xx: switch to use modern name
  spi: img-spfi: switch to use modern name
  spi: imx: switch to use modern name
  spi: ingenic: switch to use devm_spi_alloc_host()
  spi: intel: switch to use modern name
  spi: jcore: switch to use modern name
  spi: lantiq: switch to use modern name

 drivers/spi/spi-amlogic-spifc-a1.c |   2 +-
 drivers/spi/spi-au1550.c           |  74 ++++++------
 drivers/spi/spi-bcmbca-hsspi.c     |  66 +++++------
 drivers/spi/spi-ep93xx.c           | 174 ++++++++++++++---------------
 drivers/spi/spi-falcon.c           |  34 +++---
 drivers/spi/spi-fsi.c              |   2 +-
 drivers/spi/spi-fsl-dspi.c         |  24 ++--
 drivers/spi/spi-fsl-espi.c         |  76 ++++++-------
 drivers/spi/spi-fsl-lpspi.c        |  54 ++++-----
 drivers/spi/spi-fsl-qspi.c         |  10 +-
 drivers/spi/spi-fsl-spi.c          |  76 ++++++-------
 drivers/spi/spi-gpio.c             |  72 ++++++------
 drivers/spi/spi-gxp.c              |   6 +-
 drivers/spi/spi-hisi-sfc-v3xx.c    |  18 +--
 drivers/spi/spi-img-spfi.c         | 118 +++++++++----------
 drivers/spi/spi-imx.c              | 114 +++++++++----------
 drivers/spi/spi-ingenic.c          |   2 +-
 drivers/spi/spi-intel.c            |  42 +++----
 drivers/spi/spi-jcore.c            |  44 ++++----
 drivers/spi/spi-lantiq-ssc.c       |  96 ++++++++--------
 20 files changed, 552 insertions(+), 552 deletions(-)

-- 
2.25.1

