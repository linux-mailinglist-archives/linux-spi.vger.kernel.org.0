Return-Path: <linux-spi+bounces-8945-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E7AEFD2F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC29316ED4D
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FF275B04;
	Tue,  1 Jul 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OpUxp2Tp"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAE1DE89A;
	Tue,  1 Jul 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381601; cv=fail; b=E1oIRcg2r4+yGK4xRrOrKXoHz7do6ZWDmst9F9PI713sEdhESaXIKsl52tGjOQQLFuMtBn70Bd/eLkVCbfHA3srqh2Npen4NwODObvJDCbNu8eAMpEYmQVu7l+WCt/jcCC48do5TVatke4Q4t0axXLd2Yio/i/Z87emeP//81e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381601; c=relaxed/simple;
	bh=zBHyaXbAzdQB5rV4j5r5Y+RdKbLnQA8XJlqY5xxNaNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gggdmh/TAf1k1Sx70H3IcqD9j4IXifiy1HyjkqatfaPQhdO9pFbx/9NVAWeoYvKzLxgwbBaOILYG1vqYsO17kUe8jtKiTuOVDDHRVJihmfFTG5eSdQTJUt7xxzLRHSnpNUrGLdybfNr+J6SwmqaAn/gLXcmtaYfnGFIlhF34sPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OpUxp2Tp; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYBqvrUNssqaYZkGmcfM/J3jpQjgSnHximyZ8HXngi1ds7XHdiz+Ewby2v57I3l901j8tk6RlXlUpajoJIaPrKWCLwQW3pqH4wFdRfGQ/pPQUVjOFsRnaZTcZt/q/zCH5SITDFbDPEkTcNv+z5H6lT/j5FDi/U9rUiIMlcB6usbf/VcFkZgazNwjH6zsUJuZehszPclFllw5X2X0ewVCqqXuC6IpDxiDxNm17CXixrGNOs8YCBFdPfLDFShqsuqhZAERFTt1UvGge3Do3fF5rUh+sllyQOhtVhp7viPp3CEa3Gk04dAAbwK/dbe7vuPw+avVlv+iqs1ohYmgc8TtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMEGusoFUTg7BJhz4MmV9LwpZe+eNcWmSzRRhqUl64w=;
 b=jm9KA38Sl4UanEHWa8zpQzkhOUV2Nw17IaF7LPQxaGFxghSkZdCSi8SXXz9AzeMvtAYiIiKbfepP3EQ3eQBGbiGDRdF3O6j/OdQHhVz9DpYGm6YT/jcp23WYRezbJIyeHVIu5b88mO1tXwpk3+Z/+Gj93/M5rbtuazThO79/pyucylo8JT6Ra0gwF/wFH13rPhDRnkeE7Urj3YlUU20DqYQCTtlZTdPEne9589P7sWGeeClkspP2dnjBPbgI84Be2f79OhYfcfZW7bF81RiB1QLUX+7oCb30Vvv3jfmKmLOXvijMXrl2EIPkFUDiCUS+28Xi7rRFPVjpPbAFaQzeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMEGusoFUTg7BJhz4MmV9LwpZe+eNcWmSzRRhqUl64w=;
 b=OpUxp2TptZty20BRpig94t45epQr/B13a2aMzkakocwx253Z9RFGD7fjoCdHEt0n3zGBEr9HKPRxucy8TAVLrdlNE8bg2D3QFLl85IMDSEQ/MGtoMnFYlMUBNKIsKwzdd/A5p7XbNrJ7P9dV5E3B6CVwFtY5pwObEaJKjFwhSQqnExdjO5Ui+08RiuDiuj+0jyk7zgw3nBU7SxqS9BRt3oHYuzCsrzG6x0E9oXwtaWXQDWN93qiUw56g3yEuaS9cVkGO/Z3zlS01a2bTcFrZfoS6FDo+Bga4sK6MGFBGgSzgcXvLcYa4yqQk+VHWDlW5jP4axtw7UePH5rvx51ac0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8540.eurprd04.prod.outlook.com (2603:10a6:20b:437::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 14:53:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 14:53:15 +0000
Date: Tue, 1 Jul 2025 17:53:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Mark Brown <broonie@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <20250701145312.zx56ji4vvaoxwzkc@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
 <20250701135747.mns6emamtmxwgpyu@skbuf>
 <3c3c912c-1f33-4f63-9a37-fe4db5d23527@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3c912c-1f33-4f63-9a37-fe4db5d23527@sirena.org.uk>
X-ClientProxiedBy: VI1PR04CA0096.eurprd04.prod.outlook.com
 (2603:10a6:803:64::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaaae25-6ee1-46d6-c299-08ddb8af0201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YrcqlqEOSWC4FNgHRwLxFo1A9eMfRBYf2XBOrRlcMhdfdoNgrDipwBYOVNr?=
 =?us-ascii?Q?l0KQRnqlBBIv5JNgYDXQYk8JLTZY78d6A2Yj+Kfoda3DaRlUJ2ppZ+ep8k5C?=
 =?us-ascii?Q?2cUZXJqJAVAkXn2sAN0eV2b2fNEdoD1sdtUBC/078Z47kwgG4Bpw9+MLlOeS?=
 =?us-ascii?Q?Q/XeYkc6knThrovt/ivhs7PjARLgvOpnWFh2ocpky+asVW2K6uoktvnBKfGl?=
 =?us-ascii?Q?hnpx01L2MpGWhJk2RCcCaVkyimH/BAsY1NYLJ9wAHIGDek+QbEJ8ENZQafZX?=
 =?us-ascii?Q?9bEKehwE9wSmd33ZVKC+rOWqPhuYg3t34UaIFkoFrhvCwvel/wsXO30J58bT?=
 =?us-ascii?Q?cObeJi9sWuoLBbGtOrzcQ8u0dDO1r4biyiMgQ6w2oYck/v9J3STLhRl7L4GF?=
 =?us-ascii?Q?JkX0kHjOMD5CGmbjRBZdNmLQoy0o/2rG9cvI/4fJsFNPtnMXOQEL6Nk0ec+P?=
 =?us-ascii?Q?Aj7fGq03PRehEJbiKBxlb7+BQt4aNtXXqOT7QqGlgzQq8zBmi2Ah+I4NrEc3?=
 =?us-ascii?Q?RG1O7BKwXIGdGRJElf95LmMetpqGDnGR9Esp9lxJ8ljz1S4lTK0feIlA85wD?=
 =?us-ascii?Q?FRRo/cpL2wNUJy/tuVkGItHTU9PhWwAztQYTbjWFyIIduBZcWESf31H7ozWb?=
 =?us-ascii?Q?lz+qpH1ti1x/jSXDkgJS8KSmmwi/E9trJvFPOUbdXrk5V98tm3Vpv/ySEKz+?=
 =?us-ascii?Q?4RzDZdvapSAqVxLlDBGb2txGW4FvxV1jjFb7l4vIg48yqlRnL2GJ+dXLYAiv?=
 =?us-ascii?Q?Wa4Nrmv3JbYa8SICG8gkNppJIubwA5Ji017mtQcJRUwzl1+SQctkVn41YU0W?=
 =?us-ascii?Q?sH45ELylZ76w+xeEDTei5uxX8i9jpdpX5UogrW5MyUlWiECIh1fafDmSMtD+?=
 =?us-ascii?Q?2GmOkJqoJRcPxnsKCLMhRZjrbPEtNbhZx3+mqIjiElL2ARMz+Y9AkssXMDPp?=
 =?us-ascii?Q?KS6DraOFRoV+oRUQNwKqz2W/tzXX3PMezYCj+kPjD8c3KXfZeDf70pLJe7A0?=
 =?us-ascii?Q?H1I8Q5/2jICgH5PP7sgwo6z49SDVFIrqwFaRr4AB/dQWXbGDBM+/ppX1Mw9C?=
 =?us-ascii?Q?CePaq9AsNslBUV1bQADt4Wv8Kf4D2XCSOhxjpFnM21f0RP/6BT7kfrYuE5zn?=
 =?us-ascii?Q?GYgzGrDdrPLclHkYqriShs9SB39HrF7PQEFAk0qT2+Li/JS2TZ48qGiRD/JE?=
 =?us-ascii?Q?ASqv4zPbg1LXBD7gaNqHeLE0JJJJme6JeMzhxwt2OY/8j0RXAyEzR5ATyii/?=
 =?us-ascii?Q?wzkeOPQ967jaEQvQIaJXlODM/iSpWr7xRn/MtnViETNcxxFrCzP60/yKIz7d?=
 =?us-ascii?Q?EG9yc1ROK/khKaeBMub3CVj8z2WQb8uI3kFx1skoITFuTbKbLTSb/geDfRjj?=
 =?us-ascii?Q?NcSPbpJqcPhQzPnuI6PfxeAfXz6vDxqtXD5Ipeh0sb3izhN4Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IaskotlPSrVjOLFr42kl6s/Mk+MdWkqxdyIbRgYBJiViIKl+fYLj7VGdPgrJ?=
 =?us-ascii?Q?Y0xqy7HW0dcb4ghe8BNpQzUwZsvKwsKq4AzwpGa81mW/CC0bMo6kZxbCy6zK?=
 =?us-ascii?Q?1Rrq9IriHsulI+GX6sF0fkKCPm50VdMUnntIQN8Ov9vbJBA2Zu3pUfPgB8eM?=
 =?us-ascii?Q?QNCbPzYStu6c6WRAU12FV8Odoqso4r2Ngsgpsq/Rt9YY9sNQAwosfpZJm+3T?=
 =?us-ascii?Q?oFCPXZgD3dLKBjYoF9xBTYpoTNT2XtVtd8KJ8YX/oMpjqiDwVdjGuTd+z7pD?=
 =?us-ascii?Q?0hXzw55C0rsSsQ1hO6Emjk+ZH9exRHV/XiLrpK/RXagQYKRozTQotKQmRuLu?=
 =?us-ascii?Q?ZfY+6b2MHHp6zMDk6ZAfuytOBN7jlJlFvChGuXg34JvEO0PcVsTqQPbLBHcO?=
 =?us-ascii?Q?2QEtIg3Qab8Z0Iv7fCVP78eZCficiOdQ5kGE+rpA3ho82vKIhQ7D/OrHROy8?=
 =?us-ascii?Q?IGmPorPv147rAvjihOrh+cSMGhWtauzNQtBSZVMsGxQautwfiu0YY6lwI1qa?=
 =?us-ascii?Q?oz86B7hH3LbW0lFpbmmFHc9bx4asPKbjQS2ire3L/MliXg0zWkEy4k0Mdide?=
 =?us-ascii?Q?aPou0/Dr0URakI6tRYUqfQFryrOSVy9rN2PAuZ4t8bOe8wUVcbY//C7nnb5j?=
 =?us-ascii?Q?lkzMVAg19AdkmKgE0D7wMngJWHZ7Xqi9ZOm3gTEnKNkNx7PlcYlq/68G6ct1?=
 =?us-ascii?Q?EiGsmvEF57jt+A6TM8AM8ipygrDQeE9K5bowHtLjQMcKhBU0DS176CUGzz0o?=
 =?us-ascii?Q?TqBZv2GMq+FWkZaxlYNBJkzd5E9YYk8Tg11VKX0zrv6BHkkDaoAVSjA9iZB2?=
 =?us-ascii?Q?NH0J3Aq/PmIkpVXcWPgfQfG3Fb22Kvg0F2jzR2Lgs4hlmtxZwodsAfO7wh2l?=
 =?us-ascii?Q?IX9hYVgZGqkIOdZArIsc8yzvD6oxco7h7oCJKYtrdlGqZ7t/JVOy7Mame6Dd?=
 =?us-ascii?Q?jzI2kChEBpa0nMV54wcIkM0rzixohVQtp9rzV8AbARFRlFg/N0qGDykjQ4V3?=
 =?us-ascii?Q?N3iqbXVrHstp00Ys64gPQ6ufzHUCeprhTXo7kO9Hv0RrZvL42ykCqrtJD+R4?=
 =?us-ascii?Q?euThxagPifC5ghmmyD9eI1ZlqlxArjK6pqBVpm0bibwAFOTQEuJ6NWiO5AHQ?=
 =?us-ascii?Q?1r3dpIu1qxQgTiNdg4Pc/3K+wG5mh+yveYLexafIl3N9wCWRh8R1XaOL7dBJ?=
 =?us-ascii?Q?yGWfMD64EKmDaq7oUU16dXzm6gJ0CLK/zEezmUfvENhOWRu4VEiTXx/l/Zeh?=
 =?us-ascii?Q?Gt8MheVO3XnlEpu45HSjlxpNJn802HwrbOJVUQMWSsM1eV44xThZjsPq//F6?=
 =?us-ascii?Q?Yh2CDO5r3mNrMHOp+uavrpkLAT+nHVKeayMSqumDeE17f+Kleiw/l4RVm6oY?=
 =?us-ascii?Q?f669YSArTuZziz2tZ/vSMLUrDV3UMEO6ahzBUPqPTLE9Yn6jBpHSAFWRa9Bp?=
 =?us-ascii?Q?3BLccuhB/7llpcGSALyJs0fAXzjrqm/YyGdixKMpY9szSrqlUpeAQdbvDf6a?=
 =?us-ascii?Q?EJhzxaOPRbkCTbbDUXWyRnYW5q+yVLs4y+C/hHhuE2RqDLQ7l4Rr124sZnxA?=
 =?us-ascii?Q?cMMSSwf+fw5AIFVw2HYkI3LujryxDyu3qwqh2DIP7FRCi0u1QlV8J1QJ4juk?=
 =?us-ascii?Q?kRdFY4oO7KtPF/teNQvrejTiyb+njFINZG6pd22P6ERgF2doNlANrpGCFv2x?=
 =?us-ascii?Q?ob2lqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaaae25-6ee1-46d6-c299-08ddb8af0201
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:53:15.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb7RpL346t0bzk45kscY3oa7vK38BZ/3HFjyxsXccA/LJikKSlXkEhpQ8QUB0JLjq0O1dnN0Rpdp+r4Qi0n/mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8540

On Tue, Jul 01, 2025 at 03:36:21PM +0100, Mark Brown wrote:
> On Tue, Jul 01, 2025 at 04:57:47PM +0300, Vladimir Oltean wrote:
> 
> > Here, the synchronization offsets in DMA mode are an order of magnitude
> > worse, so yeah, initial enthusiasm definitely curbed now.
> 
> > For me, what matters is not the latency itself, but the ability to
> > cross-timestamp one byte within the SPI transfer with high granularity,
> > and for the uncertainty of that timestamp to be as small and constant as
> > possible.
> 
> This is sounding like a copybreak type situation with the mode selected
> depending on how big the transfer is, that's a very common pattern.
> I've not looked how easy it is to flip this hardware between modes
> though.

I suppose one could try using FIFO mode for transfers which request
timestamping and DMA for transfers which don't. I don't have an insight
into what impact that will have on the driver, but I suspect at the very
least one will have to transform "DSPI_DMA_MODE" into "dspi->dma_available"
and "dspi->dma_in_use", and reconfigure the SPI_RSER register (interrupt
routing, to DMA engine or to CPUs) at every transfer rather than at dspi_init().

The question is whether you would be willing to see and maintain such
complexity increase, when AFAIK, the LS1028A FIFO mode passes its
requirements.

