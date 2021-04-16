Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048143616EC
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhDPAtU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:49:20 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:4262
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237311AbhDPAtT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGs3q0t809GJezi7BFhFmMZZO3CGxMx8VMm1IAtQTtijjeypXGIKwR7+lxLXldPUX9HLCBpPPPuJ5r8dERa04Nraqek4pVaw/HQpPXei9ptUOawDU8/A5chQFxQ0KtOjr516s2Kn/rcMC7tDcIQOa7kBNLCfwiTu78mKpWNtjf6L0LOcHzUW2imKHrj4/fCbHHoW405H5VlHVMLGrT2HlqPuCLFd8vnPcnfNdIa0K5pqTwZH5iE6C0Ion+d8YrgAAKS0XBqouKclOIHgllkJuAvpd8R+qBlO9LA7Ggvk/oQkXikhwAFmo1eRdW610ePLhrRif9U2B2JQ5EvZ07xnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK2JV/4Ry5rEqiLLTPLjTpFF5XMXFyKUYVE7Bkdk8HU=;
 b=mQShn5Cxnd3LpsJzcbPP8l4P9Hx02/HKO90pJZOud2zvV/meuQsFDyYhp0nx10aw2LpeHJwr425QxdVJwWbHDck8igpjEUfuEE+cy+0gBK4gdMpHIS/ljhrRt0wBl0j+SIDtr3KiWbyNzX6oCpKb2mNWW6JUZpnuV46kXEfG2lblYiLfBV/fK3sKmHBWOrOWEmP66qFuUDFZU8NaL59Iut5yix3J0mbnTyboGduUj4QHB/CwU6LeBdu+AsiIvSpB5Kk+EHajV/3tsI0QYxDkhF4yyLGQq686Jd5P7GsWhGBxvvgqTCI81t/7Gpw4vIhjiVR/QyWLQMg+nVW+3Z/tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK2JV/4Ry5rEqiLLTPLjTpFF5XMXFyKUYVE7Bkdk8HU=;
 b=pIaehorDoPp4beYmtk9gBlrIZef55Vh2Tv9/E9RnBxhaP1p6WKFjkanG8WOJFNiHoRlEqTCsjf2k5/mpcBpqljIGONPbprvsCPVb8qd//u/KJqqW12ata6WScsEpQk+I/nafQnf4WgI2p/3sDFEJS80L/7A9Jbu1/DbYkJhfnyE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 00:48:54 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 00:48:54 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 3/5] spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug
