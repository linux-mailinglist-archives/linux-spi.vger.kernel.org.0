Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890FD21BF1C
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGJVRb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jul 2020 17:17:31 -0400
Received: from outbound-ip13b.ess.barracuda.com ([209.222.82.195]:58588 "EHLO
        outbound-ip13b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbgGJVRb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jul 2020 17:17:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172]) by mx11.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 10 Jul 2020 21:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXVilfP+7SIqiJ04Z8G4tglPOa6U+/wSqbYo58EZvcCHeHBY76lFY5GdJLc2armQ/dzcLEUJJhYX4FgLasxA9JkbHhCkI1Q8O1qTsbfyQXj0XXPrF7zcgimvMiDGYNrtTLdWkMXT1hmE9fFbwB+p1yF4/o7Lm7p6kpqbm1X9g0ychtlwUbvoJ70uNiZdI5dnz2ga1L07Ck6wdLWE+gtaoh1DxWNJu2IOblQECNSmm9KlepzI0mxls1bepww0sj7rfnIyOKiadiASZi5jnhvEgUfdFeqfGSNmuErpnaRchTr4cZ2qlAQqtT5ntKpGlSwl4IC4DFNsD0BQwK7ATInptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkGktgDoJkFsIV/555/TYV4ThDD4TBqtG131ob+I+Sw=;
 b=OgISi0/G9oj9GvjhpExtyStmiwsX26Y3T+Vr3jzR1+XPEmRc4RSe7rJnlmergK6cihiAVRN3t3KtBtMtW66K4O3Vln6Mu+dSFGCF9Fg+DK/7lvjLknOZzVaJWUT+/T/6RBcatUnCDRNDTuVWtGieXUbNaTIIlMPm8Uty2MYajWzV/JijvPXWHyIqQHgRqXl5Mh1NfX9SsLnJLBk2KLZGtmBrQ+PwZN+x2Ba0suKLaRTyZqYtxpAa+cDqU9tPiwXd3sXYBOOYDzP7Pgch+gxU0Wvq6xqUEYrvI/v1D9J/vIWP0hFgYuWphkHvikj7X/E1Y1jXxzqnotPU/lEa2sJiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkGktgDoJkFsIV/555/TYV4ThDD4TBqtG131ob+I+Sw=;
 b=h6hVz+Wc3ZKMnqracBkfqr3800tv0QfnBTTwFoFqb5HtQqoa4hWMZHH/rYg23DsXbEiCNfN8wFhlDaSNcp3eg1Oz6pzxkR0YKGzYLbqs7zyCBY9SoCXfbEj6+uKbfX/bA8ZzrncUk9ei/AciFqRoAW1Z0TsrRowh4lMc2XoSDHo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=biamp.com;
Received: from MN2PR17MB2974.namprd17.prod.outlook.com (2603:10b6:208:dc::30)
 by MN2PR17MB3136.namprd17.prod.outlook.com (2603:10b6:208:13a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 21:17:25 +0000
Received: from MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac]) by MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac%5]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 21:17:25 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        shreyasjoshi15@gmail.com
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] spi: spi-cadence: add support for chip select high
Date:   Sat, 11 Jul 2020 07:16:55 +1000
Message-ID: <20200710211655.1564-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200710045140.458-1-shreyas.joshi@biamp.com>
References: <20200710045140.458-1-shreyas.joshi@biamp.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::13) To MN2PR17MB2974.namprd17.prod.outlook.com
 (2603:10b6:208:dc::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.50) by SYCP282CA0001.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:80::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 21:17:22 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffca3588-e96a-4833-da26-08d82516a40b
X-MS-TrafficTypeDiagnostic: MN2PR17MB3136:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR17MB3136C643D35480B9E48D84D2FC650@MN2PR17MB3136.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN2U2Z7gxjLDUEaSjh2/z1+d/IWUK6uRls2OlUFPs0fyA6+Cf01NXJNlQfd7GGctzgRpFilzyqzfV9BR5Y4a5ijFL21wW42GAQ0xgOssi/Kpv67zL23sr22YXhK/ajhOGP8Fx69CfC2RkwslWbtSDJD3tjFKP3fKomu9eyXfM0fACOG/6E4MZJIdH6q4Bi5l44FRfbtPin+YF0DfW4ZbehPVMJas5+KkeaSL7VRJmXYufLyeQDFkfPPvxM8eDlPbomI04nVlMx6pUG17OOI1Bu/BOWSsRr34yr/9yzuD0haIXP3EYBUqUeFuJtlSC/6XdXJxKl5U1gwUwErP3GfG+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR17MB2974.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39850400004)(366004)(136003)(396003)(107886003)(956004)(8676002)(6486002)(66946007)(478600001)(4326008)(2616005)(66476007)(66556008)(52116002)(5660300002)(86362001)(7696005)(8936002)(36756003)(83380400001)(16526019)(186003)(4744005)(44832011)(6666004)(26005)(1076003)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vtvmBMH5kT/BqSKA/qn8fguJ/x826MgLI8GGNUSAXqOSmDWb6/gwADLFRZx9T3NyWAhYZYSqPpTIU55FXFreCOiAYesPNoKrqTbYzEcMtUtkQRF+hd1j/ADNdhjFWRmxCAcOG6t3vtw9dlAOfci5P6F88tbDSL8Zlg4kszSPVDzuMvYotlc2lLfElFZfXlhXaY+/arEMYus5uNd9Cf8InmZLSoWafj+vmwBbpEKthpV6K8D/wXL6cpEQjtrFsbf1OmohpGVpBJp2LkIsvB9MKKk2or8M/+Yp2AOnezEGdnqGZ9hDL0jUhh0mr6CM4qMYPl0Urr8kjnBKfmYiLrKL8dcybcr9xoGPJUlwLzw47Atb+p9aUeDRDckC55NeQZx9x7IybPUQkoOAni+UcbxtzAmdP9oTxdpvoMsVWwEZmE8/w4/Cz/f8R4cbYNCRRlH32Zk2vnkvd65SpC5wf6Ogvyr2jRYIM/NuvwfKuJ34+GE=
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffca3588-e96a-4833-da26-08d82516a40b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB2974.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 21:17:25.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Yq+tLxBtYyMXN0kwsZ6mH59h/bKxsNp3JE/NkjL4iyDxdP7yEQ3ssCLjl39FWnuBRe5pR8S1doVPy1+QDeYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3136
X-BESS-ID: 1594415847-893021-6739-28976-1
X-BESS-VER: 2019.1_20200709.1706
X-BESS-Apparent-Source-IP: 104.47.59.172
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.225378 [from 
        cloudscan8-90.us-east-2a.ess.aws.cudaops.com]
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

