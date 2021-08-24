Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0773F5C41
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhHXKls (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:48 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:27028 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236339AbhHXKlr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:47 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9oMhS012561;
        Tue, 24 Aug 2021 05:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fuZSZI0E9hsp3UbqkpcQChizV3YjsSgucAX1LgLnmlk=;
 b=dV9JsRCmzgPMXCvQEtpqXzU92Lw5tPK45Xqqz/Gpv4OWo9zczZTH4STD+eWiRE5Ky+Uw
 cxEKlQz97IMi67CY7Fh3B3tQfvlztFsfaQ+ICQK1yLqaDau/gtWc01klDJtd1+FzMjcO
 DjpxyQmiuv48kd19Plcn/niOPZ3UoebfnRiKftdbsZ+8OvRFX2hn+y4SExaNSvdt8LSF
 Y6Zcdbj+8XUDHyFii/TFI8TdbWQTnLHhXnpWU9c0nsNH/hjZaQ2pirX942XdADG6h8qX
 VauVN4Cx4MF7pQjPBdb0sUzqLmTFl31O/vGoAfXRx6hBhEYEtnpiQzcoZGsVHazBFy6q 8Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3amxg601k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:00 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:40:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:40:59 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 688622A9;
        Tue, 24 Aug 2021 10:40:55 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 2/9] spi: core: Add flag for controllers that can't hold cs between transfers
Date:   Tue, 24 Aug 2021 11:40:34 +0100
Message-ID: <20210824104041.708945-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mSnUtxGavguZ3TD4NprwGcOxygIMaVnV
X-Proofpoint-ORIG-GUID: mSnUtxGavguZ3TD4NprwGcOxygIMaVnV
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Create a flag for a controller that has an automatic cs selection and
can't hold cs activated between transfers
Some messages send address and data split between two transfers, see
regmap-spi, and without the cs held the data loses it`s meaning

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/linux/spi/spi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8371bca13729..f5b55c237634 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -514,6 +514,7 @@ struct spi_controller {
 #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* requires tx */
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
+#define SPI_CONTROLLER_CS_PER_TRANSFER	BIT(6)	/* SPI controller can not hold CS between transfers */
 
 	/* flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
-- 
2.33.0

