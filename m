Return-Path: <linux-spi+bounces-5784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2C9D3A54
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 13:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54726285E33
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28371A01D4;
	Wed, 20 Nov 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x6oCozJ6"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D817BB2E;
	Wed, 20 Nov 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104643; cv=fail; b=duHEcxMBAf0FLsswrFrtwddS1OYb5j5k4lg8c9jdiR0qGfWDXGUMD0zfIQ8Vnxrk0UDZ5n4NhifqZs+ciO9ptiIOaE6b5mYpeUSh10jxK1tY2gqCmqEWvEHjI8j9l7Idpwg4IwitvW24hWMRE5SLJB866lnkeKNm2V32BHK9EBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104643; c=relaxed/simple;
	bh=kz4LpAdIHzHrHJLRrroeAZCFBYjDOuApB3+nd0wxL/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kkn5Wm57UTogTkl0GsSVKk/NU+evtoDMghnDNRCpS5OrBo2/UNwArYVnVCOcB9HHC+5YZfZQaTSb678fC4cjmjGr1kuL4bboAcZUvb/Ues767NKbUdKuIhPD/DWclk4v2Q5N9JBP96N1+AVqc3n37TXFpf+k5OnpZhOK2l8iE3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x6oCozJ6; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJma7aJgKRNB8WAS0nWGe1DlApi2Q2fk7eyapSKY+zwRhmFTSVKlvKCRSKHF/25LN+x9z7K+rXVwIYNDcwQ7BOTebPQwKiOxjf0zhH8Rt7Dfc89aGF4/ytjXimaTsWupaMj5ZoD0X1j+ux2b2k11krlFHvdTj0e02oJufNgv+T43YH8dPvTbUy7U2DNnkHsSH3Qmb1LMACndWv7QVIBQ+bb1OoLxjzzlcGHZc6pW14BJtb53jPEEBi8nCI3b3AhANzMMEsH0uFvtg/aYRlymELaRSKaiIyUYG+0YsL+5QDEtGaIaZ9R+lB8chzPD00ZYoNXrJ5NHDf6Uhcmj/RBXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7a3BOVsA88RAp/JxUY76MXBgT+Y7tVYqwDendDBeHM=;
 b=SYM511PHp1K0zhOmKSXtLVtvCJkYtpOaPL8dDCg7nZpvUBN0zJURbRByFxPHcG7xvZe4MB4gl1lsFdMIjlkPr9VNdHUcOIomO7W37sLE1i18CL7cnhaL64qh14Un8Rg3fdx+lw1fii9vxsW8Znk1CDobhCI1Lso7B/IArabrLsGXRCR5gMPJOWPurtuOXGAh2mK3sPKpNZ1D080Iw3Iu2bnnPW5VY8LDYJ91Y2OnibVlntBF7LWvF6x0vXw/q/uvhecLidrzIAbfiHG+vFSvrz5ZkTxxqyGiRKPX+0jFhfNNrOttPrR0xVxH16/KWL70mIPBpnjNeCBu5MoHJriZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7a3BOVsA88RAp/JxUY76MXBgT+Y7tVYqwDendDBeHM=;
 b=x6oCozJ62rkHoXJm9QZxBbimVwZUxrA2fHu7/cXBVFcdIN4C+p6v3pdEx7fLWMQLq+4xqOhA+0ZMivlkSf1Zd4o8Z2kpaXitIhPoN49ECN++bpsLhAMH+454yPvo10WAkqX28PXH6tx/IfObjXA/ZPfgTEiCrbsUdCSGP8NVhLE=
