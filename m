Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112F3B819D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhF3MHN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:07:13 -0400
Received: from mail-sn1anam02on2052.outbound.protection.outlook.com ([40.107.96.52]:21424
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234387AbhF3MHM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCrqHu+SDDE2vqUc831ivZ6i3hlyF9G9eTCYqEFiW32GQd2W580YYuAx6ioOhTZsM10s7Oa9mSRmCdnWWaCmMBoWd6Ap0jBkKz+Ke2o4tdiF7IQdXqlIfkDKh07k3XIqqCUSGJN5tZ7nkw1C3kAeLjUFw/Z1/4zrxqL3Gubem4vqnwUCiEdBHfo5fmaI1u32EOCuYD/Ow4MOQW+1QJYZn8qRTRIWBZI1vu9yjz62elYacMc9G4zpgiLZqNixXB5vwlyAHhBoyogsJSFjWzQaT4aHtbPVvWSan+eKGEATB6YPrstwiFNTsrAfUXFbx3uOyjvqOP3CaDQ9rzUPwqrFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ9aheH2/3lZBG/ry2Ya/gt9MnQLdmg8Gf8Akj2efyM=;
 b=mex7l5PNRNo0nk68MWYYiakS09f+JagMhTZ5qNRPL5L5BpTSo3TPAUV0LK9it/msxdFLw2nkQMQMGsyq4jVPxFV0KwgblWsgBzmEH/ZgVVkpbivgPRtUz1HmZoaNNN8jZnwEmCJk0GRmwwGOSBlyEUXTixte+DRLFKZYvVeucHbtmDnV7Hc9OiqNyApyehFMSUOSbPvIOyPmnYkAgItdcrAr4XgjREOVfMWc3dTvIuqYI4J86XvDovi2KY61N/hiEnSf2oX6hy8lq9SNHUD2YO9nXkvdgzPG6MWO5qdc0c0eAlyTVtGN9fUphEQAo7mu5npZtAUrks65Pd+GZP6iDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ9aheH2/3lZBG/ry2Ya/gt9MnQLdmg8Gf8Akj2efyM=;
 b=AoYPqAZ27WudnCdbcRoMr9ffkwGQN0Okxpx3WtaefHLgReql3mxfU2UBW07z+EntDUDOHzwrp4quKtck2P1tksyiENfbxT3Fzq6L0CU5YwNXlJR8kWTFMuJjmCk4FXmyBlx9J7i+DdSytFoiLgYLnNM1Q8DZtR5kGVcOxW12jGU=
Received: from MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15)
 by DM5PR12MB1307.namprd12.prod.outlook.com (2603:10b6:3:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 12:04:42 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::fe) by MWHPR13CA0029.outlook.office365.com
 (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.13 via Frontend
 Transport; Wed, 30 Jun 2021 12:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 12:04:42 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 07:04:39 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH v3 0/3] spi:amd:Support for new generation of AMD SOCs.
Date:   Wed, 30 Jun 2021 17:34:22 +0530
Message-ID: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0671b402-abd1-4e75-6d70-08d93bbf3e90
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR12MB130784FD76F39215B97B0A27A0019@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcfVm2stchbzZkZsYElWegQM8ggIK83cTxzMUVoxRGRM3JiUG153Hn/S7++1LQpskN2MEFyJZZHvcoo83yYGs/7xbAZ+4fdrUhQzWHho0gqf1Akr8Vlqp2MSI9aCamR/b62YclQnWb8mbctYjaD2eGV9VncdV3aD327aVk2nLsVkt9iTr16uQgx6+UvLKwHwADGPvgMbh+cafeT5jZUl/knFtRFHtrQj0NQQrsWA5R0fppNCTLqzOWSq/ThdHYtgt1agKXcaKsd2jRxmXxDEfNPb461V9NaAFR2kzKiTzSZ5EPS9924i/Za7rRtb5WWIPZgvNAIDH7o/i8rMvcQzr76hJts0BjvR1OzcBCDxUguP1I7CMJuGL5jkk6slvbsBqk28ZCDapJpG+eJyIT8XZixI28BN1kePkeN26ZmOMx+Bq6CnbOm4lzNjIpMRCdTBOVLgZ1TI8pNCCISvK8eQi9VgWzC1GBb2U/v14VSqk3aVCCWXA2jb9rRXjUNK2HhTPmISjUAlgvCb97VmNLUPNXFd3GTEtVP+gPywrgbBoVIVSdjunLMEBolksXxULmSVE7LgURXCmQeZhQyQdtT3WxZPJv/gxScPCinjJGTCuL6pDfqVvH5h8+6iUqd5uRSbrUOkxBe+qRo+V83TKwFND8/8YP83Ayx2OKezEQorJvEGowIDrMraYkUgXlVFEy7Es8FojLCb7+ZsC0Q3qbTddvZPgX2HXdTpjJgzIC2e9rs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(36860700001)(36756003)(6666004)(2616005)(336012)(47076005)(4744005)(426003)(86362001)(316002)(1076003)(7696005)(356005)(54906003)(2906002)(478600001)(83380400001)(5660300002)(82310400003)(70586007)(8676002)(16526019)(186003)(6916009)(70206006)(82740400003)(8936002)(81166007)(4326008)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 12:04:42.2391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0671b402-abd1-4e75-6d70-08d93bbf3e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix of limitation  of max 72 bytes size of fifo transfer.
Also, new generation SOC support added with modification with 
register and few of the helper functions.
As driver is only supported for X86 based platform modified the KConfig
with ACPI dependency to fix kernel test robot errors.

Changes in v3:
-Update the Kconfig with ACPI dependency

Changes in v2:
-Split the patch
-Incorporate review comments

Changes in v1:
-Initial patch for adding support of new generation of SOC -Fix for 72 bytes of FIFO Size

Nehal Bakulchandra Shah (3):
  spi:amd: Add support for latest platform
  spi:amd: Fix for transfer large size of data
  spi:amd:Fix for compilation error for non X86 platforms.

 drivers/spi/Kconfig   |   2 +-
 drivers/spi/spi-amd.c | 149 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 126 insertions(+), 25 deletions(-)

-- 
2.25.1

