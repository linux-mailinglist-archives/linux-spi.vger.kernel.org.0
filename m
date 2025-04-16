Return-Path: <linux-spi+bounces-7613-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47205A8B749
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4968617DBA2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A023642E;
	Wed, 16 Apr 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SWBgFjmy"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1621EF380;
	Wed, 16 Apr 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801593; cv=fail; b=F4mR414557W1Y9lAPlAlEtVEJI5fz9vegE+iVnuHgCBMqv3TS0pEpT30BOfm33QOLiVn/Zp/Tz7Qts1SXZ+65rEEGhBta5a71op9dvRWqjsDqroiARSKeTe/6dJjwVBaz6CMl+KlTAPjgBDEsniwSViIxyGRDCoz7B1uCrvxoiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801593; c=relaxed/simple;
	bh=iWzoEAZzmfdLr6HxlttQMX1df6D3336YabA8RJaRn6Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efJelyyfxpk4VZHUUWj/n9uGli1PC/2i0LZL3SD1kcHC0FjUkUUgydG2FGfSqInkrXKXj56xTJoq6ABgHatx37CwkQrzpFX1bGgVTUGvHFSG7UGd5koc0d8WiOS5mU98e8FkoLPWgzCh2YR6mpKChzItQIjVsoCNMaAXdr5qd2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SWBgFjmy; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUuE6W6FCb2CQObPLl6MOE8knvC7ZYRStnEV6jtN77wPXx+rNyThWFk71iFzhGixLACcWLykTsaQjdEQB93jlHfmkhzcQw6+WRMCvzHqxO52kOodnH+bMUgIVDQZX683/qgTQ/hWHCyudYEAvm15ZxI18jhihMCWGQiK1GE7paZExDegntN6dJNFepMxjqdO6hacT41TlQFmHO5KORTZm6mNC2cp3C3d6Xj1wpfng1AQd3A+sm2mKFxRbXtbSmjxymltdpeIIJ2C6/fRJ2wm9Sq1I+oOWI6BEoDjvJ47CkdjoORhilAa69h0hR515/bH7St07Una8ijiCQ0/7Mm3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcPTg4yq9WOIvX+PHEspMFUYl7lcjFG48d85rhshGEY=;
 b=icBALAg1E/etdBW6iq9PHgB9BcarZ401Bp0ro6xGydoybr6wL1yX71FGNYFF6J3CJ53b6k+Iayi5PMu/dF1cf5KvnCQ7qWVEC07+lkim6zEMIKOr/CiC0xUiqHWtEEqArud2JrIwj7qtzAC5rq0JJqIxAiDqS8ubYtoB4rTtiqlG2UCqQZ28eScXj/s+a05WnxU9IHzZLLEpgqsEw/GFSIcIEUPsaIzyjp93iQE3ARvDMvPSJLueXWfcbRSOfRAqp68T4Qzy8PZVECp2UjHz+roW+/WBRf1yr1iDx1n+wW3c9kYi4g59TwH48QiaWrrddChAywi/hgI+KcaxTxLrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcPTg4yq9WOIvX+PHEspMFUYl7lcjFG48d85rhshGEY=;
 b=SWBgFjmy95SDTZjFJSkxsAUbvQKKFZN0yCkws9Lv9ypYqa2VzYy1KyRESiearzeMjE+iKTd6u7GP6uWpnFr/ZZolkzOjp8Y+Ootbwt3ByaXJ2vHnrEjuya2zDDoGhk9wdhdD6l2kTAaPhKR0S2sROKdB3Bd+TgFsFgXixo4tk5cRWxt03IGTuPU4Fj4hTCwfi8rydeH3jafUi3EqBT+D9Rp5gpzfZOFUXwWZ8RXpMfPzyLWC+dn9Oky5h0r2Iioez7gziDGuuIBiVmVNatZFKOLGh3WY+eR9Fmn2ZU0OpvnlKVwDYKfT+AynFoQxPQIdNNNzoO6AW5qSmqJ3YSVVlQ==
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:06:28 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::4f) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Wed,
 16 Apr 2025 11:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:06:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:12 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:09 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 0/6] Configure Clocks, Add Internal DMA support
