Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F43420064
	for <lists+linux-spi@lfdr.de>; Sun,  3 Oct 2021 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhJCHGg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Oct 2021 03:06:36 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3956 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhJCHGg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Oct 2021 03:06:36 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 192NY4Yl006328;
        Sun, 3 Oct 2021 00:04:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=sYDJTx+9daFstkb2C6VLhX500MkLQP+G48sDiihmrvE=;
 b=p7ouG8tMImfWF51dpksm5SJSO2kXGIBmmRRlpvto8JB1GfOIBz4PFi7DPM/LJU0f4X+q
 k0fwQgvjEJEVcdvZyjlMMXbzkHckB6qcZC/tqRAYEMxFbwA17ca1swuWSckmbD4rCNGC
 8ZuEARpSLHgICfQEb1wcK98B0vSlBU1dX15Pb9+U4k8Y6oiMWr7KT4O30890OxeSd4fh
 VMNemI6ItCuNpWl7wCsotNNnyyxigMNmWHzBPigMICVJjEG4YsmL8qXa58qTBjg0+BhE
 fPGZUe7rGA+xCyQDGUFGgll87POYPg2NBxw57t+7Cqqg2NbODDSr2LmheLeG7ertsWG7 Og== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bekyyj78c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 00:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHQCaQfcgfL2e5CbMOZ+F2/cBSSEtVhTNxdtYj+lHnspZHiOPL9Z0N2FCKXAlwuU8s+quoKnsoalxnfWDeShDoPzb4SUAL4wwsLaH4wtfECwqBc207yCYlqPcR2gT31z7zsCQJsu9dry40MJyip4EnGp0qmV39MAA9k6ogFa7qMOkaQ4yh9IoMx1HckaRJgHfmG2asFP1rHvlxxe6z9IGTrWuW10w1uGbCtjSvQjXB4aA6QSxAQnYYIscWpql77Q3OtZulqZK4xy9cnVQGid6vJZo6SFrhIIGLBJikcagoRv2xKGG5p8JULnXa5tztT2EHeP3iqnF7OeKHbMucmL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYDJTx+9daFstkb2C6VLhX500MkLQP+G48sDiihmrvE=;
 b=hpzZb+/sSs+pVOWTbYl+HWHrqBAndwDFU24ozuj5qo4Zyjd/L7AkIMhVwCcDjPpWWKf3YI9uWHxggu/hpeAmIxy/Y+4pmZrDmPSvs297/1K88lCyso55I7wDcgTtcOxaOsC/fJPCUDyKPDdmOUAngoBD2TfvOkKv+It/HBGhVafPWCfJbUoJAyLJ/pgO9ChXCM+WHjU6iqVRYEKOWy18DbuRy6jE9ljDVR5mQgQ/Qh7ZWHWOb7piQcByzHwSx7yL3bWBdziKd4OHR3qIsgqZ/kmeoKOiabHFIDVs3FhCCDb6UGJE1CJLl5fRIcH4ewvdFbX7z5uXpe170C/+2lYStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=oracle.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYDJTx+9daFstkb2C6VLhX500MkLQP+G48sDiihmrvE=;
 b=4sYdPz1st0oAK3OUVmTMRrtAz2DWxxr3LOXyIFo+YWqzLgMya5pi34eVHs/De/D6ccS2GrTiBqhjfuT4fGC1aGXbNMJw/j0j8r7jvwYc4Ic/s8uCmFoej1Vd+HUFytMwdN/RzAtqQ1A+eTIrtWTxHqxHgsIjIfhn754ysjvqanM=
