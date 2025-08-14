Return-Path: <linux-spi+bounces-9431-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AECB26CBD
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C04A5C1CBB
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9325FA24;
	Thu, 14 Aug 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERyhmyUC"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF772566D2;
	Thu, 14 Aug 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189669; cv=fail; b=QAQcc4nwCGYTe2GvDdzNX4ulvo+rHjN2oXKeHOyAsV60PEGpvUzKoFjv1mEoh2CLc0GG86FQI5vGRv5RyuNmXBeiSqPTGwF8lgZOrr53z4N5jhh/QQvdC73xaBih8p+DMtD3AI7i7LgZUce95ksMuXA6WA1OZwJ5q6GPnp+21Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189669; c=relaxed/simple;
	bh=I9nU+TIFIx2Bys5P5m1QXO8SEVqFw4n4DnCb3z7InWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WnZhSIvCB/AQe8QhGfSPZ1zWVxrRV6vntRxGxyf8O4q5au1WWthvD1C0BYhQMZp4vvIt+HtqXsexKTUUaf9Uo/uGKWtm+mrub6ZWpknfUXxFN6q8RrupSuO6QtfQHi/13oYx+YqlBd3hGvZ9dgTJUXNqmJrXrqkBmQOhO8CMaEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ERyhmyUC; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T89hMEn3akh10k78WZ4kW2y1/qtKavsrsve/pkhesWQoj4f0azjhBSZ9t3F2ZTe7I31+thlgCuzyJm3oL6pv78Y74qh/AF4msQS/pAzCz9DiduszbZeqpsrv7efJFN1dwoDAxn4aSFA1ocHnXCj/eRfC7yOFom41MeN2AMqPzdryNLRkgyDcwWtE3WDgwYGPjWYrxYnLPbHwMCvRFbomr1GuHiLwCRHPQT3JgSeudnEHqJeql5TVPjX+7rETZG1w3TcN12cZHYw9qX3S6cOliOn71P6cAGRkLRSiLGmMHa6hxfxjsVdE9NjhjbA1i5D0y4u1yk14KqOfn5nSfvNr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kJJu9BqAi1TgpsR6sKApFNTjOUw5d3hb7zxa8ESdD0=;
 b=A0riyd8hh++ysBvX0r7SmKnW9XJaFDhKN5SddsuhP+xrLeX+Bb60N3rUXQRaqPftGwhTBQJUYBLsLenNO6UOzrDwnKJbRfDRoSpyWnQZfBXv7b8OhJpgaIMQvamPawmMMZiWSuSvk9qOo+SqK2Ek5fhGY+f7VaDgAQvPCn9kYKaoL8pCfGqiMnVRMkIFHevb3SzHNe5FdNe1SS9kTwkfZ2k4QwxyBb88tMjH1RlADfSLDfWGeZ6rnt9MC6sI9Dlg0PcR7gFklqjS1whS50WcqttPvSr0PblgTcX1+SGG5h3G5KnJVMD4bn8josfNwTOqDwXYg4pLKAz+8eEk6noGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kJJu9BqAi1TgpsR6sKApFNTjOUw5d3hb7zxa8ESdD0=;
 b=ERyhmyUCPN4GKe47YSJlNld0vzEd+WkohtevgHqv5boZtT2GYkJlxbdNkV1gWGD0FRqiVFW7HEDjryFXAUqmnB16dmV6bq9f63yqYzZs77f5/bFr/LCc7HpgabX0taOQPKkKGS8Yj1Ga+Mg81seQYUF7ddM41sl+MCTHEysL8yKD1/XQxByC3RaqjS25KyuLRX64Uulslyy/iS/AhpXp4v3a8BXm4+xDDKDgzsraoHRJVHizsQYF/aNKWn+wyh/6206dPVXYr3/iIQSatrEUvMmpnAc2rAcVII1YDC3cEl4zYxNi5k8X83ibavxQCU7TiQngbAx0atn6TWEGtKW5sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9920.eurprd04.prod.outlook.com (2603:10a6:10:4dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 16:41:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:41:03 +0000
Date: Thu, 14 Aug 2025 12:40:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 00/13] spi: spi-fsl-lpspi: Generic fixes and support for
 S32G devices