Date: Wed, 16 Apr 2025 11:06:00 +0000
Message-ID: <20250416110606.2737315-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6706c9-0480-412f-e194-08dd7cd6bc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYuobyXjaGu1+DG7m5kdk+4Eh35ECEWxJWWAG2fNZr3XvNwF4Gf/LjU1TTN+?=
 =?us-ascii?Q?ZnEIJzc0VpclOnwiHrpe0uMCJ78s4feyugd3nHRUZ8k2KrTb4gmTobWEDEXi?=
 =?us-ascii?Q?zSkyT7WwQpZuri2+QM59QLL45lJlWoC5zaSvJksgexb3ivyMGflR9N3XPLgh?=
 =?us-ascii?Q?bGCZa6YnzMtM01BDp9MCzF86dEO+nwZV64qnE23r19xP18i9bB7q1k0Twe7J?=
 =?us-ascii?Q?RFUvDRkPYvSiUyUb5x7X9k9bg0SfCdJk8V56Pu+y1iCFXzOSaTNYjYxv/nsL?=
 =?us-ascii?Q?Rxr3WKkuC6oikPW4U7DSd4X6zeDEAww4iXNs2uSunvkLkkBOK8O9Wf6nflkb?=
 =?us-ascii?Q?3VclESbQjJOCxi2nZmhYQ/lHJZojfVQgHBD0V9I41Kz5XqyqkqmUccv0WcFq?=
 =?us-ascii?Q?AJFo5+W/CKzxxd250swqcgVflYrCa0+PqczG/CPBK9aWQ01CCOv0GqtLffWY?=
 =?us-ascii?Q?WkRDnm0nbwW1Nd4dlI3esxyXyVae7Pv9asyTga5Uda0Edd0rus9a9cvbp67t?=
 =?us-ascii?Q?VI2j/pW3936yx8n5b9pwoYt8ipnsJQIxAmqoNDBFI/1aufezx/k0qhoUJPLN?=
 =?us-ascii?Q?3pTD73G5PxTnN3JRsmOOFFktiR6Lr+ip5qge0bFnkr7NXFul0Zc1NJ/asb1T?=
 =?us-ascii?Q?Jt9VY2HP2yV4od29lOyzZj9bHOafGD3krDrr9lShR2u3RYd7E83og4sd3Dbb?=
 =?us-ascii?Q?3hLBeqhK58GJ5UcQtjPMich4oAD9E3NYNbdHacju3rYvLNU4Ujx/WGcdQvyP?=
 =?us-ascii?Q?aLXWgN59b2HP62fj7XD0eDqNOQj+Ww+vzHxgkUq+jeMvvhR3cWzp+JhCPX/Y?=
 =?us-ascii?Q?9Zy//nTJRA7R2nfo0yeUtZAg0gIFaeWYqbkpz975pbA8y/1HXZxekz1yrIMx?=
 =?us-ascii?Q?0jPzcueE6yBVqvvHcV+3VhbVYS6tQIhZbHLqlouCd7gN1aPvd4HfR/r337Gj?=
 =?us-ascii?Q?3M1uE7fbY6qZGvtCGcstiGIzBkI4ddIXRnWBkt3AgJYSTv1W5ggwSocrrMah?=
 =?us-ascii?Q?MnzJKsbWk0VU+0AD2573OQKP6Hqrb7sPVzSPWT/dYWUP88UyUyQdfW2CBOhJ?=
 =?us-ascii?Q?mwBb4vCeRwNou+rDOCV6hAOdAbTnd5mgodQ40fZPPLVWXXwf1QB/QJWd7kON?=
 =?us-ascii?Q?HeU2ED0+5kXsYGZ+QKxF4KbRByTWFT33P+AruX9PMlhCIX2dGumg1RofTU+f?=
 =?us-ascii?Q?TIQmze0arqnvYK3XvNlIoXlZM/Wn9RDrqc5jgKJb60/4H/+ORl347/cn2+sE?=
 =?us-ascii?Q?doJRLZKNAfT6v0xbark6DnJ/P4Rnqb1cZfv9ZOhB9tS5KdlYJXGcmV3fYpVk?=
 =?us-ascii?Q?jJu21bO3s4ZZ+0Z1kz5Lb0pfFh8b2kzl7b+kzp/E4tBLeYnrn5tWh0CkQhXO?=
 =?us-ascii?Q?b6dH6pIqeQpP7aqH6945qs5y//3bepVjBRRsXlU/MWG14Bl4sQkBeRxR0Mm9?=
 =?us-ascii?Q?9lxIyqtltFC7cCzfD7OiqkrdPe1pare0TFLizxszFv4ABnV68a4R79dI0ieS?=
 =?us-ascii?Q?MooVuaIcYB4guKGmzQjwgOZCzs94+8nGMILzMGPO/IItMaLipvT3jA6BHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:06:27.7999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6706c9-0480-412f-e194-08dd7cd6bc3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

This series introduces QSPI clock configuration and internal DMA
support for Quad SPI controller. The patches have been reorganized
for better logical flow and review comments from v2 have been addressed.

Vishwaroop A (6):
  spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
  spi: tegra210-quad: remove redundant error handling code
  spi: tegra210-quad: modify chip select (CS) deactivation
  arm64: tegra: Configure QSPI clocks and add DMA
  spi: tegra210-quad: Update dummy sequence configuration
  spi: tegra210-quad: Add support for internal DMA

 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  10 +
 drivers/spi/spi-tegra210-quad.c          | 282 +++++++++++++----------
 2 files changed, 176 insertions(+), 116 deletions(-)

---
v2 -> v3:
        * Reorganized the patches.
        * Addressed review comments received on the patches.
---

-- 
2.17.1


