Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118E78376D
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjHVBin (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjHVBim (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3D110
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:39 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBjg2jlPzNn3Q;
        Tue, 22 Aug 2023 09:35:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:37 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 00/24] spi: switch to use modern name (part5)
Date:   Tue, 22 Aug 2023 09:34:47 +0800
Message-ID: <20230822013511.4161475-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I'm trying to rename the legacy name to modern name used in SPI drivers,
this is part5 patchset.

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. Each patch compile test passed.

Yang Yingliang (24):
  spi: sprd-adi: switch to use spi_alloc_host()
  spi: sprd: switch to use modern name
  spi: st-ssc4: switch to use modern name
  spi: stm32-qspi: switch to use modern name
  spi: stm32: switch to use modern name
  spi: sun4i: switch to use modern name
  spi: sun6i: switch to use modern name
  spi: sunplus-sp7021: switch to use modern name
  spi: synquacer: switch to use modern name
  spi: geni-qcom: switch to use modern name
  spi: tegra114: switch to use modern name
  spi: tegra20-sflash: switch to use modern name
  spi: tegra20-slink: switch to use modern name
  spi: tegra210-quad: switch to use modern name
  spi: spi-ti-qspi: switch to use modern name
  spi: wpcm-fiu: switch to use devm_spi_alloc_host()
  spi: topcliff-pch: switch to use modern name
  spi: uniphier: switch to use modern name
  spi: xcomm: switch to use modern name
  spi: xilinx: switch to use modern name
  spi: xlp: switch to use modern name
  spi: xtensa-xtfpga: switch to use modern name
  spi: zynq-qspi: switch to use modern name
  spi: zynqmp-gqspi: switch to use modern name

 drivers/spi/spi-geni-qcom.c      |  96 ++++++-------
 drivers/spi/spi-sprd-adi.c       |   2 +-
 drivers/spi/spi-sprd.c           |   4 +-
 drivers/spi/spi-st-ssc4.c        |  70 +++++-----
 drivers/spi/spi-stm32-qspi.c     |  18 +--
 drivers/spi/spi-stm32.c          |  40 +++---
 drivers/spi/spi-sun4i.c          |  70 +++++-----
 drivers/spi/spi-sun6i.c          | 146 ++++++++++----------
 drivers/spi/spi-sunplus-sp7021.c |  88 ++++++------
 drivers/spi/spi-synquacer.c      |  82 +++++------
 drivers/spi/spi-tegra114.c       | 118 ++++++++--------
 drivers/spi/spi-tegra20-sflash.c |  76 +++++------
 drivers/spi/spi-tegra20-slink.c  |  98 +++++++-------
 drivers/spi/spi-tegra210-quad.c  |  80 +++++------
 drivers/spi/spi-ti-qspi.c        |  86 ++++++------
 drivers/spi/spi-topcliff-pch.c   | 226 +++++++++++++++----------------
 drivers/spi/spi-uniphier.c       | 194 +++++++++++++-------------
 drivers/spi/spi-wpcm-fiu.c       |   2 +-
 drivers/spi/spi-xcomm.c          |  32 ++---
 drivers/spi/spi-xilinx.c         |  58 ++++----
 drivers/spi/spi-xlp.c            |  40 +++---
 drivers/spi/spi-xtensa-xtfpga.c  |  30 ++--
 drivers/spi/spi-zynq-qspi.c      |  28 ++--
 drivers/spi/spi-zynqmp-gqspi.c   |  50 +++----
 24 files changed, 867 insertions(+), 867 deletions(-)

-- 
2.25.1

