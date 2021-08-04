Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121373E0274
	for <lists+linux-spi@lfdr.de>; Wed,  4 Aug 2021 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhHDNxw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Aug 2021 09:53:52 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52064 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236956AbhHDNxw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Aug 2021 09:53:52 -0400
X-UUID: f76cc7f8ef814dfe83c9cbfcd8ffcbbe-20210804
X-UUID: f76cc7f8ef814dfe83c9cbfcd8ffcbbe-20210804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 90024289; Wed, 04 Aug 2021 21:53:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 Aug 2021 21:53:33 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Aug 2021 21:53:27 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH v3 0/2] spi cs_timing restructure
Date:   Wed, 4 Aug 2021 21:36:31 +0800
Message-ID: <20210804133630.18519-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,
This patchset has restructure spi cs_timing, as we know spi core has
removed spi_set_cs_timing() API, it is a correct decision because it
asked spi devices to call it in one more time.
so we need find another way to support user set cs_timing. Actually,
spi_device set spi_delay for cs_timing is enough, and about how to
set cs_timing, just put it one the master driver.
We have test this patch in mediatek platform, it can compeletly meets
our needs.

Changed in v2:
  - fix tegra spi build err

Changed in v3:
  - merged patch2/3/4 for build pass

Mason Zhang (2):
  spi: move cs spi_delay to spi_device
  spi: modify set_cs_timing parameter

 drivers/spi/spi-mt65xx.c   | 107 +++++++++++++++++++++----------------
 drivers/spi/spi-tegra114.c |   8 +--
 drivers/spi/spi.c          |   6 +--
 include/linux/spi/spi.h    |  23 ++++----
 4 files changed, 78 insertions(+), 66 deletions(-)

-- 
2.18.0

