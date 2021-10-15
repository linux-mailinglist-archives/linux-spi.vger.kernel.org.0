Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7419042E753
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 05:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhJODlo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Oct 2021 23:41:44 -0400
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:18659
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234139AbhJODlo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Oct 2021 23:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc/+dwqbIIvYnmecwLTSHLgEfgMJjd2MUG/nTw0e+tmGpppn4BYz+BjqIjymw3oVJibedtOI5SlTXYiN7DD510r6rvV8lo1mR9Of9ihhecRnZG9EtP4t2x3y+3CvSbf0k02ngb1xLF+UAEA9E9Rm74TC8r1Gly0jvjDl2+eovA7C9+KytUBHbXl5bDbE8i4Tx9OXgc/0xnRxBJ5KWcbWdTHrIkLF+4K5T8h5zPiTGJNYLkth8Y6h6JJFY1dOnGQZ7ODurucJwxepVyw9LQVnBJIoMB4DB2OjxeovTn79F4uAERZonAmToz6LAJs4lEEP7pULbAzBxh+7GW5VsBU5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq2i4F+kTVCGMMTwBF189DUElHIsv/SIXzXUaRl5vIM=;
 b=aw8Zt0nrSUX2TBIiensWWITbYgIRh6kmZZOY0RQPupfIecrAinhL0kjtIuDTU4qL0RGF2IVJnWo3DdqkR5qn+UQonqVhSyBPoWRcm2nDnOOtzazBfRJJ8B4kxm8PX/mmj0tORKgrrnL9cHJ7yCjZt6i0snW3cAAqCGC8JbHtUWHhuX6qZ5czKmN1gP1SgFje9P3KOspZfQGIr6Ymm2mAwT3V8HVNTRht9sJxQ8OrSjhPmagoLJag2X1z8ok51eYNLkB3DyOSYBPe0j4K9JwfWtP3ShifAp6D3N6k8iBpQxhzXl6pbMKw009AKsIZZVngmj+sGghlxTwg90wOmfxqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq2i4F+kTVCGMMTwBF189DUElHIsv/SIXzXUaRl5vIM=;
 b=dFNFI7ZGhYtAu2cS8OmGvElq8xSX5wvUE89yDxzD7RplhIHuqek0NZVfl4tYJCy764NR5CW7DkfS/yMBCd3usLTbYM8UD9giyFd/tUGgUifVq9+hRaYwxsILBg6M7fc1yiNCPyGuQf0Bg50NJUzhZ4ukq1AMPHwcCSJyXxOf+jA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3449.apcprd06.prod.outlook.com (2603:1096:4:9c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Fri, 15 Oct 2021 03:39:35 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 03:39:35 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] spi: cadence: Add of_node_put() before return
