Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4778B42E758
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 05:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhJODmf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Oct 2021 23:42:35 -0400
Received: from mail-eopbgr1300113.outbound.protection.outlook.com ([40.107.130.113]:23573
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235245AbhJODm3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Oct 2021 23:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haRdlLH6tI9ECdJAc28DVqyZ7nqMeMCvtB0An0REfh0XIEEX8avM1SKoHbzWwuiItWhfAOE59p9SXNie2X+p7oQKoSvYHqssuRHforOSL+t/qW9p/UMTj64ZRc5H9B13+wBeeZJBHZXZ+PbY0CPImCffPMoDrjelCiOyfB61wXEHTnuuw/15IhsIvAYr8WSrGqyb2545cCT9dpWmSODaSNC5Hy9AGs7wPIDUhO7XnC7orsx8PTCuaJ/XdeBU4/qBAzNozL+YcnWm/Yyd+3JiUxP2CbTorPEU2e/S/m7bVo7wXERrjPu4OfoUq1oVrKs906pZJvJoMtXV0OUTLeAx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpN1xoyiXEnPZdG8t64A+HLT4lHfXYdz6arezC0CmgY=;
 b=ngSF22mhLSOjGFBXjI6ggdbvQ9ZGb0gni9ZlpBdbs/AfeaQg81A/Kj9MNJskuk7yeNAtcquH3vqegaXZ26/lq7NUc4qPscCYGjygRb7PtwGVv7qaT/GEiyrmF6x+cLRY0vSPXLKUlw0CtPQSmLa5vI8pzFURRMp8LoCULVE2ArgxCXRyQeV0AolqiuF6JlsX+PgR/1vnQ233iYXvLiWUC6mi+lQl0VGET9URdfB4D1wGqhVsCKjdUmT+pDSCDxg5Nbn6+lts5wxZ5XUdxWWw75Gnj03y0KTy3Mow3v7vpWKnSMnLN0uJWwrFjBSz3RtOg9me5vDecG13yfg2k61lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpN1xoyiXEnPZdG8t64A+HLT4lHfXYdz6arezC0CmgY=;
 b=VjoM4vkiOHwXhAM7YotqQzFeIWd/6B+355lzNvsKZSw6Rj4wnyY0tHlLv9pQBjKP+oVhMLBpf8oOpfOHDSu7kYjOEYgsvOrbU60iU2FSrM0vAkxLrbAQwnTa9RJDQePp96s/XhCnEnqt6z+cl+P636dpG0SlzJ+sq+oHzOxg4IA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3449.apcprd06.prod.outlook.com (2603:1096:4:9c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Fri, 15 Oct 2021 03:40:22 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 03:40:22 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] spi: orion: Add of_node_put() before goto
Date:   Thu, 14 Oct 2021 23:40:08 -0400
Message-Id: <20211015034008.6357-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Fri, 15 Oct 2021 03:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa885e04-c0e0-42a4-e6b5-08d98f8d83f3
X-MS-TrafficTypeDiagnostic: SG2PR06MB3449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB3449C3506091C9309E6325FCABB99@SG2PR06MB3449.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1O4hXk21Bi+8sJBvW7vDLskWKjzx2gr4/B+XYloQSYJs1vOfzoT1zG4Ra9PLERNs8mgSu15orTzKObIjAA1aZltw2Nezez0K9avpd7i+UBOpcuCxa0lMYCLSqQ8zoMdZsO2jrmFg+QR4oBVqhOo6zBe5kRy6/pcOKRIo+8pMfM3uxX9M8JFVRCSv3WLV7NL3nkOt6k8C+vSTVK5xhnIMdfvP3WonVjs0eNt7anYAI125KWfTPEac9NWNX6qIPn+FO8QMfiulqNXrM4r6GOG19hcErAbNdSXGi28LajsFusmh9j/wcAElEhq9IWK42IvR/5sDA9xNW6vkBgLewlZPgseSLlBp+lwTlvbCHuWL3eIDk91r0BBIPhTIJZ6SRRk4xVTH24aLqlVpY6Nk7SesJU5+WybzNPCfJuwNNLvr2GKRBJ7earhjnRMFhV6byFsQrTz6eBheb+j6nsWTMLOQS57CL4nF5I876Zva9mgCXMNsca8hZUjxXqixdq5ngkQPzJzzugtmNr7iL28fXOvMPAkOVJUjInRTUiHMbpq0fDtVBVFjb/KOc4UWTSuf7F8imdx18cIM5QVrzw0y4BbI+bkNn2gFsYRlKNyfK7ZWcBwH6wRVST5LoWhnCxObIPStJoGDeul6Ep02ghpYZnPaJhlyj18BaSONihCeg4wv/wIuP3NA7TVkkbTmq8GpXlJ72hqpI6nKz9icXoDpiTdjgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(186003)(36756003)(86362001)(83380400001)(52116002)(26005)(956004)(316002)(6506007)(6666004)(107886003)(5660300002)(6512007)(38350700002)(66476007)(66946007)(8676002)(508600001)(66556008)(6486002)(4326008)(4744005)(38100700002)(8936002)(2616005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tm0+G0T3HyTn5KMHcUi2mPV6yXWjXWVNnR3yQ3+xfm4zZvpTMacWbnkx9Xpf?=
 =?us-ascii?Q?Eh89bTqL3gHtzzofesVd0MHjSHJquqLPolvXut8j1qTAyqBuY4QiF5LHXW83?=
 =?us-ascii?Q?6/hfa2Yl40jV0zE5Q942E+G4L3eVfwdJzqlUERsZtSH9Jpodm4KUJRZz5Gmc?=
 =?us-ascii?Q?mJ8vdljghR0OqHvRXB2jL9TWiLp2Slq8wN7sm5lq7glzMQSxjyntEojraJh7?=
 =?us-ascii?Q?LU1DXMCNtC7a0DSm3YdqqbXfz5L70ENP6m6PGp6UgiT2v1ejS3Ya3pIeJvQY?=
 =?us-ascii?Q?f4VYtEKSW0HDmPLvkLgGLP5Ic85bT059k5UWAHIT2EnZL+/QeEqW9AZ5/jGf?=
 =?us-ascii?Q?zCmKOytDXAW8LQX2LoSqaT4sUUHCP5lQwCRFkhV8l7ykrHri3I90svMApzBG?=
 =?us-ascii?Q?6Gx/hJ42Vwm6SX592PMIGOvHA6BXoQYSyjJoo7jZYYQ0LawwTsKcYNNZbO4p?=
 =?us-ascii?Q?Ux3/UUNpJCeucARij2ckYdTNPg3i7wpBMRC/1yioWmYVXdGu3rf4A0R6HfI6?=
 =?us-ascii?Q?a/EFlTEHNtLXvmu3GY3ildP6UTe2994DC+I5J5NoZpzQtNpkup5lRWbGr/8S?=
 =?us-ascii?Q?fOf++pQ6HhUIrdlRQYDZRCAkmM4WbaY5L2nna9iS8UhkTTU4Ba+W+OIr6lJd?=
 =?us-ascii?Q?FyjZUglfVn9Nkxd0GjTl3YM4k97AUWxsIOu1h6tUothuPOWwPoghLHmWnMaL?=
 =?us-ascii?Q?iMT0rGS3CXhtfm500W4mPI/o+3WJGN0/RAD5KR12HyNQ1pIWKZpSi78bkktm?=
 =?us-ascii?Q?sTixWlL2lvnIcLL7VSDN1aAX/7i8/piHJw7396jwo4Xmn2DEMOdP61pc6lB9?=
 =?us-ascii?Q?fWw3o8K/px2ZAvX2g/F7eHXyCkOtAftjFZXr9DN9L/xHallo9TmH7ozmXjj8?=
 =?us-ascii?Q?nQ45464glGsZ6mEEgwfAYZIDyKgnf24od4ZQjNI5Dr+GKOGcPsn7mE484SWs?=
 =?us-ascii?Q?YtFVUVG8ucxbidxB7VXZJEPV9E2eu9yulB5F/rnd5BOWY/+OjAF1rcwgdyWo?=
 =?us-ascii?Q?a4zNwO8wP09jjHk3X0mTfQoFUm199P5AQDpSMg9XekwGq2uQ+ZdHjWC30AfB?=
 =?us-ascii?Q?WGOuK+dTHDj5HU0lBRMh/Eqi6g5cEtos+RKifpidyUQsZk4b2CUVUX3EfWYM?=
 =?us-ascii?Q?HcnKlp6v+13CjWMw88Esth9m4w5X758fpBhaIRsOwARXQ5R04lOdSGq9H/31?=
 =?us-ascii?Q?HKhHKDTaGAoo5DXQtV/AKwNWCTT+WcadRcjEh2NMv1a2GHVkksyvNgbeNQZh?=
 =?us-ascii?Q?RlZ6V/VwUL2ExO/3nnPqNT5+htRg8A/hgAlpB8nfhVMdnatmw0Ft31d2la3Z?=
 =?us-ascii?Q?qiL40eg1BUlYhHPwbDzPziO5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa885e04-c0e0-42a4-e6b5-08d98f8d83f3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 03:40:21.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oaPOV7gBN7IXyR0Dtkuk1JL6HMe+DB/JtEYqg861wQd0rgL0ruBqKk7Q9/PpcEYO2PjGUOwFBsmaqT2r4TzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3449
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix following coccicheck warning:
./drivers/spi/spi-orion.c:738:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before goto

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/spi/spi-orion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index e8de3cbbfb2a..565cd4c48d7b 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -769,6 +769,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		dir_acc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
 		if (!dir_acc->vaddr) {
 			status = -ENOMEM;
+			of_node_put(np);
 			goto out_rel_axi_clk;
 		}
 		dir_acc->size = PAGE_SIZE;
-- 
2.20.1

