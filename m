Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38136221C
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbhDPOWs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:22:48 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:56161
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243200AbhDPOWr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:22:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah6ebubNZczza3DSQN+BwGBAgh8PkNIxzmLV1YZqTNT4mBzNwxDTB2KJFNbSYH7Y2JuA8sGTnfahj6FHuIl7OqiB3f0gX66axSGWcxU6MRGpDfdR7b2w+cCIn5pd+xb6lC73bka1mW0R5jr8kzGSCa+S2GvXRwGSo5SDF3zrJx7bVZSxgjsQqYKGh4u0d9fFfnjq608htggG87B7ZBwALbjoYQsGaPeRNemLZwUy2cLfOWK4bgE2ExiVg0JD4sURqU5DtgEfHMSGcHdRLBnxGdIYMCtQ0v7czCKJGW32I8xfmk+mAOXBMPnyzBIysHVS63ZKfgQF5mO7yrDHMB2fTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK2JV/4Ry5rEqiLLTPLjTpFF5XMXFyKUYVE7Bkdk8HU=;
 b=Tl0WL9sHZ+fhBSejaVutU/GUAYf/Y+ZFwPrsr0gELInu5+xEa0u5OYo52A0GKg6fWRjt8Qb4mlDxt5SCvMgiu/8rWtGK/atVY+kQUtKetMK/Zl2nVywaP8Z2N8q1XvL+sdwC2IoNEyjUnCTpF0hrjrD/gFhaOXFO01nzQC8GdMNLGBb/wwizTd4n4P43AV5WWvukz/WMDWE5eAZ4qeiyFmZnda0SuL7svAypSZ1QyrFppkY+XcaTeaOtm8uRG/iyPU9ZspzzpIBeMaWqiAwge3jpOYKNsg6SaFTM87HNPKUk796LXqN+o/p+W55TqHBri9tOiCYNY2g3QTE2ikdx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK2JV/4Ry5rEqiLLTPLjTpFF5XMXFyKUYVE7Bkdk8HU=;
 b=EFqkaeNYzFImGl7DxTqQwr6SODrYehJM16umSmprLq2srVuLNHLrsIjMZWDJAA8cNWJTx95wW3HDE+pT/gESAXhJHzcx9/x8Psp+7ZJ77qHSlF5Xjstl4Jqf8yeVCjkysfTqKMO008WUajd9HwMBmtj4Hct+zROJKGJo1WSBhVc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:22:20 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:22:20 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH 3/5] spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug
