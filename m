Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD62E340316
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 11:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCRKZG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 06:25:06 -0400
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:5217
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229849AbhCRKYy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Mar 2021 06:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STakEqtnRCuvqg9bYVeKGKMhIM8W3ajSuVPldc6Y7NM1cuexRIKVgH0+M15RXXuALa9P3kmYkYCmSjCY0FE8yHsGvshxvCfR7omgNJN1JC/EHv0zLE5qL3dfkrq7UPSvRqWytF985snf0O+tKJc1Egjd4397zx88V/MwLNjIE7xP+B5Y9UzocDj9HFOP5StcFk3kn3wzLazPKOrGDT5rMEHu/23xksHtShCxXsu65uksvv+eMdtAgtRCSgDdX1EhHlbWGh+ytn79Qek/HdjDhhrAWZuDcBb+jsC3b7tZau8obuZsxMGrmsnLVXmmCrhCygLF/tvFVR6mfVFBqdai2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGSPArxD0Er6XwpU2O4xQGOB0IiOTAfdRns4Ps8NVZ8=;
 b=bzE8KvdAVtYrBEQcXYiwdDh7wE7jUACrv+6kSYyoEBc1esyt/ScIiv3jeY91Jl18jc/rCB1x2Qjm9srrAeQ5INZzo4o3uje5+kIjfG9hzGr8iNKuN9IlJyZmLERFSLNSMJxnApb7wVSFGftHqaIabt18s9n126UWg1w0QL0igXXYMl9Qgi/5BSa8GunZkj9r4Q5nb4G43/hZkS8d39qZahi+IdC3zeTtjEsKkkqQKbpxxbFOQuveIQmKmHk51QoHoUZyh++xvwUkiz1V3I76fUFPvJ+t7/hub0h3aPLZlbJ4myuHrieoWu1ajnKLPV9IRCzxQhTvd8wgz0g/wuVwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGSPArxD0Er6XwpU2O4xQGOB0IiOTAfdRns4Ps8NVZ8=;
 b=hOdriMY5RdZ70TKhNG/RKIi1WiujOVrVbeT9Kk4LzKGvKSd0TyloqD8UYOBGIPwluxRvKFjn4tILAQ5N+oPmHQmjTLfc1zrqIjDuF6KUpy52AoR3RafnvXXe08OIO2EW1L69PlbSToQi/t225JzSTVkBeqlBAXVkvUzQxhmnBZc=
Received: from SN6PR05CA0007.namprd05.prod.outlook.com (2603:10b6:805:de::20)
 by BL0PR02MB5618.namprd02.prod.outlook.com (2603:10b6:208:8f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 10:24:52 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::1d) by SN6PR05CA0007.outlook.office365.com
 (2603:10b6:805:de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Thu, 18 Mar 2021 10:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Thu, 18 Mar 2021 10:24:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 03:24:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 18 Mar 2021 03:24:50 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.25] (port=50704 helo=xhdnagasure40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1lMpph-0007CY-MB; Thu, 18 Mar 2021 03:24:50 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 0/2]spi: spi-zynq-qspi: Fix stack violation bug
Date:   Thu, 18 Mar 2021 04:24:44 -0600
Message-ID: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02d05562-ccf1-45f4-59f1-08d8e9f81106
X-MS-TrafficTypeDiagnostic: BL0PR02MB5618:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5618DEAF50957F23546CC293BA699@BL0PR02MB5618.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5173mKJ96475COOg/n0NOYysUIYSthNhQSlPuTqxeqnkyWhHq62zglPd6QN464HRg1JIFdepxoYnubROMkMQy3s0WCVpyhMrwxzTsz+QyqVELL0Uty2nwQ1JmdS7P6oWW0hqk6Da3hUqmjyL6WlhZBEt7Ya/Yn/P0wuVMRFE3tbi9Aa0eN4Cm8XIjPsWxwAE4YEIWnvk36pk5Is5cG1pSPn8VvI2AuSXcO8Cd1CXU/aShUcTdxwRmP77opw0HK7fRDRIDNLzlzcDKbhf9dHVmXa47cojODkHs95ODfqOeqmPtMbUSKz4ywYnnkMAZge5S5rZbvv0OuCtPYklZAhwsVD/y+1k0eYK5zl4DN8ilIpZkqiBWUc5iZNr8+zbfUzoKaEBE0kXmTwHzmf4ndlJ+QpxWJGyFkMEgu02ZkEa2VT3Q66YdF/xwqLXpJSunOcsit339rcNC//u1pfBXlFXrfVAK+r+Jn3/vxJ83nTEvk9sKbSby+4P3mTJH70RL3+d8dOxwlOkbrFw6PTPO+AW/jPndDKuVQGo4PqOVQbHSfEaWz6AT1SmxIxHRsPzpw+OQcBDBcsNuGWke9OZmY0EJ/tp+jLKFnF9a7QGG1z8TyjFX6fE39238WmtRtVL+KaRvfEsoYyI0pJ5NJTUB7SRIowUbNimerlb2+iQgTiNcCvOWlAdOWVmvFW2DQSymrE
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(7636003)(82740400003)(9786002)(70206006)(70586007)(83380400001)(36756003)(426003)(8676002)(336012)(6916009)(8936002)(2906002)(82310400003)(186003)(1076003)(6666004)(4744005)(26005)(36860700001)(54906003)(478600001)(107886003)(4326008)(5660300002)(356005)(47076005)(2616005)(316002)(7696005)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 10:24:51.8915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d05562-ccf1-45f4-59f1-08d8e9f81106
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5618
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series fixes kernel-doc warnings and stack violation
issues in Zynq qspi driver file
---
Branch: for-next
---
Amit Kumar Mahapatra (1):
  spi: spi-zynq-qspi: Fix kernel-doc warning

Karen Dombroski (1):
  spi: spi-zynq-qspi: Fix stack violation bug

 drivers/spi/spi-zynq-qspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
