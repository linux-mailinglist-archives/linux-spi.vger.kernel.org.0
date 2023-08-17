Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888377F021
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbjHQFHv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347904AbjHQFHV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092B2684
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:19 -0700 (PDT)
Received: from dggpemm100016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRCbQ3kc0zFqmd;
        Thu, 17 Aug 2023 13:04:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100016.china.huawei.com (7.185.36.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:16 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 00/23] spi: switch to use modern name (part4)
Date:   Thu, 17 Aug 2023 13:03:09 +0800
Message-ID: <20230817050332.1274751-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
this is part4 patchset.

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. Each patch compile test passed.

v1 -> v2:
  In patch #4, #5, #12, #14, #15, #16, #18, #19, #22,
  keep some comments using old name to fit with documentation.

Yang Yingliang (23):
  spi: orion: switch to use modern name
  spi: mchp-pci1xxxx: switch to use modern name
  spi: pic32-sqi: switch to use modern name
  spi: pic32: switch to use modern name
  spi: spl022: switch to use modern name
  spi: ppc4xx: switch to use modern name
  spi: pxa2xx: switch to use modern name
  spi: spi-qcom-qspi: switch to use modern name
  spi: qup: switch to use modern name
  spi: rb4xx: switch to use modern name
  spi: realtek-rtl: switch to use devm_spi_alloc_host()
  spi: rockchip-sfc: switch to use modern name
  spi: rockchip: switch to use modern name
  spi: rspi: switch to use spi_alloc_host()
  spi: rzv2m-csi: switch to use devm_spi_alloc_host()
  spi: s3c64xx: switch to use modern name
  spi: sc18is602: switch to use modern name
  spi: sh-hspi: switch to use modern name
  spi: sh-msiof: switch to use modern name
  spi: sh-sci: switch to use modern name
  spi: sh: switch to use modern name
  spi: sifive: switch to use modern name
  spi: spi-sn-f-ospi: switch to use modern name

 drivers/spi/spi-orion.c        |  90 +++++++++---------
 drivers/spi/spi-pci1xxxx.c     |  14 +--
 drivers/spi/spi-pic32-sqi.c    |  86 ++++++++---------
 drivers/spi/spi-pic32.c        | 154 +++++++++++++++---------------
 drivers/spi/spi-pl022.c        |  94 +++++++++----------
 drivers/spi/spi-ppc4xx.c       |  44 ++++-----
 drivers/spi/spi-pxa2xx.c       |  24 ++---
 drivers/spi/spi-qcom-qspi.c    |  80 ++++++++--------
 drivers/spi/spi-qup.c          | 166 ++++++++++++++++-----------------
 drivers/spi/spi-rb4xx.c        |  36 +++----
 drivers/spi/spi-realtek-rtl.c  |   2 +-
 drivers/spi/spi-rockchip-sfc.c |  30 +++---
 drivers/spi/spi-rockchip.c     |  58 ++++++------
 drivers/spi/spi-rspi.c         |   2 +-
 drivers/spi/spi-rzv2m-csi.c    |   2 +-
 drivers/spi/spi-s3c64xx.c      | 126 ++++++++++++-------------
 drivers/spi/spi-sc18is602.c    |  50 +++++-----
 drivers/spi/spi-sh-hspi.c      |   4 +-
 drivers/spi/spi-sh-msiof.c     |  52 +++++------
 drivers/spi/spi-sh-sci.c       |  24 ++---
 drivers/spi/spi-sh.c           |  34 +++----
 drivers/spi/spi-sifive.c       |  80 ++++++++--------
 drivers/spi/spi-sn-f-ospi.c    |   4 +-
 include/linux/spi/pxa2xx_spi.h |   4 +-
 include/linux/spi/sh_msiof.h   |   4 +-
 25 files changed, 632 insertions(+), 632 deletions(-)

-- 
2.25.1

