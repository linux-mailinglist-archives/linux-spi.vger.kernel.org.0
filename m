Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5CD6C458B
	for <lists+linux-spi@lfdr.de>; Wed, 22 Mar 2023 10:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCVJDF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCVJDD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 05:03:03 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AB47AB9
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 02:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+P+Js/qI1FKtX2/S3hLeEtEGRNbBShV1hgt1SHogaBSgbNeCojzzZx2pxlALaCWd8HIJqclO+U72XQ9WTLLo57D8J2Wu1039dFIQHQ9odhC/Gd3v4/ioliLd0pG4pzIft9aK1RbtTjAPRLOnjeC3AvMg2G61EB3qwrS6eESOeWHrqxiTV0xGd94CS0ahI9Ji2hmGKp2pLE0y1UtaYfHBkHdec+4yAmHpDpFGJHECj6JgSgG6E/5LCQk+BnFphYZxGKuJdVbVLkyTX7sBum5vhr9XPXlcWlspOPI/Wg4zJTOjtomc2t043f2jqPQEXOkTgNU8JhN1y1i0X70NwMYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COreK4QkUSC3LxZV5C5SpoXHE1O86YcSNE9ukcUbjmE=;
 b=EUV5OSpT6g9fmnULBxgaOHV9HJgMmjnPYra6xg3JYBrDZQOigJaCLub7v9CMB/Nrcv94GYx6MyZFyVAVLrS4Osp4XvZRwZyZWzc6gws+h9J7UlqdZrC3DDnAgnFjO9S/qcg3PIfy9Y32C4JkMQf7pbp9wDmZABDoAaW5CbZC9gVmHTL/JQwOSUP/j2RPDpp5NbSy5VHCaiJ+BLN3YupYpoaZyyOYzfJXhT4MAyehD+t1vH203W8c6H9YE9rAwrAtV9aZNL/MUghQyiq8RO2gll/VDL3Q/BObeqZPvimzkP1l09oZ8aAVEY125Q3jMwB9zQY6qtFlQd87FLNA6010DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COreK4QkUSC3LxZV5C5SpoXHE1O86YcSNE9ukcUbjmE=;
 b=Jcu4u2c06olMqUCXxOEin5pHyK12Z0Ou9Jvza77s1lsgnoXbKSWGNPz+ddmGsQDFC8dfKqdJoOFd1qS16fYNbtfOTUSayBUjEUrkQmK1cFJkt6yfigNpyPqFic5jwbdxwq8KZKf/f0kmKRNlqpLxFsrRWWmVKvo+AU9ULbVTvWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 09:02:57 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::df09:aca5:4487:9fcb]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::df09:aca5:4487:9fcb%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 09:02:57 +0000
From:   haibo.chen@nxp.com
To:     broonie@kernel.org, han.xu@nxp.com
Cc:     linux-spi@vger.kernel.org, yogeshgaur.83@gmail.com,
        haibo.chen@nxp.com, linux-imx@nxp.com
