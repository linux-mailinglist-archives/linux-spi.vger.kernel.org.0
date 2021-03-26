Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637AF34A7B3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Mar 2021 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCZNBI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Mar 2021 09:01:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39900 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCZNAt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Mar 2021 09:00:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0iAr030161;
        Fri, 26 Mar 2021 08:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616763644;
        bh=wdVkj8ZY/35/3+F5I4O+M+gGDqPcbAFAIRyCZQf9GSE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DQrwKWrhqah5y1GnoS6fLwZ9aeoZsB9gxRV9qWI3cw67uLs07rz4o8TQtr7H6IQ5r
         eyvZ0CPi8b6hLwFz4LZIQzgWsPhq0QLnMiEbYHufNME7IEfwFZn4UkfXBD1ouz0mqw
         u1JIXQt624wbIh/8DTfBZNdqQ6R4P3rbKPYmnQ24=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12QD0iwL098461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 08:00:44 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 08:00:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 08:00:44 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0Zvs029283;
        Fri, 26 Mar 2021 08:00:42 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j7200-mcu: Fix ospi compatible
Date:   Fri, 26 Mar 2021 18:30:32 +0530
Message-ID: <20210326130034.15231-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210326130034.15231-1-p.yadav@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The TI specific compatible should be followed by the generic
"cdns,qspi-nor" compatible.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5408ec815d58..2ab5a7a15bd5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -271,7 +271,7 @@ hbmc: hyperbus@47034000 {
 		};
 
 		ospi0: spi@47040000 {
-			compatible = "ti,am654-ospi";
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
 			      <0x5 0x00000000 0x1 0x0000000>;
 			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.30.0

