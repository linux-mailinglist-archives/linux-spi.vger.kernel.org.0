Return-Path: <linux-spi+bounces-10586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F9BD01F1
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9513118940E9
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B29279DAA;
	Sun, 12 Oct 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="mn8pV04j"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A8279351;
	Sun, 12 Oct 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271465; cv=fail; b=DxdOJp+cYHERbo8d9I0TpH8JPK6n2xt2HOS2DcyDc8tNUHquacNPRsrwUb97LFZbRpWCk1EN5jvlqhiA5Md9d8f4Ir51nfM7BZtiS9HHzMP/4GNff8zndSjGjjaBATFY1KR1c8hPrQKs1drlQLv8K4tdk6xkKtcGoMMv7ZI71nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271465; c=relaxed/simple;
	bh=RiKbo/qwhlU6jP31RsuFL9gEwPwjUa/P/53eg/G8Wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbtDWYT0t1FD0xz5DW4tYkk+i1uZmLdUjMByilD0BFChwwRKEFarN//Su96fMYUPmM3pqZru3UWj7xcTDPxfax5ExAuLwpIJyaTWUin7pYFEl4jMUS9aEydfRt58ouI4NM/FdLknqUpz8Svjw4F2zKB9RniB17bwLy5V2mPXKJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=mn8pV04j; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjrFo50DHjZYye2J/pLF7/a3p9oDoOadvVoRz0qJfo4aE2d/xs4TNUrN9pI0nocyFDSc95yjwhiOY/+/LCQiSMmYcV3V1MS0wCk7g13yltoXzaMeZBtdyRwEXjXKWsudYasuym4+DT+DcICYh1et3KBZo97TvEYuZ+TRKNJwqecMMOeBoSjxhcU1yl+/xZP7JddfLxewWeQ+T/MuRDaVfUbU0vsHtmjbl4A6A0gVB/ewYK6o9pXqJbh02e442o+O7+fg50H7ds/1qwGRmLeF6vWTHrep4fUh9apKZ0W9wG/YMdf8IiQoXsXYJnt5+alcU6CpdpAeiKeRgAtTG6BNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=MaNbPJWPTYMDmB2RcARSx4wsJyleEbws2IQeEDmPs0r0jDDU8MJsmwLUgD6DNs6IcMahfapTzw9seaJrKoBO3EDyQLwgyS9xF5LHcrgP8xO+4ZUt97YZIQwJ6LcNjhnPQ8dOPEptcom+MXnQ/Tc7PbSqugGEVyyp4icx70q74nj9IDX5Vm6LQEmCFUoNYvHTFTc73zCL5nfL6qpwn14lvLMzp5HvKD46NLJDaYfTdAw9Fn7LesAG5n2SRLSl3RQBrg9oavkNmPkblz8VWBL3USV/OWKjPN1AC3ymliB5dTVasYy7ybVwtvJ1AroUgioNfA0wXVnvJ8jhoI2Qh9rlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=mn8pV04jtXJtQ47oUUb96bCoZXh1youbBqTkkIE9z8Twhiwg9wKOt4Xzzl6ym/dYaA2Q8tZE9xrE24AEkwOIwnKbDNMb3HiRiZOYBFhBuWobzxpWlHQcVFfpJZ/tfO/V5KGaJKre59QkiIlKDHUG/hcANe1Ly+RiX8LMzVpepByIbV0hR+K8QS1k/SY8jgOsyhQtex0G65rBLZMfDbq6gqpcPQ3zSG2tm75ORmVkSQ20qxM2BjkaJdp/QfpoMo32mX0ku6nm3s8XkVHSMGAkaikPxg2w+AdxqK3/N8tLiAZNgwKmDd3XYtSrTKBUs1W4M5wFJ/7ift5dAmXpPdA5+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v10 11/16] spi: airoha: set custom sector size equal to flash page size