Message-ID: <aJ4RlGvBhwRcHYM6@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cf201b-0a88-423b-43d5-08dddb515ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlk00haMaQWydEcSJJJBvqcTtPE6D55igRz7ywcR6sw7gla314uvxY3m392W?=
 =?us-ascii?Q?GIkId4//SbsmvTqmzQup24RxEQQU67l4hTEv4PpR2RJrmfF14/wM2dp+uo0p?=
 =?us-ascii?Q?EfJdUOHWLdQKPLi9S7GRcw6YUoXeVKH5KN9reeLr+9DqmzuaOzAeKlHlW7yn?=
 =?us-ascii?Q?erPAdeC0Z2B+bRKq3XoYNoxXxziKz/u84HyKXEEjRAgYbYvU12fISBc45B25?=
 =?us-ascii?Q?8FCc14UrMXe0qczYTK9gUp7ihM7Mf/isHIqXrUY95icNytRsVsPRugGlGgpd?=
 =?us-ascii?Q?Oa3TCWeeF4XT+YdVIKbIh9xk2qTTnuxi0rfyZR6509zZSokL/WGz+6mjERpP?=
 =?us-ascii?Q?Z1lg3R1iaXPv4K2OYnIpRrRAzlLiPgeS9Iq219XSwZujnVIXz1ksWzFHQL+B?=
 =?us-ascii?Q?m0mbO4OVRndivh9Eo1oH6FkrQmXbvauXZh2TaWXiAePFn/4dx8+j+g0h5llm?=
 =?us-ascii?Q?ZQU9/awPEydlpAJMat7aDBN0fdNN++aZ0PD008mjHaC0bFlBMApJlXqAI0NB?=
 =?us-ascii?Q?2/rI1ujxAWxgZtwQY2007xtCi0pAYnwmUF+YXutW/rE1xnmpEP3kUn0Aq1Nh?=
 =?us-ascii?Q?ncdZ4ghUFT4UqkwCumIF3aZ/rtnMAnOuctTbv4QK6QA9XTZBztkfWtvACpGJ?=
 =?us-ascii?Q?tjHgOKPLICWe1oq5soFWNAEzu+HGum1DeRneWeqVwP3aKempc4Qb8oM13EH+?=
 =?us-ascii?Q?w+8oTOCXheNvY/zNL8LMZieYnM3xtx/fYDwVTnFi5h3yZKkFa30ZGIo3SmAL?=
 =?us-ascii?Q?lDn5A/W9Cxne9t/ko484JKE0Z1nqUkSZZlHB0Az15pDfPp//t3q4hnbc9uYQ?=
 =?us-ascii?Q?DbUTxvajoasMT42ZgtgtalBZnMddJ78prMPnIF2jL2ff3uK28ppOfGEQoaOt?=
 =?us-ascii?Q?/WeI1DjJooWgxjhDsSjiOklNyPWObjRq9eoG1ziGt9YiikkXBksBBkfGdcl3?=
 =?us-ascii?Q?CZ+5bnfISkCztZicTHfJMBRHQfujvcT0HMqmsyEvnZDq2xsbpXocNP/M6jP9?=
 =?us-ascii?Q?JQm7OqYX8VVf/KwIYmOlJoJ8Oyh55Ts6zkekvz7gQPYUDwCqb62qQCyR37RC?=
 =?us-ascii?Q?RDHsO7AycAR+PaLvhqzQeHSaJxOxPmEFRqcErRmDfuyVXsMPlAKp5XEe7soL?=
 =?us-ascii?Q?QVXw5NKYYJu7wvMoeEIzeoj6cniBuQAvsje9W4SWDCb6rwY7DbmtcC/CKuj3?=
 =?us-ascii?Q?fNlnog44xBha1VqLSRAJ/lv4o8WR/+91rKeKFq5cwwnbxbfBwmjGpR5ViDdG?=
 =?us-ascii?Q?2ciweI/v7IiybvUXNkW34STIZL7AFRta11dNnWj3lqc02hI+LrxRKvaFSCcI?=
 =?us-ascii?Q?tWn82UifVRgdRZlu168rRE8bjUwZPBzER9zJ/j+TNF+5SttTPDGNZigcNuQl?=
 =?us-ascii?Q?V0xQXoEQ3zQz+f7t1a0ONZYeoJYxXTrCNDnQN44nHOzBVgvDNOi1+uywzn7s?=
 =?us-ascii?Q?tYr1Uz9+Gv93u439monOOtID/WLQ0EfLBtAvWaF4ZMPW2+uinAejgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DC/fFmtX7yPAT6bGFq671g3P1c3RiWf9Ckzx8fbXKgiyGqiwPmyvYclzJPl6?=
 =?us-ascii?Q?B12cpAcVqBP7oJsaNhAqui7sQlYX5FtU8Ud+w6rkepmslGBqvoIG4jFCMXov?=
 =?us-ascii?Q?27msq0kFji3t0h5NFzg+HD6ntkOQ/DXGHNJgLylH3dYk7DnCCXuamh66hcfZ?=
 =?us-ascii?Q?DaCgGpqaiDmxTLTzQOVkLroEz+Z86qIp9ThX9fyqwuReoIL7OfHZcmObUv5w?=
 =?us-ascii?Q?VLI32BTg6D8TC8ScNtNOWbQs58FUO4k5K8StCy8abkdAEHEwRQtfbK30ZT1R?=
 =?us-ascii?Q?CfJRWF9xHr8SvCVYY7s381TnCfzPAqXZ+46vu3cfO83NxP/WDLVv18+ff9Ru?=
 =?us-ascii?Q?xfdecYEomfz8oaAYFZ0033+JIPF0SeokBkVfq4OVtEQVZd74NVL0h//qNPKb?=
 =?us-ascii?Q?X9emx6LjaFZmkwsAF1JNzE52K00VZz1eI2bC4fgEgKjo57U6XtRofTXLgs30?=
 =?us-ascii?Q?WV2hyXlRQCf7AWymeVQR4JquXQybsr+nUrOGAlZXfqEDFIFz77v/70mhK0x8?=
 =?us-ascii?Q?vtXhSqWZbtQSEAN0NGRrIBcNd2/ych8VWuU9A5bIqKcHK5qSYl0/AF8ohMBK?=
 =?us-ascii?Q?4efeT3/fcDn9z8CqObh9ceS+1KpUbuh+KsHgOBoYLlFWOxi/7d5fGZ01NSEp?=
 =?us-ascii?Q?pDfkFBmWYQMq5IbOoNCYEJVZvDujTkIdCr0WWPZgKcvsQ20z7bUE0xv5Du5F?=
 =?us-ascii?Q?uSKnoNf9qpl0Hl55P95kB0s6Yyg+6kFUmA1Rx18ess1zwmYfFQihkekydmWB?=
 =?us-ascii?Q?NSEvv11OYsXhXpMz8ZU3hAifwrjgYYWm+nx+lbvbBrLM3xstqt3AKIjJuwAx?=
 =?us-ascii?Q?PcvdRbXR91nDDLYntGqOqb7wbO7sSNnuKTz/5eZd/NBaB405dS9D/uybZMbN?=
 =?us-ascii?Q?TZO7pNspez1dCHkTVdwYwY21A6Pgf1ddJhbTDe9N+ynWXe8R/VMVK9MdjBGO?=
 =?us-ascii?Q?8TxAmvX+1Pb+v4+URzZzChh7pdQV29Q350nYUWggYGT955rYJcY8tHHs74U7?=
 =?us-ascii?Q?wEKanQ6fsmsngC9tC0VTfeyL1FeN3ypxZFY4xpqFVRtC2mSNis58hfhjUC8+?=
 =?us-ascii?Q?mwr+JRupmNb8jyCM8UdO8zBEBTpCgwuyBXMcXJywEueG0Oj0Ytdxhmdp631G?=
 =?us-ascii?Q?H8gNG9NwrW9lQ9f7s3++eLUUw3ayNrXtfj3kQWnmkldtZfxKalAtTHzl+4nw?=
 =?us-ascii?Q?rp38f+qI28Bf0DSzt51ke3vOPg+RZXAtiXBulkgCi9jCwsoMe+KwdIbF3wOL?=
 =?us-ascii?Q?b4DwKRDI0wojAPveGszqTbnfRljQ/QseoisRwhqmR8JndEU5n5TOGNpOtK2s?=
 =?us-ascii?Q?tu2yI8o1z59MnVBbScm8x/yRarhL6J+hEkCbnZbXZ1XY7HuzEXbeTHFj3+pW?=
 =?us-ascii?Q?J/lvvwXq4x0GjLLEPoX1bP5DrmXlFh49AbZJRoWwhxpIWXae9AoEEoOdqVFr?=
 =?us-ascii?Q?DUc5VmI+Fj1x8n6jzkAUlDmPhuJY211WtIRGsNr63G8OFQVOmCnXtWDLlJB5?=
 =?us-ascii?Q?BYC4f46plbOb6+28zTUPjBrTZ+jpA+dxnYV+izrUVca058K7lXViWerwNyWe?=
 =?us-ascii?Q?rKNo4vZwOdk6HEtPRU8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf201b-0a88-423b-43d5-08dddb515ba9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:41:03.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THTYn80fz9t4g2fX3UhsK1B5R6DrzT3KNAj15hUMbv1+PzzmxM6WIjPz3/azauEJReD7pDN8k9Nx9t278rvYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9920

