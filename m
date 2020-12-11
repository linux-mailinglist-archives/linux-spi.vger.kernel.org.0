Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09A2D80E5
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbgLKVRE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:17:04 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6329 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbgLKVQt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:16:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3e1980000>; Fri, 11 Dec 2020 13:16:08 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:16:07 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 21:16:07 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
Date:   Fri, 11 Dec 2020 13:15:55 -0800
Message-ID: <1607721363-8879-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607721368; bh=OdeajKJ0j5APS54go9aWji3Lx0upX2LRZePHgYW8yjo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Xlp1CCndJzOsTCWlN01H3OnNbbWNBfthxsyOG5K6N52EHqW//6FkihnooyqFoLfb2
         nT3bsn5uSPDO1Tjh6qDXQ6XoUkRXAy7kFNWFHCm19Xt4perQO5ZZXuz3NB68D0eG5S
         vRcH2dfa6CzIbMQWuQt9hxKlnHW9T9Ljx2uzrBFvjU7+9ti7lHS0SapZHCc6DaegKw
         CiaGQmBXqDbfux+YmgzGuO3V5q1k67AXTrtfa9p7a7jZQRYPbpUby6gdT/E7lYmVVk
         FiJKGvjdOq+vLOn3YyOJ0FPt5v9VLKYt7yTCzjIny31msaXls/O32lNFtejS8kDC2R
         gFjSI18aBmgQQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra210 QSPI clock output has divider DIV2_SEL which will be enabled
when using DDR interface mode.

This patch adds clock ID for this to dt-binding.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra210-car.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index ab8b8a7..9cfcc3b 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -307,7 +307,7 @@
 #define TEGRA210_CLK_AUDIO4 275
 #define TEGRA210_CLK_SPDIF 276
 /* 277 */
-/* 278 */
+#define TEGRA210_CLK_QSPI_PM 278
 /* 279 */
 /* 280 */
 #define TEGRA210_CLK_SOR0_LVDS 281 /* deprecated */
-- 
2.7.4