Date: Sun, 12 Oct 2025 15:17:02 +0300
Message-ID: <20251012121707.2296160-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 639b066b-fc77-4946-e5a3-08de0989540a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7vFO4wOG55dAfjFkZBW2F0eoGEvt0cc7Iv3AD1dGuB0KCjdfs3rrML4wgljN?=
 =?us-ascii?Q?57DLNyMMogGa6JJaXXTZQbUZt9zYd0Ecztc4wHHV3myzl3zLT2qLyV1gkxyj?=
 =?us-ascii?Q?T1+nhhWiQvzHIVx1Urr7ud9KOIy0Yq2mLQbu5IJmTRWpN8qdPVWwt/9bGqJY?=
 =?us-ascii?Q?uzmuKTLWJQ8sPVobxZbX9MrmSGiibHd47Fm5CrP4LyMh0VE7/xh15TXkVEfq?=
 =?us-ascii?Q?tl/VVHpuMJNgRH14QVgyS4pE/OVRVNHKPLMM8BTsA2Nx7mTCN09ZPVL8Kl5g?=
 =?us-ascii?Q?+XrBj44fqcO4y9ZSpgjh90IeVIEoELv4mKmFH+5ZLT4EeSczaxgVxt1HKe1P?=
 =?us-ascii?Q?yJlM/+XG8/WSVj+TOrYWjzvX1869F4yFydqYckCZFTRcwLjG4+UybYHsm3NG?=
 =?us-ascii?Q?lsTcI09d+eyd47mQwBuV/SiW0l41X01gU8jPl5zt6cpOhkzwHRKKstY+Car8?=
 =?us-ascii?Q?0JzyPaaa46i7yYuom0c914q5XYx6JTAhyb61C6e3IfBeQ7yO7z8uaADlOKDG?=
 =?us-ascii?Q?gxxzbDpp1L/0RotH9bRWStPhHBt+GH2LnCRbGONX7o+s+dv6pf3ehaB9VeDv?=
 =?us-ascii?Q?dKHoRiQRCzgpGI3zuYOyeZHrSZLJsfzlDZPD7bV/DyVmHrRJb4vcUuvcQOxH?=
 =?us-ascii?Q?jXHMKp81nZL7z6tESewcTAXwATI8Gy66Z5Wtx3I7sPvHsZQAi7pJd1M41Kyr?=
 =?us-ascii?Q?BC0RSnYgDSjDTCXOZmu2LwyDMKy5WeNHU6eKCEmKxwPHkMdKGTO2CwxEoJPr?=
 =?us-ascii?Q?qZNIbYbwmZs2Ihk1J113vr4/m7woyBv3tm2Z3kyZYu57pzpx75HOwH3fLo1O?=
 =?us-ascii?Q?KwsYc6pZM+P6pplINFTY0QTkvaRX3YcvllUqY7zt6mNTa9dX1N6DWhHxoc72?=
 =?us-ascii?Q?rp0aPG7LP+mss7aRr8RG9y4RrSCl5AfxcZHy+77/d7HyD9A9CVhRJ/nUOnRE?=
 =?us-ascii?Q?nT9E17KMpNkjB3DUhgnfyetpg/uTH0gmsCcriy/7vIrBJd5uuXDuY11rTC3X?=
 =?us-ascii?Q?KJ6oyseriUEF1GlaAyBIuGiZUKEWQExj5UZRTKKddAkxOw9B/5GcI7fuMM4A?=
 =?us-ascii?Q?kMVDikKIsQMRs4Aq1jaIUdYnpS9LupW6ss03deCHTXL17JLzGcjdOrj+qYYV?=
 =?us-ascii?Q?JT5FcBLhSZp3O1Knncq0Q6SoCFdhDahJUPiknUcWXceqT98eDax2Li9IzZxo?=
 =?us-ascii?Q?GrTC+qaw6LgeutWZl8nq7RQKvzgo7NoJ9epMeMHpgsMSD3kLackH+N7pj3Be?=
 =?us-ascii?Q?lslhyOV8p7pibysE7dxUXCplY4UNxsQM+R4OJ7M8yXL8EriAQjvxAJHO970c?=
 =?us-ascii?Q?/HXeHQxHgRBkiAoOgV9zpE0nNA839b0WE4DEzbhqUs7BoMrqZjigfadrjEpu?=
 =?us-ascii?Q?/7qBgw8mztem4Wb5cqC4SO2sSIH6zWcTSTBwveRuWNahSo4EI8oj+ArSgXBD?=
 =?us-ascii?Q?cnT2rTxYX4Jd4T8R7irbsWdbijVXkdjTD8BTjdlc/ycK3ei8BU1BbcPRS53v?=
 =?us-ascii?Q?qisLm0DoC/HDwM4QoYxDL7HIWrhpkIGcDpOHHwS1umwCfYyZKezpws83nQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFSOHJEoddpw5wIrVepxKsrTwsuIwrRBi2uGi6mecsP0f1UY0i4HTgLkIYxh?=
 =?us-ascii?Q?65z4dNJp7tnTjyJDuZbqiXnY2mKAOJ6FoI4Wozt2arNTkyxszi2QpCORUXb2?=
 =?us-ascii?Q?klpJ+DiM7i/i5AU8j7y1JUIMy0+TESvNWB+cXXUevlahxZWoYmg7P+l3j2A1?=
 =?us-ascii?Q?AI0qbzK0MNRpBQJ9gVlpOuz1yINr+HPj8Q5Lzbk9et17ImrArNTE4VqL7qUH?=
 =?us-ascii?Q?dQtDcMdNS4VasVQhxmrBv7SZe4mksj6X7YpryZ2BI30LU1HCVpo0JpAEbFBU?=
 =?us-ascii?Q?XjQxjPwMwDqhmSj+jUucqHyYnaHzPXqUmfpDYsPsgyxussKp4n1c/2C521Z4?=
 =?us-ascii?Q?xlYckGBTf9cYhwZK8jmpI4AdNReiFokAfWmTC2I3VDvJTm6jvE2exoID9DkJ?=
 =?us-ascii?Q?DwkPDoJED7HX11vacnHuqsjVwQykiAG/DpMDJ/hpP7eW1Y0aGoIOMJBXQ8Bp?=
 =?us-ascii?Q?CDHzdwaqGrecKbV11tE3tryxJfrE8voUaCOlH71xnJA7y9/VT2juhUOCU5GQ?=
 =?us-ascii?Q?VDXEbkBeS2Kv8VKniprSK3MTfvMD4+NuA2NgUXP78JaoBxlQzfq86VVYsFlR?=
 =?us-ascii?Q?uWFMhBADOrS/xQEUbZUKWYZ2Ympsh0DWWAKJsgEdeITuC/UlxgGVGqbUV1b8?=
 =?us-ascii?Q?pOWsira38oL83kjX+4Zhx+PKjZRmXPtc+mtcZ9H8vium/dllHcASFhZJoAkB?=
 =?us-ascii?Q?bA8dJ4R64sbVjL2Bv57dj2K1Qs9EDKvosNImcKxKAjQ6hSsi46s4mJJuxcKz?=
 =?us-ascii?Q?j8cJSbqYN3RYeI9BPKLLRJjaOfTUALTxoiNpMhEFEaY2FvQH83EtkAbNqb1w?=
 =?us-ascii?Q?n9EEN9YH1aONlDW+Z3LB74rfYn+y9AWwOb/j/mFM/1RdxvyXAE2LpgUoZHra?=
 =?us-ascii?Q?xqni14FB2PR9Y7zJdQQKy49CMn6LPbnheDmaq41lWMyDtSBC/WkF2E2YLaTW?=
 =?us-ascii?Q?f27VyqvfrNJglH367X0/ImkOmqt3sKo9KtZxy99OC65LEPXgMYb1Hx8e81MP?=
 =?us-ascii?Q?AJ+RUQH2Fz0ufHerhKtcWNYxNpYk5XayvAczHEn2RBDk10VywRkE7sxFOyUe?=
 =?us-ascii?Q?ybClSWRTRLhs71YM/0BIN+lox7Dw9XKdsPWnZ6E8/eHJK89KUr1o6xWTXatm?=
 =?us-ascii?Q?V6Qc3R3qb2E7ZriiQXjW0SlEe00aBBNwov9Bx+FvG8jmILFvkXbGR0jN0SNb?=
 =?us-ascii?Q?3QfVuCPiOBOkQ9WxVdslsu4Rpff2Y5TnvaCoNrBX+uDmnIcF8RWXnVzah9KS?=
 =?us-ascii?Q?oH+iJVZ0sW2KqDueKn8FiC7WiLMC209tnoXV69k+yLwO78GaBvnBmq3z5aMb?=
 =?us-ascii?Q?F8hZTU0d6WD3cFxzUKQ5pFSNJ065yJgqAXqSpx1us0omPauRBEgVl3waOmUS?=
 =?us-ascii?Q?IlEjTAfRtUiKGYzyc5X2Y/k0GgNMXllFFfbik0TEt+Tdw0uHDKR/JBmGWtsJ?=
 =?us-ascii?Q?DnHHCcI16CuC46kz/GhjN449eTL8KtrwpKwZf7m7ZvCWwzr8WTmRwyZW0Wj0?=
 =?us-ascii?Q?eljBryaV/0cu1C0oOdXgF5zsvis3MdOvsV62z0RjVhiP7J0cvjvB7QuMBLFs?=
 =?us-ascii?Q?aNxc5FF99IW38QCd7aqVnbiNnG8EhopRR40K35YhE5fUdJXoqVUbv84XC7LI?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 639b066b-fc77-4946-e5a3-08de0989540a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:36.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgCrkqqxYwRlCbM+Lo8rStX8W/vAPKr0Cz27EF4vkVs6Apj92VYyHUtIR+1C1F2eUwDRMYZYkpFIXGqdUbWhNIz8LIoNrJGIU6LaAn+Sfn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3fb76e2dd5e3..babf7b958dc3 100644
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
@@ -697,18 +701,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
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
@@ -733,11 +736,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
 
@@ -826,10 +828,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -880,18 +885,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -916,11 +920,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
2.51.0


