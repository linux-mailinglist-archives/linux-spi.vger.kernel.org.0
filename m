Return-Path: <linux-spi+bounces-10926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3476DC238B9
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 08:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12773ADD83
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA4329C5B;
	Fri, 31 Oct 2025 07:30:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022072.outbound.protection.outlook.com [40.107.75.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787315E8B;
	Fri, 31 Oct 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895812; cv=fail; b=b2Zhi+YhT5NiFGS0PB6mEGIkclKZN53CiaUIJcm6PDYXSTFjeIM5g5VZhifbumsFgDZd0L3vKwTFoVhcpVpKdsoLch7/SDIjYICdxWZIeE2BB3MLTZX/gsRt9UmL5L4v58HIknxmHJ9NtTN7NKhClK7aSKc4xJX0oWWUBAK9lOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895812; c=relaxed/simple;
	bh=xlhYf5lqy4nyITQm/KGRcGVQgJQ2cXx+bMmPP6eUzBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fXHYrUXhu4dZmEBl0fl2NlXgK5EumUQESOBUFm4eFcTuYZio0fyh7xOfGsuQx5R83AG4+keyKZFsSAgFLNbSAr+rJmPEkGPEHbjo5huOYTG1wsc7L6DHtGlMEXBM4p/JFIKH5vW0nJU2DLdu40YaCD3+RonCI8UU53gYB4xpbgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/l+dLUWNRJVaAPwXeBDS2gF86HkFeSa5vLL0VI7sLHe78j78aywqiP+x10q1Ol3EUTws10SgtOLnXag0fuCUK8JVpnnValxKKHkKaNpGDkfEhGQNzjXYN5pdL32+t64dHMrvs/T4wr1HF2LmTw+Ee1Vv3ZiObA1yLLuiI6N+S4/NT9s1kgIPUus0QSlXOn9+qp3BF4Znv0USUeguI4z2scQhKF+mm0LtpKo36m8BvTG3TB1J7wfzDdhaIeyxCCZXHj+eWalwRVvOySfWCbttZ2bQq0Wq3i56Q0RqhWMDRNpMv9k63yJeYLm1xg2c5GtU6O+DIwkUamJMCkMkJ8JMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m97itRjnu3KK1uRG0KQOoJyq2kKCmj1YswLWXDfM5wM=;
 b=JgBZGaQQwlH6LQvJeY2GEUkwWy0RlmTJ8KXiws482/vcPOgON3S2apF3OVU3Heh5AXRXsSgjUpilAxi+GNH1BMWuXr2PuKHzk8RjedtGVFScVscL5ghSrCx7VARoWdGXfbzg8JKV9Xlq6rx7GiBzU2SivaPHiwU4a3RjOptXN8zDhQ3ZtS+59n0E2df2luCmIhLDxNdWA5f4W2iPSfam05J5Zk9gIOhLYQ8mk9JMmtOsoZBVQ0sI/9fk7I8MJ5XvAuffKq5rycqUOvwLMgjTowqG0RgJx0WLVaSLpCSlQsEKiKUjx/xbPRvsVxgX/IoJXp2H2rldjblRjLAI8PGuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4PR01CA0121.jpnprd01.prod.outlook.com (2603:1096:405:379::19)
 by SE1PPF5FAD0D4F8.apcprd06.prod.outlook.com (2603:1096:108:1::419) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Fri, 31 Oct
 2025 07:30:05 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:405:379:cafe::a5) by TY4PR01CA0121.outlook.office365.com
 (2603:1096:405:379::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:30:05 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8743741604E2;
	Fri, 31 Oct 2025 15:30:03 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"jun.guo" <jun.guo@cixtech.com>
Subject: [PATCH v3 0/3] spi-cadence: support transmission with bits_per_word of 16 and 32
Date: Fri, 31 Oct 2025 15:30:00 +0800
Message-Id: <20251031073003.3289573-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|SE1PPF5FAD0D4F8:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 13e51e3e-6301-4735-ecfb-08de184f4fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emshA/ZEz6br03Kiat2ve5dmmi/eowhV3HYsD6SqRO4MpHMuRM++zHwCiYYf?=
 =?us-ascii?Q?sC32ahg3xSxKhWKpHyv2LhGN/Ekz57k6LFszrfY9fWt/zWDpnJJaM3LM9bzx?=
 =?us-ascii?Q?eWeMQqvkXnjx5VuZSPRg+aUIQjLyUjAFXAT5L/jZ62b80qOJSLmTYavUgMh/?=
 =?us-ascii?Q?vqsoyTYpcBnc9bpA2HiMfYQvHG+5Qwhn+xytolmOBg6fsTohYA66bQqtzEjF?=
 =?us-ascii?Q?cSMMWHBZIUC4MPFQLhgIRVQJDzGCJSCmB9uY+BhKMbpaviQf3HlZgpuJEp7d?=
 =?us-ascii?Q?NWnTHfl2s8mWrLr6GKg77mQH0GksKtOT57ABgDYbCG9x5NDdU81nQDbCskZ0?=
 =?us-ascii?Q?lamtT3OCAN5OYOigwePjFe+isXnaN7hIMcGJZiDrHxRwf6Noh5R2VWgbDF47?=
 =?us-ascii?Q?k4QuDSP/cocCKMqfO3fCBMsrlxFpg35VdRc4pED95koQP93qaUmi+kqFBR2n?=
 =?us-ascii?Q?0X2muVLiALcanvUf1tF+uYFXBDs+xqJ4kxv+8cKMqN/oOd2uB49F6MGOjiBe?=
 =?us-ascii?Q?nBtr5gFGDiF/raeSrUMWNu1ZzCRT+smZV3vktBWGAbs2AdYFrO82EeTA28m8?=
 =?us-ascii?Q?THAJRdx+/ch9LAfmPYwza/8MbqbQ4dfTQC0Yg9u2mJliSmcphtXfiV209syN?=
 =?us-ascii?Q?2UjhfjKbTWFnA6wpG5o1NXyywdahOdMYZhEbmgaEa92AE9zhEyV7nGcTxLZ0?=
 =?us-ascii?Q?zhzkKoHn7FwXmRVU96lCQPvucICARH2FP255filnJZfFmzDVbIoYfnXUJ1GK?=
 =?us-ascii?Q?YNkh77lfaJ/sYRu26HPrH551PfJ/bvdCxP0DYFIHaIlsy5lQt6ZGfE4T16Y/?=
 =?us-ascii?Q?Yujcx/rZLn2q83ro8TnC8unq+O5zjrPrIbjvVpcI9Pmzi3SJotgu2XRPdqdc?=
 =?us-ascii?Q?H4LflPLQkb1+NZRDHydQhsXWFLzxhaR0ptqp7K5IWs0rTIbH0W6DNE9zvtQL?=
 =?us-ascii?Q?kq41c+9VnUjqWzZLsTU7mIFZMIwzpyZTHP5me7gceP5zNqXRanlhu3juNstW?=
 =?us-ascii?Q?8ynC0XQUV3SwYOLKgwgJXvHvJt95dJDD3yqPypBMSU+LTme2w7H0DwS3NGY/?=
 =?us-ascii?Q?dzwpUQCnBPwShssgDrNYIxcRbLgajLy9J0m11D2d41KEXpuLFVNATbsvvTM7?=
 =?us-ascii?Q?GfYPthv4uRe/6r/ahZItf1H9z5wRZA2P6AIuxlasooX+3YxygjfEWmlDS6aP?=
 =?us-ascii?Q?w0jZ87hEttAxjTv9z7O7Y0yK7y1yjrgpQuigl7QkM+dqx3W57tbVVVqk0MAe?=
 =?us-ascii?Q?3+3qSEpzL2z8uQW0aDuP/dC+mrFR7nd6ouuU/9uQ3t8fIuq+MhQuXIIaNGB7?=
 =?us-ascii?Q?UP248FWCnZz6wlsuQ2C8XycxGbDF1Sl6FDUknG4msa0sXYQj5bdJhuFkgYOl?=
 =?us-ascii?Q?koAvhPdgdcQakO6fNLq0/7iXkfqM7xxpbdX1uDNT4kzdhHxvDgV8I0GCBYVs?=
 =?us-ascii?Q?2bfbQFrKKEXcOI88GsjSZDowpFrOjrt3ApNUMq8GaUX0zH0zs91/6kRJi/nI?=
 =?us-ascii?Q?wrpUZEFR10v8uO1aXR1NUP1ZGNi7htZ/fVu3zNdFJ4k/zyuknu9x6rRCHn4M?=
 =?us-ascii?Q?KQfYGqPOnf8oDo44sUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:30:05.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e51e3e-6301-4735-ecfb-08de184f4fce
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF5FAD0D4F8

From: "jun.guo" <jun.guo@cixtech.com>

The Cadence SPI IP supports configurable FIFO data widths during
integration. On some SoCs, the FIFO data width is designed to be 16 or
32 bits at the chip design stage. However, the current driver only
supports communication with an 8-bit FIFO data width. Therefore, these
patches are added to enable the driver to support communication with
16-bit and 32-bit FIFO data widths.

This series introduces the following enhancements for Cadence SPI
controller support on arm64 platforms:

Patch 1: Add a compatible string "cix,sky1-spi-r1p6" for the cix
sky1 SoC.
Patch 2: Update DT binding docs to support cix sky1 SoC.
Patch 3: Enhance the SPI Cadence driver to support data transmission
with bits_per_word values of 16 and 32.

The CIX Sky1 SPI supported patch is added:
https://lore.kernel.org/all/20250919013118.853078-1-jun.guo@cixtech.com/

The patches have been tested on CIX SKY1 platform.

Changes for v3:
- Rebase the dt-bindings modification on top of the latest patches in
  spi/for-next to make the patch more minimal. 

Changes for v2:
- Remove the fifo-width property and add a compatible string for the
  cix sky1 SoC to control the FIFO data width configuration.

Jun Guo (3):
  dt-bindings: spi: spi-cadence: update DT binding docs to support cix
    sky1 SoC
  spi: spi-cadence: supports transmission with bits_per_word of 16 and
    32
  arm64: dts: cix: add a compatible string for the cix sky1 SoC

 .../devicetree/bindings/spi/spi-cadence.yaml  |   1 +
 arch/arm64/boot/dts/cix/sky1.dtsi             |   4 +-
 drivers/spi/spi-cadence.c                     | 106 +++++++++++++++---
 3 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.34.1


