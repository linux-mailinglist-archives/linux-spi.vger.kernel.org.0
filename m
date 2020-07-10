Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2057521AEA4
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 07:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJF3O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jul 2020 01:29:14 -0400
Received: from outbound-ip13b.ess.barracuda.com ([209.222.82.195]:41500 "EHLO
        outbound-ip13b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbgGJFZA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jul 2020 01:25:00 -0400
X-Greylist: delayed 1928 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 01:24:56 EDT
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177]) by mx3.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 10 Jul 2020 05:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE9yJyWCEP7xW9NVnO8nOh3oZcSQPNgAl/kkCUBAssRGVYL66o5wjkj7nRN8VzYf3ba3mmjci4x6EWf0D7I2LhCYgPIsnqew24ogRwVkCuR05ZEAbyWGm/EkzHIcm6uop2MCue+rL5qMN0Yctt7vz1ff8kFGExHBFNNNxaEve3VZpwbDb+q1pcW0gAG3oiD+pmOlQW3tBcwoFpRqp6+8s6pJW4b8VusmS8b9Gb/YOD/LM9UP8kcOGnjzjHNsMar5Tdre85ZgmjPN2ijFSX5mXuXG1iyABv8GLcvqyP/NXLsnBPSC5JUykb6QVxsm72y4D7H5+1bCYNgBy/IUs41pLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB7LHCU83g3GScrDEkfm/x62x74cFXbvcHPqH3RRB5c=;
 b=ARXe/SZUDMHaD8sUEPAoWgKXskP54d6Iq3gQW+2oeeEF8ZU+kpGg/HAoBeWBR+ypf2ZchqME8czdEENZNMJTY1fC0BslSFRDgwMrAwBbcVS5SXWmtDUkcL9IjE1fkuHNsvwLDbK2svK9kPTikWSzXfAhQnwMMn4wtyKlavrZvgcrPWydtdHRo+DZtayEq30e5lK+PRM6738vle/tWrM8xOYO6DELO7o3YruJrj6dSN0GxKKHaFj0r1RCp7wgx2P199DuZKV11LVNcwAr/S8oJjUb+TCreBwV/wh8fyXY38BGa8N6gUsdW3V8GcQ5DOBUNSgGblCYXfuJ1PgK4yLsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB7LHCU83g3GScrDEkfm/x62x74cFXbvcHPqH3RRB5c=;
 b=Ue29ejgqeOuXSd1WGBfzaGVwiLpLOxYvz4N3LY5YGCQ89i4pD6xXoAB4VdJstrsxHHdvn3ZxgXP40Cb7UTJYxMq4p/DhUHTbHRLFgvtTm+Q2sSx+iN61f6wmitn4h+3QnO98+s4kf2TF6/iEw6xVQq6XrUir9LfTBaWQP81eCMM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=biamp.com;
Received: from MN2PR17MB2974.namprd17.prod.outlook.com (2603:10b6:208:dc::30)
 by MN2PR17MB2944.namprd17.prod.outlook.com (2603:10b6:208:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 04:52:18 +0000
Received: from MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac]) by MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac%5]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:52:17 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        shreyasjoshi15@gmail.com
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] spi: spi-cadence: add support for chip select high
Date:   Fri, 10 Jul 2020 14:51:40 +1000
Message-ID: <20200710045140.458-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0112.ausprd01.prod.outlook.com
 (2603:10c6:0:1a::21) To MN2PR17MB2974.namprd17.prod.outlook.com
 (2603:10b6:208:dc::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.50) by SY3PR01CA0112.ausprd01.prod.outlook.com (2603:10c6:0:1a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 04:52:15 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd908667-1455-443c-f860-08d8248d0577
X-MS-TrafficTypeDiagnostic: MN2PR17MB2944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR17MB29448B855953454854F8AC30FC650@MN2PR17MB2944.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yaeq9i8PWzMT8wja9WcD+W7MVyCYR31hoalXpgLYUasiJr1UT5uKG6F/C/Ss9TAsI9Xnw18D2dLOWXB9qY1PDdi35nXJQjrH/lGuEE55MvXwu48Jtzg7sid/CsdqyXXggIohnZ3EhO004hYjiAWPsoqW7Jm+KSLrZf8cnyKupaxBnSivy9bQSx+nSb8Is/MwWhl/dAvYxJea9qQUSrM/8WsSgiMfg0m6nV5m8nPfQ6Fo+Usiu2VjSwQSsYU8BQLam2BwN5o49hJPp5rNoINp/JDwdwmCFxR7ZuLY7PCpoma7/sJoRmwH3Xik3xkgeJosZAQcOvHo8z8i5d1a9aS6dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR17MB2974.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39850400004)(136003)(396003)(4744005)(83380400001)(36756003)(66556008)(66476007)(107886003)(66946007)(7696005)(2906002)(52116002)(956004)(2616005)(8936002)(5660300002)(26005)(86362001)(16526019)(478600001)(186003)(44832011)(4326008)(1076003)(8676002)(316002)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: N8pWsrSjylLKE6Ik5oU/fl67z5EtMsuRIZlmGSjqmzdIGjmL0PY1GgPxB1UGqOXtliCUDo9iDoFHn3EFr1lkTllFS3To7HBds241nIQYqBpERdEXE4+FSZ7SWe1m2PxRqKYyPqMnYuI02Hg4a9IQGp+PdiBiVpuV+OzfIlAY9q/g12aAao9NXt/lQlF05f/Nd36Xi3mx1g3zgGbPF0tWVxCoKr5K+vqH2violD9h3byR797SxLLjPk2wg/P/qGsVR7qXvuo111OMReFQBJGARzmM8lweGexhQlJfjHKz5KOyGK+LrGY0jtDJ2kvfjE4BmGCBUoTN59n2vTYc3a8z8tMeHgFo2txNSgn6XTNOOZSe2cl5CqfQlcAkLlvOERHytenksFnil2gOuw2c0s0SFSxWJXWTsEJj6xjoNaQwtbUoW6Ai1SFKE+bB9Q7MdxYsyV9/+7OOrNJqu+Punf5Y98HMGLNEV+XTqVma+5VkypE=
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd908667-1455-443c-f860-08d8248d0577
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB2974.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:52:17.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4m3oaq2UikoWCvl2na3+5VY0+hmET2htOpRIhL/ssZDQYG5QAVu+lFRZpDSevW6PnCACHT2WtgLQ2uDXzKFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB2944
X-BESS-ID: 1594358672-893005-16231-43785-1
X-BESS-VER: 2019.1_20200709.1706
X-BESS-Apparent-Source-IP: 104.47.56.177
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.225362 [from 
        cloudscan21-151.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        1.50 MSGID_FROM_MTA_HEADER_2 META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER, MSGID_FROM_MTA_HEADER_2
X-BESS-BRTS-Status: 1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi cadence driver should support spi-cs-high in mode bits
so that the peripherals that needs the chip select to be high active can
use it. Add the SPI-CS-HIGH flag in the supported mode bits.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 82a0ee09cbe1..2b6b9c1ad9d0 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -556,7 +556,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware =3D cdns_unprepare_transfer_hardware;
 	master->set_cs =3D cdns_spi_chipselect;
 	master->auto_runtime_pm =3D true;
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA;
+	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	/* Set to default valid value */
 	master->max_speed_hz =3D clk_get_rate(xspi->ref_clk) / 4;
--
2.20.1

