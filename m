Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B91747F5
	for <lists+linux-spi@lfdr.de>; Sat, 29 Feb 2020 17:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgB2QTM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 29 Feb 2020 11:19:12 -0500
Received: from mail-am6eur05hn2202.outbound.protection.outlook.com ([52.101.152.202]:18118
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbgB2QTM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 29 Feb 2020 11:19:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwVwxVSa7+3MmAvVE6obGga/rnzpYeK7Y3r3jeN7+ogN4AB75QtuwOcFbuyYlTsG57u/CaybC3rVjLENk1lMicr3emBgmopqTNIcS7KUX/8CXp30HZPKMRK4K6/JzfF6nfPQKE1Giug4OXe9Pb7ApHlxi0Vca5lN9X0Bwc2rN1f2VWnWj15p84+YMruCFY5xhfZbNELUQWBBjMuU5I6qGSqb4N+9dAGrHkW6FKibYVJD2G22hETF+MFRvu2B1G4QRiz7TqdPp3818zlc9nmAw1LkEsBCILLTy3plUkTEzimHbxkX1SNNK+6XaaE11HSN31Pr2KuwbcMrZwUvKVj/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWefua5NAciu1FBW0oGplXj83C+vzHIWrB3h2UTZ2B4=;
 b=N7Zg6//82GxRT+ebTzlBS11GpfLZPwwYVJvz9HjaQ++dRD8jMPHYlIm0OYVJAFaesPavRjoPY6viFV4qeiyzTVT9XV/2mthdNdSSizKWPmz/mE9v1m4bYpWvnoWmwYz/9lTNum5eN6gmCmq+gGGMQX4zj1IOTj2Ptx8Rks5KcYT/xbI3MA9i/wvrzVWZj8Ryo7FKrwvtZ+ZigfnLxomdCH0f0Qe3YWw2V1Wj02BSDuQs0nZyR8FBU3MYt7JNqXGggQ2Ls3rzZu2oDE7w/9tmyYCdHvoTZdrnYsrsqnuwh3qeT/fbMu3v+MueNfmAAR3Hou4b5vTwgmNyqywC6L/Ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWefua5NAciu1FBW0oGplXj83C+vzHIWrB3h2UTZ2B4=;
 b=kfT2fFY+WUkPcmrsYv2DaiJoy3DUYoIwVd6VP5nuK4cq2Eed9FKSmAG5dWEtafThiQu2P0nVegWQYYJvgzxNmBoqLfJbudoucpw75z8N7G3cntVUN2B1mFj0E2d6FBwYqwhSJGCUEzbnkVHIX5jovlFKfDrryRTd9bM7hsFJaDM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5581.eurprd05.prod.outlook.com (20.177.202.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Sat, 29 Feb 2020 16:18:51 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2772.012; Sat, 29 Feb 2020
 16:18:51 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] spi: spidev: fix a debug message value
Date:   Sat, 29 Feb 2020 18:18:40 +0200
Message-Id: <20200229161841.89144-2-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
References: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::24) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (194.105.145.90) by PR3P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Sat, 29 Feb 2020 16:18:50 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8caf336e-8c1f-42d3-1064-08d7bd331025
X-MS-TrafficTypeDiagnostic: VI1PR05MB5581:|VI1PR05MB5581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB55818A3BC9C85CF295BC3A1CF9E90@VI1PR05MB5581.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:294;
X-Forefront-PRVS: 03283976A6
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(39840400004)(136003)(199004)(189003)(478600001)(2906002)(54906003)(86362001)(5660300002)(4326008)(36756003)(1076003)(316002)(6486002)(44832011)(8936002)(81166006)(81156014)(8676002)(66556008)(956004)(2616005)(15650500001)(6666004)(66476007)(6496006)(52116002)(16526019)(186003)(26005)(66946007)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB5581;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQ8D+yt36F3ZrSV659KcBvAMrgoi2ggLa/UUarrlgxkFQwTP3laHV0lJjm0KcNGArO69TRDEEiy/brSV3+NVoGdhVCk7r8+BGCwk23wbtbllyybVhSRpMCHk0/9K2bvZIFlI5/RN3UfHHphSoDYHvnFgmuA/U4K4jUnq0WIDvh5k4Z15eoFNsl35Kpqo+TTqlhOuAlDj+9ko4LnR19p/atYKqVY58nexVYNI5iNSqKjxoGAncaVP1LAkOZKwCK5u7CwcOdRwaoNEyF/aHQ5sfPBkRB/a8Uvp4wJVIBFZSeObw96PRkfcruvQJGdD0e1ZDKv9tDdU/WZch2NyeePp/sx/cr0vMB4d7zQyu3Pl4gCtKuB9XSQ3jTyxDSRUYN0JODTXHRsvDpR2lVheIzmAcjXIMP7JqUHctUl4DAD5tUp1MJ5OhXB34Yl5JOS+zdejY/aRSbQzoz4QtnfEoximtZLvivyk8wjNAplAp++kb+d9Rkq9IZhFuFLz0SstfuhnVs4PD6c396NtnYS2bg+PeJbzyp7gTgwkKGoEOfltdK+ldUlJhDtUbKHTPsUMtXF4U9d6kcO9Hw2UTE97NNCPXkek14DX5c7g8MixFpkYuqGkQ+39NCzwlNB8I5dTmpHaMwCuVA3szbSJ0kt6VTrNVWU1vOG/30zRwHDioST/LnR7FeFG1U/UAMv1bErr3Hj2DphGvQr0gH/nWGJf4tipTvJtSQsRpQ1eftjiyqMA7STutFZK46xu3QGi3JLmd7eTzWGcgoKUC25K6pBUonivoA==
X-MS-Exchange-AntiSpam-MessageData: 0JR7Dm8SDPQUnjTXriS3SdaHZJaVztH7QfdkgaLa8qLc46v/45IE08sLEFiMTtuU2zUdvKeI1lAyzaxovGrBgMIj3bQMM8udG0AH17zNSn2UmG0z5ttiwNvBpVsKU8cvexJU+tYkN1VwXZec1hVGsA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caf336e-8c1f-42d3-1064-08d7bd331025
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2020 16:18:51.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYMhCmhbYM4gCwO1NtH3WarO/maNfEWcIApnMXvA4tXLfWZUf87sV3yCgIOl2UpAAyUCIpe2uJTw8vc7v+4BHF7atXTiquo/uonPX6N30qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5581
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The debug message in spidev_message() can show wrong xfer speed.
It happens if the initial (came from DT) and set with ioctl call spidev
speeds are different (spidev->speed_hz != spi->max_speed_hz) and one
sends a message with ioctl call and the field of speed is uninitialized
(u_tmp->speed_hz == 0).

