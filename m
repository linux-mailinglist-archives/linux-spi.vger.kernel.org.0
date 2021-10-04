Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3E420769
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 10:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhJDIky (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 04:40:54 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36062 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhJDIkx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 04:40:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1945M742018979;
        Mon, 4 Oct 2021 01:39:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=3LI99zn047/PEGptwgIqj2CydYlMiqoMfc7LkbjD5I0=;
 b=HcemcAjGlCRRY7V0Tr3RVxhS3MpIOe9DXRSVXwGBS2wGx0J6q27LtYzQNVZ3tv+jd1wh
 coENsH5OYErYf5vly4jyQv1uTRUTBBc49ur49FdCuTQZlFaSxFEhZ4Mv0vEyet+KGe8/
 /aF3/zzzRtCYxMID1TqNkt4gIQWZJMl+asQq2Il65/XH+oRUhu18UZZVgle6hsW/i7LL
 mQXyjbJxBrvzDIdCFH/mX1euv+gotC6tPxcE7XZ57y7xoDTcyXunilrqN6T0nsokuYNU
 KF5msHqAFe2+eqSQSss3S95YV1zheLe3n7T4eeLwZbdtoiy7JQzRIa8eSw65VP9+Sr0E 2g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bfc8p1vyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 01:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFLhCanuwNNRWSrTszNaf/VNVz9/tW+erF1r2s8OPmTGu4NZ/NLEzlOOnIW/j3exio2/3LKI/94px2EV5sDgxXqTUfdiwYgbWWk0wZqFUdN57bISkPQyEExtVHAMm41yMQOF1/0RCWGADszjP5ueMORb03L/1ghUqGHF0ZgOJnLCpdyzvJWlAMEWKx25I5K6Wx5q0iyp9laj9H4JJgzqy2PJ0VS8xz/LepXxfYVAj/tpfiHJgekG/MHAv+Nkz+3g5Igcw/Lh9VY70/HkkFju2JIUiwv7thUQ4fUklOe4G66atGoNfVYHG7XZw/BKPRXa9jpVINPau7Gr8fScWvBGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LI99zn047/PEGptwgIqj2CydYlMiqoMfc7LkbjD5I0=;
 b=LtODn/iAGE//TTKhX2TFP2Tn5wrvD8R4m/5CFx7ZSgo99OHAI7N2eo3ryWezHOxquUeSlYIx4su4L5kHQ8amiBWq0nVFvOOBkwBNHsUoQD0F3OvEF69qleCXbO7+mPK6jAoQorkN+xupVGj2RpBGSKOggRG1avlkSVte5jFJnJd5b3z7FaHO9vqlUxm+icpOZoBoCUqqZwXj6lXbCnB5xgqotppclbiiysBtRj/oy1W2unEKmg3zn2kG4SfczybHCk3oZ93BNpqAt1Bd1Ivy4oAeVULIm3f+5s7xWo5IbWr74g1Mrq7tYlLXZfFfADS1vLs5YaZcI+Ee66SmIBctKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=oracle.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LI99zn047/PEGptwgIqj2CydYlMiqoMfc7LkbjD5I0=;
 b=btEKMA6VJhHLH6ey6FmY1032FVFw3NRaLRZYQta6ocxvq3pbQGJgvE6V2dCRJxHf02WzzjuEZxp+Go1FW3w1Uq3nsiQmGGA4xgxkpPTWcOqXqhJjq2fbk0SSW4Qz/Qyw2kDnpEL1nkngXVAS8Y1OWftSyZ6zsGjTyvDQ2A/8xq8=
Received: from BN0PR04CA0185.namprd04.prod.outlook.com (2603:10b6:408:e9::10)
 by DS7PR07MB7638.namprd07.prod.outlook.com (2603:10b6:5:2d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 08:38:59 +0000
Received: from BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::49) by BN0PR04CA0185.outlook.office365.com
 (2603:10b6:408:e9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Mon, 4 Oct 2021 08:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT038.mail.protection.outlook.com (10.13.183.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.8 via Frontend Transport; Mon, 4 Oct 2021 08:38:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1948cvmg011087
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 01:38:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Oct 2021 10:38:38 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 4 Oct 2021 10:38:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 4 Oct 2021 10:38:26 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1948cQEK022776;
        Mon, 4 Oct 2021 10:38:26 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1948cQ7Q022775;
        Mon, 4 Oct 2021 10:38:26 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <dan.carpenter@oracle.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jpawar@cadence.com>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v2] spi: cadence: fix static checker warning
Date:   Mon, 4 Oct 2021 10:38:24 +0200
Message-ID: <1633336704-22735-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b94f498-920a-487b-8593-08d987126913
X-MS-TrafficTypeDiagnostic: DS7PR07MB7638:
X-Microsoft-Antispam-PRVS: <DS7PR07MB76385D2BE6447DEF516422DAC1AE9@DS7PR07MB7638.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ci8uxkdPJ5w3faxshPdiiopRmCPfim7/fy8jNmruq5QZQJGRK9TObnvc7OsU1yTA1ocxCoRPIQlWCq2vNlyJAXBVojbAStYGPZIT4xLhBCZ/umC9NKzAyfqWHDseyvjnoHa64D38O5giIPyxgzbw2VVbISUXMlVW8UlhH2AuNwKIwqOnzj5VaacFlBNHuOA3l3OswH/NM+57NVa8puxxGgZ3X7Wo04a+YxUFThaWbpip4OiOHzBJ+jYhvxxWJBAa8weR09xK1k2pI1izGBys2E2DXKsbd3gVoQf0y27pKKzo2pFo7wAJu7ZzdKIOTw9+pyY1ezeFjtUYJPpSt7/3BHmq60PvzV2t9tasA0VHBdE76C8cxYDfpxj/I/Uo1efSgH54/wtMap1kM0JGBbxDt3VorhG/Dzld3f6Izi2AeDCEcyOyPFJCZrF4oqEFKe7J2EPYCIxO1ntuMc/5Qeslk5C3vNJGdugRuumACEdAlE1RHgBO9IM12apHv05GwUcEpIx9Zag2psL1+muUhaJVlsnSFaV9xSHAMvFviB+xrUOxnFk71ADWFvVDKMimEOIC7I8/w2Vr4C5fHbPOeGSX7Uf+FFnHzjL9M1QZYfPxn5KgA/O3dLX71GoyOER2S8ElDxpTvqEFbkDsP8c+OtjOT+oaaPNwnaIGja3g6ZhwAMQ/J0HiGa7eCpYIVXQ9D6FLExNk76k6VEp72g8DccbxaOUtkRaqJWRzqudbMglJrYGxykPvsZV+0jxtiD1AeOsSb5dSTGa6oRGEX2XGUwSpUF1IxvaCbKtzY6CRfFezeWK5Z5M8MLbmUv4YpG+ZYZw2
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(36860700001)(8676002)(2616005)(42186006)(36906005)(316002)(2906002)(508600001)(82310400003)(83380400001)(8936002)(54906003)(47076005)(110136005)(336012)(426003)(4326008)(26005)(966005)(86362001)(107886003)(70206006)(70586007)(7636003)(186003)(5660300002)(36756003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 08:38:59.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b94f498-920a-487b-8593-08d987126913
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7638
X-Proofpoint-GUID: gfoOyVk9zypsFa2DHnq7PNpZbdXLvxsG
X-Proofpoint-ORIG-GUID: gfoOyVk9zypsFa2DHnq7PNpZbdXLvxsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_02,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110040060
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixes Smatch static checker warning.
CDNS_XSPI_CMD_REG_5 is used in ACMD mode and currently
only STIG mode is enabled which doesn't use CDNS_XSPI_CMD_REG_5
and hence everything was working in STIG mode.
Since plan is to use same function cdns_xspi_trigger_command()
in ACMD mode, increasing size of the array passed to it.

Fixes: a16cc8077627 ("spi: cadence: add support for Cadence XSPI controller")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/linux-spi/20210930134231.GA14363@kili/
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
Changes since v1:
Added Fixes tag.

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

