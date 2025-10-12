Return-Path: <linux-spi+bounces-10587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3BFBD0200
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5E35347E01
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936F627A903;
	Sun, 12 Oct 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="W22XJOn9"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023096.outbound.protection.outlook.com [52.101.72.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDC27511F;
	Sun, 12 Oct 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271467; cv=fail; b=lRDgGxnpBmtTgFhyiF7PTqoBEOOmeh5EcVjXHK+0XBv5+eB1x2e5Fb2c1I8F8FL7aGGYWdd+jr/ywtZ0oqkB2tUE2yrhRKUWLBJUDaYlmyrxt4grkPBvvFjcID6nTKx6mopwmxivXBfhLW9AtkgTxWKkg6HcoQCKq2MV+8Y2e00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271467; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTWZ6pfoJ3+nEghINXMVWKuxVyPyEeSi+8o8+Vp2JNMJxAb8ULPDuEg12kfT/4KqNB1UEHHCWc6uJG7whibRLz1bOhr0D1fjoWxlPKr+zQ2E65sbHF1uxXx0WugGCn18jBKlTfbRh6Qd4jomqKJk8+pGOED+IURECbU0yc7zQzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=W22XJOn9; arc=fail smtp.client-ip=52.101.72.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3DMCky6OAtKby9dhegOyj5BxfDu6rRXF2yr3ugqb22f2vT4ItGgdSonk8FVpPmAooRo6FJk+GO8Wfi21FHCziRzuw/mZsT1wi539sXWBvRkSG2dtK5wV6mBGV01eELJq2tGS1+MokVw7yHLNjgr0hnQ66gLX7KAqQdGCG2KK94i694WvWiw722JhDpvDq0jOSDxp/uuFdaHpMP2YF06GlTuI2sM8o0fqRuu9W+nAeSanpFu2+sH08Et4Wt++CQ4peh1oZkL0Qpyx+WXJizRkDp047hGQlgYgxgWKOl/WfO5epVAlJgg6YjmPs40mTxXlqKreyGrQ/eKLcxvYWy2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=kK7OeUr/mzsgeb3miBmOxsOP7MM+NqUaqx73a09t9HlkRi/FWWNgRFevjn8bWCo2HxfS4us7IznlykHHVL/cRfWtZXMi8drQl41fYFrxshMpAVA3Z1qCb54menIOuOmy9mMVD+pOzkotChyF6FyOBhFpRPGYgU5EBvktOV2XCiGiI3PbxxnkBUN1KOvSF2VRrhE7gYPYYBva/ty8HNr/8T5Ve/INI08WNtzdpgtW8HHlNzGkRHjBJ0EbheCN9AMpY6taB+2ene4HEoAe/unZhDfuQ6BO7eyTVkvLv1R4zNp3xzUUXT4BCDp0bzLlcouMywZ4lY9qTspZzl5GPXhPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=W22XJOn9dSs0DDvFXxzy8jjTUjPnsRcbGip9RCddn0DSV+ML+Fjfq6SZA5Rj/zOb2Natx3PhHqAffVHkt8lQ6Gd8srJouYNdIGvcd71Vf81zDbJsL0FuibHDdJuEEgDf6ejGtaevqOi/UnVk/e4NY3Um008bpJ1qlZkAkG0D/d5RB9YIz5Znfy5vSqtjO/YoBhWLdG2SSalqb9sKgMIe7CiuTNrALveJ9JnMQluJFTN19JHxp0ldW9zeMClByOqtitIA+uPejy2gEemWw4Uj4crVvV8CngWv/CuK4txZW/qZOUneEz9v85/rgga2iBZS/oKj1xvGsXtV9//5Iid/6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:37 +0000
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
Subject: [PATCH v10 12/16] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Sun, 12 Oct 2025 15:17:03 +0300
Message-ID: <20251012121707.2296160-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a246d34f-86e1-4a54-7524-08de09895506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?014tNN+f7tDSOAwaB+Bla6kUVrLF7sRdy8rCwm0PIqR0waNb7NgafENUM2UL?=
 =?us-ascii?Q?cGG8D7T9+U8ZWDOfelbqA1ZtvAnTZ6ehrg5+A934ZjUibNn0KRsGUh9WpGQh?=
 =?us-ascii?Q?weJONVP6khyVPblQgHpB2qkTifsVI7RqQwtWykCG2brDugZvVCGyc9VkeOn3?=
 =?us-ascii?Q?lx/ze++N5W5jBBeuHW16QnO3qNw9UWpTFGxE8MvudUNMgsgI/WH4NC6w9FlZ?=
 =?us-ascii?Q?Ko9ypZcIZCVXxB0FSiWXl3QT5fKrWFKJg8HcVpb4XoDdV5J0bm4NLvICi0hK?=
 =?us-ascii?Q?teXdeUaLbbZ20JcElXLiX5+hs4QYp4GWJAtMC18fAZ3zSBEnGo5cFvLPJn8J?=
 =?us-ascii?Q?TQrGtlnlaO+kHAPLro2yTx1Gnz89qbvY6lI/YooxDXevd8rlxwGteq2Vjw5n?=
 =?us-ascii?Q?9L9oUl/skD9W8lin0PdELMAGXI1lbMAOHG8XDY8hQvF+X8GgAsCw3QZ33Ilf?=
 =?us-ascii?Q?NU+DRS1rg0nOk8rSuptYsHelQ5D7HThclWTYbl3oeL0dCLvhH3GGk0YPo2Dz?=
 =?us-ascii?Q?4FzG+r//8OFYH7MD+NY2tiAx8kLYItseW7xoOFB6E5GqgltVT84wzA9axgPj?=
 =?us-ascii?Q?NtCVut1+bbBVQ34s4oqw/wKik4TgtwhHeToD9QQRYMdVt8801UbAJnZfyC6P?=
 =?us-ascii?Q?ukoFQLXEEB0DI3ZlCfGx0nIjGAFm3P0oOqHhV646Fz1QeTZiVTwUbK7m5AWy?=
 =?us-ascii?Q?K72QWmMUZ3VnQUCfIpQC4VHiIoyZ87GQ6Cfv/ELkYk7xX+EnONIV7IDuN5uC?=
 =?us-ascii?Q?ZVu4yrvYEHIW1XIACOW/ZUeHnykxxs86LETkPvMwJ7mDATVkhRDR/pI6L8xR?=
 =?us-ascii?Q?mhdBAGmTKpV1dhL/8b5g+eIyp72rOCpeqOeFyjlsWJAIjdwt4I6ZlyCqDykc?=
 =?us-ascii?Q?gq9J1bAvDBV4j2qPAmJcJ04Xq65eHGoFlKiJLFTffxsE0tYVoswWU86lfQ2a?=
 =?us-ascii?Q?mS/jX3pc5r2D0AXx6hx8JBWWm9fMrmxIlVIVnEL1YjkpFm9DZZTSrkdFrxSq?=
 =?us-ascii?Q?JyYEzCIMETspTB4v9p/LXg6vVHtJn3tW3dnFVUeoY8ZV8N4HYrpFpy6Lc+PW?=
 =?us-ascii?Q?mLVTYAkzrg9gBFq93GTtI9iru8d4LicwJZnM6T8J+x0uUYSiutyp3/pHJN3W?=
 =?us-ascii?Q?5UWwJNzMiWf9GzE6tO7GvLMPGiR5KLL+hLEn4A6XWfDnjW9ao8lrjA+iqpOU?=
 =?us-ascii?Q?xcatIGOV/PLg6AX7NrM5U4862fZgNE2IhAzfE67BTfbx7EwqjXbWtk6l2UkU?=
 =?us-ascii?Q?XlHi/yKeNY2r12WJeb0UjO2NovYjXnHUsAVPFnvBpe+nxd6uZFrJG4lhHH6X?=
 =?us-ascii?Q?GYFpqZ/8On0Sm27GVJ4pKuJ/08YAFqxDzmkXqPwdn9DvarlcOsdCnUINFPp0?=
 =?us-ascii?Q?QVNGM8CZng/mXNQek6M3m6eU6vLBQEsDDfTKNOFThpNHVwuY+iTd9vIt2fcz?=
 =?us-ascii?Q?dl6owAoAS+UzgjtMa55O5moaSlnd9tdRH0Oeb7BE0SLJAkKbNp5OVJUgUEnC?=
 =?us-ascii?Q?W70ehYBHcV5SN4oaRJ4pMUuGWsmk8W6jnayQ5KFdHoPWKDl/0/J7ikoHrA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rej0EuPph1XjVbfPwgUvpnAwAMGP3V5dCAmyU6VZSoY+nHNr20tcueiCn+2u?=
 =?us-ascii?Q?HmB7CNfz7kbAqs+mIAlLtWXqgJgKBY9j8DWsnb/h75/8buMQq9FRhGlEcuu/?=
 =?us-ascii?Q?DlRkIIxga/14RK1jDfvjnIFlzI4Tl0eYUzH5sWXEb092FaDFKoy4sWaxHpdK?=
 =?us-ascii?Q?Og3SuMgdsZ0tuLzsCDiCd+S4F8MjC0m87nPTzzTeNNf+zrP8aD8qsueC6yU4?=
 =?us-ascii?Q?bDtcyGhDQIGVHc/aAcfmCNobYS/SeFiOCbPV2JgFs4cxDNEBOozraVB1dUwR?=
 =?us-ascii?Q?HwerRJZ4DS8H9sPUx9uVVvbmzBJdrLrP+CVijLPnu/pHNe78T+whtMN/PO8r?=
 =?us-ascii?Q?72KtRVLy/ROmKNcNO2oNH+nZlRLSDw08ErfCcx7mf9m0swi5eXZk2Nasm1CP?=
 =?us-ascii?Q?cjOMJxDv4CsG7F7uWcS/fHJ+749su+kPOPbYZSgZZOzztnCgD8CydtgfoRKs?=
 =?us-ascii?Q?NJuwPZSwc5Ct5Pzj5/eUF6JeDaYjl8Mz/u2koO//9GeHFUA7Pa9UOdZueTa1?=
 =?us-ascii?Q?NC9bEhsJDSkH/xnCjC1uW5ffoouBG2p9DEC8XTbrCjClIQmq4V/msJ6N1miM?=
 =?us-ascii?Q?Iz9nPyHRuClcX6hRr3inf5wJjTL2D2rCm9V3Ods/Qxkb0NB1Wi+Gh7T1ImbO?=
 =?us-ascii?Q?iMUBfEgo26hJGjF9YQXR0gt1dofA51wtpcQ6lJcCBjIoPP0uVd5mc8WfXEKF?=
 =?us-ascii?Q?cNx7NuMqcOSKPH1td0tGp++yGHbfIA6W6zw0e7Diqwzf7oQtSthydnZd0vDQ?=
 =?us-ascii?Q?xDd8zM3lZTtObFFLtHMmO4OC0aM6rCM+n1X05WLp5Bp3mw3gAxSHCRxsfQWD?=
 =?us-ascii?Q?PqhAbMl9l/SEhSyE8PW3AQ8qF6K1pFHod0Mb4Jlw+wWjDbceXDjEL0dx+ued?=
 =?us-ascii?Q?sn9wbNoV1HBnjhNZ1n2QOBMnOIjjqxO0lnHAoKlN6OqgI0Ey0nloYRVkxNvG?=
 =?us-ascii?Q?isqESc3Nb20R3G7C9tHBTjCULH/Txy8j5ARAFSCDgQI/UYotgWGE27czE+Q/?=
 =?us-ascii?Q?JHGa1ra5A9qP2EnVOT6NYCxPasISyYfXMSrUsaJ8o8UQ50IRzdaMd7jkfj7A?=
 =?us-ascii?Q?CsJqv/8JJJTaJD3pCsZVDiDUqPHFU6Vnf1wDbaF28S8Vpk2ILjM67yRSnsDc?=
 =?us-ascii?Q?2+3BPCi81R028AqD8CA+tfgqr+GR15q1gGoJKbJctAtEUgCdElTpuVdxwMLj?=
 =?us-ascii?Q?hcE8+jsFpgJ5OZmsMW3oDi4nZKAngujWFaCpQbHcj9WunejhIlZFDgyrc8Mw?=
 =?us-ascii?Q?Qv4rEX6vmMLj129JQrrJrXEL0kTh0T7qgrgaD2BwrT9v8sCYw9tt+4Uu62Zv?=
 =?us-ascii?Q?pAs5jjc6YFCF8b5ML9+HS5ar2YQWTEz+opM1KrK3adzAHJiYtNk3BlimMUAb?=
 =?us-ascii?Q?FeXn7y+k5lmVxTrtU3NIN6B4Ejkr9KuAx5RAiVO8squicOOmKKYxhjM2x7W1?=
 =?us-ascii?Q?VwPtDE6rdLxnZU9X38vsbZTviAsDdtqaGnuALcJL9wOF7glm1GDhPXluehyK?=
 =?us-ascii?Q?ocBvTQfUyO1Q4+eNViL3pxCUlzTovH/0fnkbbK9nRLxJQmV6zbEbSIoU+C+v?=
 =?us-ascii?Q?fIgx9hZWzECeyKFeXWxsARV5wPog/IDO3aNvnGJWFUNr3VSzvSYfJ5N2tI0E?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a246d34f-86e1-4a54-7524-08de09895506
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:37.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeQHpJ564oUK0A06MqoNeIwENySLmr0h9ap2YY55tu7H3U0YHsujEMWzLhfmYW3KeQK1419xwMvm6A3GecgNKCFAV5vMnDSb54SnUUiA3yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   rounded up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can remove a dirty hack that reads flash page settings from
SNFI registers during driver startup. Also airoha_snand_adjust_op_size()
function becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 115 ++--------------------------------
 1 file changed, 5 insertions(+), 110 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index babf7b958dc3..437ab6745b1a 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -223,13 +223,6 @@ struct airoha_snand_ctrl {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
-
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_ctrl *as_ctrl,
@@ -490,55 +483,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_ctrl *as_ctrl)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
-	return regmap_update_bits(as_ctrl->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -571,26 +515,6 @@ static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 	}
 }
 
