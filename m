Return-Path: <linux-spi+bounces-10377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1842BABEC1
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DBE192601D
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7442DC771;
	Tue, 30 Sep 2025 07:56:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022088.outbound.protection.outlook.com [52.101.126.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263C22B5AC;
	Tue, 30 Sep 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219014; cv=fail; b=YlIo/veX9qyPVxrY3w3TrmhH3/+VpIMjgF7n/fzftXXX37stKAmWzb0Y2lIFz3P+rL79m55fiUZwke+AToAGB65wEXnUkU5VGzlNblmTsfOebVmQEl7Oan0OkFAV/WFdB4ZeM/bWuPD/lXVB7Dqz0CRlntnnICv5v6Zl4dFhbL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219014; c=relaxed/simple;
	bh=xvkBd8mgCFL7sfjacEt6x8stxgqbp3RyBWBOD6Mc4jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CM+SUdFnC/XNAChe85XxYwwk74AVYPBKU0uq5sR/PKReSOCLeCA3yszmyy8zRv1DpaGJ/ODeTsGUZJafuGCznCfZLAf/wftlnQ0Bg960EWPMAPyBXuSrPs4yAOLg9N3+vYzKCM6DfauUIgdRnMjmz5uGq+JNun1eDC8oACj1Wfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpMkR4A3XgK+YmhF/bffZ3ajhuFslRnzB/6d4dNpYko7dK51WRR6+H5237QIOznIzCvY/0lzgL3HOC/iuj2N9ZD6HTagQO8CKjiIjHnS3nGyIPZVPWEj04to+KeJRSLfZnlKOOhQ6po8FVgnVE66BLTO6KsJJMRTCVL8JItzRigJWynh3HtTtMFz4ICMN7Ah/HVneV1O52aTkhKM7Lx59ebp8KcHcLXxVVAiQBZx4QjOFrMjJnY2JZyNDnPsd7dLtoo+wh7LFbU9Rc9PPRcGQYN01iSnFt38chjGyirAqGWniXz2F83PCmHY9fMNt4Rgukva1InjPmkc5ajIOaaBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZytqp8jHc0j5Ndwle7H43KEOM+xw9TGnMnt3zzOHWk=;
 b=X7gBoltr7wRur8tGDAeUEoJXoX6YCnvH2DVb5hZFmpQxgEo8qa5BVXdMdL7S0u0Rbkc767q0++PfVPzUIeGNso9wi4Q1+jtXCQ09jZzTm8mnINxIDYgt7y9EXz9Ur6iYiN7WpYzgA7d1VZIBLddTCQmRlaJk6JcNfVQRPrDsRGJtCz+9Tg1vZvNmY/RTz4dCETT0MjSHCyKIJcwPtk6NkxA5BWEumbNt5sSy0cUYuxQBcHWLeOutLnA+KL9F6cre8GMeZ+yyBwgt2pH0H1UHkMkrmTdbwlsJtAcyW2SF4dIQGa4NHm41Ek0ZfTEBAeXvJsBcpd3o9sCuM9H4WAZsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SE2P216CA0047.KORP216.PROD.OUTLOOK.COM (2603:1096:101:115::8)
 by PUZPR06MB6169.apcprd06.prod.outlook.com (2603:1096:301:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 07:56:47 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:101:115:cafe::a2) by SE2P216CA0047.outlook.office365.com
 (2603:1096:101:115::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 07:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 07:56:46 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9C3234115DE1;
	Tue, 30 Sep 2025 15:56:44 +0800 (CST)
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
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH 0/3] spi-cadence: support transmission with bits_per_word
Date: Tue, 30 Sep 2025 15:56:41 +0800
Message-Id: <20250930075644.1665970-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|PUZPR06MB6169:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef914e8b-46f4-4a7d-6104-08ddfff6e73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8sc5jbhwaIR8+iwmCBkP4p2oLjFg72gOn5ACqP6PA5spaiheQRG1LikHplat?=
 =?us-ascii?Q?lvzzPUuA6feP2iZfE67c4VLo8gZnIXSYzXZUmxUzr/gSJj3jF5wpLHQL7WZw?=
 =?us-ascii?Q?Jv8UCTt7axsR+5KoStjHJfsKM2Lm0dxJh1w/HVUY7nC5gg9UKvOi7wpIdr4Q?=
 =?us-ascii?Q?CWW9ukYugEh4i2taJrw7aCrnoVxCHJbRFrEyvL1yggP8OMrGFBwKcKW9KL75?=
 =?us-ascii?Q?w69SDfmWhh297UyU3aRiQMWTIsezDem4d/FdXlmEPAkDOErpiKBJu5zUSDR0?=
 =?us-ascii?Q?6IHxekAzh31B9V/EIH1NDwhHHZZzb+569lzCsG6UUVRuYAulr6vOJEXiSSgH?=
 =?us-ascii?Q?ArumIAUYYtJIVwtoLkiD9JHARvqzXQjPbg7JXsD2WEtfv2rjNue30qEEgwNT?=
 =?us-ascii?Q?n7VqxtyzwLBuKhFW5uWSt8kHYPUMpPIlbDkS4fJMmyPxD+PC0EvgoJz7BY1r?=
 =?us-ascii?Q?5A0qP39a/Hjr0wEmRDbasWUKYD19+xasox+C2ox1BfVRl2gEqNy8TeGuaTmB?=
 =?us-ascii?Q?ULqDVjPaA28P/w/1oUSBHTMWwk+QhSn1S8Je37fw+LyCBfs+vPB5AEf9bmye?=
 =?us-ascii?Q?JwJhHc9xmy1bBYaIP/wZtKzkGkoFgyxqnzikUMCN8H1B2aGQwUhPXi6/GFMb?=
 =?us-ascii?Q?5bIQfKa9jriLn/xaV5d0d+joifQ7QjcQMWBaKAnoaZUSgFJ7WV8knAUw6izv?=
 =?us-ascii?Q?sexIp6e4b5bdwRq9rks5OIlejkgzEvogttnS4jKe0dMlAHvXnsTckSe8ONn7?=
 =?us-ascii?Q?942ql2KLE/lzqgSTSp3/bN+3ZC2vn3o8b85/MRcII6aKX7vFBgGT8mlg9/WI?=
 =?us-ascii?Q?KuYA1JY7YW3tjcy2/tnx4nBUwGhxqbMz39GK1XMBKnI+cpaFQvc3LoK/ZmrJ?=
 =?us-ascii?Q?agxbGoyVS1eFOwcjQVA4YX15KIBADuBrUbyvT75cK6SUaRbfq5QB3a9pB3Zs?=
 =?us-ascii?Q?hVaye9uegbSRDeD/KVXMPtW1FP7hRP8fbR99SKfDJsn4FZ8Y20UbB4Cob/v4?=
 =?us-ascii?Q?cJ2p3mLDWYWFeCQtZj6tpSav2XzSZnNP8zQHH0sCrlykkeLBihlRtl3b0Ls/?=
 =?us-ascii?Q?4wu+4ea8CUUDo8zcyGQfr+lgTmlJZ7RPuxLDu0pZMAnMvoqtcbH9fuFMYISU?=
 =?us-ascii?Q?Yqy0sBybZCC0eD0TRk+i8hRX59ubSg1TDdFzO0TwR2C2ZdpTj6kKti3S9xdE?=
 =?us-ascii?Q?yQd2Y8gnn0puVeHEowepjN1qTtimr+Pju1y5beMXgYYYWB/r8CMU4jqFWXRK?=
 =?us-ascii?Q?LZ3wj0W/FF+8Mmo4sg/fOg1lmF2R3P71w5ZQJQ/gogQNhzC51gSg+PN9cna6?=
 =?us-ascii?Q?aBGYsQqTuivicSyEIOAsODma9tH/RPkIraB0mFB1u3nMSCvJJ0GyY5QvcTrh?=
 =?us-ascii?Q?XIee6pQLQQAtp/XCAkrFUdoiOoWbf0byQFyQh82lSogzmkjn6GK69gkMh8fc?=
 =?us-ascii?Q?5CWymor/TXMq2OIxhu0+iDR+QjGQ4FDE6dXdpIY4h1AmAzg5oRnseUOtbbWU?=
 =?us-ascii?Q?6cKE8SOfx7+ETcb8J48C946e97FLSrvlHVlnOAil9aLVJols2uZK+hgnbulE?=
 =?us-ascii?Q?4d9naiEJYk3XAyWnZMU=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:56:46.0690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef914e8b-46f4-4a7d-6104-08ddfff6e73c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6169

The Cadence SPI IP supports configurable FIFO data widths during
integration. On some SoCs, the FIFO data width is designed to be 16 or
32 bits at the chip design stage. However, the current driver only
supports communication with an 8-bit FIFO data width. Therefore, these
patches are added to enable the driver to support communication with
16-bit and 32-bit FIFO data widths.

This series introduces the following enhancements for Cadence SPI
controller support on arm64 platforms:

Patch 1: Document the 'fifo-width' property as optional in
spi-cadence device tree bindings.
Patch 2: Enhance the SPI Cadence driver to support data transmission
with bits_per_word values of 16 and 32.
Patch 3: Add a new 'fifo-width' configuration property to Cadence
SPI node in the CIX device tree.

The CIX Sky1 SPI supported patch is added:
https://lore.kernel.org/all/20250919013118.853078-1-jun.guo@cixtech.com/

This series:
- Documents the new property usage.
- Enables 16/32 bits per word in the driver for broader hardware
  compatibility.
- Makes fifo-width configurable via DT.

The patches have been tested on CIX SKY1 platform.

Jun Guo (3):
  dt-bindings: spi: spi-cadence: document optional fifo-width DT
    property
  spi: spi-cadence: supports transmission with bits_per_word of 16 and
    32
  arm64: dts: cix: add the fifo-width configuration field for cadence
    SPI

 .../devicetree/bindings/spi/spi-cadence.yaml  |  11 ++
 arch/arm64/boot/dts/cix/sky1.dtsi             |   2 +
 drivers/spi/spi-cadence.c                     | 125 ++++++++++++++++--
 3 files changed, 125 insertions(+), 13 deletions(-)

-- 
2.34.1


