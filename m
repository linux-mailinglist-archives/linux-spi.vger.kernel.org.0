Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008171747FA
	for <lists+linux-spi@lfdr.de>; Sat, 29 Feb 2020 17:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgB2QTP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 29 Feb 2020 11:19:15 -0500
Received: from mail-am6eur05hn2202.outbound.protection.outlook.com ([52.101.152.202]:18118
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727306AbgB2QTO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 29 Feb 2020 11:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUp4VGOAu/hsVi3DKWkEe1dsIJMSCxzlCRV+1gXScKNM8PnFkyNxiSg67pIGlm8cbfmyODnR3Sl9+HwiqVyqGLh1PpVVeKNyPWhwoSWXLBtr3svwbFlmuUAixyfeVrDHNBe+fBWNU4uVGgBxgCdyxmwOVq1TD1U5sEgzQkC0TZTttD0Q86x+SBgeMTqDefcld7eBYy9hImnXkZfOT304mYLCzje0PrqtqxPyfMWeRzm+rVNLzjiHNt/LOLDFGLMd4Y0Rmog76LlKZWkm2NaTXO4cSK4B6T+xME3Vcv3MTtBVziUwqdM9L9E6JyS/7eBMrLHXpd1Sc7hZEPoW0ZQ8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBveL+w3P65mqb0cynVeAJtK3CCR7mathV5B4/ddM64=;
 b=hm4pjB13xxQpVxHGdl6hSc3wonOFpsflFYTqac7cw9ojIDKw8MPvc83E6H7eIgc9YPVWA6TIT4flLh9xcqiIixzGPzEI3jo7f7MNJiSDjAXo9lmW8aYOZLITPmbIOsgv10DjfN5QFn8jlWcRcF3n+zhJdr6mV5V2imtHBHzMHE9KO0Mgy15FiLJJeTvsTgAQ09xhoZGL+iyR0zHFwkc3IuMFtfTAneBHFh2YsOX+xOi/s4CUE0zKAY6uVptbeFVmKrUFWiocCk7Gm+C4+b7P/OcDaGW+fnGU/qFj2LFyFQfxj6pMnqP4ZklF09vGYBOPM3tG+lTXecLrygUTyrbK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBveL+w3P65mqb0cynVeAJtK3CCR7mathV5B4/ddM64=;
 b=WuXEIAFrdAPLj0ypklU0tputpc7L+ZVtJGZPnqauj+i7xlIjcy5ToLSJ33M4fnRnIVUvZ6Q4xhk4O5FYlHRsb7+QZJjqbfnADDXCuxoLr68ZtIxwU50bd2XXFwAQkpSjk7A0/wQZGq9ucPE5sYM0zm35nDZWTttQtpyHWqWpcf0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5581.eurprd05.prod.outlook.com (20.177.202.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Sat, 29 Feb 2020 16:18:49 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2772.012; Sat, 29 Feb 2020
 16:18:49 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] spi: spidev: Fix messages in spidev
Date:   Sat, 29 Feb 2020 18:18:39 +0200
Message-Id: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::28) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (194.105.145.90) by PR2P264CA0040.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Sat, 29 Feb 2020 16:18:48 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29aafc42-2239-4412-726c-08d7bd330f0e
X-MS-TrafficTypeDiagnostic: VI1PR05MB5581:|VI1PR05MB5581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5581E72C8BF31F198FB2DEAEF9E90@VI1PR05MB5581.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03283976A6
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(39840400004)(136003)(199004)(189003)(478600001)(2906002)(54906003)(86362001)(5660300002)(4326008)(36756003)(1076003)(316002)(6486002)(44832011)(8936002)(81166006)(81156014)(8676002)(66556008)(956004)(2616005)(15650500001)(6666004)(66476007)(4744005)(6496006)(52116002)(16526019)(186003)(26005)(66946007)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB5581;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HG7J4nULmTzBuBcdrtvXZC4nY69lqxf2UAIvYwGzumyIMzctFr8A1H8v5KxjnA3itP8+PTkp+abaTWljw7yn0Hy+hyAompk5U7VhniJvgw8N0PolvB458XBeObDpROTTtpPnXZ7jaMsh7piM3mAd7KLR5avGRJ6/NdpAiabL/cZmUsXyRgf+zF8GaGVadJo7gkbSpdsNv1RGB2E2ADp2YZtrLybRobLlf9/534xjPFuYz3FNl3BYuSft5JFpABhE0JyRhFJBUOYZxxHQCdTUgt7YsXjT7p13nDA1nZiPOo3fCRT9Bf9D6StkU6yTSJsOxRTAkGG5fD0MTioZsQXgyHqr5s75v6Xg+l+yQqlXPM7prsNNys1L4WHJQ5/gdDmvG5TThC6UXS1/xyerWQ7j4gMLTmTxWbGt/+IRjc0iIxt0JSyu0n3X4A5G77xb1+0/eq3j96DeNdy9tG3/Rcs3gDrs/zPQgo36Q73Ja4V/c+SV2cYZQzzDM/RlqnuyNsyV2nt1M5561qfZPsTPti4DFrNqp1sYhApTK9YcgOddxg950zEZi38GLNevkLxOmcSrOiGUghjxSQEBzC6PEPLxnCpe7hZMPJOGPFJCNiyMKf/tDvtD5H8ppA0Udk3Np1OEu45dTpfJgHim/ayimAmSyF8tnkbgxYpzlS5jDRzQNYtnYzeVBgAWYRvXfwGxtD5sgQdA6vVWv+C/M0mu7ailCb7yuOlaplR0jnOR83Q9ZhV+Tt8FoHA4CFL2b/R49eVLfMR+6rSQBGDbp+rmaZFhqg==
X-MS-Exchange-AntiSpam-MessageData: qyyT6KtTJNszaOGKyRM1WqEXuigiAeZmrjqj0Yc6IAQtu1h9gz/jN4WPSkLjdVW3xI6cHyWVueiV+Gq7BxKrnOgCXnTHjuwCAOfk7iZYL8yZMjPR3HUc1iKOfKlV8d+r6Rjy/Ly+DZ0WYeSNKWv1LQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aafc42-2239-4412-726c-08d7bd330f0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2020 16:18:49.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bqivpgyPpPsQRh9cP2Asx3EuMbABO0884at0sIJXiLDvQUb+vbHOtyn3h18gWgTsrDHVFXb4bVBAhDZZM7O15Nb1NvdTzg38c1INK0LLHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5581
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


- fix the values source for the xfer debug message.
- fix the "max speed setting" message showing.



Oleksandr Suvorov (2):
  spi: spidev: fix a debug message value
  spi: spidev: fix speed setting message

 drivers/spi/spidev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.24.1

