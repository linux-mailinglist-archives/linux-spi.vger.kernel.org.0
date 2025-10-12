Return-Path: <linux-spi+bounces-10575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0938BD01BB
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550D43B3C32
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5023D7DA;
	Sun, 12 Oct 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="QHqdveCu"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B961DEFE7;
	Sun, 12 Oct 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271444; cv=fail; b=i8fQr3GSpIKo2y7qkk7m+XIvXc4XFVsfEKlzCIXzQXUo5newo8gh6xyMKxtD0hoWvOCj5NRfAAj6/d41A1CC5p5HHNurJ77JnCdQ5xPQk60d/fS7DcLk8lhWrlfS3fdSDdIyG/hyimIKCo8m+2AwKyi+H8FTa5k/pbD0XQ8J2pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271444; c=relaxed/simple;
	bh=CSb3XVp2l62lTwRTlGTQMzdvcZBJPhX9brqIvLoSE1E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lJLDL2/cQzX1zoQzABXDQN8GgLK7V/BAbeiSw8j2NkmJQ84QOlbv6nhH/c0bWkE8r6iZIYZx6sKGij4zBLxzwh/F/eHYpJ1z5nA5s7U0RS/nV3ODCZgPPXeL7saUjaXuOIPma5MkapEFmCei4tB01nvSGmIonqEq3V8I3aqvGM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=QHqdveCu; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqLemrBH2BlemGB7rab6THU6654gKq+mBydAFWurGJd45h7eAM550wyq5GRoJ0xHYP7L1F6b2n2JpumX81ZIm1MHxIH8jIAEa9Spv1nSiuEonZ26/txfbmfK8kOQQ2bSIFA0iJLBDfJFj/w06gORFYNP+VHrFMvNQcQsqLdvvuwNtev4p9O1M3zg5a2bou2JnoTa+0FE0co/alyZAgu0eHAXAXsHlCODng7RCJ9LAdteYgUigMQWtH7hC7PGbACHL5VsVWf54yGlTtavkF9ddcMmrycb2lQvfOj/P0bvCYhPeW9pig+YfDY8T3Jne3+nLvmsT7IAAHWue1vYttCJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ieg2qIlGn94Qw2BbBMtt4ehqsobcL1q0S7YZ3y8FOaM=;
 b=yyLAC74mvtvGRInAwenIQhzOkaeQZTqTn5heX/EDB/riRpp1abhDBjUBKu+Z+hdVpumIGUqXrwCsIvSeOVRbY8RGp3SkNmuPnCEsfONDrS1kGBvF8X9r5vEeg77J08TvM/wtkvYXeJLtfJ6vIPTO65Se5SDiMviU8xJAzCfe9mwfAkGFRMT8NcmzcIxPTOv77bPfYpHflPLR7qIA+vLMd/igINsnaIvIBu1fawk+TeO6PkoCSfL6AAF9iLtaGpWu0jb0gMARXpzwG5UnuIOERmVAxOUCAMvSnYdjRuK1WQKFSFmUC6ECwwo+SFVyrZYxZFQOmp0L849+A8eciHr8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieg2qIlGn94Qw2BbBMtt4ehqsobcL1q0S7YZ3y8FOaM=;
 b=QHqdveCuVkD5jiH8xlxEazCvxvMfuvwKSUTfXRM921fHR3GpduGXUPRB378gQ+Mx4jzeJvYjLzAfvfGLEfY4jGWnwxmqcpRgFE/3t5vNQSy86+ErVIrjnadYtpk22bGvtj0VEtWLeaOYqpqjkPyh4CaBmtx3rmmFmO7bWoGtz167U21hhxfZpsyMvGo/EWQJIRh1/xqHMThoFePn6xOazBiNZUflyCnE+mtxv8fG4DjmXmbMvoxk9dzdbQultpQF2M9stqhPACfQzOWpZE72iGX+UBu+4IY4+BsZsU04cSu1qbY2ovpSAcvmoTwfpIkBXToWz2/ZyxLLPiqBIkTazg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:17 +0000
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
Subject: [PATCH v10 00/16] spi: airoha: driver fixes & improvements
Date: Sun, 12 Oct 2025 15:16:51 +0300
Message-ID: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
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
X-MS-Office365-Filtering-Correlation-Id: 425a82e0-465d-4395-4dbf-08de0989487f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lpnynWnamcz4RbM5g+04yvwz5gJjRkVsVfpKOs6lBzrUrvPJrDuz5U7WsVfw?=
 =?us-ascii?Q?ZyRgD2oA8KLkAX+hn2+2eZH2K5B0utfUpjtjyOEVogdsZP7jfG+Cd7llMoi6?=
 =?us-ascii?Q?H8YBqtWnkiOVaGmSjnDZumn8Aypyys3ohvOZnLwi7xS8O/IL3gqK61AE/8hm?=
 =?us-ascii?Q?CMc/18g3PXbWf9b9BbAUAue36onHD4To57af04WLg8U0fzt40VYQzz0AP4OZ?=
 =?us-ascii?Q?TVCZ2tkjhcIcCzIzt9awQm1ay+8+dG3WYnQjEHU3OjwnoYf1buZD61sOYL63?=
 =?us-ascii?Q?kKwt0O9ujWkJmhwDc7ldAtwBAoHNmdbGtNl2McfgEYPyva8lRc6VkJnrAE4S?=
 =?us-ascii?Q?IejruzW+8WICJlcPSSWWC3qENOQAbfbG4o0RahZR9jLo/Ix2C28CzIGN9bUN?=
 =?us-ascii?Q?Nw/OTp0XJ0zrDKhJqcCdw7aF9oUSRCQiiYZ3l3YBEk5LqbV1sFQ97RHc3gpH?=
 =?us-ascii?Q?vLl9UgSI2VdAPjOksBJJwPYbqbT2Cbfq+li5Xq23hOThR6ok4XVZq44qwylD?=
 =?us-ascii?Q?pnfusPgwx5sRYfNtmPo6P4DeFExW03Z3K+5QYcJ+eWKdtIExgRYoE3U/fxJD?=
 =?us-ascii?Q?ulQffSKkGApAiDA9LQ0nCnm1vQaLCAqfGCadOvt6ArPdBkwJYgC9gGuxZs+F?=
 =?us-ascii?Q?921n5/EigwFc7jaEE5myrNQes8lX5CCpCAWa1E46D1jTVuRG6wNYYXKygOBQ?=
 =?us-ascii?Q?i8UWFq9CAxpyNw9AMVqfsPXUA+rielYCLbNsKaaHbPuTjTOuif14FjbaReoU?=
 =?us-ascii?Q?Y8tZWnBbWTiQnUwWbh+XWQm5ZrZuBv9103qc8UZBy6+O4jtP55KNc2sY5g9C?=
 =?us-ascii?Q?ifJqtQJ7TYRu7Os5NMJsIt+Ecl0bBuEjvNc+ook5y9tez6/0QeCb3ohEpShl?=
 =?us-ascii?Q?HNRipFkX/z1yg0SiWwNQ12Fe9TUwOje8Ijbd0VRlmsfopcJgNDegbFGFVGZ+?=
 =?us-ascii?Q?p45QsO0zKD4PksWUzvHzK3FFIiIEgnP510Ov07LSG6tDDfJUSNIPAsE7DwpA?=
 =?us-ascii?Q?Y9Dr2ITQ5J3VoILk7V4iSfza9nG5lUFaSVoeMAxwE8ZtxeI678oRnyROQaHo?=
 =?us-ascii?Q?4xPRjlYWcHDssP0Vx4vQj4f3CmxGlfmxmBawYwHf86DUAlqREp+kamvJViAn?=
 =?us-ascii?Q?M+X1WERKcmRtmdu/cbQmtRSyKGFk889T7IplMS+IzmiNKe8X920g7vstqKUs?=
 =?us-ascii?Q?YdQ5Inr99pandU5esdi+4qijQgJzafxQwV+XNXdw8nzDffPqa963oLzpcz0P?=
 =?us-ascii?Q?FHpMaWXsUIbWiHG5J0AShs4UCkMLwqNyDRWkVpBEsIX/uK3/emV6gO4/gxB0?=
 =?us-ascii?Q?jJ52dBk0wvHQIo465lvhjcHLtbzTIRO8UKN1j3UYGNFdnF4d8hbrHEClpTPj?=
 =?us-ascii?Q?zPpboJwEZGYZ9e4zSlimJX7Ay0+LCEGVpfgLUw4HJlxP1tgFmJIbt7IRpTYA?=
 =?us-ascii?Q?NrC0jRrVJYFdYalqahImzP8FlgEEFqnB6ch+3ChZQs5v0hgf5Pq/sXpRellc?=
 =?us-ascii?Q?yrCqVV+k5JeGaWd/HBasSWkRUQBs2WbmtBlVZ/2B/B1g8s48sHM+NeHoYw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gj+5Wycie/zjLjx/WUt/bDbNdWK5haj823X78/EikbXl0VlulRu/u0Lvgojc?=
 =?us-ascii?Q?C5sqnN6i0FObAMFL+P3GzpL572W5CUYDFc9NTU+rPM+a0pTemxq1G6oQE99e?=
 =?us-ascii?Q?95VZN2Pt+VPunMP5WXNHpxYaGk4w6Req5fkMrZoGVGIo6L+Lf15OWpJ8exWg?=
 =?us-ascii?Q?+pb+4sntICB8xSZak3FOGBQt6dXPwfnEtlBkouFBBY/ZluT3C5KVQt3c+kXr?=
 =?us-ascii?Q?qpQTioeBlVnvBwvLmfhq0mcd/ySor5EmvVNAPuzmUR3yVlBHchZIgLuJ0hia?=
 =?us-ascii?Q?IsFjd+N/V8G5jzB5lsFTro+Y557z+8bj4cp/+bAS999kVM+2uB4haLW8fWVv?=
 =?us-ascii?Q?8aIjr2rTYYizSBz/QSYjgXr0br2JipNjjfXc26RkJn9jCK5b19zoE/cssbCx?=
 =?us-ascii?Q?hg6AGfpZTOi+TAL5rhg0g/tX07dvjgFPf3efmgz98s4EOkxOILRRTmChamRR?=
 =?us-ascii?Q?U3thyznHrvxpcIo7wM9Rcj/vJWNwY8UAUBElQTT00vouOze55bEgBLyDUkeU?=
 =?us-ascii?Q?ZHOS7KL5YlKnDOi9+qy93x8vi0MZmy8IyywUtloTmL+ULtPqz9TXBvyDdmTO?=
 =?us-ascii?Q?vXE5JtQHOE6RqowHIfmzc3X8w9nP6IQ4SXAQcF8G8f4F20KHQ5GfCS0Tpj2l?=
 =?us-ascii?Q?b0rr5p2ijkLrFZdktRNWBGxx82ZrtwyguAsrhu5xyhI3iA3nwp37cZHvYG+i?=
 =?us-ascii?Q?ahYOWapI0ZIsloPqUedWegqTL+W090TmrvDjuXCEX7myYOTCk8mEU7UdT2Dw?=
 =?us-ascii?Q?eMkrJdH451JV+YHvIh8ogycty7AyPfr7TdXJiZ8PnYUJcVEgigv1F8pjAev+?=
 =?us-ascii?Q?1/SqGtURGDJdDMU0aqrTnzu4hg4F6OScdTBxW2zA0LDCKbx7W3u/Quzcdueh?=
 =?us-ascii?Q?T6dRNgguN5QAip850Cb2u6Doe813F23c6Q4aPmuCo3s1I7k0q38nooqcqk2L?=
 =?us-ascii?Q?Yh+pwYG/P5s3EnWsojavylPDJFxhXferSeq0dQUfckjm72vn8aQeXO/oHeMp?=
 =?us-ascii?Q?mYyv/4xzvD9b2Yf3RgYXt3tRvofC2HzCOo4eMGbWUl6NwWp2+fN2T1exXE+w?=
 =?us-ascii?Q?1mSkLZdniTpFtYbj4PaB/3WcyvfW01eVULQrmb3J9FFHjJ/ShkhPChG2T6Fw?=
 =?us-ascii?Q?AWxd+BjnnzwjZWIDgK2/E2HRnV8FIVc5P7H04cuKCDgYhTA5gKn+r/ycK39E?=
 =?us-ascii?Q?HxSfl6NStIIGSgGsZnlN4H4O56ZNx0Ar7Vw8KJOiKh7aAasDRckH91DSDzXZ?=
 =?us-ascii?Q?ThOVXSU9kMyp1xofdkODasaU6zf1IJcDtxTCPA8qEJqdqQ/ZXqR549Xsm799?=
 =?us-ascii?Q?Rg96JQzMhdDGpaUk1f3V3loCkCdLrwzd+6xaIuwJct6UIZtYiv3F9Y6k/P9s?=
 =?us-ascii?Q?JJpvDgk3c5tW7PpzQultV1+8VaEuMYAQnWsm/Hm9sbXkomZiFDwNYZM+E8kf?=
 =?us-ascii?Q?TP6maJTNrF6SVgAv5i5ASFAvShp8XS/vaFA+lQLU6c+k6VUfm8WIT8Nx1uz8?=
 =?us-ascii?Q?4clRZvRM5ghptOyMamU7+V/mSY5CKcz2gcOnbQ38yvNzFhgBhBO/ABs5r2zS?=
 =?us-ascii?Q?xp+ZzCCoHeoKZBGm97C0Z6hkB54wcyBkh6ts9wKChArzH5+fIgOynYOv+9GF?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 425a82e0-465d-4395-4dbf-08de0989487f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:16.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z4Zgxmr6jnAK69INl2a5Q+aGSdvHRFdH+bY4xBKF3br5pVwHANgK1IjZoIMVfkA/vPvFtokxpWJ5Ro3qnsDvGQwJLqV6QOuft1kVK3joJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

