Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34353AE78F
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFUKuZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 06:50:25 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:40890 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFUKuZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 06:50:25 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 21F33C8582;
        Mon, 21 Jun 2021 18:48:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24132T140365807994624S1624272484357256_;
        Mon, 21 Jun 2021 18:48:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c430b102b16aa2053d2b4fea293745ca>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 2/6] spi: rockchip: add compatible string for rv1126
Date:   Mon, 21 Jun 2021 18:47:56 +0800
Message-Id: <20210621104800.19088-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621104800.19088-1-jon.lin@rock-chips.com>
References: <20210621104800.19088-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for rv1126 for potential applications.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 52d6259d96ed..bbeed3ae4ee1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -922,6 +922,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
 	{ .compatible = "rockchip,rv1108-spi", },
+	{ .compatible = "rockchip,rv1126-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
2.17.1



