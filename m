Return-Path: <linux-spi+bounces-10551-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0485BCE82C
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF54E1A37
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FA2147E6;
	Fri, 10 Oct 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="pgoqWq9n"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427220D4FC;
	Fri, 10 Oct 2025 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129116; cv=fail; b=MGQL+0iQSMixDxVdYk6478TM5wE+7x5+Zys7Q1HujQUySzgZrVBq+hbtuNCljdKqZ0FqDObcgJk3sV8GKFu4PCYX75U/GOlChi1c4Rqfl59x+c4qc9Lss5MJ9gpjOY07CSXZsP35NSoW5yb2vdbOxB9gSjbAVsgRqdDNhZkjo9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129116; c=relaxed/simple;
	bh=A1bSBGy2kZH8EFv3WwQRHeaHSvuGuDCdM/uEwJlCwto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akiiceSiy9v6bYFzpRE36C+T2Eh8T2f4nYcdWOFMAXoUVZNlU0hCJWgDJFnQ11UiOj9Rnfrw8EPjeURWOdQ3xQcaHqSMzG4LEH9QFxosuMrZCfHNWY8a892vLLlhdHBhbqV6okLjngKOFG2pwd6rLHy1w7zupa8JmfDtg7yROUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=pgoqWq9n; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Foj7M/k2o0uSvcEUbCp2ClKpcTq3bcdwYx7GWgSgHUqpUJs6YYrCFjFHsteJOLFqtffFJX5JmWBVS5zM+pfF1hUkLoSR9I1v9W7nIQekfOV54bNUwHYBFOd/+pKPWmQdTETljH4U9ZBVYw0C78qFxWAwEJ6ZP3aKsxBj7y7qoIl4SyFG0/XFnMOCRD3uVtori+dDeQJx/gdDLI8vIbWZ61rPY8atlhYbI2bBHntCwiGLQ6zNsK4jHQw/zZrtc7wxXhURiUsqo78A9HYISVIvzEUZxoyUdomt6a7JpjxSBFeacxHTEZTbumhHOmVpysJpvbEiii2KSAuWAJdr+nVRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=WsbefdULpgN/upt+yppJxJEvE03V6zyTrpFTpGoD8tM0uJKpqP+UfgEm3pOsjTcIObV0de1t3mYufGERxVP1SuvEFo+JPy+ulReUHbeti9yoedf9BjmIELiChq6SihIsO2zwesSFzBhErvdj0WUsvO4Dv2uhTCyM3X560jcVg8iK4ows+NaGlG46R/dtmBhVw48VOgY74ZA09c2dLxpili6vG96FBouPAkqsQ1aK4x0Ye4bZg1AJhIVbUHPLOLk0NqxvbaD0LJy4I7obZpGZpvbBze3hmOHOXnHBFT0LZ2+m03ksXMBx8KzQJqIy7uixqYdCOsTqgQ7HeRuKNn30jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=pgoqWq9nIH6z/G/fm6/QR0SkZtCacrDhRwCWIcZWUze7NMMcdu498aRETMXS/dDYj3Zwznv1kqZEe/D+Rd8dGT/+Ulf+FHnoR33v7pBy8fsR3jGHRAjaHPTWD4VH8NlHsJpQ9WQspwzO9p5K9KukZksES9vAOfXFw1KD93mLIGtHWjhVo8lO+z2+uGN0o283yByOM4Lf3ib8qHh6i2Eq1C2kM58nI00kErIawus62tLCvcjis2tr5rf8FWyxKPWzNitJXhU17OJjOA94TEBTghASlvGWY0XkyM84Bs/7rdL577IW/DQDee4ytm+kxISihLJWEsgX+SuVERVhWnJt3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:09 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v9 01/15] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Fri, 10 Oct 2025 23:44:46 +0300
