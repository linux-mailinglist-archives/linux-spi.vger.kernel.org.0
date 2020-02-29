Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831071747F9
	for <lists+linux-spi@lfdr.de>; Sat, 29 Feb 2020 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgB2QTR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 29 Feb 2020 11:19:17 -0500
Received: from mail-am6eur05hn2202.outbound.protection.outlook.com ([52.101.152.202]:18118
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbgB2QTQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 29 Feb 2020 11:19:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADsCManT+AainKl5i9X5+zvHTTKmkjep1WstFvYF3Z7P9j+bnB2peB0o+7hxwqaeeucjY5M3Jpx/YAkpplJWg590GSPU0kpnGWnzeNN0qiGs3Sg26QwCuoG1jw8/aBNodIWA0zKDOVKo1RurTP4ukGbzyIg4esPyhuhHklnLpPED2J57va60XFtE+WwXX5+7GeR0pJt6gXDihsfh6Az5I7+0KRFHpY2UJXmm1nfyeT8YQIF3dwQxVP8K0MdR5agVbp1TK4Vw18/5ZVcVT7uo4eG1P+ZD5/pzM5sRNdeoip4kpuhBRh9d5iYLFOyaqzewC4jy8qAjHRr39vFeoGJauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dx1t2RQ5/QjbB15WBRYNhP5FjeKTDD/gThb77QhS8w=;
 b=A1wgGaeFA+FDueU6emPnUqjlxodUPie+mRlKQn+TSe7Xd4zBGBgsWusvJyztpTByMiK8024T+SVjvux/p2OfXozF5DQ+pZpMdpfBOfcaKwPmo8kc7EZngCWLVetlvZSEvfnL2+UZc6FKJjvWRuQVmEILK2p3EqhLSHb7vWoc46nCRk5jkzCBN13m5RIIbjFrGZ9ZjEF6JwZluu0gmO13GqcH8IOmamJHe6aamPlHsdT9CvI2t6Sf2/Wcr/QpgZ0T7s74lRXW68rTKHWKdEmYT5E+AeVnSOlpQMO+/hJwKlRtY2Vbi7CjWQGk+nIiCiTNCp8AG/m9Ijis94MW2+j3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dx1t2RQ5/QjbB15WBRYNhP5FjeKTDD/gThb77QhS8w=;
 b=SOoitiHJl3qfLD06jxOknqG4uY10uDvLrRpR7be/7OMNRN8cBgZfPanRwZpjiypcApv4bVRX+CDTingvODuGPhSZxPgciaBX+UzgBO1s/nGfy3bjmlePsJfeP6ubEkaAsSjJjIDvsthjaJvvW8VGWk1W3xzKbHmMidRZLvCvZns=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5581.eurprd05.prod.outlook.com (20.177.202.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Sat, 29 Feb 2020 16:18:58 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2772.012; Sat, 29 Feb 2020
 16:18:58 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] spi: spidev: fix speed setting message
Date:   Sat, 29 Feb 2020 18:18:41 +0200
Message-Id: <20200229161841.89144-3-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
References: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0046.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::21) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (194.105.145.90) by PR3P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Sat, 29 Feb 2020 16:18:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5970205-fb10-4aad-7135-08d7bd3314cf
X-MS-TrafficTypeDiagnostic: VI1PR05MB5581:|VI1PR05MB5581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5581944FE89A6C8DC6B606D5F9E90@VI1PR05MB5581.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 03283976A6
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(39840400004)(136003)(199004)(189003)(478600001)(2906002)(54906003)(86362001)(5660300002)(4326008)(36756003)(1076003)(316002)(6486002)(44832011)(8936002)(81166006)(81156014)(8676002)(66556008)(956004)(2616005)(15650500001)(6666004)(66476007)(4744005)(6496006)(52116002)(16526019)(186003)(26005)(66946007)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB5581;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PonE2eLV5muMcgyLZqXR0BfigvXrP94VQbYNml2ZKREIGc5ZZM7CtHTA2nbqLJxaZSz8EW2FeGEjALY7FFUbx8+9Qf18JCdEC5qPWiNVcNBOP5Br1T6MdcPs8dJbN9JMiGjlWJBgJaCvuEAeLBJg7l/7SUipFkLE9rMM9OOUADwWE58M+c5Osou9pgDwvaqXIwWpqWwgVLW/L34RRqmDuRMj97eUt7mgh2KnfmNsWbn2xetLINYz14NlYlpsenAiWUOcXUsLM9mawFExiJfPGPdNMFko4DbW0fIdHJswZhBrrPRtEy5UHm6Xnwmu1rsBTJq3xOLwLmdApc7WCxy0aqZzA0X6Om+vouniVFe1fKMV6WnYHFYXYbHhJhl3HNnRxMNIwj3Pbjv/xXCCet7CHi/Y4eLib0S5cHkHSoki/aJKxgwXGQfAYYXZN5kBCB0NGVR062XgtnbakrB5rwMUVKYPs0YZD0zZWl+dI8txT3E7yeGwYyB5PACGTd5Q89aBWZ3oWDl6zGCnWgqA9w9dIt8wtcfnOpkBXaJemOhU+2kFMHRCGpeIOwTAs/mHQVSQHZ6JAL6WXcqsgRKIAnOZlrsB7sJg4rIKHy0ajRKfScBiP/DSMZd+0Z1A2X9+PzdfP+DjNcg6kYzu18YGKaseba1daSZE9csgeJ+ItqBbJ5dBC2HmH3wW6DqMBydHK9FNXekbI2zLzmg/FhnoIaAIAFMFZzWmQxPMmAjE3zQhLj7gs0CXodyUB6tntmOvPDpqKBaS6tasbxLN6HkFepxpFw==
X-MS-Exchange-AntiSpam-MessageData: mM6CnhwY5KrMAmGrpfUrKGXks37vU7p50Z0KmKbYH1e1VUqLMYxTDO6+5prQ/rVV4g9faiWBvpMw+7L98UoyH/0kD8vU16ew8Bc9VYglK7p1edwYt8blk2GGd9OGxr0YOtgzBW7F7+5KUd1d7gTV7Q==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5970205-fb10-4aad-7135-08d7bd3314cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2020 16:18:58.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RYYPfL2233vSHlXRa8baqZsGI8iOMqDMYUF3keOaS6eJFmm/condYtdK8WF/fl9ITTC8qqtiPdxJXfdLD/Nifeby0GPyafeEWwLlFLb6Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5581
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The message of max device speed setting is shown when
an error in spi_setup() occurs.
Instead, it should be shown when the setup call succeeds.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/spi/spidev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index c97e853dbf5c..80dd1025b953 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -454,10 +454,11 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 			spi->max_speed_hz = tmp;
 			retval = spi_setup(spi);
-			if (retval >= 0)
+			if (retval == 0) {
 				spidev->speed_hz = tmp;
-			else
-				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
+				dev_dbg(&spi->dev, "%d Hz (max)\n",
+					spidev->speed_hz);
+			}
 			spi->max_speed_hz = save;
 		}
 		break;
-- 
2.24.1