Date:   Fri, 16 Apr 2021 08:46:50 +0800
Message-Id: <20210416004652.2975446-4-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416004652.2975446-1-quanyang.wang@windriver.com>
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 00:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 938d9999-e9d4-4857-1a83-08d9007168cc
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB12565FE111123AD3DCF5D693F04C9@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rdN2IAr7gthHxG+/Lu2+/mhvG61x+uEjfF3WtW+D0lODZLxUFHKye2jpcmgdCVTzRsuzrYhJ/VNtolXooNa7yVDVmpc7MzNc6CoY5dtujJyAtO67GIwOXCLk0iva6oQMhFHPfITgYHcWzCrgv651JyU9oe68d3DrrTyw0kpUEzX0nMfTeUs37pdX/vLOaWjnYJ+0u17aqv2Qw+lrkKTjICsDp0dYBvRl0L+x1vn870utodj3r96s2wwY048WtzuvXwBf/hzA+s8DsGS6vMh83wrB1xxIv2ZXLa7M2caVShm+UaOMqbT4DP4pab1K13N18mXrO3BRKYnEOR0ipHAqOayFRoLD0KTQ7NK8nLWnaFnuWtMtYbOQ2sDoymmdbZP0FIdAOPLeuOqaKNIQp8e+BP1/AsWh96M2e/YDSYprbrlT9WEgnmW0J4gtsT0qIOZLF0TLi7/HOqT361t5Qtg3ZpEqJXrBqTKipyig36KHj47b2a59i0jmclDJDarQiaQiFYWdrAhax/Jj7jjilvwBWuj9j/8ZzVtI4SnvEDI49SfuN9Mu9HEY7fKTDIIY3dfwcuve6wp7Z0G6WsPfAq4U3HeZD4yi5elWk8MQzcO9q5muh/l1yXXGTh3RzTtRrpX1PCqzJNGKTf3vDYKFE4zK1lDzyno16moovEGFJyyTdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(956004)(66476007)(2616005)(66946007)(86362001)(83380400001)(4326008)(6506007)(66556008)(107886003)(5660300002)(52116002)(1076003)(6486002)(9686003)(2906002)(316002)(26005)(36756003)(8676002)(6512007)(38100700002)(110136005)(38350700002)(16526019)(478600001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XsguDcGAV3nuF4hsplJhp688gzS5n9QWhsc75VLZ70BuNO/isPQdrknuaobj?=
 =?us-ascii?Q?D222uDkXauSJZePcx+r/hBMb9Tuc1YfaNZU/drNxKvbkupHak41Manb82zUE?=
 =?us-ascii?Q?0/TOXX3d9UAumYxrvzUQF8gOzRQFGOGW6g7Kfb8lUHyHWDC6+s+rHB9WBnuu?=
 =?us-ascii?Q?3FsO1p4LMogYCE+ef6kSfX6/pgg3ePjbHbIn1dr8Fh9ytpo8vYkbwErphzVr?=
 =?us-ascii?Q?cRGqovXx8p4m/jKiSvQ9OVJqw5JjW8CqSOUH6JMTaF7GW+0QjFEorpJZTYuI?=
 =?us-ascii?Q?9owFH9kaGlcgOftpZ5Mnnh061OitJoLcERrKS75QD3n+67JQsRwjZWzngaSi?=
 =?us-ascii?Q?uFqxN6Hd1wvY4TBmVcmB9kz/Ol5BN6mDO/8csN7HZ+Ue/6KLc1NmNlpdQhEw?=
 =?us-ascii?Q?zEsVDpiNp0xv2Fy7WhxrVArHC22felp2OrSn+t1Ar7whpBKeW6oeL+8iEpxh?=
 =?us-ascii?Q?5il3XVWz6nCw1Nh3dT4kWGSnfAIbeg7a9B+uHwTGODf9e2Xo9fBZPBOwDIB0?=
 =?us-ascii?Q?QAs7R6Ys9oOraRjVDcT/J36l8vkWRMDnVGH0xOZqyhQMwgI/ouGlWYp2bF6v?=
 =?us-ascii?Q?WD52Q++xbZszaADSYYSamsSZ492b4jdHcqHxWGa8C3gipghxpt1bi4e8H84X?=
 =?us-ascii?Q?46nfIYnMgc3ErW0L6qKpMzAaoXpGl8pT5XqdTDABFeDlXfANPI97i06teJh4?=
 =?us-ascii?Q?Gi2yMu3laZLTZD2gCfQs5d9vJEdb55BfjA8i3dRa0wR41XKbFFGmDMGH2mb3?=
 =?us-ascii?Q?vBTJ7oQV5rLCaaXBj26ibKMseLM1PW6EjQZKklp+8/sbDhpDhZRg/OExoQiE?=
 =?us-ascii?Q?rnUu5QvRpLPfBWg/DY2IofkdWCcLH1qlHFcMSd7WCCH5K+0ZwN0AlvsMCnrt?=
 =?us-ascii?Q?uv6IZC2P+Kn6fh3Xqr8e0SKNplXTEUCl+bZW2GunNhuelkV3/HB2bf6HZePa?=
 =?us-ascii?Q?ts72CXbs9wlttRyPsaZqZ/PSVkKJAnD/JvZmHCw5ujQGVQB7aM3GGcsGbQTC?=
 =?us-ascii?Q?iGTpuhyYos1NAJJd0AuJvccLTQx96dhyzoZIirRbxPyI72pjWnqIWjrTWTEd?=
 =?us-ascii?Q?TT+VpoHhCjZ3GwvItZTZ4CttSwrugRkeuVDhOdWs0NFby+KOYCPUWg17CD3V?=
 =?us-ascii?Q?aI76duscxSfdibz5MCbeAtf//+5k39pYpnNuKchAlLb+i1Kriba71KDEw3aX?=
 =?us-ascii?Q?D+U6+c2Xdn1Siq7g8thrMQsk4wuX6Tqs744scIJ4nboawU0UslJsHs1NqrsX?=
 =?us-ascii?Q?z1+meggdSPvzblO+lpTJhBODNpcN1iqh69YQEnJRd7ZKfiMqp9KnbGwYQhCm?=
 =?us-ascii?Q?NjoCtM1TJZwfK6jYkWXohHnp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938d9999-e9d4-4857-1a83-08d9007168cc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:48:54.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+zhzyINZxMP8ZO/OJ8Grxb6XOXv6AT7UJ/BFv5MAqVrLz4zPye8LufYyhVmXr5f9Ov6zQZAiwq6Qc7uw3gJ3/6/fusNQktQ3jvYkmSlCwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

During a transfer the driver filled the fifo with 4bytes,
even if the data that needs to be transfer is less that 4bytes.
This resulted in slab-out-of-bounds bug in KernelAddressSanitizer.

This patch resolves slab-out-of-bounds bug by filling the fifo
with the number of bytes that needs to transferred.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 1146359528b9..2e2607b5dee9 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -509,17 +509,19 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
 	u32 count = 0, intermediate;
 
 	while ((xqspi->bytes_to_transfer > 0) && (count < size) && (xqspi->txbuf)) {
-		memcpy(&intermediate, xqspi->txbuf, 4);
-		zynqmp_gqspi_write(xqspi, GQSPI_TXD_OFST, intermediate);
-
 		if (xqspi->bytes_to_transfer >= 4) {
+			memcpy(&intermediate, xqspi->txbuf, 4);
 			xqspi->txbuf += 4;
 			xqspi->bytes_to_transfer -= 4;
+			count += 4;
 		} else {
+			memcpy(&intermediate, xqspi->txbuf,
+			       xqspi->bytes_to_transfer);
 			xqspi->txbuf += xqspi->bytes_to_transfer;
 			xqspi->bytes_to_transfer = 0;
+			count += xqspi->bytes_to_transfer;
 		}
-		count++;
+		zynqmp_gqspi_write(xqspi, GQSPI_TXD_OFST, intermediate);
 	}
 }
 
-- 
2.25.1

