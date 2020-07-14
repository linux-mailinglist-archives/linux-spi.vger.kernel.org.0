Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846BF21EA9B
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGNHwu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:52:50 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:64598
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgGNHwt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWBV/I7SshOz882CNBiSCOe8dTLqLdvoZi0yxIf57pXrJdjcbeM9kHNOvrbRjHvulx0NH6S/b2iTekxwEFl9RbBtdmJPkXmZVOa99pzW7M9XtJLzz37lawNA3ClA+8g5Y2G2UwPKpZHkFX1TsUU/5qke9hRriOJX3E4qxJ4ROo2WGhvQCjF8qiid0MATXq3om9j0ybOQNPQRFWTGJ1T6dkzt+/5tWlFrqWgSWF6P6QQVz/O3+LGnDPUOAdq1gzAiNzG0QOKDkByswSuwTbjKebjPZFlyyqAYD04Blq7MNF4/IGaupXR5V7/au+QRHv+gfCa0q18St83KqCWx1PXzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAX/VOWe5u6r0maIKiHNTQNUXXJ1/0Y1jndYh9bd8p8=;
 b=Pb30PB2dFquYkIdzxNzPv9HcJV17T1ix2EAc+w0Smj2Y2zUT5qUOX/y2UdPEhjOyyD3qcQg8KFoF76pZ373sYy0hgZUeVN6zoMOBf35cvaQM+rds3txFRXUcSP0tRgJRv4wutKRzsYqZMCNeyLTrkkBGa4i8HqDLzqfMsPUoAkv2wHp6KkER9F/n+XKYSWkPsu8XEi8MmyjDROWJD54s9OG5NGrCJAde7KqJSkn8Apug9fIgaO09IY4ZS8/t3lNxQQNoCS5/x4P4nSfDdn5ULu3UYhZ8rvSc0K8EzPeDNLC6fgzx8t51YMeqpIJwewZ7zRUAmks8TTd/lRqdKcXfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAX/VOWe5u6r0maIKiHNTQNUXXJ1/0Y1jndYh9bd8p8=;
 b=E41YoIkuSq4FfTs9v0w7z/UF414L1vSc2HEmBu3Zh6ei0d+7bxdovDxMOyljhrra6Jtor/DPndC0QOMgZ2JjvI7pPOilVAs3ZutKWY+3aehBhor60PcZdCDLeEjYsh2PKGgnzKE8mi3lW4L/WjBFatAYWYRSBGzgEUa0lRxHxhU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4854.eurprd04.prod.outlook.com (2603:10a6:20b:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 07:52:45 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:52:45 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] spi: lpspi: fix the imbalance of runtime pm function call
Date:   Tue, 14 Jul 2020 15:52:47 +0800
Message-Id: <20200714075251.12777-2-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714075251.12777-1-xiaoning.wang@nxp.com>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:3:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:52:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dec0f567-8b1d-43f3-a7b3-08d827cae4c0
X-MS-TrafficTypeDiagnostic: AM6PR04MB4854:
X-Microsoft-Antispam-PRVS: <AM6PR04MB48545E6001F35F27C391DAF5F3610@AM6PR04MB4854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzCOYGbJPrnuj3PKtpb61Wc+PupRLvDAcJ1bGJRQe/S430RqqjsT09ddfpJCcO0iMLgrAU079P4dWJoNzEILR1eaO1z45Gyfgxm9ia8KQ3VWAYjSdPzX84Oqfc8IiOC/0gGDQpHHF1gVGkawzTSUiD/Z6dKTs6I7fRnmvtuD1Y2IG1Okpg4lhT6+k8BkdICzJH0HKYnC9eKodSOlDFsnkoSYjb6iKtJjgmoga7+fYV7cwXDQAZHuvrCYy4H7p05XsNNerz9AvzTiNWZpphHlHaeeZteJuT95/4xk3GVm1LBjJ33YfHM9SvtZDP/OD5atygcxqrsc+DMDhe0+7YLihDUy1b50oSAdPZamS7anSNt/kp4pVWPNcvyELjjjYQ2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(66556008)(8936002)(66476007)(66946007)(86362001)(316002)(69590400007)(52116002)(5660300002)(6916009)(83380400001)(8676002)(2616005)(956004)(36756003)(6486002)(26005)(1076003)(6512007)(478600001)(2906002)(4326008)(16526019)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RzP1+Rb5oVe54j4KEI8SLMyttQ9V8PY2T1u01KxFDnnkQ4dAfyCu8Wn2fD9JPXjNQtTF2MJsMq9aj0833Z2NwiKHjF6S7PvuIOhuoqSbc0YE/BRVUK8XOyfILHZYX/D38SVkdCTaqb/uI+3CHU32buvHbuPIb7c3OdlYJBrBUmQkmqVtTE2QjZ5raNjtHn8xb/kMQHTAB5hXDJjaIOsFGNzvxK5ezFmkmi/JwA9hF5kp2bLe3QMgBut/v8YtxQIWrAfb4ta65EgI+vHDaf5HI7eb9XaXaA0tL8fiQjJk4vqdeVPSZ+dnVMCkOl2/+lpAbRAJgXCPi/ugzEYntP44Ws0JAwmXqR//uYcEOgGN41EvO1cApnTCiXj8rDAgAo1i5Ulbu6/4xbyt8Wa0BQTGw4cl4F0E+5meDu5rKkBD77aT5RSVD8YumTpQxTSNDFL/SIV1q9YWk5msfO2y10sC88JbIGfqE65EgmivXkjuHxg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec0f567-8b1d-43f3-a7b3-08d827cae4c0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:52:45.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xephH3Vmwik1/GCWAGVZ+FK+Nr6o4R6TyGA5bWYgC5F4vzt4rz0erYA/LtGrfQSauw52/2Ms2QutFKbCPWnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4854
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Call the put function after probe successfully. Otherwise, the lpspi
module will keep active status until the first spi transfer called.

Disable runtime pm when probe fails. There is no need to active runtime
pm after probe failed.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1552b28b9515..a1555bbc5e5a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -954,10 +954,15 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
 
+	pm_runtime_mark_last_busy(fsl_lpspi->dev);
+	pm_runtime_put_autosuspend(fsl_lpspi->dev);
+
 	return 0;
 
 out_pm_get:
-	pm_runtime_put_noidle(fsl_lpspi->dev);
+	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
+	pm_runtime_put_sync(fsl_lpspi->dev);
+	pm_runtime_disable(fsl_lpspi->dev);
 out_controller_put:
 	spi_controller_put(controller);
 
-- 
2.17.1

