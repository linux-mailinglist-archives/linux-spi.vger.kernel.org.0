Return-Path: <linux-spi+bounces-9878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11246B420DC
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D457A1BC0B23
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 13:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78BF301025;
	Wed,  3 Sep 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEa5MPx9"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339F3002BF;
	Wed,  3 Sep 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905495; cv=fail; b=GHlF784l8yojKgQX025Ig7/soBCmiiL6SYuyzOtevFnznt8KfUURgmv7KjW19/8AKE5xANs73Am3mO1U6cSDKZ9UWCEmhqzapeKcYcPEuLN0UBCMNUQGAqD9r9liEYsXONGmio/cPpXY75hxXMmoZ1E9+gYPMeTVbE80Kk392Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905495; c=relaxed/simple;
	bh=8VD6j4T7khWoi7FgxPLZumgNg+DlUnRoKt2J7DTSJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AAGoRtN/MFyrJacZjaj3Hq7v0GCwIrANdz8KgT9NyaNlgqmFJlCfrlce2ui2UhsywjU/MIAQ2gqYcHR4Y+Xq4AuGfwuPvauM98TptFbAcFis0xowsXX/JwfOlTFYZbS5J9BnKj7DbOpWDoex4F/DJ40peU84QSYTCiwh1w4Lp8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eEa5MPx9; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RluKRzFeACmYcHrPAE+1KrgfSsGsIz5LdQGg20nghS5SvwDNfebgFFJqTRP60mzFiszdEBvamB88FIMdnIzHJzDCYSroLwu1EJsq9Cfhqxu2Cxpzh40aeOsnYXlIUHdnfX3DqbBUFMmznwQacTTw9QJ58IyIihxIW4/FFCoIgPtOzPhgeBMaXDMEt8EE3g55Cx/3FaQMs3/iwwwr91h6Vvtf1uEVs7pQ9egrO9mQgfQTf8ek94YWpdtXfQ1Xhv+xv6s9JK0NLqanqhF6N2wvNPYYZTXVsUX+F8GzdhVXpWdvBBoGCzunJ9SBE/gY60kpp7KY9X68TQqkiEgTqyl24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0UcQVLV/+ZpMicp0TeK/Mqy4t1CcsZvUq/FzFB5vYI=;
 b=v2ysaX1pdPWicDHPv7jVQyfPkrNHKa2cfYwtFlHhnD3b5qajk67nmKB6pteSEqF3D3VwwYlpWyOMx0CZ4c+Qu34g5o74K7DpjGZq1KZELHnswpH98QZOTdlRpwCoBIblJjDIVXhpUshkmdxr6QmbdHLTQaMLGqEzZqDzbzbSLrX0E6lBWSzCO1RsqF1BpxjTLJazCaO98PigH2/RLHC+jrMVI2HmMQw4gNtQt52wXds3lQ82jmyA28pV0ZPeRAWLFh66/cIl1iqtEzmuN3/a6d9BOm7m1qZ11oisnxeiL0gGylxLOyscRvt6RzDyzichgAZBMTse2TRIevKzxSw+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0UcQVLV/+ZpMicp0TeK/Mqy4t1CcsZvUq/FzFB5vYI=;
 b=eEa5MPx9b2VSIR+LmV1IR8zC2rjYb6KU7v0Na92J4KJvTAHc40envohg2fLfJWSA8YvjxGTsuLQU5KHgYZ/Jv1b/44W5lDUZrB5j8h6baVb+1Y6ci7s3SPB68DDAGqecRuUNfuH2sJfBsHdaPuvy8bWow/V/fHSCMm8eHEPK9Q7MLDQUQYAx+QRmQQHVybeWZ8h5zlQHHUSwCi3A3RUK9YRocSh2ooozFWdJ8g0ADJbrOJmk1zgmML/4RNUp414ozFX6/LP+gdngo5c25uQB6iycy9RfT3srlT3cvECQfh4o0YDBGYGqgJ3jwKh9hJZukgjOgKAhd2MQaKDwVAZCYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 13:18:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:18:10 +0000