On Thu, Aug 14, 2025 at 05:06:40PM +0100, James Clark wrote:
> Various fixes for LPSI along with some refactorings.

Fixes and refactor generally is two serise.

Frank

> None of the fixes
> are strictly related to S32G, however these changes all originate from
> the work to support S32G devices. The only commits that are strictly
> related are for the new s32g2 and s32g3 compatible strings.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> To: Frank Li <Frank.Li@nxp.com>
> To: Mark Brown <broonie@kernel.org>
> To: Clark Wang <xiaoning.wang@nxp.com>
> To: Fugang Duan <B38611@freescale.com>
> To: Gao Pan <pandy.gao@nxp.com>
> To: Fugang Duan <fugang.duan@nxp.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Larisa Grigore <larisa.grigore@oss.nxp.com>
> To: Larisa Grigore <larisa.grigore@nxp.com>
> To: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> To: Ciprianmarian Costea <ciprianmarian.costea@nxp.com>
> To: s32@nxp.com
> Cc: linux-spi@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
>
> ---
> James Clark (7):
>       spi: spi-fsl-lpspi: Enumerate all pin configuration definitions
>       spi: spi-fsl-lpspi: Add DT property to override default pin config
>       spi: spi-fsl-lpspi: Constify devtype datas
>       spi: spi-fsl-lpspi: Make prescale erratum a bool
>       spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware
>       dt-bindings: lpspi: Update maximum num-cs value
>       dt-bindings: lpspi: Document nxp,lpspi-pincfg property
>
> Larisa Grigore (6):
>       spi: spi-fsl-lpspi: Fix transmissions when using CONT
>       spi: spi-fsl-lpspi: Set correct chip-select polarity bit
>       spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
>       spi: spi-fsl-lpspi: Clear status register after disabling the module
>       spi: spi-fsl-lpspi: Add compatible for S32G
>       dt-bindings: lpspi: Document support for S32G
>
>  .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     | 21 +++++-
>  drivers/spi/spi-fsl-lpspi.c                        | 87 +++++++++++++++-------
>  2 files changed, 82 insertions(+), 26 deletions(-)
> ---
> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
> change-id: 20250715-james-nxp-lpspi-1fac58e72a59
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>

