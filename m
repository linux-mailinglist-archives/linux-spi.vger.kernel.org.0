Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4EF3438D5
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 06:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCVFxu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 01:53:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6234 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229866AbhCVFxP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 01:53:15 -0400
X-UUID: df1682e43fff4e9fad3c293485fe2665-20210322
X-UUID: df1682e43fff4e9fad3c293485fe2665-20210322
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 56765223; Mon, 22 Mar 2021 13:53:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 13:53:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 13:53:04 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 1/4] spi: update spi master bindings for MT8195 SoC
Date:   Mon, 22 Mar 2021 13:52:41 +0800
Message-ID: <20210322055244.30179-2-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210322055244.30179-1-leilk.liu@mediatek.com>
References: <20210322055244.30179-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1AE6737A00D13FA30C1AF666ACECCA53224FDDC1BEDF3E087571B5E5460E21FF2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a DT binding documentation for the MT8195 soc.

Signed-off-by: leilk.liu <leilk.liu@mediatek.com>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 7bae7eef26c7..4d0e4c15c4ea 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -12,6 +12,7 @@ Required properties:
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
     - "mediatek,mt8192-spi", "mediatek,mt6765-spi": for mt8192 platforms
+    - "mediatek,mt8195-spi", "mediatek,mt6765-spi": for mt8195 platforms
     - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
     - "mediatek,mt6779-spi", "mediatek,mt6765-spi": for mt6779 platforms
 
-- 
2.18.0

