Return-Path: <linux-spi+bounces-8432-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0DAD3E03
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 17:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DF418888C8
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A29235BE5;
	Tue, 10 Jun 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TC3QKGLM"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A0204680;
	Tue, 10 Jun 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571003; cv=fail; b=AUTiMWeMQI5pcR1pUlGLUvZbJF6ZuqSphmfoMfJs4o+5cQQNhN7mZZLrzVNxDCv8qN5w5e6MB98dLlQZtYZv4ZPHPcTE8osHOZGbbtgQ9kGgxxHVcw6dybAhgnRLWrdbLsOBxDlZTUJYyjs4IMRyFz5EflD9nL829Y3z2fD0ExY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571003; c=relaxed/simple;
	bh=Wu612aAtIDsUfO3uIlKaqsXH/6EPH81gaawnwiisDXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R3nH39/K7v9JRyyPgjnvdwOc6vHKjRLRsYient8dEsH5L2Q4TMZafRKABlR1HrryNov/GAUBoFPFTQDtBL3R7inIAF7cn7jr/UZZBMc8+iImmdbyUxiTLk32EUOy2eVcUK1Wj4qk+3i1xo336KmrWONL1dyZA8O1ypdGjAJxOgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TC3QKGLM; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhkimBV+GwxDmLsLTopdbDUY4dB0Sm+ibP2e1FnBwukVOgwoWdiYafV0Hup1nZUG1WaVt3wMDqq4e4lcn1GsP+qF/TRZSoRFZ7XAyIRSU0Odlm1RHJIQGE9sJF8l0WvUCu+krmkLLiahDqRld3tScuwDFaSKPwncAXRSCsFg+k3U0rAXs7zp8y6apxTe1B9aW/rxxvQJzewvXTKfe6jNUZlC6V9l7xNAQ+MFNj0cd02LoYnrpq2t/kU/BK30NY4fBFJjwQZNraFgWcMoArLFaxSVo6D54JKiou299w7IsKdNjcCyvNG7JAEgnlHDEB68+aa+GxT0Rek7MGUX5ZENnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjsJtzOmzXEn8gX6OI4iqwGbU0YnYTggTl4992DP9yU=;
 b=rHTA1Yi8bjGsjoY11zeB0+106tiOL3RDiIesBfgVDPamgk5vrHGUeylWQGybdzzN8aNlhAcC0jTTUGgzX0cL8UCD0SfKvHAlifUUprm4OVgIIoKgNDdnpydD8kH/7BDKFNptf97QecwRm6jE07jXmmHqL/Popjm7II92JZ21gEEIVfFKrVAA+xJTIFXiJ2dcQULfgeYZHhVhd1WpMpO2UOUoyVri+2onRXWIfB8Tw4W7qHYugkEMji7wMz32ofxUtJbOkcqbCi5FNu7aOYfSHcEDiSyZA+kF3nJQETI/6xEtoINSp+UTz8HV/KBzlnobZIfzJ2mhAo2bmbAe+BP48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjsJtzOmzXEn8gX6OI4iqwGbU0YnYTggTl4992DP9yU=;
 b=TC3QKGLMAwmpMjJgufJmF39AMmHOcJh4hpPeVsn6xPl3yA3/bnB0vVJcCLSvEDrHI9FKQE+QdGr/zMQ59nrp7rKd52W9SBnP94RiDYkVEQwMEKVrM/xQHK8Kgc53UhMlxo8NBPhm6Tksh5Nw6h0E1KQTOLHe6sOiBotwdt4A4ctgfdPqZViOyRIFE7VBy0/L7w3Evz4vhvUyF2bCxXiCQZ12nOYr+swsc39SYdksFshWDD3Atd+TlNRYXYCATHlIAEdM3zLSRlVBqRTGqDhEwXQDw6iwj1Ah92BwrDLli0rqYZ3REwEeHB5Ltcld22L1IeF4A3w6IKjUeJJS3sb+og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9627.eurprd04.prod.outlook.com (2603:10a6:10:30a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:56:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 15:56:38 +0000
Date: Tue, 10 Jun 2025 11:56:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
X-ClientProxiedBy: AM9P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf73a86-afad-43a5-4bbf-08dda8376296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A6ozetIn0OEUhP8qhAJwYsdTgYcyDinATtEg6ZpaXrl2IW/4A6elcB9ng6YL?=
 =?us-ascii?Q?Tb5X7TzQA/YHdwCMF53RCEHlyR6FEsTJJEWJh9n6FvUwbve7YQcM8CGlc8n5?=
 =?us-ascii?Q?+IMpwNRTaEMPiJskLjo7FkfAycE2IHl9SFMYT1Q0aadkrwUpAwnEUtog20fB?=
 =?us-ascii?Q?Q2psNAmY7lBsrH35AMcMGh844u0HGl6/p5wUKTCCpLqlxtXHX0M01GuG7gQK?=
 =?us-ascii?Q?C6JrnQr0tWpY1/wDI5K9UX3jNcNyrTR6WKBFoKBR/HY2s6BM1si5rh+T8YQD?=
 =?us-ascii?Q?kACYW657vki/MjjZfD17MWdPwTpamU05uYtesnXk2eXZy50w1x2CHIHnO690?=
 =?us-ascii?Q?Xj0ewozXk6WVgK8L88QMbdnlFezvdiBvB9TdDtNdkXojg8rsplv/u8RFpTEE?=
 =?us-ascii?Q?pyJYEWwJolyCvLBM/NYdfb0JSUWI1apd57rUcirEW4Z2UUQR6ximBGPnebGB?=
 =?us-ascii?Q?fKe7u19m7PFtATFpbfT0niujykgcaxsPaJgzR3K58IlgMqF8pnU633l0kMUH?=
 =?us-ascii?Q?UM1wZOUmbtfo/Ap3f5mPFdIMxyg+MdRU9IKHbGI7R7EiSCFwYuzcSN1g/+J9?=
 =?us-ascii?Q?bEWTVMnR/QfLQg0TDWVNT8xgQaYtH1ArAkgajGgN9f7lj1X6DzKAUoZYBMhY?=
 =?us-ascii?Q?Tt9/CNVUaJG3cq4TvzLaeJKzgByGvGRpbf6Bo1/C38ECTmM1NDjm9JnFFG6Z?=
 =?us-ascii?Q?uBGBputyUvrORqFl9kCtVTay/xYZynZtno+kyA2PgmhoUcZaV8YB/e3sl4sQ?=
 =?us-ascii?Q?wISt0EvYMfQPhBCbCx3I0QDWZF535WSmwQ5jWX4Wvxal6xODCp8BTI5m4lL0?=
 =?us-ascii?Q?8lMd2USJMWKmUhG+0WB15lLZQCdZwJXDU2OktqNUOScIavWm9rXXJczPmlEE?=
 =?us-ascii?Q?pt83xePojyXmKYiUzXe+oZky2Lk7SSoAOC+bhTWMDrU7b+1RUSuV3+3TIbFk?=
 =?us-ascii?Q?GqtbqHa7R2CeR+af2A6uK+/vrAhG+1F0bVdJzc8iYxmjXxVaInt6X5xjnM2D?=
 =?us-ascii?Q?MGXV2vEWrOiFnnctbMsx/QHcemND3AzvpuX8TuaNwglqk7/tzSvpgE1VVSpI?=
 =?us-ascii?Q?VEbxbLEprnDyTEIKjCZXrZvgR0u/30Y1uWMeLtuZQaayr5xa/lEL6cTAoeLs?=
 =?us-ascii?Q?if1HNv/3VxWLorh4qsxZvrjrS8ofMT+8fYp06iBTL7BPm3OKVA3uwrksmfah?=
 =?us-ascii?Q?k9l1yikYJk8TPF2/DWV0oddFNLdgVZ9wUprRAGtozCbPc0EDgZ0Xf9DtTprO?=
 =?us-ascii?Q?T3dH/e9Q1dI6qFBIomMtOqFTsL5n18CWMFT+8Sfo22jjCX8PxANbalNdwoQV?=
 =?us-ascii?Q?mBl8vhvHR6PjKdSWwo8gnjEK73nOymclaIibpURINpJVYEA2g+3IKaw+A/tl?=
 =?us-ascii?Q?Z63R9coYFCDbzQsOXdDE7TsLrBnj7YA/e7Ftao9HzVaY1EtSJbs62NJWnCzM?=
 =?us-ascii?Q?8r4MTVYkCJXFyGOezIZshz3d0en4WxCOQcqhn3Hi5bdrdjw0GFqBdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgIrdiJ3PRLgrNmcxPUMssAplaDiOhA2ckL/eDrolgtPFIF3J3RP0z4Uzhvy?=
 =?us-ascii?Q?/G8obSOGsrGIBE+Sd2ahXQ2l+Gf/K1cTUebfNLzRqn4KOHITJ/O4aD28NNeX?=
 =?us-ascii?Q?7XuWuMotpUHHVkU3B+udouKVhzyQB9t6kNxpj2WdLx+jjkq+KC6mKmst2OGE?=
 =?us-ascii?Q?i/QfA8TfOtBI3gWY0YdnguqmZzRDo6h8T5v4XwGSDpwue0zHrTYwOt5sDTrd?=
 =?us-ascii?Q?U2xENbWITMpCOay0lKULzCY2tkeXsV669/K0gowpW2OAMtdqkQFMSfAukNjx?=
 =?us-ascii?Q?YAqq3JmZQX/qQpNk0UEyjD5FLcjJqehHHgJguWd7C8XFlxGDCSSOsHVRLq1T?=
 =?us-ascii?Q?1IiiXRKWU6KWWL9vOsi1s2JuuCCHXPYRXLK+Lihl+HpurbZtsVyrhCI6Lq9E?=
 =?us-ascii?Q?ze7Kd3AcRZXDTyUDz0eXi6ETL2CeJi3cQbGfLcCaoMIWRBAIlU37N3V+c1b6?=
 =?us-ascii?Q?0nSUhY02S0Ag/f0TiCclV6DxBYM6JZVeDRanBwZiFEnStuZm+FmgP87Zetg8?=
 =?us-ascii?Q?YTA/1XtykEwTj6Do3T6Hwck9fkP8DUuQ7aqehNiK+UxnRJAB1q4DMh1YZejS?=
 =?us-ascii?Q?NkreggBMcIhwTWJI5p/+cGk+dv/yaSv7ZUhVwEus/kNl23tMM8yOCk76Iedo?=
 =?us-ascii?Q?CztqCwj2aghziz6QinYxyFeCNObRKHqBNjkf5AzkyrrvJVpgQC6WOc8hDaet?=
 =?us-ascii?Q?HE8gy6FcnXiZoeQAe5+NIambsKpb+X8vROj8VtLzD+UelIFmfOVX9DDLiMLV?=
 =?us-ascii?Q?9rfiUysNVo5uoThmfQSOj7a8Zq2mR87CqtkxzEVz2dBUK1a5cP1KDeT1Ya8Q?=
 =?us-ascii?Q?v3+rlCQFfqv4gtnOaT8/k0ASTy+7/dnO6lIPd2l2kE7cmRZYx5x16/EKH7br?=
 =?us-ascii?Q?1qGUtigjpnRzzIxw4QWSITrtZIVjrDJqxx7UqK53IDbDulPIlykyH5ZXzieq?=
 =?us-ascii?Q?O/xn31QOi8Wpu+mU+mYqzKqya/kJYkGbAJcjdYfb34U2AWbmSiNRFp7M7KBh?=
 =?us-ascii?Q?/wz+MZJ/18v+KcAMjKRPNJu0tOqHWEcxd7OXJ5orcT4FXMvfc9qJ7iUXqwPP?=
 =?us-ascii?Q?yS3GAcJsin0jrxVIaHeSapub25RGd6aRf5jqusEcXM9Yn519FhyQb4C9kces?=
 =?us-ascii?Q?itMezT9BJLOibMwfuBdd/5c+uH/UGgOV0U95xbT3AApc2m4us7i7zAXDqd2A?=
 =?us-ascii?Q?O63f8dV4DneEGReYEyg8zcgYA3/u7a33JUh7p61x9wlXPGTMH4e9HpkcBcLa?=
 =?us-ascii?Q?EAGJUPvHqOFw8+FuC0h5iAQd+1KO6r6f14obPAA2V7Ah+gtKEUrV1iqglEgJ?=
 =?us-ascii?Q?ic6EbdY2wQDiI164WuVG6cNrzZuvmVz+z4zkUbZWjqWKMpa+0gnp7JnbtrOX?=
 =?us-ascii?Q?Pa6UPVmmkwjkKx6x2CPtcsVMtVsIwOdmCXc9ZgwJvPu1m27ZISI/PqyKXzEG?=
 =?us-ascii?Q?0Cmv9+uHi83G5YLOpCVvYStiQn+NkIrkRszl5dLgNYZh3ASn8xSaGtcrrxwk?=
 =?us-ascii?Q?OlTdfxunYLYUJ4mal4RRJbbLsOOGRYen595m5K+EYjrnDehWrw8KfZzOPnCm?=
 =?us-ascii?Q?83RMeSaIOu0AZKQ2EfVQ3xhvYTqmNbkW6x+J0Jt8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf73a86-afad-43a5-4bbf-08dda8376296
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:56:38.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqHrw/FPTDMPAAZG61Qe4dhqhHzSDyyI2J6TajI/+/4ciUHrHE/RVEcBSliDuJ/yT33kPfiKbVEnKrW6qgGY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9627

On Tue, Jun 10, 2025 at 05:48:40PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 10, 2025, at 17:15, Frank Li wrote:
> > On Mon, Jun 09, 2025 at 04:32:39PM +0100, James Clark wrote:
> >> Using coherent memory here isn't functionally necessary.
> >> Because the
> >> change to use non-coherent memory isn't overly complex and only a few
> >> synchronization points are required, we might as well do it while fixing
> >> up some other DMA issues.
> >
> > Any beanfit by use on-coherent memory here?
>
> The driver copies data in and out of a coherent buffer by default. This is
> fine if the buffer is only a few bytes in size, but for large transfers
> this is quite slow because this bypasses the cache for any DMA master
> that is marked as not "dma-coherent" in devicetree.

I see, non-coherent memory use cachable normal memory page. but coherent
use non-cachable normal memory page.

Can you add performance beneafit information after use non-coherent memory
in commit message to let reviewer easily know your intention.

Frank

>
> Patch 3/4 changes the size from a few bytes to many pages of memory,
> so it's access the buffer in cache first and manually maintain
> coherency.
>
>      Arnd

