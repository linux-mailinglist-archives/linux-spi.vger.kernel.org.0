Return-Path: <linux-spi+bounces-4337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07025960B89
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 15:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE731F228A0
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860681BFE12;
	Tue, 27 Aug 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CK4Ujuvc"
X-Original-To: linux-spi@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829E1C3F29;
	Tue, 27 Aug 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764381; cv=fail; b=s5BsfSIRQvpkiTg+tvPY7hV79tb5qQJ5H0QcL7nUbV+3ahiRKZuJKUMbMk8xDiiZQXSxPabbT3hGIMPmktHqW0kRvqhI/KkSw/nGiemzb+XDqsU8ebHuZGAqEZ6k3zPhtsFU391SkSRALCUjoQSHJDr2kYw9xqafM3D1knvBLs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764381; c=relaxed/simple;
	bh=hKMZMAiBVQAV0/4cx15C+zIYSk/eEMmOvi5YDf94nPU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iyLWaZiUDhf8r2w6nF7hbOSuLdXB1rFbyKqOT1qTI6rzc3ZvmHewyromd0d5QjnDALUOFMMTImZPl7xiuXPuQuYcpIkcG5b3YZgq+ir5uExf2+sPocRRmzklcJuXJYCFWeoJuZu4ngliXwbafLBg5vSIDaamxk/JteigZRi2AKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CK4Ujuvc; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6P+3n4GdPQ3ZkIlcQgnQN6QXJtpkyL8CbPJlD6b2BduP4Um1Nmi4uDe2kVBHI6D54HNnV/YaZX0elzqjtHvDzV/y23/y0V9dkc7Qzyhd7r5KVSGYooy1GCkfSPOYx61jfnkcjk/KQAj18JJPaqbWYQN7FHWXplX88L6amg/pSl43IQZWUqbtHTY1BUm/4Ut5+vNS/XXrFa2mAPtyM2mv/y3hSOGN7CR5jgMq83O+KjiWbPHsZW8or2UDlYBEQ6wnwnUyGCTrVu9Pjv9JQH1cO4GxEEwJxJa9QaiMMhzu4ZSNBIIEA1VtiPGozkQwYNB6vKEOaxw/WdnK9LsH6yWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa8B2YuLfFlVC48CUJ5OkES3kEuIlUF+Rjl2IgbMwns=;
 b=osDfPiOoixfl7WMkn7xwJvlyYozuBBtaZCL49+3rQQxogVqCBnGDYo1HCFyauENwRxoUZ7OOd3BFYx2O+bmocPrhhF6+jPPNh3sapOqn6VV6YCKyRXzqhpR+mpYFyLDxkVgwfyxPyixDFmFCV2Fy3hnsRksIfxP3jU2v7QQGFtjyT9mA42I9uTXN8MtXkv+Rk9CnWiQPtkP5raOjf4Jkok/1sY+YmyZITPsPvQB/zPbkT41IzWYPDYjtIbHg5QAnAg21cQysxrnYupwJZPEpezVbjRdl7IITcCiCd9HPtnemTaQnrde3SMnR1Jy7/zLtDzcm5Yy9WupptXDweCF9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa8B2YuLfFlVC48CUJ5OkES3kEuIlUF+Rjl2IgbMwns=;
 b=CK4UjuvcZ5tHIEMB2DoMWX4I2yrBmJkZoDmcQNb5HP/SR5b8H1ilqprf5AWXrOBX5DtShWTp5+IOvoNzcdsPMhUbu1iWU++5qDFBePVaIXQVbxIcEbA//0rx2W2XZg8f6kh4nz+OwMucfAGDCRiTsBGH+f1UocBKKYxUZOmFHzfRQ+9GodZk/LnJnzn/wKjoOWmVeGppADEVT5fytSCW/eeNkBozxsoFkILEU4KBbe9BJgv0jX3lBSJeGp+rObtt2kJU5EqyjkYSB8SOrRTiPSZ3ea7gf/FLrFvbo0bqe8MTvsLMriaQCOtxvA2YwQ3ZaECLZLODxBSxGUhIEeq6vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB5916.apcprd06.prod.outlook.com (2603:1096:101:dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 13:12:51 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:12:51 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: han.xu@nxp.com,
	haibo.chen@nxp.com,
	broonie@kernel.org
