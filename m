Return-Path: <linux-spi+bounces-10579-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34124BD01E5
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93F214E5468
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C4275AFE;
	Sun, 12 Oct 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="o6PU3juj"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2E275863;
	Sun, 12 Oct 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271452; cv=fail; b=SQdJnW9xpbnwZHZRNjkzktg4LeUrS6jHRQWVuhuWsqlOcgAJ337wtNS48aQL/UskMuwEo+OG95O4EIgPG6zSCP0BRBdVSj8/gahwlc5mobc+/s/ZfU15VPNv5gSmXoD3IbcZLAvALJIDCeycY4kKoUqhalpX55oK9gyzqdg465c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271452; c=relaxed/simple;
	bh=ln9Uv+JjcDjysM4q50VJX3fGqO1QoWoTBi9g3lH9b7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhYwHcLR+qnE6vtrCAg83RkMC+zmNuEVFMD9ASqg2h4TkV1lKhThSx+/2W9sb0r16+wNd7CmK8s/1FcEZrUpDG/62QjexZ/RHct62g/Ym5qxBVLqU1VhKmkv8lHIoep1c16xmRjLNyGOj0Ug8qEWMDeBvyGFwzHTbD5md8UF9SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=o6PU3juj; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr0o2BLXlo1Pmd+FMOHm008QCN2i7odXCR3XxyRXn7JyMv3gWL//7RTzh/8LglE7eJu8vKF8DdprhSkSQLiBW+FEscRXIQln5ynCLyD9l+z+TQP6yZPl6pGobZAF1db80nxFuznIU7il+ltmOJayFJq4ddWy31kCtxoMgCQh+0gpaE31mGVz5WhbA4hhdFPWztkzWDgYLof4ZdK3X5yD8Ht1m9E6V3Dz9rF7MzJ+4P/fHz/IukuX02mU9EIht/5bYooatLVTpcSSQm/l30ae5q/KMnJBb3LvksuIVYmr0GX14dmDZO7MVfupRiFy5JCMba6m7KgFI/cVQaIzKIsWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=O6x1KmI8r/QP8dRj1LdQYervwjE9r9NmmvSAzAD0ns8wFnnbrpFt55UNQnM8q4PGpKQNg2gQOBZEnPTlCiuSCwDxsm7maHBEPuL4eBWdcQiBBUEFkTfr9FJ+D3oBTC1zTFZ+eQjRii0lu0bGxXWOsYPkf/GbUnnm1eRZaSW010as087d7j3Oai24bh7O+JYX4myadntg5gXTGM0eomyncIuAFER6wbNjMHySjHsNLrrNRoBzjvMygHmAIBGeGqlD6wGg44ht6XMKPahiwfaLd7WfagSa2YPXlVpzefI+T+HTgHoEAs3OOnJZG+qxU7odttYeJllemLE7bBGsNYwjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=o6PU3juj1vNw2pR6trnkj62L6hfvVtUCv7zYX93bxXLZTxooYGCKCF8XX5tUEats5MUHxHlO1mcHInjebRHYRV6OeksO8MyV4bwNVrlzbfO0ZlrWga3hK11sab2Ev8LEKNx0juJRApPwBaOhZD9w7CR4Do1BlbD9/5aj8gbxag8lxJluAFJZaxXfQx2xzRGBJcNsKx0plOExSOWlAeZv857otm/JX/gue4JNDH0B79yCyejA46aDS+D83jqUwhVQPzJP8JQuJgu2KoO5KMHS3zUkJklvCEcpWEhbw3DaDkgpp4I4uttlLt7P+1GYgjIOpiAjjbuQ0ED6T/AaPUWhbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:23 +0000
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
Subject: [PATCH v10 04/16] spi: airoha: remove unnecessary switch to non-dma mode
Date: Sun, 12 Oct 2025 15:16:55 +0300
Message-ID: <20251012121707.2296160-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d61ebf55-9e6d-4b68-a88f-08de09894cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LO0BhycDGUb46syS4LKgBwFAYqarDQ2VyefcZsppuHPC9TE/fy3+qKXqBxfo?=
 =?us-ascii?Q?RKdEy1vIq5TMIEzdtz46BqghTo1Q2LP+nyReBzLO8iEduJnvqH6fSz24tw2s?=
 =?us-ascii?Q?7sNl0setPIt1ylIjKFAgaeSgL3DJWnlvGChBwK4//my7lDFIWJIPVMzHB7qN?=
 =?us-ascii?Q?dB/+itNSQ32PC+QWQcbruFnkAmDIRAbM9MGi0EY0Vf90JIeyBb1x6LcdV0YS?=
 =?us-ascii?Q?+Aiy83tfRIgBzfCtCMUaIzLQqivAEsQSGl+IP1Fd9FeJ2aLTSWsubZofhwz7?=
 =?us-ascii?Q?upfnGBks+BdCIY7Jo1gZgnG2FUIRsfPMDkrouwl5byMBgvrkCVSOkhBNCADQ?=
 =?us-ascii?Q?860OwNS6VozgdYy2TwQAk9m3+XgdA2xckITM4KBt6yv61xrZbmVQied3j7fR?=
 =?us-ascii?Q?Kj8e3Ei6GAU+E+NkSsfKqH9UjmXPJK0Db1u5H0grlwh9OC/lObmsInjQCD+O?=
 =?us-ascii?Q?+v7CwD6zxim7aAPSiI5qDO5yyF6n97fQQUAnMcR8Z7Ie3vC3Mq2HS+pXPGZQ?=
 =?us-ascii?Q?y9Gwa8F3hpuIucexfB05u61YptuCnWAZrFkPm2I73E6+zKWVHqcu8Ecd4xO/?=
 =?us-ascii?Q?GY39V5oMFLlU5R21CUx/2UTVeC92Xd63j554lwnsNl6uUJeqmycZdnu+jEVO?=
 =?us-ascii?Q?DGHBbD/KxBLmXl/rluWVGycK3MANDHuAZoh0ej84NvflzPeg/wvz2tWiC6Ag?=
 =?us-ascii?Q?Q8H0wJey7y20Gl9bganXdqvdoxDOWRX8OKjmrKCs/d3gu0NshFFoArM4Ct9d?=
 =?us-ascii?Q?ibMG4eXZOfXZ/xWjbK958wLIsso/CV8x5g7yp+muLH7mqZA9FAbDSKDHMdgg?=
 =?us-ascii?Q?qXigNG1zoenANYB1wcxpJBSZBdIm+yqBFx4/OfV1LYWC/Sa2Y/se1O9QwBZ4?=
 =?us-ascii?Q?y9M61Zfkv0XYPTjqP4sJGvjz4lhcXBWi+mWUOUiRtPMcKQzrIRD3NByxxA8B?=
 =?us-ascii?Q?CcnrvtDirqwGxMuwjbeKesRmYxFr3XKlQW2A+354snejNf0KyH4z40zXRTTW?=
 =?us-ascii?Q?xZ3mPDCam+LBQXORGt5JutZ3iLKDhYvEmJ/AwSTHzd2SjNG0u7BoFpbnAcLe?=
 =?us-ascii?Q?Xecg3rasbVrfNq9ApHY0uUhs3pXUc3EqjAD9US84+r193vlA2kK2WqJ6QLjA?=
 =?us-ascii?Q?paDm/szEhXO45bJjMnUj2iB8G5jwWyQC5ofQswkYrjmo0mzXO0JBSfGj3NpQ?=
 =?us-ascii?Q?0s0tQnHhXWy7GkaSUSqyns5Bz4JYf2f61BAU0OafOU2XYomhVhXwwSyN8IQd?=
 =?us-ascii?Q?B+txQfVbldy3q9uKDO2QCD9IcESBpL1mztqU0ApRQ0fXTJ+Vd0Kdbq7QCDu2?=
 =?us-ascii?Q?UiLrY5/lQ9Bo73krA3iq6epNFOZkhNIVpH96LVzsh0JhgCxOxTY8bpZ5/MKe?=
 =?us-ascii?Q?oLyca2BO+IgGkZ09THn/Kw9lSEJjqequ9kpMF1wBiaOn/xkGxWdbdYpWjc2n?=
 =?us-ascii?Q?Q21zt46Dg51795Cd88e2vl7M75YVERaMXEB/UJn5bGJwgNPr+hoI9mpQq5yh?=
 =?us-ascii?Q?CtSSRCYcO+ohgsXg+PD6umbVUlCps+Sqc9fvSWh2r60wod+CzRev6LcslQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SJJ6rGZG7txhhDSxwi8XkwqJEwimF/YWe0+b20gUhAjQlxUDAr0lyRYwB88?=
 =?us-ascii?Q?Qnj6xpN+WKkAqAqMNzR/W7eTQ+kgPG39Mm3tPnlykmFXN2BYQquUDhBZLB2y?=
 =?us-ascii?Q?BrS5td0/J3uCoMmZICzo0v5InfJBTnKU/5187KlRZLUp4mfejJtBoeN32T0D?=
 =?us-ascii?Q?E2BdNOuZIDjQCDQgEyd5sPRQbsdGpxh9bOA8uzUWPHYG0s1DExjPTY13QgaC?=
 =?us-ascii?Q?yhYNjBHA+LW2cRLxkaBxMZ6wokiG/TizaLAddz2GDsHm4cb/61Oeh2J8kmTL?=
 =?us-ascii?Q?w64B3kbOLt/0UIC1fW6WxNJwe38QNGQ9S9HFKbZ/D9h1Pe37NdBe7D95+Sgz?=
 =?us-ascii?Q?i/RP+BOK/ivykGmC2XggBguHQX6BHpmN7mLJIyX2XnEKR+Q8NR/FBW/JMtD0?=
 =?us-ascii?Q?b1EeK/mmUqPWGqvuyIQ6NqjAB57BLZ8UVBoq6LbUSaWbig+OyF3562t5AiYP?=
 =?us-ascii?Q?JyKecH+iEPwZsxRLfLkzf0av/6IiwtjJb/eeIMiNN4zUVGdsvb26jBtSazek?=
 =?us-ascii?Q?U0kzv+2jPThYX8GtVmVt9rH+RfM/KHCd2kvFuzdNvLZo04Aoz65MHrao+dYc?=
 =?us-ascii?Q?OfiUzcrGWxI6oKgx915HDpn6h6iBJGUBkbDRvd8w5PFGWr/DRT3RiuVoxgho?=
 =?us-ascii?Q?xg+LMWTSB6RHYUXtBAMR0tIdxCl5Mol2e+Ed/9h3/LwtWUaKCW/OmKPWAixZ?=
 =?us-ascii?Q?n3XeSI9JdrX1JHiVNVtpJ69i3SSwTapAEjDxm6OppAbr3x5w8Ml3j1QRFmbQ?=
 =?us-ascii?Q?wwEyg1Ug3zY9v6aACqUCLIAVswPl7DacnnkZvy85Z13Z8M7mmG8JPhffgCQQ?=
 =?us-ascii?Q?iW8pdnJUBhRlOXBFuFLuT6ceyDXqv1D9eJaubzos9BkIIS0ApbhYsfz5+d39?=
 =?us-ascii?Q?VV1f6ADUQJ9J9oqBTbHCMR/sRQsX1qDo/7+w3qUo4LDIXXkAhTE1J3c68sMT?=
 =?us-ascii?Q?tPgYOevls7U+AYj+rs0WsdiWrIYoGeYP/JwtiNl3l8jzKhe4TuNa609kknHe?=
 =?us-ascii?Q?oByj5wT6SwVR22WV8RZAaJYluhwXiil9dLO+ujnn7D791eoEWU17aNCai7Ry?=
 =?us-ascii?Q?h0FPzVXVbCwOj4UpzYVS+05hYM1+AbqEl0Ol90E08l2B+p+WcrjfBAaUI7Lf?=
 =?us-ascii?Q?79mQr2Nx28ZOzd2CM+7w0qxjMkfKfHXBKVoiRqzLbzNXTzlEvFtdWnKeGl9C?=
 =?us-ascii?Q?zTtRvVibRmtZC5S2Cg/gsQ231SwR36T4GLdVbJbBVHbeo1WhQ/BO1UVE2VOE?=
 =?us-ascii?Q?jLNM9CnYXcLxgtelBkJh/5jIG2muQ3JXvIa4FINbAk4G1h7KDmR9f2KT/VLb?=
 =?us-ascii?Q?wTzkhoexPUGQf/tTxpLKJPgV8ZOuyOi3zvn0743uq9LDSlh7XkZpDfJqmEfK?=
 =?us-ascii?Q?U3ENZr326mlttysggwnsNe+IADl5MyCBU6GCy+nmmuEzNgjzlVi6MxxDx1d7?=
 =?us-ascii?Q?HB2oiTP4woDckyvcht7xwqvgV5+yD4rnVGszi1lHA/XsICgCdZRTixUHbhuo?=
 =?us-ascii?Q?O1Y/RMm5Or5ICRXGfs3P5RI/spB+SWuB6wIHzMAtMVaVXa3FzphitfMvNY7l?=
 =?us-ascii?Q?cF2h5lXaQPRvRCpeJV4dTnqfNlCfNzC9fWIBS3aXaxCz5xJPrgqJl4cCK/EL?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ebf55-9e6d-4b68-a88f-08de09894cd1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:23.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHzhXNZq3tNXv0OlqUuhCf3hSdX0ElW5AxrYgxwWomRIQkFWvUSFO47rN7tqsSZR5o0AMWIY+e5wdjHKax4rYD4PmY+5NU1FdSx6FWrFTM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index fffed26ff990..2d86dc62dbde 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.51.0


