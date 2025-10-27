Return-Path: <linux-spi+bounces-10841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E1C0C5BF
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 09:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0023BC03C
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B162F067E;
	Mon, 27 Oct 2025 08:42:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022094.outbound.protection.outlook.com [52.101.126.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2D2E92D6;
	Mon, 27 Oct 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554569; cv=fail; b=k69t4fp43PKwyP2GMm8r7IgIIwcQ0g2Je9w4c+hh+E5noWtJu1hVBEGgLVW5qhYfpaz4TA8MR/voWTiSzafp4x7zxuRokq8K0UsGuAYH4i91wwBvnOqmz/ZWwuQ24y9jaNZmPN5rJERZCOM0SEpogEsiOHTAlkrLDvwN8xej2Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554569; c=relaxed/simple;
	bh=IuNd4PpekNoO2enGBpmDuEnYtMPnfSYALTrug4znXn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HDb7PnqdHy+7eiSrGpyIfavZTHnhkZRznoeQ4Uapy1fq2/+nUGbT8s5VK6f7MOiI3Zco/xn/ONMwXDN+pa7rOs4wgeS8c5q3CoFViZcNCYFL7RGNIZUKwToI4U8aS+UNKBwV1TEyVxMP2dGSvlDT/vYQAIaEpCo7WPVqRjoG1V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9EIzpLh6XvANM6F1s3QoncLvHj0nWIlu7RKK231IVEABycGNwWdXp08nb9YviyAYVTCYS4BNl80NTlA1OzTPFZ+d0pner++86cGhqSiljE76vAeyUPR8jKOdTMcOR9li+LizsUFF4KYDEYQP4G9YOF1EDBjRZ89aXO/blvEU/AV4un8GGTnaKPjcBlX6FzvxWHEutdIfAnaR8kd/osXRLc0mXPNI6y5YlJJ7KQnskjjk4EEakmy5xoKEx/j2B+9neauiJDiAPcFXvuW+iJwH8glcP9Wg1rXlwSpbKoO5vBJ3qQgcKGqm/od86lpQPWa4L9EbZ27xb0TjvbVKyYTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSXFYNKwS9yno4Se2GxuIhBdajm0fxixE7UyTDvrezs=;
 b=vqavH/qQ3YDGkFT6Bk/qge95SiI27+l09HysSWTQrJX6k7t4c/jEDA/sjm+dKeq2J4g+hdZCkbcQS2/1CefW26KK9ys+Ns/otfot1QJWbZsSmuf7Y0XHhUUKE56NwYknRi79gK0m1zpjAn0X/m0C7k0nEF9ck1aYQWOzE1VX6h0H01Tl1KajEyb3gwhpOWurUxG4Z/86DqF3j1AyvjEiEdFr0wJlqRA9OglkXhbUmzmdb+zic5JAKX+rSycJScFkR3qrcFdEni82Ul/NcyGUlg37m3bYxP2oP7KmKhDj1Bf02+icbQqSVQQ7wglwdug3sJZzm5M80qruAK6m0jNKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0019.apcprd02.prod.outlook.com (2603:1096:4:1f4::15)
 by PUZPR06MB5748.apcprd06.prod.outlook.com (2603:1096:301:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 08:42:41 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::cc) by SI1PR02CA0019.outlook.office365.com
 (2603:1096:4:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 08:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:42:41 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 391CD41C0145;
	Mon, 27 Oct 2025 16:42:40 +0800 (CST)
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
Subject: [PATCH v2 0/3] spi-cadence: support transmission with bits_per_word of 16 and 32
Date: Mon, 27 Oct 2025 16:42:36 +0800
Message-Id: <20251027084239.2610141-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|PUZPR06MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca77c2d-243c-4c10-4d98-08de1534ca73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REx6NUl5T0lwSW5JTVdBS2tIUXhkWUtTNVMrL1VUVytJYjNDbjJ6dVBJN3JM?=
 =?utf-8?B?QXg0Y3FNczhLaXJXVDJBQkpqN2krenVJZFFQcFhyRVVSRHMxOGhVY1UwM3NO?=
 =?utf-8?B?ZE1iVEp1TUJnVjkvMjVQODJDbUFLYm81OTRLYXVneEJHOFYzSWNidVdKbFRU?=
 =?utf-8?B?d3NySnJwRkd3WFZHcmJsMDByS3FtOEJoRXhTY1VNeFRNOGQwdEJJajc5ejVC?=
 =?utf-8?B?RlBZMFNYUmVZNkxMdVFKSEZnNloxYU5ZQzdoWTJ5SVRxNEJpdmY3QlpIYXh6?=
 =?utf-8?B?anpWamhKNmgvajI3MUNnbEFWd1JLdUQ1TkZOQUVUc0xmNG8wMzJBWlhiZ1Ey?=
 =?utf-8?B?WmtMbDlKSnRDa3Y1Y3NoVGJleE9nSUg3V3NmVFRjQ21PYWUvMWRxYWhyUW5w?=
 =?utf-8?B?RW5CZlhXVHhYVStFZXU3NVArMDBvSDVXNzdFS3RFOVZHVVpLejAvQzdZQ000?=
 =?utf-8?B?a3F5VWROK1RXakxYL0NlWVJXRUhpMXZ0UGFDcHI2TFpkZXpSR3lWajFTTG5u?=
 =?utf-8?B?d3lDTVFtdUdnRTZlb1E0bUt1bDhvRFB6bTFQM0MxSDl5YWk5bXJNVEVTVk44?=
 =?utf-8?B?bURSYnorNWc2UXBlQVgyZ2UyMzcvaUgxVjB5bWNISnhabExtREt0UisvRi92?=
 =?utf-8?B?d3FuM3JFczJQMWRVOWdzSGF5R0RNdDNuTjQ3b2FocEt0Y0wzUldtT0NmazVQ?=
 =?utf-8?B?MXhROFRreUtnQkR0UngrdXBXQjBYWUhHZENyNHA1b3l1RFhaT3hoTVFQMmFD?=
 =?utf-8?B?TzlKNlcyYzBJZk1mbHJlbUx0REFvaG1BL3VrVTZOOVowa2podHhLOVE3WEVL?=
 =?utf-8?B?cytVZFZYdEVZWHpPT09Wb0tTK0poa1M2eXd5ZGhMSWJONFVCd3B5bGExUE53?=
 =?utf-8?B?RnJ4N1hhVE5nOEdZOEtsd29HbGt3UHBTaTFtaTV3TXRzQnluSXdJbHN4Z0Iy?=
 =?utf-8?B?aUNDMHl2MjJKMURYRWlzY0xzb1VGbCttckQxMnBkMGExclNqWHpuTVJJYThD?=
 =?utf-8?B?VUhNK1hJaVNyR3BMWGNsZ1BBSlpLTzczSm52L1pDbUUzbEVPNGJwUk1zemM4?=
 =?utf-8?B?ZWVDUVBwZFBQUkpBLzdKMVpNenB0RFFxZm9nODhUdGJqbWNZc0wrSzR2bXJK?=
 =?utf-8?B?azZtWmY5enUvK1BxSGM1TkZKdVJwZElLRjVKNUVvR05WcytOektjejB3M0Nj?=
 =?utf-8?B?ZW4wSEcyMGQ0VGh6MnVHZjhZWVRNbXYvWXMycldZTVFPS1dZeHk0MTE4a1FE?=
 =?utf-8?B?eEFRbFRPVEpudWdsYm0rVlVTS0h5TkhrSEhiNE9RZ1RYRU45VWozSmwvdzhl?=
 =?utf-8?B?N2NWM3o4VURkTThjNXVkdEtqdnlvVjUwWUhjUmFyNWx2TnhSa0ExOStpTFFy?=
 =?utf-8?B?Rld0dEd4WW5SV3ZoUmJzRG42czNiK1Uyb1Z0SEt3Ti9JMDVKQzNJZ3BmdmNZ?=
 =?utf-8?B?TnI2M3NRMXhnTkZoVndqNUlqQ05uSFFpdTVoVFdIYzBob0IwZC8zZWxVb3Mz?=
 =?utf-8?B?Z1pYSHFEU0hiRzN5a1VxbTF4anZjbWZVeTJ2UCtSS1B2RGpBZExvVWg5M2Ur?=
 =?utf-8?B?cGM3bDRqZUMrdjJqbGlxYUt4aERLVzM4SHY2R0N0TW1kRkh5ZXdBYUE5VTVR?=
 =?utf-8?B?WGR1RkdnN1RoeitRckpscC9mOFRkd0M1RFJVd0Z4MVhkQmV6VWxBQXplWkwv?=
 =?utf-8?B?MEpubHhyd2JveG1hSVkvNjJLT3p5QVhONUwra3k0VDI2cUZUUVQvdnU4YVh2?=
 =?utf-8?B?U255OC9RNTF5MTc0QjVFeUNsSzVKaEZSaEp1U3ZiUXo3R2dYN2VuK1VBc2Z5?=
 =?utf-8?B?NGpmVktyTDhEOG9pbzEvUnVjcHkrd200eGN1OTVoS3hISk5OYkIrZS9VRkk4?=
 =?utf-8?B?N3hTV25VZ1lqd1Z5TitPT0J3L1lmdm1zVzdWSDRCR0hwWVpucWxVMzhBcG9y?=
 =?utf-8?B?bHBEcExrdmRoMlp1eUlmRlBxSkhZaGpyMmdMNnhZb2FxOUxvYlZLNW54YlFq?=
 =?utf-8?B?cnJXZjVCYm52S1ZJODJxNk5QZkRWd2lHTDdnTlo2Rzc5QVpHY0orQ0FvVXUw?=
 =?utf-8?B?ZnNpa1U0SWpYWEJWTTBZQ2E5NDJJOEdLd25MS2dqakZjbnh1dTkrSDdSdXVl?=
 =?utf-8?Q?kD3M=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:42:41.0424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca77c2d-243c-4c10-4d98-08de1534ca73
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5748

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

Changes for v2:
- Remove the fifo-width property and add a compatible string for the
  cix sky1 SoC to control the FIFO data width configuration.

Jun Guo (3):
  arm64: dts: cix: add a compatible string for the cix sky1 SoC
  dt-bindings: spi: spi-cadence: update DT binding docs to support cix
    sky1 SoC
  spi: spi-cadence: supports transmission with bits_per_word of 16 and
    32

 .../devicetree/bindings/spi/spi-cadence.yaml  |  11 +-
 arch/arm64/boot/dts/cix/sky1.dtsi             |   4 +-
 drivers/spi/spi-cadence.c                     | 106 +++++++++++++++---
 3 files changed, 103 insertions(+), 18 deletions(-)

-- 
2.34.1