Cc: yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v2] spi: nxp-fspi: Use max macro
Date: Tue, 27 Aug 2024 21:12:03 +0800
Message-Id: <20240827131203.3918516-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::23) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: b155f3d6-9b5f-4518-b5e0-08dcc699f492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hdooefM7LFYfR0GEHzVkGdosZkXxjws+HDMw+fmFggg4/5z2VtUy6lXNr/+Y?=
 =?us-ascii?Q?VJWygkOq9k/d0ULspq8e9hm6JIf7hQuzVNgsrDaiQSvnJnEYIojrDnEba3bp?=
 =?us-ascii?Q?onM/F0EJcut/stB3QfrFTejHtiJRp0mW0tJXfOZUvZBVdH4RQ5l3JTh6mHZ3?=
 =?us-ascii?Q?R2c5I2Li2aUr3ne4AO/iJ1iqn0a3soAWXMaVTbYyOYBybd5PIix3/RFyhlQo?=
 =?us-ascii?Q?Z7VWTCTE2BmPkF6+QC7uiPnNfcTqSuUpPASD7etdz9nC6rZxpDdZ+bY8bgzg?=
 =?us-ascii?Q?0ykYUC2IEt4NG/85ylbxKpUw2FS1ZlB9kQ0/KbjHv/RQlM5iD/uTsPq81geS?=
 =?us-ascii?Q?rXI3NcuiZYcmQoXrjpzDsokJDsyQ0Bio/PKwn0OuaUbOhocMzoFX0xPqkaF9?=
 =?us-ascii?Q?vd51V9pvwsf5m4QT3VXZuhqk639qr+G8rlw0nFO5FSAl3D0Nj1yFxZNEneP4?=
 =?us-ascii?Q?fE3KrCMU6Zd6ehFO4K/JGCdk2Anb5+DgAQmY1asRupz/sBiYG75z62leeugj?=
 =?us-ascii?Q?vzN7Dycrf185XO6E0C7c0pzdQJwRcxYRso0Fna0iEWiThdi4cdGnenOpsqHP?=
 =?us-ascii?Q?zxRcPbVeBwQezhl694JyrnlgAefKR6PMAJOHZ5iGBVKdVU5QO9vKYrc8H0Nx?=
 =?us-ascii?Q?WAHFHT+mRVMgKmZ7gMIwdBv7RTe3AN4UHO2Hq7Odi+5SAGxj7H8TI/BulA5f?=
 =?us-ascii?Q?lvOcyXL/2uE7pphQb1i8rwdXOywjri4h3BXbDEaCi38ClPkdXKCvs2TyqHgy?=
 =?us-ascii?Q?v8agkzZgFZ2zCJFhMPlsP7zI7+JhHI9NgDCONvpsYvLhh9/TnRFY6gCbAwcA?=
 =?us-ascii?Q?ixO8UHZosVmK6gkcwg56XebQAu67Tsfg5yS0UIy3bsx9XSKRDyLPmjOlcuAC?=
 =?us-ascii?Q?Opig14sZsHSHYNREW7KodYbObpXQTexE//qLpAwI48cFsv/WDRxwMwVByj6F?=
 =?us-ascii?Q?7HsBFBneysLnjLe1OhDZSWkneDv7JxMedM8k3kl1kItXUq4cm5SvgQwGtw0P?=
 =?us-ascii?Q?/vUR7w0ungLXEDb05lDlvoRahBakAxU9CyG4+kZ07Mh2TLa76i7kRkTbUOON?=
 =?us-ascii?Q?mfZnIEyBQp+/p7dWtLiJ05WWt1XFj6eR0fg8/ORAkrGTcg8K0Q1h3oOL8rpm?=
 =?us-ascii?Q?Ku/ev//Qec6LwQTEZNyNp0eytRb/FXr9yDR9RkwcNL+bGNIJnaFwfKWXruob?=
 =?us-ascii?Q?3CrA874bRgyhgWZH8Ufm2Lgjd2UVbvkmvWKtH8/40C+gy1XWQdj98Gg+J92D?=
 =?us-ascii?Q?HAax10MNwI53Avg/WBphqNSBYRhybbENpJXICSSD48XpX8MJsfthxPbCdjHp?=
 =?us-ascii?Q?lPRJI3qd0xyWhQs/qqlvGCee1dN2iULeyQ1C74ZUujUtSayHStAPOO92K6f9?=
 =?us-ascii?Q?SHEsPsHvv3mP17LNuGxY7roT5VicOApbX6EqERoQK6bmY8iT0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvlDeAaLNIwIunFBQESV0Wa9xDStH53jMrbnyC10dSN5il/ZWgkFjjGXrCL2?=
 =?us-ascii?Q?q59cFlIm9+8qNR6idkumQdgeJ7ticHTl73eOHOdwh9uLXByDmscu1kLH0YPG?=
 =?us-ascii?Q?bR5+nE+JfExaGk1ebcZacXizVszU/tXXtDyUimSu7ipOqSI1mPIix7d7ZoUm?=
 =?us-ascii?Q?UvKztHy5IjbBUTm4LisePKUi6YrbQ1rUW1xy1ZB0tLjvybVSdWDddU4/d1jz?=
 =?us-ascii?Q?VNmdKElFyZBj/MgOwNJPewx9j8y9iKi6juRdwTpKlF6V4jbU0DzUQ9VO/hoL?=
 =?us-ascii?Q?HnibU3vLpFWcWWAzgyA2BdhsjqD3F1Js3eokfsaHFWoNwwve0Z8Jm3ULmJ6X?=
 =?us-ascii?Q?Ogq1l70oXPsJK2H0KhiELyvX6FvlVdIlNO8bSfzR81HvU2WQ7jBN47rcHs3Y?=
 =?us-ascii?Q?F20zzQxZatncrrH07X4BzfjUW4hbixrZkCUo9Q2b5iVPYGP3KAWCpWB8WEKa?=
 =?us-ascii?Q?6nSWHvAImyDiD+8NJMeCqx3J7fWAokVcETDlQZ5QFSi27Z8Xg5ROsYTuGfEP?=
 =?us-ascii?Q?GtGjO8K7biSqlKouQ9fLF4EwVI0mq3CqBi8knA/2GSgecS2u1LUFsX6SMBQd?=
 =?us-ascii?Q?ArEzAtcwuNxr2MHyvUg7b4M7q7cFk9hArwEN7q/7eUnX7CA0b/eFSx9zM1TE?=
 =?us-ascii?Q?VsZcVZTVntFcphkM7gBSBQ8D88ksL3/+3bf/jweqH8aTAw0uMNCLzl+7l4pQ?=
 =?us-ascii?Q?JnCmWVEPOFYKhQlBqy5KAz3gLNG34DoxFySevinOYfcDEwGPGCwtyKZoS3xb?=
 =?us-ascii?Q?uJvPBSkICrlJGQuLIBl8bkcK7gWtuX+Kyog1Asuvivfr5UJUxTkO2nWeUZB4?=
 =?us-ascii?Q?d2JNpqWhjyUCjO9+mvutvV/Prk/cXcKvoDZ6hlplYPMZ7k4jB9XQb6LK+gAx?=
 =?us-ascii?Q?3CDstokHRANDueX858tpaP2I98oSBTfqfRi+fyDgEyZCN4yBe7mk62jKBGw/?=
 =?us-ascii?Q?8cPUnVPyG3ndKDp4ZDdgGIvG/i5J9B5NWkvW41BgqDc4OlNdhlYPiRVRpc3C?=
 =?us-ascii?Q?fta710SMwo3UyE08PAE/cGIPvP+0Iw9LxXazU2PK/IKzfygXorCSwqLiMwQf?=
 =?us-ascii?Q?/kTqYIclb+66ppb9FuxYHJJ0s0Kl87hJfGH3LGzd3CJohV3t2Vr+4DONoOPI?=
 =?us-ascii?Q?IujqDx5R0824RwoJyjCwec0wX/jBNTVsS4ePdzJiQUDmX/dcswkM0+3CO7pz?=
 =?us-ascii?Q?Pm4Kraa2WIAZKWmTDLjqE7VdnXMT8wDmLxAuyYsZ0oy/xJ9/pf0RzX4SIlPH?=
 =?us-ascii?Q?JyovnhfidGEUXBphDLb6Blxn3iJaMk1uZ1u8wRoAI3rgcWEQlmBjjiPlzHJS?=
 =?us-ascii?Q?mcG8is3Nl7P/5LAjyP5Gz0Vw9ET5t+UtRcY23lZExaA5T0hFe7fE+2xcQ+3X?=
 =?us-ascii?Q?hbAcWbw+b6oWZRFMEJfMg9Sg8PtuemjkeWph/YvvJe2NOYkqoFY9q/NS8DD2?=
 =?us-ascii?Q?cm/GpP6M9CTrVDFItenfMp66L5+Z3Ez38lOspx6hctbmSd7OgsMLTC/+aFUx?=
 =?us-ascii?Q?iEYAnoyUOnKLBT44eQjxdLmSEU+U0Po1IgRvlFxKQTvXzgYKT5oW75clcQpC?=
 =?us-ascii?Q?B3RsMb/+iTe9ciZylJPg8i6gCcFHC+eg9KDwfwTe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b155f3d6-9b5f-4518-b5e0-08dcc699f492
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:12:51.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASEGjlScHxJn6eSbWJGRwlI6oAfuWmBrpUlYgY64BWj7RPo/8GOmHtcb8slOvCah8juXkVKJZrNI2pYMxzLeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5916

When the original file is guaranteed to contain the minmax.h header file
and compile correctly, using the real macro is usually 
more intuitive and readable.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v2:
- Rewrite the subject.
- Using max_t() instead of max().

 drivers/spi/spi-nxp-fspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 88397f712a3b..fda902aa5815 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -756,8 +756,7 @@ static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 			iounmap(f->ahb_addr);
 
 		f->memmap_start = start;
-		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
-				len : NXP_FSPI_MIN_IOMAP;
+		f->memmap_len = max_t(u32, len, NXP_FSPI_MIN_IOMAP);
 
 		f->ahb_addr = ioremap(f->memmap_phy + f->memmap_start,
 					 f->memmap_len);
-- 
2.34.1


