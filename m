Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642DA2CAE29
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 22:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbgLAVNf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 16:13:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6354 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbgLAVNd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:33 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d50001>; Tue, 01 Dec 2020 13:12:53 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:53 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:52 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 4/7] spi: qspi-tegra: Add Tegra186 and Tegra194 QSPI compatibles
Date:   Tue, 1 Dec 2020 13:12:45 -0800
Message-ID: <1606857168-5839-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857173; bh=Loe9QPMhk0KGgbjrVBR7meQJwypMNtf2yYtQtw/Xh80=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=ryoAe0ZRd+OkVgdmKj7v3qPw4zyF08Tldro4Js1DQ+L85u0EEqJRK3/jF3p1lL9jH
         bRyB5DEGJMRHWKhVpgjB6i/fnxBAiOPP5I79ilM9zmD78GWD4SdzwfvpPVTvyMnlq7
         eOSjIsMcFVbDjZwY7qqn0J7nJ/rfpaT8iAqOEWhxAwKBWL/fv2r3FKL9tUOSgIzVEc
         mKYRLLsIAev294swxtGwrYW5WckSb1wOBfkg7Mr1UiL6UFZmnMlR0Oej3rMKLu8/si
         sglAVmzqfo3jLWvZabdjYdaJELoxaZKs5ySckx7GPENZuzohVhngGAf7gCck2d9IzO
         Hf/zj6fg7vjvg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

QSPI controller on Tegra186 and Tegra194 is similar to Tegra210
QSPI controller in terms of transferring command, address and data
in multiple transfers.

This patch adds Tegra186 and Tegra194 compatibles to QSPI driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/qspi-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/qspi-tegra.c b/drivers/spi/qspi-tegra.c
index 67a8b44..cd6a3c3 100644
--- a/drivers/spi/qspi-tegra.c
+++ b/drivers/spi/qspi-tegra.c
@@ -1181,6 +1181,8 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 
 static const struct of_device_id tegra_qspi_of_match[] = {
 	{ .compatible = "nvidia,tegra210-qspi", },
+	{ .compatible = "nvidia,tegra186-qspi", },
+	{ .compatible = "nvidia,tegra194-qspi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_qspi_of_match);
-- 
2.7.4