Received: from SN7PR18CA0024.namprd18.prod.outlook.com (2603:10b6:806:f3::33)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Wed, 20 Nov
 2024 12:10:35 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::44) by SN7PR18CA0024.outlook.office365.com
 (2603:10b6:806:f3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 12:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 12:10:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 06:10:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 06:10:28 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Nov 2024 06:10:24 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <vaishnav.a@ti.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <srinivas.goud@amd.com>,
	<radhey.shyam.pandey@amd.com>, <srikanthboyapally2016@gmail.com>,
	<srikanth.boyapally@amd.com>, <sai.krishna.potthuri@amd.com>
Subject: [PATCH 1/3] dt-bindings: qspi: cdns,qspi-nor: Add compatible string to support OSPI controller on Versal Gen2 platform
Date: Wed, 20 Nov 2024 17:39:49 +0530
Message-ID: <20241120120951.56327-2-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241120120951.56327-1-srikanth.boyapally@amd.com>
References: <20241120120951.56327-1-srikanth.boyapally@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: srikanth.boyapally@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b81cc3-f5b1-42c9-d6d2-08dd095c56ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njrjWYxofAn6eekdOadHU621IjsB+BZ8IYha5mCwCH75VNLzsK9CeXaWPPyJ?=
 =?us-ascii?Q?QcmSrTjSNESobtiqftDlq0abD0316LtoAnC7dQX5f3ciOa7maemuBpA5d01i?=
 =?us-ascii?Q?fZt5u1hD+EAfEvLpcIxMtfdkNcqFiAiJXnUolf9suEIQHvd/G/pY/18Njq3g?=
 =?us-ascii?Q?bkh2jxcaQEl9M9qyb4rRMKU8SZIDnmMLkmaIyrGWA3t6M10C+sqkyeKQat1R?=
 =?us-ascii?Q?SmP6KiyWlfCM8rdJjTglecLfXCrwHmUPYdJvWguILv4QPQauXSYSeRX5j50I?=
 =?us-ascii?Q?9jfsL84W0Egqkqw/WS7WGsu9KXm8BYdUSs1mLkYek5yjW6G4M0okf9tvi+K5?=
 =?us-ascii?Q?bXrKCd5cW0T+sf1/1BhCJYnNwbYlfcG4WFZh2wXIimXbX4eEk77DruPYqOTs?=
 =?us-ascii?Q?RyrCnPhSPg9YCIGsnLNAGC1IjF0d7P3fUdEdCivq/kVz8bBrUJfcrGnPE9z3?=
 =?us-ascii?Q?/f4G0ek5pjOAsDtBr/uRgMB/CefO/Xo5YeQMZL8S7/GmjvVKRgFs26GbIxyg?=
 =?us-ascii?Q?ORuKc4LgKIFwiEKOS3/H3ZbsADl37w2aXGQDAkfOdoi/ZvFXXFikh08/pWSF?=
 =?us-ascii?Q?uGcb51hvwDvQPwoLSj65vcufvMb+wlKK04JYZSpRThnHnTwerDBrzROLY6tK?=
 =?us-ascii?Q?6R2YgpZREnhdQptpd2IMYSIUjLfkIZT5sjElaC78i61kxevSpauLNjaBuXTy?=
 =?us-ascii?Q?PnobGi9jQwJVjT6k/uWCeS6uLqAnhpU+1PVuEwcAFv0Xgn1xQkYhcChTgsNZ?=
 =?us-ascii?Q?qGxuozmtVT4OjI7arIp6r8tmdXxk1RqYpqW3aQz/auBWHXaw4oNrd+WRZjNu?=
 =?us-ascii?Q?QfZzfNYN0++8/4SFmeoZtmOmnjsrkRKRBl1oUW3rA2NaLGYR5O+7XszJqU/v?=
 =?us-ascii?Q?27qrSuWrxSZkGTlCZ8x6Gxrk4RktsZGVM9cCzUXuLbYG+RldOPqFm581CSSL?=
 =?us-ascii?Q?KwnRpJql3+2VRep7UlMc8r/Y8TZwhsLCL6mFVuWfLEIW+FHWT4U2N/1D5icg?=
 =?us-ascii?Q?mgYZCvCVWm82+5tBLhsPbnJPq0kNi7AG3mWpkxko3qyUfDlTWZp4fi0YpPww?=
 =?us-ascii?Q?8M3bEVO7H/0wzpQKzzQIEgTT6+pcRnZAzAlxOlJXXqU3oR6dAWQSyoJFfAaA?=
 =?us-ascii?Q?J+wWhAU5a9UIlBUCNgbuLCbOh+EXgeFdpNfQ01sN4HC0j9M4DdI7OC5iZ2gp?=
 =?us-ascii?Q?HEzKgyL6Favn0zQS+L62wCselI1FOoex+oK/e4aMXxBoBFnb7yWUnxW2had6?=
 =?us-ascii?Q?0lEAHHO8g/ucrP8OtaNoXMAtoKeqHqGTxv6Lb+7PDl3p2Zix+GpSdroNgA6u?=
 =?us-ascii?Q?FizF7LkQxyC8IExZDNULQBFhM+l/PMJykFjKWiEzJv+qhDaqafPNuvGExgN6?=
 =?us-ascii?Q?U32KR/WPLAJusrbWdiBle4QrgZaCQWLZ7ZwzY4EdydCHtpQUWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:10:35.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b81cc3-f5b1-42c9-d6d2-08dd095c56ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

Add compatible string to support OSPI controller device reset IP
feature on Versal Gen2 platform.

Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index d48ecd6cd5ad..b6bc71d19286 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -68,6 +68,7 @@ properties:
       - items:
           - enum:
               - amd,pensando-elba-qspi
+              - amd,versal2-ospi
               - intel,lgm-qspi
               - intel,socfpga-qspi
               - mobileye,eyeq5-ospi
-- 
2.34.1


