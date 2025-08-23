Return-Path: <linux-spi+bounces-9622-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85714B325AE
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC2AC72E0
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448C1B4F09;
	Sat, 23 Aug 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="LaaRNKE0"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD63198A2F;
	Sat, 23 Aug 2025 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908213; cv=fail; b=hCyX+FwSXxyv/jvGU6vtmsABmRbPT8WSVnUIiJ0OklFsQ75AUA/5R9e3heCdkHyfTANo9ovU2AXTuyJbk4DXXCYTlJB54ARuk+RflvmVVVbJ7wSSFQK4t9FHWdU448zvH3bcch3vjr6LRV4AvNHsI81ySwozrvyO8xpaewbGHRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908213; c=relaxed/simple;
	bh=rytBHS5N0PtTQymzL2bvY/go8y8HDYvfkdzWmXhHtIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exDm7vtjS2DZkNa6P5aKsADnJfUrYD66TkQdbOR4JIglDMO2IZAn43EYRPMaCgyM17Xz/6h0oL8UihjWjv8f//0hwVc8ORWKFBjMELjQrA1pyD9LybHn7k3L4G6cvsLkZ/Ta3leIFMjbYrBxEvCANMO0quovy3B8QPAXRd93WMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=LaaRNKE0; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHHxQT7jU+BPJiQH1ZPCnJiehGOv4sTzHMFzylDYchChocMgsf6Ho+S46D9aFJag+ksQWHjV6LAcL4oaA+tSNn6hqbHg8WURJY7sBi42pB1sTnJuGH9AOlrcZXDwinUL7fNVXRIS3B4dNBMfukyQYLLKBuJUtFo6SdvIXDb9T04AxqhRJZfB6yUZQ/GeK0WDhqVEIsQN6dy1ekzlTPLj+/3AkJ41Cp/7cvkVnjDBADTBWoLgf0Yqy0cqV9jfO25GAWo3tyInklERCX53pFUacgeoSpEpiMSnywjYJ9IBkn6F4X0sceVEnMWIF6YNegM0abBRUrS9l8HORjg4Fu6GTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2edt3hCNhDDISlEQWDtl5hq5r7qRXf/kTUlSGVC3Zc=;
 b=E827KN0dGEAsdGPTDpYOnGfG00eYD3pinCE4pLAGQ49p9WWYxgsSPehaZyQzEli/JQ5B+z00mwtDkUASqvcSGrVM7F0FnpmRBaTkZEIo3Yrz2kRHzey55Gdp+etrLTinTNA+IPHrTWF1RL6hkMMbWE9gJAgMkPPHsSuJr86YeKhra4E8aqOf1ugYltFojZ7R9uxUBbBemIQBh3Bz9mjL033/80CGj7fObiwD0XxYaZncKDaBdanRpWw6YHShcxZu6+Hn8HEjIwTxqcWnnx7oadyh1oMVsMX8cnTcnUYX0jDf22giykgi/VPPCy6cOGkaWWPzrHI6CAPG3nibujvemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2edt3hCNhDDISlEQWDtl5hq5r7qRXf/kTUlSGVC3Zc=;
 b=LaaRNKE0UFSxVFbIMyTSdwCseFj7hjdIxcCF5GSmT9A5xJ77s+TFUhb3DzeLOx2IOZJQNFq3W2Q7T0XNoCDicrEh8y+PJJtgq2KeJ34k8SCNXSiQWoO3sjUx7wJ0YU/cygCIUlofyT3fTujeW+NF117edrgRLzAQE/R9rvFrBfTwRLKB0bjCSRHUjxaEBgu9HeOLNyQ/j00/U7PmvjB5ay7mDx2ww5h4BaePMWA46WfE4gnfKrZQ91nWcXTsmDNqhHYk4NDw0uHTvGQYAQFXHVPVNd7xYzFzB0+johe4LrGwNTqc6HXORHzgilXhQrZdrF0odN2dPgn5KmiJmOSHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 11/13] spi: airoha: set custom sector size equal to flash page size
