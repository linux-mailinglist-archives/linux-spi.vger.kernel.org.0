Return-Path: <linux-spi+bounces-10370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75EBAB027
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8F8192433A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E902580E4;
	Tue, 30 Sep 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="lZt0aAuy"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19A21C9E5;
	Tue, 30 Sep 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199251; cv=fail; b=Scz5PInGcPxAQTukVt49nBxRw21LmYIM24Vbk3pfAlkRwx0qM1tJUrSgb4H+7Li+j6f07iycjU6O6ow+BWGMWLrzaR1NQM3qwTxhfqA/qYnur8pv2z4RDVMH8RuNrlBR/loE8Xwl2AUDlAo1ydhRR9zG3M/2ZZkpywbd8MOj4zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199251; c=relaxed/simple;
	bh=cJOgojh/RncezIE/1naFdIHp6cwHxDMrvkkEdCOwuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBEuJhO/pOnClJEI02qgxqOTpw4Hrn+5d7dTY4vH+4A7VlTFKSoAXfdcjMr/B6+63Iplx03zXi2KwJ/RhlrpQkXgiQWb5K6A0Xr6avHFpELy6ap206FRWhF/4Ia5c8omvB7ccvxdk4PhIroQGr8l7IWH5nzOkFp2TkaX3+8G7uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=lZt0aAuy; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2A8mtvyfmtewZ+RsUij141vnsKKhESVr1XmA4AHA6+vJ6uyRXptzgsmueBowFP7HDivOB/sXAzrROYBXxahJiHvCDbl8XqDapy0VmnY29V4bcsao0bA38QNmzo72gzr0SoDyQTL9loXART9rbdj5mDtMvX7ZfmDWDarlX8FCx7U0/aGJobi3w2GXpFhskSiF2E56jjp/tptw0EQjWr4b3LDT7OT17Vh/kRvXEQaJkFbfbmqv78A7T5AqL1AyLvQxPNA91dmLclujUKlkf4/16M6ZCnj2TIN+Dt/f8jJIYvs2SyvFyrdvAuoSSp2E5Jcy7M7MET/ZESnEmehvpLlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfgrS+X26NFk1wZ2huO34BoCZf8y+Al5DMv9+1OL9oc=;
 b=dL1z0Qhz1TKNZse4MqgNKis2WZnnb/2K2P+PT42cEmWSmMvp5C/HjkOoo1WTI3kzQnjLLmEqEz2RulUyvlVNF4b5G7IuBW9X+O7KhD1Gijjh/X7js/BjBIZld2Ux8rt/OYfqOVjGthMvK63TPm5NbJoBLcX/Q5FulwzdEC8W2q36ObTgvhGw8SdMGH/e0RL/PDuvrMr7HFJAqq3aWN27OfnCqoUv6RXw8WEClq+4xX2DcYmCEucC6o7G3Vl55ya4xeSz9XqBK0XF0ZgF7AYTrG9wqy6OgEOh52B0MgHWLrTRk79SWHqyso1uuwcgZgfcBbKM3n0JPS37ZVD14tl8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfgrS+X26NFk1wZ2huO34BoCZf8y+Al5DMv9+1OL9oc=;
 b=lZt0aAuyC1lruFApkCr+IjUAw3r/ASprJP4oLlz/5xgzq2gH21IiGpTuTmzpMXuuhosQ77utQtgtIleYpcG1kvccIF8xipjszckKnL1bn/1v4pUdeZetnzluFwL/GxTVYFmq+hPWWwOY/86GPhxA85BehqT3z8wkX4vd0S0JbT5YF3hmB6TcpXw7t4pQiR3ZpQYrtQq0jrMgTvGkqPDKdH+QhcpVR379ELkAhKn4wx7MAaBUayCcd9kxBbuHDmVyabqHHaK892NuG+28TOLYmZtIJYcMwWUMWkEgANvn9D+qzbuOc5M1HOjdGcU50zfNDqNqJ4AsNZA00YdUHJMxrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 13/13] spi: airoha: buffer must be 0xff-ed before writing