-static int airoha_snand_adjust_op_size(struct spi_mem *mem,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	if (airoha_snand_is_page_ops(op)) {
-		struct airoha_snand_ctrl *as_ctrl;
-
-		as_ctrl = spi_controller_get_devdata(mem->spi->controller);
-		max_len = as_ctrl->nfi_cfg.sec_size;
-		max_len += as_ctrl->nfi_cfg.spare_size;
-		max_len *= as_ctrl->nfi_cfg.sec_num;
-
-		if (op->data.nbytes > max_len)
-			op->data.nbytes = max_len;
-	}
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
@@ -641,7 +565,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -833,7 +758,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1076,7 +1002,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1101,36 +1026,6 @@ static int airoha_snand_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
-{
-	u32 val, sec_size, sec_num;
-	int err;
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_CON, &val);
-	if (err)
-		return err;
-
-	sec_num = FIELD_GET(SPI_NFI_SEC_NUM, val);
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE, &val);
-	if (err)
-		return err;
-
-	sec_size = FIELD_GET(SPI_NFI_CUS_SEC_SIZE, val);
-
-	/* init default value */
-	as_ctrl->nfi_cfg.sec_size = sec_size;
-	as_ctrl->nfi_cfg.sec_num = sec_num;
-	as_ctrl->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	as_ctrl->nfi_cfg.spare_size = 16;
-
-	err = airoha_snand_nfi_init(as_ctrl);
-	if (err)
-		return err;
-
-	return airoha_snand_nfi_config(as_ctrl);
-}
-
 static const struct regmap_config spi_ctrl_regmap_config = {
 	.name		= "ctrl",
 	.reg_bits	= 32,
@@ -1204,7 +1099,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.51.0


