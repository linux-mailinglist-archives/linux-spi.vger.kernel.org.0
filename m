Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2F2D7BF1
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbgLKRCe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:02:34 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3607 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392627AbgLKRC0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 12:02:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3a5ec0000>; Fri, 11 Dec 2020 09:01:32 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 17:01:32 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 17:01:31 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
Date:   Fri, 11 Dec 2020 09:01:18 -0800
Message-ID: <1607706088-1437-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607706092; bh=OdeajKJ0j5APS54go9aWji3Lx0upX2LRZePHgYW8yjo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=VtjhTy5sBr+eLvDjPh/PJSXP8TNRWaXT2TggkBVIMF28cxsk5lOxHdAF56eISv/0M
         oiZaH6FPQsH9roiPTsCv2gBoniHKMEF1DSi1BDOH3aC+pdJrHZ+QuNsMdlyQzimkjs
         S2h8KcCYgVMYkAKndMMOBKGpXhe2icp3rOfmTiF96aSf9N600LCVlUJgFbAgh7a7Jw
         ZtySQK/afP5wfE5Msw5A2hbUgmSe2eMQMWA9w4OWzv/pXF9jO7J303zebsS8PF7yv/
         a7LtXPCATg5Qex/5hpMgZ6y5GgVlE9NxhqRJio8eWlz5lrkRXYQTquIAtLFNclyXAH
         Q9ciBLN8pQDMw==
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

