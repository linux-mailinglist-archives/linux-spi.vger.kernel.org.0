Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43CE34A7B8
	for <lists+linux-spi@lfdr.de>; Fri, 26 Mar 2021 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCZNBJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Mar 2021 09:01:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57792 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhCZNAw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Mar 2021 09:00:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0m4H096913;
        Fri, 26 Mar 2021 08:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616763648;
        bh=uJF7BEVzYvkANaKH5TA5n8lEBNW1IRD8Vqtbcnim/nU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sW49hB071Onqe+bLsjtkFPd+RUotFt3VQ8qMSsrVm9ITEfYJziRjetoR88hXX5uGu
         wH5rhGnd/lO++SMN67zQT0goyDALAmCVH/8NmjoxLz9egJ9L5FSYZHYyT204/SnCER
         sQAMTWgeAW4NVkdIh4coAZmWbPhAIjreYgrnUe+Y=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12QD0mGj072464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 08:00:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 08:00:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 08:00:47 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0Zvt029283;
        Fri, 26 Mar 2021 08:00:45 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-am64-main: Fix ospi compatible
Date:   Fri, 26 Mar 2021 18:30:33 +0530
Message-ID: <20210326130034.15231-4-p.yadav@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index b997d13f9ec5..3cbdd33384a0 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -592,7 +592,7 @@ fss: bus@fc00000 {
 		ranges;
 
 		ospi0: spi@fc40000 {
-			compatible = "ti,am654-ospi";
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x00 0x0fc40000 0x00 0x100>,
 			      <0x05 0x00000000 0x01 0x00000000>;
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.30.0

