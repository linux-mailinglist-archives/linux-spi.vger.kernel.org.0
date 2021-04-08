Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1D357B08
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 06:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhDHEEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 00:04:13 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:25953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229820AbhDHEEJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 00:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKUupt6PixRsm7CLM1gxprtjZNZxiTBrYbvUcdYIsT1iHiJtgCiGVU1fHxSP5UFQ75aHNuncrOuokuweVIuMczIsAkqk+Lgknqijq6Flz4I7MlcS8/AkPg7eXT0P/ZndJ/4n7OvlwV7GRgoz0oN2EsqYpyfozOVQmzk6wd4BIVDnHmAseyA0xc764rTknS0A09eOHYFQbP/QHzPMzcTS/Qt65E3zLI+iyxv2EYnkrf1EPs7v04MYWgf6IOCR89CdJjonKyQ3MueiD0wCGhdI/1xaIor/igaAcRt8qzcsF2Op7Cxj0cbwcONxmx8/EIAokV4DigbiL04krJHJejM4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejx1z1Qj3X4US1q/1YdrUH2l/JvUF8seAXu7M/925nc=;
 b=E66BugkBTo+I7tMQu4/RCEGM4ixa5IDE+lyfCfXIui1CxpEC1QQqZGdyaLZa4MGFvA6ThijqBOW5LziRmjQ59M0skVc35OkdWMy6wuQxPvifjlPUrCY17EsTfccNtL9Fehc3PywURIDzsjgmyBuiIwY8vdgUQFHGw0KYSo5Jq930eGJZYAEWGbuZqt6fhRejt3DnbHbkhuO+kWgtAtNL/2ZaqlvjfFWmKRmVPBS9KoPk4NJEtcgkDzx1HB0uK7Mj2jspBEDQKwS3L8DRFKv6cludUI+r+E0G/r6Fmy+ucJTrRkaNbIAvMfj1srUDrQRkYwSDJ4jNQhu/Skjd3sv1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejx1z1Qj3X4US1q/1YdrUH2l/JvUF8seAXu7M/925nc=;
 b=nm1HBzVZMdXvGMX28TS/7M/AMsgd0zpCDsPZuZX0j+OnkdN9nD3z9f5ADgA3rOW/AI+9bBKVX8oZOBpcC3pTCofAEwWFOWYM1Q+4iQv8sAiKiWjBhULLDlGXiyg5iRvyyIcmS3lTns2UVomTJbgRQnYt7kwFjxRHWyae4ovDkxs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 04:03:57 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:03:56 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 4/4] spi: spi-zynqmp-gqspi: fix incorrect operating mode in zynqmp_qspi_read_op
