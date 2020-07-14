Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707A221EA9E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGNHwy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:52:54 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:35812
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgGNHwx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo72srigKPrLumzK52fTRRwy2A67LSsGw43pzhft9VXxGVKsXCJhovXzzAUsnMViaeN4IOYGYHHeUOS9BgGH0Wt/3itzD2+vH31OhlypSnvoGnqpq8o/FzYwEgzh19XHTrRjOGJJYVJMZzX8zjALLIPOkVWoZ71OIcumI1eouhwg0dh9VHvpyyYmRDhrrIfNn5eNvhKMM2HstwGl1TKVjGQjczTTzwQlm/kCR/zjq+0X9tjQF61PYs5yF+wNAvI+q615wnq46WG6hqRSmSDOAQRTvGwbU78KryMRP/d6N4Z9+Ralp20MKSkMvCV7q+I/MTfW31QXxyZxvMGefCPxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUQJSulBVBN9IJjpTdanbvR6wuYBkvQRquEWqqS9tVY=;
 b=Trot/W1O59btJBs1WqobFqwIPIfXIP22MXQl6GUeA+bB/sw96iDUDfocXKHvqO8Uzsy3cCcK6c1JO5/U9/bd3xe+IxUp/qnW9rrX9wWgelD8zmtz0eflzA68kaqiUkm2gEmGaciX/j6F4xAMq8FuOjZWTmebeoaqv0KJdhC+ysyJ/LOo+bZe0uonu/K3FKyUVa/2f+qFbUNX3BjtQmojuQEALTkDWXAkhFul3/3Y5mpP+Mpc2b5yFZa0K/Th8mwvq/92lRA5IMVSkB1WeAyUu/mXq5d9bUUAJrrySbv9oliXmKefGrsozK0ltX39u1INUNmaL1FRoTUVBcjBw6/Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUQJSulBVBN9IJjpTdanbvR6wuYBkvQRquEWqqS9tVY=;
 b=URDaHSGMjqDtOW2zV/HY5SYcaVpj+mcizHXViX1S24B+BTmBiap2TNGfWwF4QDuCsp+dCxFuRfocGucIU1RcKnNpSBVoJ5UFTwTdTRyY30pSbqev1k/tpHquAZvUriEyn7qyKJA/8RJqaU6sT6u+w2f7EJmyxkbavSEfgO1sb7M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4854.eurprd04.prod.outlook.com (2603:10a6:20b:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 07:52:51 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:52:51 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] spi: lpspi: handle EPROBE_DEFER when get cs-gpios number
Date:   Tue, 14 Jul 2020 15:52:50 +0800
Message-Id: <20200714075251.12777-5-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714075251.12777-1-xiaoning.wang@nxp.com>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:3:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:52:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a930526f-de59-46ff-4986-08d827cae852
X-MS-TrafficTypeDiagnostic: AM6PR04MB4854:
X-Microsoft-Antispam-PRVS: <AM6PR04MB485428C4A6EE79F0C4F91727F3610@AM6PR04MB4854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z60Zbmjh1nkYK+R3FhVj8Rgo3JJ8j1Imzm0ljZ+TybMIgwoG384rWmrEBfKCg0vdfa5W/YXDLr7eg9D4OCuL1L/JHtXar0WwuvNuDrHwmFEND0jZ4EtAgk9H2AErcDnbBowHBkttWA6+ZR57GiStq/PHP02xJEGh9Pax1Sp1nn87aibYUcyUtWAXwPk1OeSyOH+2DLe1iGQgrt+KWxT3jQpIb2H36KsV6ZV8WytDEtGq+4AFbFz4XHKtC7xIAbuKZISoISo3fDMm+AuiUV1tYGPaGfHshcSfg8U4bOeVChfRu65inZfdszDav6vcgH82TBNowxFFeGRwq33iC3QQvCsSx0hkSqy6kh0AfQDWlv/eyToWzmWryPYxL1nIDRxe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(66556008)(8936002)(6666004)(66476007)(66946007)(86362001)(316002)(69590400007)(52116002)(5660300002)(6916009)(8676002)(2616005)(956004)(36756003)(4744005)(6486002)(26005)(1076003)(6512007)(478600001)(2906002)(4326008)(16526019)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S39qZrTM6iScGjosOGDKJ+oQ7fd1DYWd57I/mCsYIt4W4kFui042Hs/eftC61nat7wJq3HCAyb0ycAmnRA/mhxIWpuEk46MaDdJIxO0I8g8rQQt0v1QTFVKkUVxbGG5LlTD/OzMCcY21kZTYqABFbL6J15luweIEjH2shvTu9yexSdvwoBVTqYse+zjmgzg8puyXc5BNvDWIJX19EnqShnYEgPVGr7GGzxUMZn5wwfaD5ryiJe6HX82JSEjbXAzt8m82grSbrTwBTu7rg3R4PL31NA5OWPVCwMhr8kNxEPJhQMXp82ntLFD8a9K/LOlw4zjL90kXIkRSsPvgNhj3O5qxCFrhVdDLepJqTdFHVrIAwI7J9XuSW7iPDu8prRVBEi83jDUuMK/vhhc98Yalu4znb625MZPl/7ZKtx5MBuzbqEg1DuRlmiE3SHhMlxhNFvZNES4+JtBYDoKtDMzoJCeFdFfsRDGjGujM1FSzjjU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a930526f-de59-46ff-4986-08d827cae852
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:52:51.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kkkzO9hEHgDSAWz+V/lPl90TjtHN04JiCbL/7MCtGhSKjfQWSUwLefKQeu0Ry4/mel4yehafThStDqWWP66GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4854
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Fabrice Goucem <fabrice.goucem@nxp.com>

If SPI is probed before the GPIO driver, it may miss the cs-gpio
configuration in dtb.
Add defer probe handler to wait GPIO driver probe.

Signed-off-by: Fabrice Goucem <fabrice.goucem@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 6fb77f0f657a..05b6ecd82974 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -887,6 +887,11 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		for (i = 0; i < controller->num_chipselect; i++) {
 			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
 
+			if (cs_gpio == -EPROBE_DEFER) {
+				ret = -EPROBE_DEFER;
+				goto out_controller_put;
+			}
+
 			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
 				cs_gpio = lpspi_platform_info->chipselect[i];
 
-- 
2.17.1

