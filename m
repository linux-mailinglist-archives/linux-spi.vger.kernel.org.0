Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E248E34A7B4
	for <lists+linux-spi@lfdr.de>; Fri, 26 Mar 2021 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCZNBI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Mar 2021 09:01:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39898 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZNAt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Mar 2021 09:00:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0fbw030117;
        Fri, 26 Mar 2021 08:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616763641;
        bh=XdWH7/gUcza2XjnEOLD6AfcHxmK2gQARPwTy9oB36T4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oAXtwrwSKVcq5OxRYMv+X0I+g1KMo7PvqJiJBZuSlusKJk6vlbK88jfwIW5mY8n+2
         Ns0YmWEXC0viJdz/eC0Als9EO+tgrB63+Cb4jpqHyzBZ4iX4kx6LujCMJbDK61whEt
         cGciiLnkTFsHVnjK/N1njTFrTOonOhtgk5aVHuMw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12QD0fRJ098366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 08:00:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 08:00:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 08:00:41 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0Zvr029283;
        Fri, 26 Mar 2021 08:00:38 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j721e-mcu: Fix ospi compatible
Date:   Fri, 26 Mar 2021 18:30:31 +0530
Message-ID: <20210326130034.15231-2-p.yadav@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 6c44afae9187..d56e3475aee7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -180,7 +180,7 @@ fss: fss@47000000 {
 		ranges;
 
 		ospi0: spi@47040000 {
-			compatible = "ti,am654-ospi";
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
 				<0x5 0x00000000 0x1 0x0000000>;
 			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
@@ -197,7 +197,7 @@ ospi0: spi@47040000 {
 		};
 
 		ospi1: spi@47050000 {
-			compatible = "ti,am654-ospi";
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47050000 0x0 0x100>,
 				<0x7 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.30.0

