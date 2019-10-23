Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FBAE1295
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbfJWHA3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 03:00:29 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42406 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388218AbfJWHA3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 03:00:29 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N6vlxx026605;
        Wed, 23 Oct 2019 03:00:24 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2055.outbound.protection.outlook.com [104.47.34.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t219ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 03:00:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO0hWTm4BiIRnQ4oOfESxv9cRFztLh1NjxsYzkAJsA6vQgNgYonHhXiX6MTjoo0asXsk6jDaCfN9fNpnvBIR/qb/Gt0z1KHWKm4rU8YYMk6YyBeB6SqJvRIUdtmAgisNaIiMQz/scueUG6WXiD0ISm97g8tTHTgQGg56rpdO/gxPmbShAu7XOk+IkrosRhhc99M8MppWez/9KerM52hpe9ZvSF1oKdqTqprCiNVt+W+aPO0wJTT/phEA/i00lXET18KXwLwezRSykjzuXBid0j22xy/5Y2GU/crAAeaUhYwzZOVSu9lA9JDZGjLre4VFuxO7eWqJWBQHoC1DU9v5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SAZawyw2mjZD9738Vzkiz3VqA0/AeM/sbEnyB25CHA=;
 b=HeeLFM51soO4+14eTMp+CJllusmaht14JvcmYeGGwdKtGaA1teT4XhWf5HRB+JxSmyk9Zj+uQl1C+OIRc6d5514KJKQpGfGb9wsIn0u0Xen5iEwtZU91E/jdZ6NqVct6/CC38nxgGF5i9ip7kVoco9O2jWc3hboW0/ZeamVsR3ArsXuIoCMd1pKGWOhzamoy2786yP3vi2JUX6NDEOUMsvhgHDXcYmqj9PhKBxisv+/UuOo5+8rzFSsWlrdPrSp5+MyaKzYsbUS6OqrsqgwQswTVbf0XIcOT7iBJxwhgFX93Db8LHXDiTcwNQB6gLdHFbhdYLCvOLOtg0/MqSns+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SAZawyw2mjZD9738Vzkiz3VqA0/AeM/sbEnyB25CHA=;
 b=LMfZCZKvSfEDqXDITQA+xD82u/+YHE7dKIfEDwCcowY8k0CGlljh9uBATMSzwT+IEH1kHNiXXr2ZAkCEtiZDyjxxc9B/8JOfU59PX+iemEUVGO0uUNzvRj7+FjIJpAcwjmuhMfka7kJg6MNRBd7riBdxqG2YjP5/tuJ2NMqCJIc=
Received: from BN6PR03CA0068.namprd03.prod.outlook.com (2603:10b6:404:4c::30)
 by MWHPR03MB2432.namprd03.prod.outlook.com (2603:10b6:300:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Wed, 23 Oct
 2019 07:00:21 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR03CA0068.outlook.office365.com
 (2603:10b6:404:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.21 via Frontend
 Transport; Wed, 23 Oct 2019 07:00:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Wed, 23 Oct 2019 07:00:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9N70DfB021405
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 23 Oct 2019 00:00:13 -0700
Received: from saturn.ad.analog.com (10.48.65.116) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Oct 2019 03:00:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] spi: document CS setup, hold & inactive times in header
Date:   Wed, 23 Oct 2019 10:00:46 +0300
Message-ID: <20191023070046.12478-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(1076003)(246002)(50226002)(186003)(356004)(316002)(86362001)(8936002)(50466002)(7636002)(426003)(486006)(305945005)(44832011)(110136005)(6666004)(8676002)(5660300002)(54906003)(4326008)(2616005)(476003)(47776003)(126002)(14444005)(36756003)(48376002)(2906002)(106002)(478600001)(70206006)(26005)(70586007)(336012)(2870700001)(7696005)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2432;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5297eb40-6c8a-4064-f744-08d75786ab69
X-MS-TrafficTypeDiagnostic: MWHPR03MB2432:
X-Microsoft-Antispam-PRVS: <MWHPR03MB243287CD34A0242BE1103E76F96B0@MWHPR03MB2432.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 019919A9E4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0qOIk1QMte/PEcmHxhN2V+kITe3iW4Xujq2PwlCBxT8FvHHpphWpLb1PoYNNbp7fuyVcWSK7qtQu557gr+o/5UaO7VpUjYR9aO2zNtiTPbTjmaP/tURHRUcuNFG+G1ziA5FOH2+Wb5DEtM8NnLG+k9dxhPyRIW9ggYylxSDG5KhmhW+G2DIjJSwTwafP8GFFGez94NI15Men7XPPojoPNy+/hQn+BFA7EAVAwCRIBSSpbInlf///6D53xoYoQYDQNXZrXC6Z8GLrT4//7/4EOy6vzSK5+dKEUxliuXadXOAuFQkl5z+VjaNUBkmTIc0uF2uFNz7/ZIEoeuwt1V6Mf2xLYuOSBiw9qarj26vcVjYaDQI6vzmLwDgjbltpalPuyAxQsQX5RDd2H/RshtS8HCk0EogzfXylGmSIM5du0f5uOvLjPEhqmtn2WdYFZgq
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 07:00:20.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5297eb40-6c8a-4064-f744-08d75786ab69
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2432
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_01:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=967 phishscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230068
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change documents the CS setup, host & inactive times. They were
omitted when the fields were added, and were caught by one of the build
bots.

Fixes: 25093bdeb6bc ("spi: implement SW control for CS times")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/spi/spi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c40d6af2bf07..98fe8663033a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -407,6 +407,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	     controller has native support for memory like operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
+ * @cs_setup: delay to be introduced by the controller after CS is asserted
+ * @cs_hold: delay to be introduced by the controller before CS is deasserted
+ * @cs_inactive: delay to be introduced by the controller after CS is
+ *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
+ *	two delays will be added up.
  * @cs_gpios: LEGACY: array of GPIO descs to use as chip select lines; one per
  *	CS number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself). Use the cs_gpiods
-- 
2.20.1

