Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFD417007
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245458AbhIXKK4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 06:10:56 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:60929
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245341AbhIXKKz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 06:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knkzR4oIRfMckcMSQTzCsffErYemE2rHlLrMHjSIhGBYdOUg6lVExC9Tyid1iEnNJrwhbx0ffQfp4GW3qd3RSEa9E7tXcleTiTuMLk2XyCAw+j/6C5LW3sByUCXLI+1R+EZrSdnAva+e7NyNmP7i3X+eVjqmny+MAp50OigVKKwwud8YNscsBqqmPb7jfzlObDNbHrldh9YwRDmtyJsnfZxygvFgya5z+4u905UEUww1QNczxuoa17YMa46R4BmCLZxb7iGbKgyPpOtrIJoHsfk+wYUm9YPO2nWXfSmzsezbPlPUPiX2Dw6rb509wYaSAM7eBtEqvTf1330yPFmWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0yhSzASC/VKpgGnNgroHuzLNcwRoDr2rbQkb61n1Cr8=;
 b=kNxxQ2/qLzVYr4jr7k04u8yUjZdi+mJzNM55AqjBe2G0Bw/131anv57WsOeQ6XtxoNMWPL4B8MH7cPy5LIwebw+1gCxGUYdomHEhJyi3APBL9C4muEdqHf4PMiwjT2AvlyE+ukJ3k/CZ7fIS/nmvu2a8qRuSL7t7Dt4gz8yhihZgQHKNDHUYu0gdbu82xbAHCExMbKORVIBsNSKXMqm3aBcVhcl18tehLBftrPKFy7gzl2iLQ58KUwf6WMKWiJAwlFzMP6Lm8A9yNgzpOASmQJQNmlAHdLXsZAuq9Icn4O6Ht7zA3EQHG4s5BxyWolODkqCtN/M5Nnw48enZuSgy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yhSzASC/VKpgGnNgroHuzLNcwRoDr2rbQkb61n1Cr8=;
 b=W4aVK0YVUuGNyfqj4rtcXp+WKy3dVXsVs0zoikgpYLvuXriNphAtiSh79aJ4TiYR+KoVi/ymfR8Zi8tdwwowCNDM2M/C6swE4NTIZKfnqA93higHWVQ26OOx8Kmz6Sb4BZdt1Fu2WiuZs5PRhbXocEuFSS4RT7yjcWpW8QuA+Ro=
Received: from BN9PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:fa::23)
 by BN7PR02MB4243.namprd02.prod.outlook.com (2603:10b6:406:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 24 Sep
 2021 10:09:20 +0000
Received: from BN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::52) by BN9PR03CA0018.outlook.office365.com
 (2603:10b6:408:fa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 10:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT014.mail.protection.outlook.com (10.13.2.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 10:09:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 03:09:18 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 03:09:18 -0700
Envelope-to: git@xilinx.com,
 arnd@arndb.de,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 iwamatsu@nigauri.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.63.68] (port=39484 helo=xhdvnc208.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1mTi8r-0003Y4-36; Fri, 24 Sep 2021 03:09:17 -0700
Received: by xhdvnc208.xilinx.com (Postfix, from userid 14964)
        id 4263720633; Fri, 24 Sep 2021 15:39:16 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 0/4] spi: cadence-quadspi: Add Xilinx Versal OSPI support
Date:   Fri, 24 Sep 2021 15:37:07 +0530
Message-ID: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52bf69c4-5eaf-4048-a18c-08d97f436044
X-MS-TrafficTypeDiagnostic: BN7PR02MB4243:
X-Microsoft-Antispam-PRVS: <BN7PR02MB424306CB1A61ADE927442A77BDA49@BN7PR02MB4243.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vOIT8Du0Wdl0NZQox3wtV2gyw6UWtvVLIGkqcPtUKfaAxCGzLAwFs5pZaJddopA12M83/QU//HUIvlfOjKRMy58AE6KLT85cQZCR+ZFotZJVDhYWLvYc4w0SUghRGWvP3goR9bf/1hnEzcEmFiWeiWf/pzm8utk05avdFKdoBa+/AQShyA0SMk6p3uYJcUCtSDYD/+QPYxLSuoYsNOthwAKy0BmwMd2YnB5sjFPyQLWypWiHFEmnLPE0GNGT5xONyBDUqzjP99twZce5CiAmVIMq0pz4dBcMR84Y5OJQFyE5VLvN1d1s9+WwdFpR2BTWjw99wZrXpJVDx6kP9w/cLCikNtzCpHKA+yk4AyH9BHNcz2ehA86t5rT3waLAyfX9oFhewFMLmrJ4ux4mb5YzBZSYLyiGJcKJLrtBwMT08Zj2k3WNCZPr0Uo0PgRHunJoPSsvv63ZHupPYaFKdZWOoTgiRGD+rL6WLhja1nQWACY+eyecg8ETahe2MhKerg0JeNGHRDpAO0hlsCodqEtYPRooeUGNaS6DZAHRfsGOLTS36xbvmPLgn1LYb6KmBj2owtM3k655Vl/7wmySC2FOZv/rA3qfliQT7/v+K9F9dXR4J4yugy42odPmEQmn03XI581TCc/bN83G40Bx9V7LnqJNH2g6KMEGDioxafPBYn3LY4OygTGowytRc0t7Ni5YdNKYNm3OFe4Nga4m5wEJLEjiqbYwZ1hkYIymUGl0Iw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(36860700001)(83380400001)(356005)(82310400003)(6266002)(8936002)(107886003)(110136005)(7416002)(508600001)(7636003)(4326008)(2906002)(186003)(6666004)(47076005)(426003)(36756003)(26005)(42186006)(316002)(36906005)(8676002)(336012)(5660300002)(70206006)(70586007)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 10:09:20.2963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bf69c4-5eaf-4048-a18c-08d97f436044
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4243
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Octal SPI(OSPI) controller support for Xilinx Versal SoC.
Update the binding to add Xilinx Versal compatible string, also add
'power-domains' property and made as required for Xilinx Versal SoCs.
Add API in xilinx firmware for configuring OSPI Mux, which is
required to change the interface to OSPI. Xilinx Versal SoC
has external DMA support, so by using the OSPI MUX selection, interface
to the OSPI will be selected (either DMA interface or AXI slave interface).
Xilinx Versal OSPI external DMA:
Xilinx Versal OSPI DMA module is integrated to the Cadence OSPI Controller
with the DMA write channel. Cadence OSPI Controller which reads the data
from the Flash and stores in its internal SRAM and Xilinx Versal OSPI DMA
which reads the data from the SRAM in the Cadence OSPI Controller using
the DMA SRC channel and then the DMA DST channel initiates a write DMA
transfer into the destined address location.

Sai Krishna Potthuri (4):
  firmware: xilinx: Add OSPI Mux selection support
  dt-bindings: spi: cadence-quadspi: Add support for Xilinx Versal OSPI
  spi: cadence-quadspi: Add OSPI support for Xilinx Versal SoC
  spi: cadence-quadspi: Add Xilinx Versal external DMA support

 .../bindings/spi/cdns,qspi-nor.yaml           |  12 +
 drivers/firmware/xilinx/zynqmp.c              |  17 ++
 drivers/spi/spi-cadence-quadspi.c             | 214 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  12 +
 4 files changed, 255 insertions(+)

-- 
2.17.1

