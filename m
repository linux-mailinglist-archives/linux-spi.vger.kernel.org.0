Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E62E01EB
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 22:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgLUVSY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 16:18:24 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16126 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUVSX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 16:18:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe110f70000>; Mon, 21 Dec 2020 13:17:43 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Dec
 2020 21:17:39 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Dec 2020 21:17:38 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
Date:   Mon, 21 Dec 2020 13:17:31 -0800
Message-ID: <1608585459-17250-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608585463; bh=F9YCDFK99FRDi3U+h+Ki2QV7a47qhYdA9LF7IjMqvCA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=RqDH/TGsxp8qG6B1MDiJZLY6jOOX4N9o6vKMvevrWXcaoanCuKNeT2z5VqRUKXV5P
         hwvU2+qEmCJ7RuIdL6+bP5C2YR7Aea/diIo+71wGI23Q75q3XBtCjvLWsP9FdxbzhQ
         CAHPNJugkuNoQCMS1xYWwuYjArpXAT7L0F3u/eZQjSHH6DB42wElhs78Sev6ly+NvJ
         ZmBSE6o2XekUHi1Ayjlf7rJppzojTdrqjTWubuZbPKoHm6QhksYqjbilOzfPkAuvTp
         jFzUUXpNGAuKBS0BLenn8yC+Fy6RU3fESH4Ao2fdeC/r/xok8IPfRrE3A0Zp3ibH7k
         biYD1xms2G5vw==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra210 QSPI clock output has divider DIV2_SEL which will be enabled
when using DDR interface mode.

This patch adds clock ID for this to dt-binding.

Acked-by: Rob Herring <robh@kernel.org>
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