Subject: [PATCH 1/2] spi: spi-nxp-fspi: correct the comment for the DLL config
Date:   Wed, 22 Mar 2023 17:04:50 +0800
Message-Id: <20230322090451.3179431-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e63515-7b29-4a79-9621-08db2ab43a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M28xyKDyqZU86m0Gg7VkCZ0gxVrtkaJx1otl74NyHmIk0iDH5nuZCjQAxUhx4jYfbKNBHRXXnj4Sh2nfvQjyebnC9afpbfvGF2WHZlMo9bNgCO4zaKhpvFa9sBUkiQDd5jnct+ql7gYIp43OsxnctXOnlu1ZYsGCno9XjlCK7npUoN06CWbmqfWL9iwHr/6nlk3If34Dv11HKZXzJIJ2T2uJ34cjPoU8DlZxf0fMjWhBEV2h5NEI0zistZ3+gsNZGwqro07RGs2Bvtv9rBFxL7yvDMWX6jJVLg3W67i0eXdE975S8FWo3ThqgAtCFDNxBeFMl9l3Ml7kUA6ox0m7+XSf8x0Bz/yiwKyWxUm2xMXX6ATDNSjqF6ly7SQMoG5kQwvPvNjeByGWLOlQnagM6b3I3erQSo+46n+PWQLC7EYROqm/6WxRnHzuwrvM+2Fe85Et6WNCLQwlDz4m35Ebnrze11Moc/GZkvrh/VTqo0zULMgYoTXUgMqdYW0e0RIZSgxfjOMbbM1sRejoj1UJqxBsthgyJdqqUbkwZYCecafYx9vOStrzsGRpDsKb4Xc8iPXstwSVAJ2IWNV7NSIEvLSIIOAeMtADiw8dlExsI4emXzIzXi6mD+R1WW4VYd9g9srt9gYQ09Yrisic/Hjudg8E/MZ4hIk6s6Fzj1mneSbJ+iHXI+NuZHIMBdSBQxl7HD39ulfu5ZLD/cK9Ye3WVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(38100700002)(38350700002)(86362001)(36756003)(66476007)(66946007)(66556008)(8936002)(186003)(8676002)(6512007)(6486002)(6666004)(41300700001)(1076003)(9686003)(4326008)(478600001)(6506007)(316002)(26005)(52116002)(2906002)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pDH6hoR9O+4gbna7+YZItnQ90+oaen+Z83iOagmF039FXiFXU/+YT58Edl1?=
 =?us-ascii?Q?MvlMtR3XZX6VEQnZ6ebSeFy8GD2cunhMJGalrXC10qpt/Hy/8NZKzQLDq1wS?=
 =?us-ascii?Q?7/pDvhzh8EDLVcUkvvGzHJ73AB6pYXFI1sUZuP4RTSa77koGQzHH8ZvLVbKI?=
 =?us-ascii?Q?20mjS1ubkLl5p8rNXpY5AwDfGvdFAnofRCrgyAOJ7mFpxmV6rWZoBpiTGw8y?=
 =?us-ascii?Q?3n3oJoVQGG901qs5IsX5d2Na1LKaufYQZHr03eQ8TAlEt1pIZm1At//7iYhX?=
 =?us-ascii?Q?XbAlVAxpvHhC+HiVPWCif5s0/pzCCfLgTx64gZLxn4tLEQtmRPGiHZo+GFoA?=
 =?us-ascii?Q?Qi+ttzV7UexYiq7V9agCI8JihIO6k+vSgAso+am+Pndeio7orGsLebNHrWMd?=
 =?us-ascii?Q?C6HgEunRM+OCnO4Oe2hL1YFjEFX3UkgEkGQYrK8v41/bo4dUbmybDsfUvCyD?=
 =?us-ascii?Q?AM0I3s8cKbtJTM8phJooMcQPzZBxy5fUAq7De7NLq3LMDNNL1BqblugPG4Kr?=
 =?us-ascii?Q?uHHvS+kESDZ2B224eit0oz35IInwkW8C3yOrGki69OxCbogGYkS+K2Kezlbx?=
 =?us-ascii?Q?IL0fesaDM6uK0lzavE/El1lZe7Sh73exDJIAWgeXjemGrlxzApX/FIuaUmcN?=
 =?us-ascii?Q?fcrSVwFTcXM8OS2nxB6jKnA9NQBOgFkP12Y6TxY7lgikAedTDcETgOmA1qJJ?=
 =?us-ascii?Q?JiXPYAPbgyreCI6oBgzgNT7JbZI6iUl5PQfar/VACwWnUqvtH3oHlTivsYUa?=
 =?us-ascii?Q?zMyuoFCFLUjQjFQt861RdwclzKCfRmcChx2jZEF9hY4bqplbXfQJF+T+AQF/?=
 =?us-ascii?Q?jJ/f3L33j0z7ogJZz7bjgdyZNRTDIcWKMT7hXU2hwE5vpaeFrMU8tEioBeuO?=
 =?us-ascii?Q?j12GvIZOnwXStGUvaLoWxy+xcIegE5yjgxJp2u1vhUGumPNNYx1fNo7HipaC?=
 =?us-ascii?Q?F7Y8g/QH2hsOgrjS66kJmUHz2nzN95Ht7J43+5Cn5oT0oIsLB1VTaO/XNoVf?=
 =?us-ascii?Q?K6hrLWD5XHAnx8fk+C9jNGnu4PXH3QwbOv/OfFdMVNWyDkw2jNA/gmFAjxHx?=
 =?us-ascii?Q?6PUwVdo0OY4JwrwtpcUmkHwiWohd26p5OSEY0AAnfzh7Cd1diVgUpMSlyqn6?=
 =?us-ascii?Q?sN2B79WUT6W9bX19ihFZTcjggVPI4G83iEaXc7GbuLk7sy2pj6fVHqbO8pdX?=
 =?us-ascii?Q?r1fIza/GNi0UxuejA/GY4NoX4rlb/81r2g0bPBd90Dg2sXvAj7sca4KZBpPV?=
 =?us-ascii?Q?MNhkJrXRoBmMEaypaWzRtuXhNUKlgwnmdC9382IrrP3yLSlE0sumdTdpkcIr?=
 =?us-ascii?Q?wC719W1lRtRTwBC5ldwfjWe7pzuc9xzNo7vm4xBGxkoL3ncXaFYKB1gwrKjn?=
 =?us-ascii?Q?9EAuCMr2vDrX5ox2vkttgN9Z66CgfYxzhiGzxhDKHeiEcSYWidwykujjES6j?=
 =?us-ascii?Q?RNU/K8qoC33FUVmPAzq2nEGVrvC9CDgFhfzv1J8U1DFp98DQ5bs4gTC+3cCx?=
 =?us-ascii?Q?bwe7aCLmDLmc1VFnIDtaAzTfV/poxVJdLlZ7qqXla5pU0PilnfA5OhzTzKEx?=
 =?us-ascii?Q?0jptd7b1x6hPO87yAfJKmcce5XPe0Zwa+37eaoa/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e63515-7b29-4a79-9621-08db2ab43a65
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:02:56.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjId+IVp/AC65hJU1jynpt5HAIrleyw9No7Pp42mvgcJsKJhyflEeJXAduKvqQvF15lCMjmNaGm3iXANj91BUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Current DLL config is just to use the default setting, this means
enable the DLL override mode, and use 1 fixed delay cell in the
DLL delay chain, not means "reset" the DLL, so correct this to
avoid confuse.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 76168cc1e00d..6735c22b9137 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -997,7 +997,11 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	/* Disable the module */
 	fspi_writel(f, FSPI_MCR0_MDIS, base + FSPI_MCR0);
 
-	/* Reset the DLL register to default value */
+	/*
+	 * Config the DLL register to default value, enable the slave clock delay
+	 * line delay cell override mode, and use 1 fixed delay cell in DLL delay
+	 * chain, this is the suggested setting when clock rate < 100MHz.
+	 */
 	fspi_writel(f, FSPI_DLLACR_OVRDEN, base + FSPI_DLLACR);
 	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
 
-- 
2.34.1

