Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691BC22737D
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgGUAJX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 20:09:23 -0400
Received: from outbound-ip8b.ess.barracuda.com ([209.222.82.190]:42028 "EHLO
        outbound-ip8b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgGUAJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jul 2020 20:09:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170]) by mx2.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Jul 2020 00:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4910MLeM+xxar2y598xmFJD14rS4b7FKrxgrXs+4tAwEncXeSqB9hpQTVxtMwwGGj5CbokTb6SKtDodsmLk80+p/W6WTbWcA+tfZ+0lnv137f7ypVYjIM6v+kDgpJvPg1HGsTtPb+FJsNOlCpCBPhUHJR6B5DdAXs3zWpf9DOqnXLyaFsqdNqVYbNJ8qaUsx4U4E7fJyAK6ndkDoULUFdb8rLmixlThGR3TnQYVF/HkrQRevmwtBmmAfJtvQUvibwfPkWw3ht0Yk77Qjw8yiREkoQTF70FwjdE9uHaTbVgC3Vj9fTZa1OUadg4NuBfptB9WvjbKGqah+iXhxeuw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkGktgDoJkFsIV/555/TYV4ThDD4TBqtG131ob+I+Sw=;
 b=E3rOqA2/euwoAZmYsdSVapXtjdBZVU2qpiIGeLbAmQKTZdOyS6kR5DvLPolvWZC2W6OBu64KY0FddyRnzh7mrBsZJrW6v/Wr7lTujFJ+DhVxObum7zPWNi551ziHhnteoODkpNtdxzNMKzohgNP5pRYQdLXqkiR7HFIfW0+D1+mkjiGRePAeI1XDEg8fMsttDXJ/Pj3/8EafYq2S9aJiioxfD881qMiqWvBoG8ioXVR93AQfA/UiPGwOVuUm7lBa6BQKkwaYyGXKlyGvJ2GUNN4pYj8gQ4sx67l9xOXuNcLRKt6dfpA5jvL1ufY3Ro/s4j+0mTPGtQjZv16khoXDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkGktgDoJkFsIV/555/TYV4ThDD4TBqtG131ob+I+Sw=;
 b=jUEjrbN/J4C7Tr+X06N9aO0ODPXT+DA0++XMvu/f9Ee550tm5PjAs8b8MW6hFJt9rt3xVBWFCtlbvJWplvtEl2+ERy/y604pnJT+j6s2htBXIUI40DoKb0/c60hj4FysaRq81wPaSQ4wUll7J4VddibNlJCbYcPq+tjOjRQN7hI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=biamp.com;
Received: from MN2PR17MB2974.namprd17.prod.outlook.com (2603:10b6:208:dc::30)
 by MN2PR17MB3167.namprd17.prod.outlook.com (2603:10b6:208:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 21 Jul
 2020 00:09:16 +0000
Received: from MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac]) by MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac%5]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 00:09:16 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        shreyasjoshi15@gmail.com
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] spi: spi-cadence: add support for chip select high
Date:   Tue, 21 Jul 2020 10:08:50 +1000
Message-ID: <20200721000850.370-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200710211655.1564-1-shreyas.joshi@biamp.com>
References: <20200710211655.1564-1-shreyas.joshi@biamp.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To MN2PR17MB2974.namprd17.prod.outlook.com (2603:10b6:208:dc::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.50) by SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23 via Frontend Transport; Tue, 21 Jul 2020 00:09:13 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cff369e-70de-4efe-6b25-08d82d0a4e02
X-MS-TrafficTypeDiagnostic: MN2PR17MB3167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR17MB3167901F8DF070AC7A6AF59DFC780@MN2PR17MB3167.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5OPQjEfXZwR75v4yjWIrNGhShEZOhU0GQep1PwX8cHp4hLoEbHYc8GJGET8Z8lkIOChHCG9TSCkUZONMJFPTARRJ7pcCBjx5ckINUa2FEteqryciIzoesaFV6xWlXCrOsl87zS6Rq1KC1Yyq1YEsdnO3vOUzpnhzCaKgFhfjlUcvJ+LfOaR2bguvJ2s0pHi2Q21p+AgNwl3+LTq/aqGdNG0mxrMpDSL02YVaYGvQY6RgsRS2aC7v9n6ZVoiAq/KXhjTEfL5SRg8jQr1NRTCtXYQaKsj1xyKbFfmG1zaNwv0GlHUH4nvVv+Q8EG+lif43ORKpL8uIr0rfmT79fVsQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR17MB2974.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(7696005)(6666004)(2906002)(52116002)(107886003)(83380400001)(26005)(5660300002)(36756003)(44832011)(66476007)(66556008)(66946007)(8936002)(956004)(4744005)(6486002)(316002)(4326008)(86362001)(16526019)(8676002)(2616005)(1076003)(478600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bR/4hn+zN5DiUlftieT8mP/ZXGNDHNBEk+BiGDnFwrl9M08Q5gLWqyJqiIoRzyfKounm/usUpFm6LA9PoBC1JKK/nD8G9xA0v9Epeb0lqOwtY+QYm6oiDBALzYkIyvASxepYo7LSYmNWllggeR9W9yrIjbw9feAp0lhAy9GDgw0ChCvOrFGSnI2Uhv57WrZT82IbZk2aAR3zIpKc6m25f7tc6KIiOlRaPmYPsLcrqOWab7Ecr+Iz8dmf1ZBQrgUdLFKcNvVwSgGJ0KgeNrikb5ocidRccOj6f9M0UMTZMsXrLN5G3fA4hJi4W6pkJ6Y5+fE7Z5+27qzIZOcc3QiUHN8+iEElmM87kSAC4b6WhSQZkkDfnUga84moExfzK8KY23+yvpkk5T6lI8DXnm2F74VOCPiwOTrU8B5lucr4SoGCHDdSXBTB1nXGOkjyacLbDzymoccwdB9G7woSatp9TuYFM8Y1Z7OnKkTtM6fULHE=
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cff369e-70de-4efe-6b25-08d82d0a4e02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB2974.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 00:09:16.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y01IKKoXf56LhZPa0y5lIK8Tqye7WFh0HaiphXeTfhJryJgU2uOADcayZ3OYyfu87Mw6DlcIhdtc/UojzwgefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3167
X-BESS-ID: 1595290158-893003-11571-4745-1
X-BESS-VER: 2019.1_20200720.2239
X-BESS-Apparent-Source-IP: 104.47.59.170
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.225610 [from 
        cloudscan11-204.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER
X-BESS-BRTS-Status: 1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi cadence driver should support spi-cs-high in mode bits
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
=20
 	/* Set to default valid value */
 	master->max_speed_hz =3D clk_get_rate(xspi->ref_clk) / 4;
--=20
2.20.1