Date: Wed, 3 Sep 2025 16:18:07 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <20250903131807.cou3u7wa3e266yn7@skbuf>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
X-ClientProxiedBy: BE1P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::6) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 4131018a-a990-475b-c543-08ddeaec5407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSzjjlp3kHTokaFfle0eEQE748f2GuL7Tn84UkfblNQiOIvRNMEn10HQPTeo?=
 =?us-ascii?Q?OMtMWLE21lToNC/PsHn/yodbvndfdx4/QW4j7+TVErMqvRF5oUribUcULrQq?=
 =?us-ascii?Q?WIBALtDnRhYGItC5q3nvId5Bl+uV50NY5adsiZu4vrPCYG5XejjIzROdC4G2?=
 =?us-ascii?Q?kpuXPVI8FwwypyS5Hh7fqoQxw13ILWDHV8WZPDWE5qmsF+6zEkWs717KYGBu?=
 =?us-ascii?Q?+3c7UaeJrOWKtC5Wp7HJFq9GiXeyiF87yO6kJYOszgvvwC3ArLXqpTO/9Jh+?=
 =?us-ascii?Q?pGQfXAgAArGaakyjzP2xvGai2g1jRZTKLt6ZyJyprI/rGGJTmEUAoZerIc/B?=
 =?us-ascii?Q?5zL/7ALlS/lGLnHTlveqrWO27GqIScPa2PV+VZyZMJ2qBTCRtKTSMHBdYtx2?=
 =?us-ascii?Q?26Q4ctFndF0uvD6t0WPkEzlFEOy1n+tC8DtJqabbB7FuiKshX19fN+ukb9qn?=
 =?us-ascii?Q?YLMCjLjwIdhih4C2/0b5PM5UFosmCc6isJbbmc/Imd1rpAUaZNEdbBAdRYAI?=
 =?us-ascii?Q?Vc9e6JHpB9bBXv5mw1eZxbwbOkmLRxvaRKdXYyD85Mb1Jh/8pInaQ5t7hqMS?=
 =?us-ascii?Q?TUVQ4YIMZEH3YOiZLw9U6V2VDPmSuwwrdGD5EMRdQ31uJxBMfVlzBtrBj1yZ?=
 =?us-ascii?Q?0N1egHXb59MJUg4ZUwor/ROj2shJdwZxozO4IGsagFKD+w2FIukRA08XGTPh?=
 =?us-ascii?Q?wNmLdT3K98zed7Zl4vd9+AiLgisY1cDjUGMnODGoHRB7zZZKmROEa4VNFeIJ?=
 =?us-ascii?Q?kSTQqDnPzMpKAFrC6msJ7wqnlSPZ9p6dGutkeNpizJTPtAxtQFIwfRiiZhr5?=
 =?us-ascii?Q?Y+ldWNMa1g8H04MdYD+eT7j4V2eLXadTKDSTciE154n6xW84GvzZVWYXO6JE?=
 =?us-ascii?Q?SCikx+ZDxYe2H/F+/FL6pXSbVuupiPi6JIYYhvQW52ErYtTFETcVsg1FUFtW?=
 =?us-ascii?Q?9Oft40uDKXBQQEIx0DfJ5xa0X2zq7ucXGTjkp7SplHHWkXVpXbFj5vN5Xp6r?=
 =?us-ascii?Q?Qt/nsWTcmBlu7RQVHAOlPu2JdMtvnGws2rjsyoeucZPE2hF/67PRlMHbZSXU?=
 =?us-ascii?Q?Pmo0uRPscq1vZSm5hF90kNxcpzkzEuOSkT20sGrgo4skXVc7Ay02xZzSQtIE?=
 =?us-ascii?Q?DMuFkP2Gsje/FT550YkmpInmK5wSWGrbt1+bZnC0Da777WcSCrN5rhiKrwS/?=
 =?us-ascii?Q?j/4VbX6jgheuO60uvzyGTGmC3LHLEDhEjkh7BK3X0ZOGOUzhTkWNWTjc48Yq?=
 =?us-ascii?Q?VCcLDpgmCwE1m3ca6IThPbNb8UVE/DHKZNG/iPmexnKFIz0Ez6CRLmNoeJlg?=
 =?us-ascii?Q?XTaGBD9IaLX6W84TjxBL7C7EF3Mqz43sb4QTVyi9TQjPZid7osHkEoHathoo?=
 =?us-ascii?Q?d/+V8iGeQS5KBZsbwhOIiV3IudZGtHOI/1BnG0bu+n2cg7wUWizBtl363Gna?=
 =?us-ascii?Q?0rWuUtcbNT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66wP/i3Dgdz9jgTIBJO89hm7beE9jtjfu0Xtytl+xdm7ERRaGqvfoSl4zpfM?=
 =?us-ascii?Q?ac/qNuq1B/30+6CTXyjXRtN1aSjeg0lpPtrsRBSulXw5CEs7dYq9ZZdWB3WH?=
 =?us-ascii?Q?s1uINlDan2WBx1hz+0xRtxq8C+EuKA6XQ3oHniJEJsrC4c7nwg4ke5i+4FAZ?=
 =?us-ascii?Q?utBp3wEOVHayCb3yUL/NRWOWUdBYF5v+q+EfG19mr1y7gCXR5SiWc4wFh39+?=
 =?us-ascii?Q?iCxVNmu/tIiOLxd7tuB73rdvBz+P42Ou9rk6Gwa+DPJejukzirGcU0lzgXhY?=
 =?us-ascii?Q?Wfjpmi6Pg7KlYFpEdbdwxJHQOw95CwnM2bsobtERcdtBm47SUy2oJ1xM5Dbt?=
 =?us-ascii?Q?knT3ucXgDUZVWOCe3HHeuIG+TAgQs8S5KWiIwop2UtMWLGlVCL622abEMSkk?=
 =?us-ascii?Q?xSIm2qi9foNzFrxbJD0/zwaTlA7xLb1sn+P+yE3v23lx95GCkv6JucwDcGog?=
 =?us-ascii?Q?O4RoGcwnDjG9vaxw3E0oHLB+ku4Yf65xVF2FYwMa3DuwA537nJYRIffjJHbw?=
 =?us-ascii?Q?eQExVjFmSSlNyLsOoSxxnzlFXY6eyILpNioTHeMWgxBkvttyBLKV7cS8/pLk?=
 =?us-ascii?Q?c5QcSUpTJBD8OkIXdpQEaStzT0mjxsoc9+4F2p4B21tydObUwdONAF2iihwC?=
 =?us-ascii?Q?tEx8u4pw/mDIW5zSve4He687Er17kP7NM6Xa1+Rf0lE2XJ5Id522SfPWjb9I?=
 =?us-ascii?Q?hulMZAAYnCAnKKcT6Wg+zn5eNzzqNexwXIbYuaf7baeR6C1Ihdwdi5LopJTZ?=
 =?us-ascii?Q?l4W6qMdVb/SlXFf9An4S/MIQYAK50H7AUyjHTTFY2G5PlC0DpvS6PaO3fhls?=
 =?us-ascii?Q?NYjZ2Ie1+3nOZHb/BowHQdAnADrcCvrKlzIFEfY7aNNI/79Cq52vhs3+V49L?=
 =?us-ascii?Q?cVIS5BEXlw2x7dTcpl8kEZchwyqGiFYPqoERUqIGVxVJFBVnnhvXEoR6yqVi?=
 =?us-ascii?Q?sKqxzBY23vYFT0s7sJS1gSIFvfHrPy3KGxHnQfjOxheIHyWsSavtOSm7AKZi?=
 =?us-ascii?Q?B6/luSBUWIaE0bFwhP+p0K9+kr/yjBhezA2heBkuHZfNLUs9btFviWERfAjy?=
 =?us-ascii?Q?QhTvM9jFatzoCY24T/o2Z62pQAy2QRGYg3Lx8joDz61qzepFJQBHxku7+YxX?=
 =?us-ascii?Q?4KbaE06+0oyDkbSl0yxzEnH9QgkZBi6yTtA3kpyVDPErj2Vq6Vax+VqBLRSW?=
 =?us-ascii?Q?6e22nZdy0vKik81oZ1epXMS7kmwePqyrLvJjEzCUF7SO5Iuveylu1Nur+eG2?=
 =?us-ascii?Q?0rHfS57pG/zwJMlkbrAe+EhhGiaHVWYEa7lQq2JqRvVmY8AlNeTYCH2ttexY?=
 =?us-ascii?Q?cr7ygUueoPT/Yq/ICIavHZOYSo0UKCh6IzxJsOZXY9Pql7A5H3yzNG5fLrFF?=
 =?us-ascii?Q?2Tx+CGNSkWjmaFhbC5kromceVtK3uX3K7P2PQt0JjIMf1Q7b9sIGnyuoa221?=
 =?us-ascii?Q?aVF4bFN0KFFbM12pUp6NNMbP1g/9wMgy8Q0sdmnfFvkOlFd2uQOD0Zvjs5E2?=
 =?us-ascii?Q?kBTN32+bwm/6HsbGW/tUQZO59nGLdPGDpLiH645eEW+j0/em34K+cRk3N2fX?=
 =?us-ascii?Q?T2wvaNdPKy9v1SWUsKCFzksGFq8JWL+4GPUQ4196RgbuNwRiK4LqglV2qtMG?=
 =?us-ascii?Q?T0pnzhMdasjRHtybpRFj3I/opGnDg3dSRqLtijKNMZtTRFW2YGR6D3HF/BYk?=
 =?us-ascii?Q?U51GHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4131018a-a990-475b-c543-08ddeaec5407
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:18:10.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muw0dClIor9RyGzimgcKwXP5UBSgOO23lU3UTyeVYxUkIlag7IcKm51GiUA0JFeridxKirUeIxQ3NnudG+cidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