In this case the kernel shows the spi->max_speed_hz value instead of
correct spidev->speed_hz.
...
set the max speed with an ioctl call:
[ 1227.702714] spidev spi0.0: setup mode 0, 32 bits/w, 20000000 Hz max --> 0
(real speed sets to 20000000Hz)
send a message with an ioctl call:
[ 1227.731801] spidev spi0.0:   xfer len 4096 tx 32bits 0 usec 10000000Hz
(debug message shows 10000000Hz that is the original max speed of this
spidev came from DT)
...

Fix the data source for the debug message.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/spi/spidev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2ab6e782f14c..c97e853dbf5c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -275,14 +275,14 @@ static int spidev_message(struct spidev_data *spidev,
 #ifdef VERBOSE
 		dev_dbg(&spidev->spi->dev,
 			"  xfer len %u %s%s%s%dbits %u usec %u usec %uHz\n",
-			u_tmp->len,
-			u_tmp->rx_buf ? "rx " : "",
-			u_tmp->tx_buf ? "tx " : "",
-			u_tmp->cs_change ? "cs " : "",
-			u_tmp->bits_per_word ? : spidev->spi->bits_per_word,
-			u_tmp->delay_usecs,
-			u_tmp->word_delay_usecs,
-			u_tmp->speed_hz ? : spidev->spi->max_speed_hz);
+			k_tmp->len,
+			k_tmp->rx_buf ? "rx " : "",
+			k_tmp->tx_buf ? "tx " : "",
+			k_tmp->cs_change ? "cs " : "",
+			k_tmp->bits_per_word ? : spidev->spi->bits_per_word,
+			k_tmp->delay.value,
+			k_tmp->word_delay.value,
+			k_tmp->speed_hz ? : spidev->spi->max_speed_hz);
 #endif
 		spi_message_add_tail(k_tmp, &msg);
 	}
-- 
2.24.1

