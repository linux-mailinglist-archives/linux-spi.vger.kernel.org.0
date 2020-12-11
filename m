Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA32D7BED
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbgLKRCe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:02:34 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2194 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392655AbgLKRC0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 12:02:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3a5ee0000>; Fri, 11 Dec 2020 09:01:34 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 17:01:33 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 17:01:33 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/9] MAINTAINERS: Add Tegra QSPI driver section
Date:   Fri, 11 Dec 2020 09:01:21 -0800
Message-ID: <1607706088-1437-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607706094; bh=gvQPuurNzDxDGiAB5l6R+Y1W50ta6X1urZfiBvpyNpQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Syfd5xgyMYBaxG7YgQyPOTOqGQGEID5MJHSr8xT3f1kXYkBEV1ChFiiYgu9wxpMAp
         9QwdHHdx+7fQauj0RZRHEbNb5AM5QVygi2bvg6PZK4fiCEU+DDyRDejEnK8UYGuDS1
         0ek7M9b13PbGQJCl0NEgvdsDGuGj66d7lxBzZgrdLK6tAwfWzYOJL4sIpPn5GOGPcY
         85i2QCiJ2qAqFdu/KYCC/kKE3FbYVs7XdnUVQbzxpMd1YXGsZv428RJFy6xnQ7SHy3
         3gIX/vmWQrI8jDpRbG5VuLxDIAsdWsooOenYxS1T52KrcP1Wt8BFtf/5zG0FDhKN5i
         gGpS0cq1LsvGg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add maintainers and mailing list entries to Tegra QSPI driver section.

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