Received: from MWHPR04CA0040.namprd04.prod.outlook.com (2603:10b6:300:ee::26)
 by BYAPR07MB5304.namprd07.prod.outlook.com (2603:10b6:a03:6c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 3 Oct
 2021 07:04:42 +0000
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::b6) by MWHPR04CA0040.outlook.office365.com
 (2603:10b6:300:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Sun, 3 Oct 2021 07:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT050.mail.protection.outlook.com (10.13.180.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.8 via Frontend Transport; Sun, 3 Oct 2021 07:04:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19374dBC006562
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Oct 2021 03:04:40 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 3 Oct 2021 09:04:20 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 3 Oct 2021 09:04:20 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19374KB0014738;
        Sun, 3 Oct 2021 09:04:20 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19374KAv014737;
        Sun, 3 Oct 2021 09:04:20 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <dan.carpenter@oracle.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jpawar@cadence.com>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH] spi: cadence: fix static checker warning
Date:   Sun, 3 Oct 2021 09:04:18 +0200
Message-ID: <1633244658-14702-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c405b0e-08a7-449a-8745-08d9863c125f
X-MS-TrafficTypeDiagnostic: BYAPR07MB5304:
X-Microsoft-Antispam-PRVS: <BYAPR07MB530484D3F86AFB6852069365C1AD9@BYAPR07MB5304.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCUDcg9UlM0RQLJaeoCNMv1p0LSOjxgFAfMrSU4j8+N0w+rWOJAh88WJzmTXEba9qbt2kluJrfXA+tzm1fEE5Gc0trkZ5SskxEJVlkdBpQcOsn0KN+/NaRZDAwySLMMKHfUiUvk5C15m0BUFmSGjQ3p0z3sg9f0JWUXhrEYj7B5xX3vmYK1gODrG8TihUSrh0xKdKxnvTRmkSbSTroX8mib7RfclmU4XWyADfWQW8BNwZa/S3HrDkYJKuODEeuCCU+oRlz+O/hlFZMqGTT1raQuwFoQuJP/BQhgQ1DrmtimzNr8s+bAb2e40bt1GSw4NcSVWsfL8Atb/GmghD9auRKeLj1NunzPtq86RhElweCVgo9ZGBaXRdIJGTFWswHFAGvK9gKi+PLwxwx3wwBudbmL4HhLthR/Dk3g4BxL9yfmnEchozwzOfLcd3llrgfwVYAP5GLp/jeqvFqkKgx9/5ZErykmfv6Kl6g1R4Qh4jjcj5j2GFNfVdicAz4cIrZTj8MNEClvaYtqUD9GSTmLJUTnrsNyUeKz8Bh8Zq7wwpXmQiI3nUjO7vsqzGSL12ng7YkXql4h5kysoY9JBs4VfjXRNrjRsmIHmIolW7HiH5JlTPCiYiaO/ngit/EVQEdVBgw1ZD7DMIGZZ53yvZ4w8mGtS+6hfCrHjvODU+O0P2pjDjSzohbjU9JA6up8kapnMonCkeCv66b3BrmCANFHZbXTX2WWV+Jti+opzIsloIShvzoVf+OFLAYz+wiZWxOkR4zYubmwl+0UIZkWZA+kEVRnUsKKjetI+RpF7gZu7LJRKugT5DJ7L7jVmSM2bZzqseAUPMWxnhlrsq+AJdR3haooDQPby3xVka9bJTto9Ng8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(2906002)(82310400003)(81166007)(336012)(83380400001)(186003)(36860700001)(4326008)(426003)(966005)(356005)(5660300002)(107886003)(508600001)(36756003)(36906005)(47076005)(86362001)(110136005)(54906003)(2616005)(8676002)(316002)(26005)(8936002)(70206006)(42186006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 07:04:41.2518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c405b0e-08a7-449a-8745-08d9863c125f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5304
X-Proofpoint-ORIG-GUID: xIjSSddLT2sMUl4lphwb0AcaioRG_36U
X-Proofpoint-GUID: xIjSSddLT2sMUl4lphwb0AcaioRG_36U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-03_02,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110030049
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixes Smatch static checker warning.
CDNS_XSPI_CMD_REG_5 is used in ACMD mode and currently
only STIG mode is enabled which doesn't use CDNS_XSPI_CMD_REG_5
and hence everything was working in STIG mode.
Since plan is to use same function cdns_xspi_trigger_command()
in ACMD mode, increasing size of the array passed to it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/linux-spi/20210930134231.GA14363@kili/
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/spi/spi-cadence-xspi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3401fcf..6bd0e67 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -239,7 +239,7 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 }
 
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
-				      u32 cmd_regs[5])
+				      u32 cmd_regs[6])
 {
 	writel(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
 	writel(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
@@ -346,7 +346,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
 				       bool data_phase)
 {
-	u32 cmd_regs[5];
+	u32 cmd_regs[6];
 	u32 cmd_status;
 	int ret;
 
-- 
1.7.1

