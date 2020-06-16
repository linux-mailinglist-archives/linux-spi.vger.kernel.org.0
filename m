Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC01FB4B0
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFPOmh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 10:42:37 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:35008
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728250AbgFPOmg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 10:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlmFNHGzSqWX7oBS/bxe1dV2JlBMgIrd9bz/7AAuJmo9dCYXZlmuJF55CwVo7RcfSaYN4G+/jNiVP9Qwgcff7RdF7FktbZ3w+t+we6WCtF/l9qaYhNHB/sNCwmlcxt9fl4hXPgdeCFEdHqyLbDQbPQkLf4g/eFyR6p6tW7CLabSm2aIQlWDeG52Odneka47shKMa90xCzT2Zy+pCg9JIow/oG5m95tGCqKhDr+lIYp6YM7ytWuh9H6NRzco7E0wtN1hZU5QOxBnEl8+tMLz2N1PlbUwKjCZ9UEyWiq4E6QQatiajTYWoo7jIto6qMzdCswrCZNuIZJEx5N/7mcwwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17dvcY0r/ZsFIaXwxfsn27sP1RMFkAc2DpDYVfQOo98=;
 b=eF4AwZ/RpeWr0xBZfiI5LXAeBtpIT7P2Z9ZEEOqDBwMtcH9k0tEmCp0GoBScZgctAnASlx3SraU/npseJcCn7PFNDk01cqHRYQ/UNT8/20fTVkH8MEpN+loNb763I71OlBVtshns111sqMalEcAepK0uuesdtLpMUHjx80PIbg/YHwIIz+TT+CLAEN8yfkGhJhpcGubbZUhxObbD4tXmv++S6jf0NlcvZnRBNfi7/9Dt7c43Mp0KrON21dT0uidEYQaB7wBcfOtetoumzg094bajaVBAhISyImCk9LVrBuolXZBZ4Xpqlj5H7M0Su0NQ7IaChwQD9dlhaOuCnIszqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17dvcY0r/ZsFIaXwxfsn27sP1RMFkAc2DpDYVfQOo98=;
 b=Z8d38Kvsnt3ru2/2lLm/ZOJ9xtItNUnm89MFKCCKAqd0fLxnBe6hAcZD7YRLB9cpptifelZPWDp/CNqCFpQg6DqUFWBe4t6HbCH+5ezdRpyk7QD4bN4a3HcVHe5UwvH6dDpTx8tw4fg9jVuRjT9A+9OT2kj4g0ESCJmFZXq/+JU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6623.eurprd04.prod.outlook.com (2603:10a6:803:125::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 14:42:32 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 14:42:32 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robin.murphy@arm.com,
        matthias.schiffer@ew.tq-group.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] introduce fallback to pio in spi core
Date:   Wed, 17 Jun 2020 06:42:07 +0800
Message-Id: <1592347329-28363-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0163.apcprd06.prod.outlook.com
 (2603:1096:1:1e::17) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.21 via Frontend Transport; Tue, 16 Jun 2020 14:42:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 236bf7bb-3f86-4d4f-9959-08d812038075
X-MS-TrafficTypeDiagnostic: VE1PR04MB6623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66234124DB067EE515B1F883899D0@VE1PR04MB6623.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03lEwRyYE+gOP7ATnFM9qz5ZNF1rdq9oeVMtdEje4WNtXWNXjFJj7PKbunSLeONwssg0o9VtJca7XNB719JniHxz0OJebeg+O9F/5g1NbTDsol0ZHW38DS4rTi1cA1mywestBJ+ceAWw+23JBg+xjXgP7bJ57otlP9aRq75nXii1aEnR+UzXQ+8nfDKrFTPq0DFQ9hpWem1S4tZTH8m/RLrvfCtzivEPaQr1gPtfbULSx3Lu6Dc+HyYZVleFls1BG0+QPAxG7IE7HZzHuJCS+UUsjyUtDS0xfZiZ5QL/qBP7c2mwKP94iSG1W3MKWqXTKNKhdO8b6+NpUnwehvDm5ctU/dX/0OCMXFPfUYTridK+RhMEFtt+q+gWPwrRb1qEEEsvOUmVaX2UnVrFwrNU/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(8936002)(6512007)(6506007)(66946007)(66556008)(966005)(8676002)(4326008)(66476007)(498600001)(186003)(16526019)(86362001)(2906002)(83380400001)(6486002)(26005)(52116002)(36756003)(5660300002)(7416002)(2616005)(6666004)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tM3bi+xCXwkBe7fgrfqhX1bPvTyY1HwbcQpGKrk1mFihDo6y19XuGvFe8MrkpnU1vrRQZOWbCXmdz+l39YRiqjKGP/mZUaSnq0AdFkYouAf7vlfKG/+/Ka8NgcHufVxqiJUo6OutMoHdvkAdpR0kNlB2Y3ZxNjINqUsYFhP+rw58PAmHAa8t1UvcB9xj0ANcedtuO1omFS/NVtfOPXEPwIgx8JdKACZ5ESnVxMq128m5nei9p84pCW5givy5jCzqjaS4+pyFBPKBwoNp+O8aONgC6MVMtKHS0+wKYPWoL/raaU2kuzcEFveOURmJeDafRSBAKCAWeAmn2u3ii9BVcvD+CoN8JmRb/ZnY+GcDaoCWtMEVQwYelSag5N6c0ogFqVxfu8xZkvFWEmofSnyusuAq0AttmBm/RvglH+iQkAoxoYj/Wdm8JbwFXsW0yTSkFiQI2S/9jDxYFDIOX88wDqWf2yeKr6BgtZDrcvFCXwA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236bf7bb-3f86-4d4f-9959-08d812038075
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 14:42:32.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysybf4oCANqVzedESP0nVvEttCFEXWx8JgB3DC+C3NGmKIgA4uX7bQhYES9PL3D9CjJJZpwZqowFfZxrDqXxiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6623
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introudce fallback pio way at spi core level so that the tx/rx buffer
mapped by spi core for dma could be unmap and fallback pio again. Hence no
need the below patch where 'dma_sync_sg_for_devic' to sync fresh data back
into 'device' memory and sync to 'cpu' again in spi core.
https://www.spinics.net/lists/arm-kernel/msg812236.html

If you want to use this fallback feature, please set xfer->error with
SPI_TRANS_FAIL_NO_START in case dma transfer failed(but no any data push
into spi bus yet) in spi client driver and add 'master->fallback' checking
in your can_dma() to ensure spi core can fallback to pio next time.

change from:
v2: 
  1. Add error flag in stuct spi_transfer and fallback to pio if spi client
     return SPI_TRANS_FAIL_NO_START failure before dma transfer start.
  2. Remove SPI_MASTER_FALLBACK set on master->flags since the above error
     flag could ensure no any impact for other spi client drivers which don't
     need this feature.

Robin Gong (2):
  spi: introduce fallback to pio
  spi: imx: add fallback feature

 drivers/spi/spi-imx.c   | 23 +++++------------------
 drivers/spi/spi.c       | 11 +++++++++++
 include/linux/spi/spi.h |  4 ++++
 3 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.7.4

