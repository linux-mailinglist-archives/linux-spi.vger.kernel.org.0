Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73973CD0EF
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhGSIwI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 04:52:08 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:49964 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234868AbhGSIwH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 04:52:07 -0400
X-UUID: 32c4bb74f73f46e491953d9ac8bdf1ad-20210719
X-UUID: 32c4bb74f73f46e491953d9ac8bdf1ad-20210719
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1110884393; Mon, 19 Jul 2021 17:32:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Jul 2021 17:32:41 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 17:32:41 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 2/3] spi: modify set_cs_timing parameter
Date:   Mon, 19 Jul 2021 17:16:43 +0800
Message-ID: <20210719091642.24633-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

No need pass in spi_delay to set_cs_timing callback.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 include/linux/spi/spi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 651e19ba3415..fe027efb85c2 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -553,8 +553,7 @@ struct spi_controller {
 	 * to configure specific CS timing through spi_set_cs_timing() after
 	 * spi_setup().
 	 */
-	int (*set_cs_timing)(struct spi_device *spi, struct spi_delay *setup,
-			     struct spi_delay *hold, struct spi_delay *inactive);
+	int (*set_cs_timing)(struct spi_device *spi);
 
 	/* bidirectional bulk transfers
 	 *
-- 
2.18.0

