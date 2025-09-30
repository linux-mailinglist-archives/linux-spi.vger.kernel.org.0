Return-Path: <linux-spi+bounces-10374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7041BABEB0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A824804EF
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EEA2D3220;
	Tue, 30 Sep 2025 07:56:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022103.outbound.protection.outlook.com [52.101.126.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1A24DD09;
	Tue, 30 Sep 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219013; cv=fail; b=WBbuXLqOjICgeQJC8YkbgNt+oLXd+oBYHhseBoSkPDccLoITe4b0kPh/gSoewhE5yf/sNXM6VBecqmNoj9qDMNH4SMZRadvjYbnT8PlgOLFSuJwTPTuhIN48wL1IRnvER/LUKKc//HN7KzcPQA+ZokEg66fpxCd9pR/uHW4m3Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219013; c=relaxed/simple;
	bh=PWnTAGf/S3FvSdbjIXl579JlUTC7OGkmVoFzTceKlYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzjQQpt690uSRAR0fH9mM5Q5eQgxnw4DQ5e5QWEqUjWXzodqfoVtdeaXoCo6zZHq1Nocrw9/Ag37fRxJo5EVqCDA15aIKXYtsx/46BbMD3/9ym/QI/HMTFGtOBmKyXsQCy4VrF4h2iT3zed1IxY2HNVgNchXTk8NIKjYAJOi4Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StL+l7d7KW49G0bNRWyJUuSTxvGhvG4QfmSkbPMiNbdtEN7CsaGBlKvAs5gE/YENrNan6Mm/QYvCewsSvtqaaHCESx3QOhkGKBgQMvLZ5CY1EMyfdMzYRFF4plQz0IJzQIKXPhjGrhcibiFmnsa2o+0sPPt5zFNV7/aKx+YqV0G5ugfIJY1j/knrLKS+kQZstSiF6P5pgx8plW0y2S4urt4Cn+Bbm2zmCGYfXwx66thvwDOTOhbS2W3CWaj+TYMwo0aVw/gZMHoFtZR9o35aQzSIw5vuSlLVhMwUsR6ZVbmtoS8tTym1KAjUn3H5OYqyCE+5bN4L2YDuL44KvHxtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJDDr2WVlUNgqHDnO+O9w0hzsF4byKtFXI8ZM61NNo4=;
 b=nN7c6T+lsBVQD6AeILcGR7CLIQ/wlTtXK/T8bcw2p3DRu5VoenuujaXjBLQGMKeJBlQFIVsY7fv34iWzqyc3luji2VyLvIuCsYmWGU7IOoeE/hDyUUSx2WU7kY2YEBnAYo27+ef/q0uXLLgRyXNgsVFo/u47a05c3kTPCiXuJN5GVbgAm/gb9Qc4BGQF+Rz3MRRGc74hlg67Jf8vAjAn1mYmHun0u8WWN20V2+/K+Ci8QZObFJFhe803CjZyfZmk6Lzr1L1tVc0SImLn62PUAETlBpiBO6wapsd35tBJBcDk16GybyhQtcsD6WaxC+ULk2wS4e2yIPp4xQAUqsGjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:385::18)
 by TYZPR06MB7216.apcprd06.prod.outlook.com (2603:1096:405:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 30 Sep
 2025 07:56:46 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:400:385:cafe::7d) by TYCP286CA0208.outlook.office365.com
 (2603:1096:400:385::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 07:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 07:56:46 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EFE3B4115DE3;
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
Subject: [PATCH 1/3] dt-bindings: spi: spi-cadence: document optional fifo-width DT property
Date: Tue, 30 Sep 2025 15:56:42 +0800
Message-Id: <20250930075644.1665970-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930075644.1665970-1-jun.guo@cixtech.com>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TYZPR06MB7216:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 388d4ddd-39f9-4105-c89f-08ddfff6e73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FNNiVMcJ+MrLvfGsAoUdS7akCRdFcHacoExUZirObg/Ib3SWPA2SZHYHSpgJ?=
 =?us-ascii?Q?2r/aDDpIQ4RLMcOOa4xO3QcmGvXwL9sQ0JOPsxs48zY/kQCg4HZrrxSV/IIF?=
 =?us-ascii?Q?9KQzQV81B1fnQL0JLUtiTXxZL+chj2xyt0tmO8SL7TlzqEcW/fdCKJWD6gFM?=
 =?us-ascii?Q?faCWdkFANly1Vt7E+1fYqQW1SJl0ueJp7TqL8H5GQTPYTkntpLs0PWS6q4y1?=
 =?us-ascii?Q?GMlTopecWw6wTcL0MepbYQ0VUrntfEP1GIojF4BLAxzMvUqsDSzCS4KOJ+bz?=
 =?us-ascii?Q?pM0QJAscmYC6u+kwNcxoIm+PxMLtieHsxGpGgMNzXpdDhSOMFWADgr8x3+BI?=
 =?us-ascii?Q?+65wtITzq3nMCCjt0x+pSgAOfwzQoYchCReUMD68QUMvpVMKyNvCwz/Fkicj?=
 =?us-ascii?Q?N3+akGpDPcO0pT97nYa80Xqvro30HgYpSh10riHNaNpyvfQeSIq/+Zz0thgg?=
 =?us-ascii?Q?A2TbD8ioW7BwL6H/aU0g3ZKk2rWRipFkGGlfKg5+yAlLwUrut7g0v9E+K6tZ?=
 =?us-ascii?Q?OwZnb+UMtH0NRWapaWhYLVFnK2XqkXKwSiLENmiqMSXjI74BOPBzj9epuBHI?=
 =?us-ascii?Q?Z8ArmYLrUPx4k+cv0IhiqxGzAQvDHXANvnNTrJ56jB5sNJCExxuYSuwXJ9ES?=
 =?us-ascii?Q?Msdqp13QO1PyG2bpDR9TG/9X4uZlT9a1Jitv5ZU/wICTB1tU7EtLt/gCDZZ8?=
 =?us-ascii?Q?hgcDJuP7Y39v2YRrvSgEsOMNH5ZfJBhhyxu+cYnZ7zbXDd9GFCZgsGiNbuzu?=
 =?us-ascii?Q?aUxFSsHtr7TJVmr97LnWhpXSUulSG9dRYuP0L/y/mLr6sD1E4hDib/sFltDD?=
 =?us-ascii?Q?3akbd/ReDsNCvodrTvFNsSizujbFE3r2ugpwhmQrbaY/zBw7Yx0cCSOiVuIp?=
 =?us-ascii?Q?b9XC6mlRLYJCy8LsrRMtBTeXEMPbswbCkwr3++hR6+IcAgNetcvFP8iPEmsx?=
 =?us-ascii?Q?moB71CUF4BSgB81Joaqf3HYhOMwdSN2EvVcPiS6ywu70JufT4vVgqjyHY3zA?=
 =?us-ascii?Q?KWHTS0PETsSgQa95kTGAGlg/1EJT3Um1Ff7Ej5GeKnd5b/D2aDobGlSmnAg8?=
 =?us-ascii?Q?aVN2dfsQGxuB62pkQo1H2nRmOhzihJ70qRdOk1d11kXd0hBWBBd9FUHv1gxW?=
 =?us-ascii?Q?9ef5RVS0GXabAZjw58tcM/buQ8Ybq/dii2Fyu7HEZbyBzev4wemxxLsKW5tF?=
 =?us-ascii?Q?V3+f79DuVdyK3SxFDz7I/YStSw6jq8vRZbyWo9v2GR+gb+kUvdfs/sdMykhr?=
 =?us-ascii?Q?X2jhxao5chuR1ltwGGT4zKHmu6mwhMvXNW+6vSWhlR3Gf1LShnFd/RZuYtlX?=
 =?us-ascii?Q?JrYTtesrw7fuxAErn/WLzzQ6r7TR+vtRRv2dEcZsbWIlzoZk7/I03YEpSQx5?=
 =?us-ascii?Q?N6YZPp7VbrG+8oOUk9K5MG8/itozaL+enMQvw0JQjJVjf/jK9d1fZfvr4Beh?=
 =?us-ascii?Q?PYEYFtPvv4xZXKGz16FZ89Ssiqyd2IBtrk3j4IQ3lyKTltbfBp6smj1zh8+G?=
 =?us-ascii?Q?rNLrHX8toFiVYC0gluEB81zPg8LSh4P0Q4sQtAP4SjgApVYnYSJ/EEKRW7SD?=
 =?us-ascii?Q?1OguwK4Sx0p5fzUkWOY=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:56:46.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388d4ddd-39f9-4105-c89f-08ddfff6e73f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7216

Add documentation for the optional 'fifo-width' device tree property
for the Cadence SPI controller.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 .../devicetree/bindings/spi/spi-cadence.yaml          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index 8de96abe9da1..b2e3f217473b 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -62,6 +62,17 @@ properties:
     items:
       - const: spi
 
+  fifo-width:
+    description: |
+      This property specifies the FIFO data width (in bits) of the hardware.
+      It must be configured according to the actual FIFO width set during
+      the IP design. For instance, if the hardware FIFO is 32 bits wide,
+      this property should be set to 32.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 32
+    default: 8
+
 required:
   - compatible
   - reg
-- 
2.34.1