Date:   Fri, 16 Apr 2021 22:20:45 +0800
Message-Id: <20210416142047.6349-4-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416142047.6349-1-quanyang.wang@windriver.com>
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:22:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721bc683-cad2-45fa-bd02-08d900e30bc3
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB226417629CBDB03BD0EFA467F04C9@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vv0Tr0WWDONrHwBBWFE3oP1iuF3InHwwcYpN6LeJCGPsazWmffyoFUwoJZ1p229lZyIh/D9+xGfePnnr3Tr/xxlehtx4y1MBSPoqrTsKzoMG9FWY2Nz9g/dC0LkASlAj/lmfifbUymSQ+2f1/fzYd4+537GpWAMTS2I3l4GAaFS8QpCEp0wiPaDf2lC8v4JdQPRaJpHeanw9PIiMbG+XfoUiFy+L1M6HKPoadcI19EuPUajWp6QCLZ3HMkdfZ6NBcvMg2t5b148kihDPf9VUWSzGQ2UThTTNYhYFj1hvxjDRf6opMdkWKlipK5Qm0Nlh1g6qvrDETFlAjNdb7ck0LQLHh/u31OxLi5l3hJJrBXeUfLg6JofZvq6KZmzhDmNagCOtxBlax64Ob8abHNKZ7jsgPBJAp3SB5VjI+zyrpuK1JT9iil4zB3v2F1Snz1KuZ9zuPDkjRrNJv7Mp7B5acEMYPC5DBSXMRxAGUQ4/f7A0WXM6BQBNh4BbzssVvh4GiQKbhed3q57sERjkfacs1GfCvlKjUvtGQrxAzXSB5qAtXXgYlpqAX1Gao/G+4QGuEhSCIb4xGvEPKwFkr3oBFeM5HjmjAW8newjO+e1gf1EA9oU/pXQ2d3QwaRQVxvA9lzPJs3CkshyxvgwcfwJAhh3CP/ku9dcTmaf9gl+tUNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(86362001)(186003)(2906002)(38350700002)(38100700002)(316002)(6506007)(9686003)(6486002)(83380400001)(66946007)(8676002)(66556008)(66476007)(478600001)(16526019)(5660300002)(4326008)(26005)(6512007)(1076003)(52116002)(110136005)(956004)(6666004)(8936002)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t+QXsiscE4XcfvIp0rDiFuV/xfegs7BPijmhszyNhFox+BPj4HZ/heJPBku2?=
 =?us-ascii?Q?IUj7TG0Ghd15b91M5LyQUqkJI5Hu8YHZK5N9bySaoctZJU3oTXDZ2miQhdCm?=
 =?us-ascii?Q?CpttZXNFD5hFzPE1XcdkoM2zv+y46RdTRv0pvQ5ZJDCiaoMdBnlDod/lq4vo?=
 =?us-ascii?Q?0Jb048clGDlwN1l2DsVJJO1csQeLiQVreH9nZ+67l1QgLQFzv+0BLABdsqo4?=
 =?us-ascii?Q?pwCPwrDJwc21h3hKCO7/ZSsfBlJbKqDYa2ocn7goR+kfCc07DDMv7YTcmDcZ?=
 =?us-ascii?Q?62cJgUfXLPCLcrPVI66vcKCloVWtHWDlke85y8a5+3+i1+b+KUZWl0aqtULT?=
 =?us-ascii?Q?KjV+sY6lxjKjCm6iVGp/e78SsjB9QDwWdfQzMq2jY8x1JtWBOim96+jPG32N?=
 =?us-ascii?Q?0qaLpq11LIYG5+Hu1HnQJmoaa3pTwJwZOArgm4jn3HDE/wChdo67LTD7cOcd?=
 =?us-ascii?Q?F+Ejj6bo9ra4p1WiI9SFsY8QWdAxjmlsevtCqx6EW4jDFXTukAWM5JxGbRKM?=
 =?us-ascii?Q?QrSqYYLhpXqVXtKIoCn8+tdfv8HZ9+15Ih/FoBhGxpkABnpTnZ7uMputZzCS?=
 =?us-ascii?Q?LmupGdHpSsA7xGCHpQZQLj/plo97OOdGSrvgdnYcx3xdrDXRWtud1ruMBE/M?=
 =?us-ascii?Q?SfDAywrMSKaTZJFzLzZB1gwfgHXLt9j/RKOjkEF/Yaifz8lLj9yZaYZj+TYx?=
 =?us-ascii?Q?RpS9ZkucCKiE8IprV/NnQQjsHSUBHGMO9iEV9mthgWPTRKDpSvK+Dl1Uprpw?=
 =?us-ascii?Q?R8XPBJy6SURJ8+8bTgVvrNdN+AgHfCUPMmtIj8X5XtDQgwP2W1L3/Lpe/P+I?=
 =?us-ascii?Q?sxDibMLQNTWjt2XaZoAo51b3ymfg6GPyPdfFmfwzfB1WmRHGccvYX23qRxKR?=
 =?us-ascii?Q?SKpllCuYrPDe765jdG5q/y5czu1ZtWVz7AUtXT6M8ZltbuEmDRc4/nE5xpzq?=
 =?us-ascii?Q?edCvaZLXlsYmrQ3pF++tSbhhbh9z+E385jBFkcZKh7NVyfUQEicZaQDGvO35?=
 =?us-ascii?Q?Zvt7peG0hY5cPAvp94ohWYPrzn1vNv2vn868vBF8UQXaFhUHIxyl7pmqeAPO?=
 =?us-ascii?Q?7BNcsquAhKN0GzoKMTypHNVdJjP+LdkHTlfxVxte8N9DtE+P4uw5phkagnOE?=
 =?us-ascii?Q?KqLs9nVAMRlcA+ZAqvcIWRcGu1y8IexW4EbIPKopOuMFmj3U/sMuKeRjm8/J?=
 =?us-ascii?Q?snqUnuzuBUAFvhQVqeH812NjEiIwx2j0RHrNvAuZ5U5h9InFVoIkUfw+aust?=
 =?us-ascii?Q?8P59gbZwJ4F/zf+z8UgPeAbYQNWIWJf4dEj6sw90l6mjz4jxVmlZPjcjFA+W?=
 =?us-ascii?Q?V11ywWttf6XV1dnIC7Jj2EyQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721bc683-cad2-45fa-bd02-08d900e30bc3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:22:20.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awl/vHQ/0HQcKgIuhY7xzevHvtVcA1qINFlQiipOm06d7xpR4n6VYkH4h7aPTcpBUAkjFRAM9+k/zb3cpji5++sFoPwi5Qn0X0734K9ahI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
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

