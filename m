Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC78D3DEB12
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhHCKjd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 06:39:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44972 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234913AbhHCKja (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 06:39:30 -0400
X-UUID: 7b4888f653c74c189dee791da5555021-20210803
X-UUID: 7b4888f653c74c189dee791da5555021-20210803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 665165894; Tue, 03 Aug 2021 18:39:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 18:39:15 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 18:39:14 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH v2 0/4] *** spi cs_timing restructure ***
Date:   Tue, 3 Aug 2021 18:22:29 +0800
Message-ID: <20210803102228.2535-1-Mason.Zhang@mediatek.com>
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

Mason Zhang (4):
  spi: move cs spi_delay to spi_device
  spi: modify set_cs_timing parameter
  spi: mediatek: modify set_cs_timing callback
  spi: tegra114: Fix set_cs_timing param

 drivers/spi/spi-mt65xx.c   | 102 ++++++++++++++++++++-----------------
 drivers/spi/spi-tegra114.c |   8 +--
 drivers/spi/spi.c          |   6 +--
 include/linux/spi/spi.h    |  23 ++++-----
 4 files changed, 73 insertions(+), 66 deletions(-)

-- 
2.18.0