This patch series greatly improve airoha snfi driver and fix a
number of serious bugs.

Fixed bugs:
 * Fix reading/writing of flashes with more than one plane per lun
 * Fill the buffer with 0xff before writing
 * Fix reading of flashes supporting continuous reading mode
 * Fix error paths

Improvements:
 * Add support of dual/quad wires spi modes in exec_op(). This also
   fix flash reading/writing if dirmap can't be created.
 * Support of dualio/quadio flash reading commands
 * Remove dirty hack that reads flash page settings from SNFI registers
   during driver startup
 * Add support of EN7523 SoC

Patched kernel tests:

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
    [  263.191711] 
    [  263.193218] =================================================
    [  263.199014] mtd_oobtest: MTD device: 1
    [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [  263.216791] mtd_test: scanning for bad eraseblocks
    [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [  263.227361] mtd_oobtest: test 1 of 5
    [  265.077216] mtd_oobtest: writing OOBs of whole device
    [  265.121767] mtd_oobtest: written up to eraseblock 0
    [  275.174147] mtd_oobtest: written up to eraseblock 256
    [  285.210279] mtd_oobtest: written up to eraseblock 512
    [  295.241724] mtd_oobtest: written up to eraseblock 768
    [  305.280167] mtd_oobtest: written up to eraseblock 1024
    [  315.326883] mtd_oobtest: written up to eraseblock 1280
    [  325.364049] mtd_oobtest: written up to eraseblock 1536
    [  335.398609] mtd_oobtest: written up to eraseblock 1792
    [  345.358981] mtd_oobtest: written 2047 eraseblocks
    [  345.363694] mtd_oobtest: verifying all eraseblocks
    [  345.386088] mtd_oobtest: verified up to eraseblock 0
    [  349.830833] mtd_oobtest: verified up to eraseblock 256
    [  354.276245] mtd_oobtest: verified up to eraseblock 512
    [  358.721496] mtd_oobtest: verified up to eraseblock 768
    [  363.166881] mtd_oobtest: verified up to eraseblock 1024
    [  367.612694] mtd_oobtest: verified up to eraseblock 1280
    [  372.058211] mtd_oobtest: verified up to eraseblock 1536
    [  376.503820] mtd_oobtest: verified up to eraseblock 1792
    [  380.914843] mtd_oobtest: verified 2047 eraseblocks
    [  380.919660] mtd_oobtest: test 2 of 5
    [  384.202620] mtd_oobtest: writing OOBs of whole device
    [  384.247584] mtd_oobtest: written up to eraseblock 0
    [  394.305121] mtd_oobtest: written up to eraseblock 256
    [  404.342199] mtd_oobtest: written up to eraseblock 512
    [  414.374204] mtd_oobtest: written up to eraseblock 768
    [  424.409891] mtd_oobtest: written up to eraseblock 1024
    [  434.453378] mtd_oobtest: written up to eraseblock 1280
    [  444.494321] mtd_oobtest: written up to eraseblock 1536
    [  454.534480] mtd_oobtest: written up to eraseblock 1792
    [  464.490962] mtd_oobtest: written 2047 eraseblocks
    [  464.495681] mtd_oobtest: verifying all eraseblocks
    [  464.518015] mtd_oobtest: verified up to eraseblock 0
    [  468.955635] mtd_oobtest: verified up to eraseblock 256
    [  473.395502] mtd_oobtest: verified up to eraseblock 512
    [  477.834373] mtd_oobtest: verified up to eraseblock 768
    [  482.272717] mtd_oobtest: verified up to eraseblock 1024
    [  486.712148] mtd_oobtest: verified up to eraseblock 1280
    [  491.150704] mtd_oobtest: verified up to eraseblock 1536
    [  495.589439] mtd_oobtest: verified up to eraseblock 1792
    [  499.993138] mtd_oobtest: verified 2047 eraseblocks
    [  499.997951] mtd_oobtest: test 3 of 5
    [  503.404228] mtd_oobtest: writing OOBs of whole device
    [  503.448822] mtd_oobtest: written up to eraseblock 0
    [  513.480773] mtd_oobtest: written up to eraseblock 256
    [  523.489361] mtd_oobtest: written up to eraseblock 512
    [  533.506896] mtd_oobtest: written up to eraseblock 768
    [  543.506268] mtd_oobtest: written up to eraseblock 1024
    [  553.506503] mtd_oobtest: written up to eraseblock 1280
    [  563.511266] mtd_oobtest: written up to eraseblock 1536
    [  573.519567] mtd_oobtest: written up to eraseblock 1792
    [  583.455111] mtd_oobtest: written 2047 eraseblocks
    [  583.459837] mtd_oobtest: verifying all eraseblocks
    [  583.499358] mtd_oobtest: verified up to eraseblock 0
    [  592.382953] mtd_oobtest: verified up to eraseblock 256
    [  601.267297] mtd_oobtest: verified up to eraseblock 512
    [  610.150907] mtd_oobtest: verified up to eraseblock 768
    [  619.034702] mtd_oobtest: verified up to eraseblock 1024
    [  627.919683] mtd_oobtest: verified up to eraseblock 1280
    [  636.821168] mtd_oobtest: verified up to eraseblock 1536
    [  645.705487] mtd_oobtest: verified up to eraseblock 1792
    [  654.520336] mtd_oobtest: verified 2047 eraseblocks
    [  654.525134] mtd_oobtest: test 4 of 5
    [  657.578146] mtd_oobtest: attempting to start write past end of OOB
    [  657.584336] mtd_oobtest: an error is expected...
    [  657.588974] mtd_oobtest: error occurred as expected
    [  657.593848] mtd_oobtest: attempting to start read past end of OOB
    [  657.599953] mtd_oobtest: an error is expected...
    [  657.604569] mtd_oobtest: error occurred as expected
    [  657.609450] mtd_oobtest: attempting to write past end of device
    [  657.615367] mtd_oobtest: an error is expected...
    [  657.619990] mtd_oobtest: error occurred as expected
    [  657.624864] mtd_oobtest: attempting to read past end of device
    [  657.630715] mtd_oobtest: an error is expected...
    [  657.635333] mtd_oobtest: error occurred as expected
    [  657.641043] mtd_oobtest: attempting to write past end of device
    [  657.646966] mtd_oobtest: an error is expected...
    [  657.651574] mtd_oobtest: error occurred as expected
    [  657.656451] mtd_oobtest: attempting to read past end of device
    [  657.662277] mtd_oobtest: an error is expected...
    [  657.666901] mtd_oobtest: error occurred as expected
    [  657.671774] mtd_oobtest: test 5 of 5
    [  659.382333] mtd_oobtest: writing OOBs of whole device
    [  659.388056] mtd_oobtest: written up to eraseblock 0
    [  659.393526] mtd_oobtest: written up to eraseblock 0
    [  659.704525] mtd_oobtest: written up to eraseblock 256
    [  659.710187] mtd_oobtest: written up to eraseblock 256
    [  660.021093] mtd_oobtest: written up to eraseblock 512
    [  660.026752] mtd_oobtest: written up to eraseblock 512
    [  660.338427] mtd_oobtest: written up to eraseblock 768
    [  660.344048] mtd_oobtest: written up to eraseblock 768
    [  660.655718] mtd_oobtest: written up to eraseblock 1024
    [  660.661462] mtd_oobtest: written up to eraseblock 1024
    [  660.970676] mtd_oobtest: written up to eraseblock 1280
    [  660.976386] mtd_oobtest: written up to eraseblock 1280
    [  661.286858] mtd_oobtest: written up to eraseblock 1536
    [  661.292587] mtd_oobtest: written up to eraseblock 1536
    [  661.605397] mtd_oobtest: written up to eraseblock 1792
    [  661.611142] mtd_oobtest: written up to eraseblock 1792
    [  661.918754] mtd_oobtest: written 2046 eraseblocks
    [  661.923458] mtd_oobtest: verifying all eraseblocks
    [  661.928812] mtd_oobtest: verified up to eraseblock 0
    [  662.072499] mtd_oobtest: verified up to eraseblock 256
    [  662.216152] mtd_oobtest: verified up to eraseblock 512
    [  662.359956] mtd_oobtest: verified up to eraseblock 768
    [  662.503238] mtd_oobtest: verified up to eraseblock 1024
    [  662.646847] mtd_oobtest: verified up to eraseblock 1280
    [  662.790603] mtd_oobtest: verified up to eraseblock 1536
    [  662.934269] mtd_oobtest: verified up to eraseblock 1792
    [  663.076329] mtd_oobtest: verified 2046 eraseblocks
    [  663.081114] mtd_oobtest: finished with 0 errors
    [  663.085647] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
    [ 1142.213082] 
    [ 1142.214590] =================================================
    [ 1142.220433] mtd_pagetest: MTD device: 1
    [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1142.238388] mtd_test: scanning for bad eraseblocks
    [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1142.248935] mtd_pagetest: erasing whole device
    [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
    [ 1143.967301] mtd_pagetest: writing whole device
    [ 1144.011729] mtd_pagetest: written up to eraseblock 0
    [ 1154.137933] mtd_pagetest: written up to eraseblock 256
    [ 1164.265201] mtd_pagetest: written up to eraseblock 512
    [ 1174.393365] mtd_pagetest: written up to eraseblock 768
    [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
    [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
    [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
    [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
    [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
    [ 1224.947410] mtd_pagetest: verifying all eraseblocks
    [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
    [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
    [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
    [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
    [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
    [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
    [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
    [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
    [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
    [ 1430.473702] mtd_pagetest: crosstest
    [ 1430.477717] mtd_pagetest: reading page at 0x0
    [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
    [ 1430.487469] mtd_pagetest: reading page at 0x0
    [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
    [ 1430.497668] mtd_pagetest: crosstest ok
    [ 1430.501409] mtd_pagetest: erasecrosstest
    [ 1430.505323] mtd_pagetest: erasing block 0
    [ 1430.511511] mtd_pagetest: writing 1st page of block 0
    [ 1430.517166] mtd_pagetest: reading 1st page of block 0
    [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
    [ 1430.527739] mtd_pagetest: erasing block 0
    [ 1430.532565] mtd_pagetest: writing 1st page of block 0
    [ 1430.538229] mtd_pagetest: erasing block 2046
    [ 1430.544181] mtd_pagetest: reading 1st page of block 0
    [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
    [ 1430.554718] mtd_pagetest: erasecrosstest ok
    [ 1430.558900] mtd_pagetest: erasetest
    [ 1430.562381] mtd_pagetest: erasing block 0
    [ 1430.567208] mtd_pagetest: writing 1st page of block 0
    [ 1430.572858] mtd_pagetest: erasing block 0
    [ 1430.577680] mtd_pagetest: reading 1st page of block 0
    [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [ 1430.589279] mtd_pagetest: erasetest ok
    [ 1430.593023] mtd_pagetest: finished with 0 errors
    [ 1430.597651] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
    [ 1478.691648] 
    [ 1478.693158] =================================================
    [ 1478.698981] mtd_readtest: MTD device: 1
    [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1478.716939] mtd_test: scanning for bad eraseblocks
    [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1478.727475] mtd_readtest: testing page read
    [ 1548.352125] mtd_readtest: finished
    [ 1548.355553] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 1617.353002] 
    [ 1617.354511] =================================================
    [ 1617.360332] mtd_speedtest: MTD device: 1
    [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1617.380150] mtd_test: scanning for bad eraseblocks
    [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1621.021861] mtd_speedtest: testing eraseblock write speed
    [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
    [ 1700.921250] mtd_speedtest: testing eraseblock read speed
    [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
    [ 1738.682742] mtd_speedtest: testing page write speed
    [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
    [ 1818.824058] mtd_speedtest: testing page read speed
    [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
    [ 1856.674492] mtd_speedtest: testing 2 page write speed
    [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
    [ 1936.442869] mtd_speedtest: testing 2 page read speed
    [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
    [ 1970.503624] mtd_speedtest: Testing erase speed
    [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
    [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
    [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
    [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
    [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
    [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
    [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
    [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
    [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
    [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
    [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
    [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
    [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
    [ 1984.672531] mtd_speedtest: finished
    [ 1984.676054] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
    [ 2190.651750] 
    [ 2190.653263] =================================================
    [ 2190.659087] mtd_stresstest: MTD device: 1
    [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2190.679846] mtd_test: scanning for bad eraseblocks
    [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2190.690389] mtd_stresstest: doing operations
    [ 2190.694655] mtd_stresstest: 0 operations done
    [ 2214.262705] mtd_stresstest: 1024 operations done
    [ 2239.019612] mtd_stresstest: 2048 operations done
    [ 2262.820899] mtd_stresstest: 3072 operations done
    [ 2285.061376] mtd_stresstest: 4096 operations done
    [ 2308.297322] mtd_stresstest: 5120 operations done
    [ 2330.530459] mtd_stresstest: 6144 operations done
    [ 2352.651759] mtd_stresstest: 7168 operations done
    [ 2375.188275] mtd_stresstest: 8192 operations done
    [ 2397.738174] mtd_stresstest: 9216 operations done
    [ 2414.792572] mtd_stresstest: finished, 10000 operations done
    [ 2414.798257] =================================================

Speed test of original driver (with patch to fix support of flashes
with more than one plane per lun)

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 2894.142208] 
    [ 2894.143719] =================================================
    [ 2894.149556] mtd_speedtest: MTD device: 1
    [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2894.168888] mtd_test: scanning for bad eraseblocks
    [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2897.500416] mtd_speedtest: testing eraseblock write speed
    [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
    [ 2977.813171] mtd_speedtest: testing eraseblock read speed
    [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
    [ 3017.440320] mtd_speedtest: testing page write speed
    [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
    [ 3097.838812] mtd_speedtest: testing page read speed
    [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
    [ 3137.538423] mtd_speedtest: testing 2 page write speed
    [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
    [ 3217.911883] mtd_speedtest: testing 2 page read speed
    [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
    [ 3254.055254] mtd_speedtest: Testing erase speed
    [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
    [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
    [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
    [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
    [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
    [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
    [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
    [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
    [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
    [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
    [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
    [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
    [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
    [ 3267.964525] mtd_speedtest: finished
    [ 3267.968039] =================================================

It looks like a patched driver is a bit faster

write speed: 3260 KiB/s  vs  3277 KiB/s
read speed:  7252 KiB/s  vs  7695 KiB/s

Changes v2:
 * minor fix
 * add comments to code

Changes v3:
 * add patch to prevent continuous reading

Changes v4:
 * removed non-needed patch, other patch was a bit updated
 * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
 * changes were tested with linux
 * test results was added

Changes v5:
 * reorder patches a bit
 * improve description of some patches
 * minor fixes & improvements

Changes v6:
 * do not fill with 0xff the whole write buffer, only areas not covered
   by user provided data are filled now.

Changes v7:
 * add EN7523 SoC support
 * add en7523 specific hack to avoid flash data damaging if UART_TX pin
   was short to ground during boot
 * add SNAND node to en7523.dtsi
 * update dt-bindings

Changes v8:
 * remove dt-bindings changes

Changes v9:
 * fix en7523.dtsi a bit (thanks to Rob Herring)

Changes v10:
 * add 'airoha,en7523-snand' dt-binding (thanks to Krzysztof Kozlowski)
 * fix spi driver compatible in en7523.dtsi
 * use 'airoha,en7523-snand' compatible check to activate UART_TX hack

Mikhail Kshevetskiy (16):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: unify dirmap read/write code
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup
  spi: airoha: buffer must be 0xff-ed before writing
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  dt-bindings: spi: airoha: add compatible for EN7523
  arm: dts: airoha: en7523: add SNAND node

 .../bindings/spi/airoha,en7581-snand.yaml     |   7 +-
 arch/arm/boot/dts/airoha/en7523.dtsi          |  20 +
 drivers/spi/spi-airoha-snfi.c                 | 553 ++++++++++--------
 3 files changed, 327 insertions(+), 253 deletions(-)

-- 
2.51.0


