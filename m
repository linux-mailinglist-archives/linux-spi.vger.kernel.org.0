Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752A84038D7
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbhIHLgM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:12 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:65068 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349173AbhIHLgG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:06 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188696pE006454;
        Wed, 8 Sep 2021 06:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=66kIxK3yveLicWslQIjzVDIWEYFHtDg1+tr0+IgstQg=;
 b=ekPTrM2yDfL72iP8xZFEgmkh2edRm5fB7PBI37QOFg+h6GNpPe44TLKoN+ec/ewQqBYB
 oglxrMCS714ZxYYofi0oFUeuAxug0OuYoHvgnBHRHZxiddty6nVxj0t8vXzPb75QdXM+
 e5W7OTdtDwQevaLTrXH29xFeYOJugd0qVDkMFrjsG+dHz3mWlKy7rWMUwtXiKIbQbK7a
 hKRqbekN0/oQYEfu2aHW28rWaSHoFpzFS2t6lxFmBbiXY2S5J86RlRQjpm7m+PCOtbsg
 zCa1T6go+llsMo2P0plue6yjpfsxMNpcMymPfeSo4WKZn6NVpQEYKQMVaX4Cym+5Sgxz HQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:54 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 659332BA;
        Wed,  8 Sep 2021 11:34:54 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 03/10] spi: Add flag for no TX after a RX in the same Chip Select
Date:   Wed, 8 Sep 2021 12:34:44 +0100
Message-ID: <20210908113450.788452-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WkrK2ww5DjFe4JrzJP0-1nokYJs-jDAo
X-Proofpoint-ORIG-GUID: WkrK2ww5DjFe4JrzJP0-1nokYJs-jDAo
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some controllers can't write to the bus after a read without
releasing the chip select, so add flag and a check in spi core

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi.c       | 11 +++++++++++
 include/linux/spi/spi.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 65d14af9c015..1dbc8b6f1398 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3724,6 +3724,17 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 			return -EINVAL;
 	}
 
+	if (ctlr->flags & SPI_CONTROLLER_NO_TX_RX_CS) {
+		bool read = false;
+
+		list_for_each_entry(xfer, &message->transfers, transfer_list) {
+			if (read && xfer->tx_buf)
+				return -EINVAL;
+			if (xfer->rx_buf && !xfer->cs_change)
+				read = true;
+		}
+	}
+
 	message->status = -EINPROGRESS;
 
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8371bca13729..916b982dc2a1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -514,6 +514,7 @@ struct spi_controller {
 #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* requires tx */
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
+#define SPI_CONTROLLER_NO_TX_RX_CS	BIT(6)	/* can't write after a read in the same CS */
 
 	/* flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
-- 
2.33.0