On Tue, Sep 02, 2025 at 01:44:52PM +0100, James Clark wrote:
> Improve usability of target mode by reporting FIFO errors and increasing
> the buffer size when DMA is used. While we're touching DMA stuff also
> switch to non-coherent memory, although this is unrelated to target
> mode.
> 
> With the combination of the commit to increase the DMA buffer size and
> the commit to use non-coherent memory, the host mode performance figures
> are as follows on S32G3:
> 
>   # spidev_test --device /dev/spidev1.0 --bpw 8 --size <test_size> --cpha --iter 10000000 --speed 10000000
> 
>   Coherent (4096 byte transfers): 6534 kbps
>   Non-coherent:                   7347 kbps
> 
>   Coherent (16 byte transfers):    447 kbps
>   Non-coherent:                    448 kbps
> 
> Just for comparison running the same test in XSPI mode:
> 
>   4096 byte transfers:            2143 kbps
>   16 byte transfers:               637 kbps
> 
> These tests required hacking S32G3 to use DMA in host mode, although
> the figures should be representative of target mode too where DMA is
> used. And the other devices that use DMA in host mode should see similar
> improvements.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v6:
> - Indentation fix
> - Fix trailers in first commit
> - Explain reasoning for "spi: spi-fsl-dspi: Stub out DMA functions"
> - Link to v5: https://lore.kernel.org/r/20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org

For the entire set:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

