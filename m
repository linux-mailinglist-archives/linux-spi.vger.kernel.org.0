Return-Path: <linux-spi+bounces-10556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75FEBCE85F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881AE5457A2
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF74302CB6;
	Fri, 10 Oct 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="bd4+Jf5F"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020089.outbound.protection.outlook.com [52.101.84.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E7302776;
	Fri, 10 Oct 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129128; cv=fail; b=BENgCycsoXqgok6oq9uUpvdqoIBXEWOd4q2H2cIrsprTAfj7lTQKhcPMdVdHOucd4+tp7tMeDTSefo90q+BNoLQkIvel5pyJYwR7/AblphgjvLq45DoUEVO9PrnixQoBohKq9p6tl3yawwtD0W04IVspm6gUyQE4GklhwLht4zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129128; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsbRdAd+HYX6MR1UvbS+nsNXp/R4oSK20Wn1KZvbSnK7gwND8SGsD2Q6X/8WxOouWT20Jbi0TXHunnGJjX8SzNzRMWNqZkXpZcHgyYNKqOf8kVwK94Frf7ULY23vernn3D5ITFXhANq6oCYbUYno1LNNkHyrk+yP8QstLX3qFKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=bd4+Jf5F; arc=fail smtp.client-ip=52.101.84.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPzddB8/VYnq/YL8BSeS9q+3VLvr8vnSLASAsvawwFSIog/EdUuSX5bx1FgM1mq96E8ozj4neJknxi92N9nZZopsgzvU072qrwOwNDi/aSxkwwIb2im+yBdV6pa5gPim1G6Acj0jAd6Jfwbrgiqlr5lL3BZwzGyv6RmAmhc6Vef19/1MtfTxsaoxqn2R5hyPFbKgCKWteEcmNJr/yNEn3lx/t/oD0KHk8DiSOUPg3ZgyVbi2A4ay2jM6/KLAEaRdSprrRRDyRjwJ5Yz0T3pVY53eAmdR61xxBsHg9lp5wWov0SoGedIPznx4t84gMJVPCyQoofjXgsaWGuj/19yCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=j2BODHS82S4jRFRgURfaOwvaVf2+iC0nJQstqVsgUTBOta5BVeZ/mjmK5U9bB5k5A526tqSetTYn/tuibQilRv3CsMTQb20lGJlpihPGNDUh8gjAGk/mXr30W5MUPyp3xZ+ubwPzY9xhK5Q+FAAtDUFIDcd/RGNDBEBFhnK3c8bXDaBiFT5j27iNssxIyrEpVhx/bA3aalzfvmbHlEeJvf7Xm/XCaHqGT2LHAhe+Es/3OhpM/elPFtaKUXYxf4axYFsNSi1VAn4I+uxYyEk0Cb6V09YwSQJS7croLxP6kuBXNjeDJx2CZwY4OsdIYLdmbVNyDiqlAbRbEbB5XPXnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=bd4+Jf5F/Yfszna226u9FteSN1BZyXBSpKgs3Biog7D9wPHj2hj1rabfUpB5tKxpLyUCNxc78J5uJILLhi8mpwjLYLnFkmq3nnwxQUiFner29fNA/6rZu4FBQUllNw+EwWDCXGxm+3now0iC1UTpWnvs34rzFbbIn7CHuoMV4QR+m7jYA/klEf3wW1upvRS307uqKcy8sDI4FYdYZ9dvuOOLmKCfMDTc0ZJ58wLGl4uPRc1389dG3OaBWOqBcvzcoyVRGWAISaHAZFEq4OS+yHQNJyBeSj72VRfgkNuljSy3AJujbS+ParL4CpTfGi8/sZXZq9Paz/JO0Sp3kCI73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8619.eurprd08.prod.outlook.com (2603:10a6:150:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v9 09/15] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Fri, 10 Oct 2025 23:44:54 +0300
Message-ID: <20251010204500.1625215-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd21837-2f60-4673-eb16-08de083dee65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6jf+RhW1pm/I3lHlgYZA8sopebieGHahJeJnCZZJEFcWPViJpZo5yoroYzuw?=
 =?us-ascii?Q?Rk9HVIHzDcStXWObvS2xHix7mk+OBAvWJGpH8qwEh2F+ZmF6pgkUNdXf4aMp?=
 =?us-ascii?Q?pCQeg5Cnr0tA8urse1xrF0JsBnCRbHFC4uXBGNLX5CZLYJq+BFEX6U/fIqKh?=
 =?us-ascii?Q?YU5qrCHMW20IpY1IFLv+Tv0pFjVqfELlkPP+UPtXUKj/dHf+XsFjyk85YfEy?=
 =?us-ascii?Q?0OezZLUMo4dlm86+4haT2zZL4pVFV1TZWWexlg+HuwL88BjPSVN0dfM848LW?=
 =?us-ascii?Q?CaPYA3MXFmLvWUIH7nCI4ZdKYL+PPAB9xgEhVoVwHzdcW3rfAvjzJWt//b+5?=
 =?us-ascii?Q?D/+vkJX3TkfWQp4/0zEdLeUU4thRSRssScWYs2b3+fkptP+SBmlcbkkrodJH?=
 =?us-ascii?Q?dRnDJJbd87JcFM59QlPtqy9Idch6p54vSKivI7q22zqvgBhyX6sWUTHsfYY1?=
 =?us-ascii?Q?XKKRAaPZbjPqqHYQpbCNAoeilYoUKxWuRnNXfGjLv2HG6Ec6dmXLNFPZSuri?=
 =?us-ascii?Q?gJdmTcH7Ck/C/qkoUpnlOkviLlnJJ9bQyovoU9UwIQll+9rq2Nn4ZKyy7+i2?=
 =?us-ascii?Q?R2miJZTb4Gz/N/mQsz0XpLh9ysMOb/GuzwW+iv0+53JDPVQ8SwtucwgP6OH0?=
 =?us-ascii?Q?LBXIagBhsZDWKnu2vGZdqdrC3hDRw+QOby+KPb2FJjfd9Rds+dKgloL4qdAE?=
 =?us-ascii?Q?xOoyQM7VAvTqlvUKOIznZG3xt9nN6QEsTj9+OH0bEy9pJ8nPsdd7ArXY8+Vn?=
 =?us-ascii?Q?MYHvvzxhX/ZDjRjKX9I4LwmYGYpYRYoUKhq5T1mc7mQ0TGQ5y4fzq8auUNmK?=
 =?us-ascii?Q?cFY0NYejLl6yuOLV7GjF1ShXf74xOr4pYhCN3EiR7L9rf/PEImLJoy/yuRL0?=
 =?us-ascii?Q?hXLSHX61Mj31nqyUqaCAhWZ6FDE+d9SkhxH6niMX5oZ7CoKaB2OHctnuV80S?=
 =?us-ascii?Q?Akgo4eCVzS4beA8JHnATeo/oktN5MraWT+291HUPEecJm4ATbH3B6W0P/7KA?=
 =?us-ascii?Q?cnuX7eKYM8lZh0BxvTqlyauUYTfcpYumFcXDpWPMVYqa1jqHk0JAaAEIauI9?=
 =?us-ascii?Q?OAu/SuiaubGgh1osbu0xl1U3Xph63i4FYxzXs10ppZ0eoGbdo7xfqZi1qWNr?=
 =?us-ascii?Q?7eC3595hkXuJ+Mj/CmZ5X6N5q95Ww42RAmDIpOwhZo8SoLQgsnW7pML7rPy+?=
 =?us-ascii?Q?yUkQh/kIFelWprfCgjUv8yW2kSOWbHilhJ8YtD5u0PqkJpFixaC2DzbqSF8W?=
 =?us-ascii?Q?VFDY73Qnt7hn9FuajBFCtO5bXkpGkAsEx3/prrFyyiQFbLaE+bARKHZTe8iz?=
 =?us-ascii?Q?T63K26HKhkhPIf2TB+7ItoRuDMl/Sk3p3FlhRNTNI+tRNbFh9FexfUmOZBYu?=
 =?us-ascii?Q?xkk52sn1Igd3VaqxguHXfcejV5e8WqA+wiKgDIwM4y5Sbip+ImW/Taa+x6Rm?=
 =?us-ascii?Q?lva+2ntPz+hvMfFiCUMCZMxZEgyUvDdWX4kNyn8W7YSEm6mDy44KA321SNxJ?=
 =?us-ascii?Q?xd2dSQPh5NsAKPtCccHLEOr+XsfgB+mRjsWp0CzhCqbxwW/eo4r+kgxLyQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wovF+mD+nitwtBcReMDsVtlpMhehvgxcNHC4DBPwBV0hK4e8UPzSUjUMjaSP?=
 =?us-ascii?Q?ekEpOA7qV2OWkp8u3f4PjOe9l+pDG8MeeHWd82szJx1XbisBwcq/WnQKnOLt?=
 =?us-ascii?Q?nyvCTaot1G16IYZtzJcbQtjVSIxrNhLJBGFVFmdsJikeg5QQIdxyJ9W+oPHs?=
 =?us-ascii?Q?GtHKLi/yoLgb1amLRTgChJzRwyyEuXrjyLoh1754QMMxbPwtAhpUTlGQCbSN?=
 =?us-ascii?Q?03TGeqrYogbF91ciIzuqn4spEnEi/V0iK4J27QLNyQ++9BheWcMndE801phF?=
 =?us-ascii?Q?Imnk3BL1R6S2FuGMgoIb5GuX0qxHzhjnrJy7GfgF6Hyipu45hLsldiQDECJO?=
 =?us-ascii?Q?Vtrmsx05mU9Lbd1cephLsjJqMTHCyqX2J981lKwUfxfSSud7eX9tP1seVXiY?=
 =?us-ascii?Q?aAGAnXVYoxQgyxkgAeu+V+4w9NiIhmhIQbiqs5iKNNykg6SGaDVlXhx4mkQ9?=
 =?us-ascii?Q?PhEksvMEk+cn67mo9ZcJ93jKcTBzcvFGam1VkYbpCigeHI/3ulAYRi+Mri6x?=
 =?us-ascii?Q?qMYZ3sBRipsAlvLxUKw5h8g0Nzzvsfuqip+gie0HZWU8Y4j66ATyJ6dW0wD1?=
 =?us-ascii?Q?rOoqNnttLepwJ1Eq6m/jCwKBtXwpTo/zjILDOAE7iTydhIb4lVQd3jCC3SuA?=
 =?us-ascii?Q?snYRljDifnuf9nPnMWIFb/KP31DiLXwKuCzpIRUCPfycyThmuLnUTbWiOD0H?=
 =?us-ascii?Q?oHpcdIa+kkU7TLtOEuE/qiGYxNfJwPv9+Quk5QuPJfJuIEEVR7O8iXylIgUr?=
 =?us-ascii?Q?cI0LBrTRAnaSnvUOojihP5j5n2I8hiSTbJkJ4zgNu3ZBPJtzSDPmiDcIIoMW?=
 =?us-ascii?Q?Fme05xH48p1sK75q021ZVMnE4SRJjWvyd4ekqFnTnK5QnOzf3/ywuGZ/3npz?=
 =?us-ascii?Q?xZ+eJMQ6iVcR7GrinLcHOpRA5sWSS85tchfvcG22w5ftWlsbnEvo3f4vO7d6?=
 =?us-ascii?Q?OYIHWSssRe7lb99C1rgcFPZwMURTcKS+9GgkeIU3LEg7qDk3Axn2Se5eTarv?=
 =?us-ascii?Q?aLNUOZKEthVbv8OpiNxxboy3aqz8Yg/5J479LWydmffEPjq9yFI2vs9K8Gh5?=
 =?us-ascii?Q?LcFS2HWYfNaXw9dzZvV6OLvp9wW3hL3IJ6RegPdQrm9XfZgt/NQdOm+6CyLy?=
 =?us-ascii?Q?TUk5365B2y3SWxGZ6pgzdpeIToK+lMFc3a9SjzPAKLm7f6pqCRnyLldFL3O1?=
 =?us-ascii?Q?IkfxUI5rMwLqX3alctDE+T0T47wGXDqEE5L7XQ953FuFKVqvuyOR8VYJn4b3?=
 =?us-ascii?Q?I9HqoiA4b35jgHoEEFvxJxdHpG5S4ELzerAaWigluhkzm3XqJwsP/2bOealc?=
 =?us-ascii?Q?tlkZsk665J8659PkbobBdjvlFAEY2s0kI+Kxk9WbjCv7JdONpR/bdL6Nk/Gu?=
 =?us-ascii?Q?8VJRo4BeV/GQ7tn6Kl0n/q/NXC65D9uOZG2nMQN7e86uTlopKQUOVGFUmg7s?=
 =?us-ascii?Q?Bg5tqT1I+Hp4MPgcZ8TtQmQfW/DtHNH/RWSB1AhBAu9xG6pM5IRD1+FN+Ygs?=
 =?us-ascii?Q?Nj/4ztBgecdCmB/PDCVEa+0knGNicqltVRbaKJYLm2GAWMR0doW2zcSZGORY?=
 =?us-ascii?Q?9CucNBStncXR11DS+KJz6FBjBQ9AnRJNH8jEQOWsgimljVlMve44/RYoSH2A?=
 =?us-ascii?Q?7RUjAm+81rWYJUzILYbNRss=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd21837-2f60-4673-eb16-08de083dee65
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:22.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6E01N1jjsZQjKtJ4N2pFC0B8DJc47oI3FEOFwDmfnYoCbkFMIK8F0ysCaDavuFOxK6d9uvoPhGIp4PlJRvuQf5Af9RBNEMzmeqSaBKSIWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8619

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 744eeb2b24ef..719b424d4cce 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.51.0


