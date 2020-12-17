Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A122DD9EF
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 21:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgLQU3i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 15:29:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19871 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbgLQU3h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 15:29:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbbf880002>; Thu, 17 Dec 2020 12:28:56 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 20:28:52 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Dec 2020 20:28:51 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
Date:   Thu, 17 Dec 2020 12:28:39 -0800
Message-ID: <1608236927-28701-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608236936; bh=F9YCDFK99FRDi3U+h+Ki2QV7a47qhYdA9LF7IjMqvCA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=cEc9sf8eG3pG/1HuY89VejviGNh2TFWqRPBQgYjvP0xEl4r7+7CkUfWg2SZ9aedhC
         ZPnCKwqx2pvPnxBta0ZT3wev0PHMTqxuKAKUvKBVC3qoDyOaejLeBjvLjHR9WI7Msm
         qcs/WBKr3CRXjBtEoOknnekmQdwljn9cptejY+RSywNBIJOlqpzmZVS1MZFvPS4bMw
         BmFJF5PGQboFOfvE7dh8wgmHtmjRWnHRCS1FKRXh56t5WQ6BUEgXrCkQTxqkBNmoZd
         H9Il+lEDrfRkggPNFVD5+52FNdfDz9qel0Z7aukAbhLVUaLBkceodpYW0hCDA6q1np
         zN9RcqLmL50Rw==
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

