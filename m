Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA75E1CD3EC
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEKIaq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 04:30:46 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:58640 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgEKIao (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 04:30:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 3159D2005E73;
        Mon, 11 May 2020 16:30:42 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id li1WDHJHoWxu; Mon, 11 May 2020 16:30:42 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 161AB20020CB;
        Mon, 11 May 2020 16:30:42 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 12A7CC01F94;
        Mon, 11 May 2020 16:30:42 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 0D5D32001DE; Mon, 11 May 2020 16:30:42 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jack Lo <jack.lo@gtsys.com.hk>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] spi: spi-rockchip: use num-cs property and ctlr->enable_gpiods
Date:   Mon, 11 May 2020 16:30:22 +0800
Message-Id: <20200511083022.23678-4-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511083022.23678-1-chris.ruehl@gtsys.com.hk>
References: <20200511083022.23678-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The original implementation set num_chipselect to ROCKCHIP_SPI_MAX_CS_NUM (2)
which seems wrong here. spi0 has 2 native cs, all others just one. With
enable and use of cs_gpiods / GPIO CS, its correct to set the num_chipselect
from the num-cs property and set max_native_cs with the define.
If num-cs is missing the default set to num_chipselect = 1.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/spi/spi-rockchip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index f57a8faa6f31..9b8a5e1233c0 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -708,8 +708,15 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		ctlr->slave_abort = rockchip_spi_slave_abort;
 	} else {
 		ctlr->flags = SPI_MASTER_GPIO_SS;
+		ctlr->max_native_cs = ROCKCHIP_SPI_MAX_CS_NUM;
+		/*
+		 * rk spi0 has two native cs, spi1..5 one cs only
+		 * if num-cs is missing in the dts, default to 1
+		 */
+		if (of_property_read_u16(np, "num-cs", &ctlr->num_chipselect))
+			ctlr->num_chipselect = 1;
+		ctlr->use_gpio_descriptors = true;
 	}
-	ctlr->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
 	ctlr->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
-- 
2.20.1