Date: Tue, 30 Sep 2025 05:26:58 +0300
Message-ID: <20250930022658.1485767-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: c1af83af-9c70-461b-2750-08ddffc8e136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xfKYUDO/GHEehrUNZKTaCt3jpHrCVqqenSWVL384VvjrE+UB9Q7ycAOh0FZY?=
 =?us-ascii?Q?yPKXsZywXbHGq7f8MkFqo3vrwRDrZGAluC2S8ywMZDL5cdGKYHMkdSLXbWKF?=
 =?us-ascii?Q?k03ZW/UbPiJgpPeLTmwAUph1lTcgMOhL5GKPfEt8vddhYuBO5qOp/3qAsktE?=
 =?us-ascii?Q?mdFZ/dA48wQrY+SVXcp7iCOv1EfbYKyJAlPlSG3P0C9411OcmHV4TImVuamk?=
 =?us-ascii?Q?lDjz2vR9E5jeKLLU5y6IlWjQG6rIOCvsgwFIOY2411ME8W9uxOvVtROgdSzE?=
 =?us-ascii?Q?xdY1TirNDMcCWSoZ3rlP9TqUPE0CJheFakdSwceXox02dAqsGeZu5LotM+l2?=
 =?us-ascii?Q?k0mqca6KtsIb5Y2OaTp8pcQ5QEFwJuF7ATYhyYt9zA+25b1bO2VjkJPKjkbf?=
 =?us-ascii?Q?RXssGm2YxQMWLu9txpI7oPkYcHJmR3yf9T1YNMRp0TBjnYJ6MmeyVuoVZ5UR?=
 =?us-ascii?Q?+oMoBvsv/antZeWnD4GUsm8hzYgWt29YVsSJK/5fObOoMrngvuFbkeC5H7ZZ?=
 =?us-ascii?Q?DlHrBHNuiansKl/9yn1D7qche0ps7aGzdFc2GZcFHAPtKWo0pHWQ8px19V4q?=
 =?us-ascii?Q?MqhwBmAI7plxhCFHXpIB9ONTpoczM5cvWkR/KIfPMsp3wULxXsdYLZsX3BzP?=
 =?us-ascii?Q?vEMpcsn2+FEDjKaD4bS6aWbYfI7cn5bUl9orBkBRC8PrnGgr0E8tBDrbP88A?=
 =?us-ascii?Q?Sd3VaUUVBqRY89xKTHlHckorWuEIn6KaapTEc3o8T60VRD5ryAHyLmnZ4YRf?=
 =?us-ascii?Q?8eZ0+UPK1JW3JMOWxylCerOpOWdTNsYxjX04fICZ4zwmlrSPw+/sE8vOwfFl?=
 =?us-ascii?Q?NQb5FtZrfNrmBA3gQJgVuR1EQE8/4mLNOG/iUIBBsjN5MemDRrgad74Rqlzr?=
 =?us-ascii?Q?b48gr8Xe2qeXfGgefy8XN7rAbkLLaleTcEO4iNMdzUJqudZCSYFTuSTS8Jas?=
 =?us-ascii?Q?8T8XA41Z+v7ihCHwnmsKwI8YRqiPNJWl7QdB4hkFEYmm20elTdFb9aLXmtLQ?=
 =?us-ascii?Q?c+trVvm3uLAFpmlU/C/t7JT5eVSw4sbDy/41jH6tLZATFRwkJxauP/W6ylN0?=
 =?us-ascii?Q?urU692v2Qu3iK1Jf1XJblzR7tZ26iZlEubgo0TSBV2tbx2768y92W9csUVvm?=
 =?us-ascii?Q?GBFh5cW1xFc0oz9gV5eQpvzX1Ri+mjYaRneQazBzc8gDU8XIfAe7UQQWRwio?=
 =?us-ascii?Q?oEpc1xb46u4RP9TANuwFueUDx/GbFOrdes/CiYmvNFH2VzNUjUvT/SOp7GJi?=
 =?us-ascii?Q?0Z9rnr01ithVIp8/iTj9tSktAi8NRls5CEWGRCnro937BNZ4fhHXY8ublPS4?=
 =?us-ascii?Q?JPtjR2uJ+4Huge5OSIVQumurodWfeknBZGFqNE+FJXR5ZDmu5aMD20FhdAf/?=
 =?us-ascii?Q?8rteRWAqLKovSJ6OighEMpfsauthUbsMxG7FRAA7tPVp8ghrSxJl5x7KOkTB?=
 =?us-ascii?Q?Bp0RUcf5Wgs7/gzDPcEkt8pbT1KEJ8u2/XaCTkG/Q5NaNVenv0VQVu0G99k9?=
 =?us-ascii?Q?J9iBOumtURNEIGo5erjnbeVwUKpBS4DRIBJt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TGgMW2iCX3IM16WXNoBHq0mpDb9SENJ+8agushq2opnJ/4Qu9UTyIaRaRmJ?=
 =?us-ascii?Q?SWlgv1BSozd/7W3Ds71azp4R1QSFETIupXgs5CKWnUtH5ZCjsE0rKaUc23a9?=
 =?us-ascii?Q?iCx2Ay4JHRqIUN5tg3+/9C0i1l3dMIgYYIMXkaTC26MRhbQg62UCo/C8UEgi?=
 =?us-ascii?Q?utLdoQKEVr9k0fbNHKnABoEy6Os1NBXOOSw9RJfIKYKwegXPCBlcBK98Z0xP?=
 =?us-ascii?Q?1URXf6SmecnQH+/HyzcFsc5Cs5RMRwSunypf+pKxLcPgmGEvF3zJHY+QM/Ho?=
 =?us-ascii?Q?8+7pxUT6/pH1CYIB2MYjIeDUoKcMHMLasYfRa0hm6quSS6lyHdQpTzeIKQd6?=
 =?us-ascii?Q?CE7sFRaKaPfdDCrVvrpF4urHTJMiEvQqcXG0jqc9VE5FjGOJpEAJqobfLeZp?=
 =?us-ascii?Q?tekQienFyVNwSdyoT0qv04rk8WhsvLDrhK3ZC0+cP6CT5k/9jyMhbPZwsMC1?=
 =?us-ascii?Q?UDF6qaxNkpH5cESfMZmiEU7CI4K/1QnKchcwXwJmRFalzLQX9fkzZkkzeQE2?=
 =?us-ascii?Q?hfwm5tpOe2PWjPFz4X1VCESyqOdgpWplpWfYfcERitv1lEsfHs5VBQjtHGql?=
 =?us-ascii?Q?WQv7s0Pg83qC3ECCxpcfqDUQzXAJ6byuCXhKA5KIg6tUHkjBmRuQuQJUpWSK?=
 =?us-ascii?Q?ladZBaKilCG6cTEc92L52mH08l+WOu4fQ57lP3evM6c9K3Ceq6EhnZQz+4vM?=
 =?us-ascii?Q?9t/vRYVs4Do77PChkU1SRaSPq8ocd8ev1UbwzVdE6xZm4//abWMCLcIpwAeQ?=
 =?us-ascii?Q?xZophaE5ulTFnr7T6cGTyfJraZcMeMm84qoqZ/GGnusxW/ii10fU/53geuvF?=
 =?us-ascii?Q?1DnZK1s2SzkQXPdqPrYBjlfJiTXnvDtxKsG0oA4455Hf7eVBEA57LtvMHP7u?=
 =?us-ascii?Q?rQaHeObOp0Z4ypNjK3uNsZ8N2xbPcpF8oy8aqOAm8PNBoSGPRYTw/Kfi5j9s?=
 =?us-ascii?Q?4Ms5QjEV+QVk+/PBuuRHCnLhagIxMgIUtn36XeEF2WAx5KWHfFacM+pa/jcR?=
 =?us-ascii?Q?GnqV5UX/BHlvW6NCiDWJW4RlUKQgPA0dx/s1Ay2CNqSAfI6hcn7i7hR1m4Sv?=
 =?us-ascii?Q?4mRVedr1yhYfOk7BW7GZx1F0PMiJo/AEBVxHsHKMHWNazvGI7yunZGppuxaP?=
 =?us-ascii?Q?cdoU91XbWf3pkOXsyUDKZicH48w+UQSYTk67K9nwfLgw5+5kV5ZutzOCTfw7?=
 =?us-ascii?Q?zJ9iUhjoX1wfbjvd53p6aALXFwvSKmWD7XWSxfmHvlb9Ar8gqcr1g/WNZsaQ?=
 =?us-ascii?Q?QX0ajpcxhPJ0snxjg+g+4uN64bFc41FKowROA/d22opKa1iFHE0l41X3zGwE?=
 =?us-ascii?Q?pYvQLmP3tbBHwyKTbViIZ9auwFg+z2s70IFINnC9V0OGSGp1LcSxt3Q0vFsl?=
 =?us-ascii?Q?GzRu83Hhhwm0GaWKrmd8YQWxC7C7is9kEX4LtYj2gqwastPzVXGk+l1exyAo?=
 =?us-ascii?Q?jJAad4DFLqJzfbg3Ou6nxESd6lXN5f/Y8qE+TLXTFX644HvL8iaxsXMQSRb1?=
 =?us-ascii?Q?Q5WuG7izCEE4c99bT68vqOOpGyrbCmgRjoGnPpSSe+tjdB+xE+yTmg9t+TG+?=
 =?us-ascii?Q?K+FlJTja3D7SDt2VaFjf/zxC6LF2yloO7XROazBpS5IwtEO0BjX8bFJOzTXy?=
 =?us-ascii?Q?VbCf35A9/yKuef6Yo/Jt4FE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c1af83af-9c70-461b-2750-08ddffc8e136
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:19.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LZo8fBAZ5Zw12Ux7FZ3JrGu5utgAX8+eATv9ZhD6Jqhe9+ABk3T6yGTWt/UdIbzKXZGo4Q03aCGvWDY92C3iqxqoVO/C/Gwngol6RHUz0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 437ab6745b1a..57b1950e853f 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -776,6 +776,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	memset(txrx_buf, 0xff, bytes);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
-- 
2.51.0


