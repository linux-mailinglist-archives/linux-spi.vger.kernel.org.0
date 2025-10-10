Return-Path: <linux-spi+bounces-10548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9FBCE605
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD31F19A7EEE
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F1301718;
	Fri, 10 Oct 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="6l+ft+lt"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B4302CD7;
	Fri, 10 Oct 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124082; cv=fail; b=L1xlPWTH+UwITwbBCf2FVQAiPMqzQooFwukzBF9m6PMmnuow9rR93YqwovoeuFdtQany6DGHrvxn/S2WwLYd9tTJzZ3sJje0JKB2JAZSsTSWe7+foc9vjfwTD0zj7eAlYMAjFg36OLYmaJ6ABhD9JScxvl9mZSS/hAQc261681Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124082; c=relaxed/simple;
	bh=zXs1zjwe73k8NBFsZyuBC+GPa3XlTDJdYKLifu+UCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoXHCcqdfatDTCc3l2az+HIx4+pfNjG6RY/FG9VtvLi60eJWQskMc+piA0TjIRjgPU5MIG0IF1inRkP25Durx5B3t2QYaQYfHXbntJlEahNjTRdvtplLseXMgWnt+Y4LIXxXn35D8LmwaLH7PZycVz9a19CqotRHGidDaz7Sv6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=6l+ft+lt; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7/wXVu7iapfDUWC7Rpwq5SaMQntCvCEoq2qmOiTcPbKsOeS/3Yr6SLbbKb9+N+6opQSJT5PBdpSJdxFqkCuSlhdpGluvja4Uz7vz8qvejln+m4gRjYT7g1mz8VChaN90bgZMdvN/6/yPh3jdSvA8JbKltX+EiBkpQiMQ2+qqx1wQbTYkqXZ5Gm5YSzWAgv2PgvZN6tCEr2A9kKeo6wJocbnCFFWyFiH5KFYLk1PxSdZDWy3z42ZqonKjjOxPd4nvGe++1jcREBceuzQOnVTzpx7Iv1Fz3wuCuoSnxQVnZ6FQ2l2PI4n4kUL2XKAj34glCgXXEbwiohuH+y0NS/ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=QwrdH6DUV8sxncF2hGtqawJxIqrjCcIuFV5Mfl4rKCthzIjScJNPgGVOLinrcEyhAkqK4YkRDzVfU23VAwE0JZ5xl9E0EIFMTXtWqQYBmA006bLTAs7Wy+syfzeA8MRJuyA+rnCqpaylJgYOVw3+dp4GvnwEKn7QtqiYP92He5WiDUzRT8pYjKOznQHgDeSygas6s/iDNAgozzTV55THyn9fN8uwWmJ7UYPiIy/XrwKQoOjMqUE8jxgUD/XhRLQtyNs+2OInmydfYzWgHqXm3REOY1Z3QgRkfn6hWCOjrzBEiXdowsfG3If7xOy8rs4ZgxueQ0LJjZfdP672OKo/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=6l+ft+ltBAGpoLSvdNHaJGQPiCoDYERNeY+7YN7nBh3+oWisASnYb4Q7iGt5M09oKRhbq3hvOYtk3fYM7g/ovGJrhAkmq/1xNOnQasnsUzz+9UlqGVOuh9d1fqodGyHinMZek09dKEZxqE7dD35tOyUjy2R0Ln7dE3DcqyUXMP1MbMW/KpR2kRSS03zbxmqNKEQ4kznBlPGLvl1APp4SeJqs3Jl2q3JkZKh77taqGNbSAvWRVYix8LevBT6qWnXY9WodyXlolqHVkE0SRJzsZ7SpBo9CjVKrdh9J9gWuQNm4bIOCNTNLvaSQ4WrNJBXdgtD4Wy0rroWxkPsfQd7lBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:21:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:21:05 +0000
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
Subject: [PATCH v8 13/15] spi: airoha: buffer must be 0xff-ed before writing
Date: Fri, 10 Oct 2025 22:20:36 +0300
Message-ID: <20251010192038.1592889-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 359f333b-b0c9-48cc-b39b-08de08322838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i3ElvNHwNiD5JFygH06qZpuIEDye4knt3xlW1Ld/le6yKmpVG5KWXj7BDTxX?=
 =?us-ascii?Q?jaeTqs1AdA3EP8AlXviWGS0bG37vNY4EUjn8JoNy9Mx1MKqr7J3b8229Ig1p?=
 =?us-ascii?Q?JAYJAVbBEYiX7YijTcBqmQ0YS6v3ypU4qf12gOB0iQbzZrpsFuAdkfaHTtRs?=
 =?us-ascii?Q?ADLS9eJDoT1Wvy52cs9/07j0dDkwyNx2EzR4Lshwb/6MN7K0LzbNUtlzrnzH?=
 =?us-ascii?Q?FKpkyc+LHBT3/9eIo9xFmYS4kC2FUzEOPf9tvCZX2lTN4iMCVPGYZ1G2kNq4?=
 =?us-ascii?Q?BPyb/CooJSgALzlwlOmy/gCbfHxBuR+kXDOEnG9LKGQJh9wxl1MgPxM6wSXo?=
 =?us-ascii?Q?ggAOjbURXZZmfe+h8ZYET1Ek1WG1CTLJAQwx+ViP4C9qyl9MV6SwVtPvJLNc?=
 =?us-ascii?Q?CrT4qCQJgxpfEmRlXBUF/RBndl63tHQh7woCKcEUpKIfzzq8OIgL3qaUIEov?=
 =?us-ascii?Q?ABXVywkBlHCsDQtzOTnmBxyKzO/mt2lkp/BWBLxxs+fCkh5jbhCXST+T31tz?=
 =?us-ascii?Q?9iElEJX9kx49qRtT/q8quNeBRLNOM0NHdtOeEcJFPBI4XIblWDqCDhtZwIH7?=
 =?us-ascii?Q?ZrXfPkuPl1MNHrwtM5L4FJRE/hVUFeWexdBxjJb8kSRsvWAkZyYwwMm6+8wM?=
 =?us-ascii?Q?jWe146H5vIa/jyHO5iV+fE9ba4u5MsgrXdM46yajjdUcTAPLvgY1buvymVLb?=
 =?us-ascii?Q?kv10zIrWkPQa6t4brXUB7enD6CovFJjq43uauzOYI3Fw6F5i6/w4NkajBvAg?=
 =?us-ascii?Q?LZ2TYALsyIKC9RfElXCq132cn2CUppuFRg4NjhvY1zLLXakqRWFmMQo0yRlm?=
 =?us-ascii?Q?uwyxp9xl01xf2ZONogPKxU65ipRbl7g0DRqx1uz1yekJcArNo+fr53H6pmjW?=
 =?us-ascii?Q?hEGNXUCCUK9bkf2+DdYtYlLT8Z+7dJPTiP047pSFUdUQikwyMDbV1B9g6fwN?=
 =?us-ascii?Q?bQgI+NGOsojcPRm9xalses+RIwpvhD3KNpO1CZQi1De03QVWSPmaQylwj7bY?=
 =?us-ascii?Q?EtOZE5id8gnyLI2hBeocaP5ot5UlvNufpGoANaGy+WkyAFHC3RNA5OhyiT6v?=
 =?us-ascii?Q?SzrnbkGFB4scI4FxdhqFgVlvRm9qde3c762QACAjAaHHQ6BhfuxcslB3IF2B?=
 =?us-ascii?Q?c3A4cYYXnXvWKcm19sPVicnuS5m35oFAQx1nW3mJ26x28cQSM5fqSTyBL5kZ?=
 =?us-ascii?Q?AjlmyE2X9iS64Z7NS18It9hkZNDE+P2USOZrmZeUNvJ4oEGB8+qxtrvSEj9H?=
 =?us-ascii?Q?1Gn16KcVI2atoLsqaUmTGJthKZwdzk44Q5xZO1L+qFUiJwY8EPEmMW+tjuNf?=
 =?us-ascii?Q?VDwHKX8gWagoeH7TOfJBwgN5l7OhLdZ3KvVs304/Lxt1NEixm4EWIowfsBcm?=
 =?us-ascii?Q?SkqKf3fmfNkPHex3cBrsecLJKsXbNoVPGNpfG1iRbQ05+2vXfpjF6/sWlSit?=
 =?us-ascii?Q?o+qYsYLMK4ZWHXIUZlE3/DtaTcmh3q8M4WS/9AjIHl7snuct2yJRxhkhDN+X?=
 =?us-ascii?Q?kz3dDrRV5M/xNHQy4uGcwUb8Qu7bm2GKviK82mqyMYE4SpTFShQbhCfgyA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZU2xmfN4kEgtDnYXI0fgPR5jON4VwH8GDVCKdnV5p+0vPCLS0Te/ji4gd4E2?=
 =?us-ascii?Q?1vec2PRHx94cxw1gvo8J1xPzFVBvqgsdsDcR6xjodaN9edyvmjLWmZ77ex7T?=
 =?us-ascii?Q?6pK2gMfB/RClHjf42iWPJVYkUV4bLnbbpuMyZA/1va9bgwmiWWBUXfVokCr0?=
 =?us-ascii?Q?5PM9MgdZ4KaUm4pghgTvM8i7w9XBOBcZ1UxtKpHMi0n/zHxIITg8R5QKYEgM?=
 =?us-ascii?Q?hSzfqp7/uivjcifBkVD02RRIFL3MZOv5B5IWI8Tl9NCZD9GkOZJpqInWVHl5?=
 =?us-ascii?Q?Tu4cKGbmnw6/G7mqbuJB5e7www1GA79kGfVs7v4dGDSY0VluTl9vM+5Avxqz?=
 =?us-ascii?Q?PlhcsXuG0hKSngz4R4w6EKuTiZMJWejsuex8LiZStprYt8WhsnE1R7+27Lhp?=
 =?us-ascii?Q?RruCrrAj3Q1bMgExjfMmsruiCgARlNetuVrEOHd4mt/vwnbCbjFjZEFS/8Ui?=
 =?us-ascii?Q?15UJBlfkT+xEbg/rq7jCGh68qJk9nehHNzMHrgCIjMlDJ2kRXZbALmK6bg5v?=
 =?us-ascii?Q?butZpjm5vt29SVpy/7GAST0mkXKmPpenrt/eZ3v07/JGq9ZV+nGtFnVib16j?=
 =?us-ascii?Q?VLRmRzqQ5hfjXthkvNTIyjgBJ1DcVkSjEQQwSvJoIPYOyPUeuZL2Cr5dVe5G?=
 =?us-ascii?Q?2zgHtozi0fuWTD1g9af2G/RCkLSHSj3D6KtN4MSkQ2VsZQD3Oym37EJFXRHa?=
 =?us-ascii?Q?baEna6skqqLu9AcF8HVPes7uMUu2+X73konAV4CYZXGHSaDdNMDNog4HCGae?=
 =?us-ascii?Q?dIWHX1h5D4UN2RuJEXF5TZK8nvyTcDILCULTFD/qVG66NuSgM/R9kvLiVxXQ?=
 =?us-ascii?Q?KfhGPcw9mF4zkBfbV/xY4AM711oRe/B8yva/+Fpq248m55wOmFP/eE3zYs9n?=
 =?us-ascii?Q?lPnr43TQSfzkRGTvFJafbhtmZyM6m1m2ODIrjqFm8t36Gl7ukyyLcad0X2vs?=
 =?us-ascii?Q?nTNCT29ebVzWjDJGvCXcMumNWrDBy7GQSDG+D9fESS3yyc1/nKAPRJTZv0Yx?=
 =?us-ascii?Q?TGzEMALpokYEfM3gk5K/7S1ROmTGqAM8Tudj5x7zWz7hVPVvCp1vTMkr+Lxx?=
 =?us-ascii?Q?NH4LQE3Ttchr7EXTTqOZ4ssLvCp7Cde505Kpye0OBb4on+MNLR44fTEBTeBF?=
 =?us-ascii?Q?lreg9aFIFyILXYWOzJAwdGYkWpaZ9jwu3/sHcZXSPsdF1qmYblzryCt69Vob?=
 =?us-ascii?Q?RBHwBhLll9Og0LSxr7oK/hK0QZoUiJIkqh/Vf9SZRMPXSCw7rae6oRXi3oYj?=
 =?us-ascii?Q?NiFNW3yWz6cDmBElXTEVeCO4QbaKMpzmnRp6oq5I0+eB9KEVH4JLmhUoGc+m?=
 =?us-ascii?Q?iyDKa1hQ34T7kdBH0w6qZQhuXPM/s+KbFGyxMCx/0dGROPivTv6q8bZR/bDs?=
 =?us-ascii?Q?1Om3FzO5dYpl2u6Y2iUYgOu2+vDtkzrJHegNJrW9JpZnX0pqk8l0LGzgfNQ9?=
 =?us-ascii?Q?gNjs329WqynMLqBznN9I6Bk1vXa/Ix/C0Svvuh0tXXshjivJGCTCZU7s1Aty?=
 =?us-ascii?Q?yNP3TPGfwhInv122W1i9mX0+a4BsKy6lHHct67aLBhosVPKeM/oodMhuv1Bw?=
 =?us-ascii?Q?fW7/aIuZD+Xez1Aq5bYsFBshG+8A4cQc/TvAfE8vsmQeWir8IgXteWDWO1zi?=
 =?us-ascii?Q?9L6/HsbAyecGsDQmVq5WKig=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 359f333b-b0c9-48cc-b39b-08de08322838
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:21:05.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Exg+kHi5x523Kjv+lNHlLiXMV8wOwG3tzh6mh+3IfC1BTE67LIKQ9ivymjTmSuks6l0yg5MRqqa0gZqFFOfPvla5ndNI2kXuoQ/114WllQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

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


