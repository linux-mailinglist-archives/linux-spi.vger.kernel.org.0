Return-Path: <linux-spi+bounces-10843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE27C0C64F
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 09:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A3804F4759
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0A2F60CB;
	Mon, 27 Oct 2025 08:42:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023108.outbound.protection.outlook.com [40.107.44.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CE2F531F;
	Mon, 27 Oct 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554571; cv=fail; b=cqT6gmKx/NXVXYuH6CZ4aml3WJgmFC/BJYZ0q7VeFtbRcf2LEjO2BR1qi/GXOOSzjYoQGfmqFDbkMrBuZb2a+I8PC4CLy68HZwuBjcRBYUp1hTSkya4OfF9LLBSIUwF28t/Xmb2FgrqgjlgyjQtuRsJmIniYAjXYZfHen2Zlrxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554571; c=relaxed/simple;
	bh=gFjO6PjDxGCChsKyg3a4p7sZoWfmVfXp5Wel14qA0j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7LQk/huzJDIotiqGZiOIWFcpzRZ7uj5T6x8auYzz5bC/Vk7Gqw6N6b3R10F1JuB0MQvdoQbfNzdqzhb00fdiqblueaT3g103Tecnb0HoFHdM5e0U6YBNo+/N1dmfpcotMr1cSaD/i3NPLs0rhJHjpeABlk053NLDuzmmFr9n0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liK7QNKkWG8vPLm8zc6nXE2sw9qMPbQvxkQckVtfBSTESe0nI8G3HgatlkdmR5UQbiKFLg0UDy+O7KvS88nCKw/+AHyHBAW9//q8TzzSFUyeYM24pk+e4N1yWt/m5dal3Dj4z64BeolBDiff4yQ7cd4ytRF7JMXLFlFJ7uBt7qmVlNoCgwww7p562dglEDvfZCcZYHvftOyALMnBnfeomhjiSJ/OL1UZAKjj8P2Z8lDg8p4tXJX+zSj46zmwzCX5yLFGsUI3lW3iKn99XJnTDQ0xXaqQMfmZENqXXVBc8SbCmC+BUPvbAP8gd5LEhRO0VhqoHBjaHs95LqvQSDRxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnx1/Gf90HyEVMTLX9R0bf/iH1fw3N0nvOwqs2Qutlw=;
 b=ZYBfYtkebtnrJjhf7qAk+Um5jRUKlv53QbwZWGKd8hOIpbWaePB9NYK18LP9OzResoZDtP5pC/XqhMSRMixnUO08v7H00tk/0bdi4/3RwFABB+x8DXJANqH0ykXpthttxuhjPg1biMN1FpeADuFDtMoUvXIln2u6foTk64X+5+5IqJXiJBda8911jnHOMn7UVe084X1fd+2Z6mp7jHkQxvTEm+4WDbVNAuHM2nax6rx+PlIxBtDkn9uGsP4y8obwz1dvScvAYuA4DB4iGryCJv+zf3jFJwcLOowrVwZtfI9oa529t1+ICuqnZ7yG9Qfice3beSJ+8hnZopI5/tyksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0127.apcprd02.prod.outlook.com (2603:1096:4:188::7) by
 TYZPR06MB7256.apcprd06.prod.outlook.com (2603:1096:405:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 08:42:45 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::95) by SG2PR02CA0127.outlook.office365.com
 (2603:1096:4:188::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 08:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:42:41 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D713741C014A;
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
Subject: [PATCH v2 2/3] dt-bindings: spi: spi-cadence: update DT binding docs to support cix sky1 SoC
Date: Mon, 27 Oct 2025 16:42:38 +0800
Message-Id: <20251027084239.2610141-3-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027084239.2610141-1-jun.guo@cixtech.com>
References: <20251027084239.2610141-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYZPR06MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 360e80d3-ef3f-494f-f2ab-08de1534cad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhTTFRSTmhTYnVGQkZVN0tJbUoxNDJraG1lUFhCSmQ3ZEJTZHZKYW5BTTk3?=
 =?utf-8?B?VlZpRndGVlVOQ0tTOU8yY2E2KzBJcHkwaDZPOTYwcmtZdi9VbmphbDFXVnBn?=
 =?utf-8?B?Z0Z3RU5UNTlzZlNiaHdLMkFJZUxURytDTzBDYmVtWUY1VGF3ZnEyN2JUbGpZ?=
 =?utf-8?B?UnhDWnlLS1R5S2M0dzBtZ0tOemk3cVdyYjJITldUSzdVQ1gzTTVyV0NpT0dw?=
 =?utf-8?B?NXhUNVdyM3lmYUh5Y0VnS3NwcFpab3BvTzd1VlhFN2FPQzVzb0J0d3ZSdFlz?=
 =?utf-8?B?aUJmd1BJK2JlS2pCREEzR01OSlhoV1Y0aHR6T3JwZkZRSmNmZTBRcUZHVk4z?=
 =?utf-8?B?TnZaVUlMQ25rUGhUMEpIRTQ3aWdxbjJoTGtDcWVha092ZVUvTnZqKzF3VCtO?=
 =?utf-8?B?clRxUmlENFRKaUhaVGd4UWxUSGdBUHN2ZVVpdlRnVWZmVE1vMGdhbm50ZFQ3?=
 =?utf-8?B?cCt0TFgxSXdySGVsZHp1V3FtRXJVd0YxQU1XdFdadk9YV1NiVXI2d0dhaDh0?=
 =?utf-8?B?ejRGMnZ3d0tESHdVamlKRTIrQ0labHNCUUxYVFQ2MW5FdEw1N1oxa1pGRCtN?=
 =?utf-8?B?eGJtRlNFK2xwSWd5VFJDTzlMTmRJcjNadG95b0pkNmRFUE5VZCt6YmxRRjJJ?=
 =?utf-8?B?VCtlaml4M3NBWm92d25RcGtEbEU0cm40VXBJRjVRUFQxTEtBdnNjQzJ6d2Z5?=
 =?utf-8?B?cWNjL0pvUVZFazBWaVFsanVvYVJnMmFqN0dSamowRVh3SlZnVloyNE8xMnp2?=
 =?utf-8?B?ZEZlRWFVeGxDc2poNC84cGoyUEhlU1FVemNXMEtTSFFjbEl1cmkrYkdjKzhZ?=
 =?utf-8?B?RzR6S1R0YUZWTGJhSER0THpZM0wzVU44UFdsVU1majJXY08vdnBZY1NXOVMy?=
 =?utf-8?B?QUs2UXA5Qy9rN3N4d3NDbUgyY0h5VEgrRWRIK2NkWGhqbmtUenJOaE9OQXpl?=
 =?utf-8?B?cjRRTDJNQUdQQ1l1eWZuMXk1K1VHRDlYeFc4dUdhbEhPY0k0K2NORVRvNENj?=
 =?utf-8?B?ZXZ1T2VsV3p6aTY2dTVDUnNWMHNWalNrUGlXM3FadEVCTjlTTEZaU1FXUU5U?=
 =?utf-8?B?OU15RDdHUUQ2LzRmQ2tORU05UzRuMXB3VStCMkcwYzdmaEF6Q2tTOUZMd0Iv?=
 =?utf-8?B?U2c3cFZ5SWsySDFaRGFLUGZBV2RrUkVrbkRZWG9oRmsyUlJHalRNUWhBVDNH?=
 =?utf-8?B?MGw2dHV1VCtnOXd6NmdwdnI0SEZ1MzRBZXBJdFp0b0ZQS1pFd3FuSjVpQ3dM?=
 =?utf-8?B?UjFqWnJTK1dNM2kvVnV6NlBPRlZPTW9rZlR1MUp4NmE2UHVtQ1cybFlBVWR6?=
 =?utf-8?B?bHh4VGgrSzdDOWhLdEZPM1dzUTRad09LMHN2U2ZpRHkzUm9yS3lHaG0xTGFJ?=
 =?utf-8?B?bTNWUWUwYVA5TVpYV2J4ZXZ6K0hXN2JuRUZwOVhOaVhNeTV3d3piUitJV0h1?=
 =?utf-8?B?ekptVGEwWGxwM3NaUVZHRm1CMFptM3RlaGtYRHJvQXFZQkQrdk05TElmM3R5?=
 =?utf-8?B?cE02YU5FUldiL1BxeXp4SEhra05wWUFIc2lBY2gvUnBtV3F3TGtXZXg0SG9O?=
 =?utf-8?B?WG92d3NYMmpTcVhiWXZNdDRMRzBGQ3hNY0JzWE00d0JKR0FLb2toZy9sdFdD?=
 =?utf-8?B?VzA0U0tzamRZTVI5WWpVTmo4SGZwbXBaVWE0cVk1U3ZtQ012TTQyUjlpaHFz?=
 =?utf-8?B?d2p3L0NTNlFWTU0wcFlhdXI2di9icEdHajdERlk3WWJTcTVGWkJoY09wZHpP?=
 =?utf-8?B?dVliOHhzMkU1Tjl2NTdKUzNFZWVscXZwM0dsUW9heXBGa3ppTFhDU3J3UWdL?=
 =?utf-8?B?R01BakFRaG9ORUhMWWRIOTljOGhidkVhTGdkajJ6L0hjRS9waXhad0VQdnk5?=
 =?utf-8?B?dXRrTUdRQnRlOWhYazh4aGlYVkdEeHVhZVV5K2ZLaTIxVEZPbzZaS2JqS3NP?=
 =?utf-8?B?SS9ab1lvNmpJd2ZMQUFSVzhSTmIxWGlRdTRnZDJBQXJ5K2ZvUk51Wkhjbmc0?=
 =?utf-8?B?LzRQRFB6REp5Wlp3MTBweFN6TTE2Z09LVE5rYXAwUWI0Z1FQVzc1aEtLS1p3?=
 =?utf-8?B?bnBmeGp4cGVtcWYwYythSjZSSTlNT3hyRWZHcGZPYVdXWDN6TG5raTVjaXhw?=
 =?utf-8?Q?0b/4=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:42:41.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360e80d3-ef3f-494f-f2ab-08de1534cad0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7256

- Add new compatible strings to the DT binding documents to support
 cix sky1 SoC;
- Adjust the configuration of the compatible property to support both
 single-item and two-items cases.​​

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 .../devicetree/bindings/spi/spi-cadence.yaml          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index 8de96abe9da1..e75b142a1368 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - cdns,spi-r1p6
-      - xlnx,zynq-spi-r1p6
+    oneOf:
+      - enum:
+          - cdns,spi-r1p6
+          - xlnx,zynq-spi-r1p6
+      - items:
+          - enum:
+              - cix,sky1-spi-r1p6
+          - const: cdns,spi-r1p6
 
   reg:
     maxItems: 1
-- 
2.34.1


