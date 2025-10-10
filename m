Return-Path: <linux-spi+bounces-10542-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE3BCE5D2
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2E3A4FDEF0
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7453016E8;
	Fri, 10 Oct 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="VR7tUMWB"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE9302176;
	Fri, 10 Oct 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124068; cv=fail; b=a+yEET2+KD1ZWaX4o2Ql34JHTD76kuP6sn7IFUG6lUibUMVYIV+8Q6A78I0doemIybFv4QOoh4xeZ0CaFp1XScxKIbSxKfDbdQGSHytj8RvC4Frmr+iL6QiToVQRbwS31YLuKAsW4N7C7My5LwO/Np3OjnuhOuLbgy6f6I1LM7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124068; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bEHHjmqyaWdHVThhBCWauSJfsI1F4wUX7dxtBDl5r57QeRO4ik6iMDdITafVIPeRmYz+M2LiJB2e3tZst8cW4QSuULY7i5O5XvaflaP/xzHlGFP8NIQAql5Zfp/uZnm71qGYEn/7jcELzx1O2z9kGQauWsjIzi069PbA08xv2GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=VR7tUMWB; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+azKnXdRV3HARDUSbxtPPH4xnRbsJbHo8AUTPMQs1+XpSFumoMFs0f9B4MC2Jql8nS2xGiSrfuZzHZbn/e+pCo6VNT89NlK9g04LLPkSYSTKnK/V0G+q2i81j5c4ezmrKmY1pKkGl8l3yiTCJC3jeHu9S8JTGuvZYFHvp+1uwG+QNv21D6yHwIH5O2hrXb8ukuULAj/AEOeo8Zs2RsIMafe4uzVyUQGINazL1ocHSlmbEl+R2bKvjB1fNoN7nEMwHSbKHHMnH7A/tHeFgWQNzX5kkxOJuHRbLzWH9sqLPypg798l+Qm+qoVbBVLiflUmGFJ8TQjsYxmoGNJcR+DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=kYar/D0x04HrjaUFiBnZZ8AuQhgLRLeyKkbR9qxrpgQG4GIlVjJL31gG1e2R5TQ0xmgLhx3k/CctOp1pSB79CBz9u2/FMvCJ/Qo1DLxzlHISHXoeYE5WXNkwTU8Gr7arO/y4zASKPbT4mo0Rrt31Y9q2S/Dp2nXwIocdFP+2UM7kTxDVTOa88hMg8TCsBgqNeNSj15BsOMCW1zm+NAD+ucfwG0GKyMKa0O6ZFe1TcLpTwGQSnRxpV/HUsoy2w0w1K6vmCWBvdLbEEEjJE39XAzgdqFKsBVHk2zmSQOSkBzuSzYlrmSwtSXL371dlse6jspxpB3Tg8D1kZxvRM19f2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=VR7tUMWBomnRWa1T9WtJJ6j5mrtIn1wdv3sxv3mjfP8zMvLzwKBf2q0+XzqOR+apHFg6TbJ7Z3rqqpOnBpgqjv9jS3zBG0bpT+4Q6HPI00Lgh05mBKVJxnpMUxLlOomcd4IqiSy9D2exWLaV8ZAefEJKU2CWzMinIgdzc78OFLotvXs/7y12/qFIRQE2FKMmrLROHXXWjLE5bawyL9tUspJ3Q4bOiGwnDGUlnlHxUiBbz5PuGm01E+zLEjDh2mzWLb6dYU/cQtbIOIqFipY4JIkjAAUCUNFtdi4xc1pWPTkR0XeI9Vxix1UhxY4gTSC1N2sl+jbcEHCRAMGG4DOeAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:59 +0000
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
Subject: [PATCH v8 09/15] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Fri, 10 Oct 2025 22:20:32 +0300
Message-ID: <20251010192038.1592889-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f02455c-2496-4dde-95a9-08de083224c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4DmzG+hIVd49PxzJH4y9HmY+vEXUk4Ic/JxwzKhgTi/VtGjbeYGYJeIPaO2l?=
 =?us-ascii?Q?vXB0K/BvjP16OGZzN3znhkAa/cmCogPwYZhZ1zn3bYMK6h8hbQc7raLKZ0qn?=
 =?us-ascii?Q?vNDWOxJ1xr7CukVHDOUEKjgDaZqEyqYF2Q0NrnOHmpVDShTY7jKG5nr2MblO?=
 =?us-ascii?Q?9eRNZ8xbKRXQTpstjvFzIN4wN4OblFIa0KpnQIwzd2oGnms8YmFQlWNmkNxQ?=
 =?us-ascii?Q?vKmf14ZWE+5nNCh/CJu2E5+gzJLmvPcDqPN913AphN1JKTyQQRpmP2D6OOwj?=
 =?us-ascii?Q?tNYg4l9XrZqk9DjBz64nkIU6r8bNKS1XWEKfJivmJOx5+5HzpIeY3XkvqZR4?=
 =?us-ascii?Q?Gkjjxn7Hvqy+0CDfNw0uplywtqTJkCgO8SYg9XMH+l4FSvKZU8f/t2+SSDdZ?=
 =?us-ascii?Q?imDqQapa8S9nIdpC+uIGWi1c9C9kpncQusXn889D15Oqa2ajPNlPuKwNKHW5?=
 =?us-ascii?Q?np9qHuYf89gDuFNT2AwAKY5OfTOryki1A/60fx9dIlv38suSfjEziY+eBtQS?=
 =?us-ascii?Q?GSkDdzxWTMb5wFHF8Kcw0ypxdiS3c8xgaGqeR3LNrR2x8IDRyQHUo3qw/dZg?=
 =?us-ascii?Q?dWH7fVKpsYL4iE5diTPS0TahdD2xQ/GNuSgrEgYKdCIQ8p5vDWB6QOlq0IzM?=
 =?us-ascii?Q?Z+tvZxtDXNvsS1Ejis0xor3qkWb+tSa7MvizkOrqYU6hWWdAJfRW85RvuzHF?=
 =?us-ascii?Q?dzFAfUjRqsgRI+b1gqzyu/VlNkputdxz4658n7tP6bdcdyrTf8lb3dvGndFb?=
 =?us-ascii?Q?I/Yq2wGfxNhS64vH6ljHJU81n3wNxMPq7XRh0UoO5S4GOmef5cLeEcd/OOMn?=
 =?us-ascii?Q?u6v68jviBvBVx6e7rWO9toEjCUkqK5UxUrD8bqQJ/t2GPOxauFeWDPuTJ1Vv?=
 =?us-ascii?Q?qI8+mNWvswdkE40qITiQA08/gS184PgIYX7cA38uk0qZoQLoRk6V3oE2+kgS?=
 =?us-ascii?Q?S/eOix6uocu6uyCVnqGkl66rzWHePUq8oIAB3ly74j/iEJ9rY1P479MPzt/5?=
 =?us-ascii?Q?W0vqBf3xFhZm0cmknNgcwvWoMo9K+9pHWPhHJVGxXeiCUDn7zZYelkckYJz5?=
 =?us-ascii?Q?x9okI4DLiZgfcETutiX4TNudy6fm8B/PkgRusDecJzf9RNCcxxydPvWvZlQG?=
 =?us-ascii?Q?LHNkmiunzoHnmZvQC1JEmNmnmU8EAy+XpY09+RNUWSlzgLKe/OvCdgsBJ5ti?=
 =?us-ascii?Q?4TwF209F7q+FfEOoERMzYwMXXM3PtR9jME1ug/ZQxWVRy81BCZxyT3SqdbQe?=
 =?us-ascii?Q?NQQHCDDM4vowlinHeTn3uJdMn23/sfqZlORhKI0jc1WVmx9HT/jsAR0TE772?=
 =?us-ascii?Q?Io++CYs7RHkYkAQvwAZtSBMXF8sVvQXV02ZblKYcUgVw8q999MSyn6+46HRn?=
 =?us-ascii?Q?aNaiY0Qpd1JsRiyAoVkLfIeigYGAiK1EuNIRx9j5riwUaq3VON8lL7OYlShD?=
 =?us-ascii?Q?gEFajbKF7x0cxq/F9ckXnPh11idA+mDDmE5dBrVGdMN8wGIH5kICECCdjH/K?=
 =?us-ascii?Q?PRHxcXwaWsA6cDcPb857cW2qodUsRuEI2KFQO7dT94EPx8q41onIPlXiMg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?raxmN9h5vkiRgBGyDMx+s4lOs/o39d8yAoV53WDhrYXKkXrEnarQbJPLW5CK?=
 =?us-ascii?Q?FpjTaaOs/IEUdrnWzfjReKjITLjIgF66K6q6sNiyb7wL9+J9b8eCOyLp2HAE?=
 =?us-ascii?Q?JOCEWo8U4oBaofZrOA7SvjwXOAQuesYa8wt9wfQ70Qd8iiS5nqg2X6pQf3FL?=
 =?us-ascii?Q?3pm6ZDxSmRzknuxHnzfwZO5suV0kOPttTNP5CcsWwDhXRVpdNHVPEUGX9zQP?=
 =?us-ascii?Q?eCPj8lNZvgL5JpJWLKP6VwJht4kaYhkP1+SS2BOTVBY2E5ZOawmLpoxZha+d?=
 =?us-ascii?Q?uzeG5DZuOSDUiwtUk8DtAPVGvxRtmLs6MwlPJSeqUnKlFABNxhRWRxIWt0yH?=
 =?us-ascii?Q?1Kdmn8flyAoNmQOOMwIjhx4klAeupmxtOnlsV7xZ83TU+324uQEwRi9IjJhk?=
 =?us-ascii?Q?+fXpSA9pVxPQ+81TtPhmB1/LcxlMaxCYYdTyMQO3+Iiy0DHfmtQoyvHbNhoW?=
 =?us-ascii?Q?X/X100nTWzplLmkK/JQ1yYMAgeY/bNeBIA9J52w2BJF+zZ0nVQ1osLJyAhDa?=
 =?us-ascii?Q?bkuDxr4bln7W/l1HXHvdBIw7jnyDpQxtpiktlDg0JyPGJi7S2J34uVuGVXYR?=
 =?us-ascii?Q?lNn3skAuE0nKv9ccya6x5pQYonyP3y/AvVSfHOzrMxm2xBt+r54K/0XMeRvR?=
 =?us-ascii?Q?ZXjuiG65m2dxeUAzBXAWQjddWv9KVjrVdQ1YIkcqA8C7HANOISZWJiWVCQJo?=
 =?us-ascii?Q?0pES75agTRbsj3s7sJ4mj1gl8rZ+eiDZOmC9DUWD9D5MgHRl+78OkkFLUa4P?=
 =?us-ascii?Q?CmSRplnzRpkdQrhDC4dj/ogedpxE4KouxHVq9YX5LSyu4YnY2usTcDxvlojn?=
 =?us-ascii?Q?yJfeAmiaCIqzcav5RrantHbY7uwe6kJofZovjz4NnALvpbgZPmgC4Q7pYLPe?=
 =?us-ascii?Q?T4IeUX+TUx7zyYMeDtitBroLK50TO0FJYcthsB8RzHXfp28Rf67uLpKqsiZr?=
 =?us-ascii?Q?s2kMvcC/v9NCOg3LbRRGeE6BPVuQIvOP0AY053EJF84ItPdy78oA0NC+uO1F?=
 =?us-ascii?Q?02LoNhZuNNuZsPcRtxRCJUx2PT4kXDTqk0JKL16AlYjBFabPdWbZTZEP/uid?=
 =?us-ascii?Q?zNhHufNQ8bwfNiYHlHhVEOmKXMjD3V2+XoWS+8vlzduGZuJtqAVwXO4NVCQw?=
 =?us-ascii?Q?qwhx2GLL1ifsAx32irsFwaAFEd5ntWa1WEudoybcWVjbEbxg5UexQWUy75Il?=
 =?us-ascii?Q?zTDJa+KjmLGd0I3KD7ceg/NwvAwtMZzegmikqayGL8xMeXo7sd4KWTgqqjDq?=
 =?us-ascii?Q?jl79RCuZLpok3DGY+zDlP4AkWSj92V4mKt9WGIJaCG1t5rtQlHf2/bPSXUP+?=
 =?us-ascii?Q?PigMfeDnLyIKNjsfqXagpAQaBJPYi1Ivird/PjB5WlSpRmbnQSuKHRo0Vp7w?=
 =?us-ascii?Q?6iQJnbi5UIpDVWVat2qK3CsyQDjw5VK4WIcBdPcVYlEhxBHl3zGqLklYj/XA?=
 =?us-ascii?Q?YiSByKR1rfYGkCFNbSnfTaCQKUgYY+UW3hWyGEsuu9XkwkTRq+Ar37lj1SZ3?=
 =?us-ascii?Q?c6fX7h8IER5Er5/NQgrTBgp14Fclj25ShOgNzUEquQNCd2qMeV673d040+m2?=
 =?us-ascii?Q?nWvwylMyM42m9d7WOdEfGh1aifRmrmSfuJS74zxrVwYK0YuO2YNjXjNt8W00?=
 =?us-ascii?Q?pwwnG+m1ZmwD9++hCz+FkZs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f02455c-2496-4dde-95a9-08de083224c2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:59.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiquHsDeA/BBziEKRYoRngCqj1nfj6uOl4M9Y9tiGvBQ7hWtehqSAUkFKFvpDkreaf9+GcJSqatfSBXPGBwCVRJVX3ywn7mnFPO2IkaxWas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

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