Date: Sat, 23 Aug 2025 03:16:23 +0300
Message-ID: <20250823001626.3641935-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: c4456f0d-4dab-4b79-c4f3-08dde1da5746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/srWrnVC5yoOxL1P+08sGnF5aoap2B2mM0dmczQPdxzGNpo+p9WG1MaF8wW?=
 =?us-ascii?Q?cOAwGg9xEb3ZVEi4kwcO5VbD43b/U5I1ZScBPqaPViVIbv1SA8LZu0LP9tHk?=
 =?us-ascii?Q?+UTyMMhidcM+kprG3TVs2EczFbJJ9QxA1SFziO+9Yx8cpQduAmAGOCm+YbcL?=
 =?us-ascii?Q?SSI92YK4WV+8PTOaET7C6ImdxGuu07bRAGF42T7ZyiWwKodDlNzFV3wWFobD?=
 =?us-ascii?Q?LUU1uJXHitRKdMY5nTClrBzW8xUan59vBxDuwQYvyAPjKq2Cx7AnF8AyOIV/?=
 =?us-ascii?Q?tVc8WSTu7uFCan3MasJz4c+XAYMiugFFaQYiXnWIMwjgY0l4nOaqETeLqiQo?=
 =?us-ascii?Q?bkFJbmer3Y1O91ax9w92CvTnNknk1j+NWW7UIo6jDZmLWOsbpmuNRQE5JvFF?=
 =?us-ascii?Q?tNSH0pnemI3rQkLLqB3zI9wOUOdjdMw5zDf+raTXSrr809mwtzz/pRe0htdw?=
 =?us-ascii?Q?RZ1g9LesJdCmkeibLp9iUa9M87J8n9gNQGcKHbelDfDrtvFSbHFxso0FQRMd?=
 =?us-ascii?Q?v4y0IrYXr7UNIrFeLeZcNRol73aG8sUrdmPz+AqonzdmBW9NXTU3k0c0PI44?=
 =?us-ascii?Q?Xiv1+g1HJSzjKM4frv3etd9icFlkGV2C0Q9wRIeKW6xHSvspeEowWN+um0sk?=
 =?us-ascii?Q?czbQ8bnJjvEcBuRBQnJ25lj7Ici5HFAPu33M1v1QricmqG08evJ3/4C4iCOc?=
 =?us-ascii?Q?k5yYBbS+pAiRPllw5PYeEIb57FTQfYETB0Tf2pZDSqaEnNRHcoDLRAOnFKe7?=
 =?us-ascii?Q?k/1PhPrBS97Y4ENdB5slFeH5PqdbAVImOLhXmuvDzBqtfctFcgwX5S0ql0uJ?=
 =?us-ascii?Q?dc+mJWQEEOfLvBwOYoKz2GGmXn/wkp2EkaLDKxt9bSohCnPQfA38uDpZ0ufV?=
 =?us-ascii?Q?VU6YWOHpTF5Pnyt4zEAbcdtNESTNvnSFKkC6YOqdOPZC65K5ljg4N6Ej5QaO?=
 =?us-ascii?Q?/bFd/5MMUau5IIPEHx7LIOF8jrBwxZOpjsDaEcf3ZqNgIMjzWD6m3NWsN3Q1?=
 =?us-ascii?Q?GNGHwCp0JUw0VQU+RIJL7qL+wdGGdoK283aJ+mMzM6ntvfMgbSSVPFvGV37n?=
 =?us-ascii?Q?GVJJ4DEBgbWfR0ldcLEWXrRnM3/wcazNkAp/oh2DER6gUxRdB4gdWGqUWXZm?=
 =?us-ascii?Q?Qm6Ho6zi12dkNqZi9TvJnSYxI4Fj5OsKFqxy2l3qHl0qankv2Zu/fzOapdOK?=
 =?us-ascii?Q?WgD19XAzNOr/JYRcrBZ732q5+cv6w/s9bwyHlXnoTLVpvFGpS+//8QeKTYZ3?=
 =?us-ascii?Q?bNOtqiLQBaTPGSLb9KZqSTkt4KVj2KptUtsQEZqBcOVA62OS4YhiIPPCnIl4?=
 =?us-ascii?Q?FU82IrwzPzIgBuuYH1AbvKJJ1uStnlwz2F7QkvpDOpHK+LQktLxvIXoxbAho?=
 =?us-ascii?Q?KC7LHS67bHMAMUwvlrlFz7m5McMbdNvFHuvr34wHs2A4zQbS4oHycfF9BJGV?=
 =?us-ascii?Q?PTFK6e0gpNvjaJ32yKTd0kfUNeO6FrgT2SxY7SqAKOPY53PD8XuiWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3cTSatFXSvH47aAHqQ4oLsrMw2zPmaLOJNq7vaqfuHycAt3TtPQiDFjT/wB?=
 =?us-ascii?Q?77hShxfZIxWMezHefZo2tebJo97QGZepox4HBsMo7AdJ305C1RqL4GXXaO9c?=
 =?us-ascii?Q?Y29429grzu1HLsowH7cLWRAEqK5YVe3uBMTxDECYnJ1jIu+ynRGxMHA/ar4p?=
 =?us-ascii?Q?W4UgKlnYpvufim/5X1laiac69QNaw5VhImoYRu2r4FabsVnOSHn0mrzVjcY0?=
 =?us-ascii?Q?+T0Yixy0UIE6GaVhDcmDOrNtLT73iN+yp6qCz8lUXutHrMDhwJo53QdFpD4c?=
 =?us-ascii?Q?33Rv1vR9FpVIaJBgWvNqYS4nvxkcf9SZ0EYv+ys46LRp6JlA5Cq2EOnhbm/9?=
 =?us-ascii?Q?OBBFuwlUfFgc/JS8NcRG/ttk7EGlGub322Pf+z0XBa3WCLneWzTQBp2YnKgw?=
 =?us-ascii?Q?LQDftsriBwm96EEhaX5jYB5kG/2TIuRWMVZieVwIKfpQN14tUAbsq9lfmopc?=
 =?us-ascii?Q?scXb4H3RBERTqHJ2o6p5uxEnqnd8hynR87yBkwDqH3+gbWYFres0c8WWyBwk?=
 =?us-ascii?Q?QR8wfWnkE0yFQYfVWUoUKxGGG91LxKgpilPpx7TvRda4b6z8MfujYTyEU0XG?=
 =?us-ascii?Q?tsVxgrhQ6bzEY4SwDgQDoNazwQXqs120DEqBNjohXRxAnsp/uraWqwOzO59l?=
 =?us-ascii?Q?x2kAmCjR55bbsPOg80dsP1+eEMFEUjNLEtxZDg0n5QxA5ZIF2xLea59HzOvX?=
 =?us-ascii?Q?rY+hLqKp4NQCMcmcY+jiRs1BAQWTAijvM9P2O0NVY/L8Zy+GHBGmQkAxLYnI?=
 =?us-ascii?Q?nAJeaNMcW02duZkcGNH7UmkP9cqhsdSlGrnq2FY9TdoT6nsOkr8SD6NZHmGh?=
 =?us-ascii?Q?HT5SDNo3CzWXcpuj7RxFiYuJ/YfKqd8orB2yWMhJtmC8ehYpgb+dWernfwAk?=
 =?us-ascii?Q?dCy0//fg5NfKUEK0Rq0joR6lVgulsmNFak0+3X56JbKB1M9TuCURXIf3wD2z?=
 =?us-ascii?Q?eapDciFiHYn3ucZ+QGlGBUWDyA84YXmUYz2VeEcfvZwPd8LKOeoPYTeY7SxP?=
 =?us-ascii?Q?kPZiAyxPXYav9qWWmmt5EXPlDTMRN/Vvn3NrAmLAvNkkjiTQBlByCQQpRWfJ?=
 =?us-ascii?Q?9NUgJJGfj2SBKMqmNqoges2OXZDnoajNOHQXISSd1S1Hi/kdZsQHHp9YhP0l?=
 =?us-ascii?Q?nx0hD9CEKoWhYgAHSnq1QC9yR7wDFbaRTNDF4ZL3Sf+Ta0m3wXQMh8y12ukx?=
 =?us-ascii?Q?W1ecCY7GcqvXA4OZFbC2w5IF3KZ2/6oH+Ev9JjDFlES73pFhTsWgMtP1cj2D?=
 =?us-ascii?Q?Y1WE6qkzdZmHNQfZAi8hBQT5S1GGWPTPkY3gNwtRu2YatV0Aw4n5j08Rz3Eo?=
 =?us-ascii?Q?1jgnSoTxY/GfWlk4AYY6ghb2b2n8ATPcEzUAMIpZg6W+Y9YSNonML3Y5QbQQ?=
 =?us-ascii?Q?oOx+rUIzndlzLuBYc8oK9gE8/z1uYPBujrMN1thb/nm0kl2AzdtHmff2xAPo?=
 =?us-ascii?Q?Kzid+I7WUo3mI7KZOK3RDJez9Lw3h39jJ8sPbg6znNIdNwsNOzN9TB+BGzxF?=
 =?us-ascii?Q?Lmc1joNQeAOU6wzqKxclA8aFXpsT9peLH5IJAmQWW14hE6/7BXOsPvWIOnQK?=
 =?us-ascii?Q?lZAZ3SaJd5KRDcdOqgnkq6a6Mts87kGl7bFkVoEyYMzF08U3pwevxMBybyfo?=
 =?us-ascii?Q?INXgHX0zoAKDLcyWLsF8K90=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4456f0d-4dab-4b79-c4f3-08dde1da5746
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:44.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZhMZ8hTq/JBsKdDRW5c48uce+KvIgurpRbhrXC2MxR7R7ZKVaULuuAJ55srJ15HgEpDjsEt3TORae1mTzTzNt3LWn1W99nUSYFMRSuM1Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 284ec5534693..bcecfb02497f 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -519,7 +519,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -532,7 +532,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -635,10 +636,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -696,18 +700,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				 FIELD_PREP(SPI_NFI_OPMODE, 6));
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -732,11 +735,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -825,10 +827,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -879,18 +884,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -915,11 +919,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


