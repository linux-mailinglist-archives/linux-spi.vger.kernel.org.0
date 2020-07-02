Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E949E212614
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgGBOVK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 10:21:10 -0400
Received: from mail-db8eur05on2114.outbound.protection.outlook.com ([40.107.20.114]:22624
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729368AbgGBOVK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 10:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7gSMrg7/oTjSVgb5IjmDYooRYhxcFO8acfB8GHOoaMN+z613bYp0RBQp8D65VgYVo/sJhMDwD+9XKiLJmoEmz4D9AGvV+UUzGp9DktISUIEn2GZERcDNIY05oKUnkNwxWB8Aw23LeoA0IaIbXHpLLRImfyTAdOpveuKwpEOdfGfn0tviX27hN3WNTeuG7hPyC6rcYiXYk6UrGeVAUbcOBodnMCQvkCCSAYXaUBN5OXeG8KeP/V1ItBSM4dReDzX0eyTAHYCkynmmtVTQBVouyg0zKUHx/whjzTr5lBbnA+SXV5e41ru8zr+ob2VEFwGLIxfHrESeyWoGMk12LsDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUA+uvrbNt2BkmBPhmYcpgSQWKOVeHVn8JFAmGXSQx8=;
 b=OZMY1Loa47rfthukoKlewOdDUvgbN5BpWSWtRsq4gA2KS/UYXZgDqKCS/15TtnxmOAfXaQKDJ5woY90HYI/21cLHtSdGZK2TOBX29XbCHzGVxHbwMQXX+pbZnzVcctrbuni4Vfgz1JO26I9eHPRCoGCD2cDrCGrQQKpLft9L6UVfY91byuvUgFpO+JBowxeub66s72RAmcwgK7Xg+s/ESUgjtKbIP8QiaKRL+wj6CO2RJuWkNTZOQC7QKPiKyw9fqaS0jXPfRxEeFOfjlv9H0RODwCssZs7P82NIGdqtrD9IEq2hP3j265BeAnJ6kgKyXBjY40/p2px/SuImle9FGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUA+uvrbNt2BkmBPhmYcpgSQWKOVeHVn8JFAmGXSQx8=;
 b=Bo/yPIIJ5aes1beCIg7dCC3n6dI0R/eS9JkXP8xY79GgOuGfIyIZL29lZcQ1mjdDCylsixC0x3s2tWkqyKQKF9YekU966wz1qc2OPbPOhcmRdYjBH7Go+KmCwccrkycbzbj7goOa4MONbQBrsWIlCUBr9gpxB2+4A02UCD28bJ0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB6PR1001MB0981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 14:21:06 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:21:06 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: spidev: Add compatible for external SPI ports on Kontron boards
Date:   Thu,  2 Jul 2020 16:18:46 +0200
Message-Id: <20200702141846.7752-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (46.142.79.231) by AM0PR03CA0074.eurprd03.prod.outlook.com (2603:10a6:208:69::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 14:21:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1809c6-83a6-42e3-01e5-08d81e9328b3
X-MS-TrafficTypeDiagnostic: DB6PR1001MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR1001MB0981AE98739654F8B8F3F7D5E96D0@DB6PR1001MB0981.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhKWe/hVNMdYzsuEGrYksrfifxKQX8pFWnFBc67LruLhB6OAr01uKWGucl3a1NFTAgqiO6soThszMpuxlrg6o/844O2Jxt89pmzL9OXUMQ2wihUOlS4kB9kQGY/NiO1Ex+ZYFcxTHwPyay5GD69erb5VPhNTItIxjxZdnoJnSMl4O1umXXcxyB2pqcAfOMN8apGrqoqVWNjY/l6JVdMelQyCMPqDXrG897iusg8i31lQA5FP+prsuaQIlyQHEDUX/2IFAgLvWI74YEO221nYgaEnIR8OBJaRRU0eDoPAN+TDqoL1PKEj1OMd7RcfydSO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(316002)(66476007)(66946007)(956004)(4326008)(8676002)(8936002)(2906002)(186003)(52116002)(16526019)(6506007)(26005)(36756003)(478600001)(6512007)(6666004)(2616005)(66556008)(4744005)(6916009)(1076003)(6486002)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JyRh6HWdk3MhNAI4M4QwyAUBOwyCJju5VW+OOxHkd++XkWfp+HlHpHWqDLVUXFdRa9H1LUsYFPAuEyrrXxWIUM2svDUk9zF+hVmYvk/INfybK4kCiqviW9lFMBcAeXkDpqFpSGBzeMKfz+en+BLVLGlpuoesU7EVQPZWpWgLSIwzR+63UMC0efgUrfzZtCKlTJwZ5xaYqvngUABWqhyt57NKW84Do8LB0sXuZzToxwGKk/CZrswDF9Na0RanOlYIajcX+WjAwu/K128VcRA/QDN0vmMJjLuAiEyXZMhMJMSjNnjEhvG+JTAVOVw3RgpnWSnWPZjO/W2Ly5zbT2niFUuCYRrW/jVrxVm5z8uDlReo7RfUUwDT4Yo01FtyU3EIcMZWDj7d0NAjVnSBXoAq2svmBmvdBbU+Y6gNV7j3hlZaZa5OCch/0YncvaK3OKDhlJHWgRGozKzU21oPZiodVCJp0V96pt6+VdcN+4oP4gc=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1809c6-83a6-42e3-01e5-08d81e9328b3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:21:06.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jghMFJECcp+al5jTODdU9ZjlGnXhzFnKgrgxKd6fzddhe8lrnaaqmPDf+LbfPv9dBg0V7E0Gal/jQoQU4iuV2tf5gwYsB0RkzZXAP395rTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB0981
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Allow external SPI ports on Kontron boards to use the spidev driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 59e07675ef86..058b08a3767d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -677,6 +677,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lwn,bk4" },
 	{ .compatible = "dh,dhcom-board" },
 	{ .compatible = "menlo,m53cpld" },
+	{ .compatible = "kontron,user-spi" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.17.1

