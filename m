Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4173E376FEE
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 08:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhEHGDg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 May 2021 02:03:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28806 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229473AbhEHGDg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 May 2021 02:03:36 -0400
X-UUID: 943db313235c48f4ab6d6ade246fc35c-20210508
X-UUID: 943db313235c48f4ab6d6ade246fc35c-20210508
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1994536755; Sat, 08 May 2021 14:02:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 May 2021 14:02:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 May 2021 14:02:19 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH] spi: take the SPI IO-mutex in the spi_set_cs_timing method
Date:   Sat, 8 May 2021 14:02:14 +0800
Message-ID: <20210508060214.1485-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BC75931E69A775349CBFFC250E38064680A523688CABCE0898A061ACCED4A45F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

this patch takes the io_mutex to prevent an unprotected HW
register modification in the set_cs_timing callback.

Fixes: 4cea6b8cc34e ("spi: add power control when set_cs_timing")
Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2350d131871b..6bda471b9621 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3459,9 +3459,12 @@ int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
 
 	if (spi->controller->set_cs_timing &&
 	    !(spi->cs_gpiod || gpio_is_valid(spi->cs_gpio))) {
+		mutex_lock(&spi->controller->io_mutex);
+
 		if (spi->controller->auto_runtime_pm) {
 			status = pm_runtime_get_sync(parent);
 			if (status < 0) {
+				mutex_unlock(&spi->controller->io_mutex);
 				pm_runtime_put_noidle(parent);
 				dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 					status);
@@ -3472,11 +3475,13 @@ int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
 								hold, inactive);
 			pm_runtime_mark_last_busy(parent);
 			pm_runtime_put_autosuspend(parent);
-			return status;
 		} else {
-			return spi->controller->set_cs_timing(spi, setup, hold,
+			status = spi->controller->set_cs_timing(spi, setup, hold,
 							      inactive);
 		}
+
+		mutex_unlock(&spi->controller->io_mutex);
+		return status;
 	}
 
 	if ((setup && setup->unit == SPI_DELAY_UNIT_SCK) ||
-- 
2.18.0

