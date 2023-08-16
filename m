Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED477DD88
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbjHPJnf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbjHPJnZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CC13E
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:23 -0700 (PDT)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQjmR4H0bzFqd0;
        Wed, 16 Aug 2023 17:40:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 00/24] spi: switch to use modern name (part4)
Date:   Wed, 16 Aug 2023 17:39:49 +0800
Message-ID: <20230816094013.1275068-1-yangyingliang@huawei.com>
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

Yang Yingliang (24):
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
  spi: rpc-if: switch to use devm_spi_alloc_host()
  spi: rspi: switch to use modern name
  spi: rzv2m-csi: switch to use modern name
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
 drivers/spi/spi-pic32.c        | 158 +++++++++++++++----------------
 drivers/spi/spi-pl022.c        |  96 +++++++++----------
 drivers/spi/spi-ppc4xx.c       |  44 ++++-----
 drivers/spi/spi-pxa2xx.c       |  24 ++---
 drivers/spi/spi-qcom-qspi.c    |  80 ++++++++--------
 drivers/spi/spi-qup.c          | 166 ++++++++++++++++-----------------
 drivers/spi/spi-rb4xx.c        |  36 +++----
 drivers/spi/spi-realtek-rtl.c  |   2 +-
 drivers/spi/spi-rockchip-sfc.c |  34 +++----
 drivers/spi/spi-rockchip.c     |  58 ++++++------
 drivers/spi/spi-rpc-if.c       |   2 +-
 drivers/spi/spi-rspi.c         |  10 +-
 drivers/spi/spi-rzv2m-csi.c    |  10 +-
 drivers/spi/spi-s3c64xx.c      | 130 +++++++++++++-------------
 drivers/spi/spi-sc18is602.c    |  50 +++++-----
 drivers/spi/spi-sh-hspi.c      |   6 +-
 drivers/spi/spi-sh-msiof.c     |  54 +++++------
 drivers/spi/spi-sh-sci.c       |  24 ++---
 drivers/spi/spi-sh.c           |  34 +++----
 drivers/spi/spi-sifive.c       |  82 ++++++++--------
 drivers/spi/spi-sn-f-ospi.c    |   4 +-
 include/linux/spi/pxa2xx_spi.h |   4 +-
 include/linux/spi/sh_msiof.h   |   4 +-
 26 files changed, 651 insertions(+), 651 deletions(-)

-- 
2.25.1

