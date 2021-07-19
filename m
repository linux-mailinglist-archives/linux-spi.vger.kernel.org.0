Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D3A3CD0E5
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhGSIvJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 04:51:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48534 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235034AbhGSIvI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 04:51:08 -0400
X-UUID: 3fdce7f326874a4bbde4557511350698-20210719
X-UUID: 3fdce7f326874a4bbde4557511350698-20210719
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 637131729; Mon, 19 Jul 2021 17:31:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Jul 2021 17:31:44 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 17:31:43 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 0/3] *** spi cs_timing restructure ***
Date:   Mon, 19 Jul 2021 17:15:26 +0800
Message-ID: <20210719091525.1453-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

Hello,
This patchset has restructure spi cs_timing, as we know spi core has
removed spi_set_cs_timing() API, it is a correct decision because it
asked spi devices to call it in one more time.
so we need find another way to support user set cs_timing. Actually,
spi_device set spi_delay for cs_timing is enough, and about how to
set cs_timing, just put it one the master driver.
We have test this patch in mediatek platform, it can compeletly meets
our needs.

Mason Zhang (3):
  spi: move cs spi_delay to spi_device
  spi: modify set_cs_timing parameter
  spi: mediatek: modify set_cs_timing callback

 drivers/spi/spi-mt65xx.c | 102 +++++++++++++++++++++------------------
 drivers/spi/spi.c        |   6 +--
 include/linux/spi/spi.h  |  23 ++++-----
 3 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.18.0