Date:   Thu,  8 Apr 2021 12:02:23 +0800
Message-Id: <20210408040223.23134-5-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040223.23134-1-quanyang.wang@windriver.com>
References: <20210408040223.23134-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 04:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f289e2-8a32-4cfe-cda1-08d8fa435482
X-MS-TrafficTypeDiagnostic: CY4PR11MB1351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1351DFB8E90B5183276E9240F0749@CY4PR11MB1351.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auEcOlCHJXogD0ibbjlJKGg119x+jCo75tl9etS9QjRCvN/R1iQYnRLn7N33wcfsgraT+qw/LgcYeNf2fXsiawD+y642CRQ07DGKPM9eLLqeHnohfV9KWZjNnZTQj3K7XUMSowiSdT7lTec5ncjf7+GJmiFfqn3EnbKhc4BWgN3AxkmnlSZukmngbwA6CM+Nn2HOM55vGKt4WTYkiNqO5pjK/+dkPcKnrLDmIz5OnlnCOXA54iAhkCsICXbc7j7jLH3pr84xkDKPGgem+pW8Ll1/wyA3u0/aD7S+ZN7bEJRFudTyIa5bo1GkunWKhPRv0E+a+p0hyD/DFUOR5qUzRiRZ1l8y6wRr/RpnWO8+1ol8fqCIFDQwJTN50jQm40HytU9/cwvpOe9wUOZf+2hMF7qI78z5m0sSJgl4OS6vDDKEXAcoquFKfo9QjuUCngfKRRevO3H20nvUDC6YeshJcHLh/nDErEmtWvo3m3zVZrW2j/FlloxBg4Aq4okgjNpmAtgJkOj6U9NFxjbigeSIlzTKArwY896oeVImbr1kJ6jiVwvbAIWP3YmN3GFs1PhCJwVfKG2rFhzeBal/bZIYhMw+7hcbKa3AEsCHckRBwCTnOmv3ETCXmrUYdFVuLw7eympqa0VoJrGNYZmkiuOzt1VaZUuZ7Jk6aqlEr6Bcdf54S1put93I3BVHUMIf8Uzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(8936002)(478600001)(36756003)(38350700001)(6512007)(66476007)(2906002)(8676002)(83380400001)(26005)(186003)(16526019)(66556008)(9686003)(38100700001)(107886003)(6506007)(316002)(86362001)(52116002)(1076003)(6486002)(110136005)(5660300002)(956004)(66946007)(2616005)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YyoNS5i2XEbff3W4RO7pvqYOfnnGTTLnKy83Gg6UMpYfSKkF4VkQ5FhBCRXv?=
 =?us-ascii?Q?eJOgMOvcHGDy10XmjR+azg17eTUEfVfYZYGSETdVHPz4eD7ydjRGjDR9zrz5?=
 =?us-ascii?Q?x5W4VPS88uojGzMjnYQ86H/3KLaeM0w2JyWRhb/23cnGJ8SzyDhFvXQDBRaj?=
 =?us-ascii?Q?Ih5hjbGfjBOWrmvDeE8eiml7Qjwf3/+gH/r0Tv7qvtpPoU0HnBpKnkqklQqE?=
 =?us-ascii?Q?UXiyjEuoZgJhJJhQUGUd+1i2+a0phNsvdZnrqlRn4kQMdKKQOD9Bni8GQnqU?=
 =?us-ascii?Q?k13T74bRHHH6nKBz/vzu6xlQ5qu/Ch7lsdw/3TWglX/9Ryzg+0tBO9+IfYIM?=
 =?us-ascii?Q?jlJO4uNqZIOiFKNkJ8HOlYBO2HAyF5ckF4jE56Viz9QpVPiOfHXO1HqAKoZh?=
 =?us-ascii?Q?8ZcUl623xHpins6r8RHlsZULvd///oX6peH+AehNXXP7/3Q4PfmE1jPm2wum?=
 =?us-ascii?Q?RXz0womIahKI0BdodKWdpG4zwJo6arLZad2lmFPQV2Bx+FQv8wrS0fiPd7h+?=
 =?us-ascii?Q?Ur9v4dS0Va/bjySOlMK5s5RIL5zgXgq+n3q6Cy9IsLxueFf15ON5QDAhrQo0?=
 =?us-ascii?Q?0En35WChrZ/3dDx+GN2HIG/NO7fac09uetRvOYQVufd6P4kHoEaW8VPRYSr/?=
 =?us-ascii?Q?Sl/6Xvr1szrfodlUem+M7P9iH+Enh66bwYNatSsCJtiQmCodIBoh5sPPSmAq?=
 =?us-ascii?Q?vWQXsBjE4brw48U4vz1l9iX7G4ryL3gStzA7BI3woB0EwzGmRSNUofy+35cM?=
 =?us-ascii?Q?JRj7g3D7rBIRTObVEZcWSkm+rSTjuBFMn0f0c2JESuFvRBAwfmwzNM6oG7Tp?=
 =?us-ascii?Q?J1Q4rxKteNdCENeQORDclxlYPe+I6vL+H9ldMNtYSC4r1ZgcjfrowpUUkGl9?=
 =?us-ascii?Q?A1pT1EFy2F8B8Cu3lYuLyjMxl/NUc0mEZVOlbd0ykxW54aK6X4MDfZFuCgjH?=
 =?us-ascii?Q?LLnV3SkqOfE+QuVW1oT57Isxvv1FGdpxTwtlbECZCFXQn61ztKFqwS56kkie?=
 =?us-ascii?Q?6RBqOn4Z6eINeH1f6Mf02ffqJq2pW+p7v+vAFFOpHIOot7W7z0XUji7Kp86E?=
 =?us-ascii?Q?V6tm8lPyQXDlocLxLnBXi8fyZRL2Dpo/ikD7rD/5hNvjBESShwE1EyqOiHI7?=
 =?us-ascii?Q?O1OEmwTsv5wgUCSrVTY6pDcL4PA1FQ5i3SwB6TTQm7jOuHVN3mRVB1uZEoi1?=
 =?us-ascii?Q?oY7pddGqUO7R8k3aCRudnaE56Qg7wUiryDETlvQxI1v6QinTCvK+xePhSvqr?=
 =?us-ascii?Q?7DPizybRmTMXYYVfJ4i1EO+wAgoqmX7KfCPUaaG88qNilKAaCCI1jaViEa4M?=
 =?us-ascii?Q?8ReimULhazkhG8DS+v+Mxshy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f289e2-8a32-4cfe-cda1-08d8fa435482
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 04:03:56.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCRDEvGFTZE1tGWhZDOMps462KDuqwjwNBsWJelm4Dg386rO63pYNICuOJmq/DXSy9jHLH9LLxiWaYZnSyLaggJc+qtp1BOD34BcX5xbjLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1351
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

When starting a read operation, we should call zynqmp_qspi_setuprxdma
first to set xqspi->mode according to xqspi->bytes_to_receive and
to calculate correct xqspi->dma_rx_bytes. Then in the function
zynqmp_qspi_fillgenfifo, generate the appropriate command with
operating mode and bytes to transfer, and fill the GENFIFO with
the command to perform the read operation.

Calling zynqmp_qspi_fillgenfifo before zynqmp_qspi_setuprxdma will
result in incorrect transfer length and operating mode. So change
the calling order to fix this issue.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Reviewed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index cf73a069b759..036d8ae41c06 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -827,8 +827,8 @@ static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
 static void zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
 				u32 genfifoentry)
 {
-	zynqmp_qspi_fillgenfifo(xqspi, rx_nbits, genfifoentry);
 	zynqmp_qspi_setuprxdma(xqspi);
+	zynqmp_qspi_fillgenfifo(xqspi, rx_nbits, genfifoentry);
 }
 
 /**
-- 
2.25.1

