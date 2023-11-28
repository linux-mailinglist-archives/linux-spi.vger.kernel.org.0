Return-Path: <linux-spi+bounces-53-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE937FB5A3
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF6282625
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E5487B9;
	Tue, 28 Nov 2023 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41635E1
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:22 -0800 (PST)
Received: from dggpemm100019.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SfcWc6nfVzvRGj;
	Tue, 28 Nov 2023 17:25:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100019.china.huawei.com (7.185.36.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:19 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 00/26] spi: switch to use modern name (part5)
Date: Tue, 28 Nov 2023 17:30:05 +0800
Message-ID: <20231128093031.3707034-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

I'm trying to rename the legacy name to modern name used in SPI drivers,
this is part5 patchset.

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. Each patch compile test passed.

Yang Yingliang (26):
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
  spi: cs42l43: switch to use devm_spi_alloc_host()
  spi: ljca: switch to use devm_spi_alloc_host()

 drivers/spi/spi-cs42l43.c        |   2 +-
 drivers/spi/spi-geni-qcom.c      |  96 ++++++-------
 drivers/spi/spi-ljca.c           |   2 +-
 drivers/spi/spi-sprd-adi.c       |   2 +-
 drivers/spi/spi-sprd.c           |   4 +-
 drivers/spi/spi-st-ssc4.c        |  70 +++++-----
 drivers/spi/spi-stm32-qspi.c     |  18 +--
 drivers/spi/spi-stm32.c          |  40 +++---
 drivers/spi/spi-sun4i.c          |  72 +++++-----
 drivers/spi/spi-sun6i.c          | 148 ++++++++++----------
 drivers/spi/spi-sunplus-sp7021.c |  88 ++++++------
 drivers/spi/spi-synquacer.c      |  82 +++++------
 drivers/spi/spi-tegra114.c       | 118 ++++++++--------
 drivers/spi/spi-tegra20-sflash.c |  76 +++++------
 drivers/spi/spi-tegra20-slink.c  |  98 +++++++-------
 drivers/spi/spi-tegra210-quad.c  |  80 +++++------
 drivers/spi/spi-ti-qspi.c        |  88 ++++++------
 drivers/spi/spi-topcliff-pch.c   | 226 +++++++++++++++----------------
 drivers/spi/spi-uniphier.c       | 194 +++++++++++++-------------
 drivers/spi/spi-wpcm-fiu.c       |   2 +-
 drivers/spi/spi-xcomm.c          |  32 ++---
 drivers/spi/spi-xilinx.c         |  58 ++++----
 drivers/spi/spi-xlp.c            |  40 +++---
 drivers/spi/spi-xtensa-xtfpga.c  |  30 ++--
 drivers/spi/spi-zynq-qspi.c      |  28 ++--
 drivers/spi/spi-zynqmp-gqspi.c   |  50 +++----
 26 files changed, 872 insertions(+), 872 deletions(-)

-- 
2.25.1


