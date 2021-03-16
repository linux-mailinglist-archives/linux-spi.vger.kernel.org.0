Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C03E33CF1D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCPIAn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 04:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhCPIAT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 04:00:19 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DCC06174A
        for <linux-spi@vger.kernel.org>; Tue, 16 Mar 2021 01:00:19 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F05LR2H3pz1sHq1
        for <linux-spi@vger.kernel.org>; Tue, 16 Mar 2021 09:00:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F05LR2963z1qqkj
        for <linux-spi@vger.kernel.org>; Tue, 16 Mar 2021 09:00:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id omHL9uTuuRMy for <linux-spi@vger.kernel.org>;
        Tue, 16 Mar 2021 09:00:14 +0100 (CET)
X-Auth-Info: iZKcPLXD4Ew6d9arXZSGGVlwjhrKXVgZOQBodaZ1jgI=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-spi@vger.kernel.org>; Tue, 16 Mar 2021 09:00:14 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 5F04918531D;
        Tue, 16 Mar 2021 08:59:31 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 546D61A0092; Tue, 16 Mar 2021 08:59:31 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: fspi: enable fspi driver for on imx8mp
Date:   Tue, 16 Mar 2021 08:59:27 +0100
Message-Id: <20210316075928.1763460-2-hs@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316075928.1763460-1-hs@denx.de>
References: <20210316075928.1763460-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

add compatible entry in nxp_fspi driver for imx8mp.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v4:
rebased against:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
a43e89624baea ("Merge remote-tracking branch 'spi/for-5.13' into spi-next")

Changes in v3:
- seperate spi changes from series:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643289.html
  into own series as Kuldeep suggested and rebased against
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
  144c79ef33536 ("Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")

Changes in v2:
- work in comments from Marco
  add own compatible entry for imx8mp

 drivers/spi/spi-nxp-fspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index ed1e888c7ece4..6e6c2403944dd 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1242,6 +1242,7 @@ static int nxp_fspi_resume(struct device *dev)
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
+	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
 	{ /* sentinel */ }
-- 
2.29.2