Date:   Thu, 14 Oct 2021 23:39:17 -0400
Message-Id: <20211015033919.5915-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Fri, 15 Oct 2021 03:39:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7fa419b-67e7-4dec-d2cf-08d98f8d6855
X-MS-TrafficTypeDiagnostic: SG2PR06MB3449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB3449630AB62349277492B92EABB99@SG2PR06MB3449.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+qbEDCUh4wK5qNW0UBtPY0JI8Y/KgX9IE2qU5E7U56ERf7Ee2IG+bvVeC98+6dxE9cadrGzTLyxnzPTHFCKYziFGgmW5fpZpftN3rb7IHKHMYS19+k5M/0O/1oJVE1t3pYHT/O3/xztBl+NdEpuxD6uXxrnEEGmYt7VT32PLF7OxVPO/T2yMXAxq/M7Mkz21MwahZGqSkBRxc7xLgmT3NcjAefqfk1o/Rt/lw1kGiV5jLZuyr23hs7HYjPMHMGisPU8uPQJgGWeb6Dah1EGZd+A2asNRh3BHJXS5ocu8Ttn0ROGXDqLoiA58TEwtUssoRWwbRfxN+h6K3+xB8NKac/6oTmqPl+wnOJfyb1VcThUQ8EbozeSo8teiyGahrSiH/PddgeDDqxwLjmuQgzed9lIwZOV4gaGFgl+HraJKQfxqlDjGlhVNrhhQiemrUNlz5tCIuHPe/CoKxJvqa3JsIPi9fdIw7HkTe04p9g/61DTeKIudmznjPrmTA5rRFsGRIuzu+Q2F331dOt6JfHxTgiICJV/N5y6pRb7Kbf4ic0eYMijQmpVROURoVjLP8b+pkKzxzX7plzeO2D49J8tjbBI8LEfggb32ZWjI2RijNA/MRI6CEJbG+OIHJ+L1+P+TXUiPFwfit9syxBtwSSh5BAUo58Lq5WdEsjBwtzX53cBfdA2xV+Ex4XLr3M3Nb8mChFVXp3VoMLy0OLBpuGvNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(186003)(36756003)(86362001)(83380400001)(52116002)(26005)(956004)(316002)(6506007)(6666004)(107886003)(5660300002)(6512007)(38350700002)(66476007)(66946007)(8676002)(508600001)(66556008)(6486002)(4326008)(4744005)(38100700002)(8936002)(2616005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPRV38Gvbg1YCsWNJw0LWdwPbQyg1hwCPyadycFFC4b8VuC42pFNiPT1vEu7?=
 =?us-ascii?Q?UPsHHePvZm4Qx/D88bqIrRMGI79LQHqtr8iguxfwveX8lpeqFt2HR/QFXdWG?=
 =?us-ascii?Q?N8T3jm7svX0f0A2okJUPjdhA+PMaqfK3kc3YByx9byIh1OCYOg81nEOF03U6?=
 =?us-ascii?Q?A4D7ZpRJDxYT76Rzb5icvHMdlOTvOlPesFUShiDxvLjorjeLsAamZYNB05FP?=
 =?us-ascii?Q?Eb7KAVjpIH1qUxcVNvrHWO76QYxv7hgkq4Lpwg8yXHedvw3yhKNA40oK+qgQ?=
 =?us-ascii?Q?/QNYvkMSJlGwg4FEisv1hReWl98OaEoHgnI9n25y1IlCoH8a5LsanAa3rAQP?=
 =?us-ascii?Q?l0cVAR+ffigdWuXzpdjB5gFl8y7YC926So8igbweLAL37PmgUEOirHZh9Tgn?=
 =?us-ascii?Q?OkXcTJN32I6HqFbo4/Tr23EsHeAgr1TOmG2ACZTS2OxUpuLei1+V2JBWQdHC?=
 =?us-ascii?Q?Zc0PIUAvBX5kZzPbv9rM9E7ggPivHD/MJ+8RL4z8Qg4wUv3FBzHhOKmEtfeU?=
 =?us-ascii?Q?hXpTFPvzVAU9K8yck1lFi+hbHTLsJ1HL2WsHP84rkMtWXad63uz4URjWgGbi?=
 =?us-ascii?Q?OuQD+B8StbwPG+VYC4SxBWFULWD+3fWEXYXwQK/ekxMypSEgjpWW8jGFpOBN?=
 =?us-ascii?Q?q8HL2qhslanzOYoIoUnSLVGcM766YTCtJ8rkntOcNaYXmkj8GI9vO+q+2LC6?=
 =?us-ascii?Q?ErgxD0iaeYicpiCQvnePYyfcdMexnv4fqyfSCcX9m/biTieKCkq8JN8w6MGO?=
 =?us-ascii?Q?gHPvUqTbJ1f9hBNKphZ4V2cvO5dsr/OeiaGt+inBhpupPG8isowfZXtvGI3C?=
 =?us-ascii?Q?MRDq11wV2CCbI44esqMibYKzZCd9YnKT1SEDMT0lLetA52f3Y2VQPOcAPhfy?=
 =?us-ascii?Q?j7CBU1pVKFLWX9/pHUNvuNpRpzmounKmcHrjAy+KI0uay+yQCcXpT/6yWo+v?=
 =?us-ascii?Q?IF1GCIjDmwJSlT6l20AfqcLDBQenui/AQyjAZUnQudpcgOnhYEfwcxwi25JJ?=
 =?us-ascii?Q?TcB6i8BwRLXn9viMC9/6O4DM4wpAuKFUneBDwfBrW7a1htZXvPj1ePXUgAWa?=
 =?us-ascii?Q?RENkQO18sO74c3Y2tEr3e6GZ6ps2fNsc/2cG+jXEphdRPSuqTkCLOG45TmFu?=
 =?us-ascii?Q?ky7zSWRG19D2Q3NDldxmIoYMs6AXwTss4RbD6Ds7Tfi719/TzryjgeRN0O8R?=
 =?us-ascii?Q?RmajInU/LSlH/bZRrtleUFkpTjSJFc7wJJ+5keSNnj9AQgM8y/teSxsxyeKv?=
 =?us-ascii?Q?f+OScCkynWMb0L3H89NO3azpKJNNfKXKSst2Kp2CMquYiJW3cC9gK8gIgPYS?=
 =?us-ascii?Q?vVuyp+xK++fqG0i3VI4M+X8w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa419b-67e7-4dec-d2cf-08d98f8d6855
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 03:39:35.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbG0NX2GfB5J+koK/82m5X7Y5WDQ0opV9pR5Wr1yYT/9ec0Z2/W6Gg+ckCPsMrov9MJ5Hfa/LZCByjdOdPaPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3449
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix following coccicheck warning:
./drivers/spi/spi-cadence-xspi.c:490:1-23: WARNING: Function
for_each_child_of_node should have of_node_put() before return

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/spi/spi-cadence-xspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 6bd0e67fedf4..4bc1b93fc276 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -493,9 +493,11 @@ static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 
 		if (of_property_read_u32(node_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
+			of_node_put(node_child);
 			return -ENXIO;
 		} else if (cs >= CDNS_XSPI_MAX_BANKS) {
 			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
+			of_node_put(node_child);
 			return -ENXIO;
 		}
 	}
-- 
2.20.1

