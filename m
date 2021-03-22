Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F93438D2
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 06:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCVFxv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 01:53:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26641 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229613AbhCVFxP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 01:53:15 -0400
X-UUID: 6be182126f2945a3bac758b908c7ef16-20210322
X-UUID: 6be182126f2945a3bac758b908c7ef16-20210322
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 856504822; Mon, 22 Mar 2021 13:53:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 13:53:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 13:53:05 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 2/4] spi: update spi slave bindings for MT8195 SoC
Date:   Mon, 22 Mar 2021 13:52:42 +0800
Message-ID: <20210322055244.30179-3-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210322055244.30179-1-leilk.liu@mediatek.com>
References: <20210322055244.30179-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9F79E37BABE1F44B1C4A109126999E2848C35006EB447B3433E3E6030C2D2E6A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a DT binding documentation for the MT8195 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
index c37e5a179b21..9192724540fd 100644
--- a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
@@ -3,6 +3,7 @@ Binding for MTK SPI Slave controller
 Required properties:
 - compatible: should be one of the following.
     - mediatek,mt2712-spi-slave: for mt2712 platforms
+    - mediatek,mt8195-spi-slave: for mt8195 platforms
 - reg: Address and length of the register set for the device.
 - interrupts: Should contain spi interrupt.
 - clocks: phandles to input clocks.
-- 
2.18.0

