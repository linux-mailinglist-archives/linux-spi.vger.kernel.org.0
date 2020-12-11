Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2922A2D8100
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405524AbgLKVSN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:18:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6350 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392453AbgLKVQy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:16:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3e19d0001>; Fri, 11 Dec 2020 13:16:13 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:16:09 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 21:16:08 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 3/9] MAINTAINERS: Add Tegra Quad SPI driver section
Date:   Fri, 11 Dec 2020 13:15:57 -0800
Message-ID: <1607721363-8879-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607721373; bh=eUmYkQtzsVe7hTNcXJ04Thtwwti9plDaDD83X+TMEaA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Yj+AlcVIZwF81TEjFtBWLapFiN+Yr0Ughlr4/QQtDGycx9HWrez1DzrQgHg7DUct2
         WcPijMNwSMYOYV4S4Wm6biJtUcINFcD/SbOYbrFGIevUOhcNbBKK5b5I18YyJnSl2l
         bEMkQPRzDILzkvhWyQKA5yjP7239BCHPbYnxVbdHPhu2Xh8J8EhZQNc9NQ4tOC0Kz8
         W/Yzyq5iF/nHasKkLerbSw0xjclpxhAfKi/yOIoE8lQ+nWPWQzu7iq+5pUgJsAsH1Z
         dB+gDt/eZ9FxL03eKKkzKUlJ6vfaK/UhLGsz71Z3dtDAfHQAAl0PGNrCIYz5yJnPts
         6ocjoQl9bYqGg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add maintainers and mailing list entries to Tegra Quad SPI driver
section.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b20bab..19db61f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17447,6 +17447,14 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/spi/spi-tegra*
 
+TEGRA QUAD SPI DRIVER
+M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Jonathan Hunter <jonathanh@nvidia.com>
+M:	Sowjanya Komatineni <skomatineni@nvidia.com>
+L:	linux-tegra@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-tegra210-quad.c
+
 TEGRA VIDEO DRIVER
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Jonathan Hunter <jonathanh@nvidia.com>
-- 
2.7.4