Message-ID: <20251010204500.1625215-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f31fc17-4ec4-448d-ce48-08de083de6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gr4vl/HX8xLlJ1D1YXtosJJH2dkKATAvoWG4RUvzf8C3Sejq8xPVp7RU/Vj0?=
 =?us-ascii?Q?QAYf6Byb5cn36gEFQVVTi4Yw+mbKQ1Lhl/eCojg5mJWaoX/mIB/3B6rQIGy0?=
 =?us-ascii?Q?La5dJ6rfiANoqS6X06NhWukztfrpLyP/aLi5Qs+sQFugrx3D9LkFlEaEVxb0?=
 =?us-ascii?Q?lqhqFov1iQGOSpMJolOKT2dER0E8mRhupLnLE5wYr2pkWzpjNomtwAgADrXT?=
 =?us-ascii?Q?KjR07vEPisuUByVMR+n8+y5POvd4ApfxGiZs7qGz3qoP1fVGiX6fpMwI5yHW?=
 =?us-ascii?Q?slbedNR9OEjZ7hGIru6p8u1SZE+Kk5XbEarQX7LMqKcvmkqVhGlYPCtYEdU5?=
 =?us-ascii?Q?8MlczHk3D4pEW4gkg1X523pfSgvTSf9h8tKWgEVthW7sHXNK/HxcJlmBny8X?=
 =?us-ascii?Q?XEnU/rf/1LlmaYylZWu3FAhA6cOex9c+UAqzgIgXPvhBONzZcg/y5/YjDSbE?=
 =?us-ascii?Q?718GIMFnwkpIT/8rDaKfoOEKlqce0i0O7k+zhQ4QpFXY0rNpwrZkvIUnHUnJ?=
 =?us-ascii?Q?+tLract8kITZUc+0KFS2LtyAcHrWU2RhdTG0V0t3FUhIJY9i5io8UJ/XrJjx?=
 =?us-ascii?Q?yn0Fg1EZR+olfGomNFir7DSuf2/zS+ms7tEexEJftW5fLCRsf73JSQUa3vuh?=
 =?us-ascii?Q?4JMdRLzWD8X9oDM3KdPK4kjo/lf91Dt+0D20ZivRcY3rxxll6Wv+X5lo9jo9?=
 =?us-ascii?Q?2XdRf2cKdGlp40R92Dq8mBH+hpopqLJrcnR2mI5RyJCAYDviVIVnMcfH5lT3?=
 =?us-ascii?Q?C2nYco/+Mp3l/al/OJj8IcJ2OKUWeTjGVSJ6Ub9hmYrpjb6FVEyZd607Iib7?=
 =?us-ascii?Q?8uXl+qKJFp8te3Db3R1qRUP4RqKT+u8mGBEw/XaIi0JajG3pUshjWxp1Qjiy?=
 =?us-ascii?Q?EHQvr71lOvBhkGV2cnzlBSkQIY2dqaEnXue752mbkafPRAGPx/WCSIVuhO5G?=
 =?us-ascii?Q?92Yu9Q7YiAIRVU1QYsmVjw70u95aKqESITGFAApc/EUqaU9epBTD7m0mZ/xa?=
 =?us-ascii?Q?L8gVUrk06eg1tuV/090CtcPRGz+qzRoji+UUA4tkGsZEWxsdTGyF/XqwxTEx?=
 =?us-ascii?Q?1ijyHvRPRCTPuf3m7+/L3Uv3jUhE37romT0WyOzwXaC8+9qub86gOUXw7ZKx?=
 =?us-ascii?Q?Dm3AzTRKTHL7U1d3b6uqukuDA/I6i1yKEzQEZpBPVNY72KHX/FQAOSwI6YIN?=
 =?us-ascii?Q?9wWrN2SMqZ/QhRljNU0Li7DkQqci14uIQWKWl3aAE24TWXmfsEdB5Kanb775?=
 =?us-ascii?Q?1Qk64m+doB7MtWTewXJzybtr5pfVByM9G97OY9yCNVlUpC3ldiTh4To+qjvv?=
 =?us-ascii?Q?ugetLzUl/qvB5L6k2mXA0G3onrWF5LGGT6rcTUdbBHvt63F9vrc6LQKsSqKr?=
 =?us-ascii?Q?YI1xT+6ZRHSLATccepyYoOTRsvF04nu8g8Nl6U5zpGNIYufV3+tduKL3qXXd?=
 =?us-ascii?Q?ciD6iSjNRtW2C4HNQ3zEViesLoKTAA2sP9us1nif7+5zBt4yRX15+RSEsLhg?=
 =?us-ascii?Q?rDtngClIavr59OvYNvhqRTRkbHV8WNknRImg879JZAib8635NXxSqtYTRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGYC5MKmY4/P4TeMw7eoV8Ahtq+f/BqzN/oZyr8CYqyGRpppBSSEiYh7oFGQ?=
 =?us-ascii?Q?Z6/pLOdNGrW7jj4XpExxuFP8TTy/sXi4sZFVaD/272nBjPlKgVarN3R62k7G?=
 =?us-ascii?Q?ihoInFjxk3LJScFBQ0eP7y+u6m7znrz9nBerK4YwfOBps5wHDq7FsCZkDU9u?=
 =?us-ascii?Q?2vnbwirRrBHmwrHWt6848oMqEZ9xDAmbEexUjTt4w/94971zvjyXJp3Wkaiq?=
 =?us-ascii?Q?nMk6KNFfUDPyBmC5gRT0QpXAsRieUEyU6KNkEkhg0W5/1XQMvhKn91sBD3Kg?=
 =?us-ascii?Q?uiGPf+nVmEG2f7WZZ3IE91l1AXMJXcuski2i3G8ow9yWHdRANnXoFoGxVBdc?=
 =?us-ascii?Q?K5MO/r+YRWx+on0yP/K3aycxADP2fM0zom4sfB8EZeqvdfcR5FcnCqapeQxv?=
 =?us-ascii?Q?hCQPUJmSWlVndoRdG+rReJwJ+Pj09SCgM7jQX+uDQwCxNeiLDzJor9aUE5cC?=
 =?us-ascii?Q?V3L4qgLCgtRUt2a7NZG8NVwvqfGxhz23YlcC3XQ2/B5coEeUbkRev95E5DEd?=
 =?us-ascii?Q?0tBCowfSlX7a1hPGlPChBV4nHf20rqLmkqnhqcFW44xrkrLyUglZuVyOSq2O?=
 =?us-ascii?Q?oSSIWun4rYNcww/NVNsNfFh2e7Q4cYmYdIvbSJ9WkVWber2RbE4qfFFW0t59?=
 =?us-ascii?Q?kmzraanWnXb5GMzIaO8teiuNXE9O7OLwncXqfkdeyUEbJ2jsZQbrE26oxYQt?=
 =?us-ascii?Q?PFSbR1q335/V9B81g2fGlrSflcCIuy/ZHaHqSWb8Zcbc8vcVK83dxWH6Xr4r?=
 =?us-ascii?Q?AfE/M/V84xUMwohqCYPXavP3jAju4HLFHkX7AA1tMl6oddOwgJ6jcKnBytlH?=
 =?us-ascii?Q?6I9opxfJtC4V/Ab1E3yzkWiZhZB6hCtrUDd0VePzXEquUb0fn7qOGfYWqPx7?=
 =?us-ascii?Q?vJuYmiM9JhXNDgozUOt9ggyLMoB/oh5g3Dy4bbgeP+mR8TVZ7on725lgNkbF?=
 =?us-ascii?Q?U2CiLHM7t0Cfsqm3ctNvO1ikbxZT0z5nJfdmV972uDebykamjVVaUGscyHfr?=
 =?us-ascii?Q?epOO7K0cPeGJzXG8NDDRPCO6of3hXTnwZZmDbIGKfV96M4hEyxBCtFAnabUw?=
 =?us-ascii?Q?CkzT91YZ6mIYdoyefmxYnCSaUy1+Uu074hCbUGyAxKnmw6cbupUzmcTwVwYK?=
 =?us-ascii?Q?epol2agM00+bTNNbDW/bI1pxyy7FXAxvNNn1gGtmSu8dwq33zwziSA8wE5nz?=
 =?us-ascii?Q?cauVBAnfKIGr0bmqryv7PkvN1wC3rqMxhVXimYpmDIHWI3nlbxHMB2V0bB9E?=
 =?us-ascii?Q?ZePKJYMClYrz/phfbvakJiIAFhOhJS+6UBomwzXF5MRRaeaSMBAFLfCUFFjm?=
 =?us-ascii?Q?L8aSRgOfnpHVd7KP/W//zpmuMHjx7r5ql4v6kepmDYJYuu/4qrju7rM4vxDV?=
 =?us-ascii?Q?Mca9qvvbaUsRDEkCADKSxQBAsqt7K9CEmQumM7szvNG4X8erQ+kodZGEpHjz?=
 =?us-ascii?Q?1uNveJ8Fbt/oMnfAdiG5zlo+XZs16AGFpzZIpvdaiJdlTvaCNdLrGZXt9155?=
 =?us-ascii?Q?EEqZ3ddHGViIcVfPpR1egWuCEojwuc4l/cO0GXnsuOwun955wCgdl9ialoFQ?=
 =?us-ascii?Q?og3iYVd5xjhBBeqxgj5OWUk7wb5Au2hNrCTgQFWu8dnRQ9GWWfzUNDA1Noz1?=
 =?us-ascii?Q?rP6UADLoFLXtSNoLRDsHslo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f31fc17-4ec4-448d-ce48-08de083de6e4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:09.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EPld3zAxu1Mu0x49OsU5VVdbt1AGituTk2L+T5F2TKc1BgE9hvF87rFm2FghlqKfIBrZaJgpsi77DnDFfHx7Q9a5B2bdfwybZWCSQr7q4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


