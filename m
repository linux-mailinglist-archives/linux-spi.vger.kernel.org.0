Return-Path: <linux-spi+bounces-10564-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A84BCE898
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98BDF345CD1
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F2304BA4;
	Fri, 10 Oct 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="zc+lYUs4"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020089.outbound.protection.outlook.com [52.101.84.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED83043CF;
	Fri, 10 Oct 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129138; cv=fail; b=TnVY1yhue7V5GCY2nm94ESdIsIZ08XS8EJMojdN489/8Ik5Ags8ypSmdfak9RHIckqKYuIi2CSlFu0y9A5V00cmztXfT61YkcwW7P3Utfzsx5wDYGA/JWFsNHIdE2rDd7UqkLbfs/Y9dqquGxZw7C/kN3wS1asOC4MYYBXZveQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129138; c=relaxed/simple;
	bh=zXs1zjwe73k8NBFsZyuBC+GPa3XlTDJdYKLifu+UCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4tuYoCPjOjXK7g06a7imkJnZbTMwptQvzHcnv1WlFBYCIgLzrANIqPGiEb1j73A08RNBTn8sRZmFD1TqZ0VFiFJ3l4288J0hU+FP6w+LQppj9CfHm2ZqPgDj3ZT9lUp7TGRyp8pW4kZgJ7oc7ZBZ9fK27+y7ETteeTwYQjNF0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=zc+lYUs4; arc=fail smtp.client-ip=52.101.84.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSl8ol2eRys2RRY4jHn2lr3ZXQzwKJJ9Od7RKQpu4XLYBx/eAojcp5MekO+dovhfmNTyne85QwfTP7IQlKviS+mHAwRzN+VYdaJz/mP2uEeVTZoi3/Hz4JmU9zvUNdh8Y8i02f27jNEuJ3RW4rK6WLQRcA9wy9C85ZAM3ExwamnUzJHvVJnFZJh4tDGBGre8N8H04/4uMEjom1ZKsiHHlLeXg2+aO3w2nW00Rid5uuMuyRdLz3mO+lsZw4xagnMzcSRRhiTF8BZVqTH3OCC/4jsYbuAYcWAg05ZZrJgcILNgLV2ocnGZCyLwDq1mPKaPEf715b2SYRMOjRu4x0HpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=H6WEh+CSLJaaWBNkhfHEgYdCL4hTmXye1p155/B7etKNwkfcDxB4jpTa4HlJIjSXlf3kMSlO7vdLsNhgEhyeAj6xYZD/SkR1fmMBHqUuUKa09WR08y/VOr5/UmBZbgUHTGxNrNoQ/LyP2mXQoV+ePXNnRTK/hMeBGzzMPgiNz2nkk5Y+5/wK95HQjKtnzfnDXMK340gjWi0T/kh3H/pcQ+48YzfrHFQWx77EUqW2iAhI5GRM+fTwdw85g+izyqpo6u2Y3XuSSe5VnZGg/uJDO826WncvvxaGAdcM6Tg6OFr8BnkebyT/53jKQKlKbnBr4DJ/4NeERP+mzSRSsHrCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=zc+lYUs4fYSzhMeAfYDi0T32TSojyExFAEOPA7Hd1yPzyi7U7V2XQVJKOHw91Kgn4CIFwfegibxLY4BosDWDRy+vI+n8rqZkhqvWewtBsgs8dQqpGDxgp1Z7ciFMrlaJES2JMpjehBxtsL8eCvPjm5+koXPtt6adh9EFu7MaeDwN59A8bUJo9U+x/3QVGv6UkzhQufX9EVQanBtfB9EEGK/MchpHNIOrYZJ34wQajSX1m23aO/F4pXdM4WG+IdL/fg809VfXSDTPeKvjekWqt7DUSC1heuUWfWEmhm8NH9NyQ4cGQ/QK434uNvIVe8+XJJQ3GcfFe++1HdUWNp1d/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8619.eurprd08.prod.outlook.com (2603:10a6:150:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:28 +0000
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
Subject: [PATCH v9 13/15] spi: airoha: buffer must be 0xff-ed before writing
Date: Fri, 10 Oct 2025 23:44:58 +0300
Message-ID: <20251010204500.1625215-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7c6f41be-b005-47c6-c438-08de083df21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/p7Puxx6NT+pB/94k7E4/XbflSn/6j6t8uTT8mmgx4H2iv1ijQDzXzJ19r/s?=
 =?us-ascii?Q?Qadk5niGr+BgshoGH2HiQSqWMZUAVaUHQMudrNA/TT09r51PK1BVOHz5vjoG?=
 =?us-ascii?Q?BBw/9NItBNMfSjNlCmF/VdVcVsOCiXy5SCFP9oOVmIEmhW3WWXMe7fVlu/lV?=
 =?us-ascii?Q?jgepVExoOARcfAJAw+g8EoGn8DpozLefnA/ieg7aWy8KJmcFVsOYkos7rNdg?=
 =?us-ascii?Q?iY+/CozY6mXVI+bzhtKa7sju+L/78J3UsMkxRbawjDbs/dhvOdF2+aPXYs3e?=
 =?us-ascii?Q?uPH73wyuZrw5v2tUY0tHlVHEkgsvifDHRD09Rxs25gOtfTVfmAlnpT5rRP7p?=
 =?us-ascii?Q?RFBws/3wnvBMj9y6ky8WZEjUG/dTYjYrHkpYY/5SA2DKq716lz+KNyqVANwq?=
 =?us-ascii?Q?Pa/IsMij9j4JbD9N5BENnS6b2X/E0ItQah03VbsBVcR4JKaCSsYKcm6hOvC/?=
 =?us-ascii?Q?+7VYau7kzRLN/bMdB+FgMfdf9wBDmoFV5/kea3NDP4oD3EabjQLzjSIJXuE3?=
 =?us-ascii?Q?cgWY9KidJR4WTu0Pdj+mIMV3Ji+RnKSNEAbQbQlOyq1GJDefhZCjCxnWXdQR?=
 =?us-ascii?Q?BuhBqVmsB9W5G18XpIfNqYSH1jkURnbaaGUrcyweK/JCvoU7Czz9rlH0L/N6?=
 =?us-ascii?Q?tOvhcb1aKTt9RHR+cHnyqRerwYEz69z8DjEqiuB3Vn7vx2inPrXzaw2i5XG+?=
 =?us-ascii?Q?KrNGZy4XlhiHppR2R6GHTq8JgHyB3g/Ffeh/Wa6XUihXWmOH132/IAwxwnSm?=
 =?us-ascii?Q?P1OA2nq5zxYAqyiNRGeJ/OpOERV5g6zx3OBYyiEcbaCta436xnMjgm65vuIo?=
 =?us-ascii?Q?DgB7VD/wHpaFE+7F9BIJUl/CTeqFApXOiy2vng+R214H2va07RdVETh1S+nC?=
 =?us-ascii?Q?wxTuKc0V5rBamti1W7Fnoo+JRkjq/PMQnY7h3eCd2FAmK2nCr2DtJY8ktGTm?=
 =?us-ascii?Q?mBuEcnq9sfIlyfl7MbfpFT9iUVQ3PwwNLKgddSM6xaa+QSt619btelhXIXGX?=
 =?us-ascii?Q?9EzbMulXcWyKr0OQGrE6JarrFTaBBJyNmi7EKoprE1aD72N+vTC484MGXhzZ?=
 =?us-ascii?Q?d7hnBkCTAvQCTsta5wPjQe0Wo/Ez/pobZNVAHLaGJ7y7SufAIGuHCjdUSKzp?=
 =?us-ascii?Q?B7XoFGZ86SWnxpW3RdliwyuwCYttKvKMHhoPp9jaXjWuAuI6CCrlYMIpTcxj?=
 =?us-ascii?Q?j3vBS3IpHHG9GzPCqLtVdX3gjc0+z9SDReSVz9pnde45XHo6/4y0/TaqTNbX?=
 =?us-ascii?Q?g5BDTujnorNsq6pS0ULw9kin/BwsDe4rK9xHnzf/RTGqSKzXk2IU/ybQpShk?=
 =?us-ascii?Q?hCuqItwsnJO4pitVaip+ciRsq7Y+L6n+dfUhR7Q5626XPwrA83NCMSXbCofD?=
 =?us-ascii?Q?JkU7+r4c6y8c7qDKP5cUqY5K9alTdW7IwSLzFhoRe7cP5r0Ps/v7chdO14uk?=
 =?us-ascii?Q?VtpgHSUBQYFYyJh+YThL6l2armK3IZW13f7utQfd7MZvUvbmqfwwQJay8gLo?=
 =?us-ascii?Q?3W3r0+3SaaDLCloa0EYwo96MUnyOeJBNVazno5g2vY18WmPS3l6V4oqRaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njy95tt/fhM3WPjThNtRKqbl/7gqgH/zFc7j/0Y1OvWjj2qkhdsNdnY0OxTm?=
 =?us-ascii?Q?GSPilTQx4OR1E7KJPrvvJFC/3mgJy5A+jn++Q553vU2ivwXQnnMpO5F/fbFf?=
 =?us-ascii?Q?D+VIMhVav1SrD6vnSVhSnecClvMe54SE3iTMLfR2qj6dkbVONbQ9JXPFv12n?=
 =?us-ascii?Q?ci+A0J9IPdDC4Ilsuuk/fyZFKTEuxHjdpHWQyt8+oSQt0U3WjB7BqxEYJv8t?=
 =?us-ascii?Q?172Y6Xc5DrbfGgDvSBY35fGDFEgVLc9e0YWavxwSuhOoAG1sv5TYgnqUSwSD?=
 =?us-ascii?Q?SUDIbTsDKdMWPx3egxjaLq3pWa0WD7V1yOcmpmgB+ICp/JlYiSypcUjjFAxc?=
 =?us-ascii?Q?+C+Cc+ippWPPUj0YvuEVSP3uKUzkYnFl0wYaSRZfMvM3bVLMg7kszsMYaG9w?=
 =?us-ascii?Q?qup2pyZdJsiEkVut48pc7Qo58x/s5NfzaaIp8lB6oCmQeKphHS+ICbvd85tw?=
 =?us-ascii?Q?TDIz3zLAvf3bvVi66FyoS7ucaDTnaUBmM/YuE4uCjkCV4xG65joUTAB11aDD?=
 =?us-ascii?Q?gID+GHmffb4iBMsQdjDlCu2XSeqeb57t1YbxZpMn8f4cCA8Gn/+3kcP3c0de?=
 =?us-ascii?Q?xxpU5Aj48Xu3ee771U7Y1hI7E+T0mQhhtjDEXgWClZ8EMdiVFeRUa4xXvR/q?=
 =?us-ascii?Q?e6IH6HRXnAxm+m4RPMF5jp2CZpuLARkjhiAAQ98sVbwqUz2hVVV7+8eGBTyM?=
 =?us-ascii?Q?aoP9lgNfBrI+hqGXjz3/iJ5xTn0z1Q9eGoIHJrLgnXYTTRHKZXkNx0DsFv0V?=
 =?us-ascii?Q?piqsdl55Ftg+AWKB45b7hLzutanx3YFWkkZKYUyxC3ajyr2mhoU5OvInbBsy?=
 =?us-ascii?Q?cjdS7cqM4i7sKW0cJFv2NyiEHD/x8xAZJFLgf8H4+ll6Dufdk+bQZ6KTz9fe?=
 =?us-ascii?Q?kWNIyqV+jTD2sRzFmHPz7WaoDb0OXfCVo/LCUmHeRjWcHFQZHZZIyfqlzBCl?=
 =?us-ascii?Q?GtC+MhXrx5jLjStyn8AyBednI+eXcbxP4fhoRVvw+EIqaDtxt1jxnY3QxH9C?=
 =?us-ascii?Q?oJs5xzTnbraPLdHFcanZ5Oz9+tvsYyLj6RFduuOH23+9P8AhsA8IjdLwgV/Y?=
 =?us-ascii?Q?6vm2VIpkXEJ2NOxEM2ef0ViauMivsNQ/hndnPP+Y1IpoRl/2NQco8t5k3Q74?=
 =?us-ascii?Q?b2wi1v3a7n5AGYP2TW1+29bIfC90eTb2XK0LJyv3N7ea1zQdiC3qRCF8S+R8?=
 =?us-ascii?Q?uoD3YCz2V8Rl/5utIOOF0TUxjzi0rLwLLvBs6mR0fO4ZssVybFGFVVVinN/t?=
 =?us-ascii?Q?hP9h8VKOzKm5IUcCocrpKTXvJjJ/7J2J/QcRmEzqHtgzeHj+Rs9NZy6U2PK2?=
 =?us-ascii?Q?asJ7H9khNbjEgea6SsPWK9OHGd/YP96fIYtQ9soZuO/peRBRzj8M6yNtdEIx?=
 =?us-ascii?Q?Vq+ifbnWLou8r1E/i+f1MMS18uDrUtbBg261tJ9C8dKMQn4irWq2HrxB72Fr?=
 =?us-ascii?Q?w3/2C6pYUZdr/fLrTmEioYw+GtFKDwBUHN2rgQu//ka462SY+wYM2x/7XZny?=
 =?us-ascii?Q?sZOB4bAU9BB1pN4iEI9MSeClFMbFcuA8mqj85f8+DA+ndrd1TMgnXnpv3Xx+?=
 =?us-ascii?Q?Z9NjUtpy+0+INz4Utb0IQ/57kuoO5EiUN4armfhSIQpVTprKzA6nBinbLabZ?=
 =?us-ascii?Q?dbStY99g/HnMm6mFOmCVJd8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6f41be-b005-47c6-c438-08de083df21c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:28.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNMDXwZWkLPJQ8BdSzlr536ztd1+KxPjq+eS+wy8n2Ie1+kWdLACRENOHvs9zDcnhvZ9R21spFwO+HsWyL+q4wl8ne17IBkHkerVmtVB22I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8619

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 437ab6745b1a..8408aee9c06e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -776,7 +776,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0


