Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB359EA3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2019 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfF1PTD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jun 2019 11:19:03 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55538 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbfF1PTC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jun 2019 11:19:02 -0400
X-Greylist: delayed 10110 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 11:19:01 EDT
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SCS8mD025966;
        Fri, 28 Jun 2019 08:30:20 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2052.outbound.protection.outlook.com [104.47.48.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tdasvh9yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 08:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=tUmkv5XEQ1AaiIqU6cn1k5wEitm0dHMOHpH+glijM5CLlka5W6zCN4SCINAxctQtL6H9v2VUw/B2LyXYzw+WZiZulJxknz5rtP9z+uJrTugXKNxtDqFP6HJ6w1zsFr76VK0qp4FoLQN+cxHx8+VHSzDDgQt8KOyHLEzet5Jbc3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRn7T/55qU1uKDWRES7M0wi6sof63Ze/Idsd+VAxxm8=;
 b=qCAtlDRoXtk/xQ0/fMXs5oaTgjzowTFGxFLLNZj4Xi/cI8txoaVNWrowFvnIFTLHexi1jNgFk1x7/JAyX9Ok00YPjz+McYuXHGNY9e062Neju5lnPOXF+7UBme2CyUR5cIFAecvMEYa200SnUXQC6SQz0CcoZJEZ1TEh6yVX00M=
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRn7T/55qU1uKDWRES7M0wi6sof63Ze/Idsd+VAxxm8=;
 b=Mid3C5b/Bs6acKnBlB9HCEwtiWaw7Ww1WFL1hCNYgr5NnlHiN3OoitAtMQXqReB+9JN7ZT0S8GVWq4FhxQ2pzuiWu+yrIUcNyq1P6auumBo+UuzTIMGFc0UZ52HorKBWMoc3CAnzyDVaWmGi8CdJegKpoYo7b1pLb9oYzAB8Fho=
Received: from DM3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:0:50::22) by
 BN7PR03MB3506.namprd03.prod.outlook.com (2603:10b6:406:c2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 12:30:17 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM3PR03CA0012.outlook.office365.com
 (2603:10b6:0:50::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.17 via Frontend
 Transport; Fri, 28 Jun 2019 12:30:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Fri, 28 Jun 2019 12:30:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5SCUGMV025536
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 28 Jun 2019 05:30:16 -0700
Received: from nsa.ad.analog.com (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 28 Jun
 2019 08:30:15 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <broonie@kernel.org>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Date:   Fri, 28 Jun 2019 14:30:23 +0200
Message-ID: <20190628123023.4696-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(199004)(189003)(70206006)(7636002)(7736002)(70586007)(110136005)(54906003)(2201001)(2616005)(316002)(2906002)(486006)(126002)(476003)(50466002)(305945005)(86362001)(47776003)(426003)(336012)(7696005)(356004)(6666004)(5820100001)(23676004)(1076003)(246002)(966005)(4326008)(36756003)(5660300002)(8936002)(8676002)(16526019)(186003)(478600001)(77096007)(7416002)(2870700001)(3846002)(106002)(6116002)(50226002)(6306002)(72206003)(45776006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3506;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e46d08e-f1c8-4382-5484-08d6fbc4601f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN7PR03MB3506;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3506:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN7PR03MB3506F9C580C3F3741244EB6D99FC0@BN7PR03MB3506.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 00826B6158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Mrsz+ndzEtD1SS4tOD0vciCwg7EsnOkWTHrlYGcR5VLVpzMOyICdm+exHRW36vLW2RJW+C7g0JymUsHSLIQ+h8/+WbdvruAMltONewXT247xH5TTZQiqNDA5XymbuahMmZkIK0YeQ3Z8rtIMHSYdt4HCUek1k98vSoBTWi29bMNSsxRLCc2OTpWKFW6H27gQL8ptYZzPai20Vl9XqQuIbQvQHWr9L9Mzh2N8LrzV/iMrCC6vD/k2heXP8oT8LOz1djsi1DFWe46ZNc7wBvLk+YOw/0fe+Ezc2VmX4eR0Yug/GcohLIs5Cml+A409uov/Z7pIHmInxKyVq3lrBPw/pUDdEiR9Uk3zae6wQLQAXizTuRzStUHEFQgCN6s23aJMqrSstqz2JYmguNrntPoRvhLoUiiBeq+sg2Jwu0jnS5k=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2019 12:30:16.3450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e46d08e-f1c8-4382-5484-08d6fbc4601f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3506
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=959 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280148
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

As stated in
https://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/README.md,
one of rx or tx buffer's must be null. However, if DMA is enabled, the
driver sets the SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX on the
controller flags. Hence, the spi core will provide dummy buffers even if
one of the buffers was set to null by the device driver. Thus, the
communication with the 3-wire device fails.

This patch uses the prepare_message callback to look for the device mode
and sets/clears the SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX on a
per spi message basis. It also assumes that DMA is not supported on
half-duplex devices.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-bcm2835.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 6f243a90c844..8993a15a4684 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -674,6 +674,10 @@ static bool bcm2835_spi_can_dma(struct spi_controller *ctlr,
 	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
 		return false;
 
+	/* Do not DMA on half-duplex devices */
+	if (spi->mode & SPI_3WIRE)
+		return false;
+
 	/* return OK */
 	return true;
 }
@@ -902,6 +906,15 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 		cs |= BCM2835_SPI_CS_CPOL;
 	if (spi->mode & SPI_CPHA)
 		cs |= BCM2835_SPI_CS_CPHA;
+	/*
+	 * For half-duplex devices, one of tx or rx buffers must be null
+	 * for one spi transfer. Hence, we need to clear the spi controller
+	 * flags so that we don't get dummy buffers...
+	 */
+	if (spi->mode & SPI_3WIRE)
+		master->flags &= ~(SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
+	else if (master->can_dma)
+		master->flags |= (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
 
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
 
-- 
2.22.0

