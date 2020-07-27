Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550B222E445
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 05:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgG0DOx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jul 2020 23:14:53 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:43635
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgG0DOw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw/w4FKQ0ovYLukdG0gPx5xNG6NETJY6aUkXlWvuLfKxERDVnYG1Hp1nEFUP9NmxsoZnq63k6TEcdL5lp/BhvXvnA18+DSMsaD5iezko2m6I8DvMt692HaxcUMn7R+QkgWsbXIyqgVwZXRxbAa1kY+hEAXK1msQ1gSN56M9mP1Sn9OKi89fT0uAHaMgq9e7NwZJODuomZft3/YBfy0X/8ULwwdeAokMvQwHIf6DYXLCiLbe8v2UljRBk8xogtSEGk/bi9wGs6zRWQLlAxNf2h3w02dxuK1L0EuCvPhQBvl3Pe2WG2T909DKRciusc7cI2yAea6pZpm49lPY2MlEkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k2oQw4zSfzwy2xqEy601N0NRvEoH3B5ZCa2ah0KW18=;
 b=K4j1XGPmegovB4+CHH2uvq6f/QPz3xdoAWz0oCbgYnxMziLNNUySgMNw5KDStq48mxETSgeobpdJp2giHJitKNyVFDVIPgZkENtJ3hyaY/8+K7BDPpAlQg+QLIXvwdPJJTZoH1O59WrIgIoBwUDb39thJx9OdO8/GycwPir1cnclgmtaiOFruOH6NWLoG4kPUEtdi/B+ME/BKqyx7LxaFRT6aqEyNKqGo66sIDSulMhXjHu1knPheGxajlnPr0NWhkBQZQ++ez0pIfaVWQX6eWCLZRuN8Ym71DHEQlN4sZGT3iP1lj2YQiO1ux/BOJDW6eqLjw2Mh2/xPuq8CPQKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k2oQw4zSfzwy2xqEy601N0NRvEoH3B5ZCa2ah0KW18=;
 b=NBXz5jGbOxxDhDLoOXlrTV9qNnQKt1klWxUhNBa9Q9Cwaj9fwhsIuN7/KGAPeqQSpI5KMek9Shj42snW4fH84Ej0lmRakaswLlgQPRVihVbzQrGgdPz54svBhUPsF5FxpPKo+8+hZsq8eRz7bjdUtiWvpXZqd4DKX2O73f0wRAI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3880.eurprd04.prod.outlook.com (2603:10a6:209:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.31; Mon, 27 Jul
 2020 03:14:45 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:14:45 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] spi: lpspi: remove unused fsl_lpspi->chipselect
Date:   Mon, 27 Jul 2020 11:14:47 +0800
Message-Id: <20200727031448.31661-3-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727031448.31661-1-xiaoning.wang@nxp.com>
References: <20200727031448.31661-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend Transport; Mon, 27 Jul 2020 03:14:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a90975a2-47ae-4372-a2c3-08d831db365a
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3880:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3880AFEF740DFD1F9A8EE65EF3720@AM6PR0402MB3880.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXY1GW3en2lvH2FK0OvXSOn4dik1iaCoGAQlA4YtdaDxS+5W1SLAdnjkVImlQc2IpOKRqbPN23zpvk1jlY0GnwFTHKb/sI/g8Ec2hBYtoLfj0HSpMUX80ijN6+saSZP8Ca8JgPJZ2MW27NW1A50Cu59MWozZyY1XZJ/x2Y3oOKUuzgRZNu8/Xsx9BDX2p7pbA70Cr6XJLHVl6wGw1+vd9wAMDMt01l3TqQOMSuDSWIjDZIZAd50vZHdiQgloGrR576TrKDQctYict0mQdFFAH6FAY2NVmEChWQzOSzKZl4nTTFB6e9Gb2FRrWzWtFmKZHDIL9zLOxCxWQIa4PB3oEVPHucQrlymqKiFXtn5vCxZxNSiXWReQ3lrqQ+lQQyl1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66556008)(66946007)(66476007)(5660300002)(956004)(2616005)(6916009)(8676002)(478600001)(6512007)(36756003)(316002)(4326008)(6486002)(4744005)(1076003)(26005)(16526019)(52116002)(6506007)(186003)(83380400001)(86362001)(69590400007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zAYlmTC7Te2CRWypZTqWxERFhUbZUkXSJJBYiWaCEJ6BUPqDmX+wOTVf/FHaq8cCQZD/CHt9piYc7KGicJVtlihKsxHptlXf6uwbX8DpvbPNBDxbrL6Bidvg47XCClg/z2d3iQg6oMIPcShx9aP8cx8cQStpVPitLOALImidU0+0xKMapChcGCmOWbrk05r3GacJnNMBwAQH6fFQkR1uV3dM4438IqJ+TgyNEU5lIE5ZZ4jylJz4jHAlTHRdk3wg7daHAlSa5E+ELt4+jHHYL9Ngo56KyqHeNckIV6c9e+9lIdG3kujVOIABEIXTrwGzdUUkM4FPycv3mzbtiTigmzoFMQljvb6FCISYCFjoTeQdnEZz3ZbdhhG9DtoPo+CfWq/qTkQlm5q6zHE9B6zQUKdb1jIwaIRTZOHEy+MAT7LttKEXc02e4aVfFGsJ7i/xu2s5STGhB9bHFEHyBH0qdu1zNepVW23Ue5k07iC53yY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90975a2-47ae-4372-a2c3-08d831db365a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:14:45.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTnhgGu3l0FhY08/Qoe+auRw+RjbI5e/ppuKqxYt43ypOtvEzKFnCbh7hm1iv1Plh/ZX3Zo5JGXetXDnkKqEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3880
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The cs-gpio is initailized by spi_get_gpio_descs() now. Remove the
chipselect.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Changes:
V2:
 - New patch added in the v2 patchset.
---
 drivers/spi/spi-fsl-lpspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b0a1bb62f10a..1e426884ac37 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -119,8 +119,6 @@ struct fsl_lpspi_data {
 	bool usedma;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
-
-	int chipselect[];
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
-- 
2.17.1

