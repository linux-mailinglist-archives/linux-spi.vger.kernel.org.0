Return-Path: <linux-spi+bounces-10837-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D04C082C4
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 23:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A39B3BB84E
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA5303A04;
	Fri, 24 Oct 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XRLc2Vud"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E22E2EE4;
	Fri, 24 Oct 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341066; cv=fail; b=Cjoq6YiArP+/tQZtR5Se8lI3pL1JeLWjdco+cePlm5TOikZeMyVL7b6EVFYgRdjgo8M2AbMekrv66Wf/PTaxGeFDI09Ap/w4DaYWyeelJJ/4ro8Q3bPvBfW+M4YmJRyXWMyhLVi0XVn0qXFX/T6bQlqJQB/Mt0SoBpzE7IUYaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341066; c=relaxed/simple;
	bh=QCAvGpMLczRePudt2sh+oJdrpqxP8n1owLfjf5XYb4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NF65B+ChG2mjoFgvSw80wPoaD/ekcodFWlRTZ1u3R/1cvSHrta3ZIb5lgts0ZHDJ83uMF9a6JBHmfbmfaIQrP837lgSIt0zqWzmweBSi5g9pkMIMLYYH1setRFnjRT0W/LW6xm737E/mS/GAY2JnNfcgMIHL6lrdcGETLDgUg48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XRLc2Vud; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEMpSR1cG9x/3QkAJZ0QZN2JXwEOc/nfBrcHkDvEbbvWnuJ6kCdjxXgGzis03DuIRMVwe9UXLk4c/qHMGqlEfJiER/tlutkOqDUHKkoxW/wxG16y2Mp6G3ZvCFg4Mm3MZeOcCFUo35gIysIZLTbkm5FNkF1QVu8HF8LcDPn/Gz5USbanhHu3P3x8j0AXG+NdXEsHawbvx663S36Eu/sDUxDDZxbDioL/qfKmeFVeQc2+CRwGHXrFEWAoWVab1v0tGQ8nHIOgP+WoKWn5f1ilmBkdVzh/QLO4Zt7mX8xmJDRcy1NCtdhG6QWdFkZPKVP2Cp3Dpwfwt1H9RnTm/s1E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEOuue7zD0H2l1RjyvEFtLSjH7Pcrw28LbUFRijSrCk=;
 b=lTj4AWZwPkPm8ZTtSE31tD+9gTC7ogky4NPkrzpgONEegXbKAm74+Rl+QPH5XiUci1OsbrWPUvloGv1qdfkQlST/rIAmmZIc/N70nKHL5nmttIXsQAUhX4SLlSmBbb4FH5BQmvpP5dURipjuXPhUE03RzmwIvEAkOgC48JhNKdE7hVgQAdI9xq+K/1ORMHM7C7+7//lwx4oA4VRNNLafpBO9d2I/pXrM4gbLu+5rmDnn9o9KXu9ipBxLkzFx+B+ezyI6n0xrqmpIMH9ykhHRp6YTTDv92KaqO2CQhbGYASaxemlwsBmkrjj8I2iO4zanGSjXR3GDSJ6jXC0p7Pi/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEOuue7zD0H2l1RjyvEFtLSjH7Pcrw28LbUFRijSrCk=;
 b=XRLc2VudcKRNCmhl3MgPKB2ZfrJ432cEw9ST3JZPcIVczaHbSpVOznO1BDiqyJtsTquoIE0DCdoUsHgq23PwD4rBJNA4OjicpXR9/UExQgohU82H9lQfpT6GJSk2ZJfPnefTBjEDSNiSxbfXYzM8akxzLQ9bNPYHJxasMdgpJeJeXW+VA01W71OsMra4wM0PqDX0TanLewfYFk1oBYqfgby1dzpMs9Sl1ARd5i4RdsAXOOWxOOoSD8r6m8/fxB2lfF3+GFSjQTZ17/g3VpmT32hBABPrQVeduMWU7vqMe+ZrnemALHmAvjfG03DZfKjSB7qBuCbgXbK3YwPfXgkmIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:24:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 21:24:21 +0000
Date: Fri, 24 Oct 2025 17:24:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] spi: fsl-qspi: switch predicates to bool
Message-ID: <aPvufqRVtkGMVdR+@lizhi-Precision-Tower-5810>
References: <20251024191550.194946-1-elder@riscstar.com>
 <20251024191550.194946-5-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024191550.194946-5-elder@riscstar.com>
X-ClientProxiedBy: PH7PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:510:324::9) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6a61ec-f9f7-4b45-8ac0-08de1343b2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?co/7ghWg7QMNNX+5eMkNXdrpjnP4dTLDVpTZ3tJFkuULQQBDdAjPZ8dFXuhi?=
 =?us-ascii?Q?DST7VkWy9OMBuOyjXhwSYQnsayPZcPwoYbp7z5w105+ZAnnnlHU+uVdR7Nrz?=
 =?us-ascii?Q?OmdFrL2znqcpsJZpbYiDN87S9vGlrsAG3fI6OHLWhmWJK0fAgD/9PNO0MH8W?=
 =?us-ascii?Q?Wk5z4HCfPlXn838mA5b8PN9BeKJ+yptucU709eJn5giVSKynvdv/RwBgO53X?=
 =?us-ascii?Q?GaanXcz1L0WZXQDG9tZrCPylhjaytywLQ99KI9jHv2xX5GAT6vPwc+TSsb/d?=
 =?us-ascii?Q?qNGOCqABS7kJcssmG0YfHTQrirMDgGdOIsDPVdDXNmM909i+PWED9djQw4C8?=
 =?us-ascii?Q?79OAkQL5y9mDARbvIMuh6znN/Aihim0MJIyYdIRbfWEkgjDiT5+ifu1zJb8j?=
 =?us-ascii?Q?JLAX5FXKXaRwbxAxHQmcIjj6VNDePeXzdJ0rT/Yb357paAbDy3wQReeJaxOF?=
 =?us-ascii?Q?xplwIpkSbTWV30oMMXA0VVGzA7XD4hbmSdSPxMJFU39iR4v2WWjZi5LuwFHl?=
 =?us-ascii?Q?KYkQFMAasEYx1AYWximPbM1qdUnkM+cWHdq7ZybgXUVnuNS7J8JUXs/CxbCh?=
 =?us-ascii?Q?u5iSeCTi61mHECuOhbKcYKV3sXHZ73zNTr0UPcrZXp383ELcaX4ZR01YM8eO?=
 =?us-ascii?Q?xN+7GYqxmIvCfOQBWHH8c1L8Wov3wBfKPyF7llicRnTlAOaxG+89D245ptNP?=
 =?us-ascii?Q?Hvi2V7QPYqKyegJIRnRxivQLyjUTO5RZbLlvMVlu4sVS5G0thVT8Ffoi67+K?=
 =?us-ascii?Q?sxMvKS/pKVrKaDv4QJp2b2U+RaJb59msG3u0DELVWSUT5Jazvf66aFgsg9qW?=
 =?us-ascii?Q?qQcU1vv8rFOFSSwaD/hyybu+wkxMrD53987vMYWLNziOwHZu4RwN//IC5OPo?=
 =?us-ascii?Q?4qP1GVevLck1Nrojf8O/lxlDtbxmZQHsv1qLatxCbX06LCYOH75icy1E3kYI?=
 =?us-ascii?Q?491i0YULEPBBnXqD0jR93QeAFycsSvAHi5RD8slixXB/uPRt2mPAJuSpKVxa?=
 =?us-ascii?Q?VKAgAZxXF8OySaSDdR/FUWaJwYxhi4ip/AChO5ROzUNvZP3CeBKwrAc8pOQ+?=
 =?us-ascii?Q?6cxSIfprr8tBfAwMku9WQwsUTyS5ZlZUSQ6zwFhTGL29JUObRtwceYmI7Lge?=
 =?us-ascii?Q?f4biUNkRXfSlViHs3WhulwJtMKZCTDQG6J989mv7RksASboMxZclaXkeLej/?=
 =?us-ascii?Q?u6n4QxsiFCQeWhukmbfb8hRkL8Wsji17I/Q3rjcib/a4m9IuBpm/j4Hjlhim?=
 =?us-ascii?Q?pzxSpf5wVF8Zie2EBsA/TD+veR46s67bT+4lhLEfDqLR2+1mhNiSgcGPh3W2?=
 =?us-ascii?Q?tfS6iG77Hu1EgtHzEV9cOJelXiB70jcnKDFp8mBYliJ6jU/EVMWPeLrL0iPj?=
 =?us-ascii?Q?5l1T/wAP5Ebmx8zHdcQDJMqunUCbykAvF6N/WYmr9028H1bhCWr7bXiU9A8H?=
 =?us-ascii?Q?8Qjvfj0KAOEyfEyxk6B27iF0qGtB3v09PKEXFIvuwbRCP2+EiOTzqkIkyIVU?=
 =?us-ascii?Q?03fOYODxSBKJfGXqDC9E0E21U5AlVfwNttrU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6ncGgkNXCXzxiTjPwh3hz7P9uaAublh+IQmuxlAhULzxlBe1CCgtLYh8O7K?=
 =?us-ascii?Q?xu38gxhq4KFz66j/b9DL8NDlSiaCKDL7ZpRdzo7PqJw6P+54tG/NnzCSrTpB?=
 =?us-ascii?Q?lVkDzez1k4KnxjUNOFLbg0oED/u7UgonMxOV5kUJIwsW8/ncyUHPGn8BMtSx?=
 =?us-ascii?Q?N3FgcBxwzPO1cN+9NtuAQkHE9/rQQQ52oxWurV1wVaQtYQXhbzv008RDzeIy?=
 =?us-ascii?Q?yiEfyDn429nP2LnyuO4vp2rbYWsB9X+Tb5grzgvTlh/TogI69eH27gWiWP4a?=
 =?us-ascii?Q?rbdeObaa5wjXQz4aJwzK34euyjrckQdBy6jMzQxtZXpub/2GjTd7jo4pRM5g?=
 =?us-ascii?Q?eC6LdF/I8Y4l8a8eAa0yeXB4poB1Xc/iJi05vNvYDw1cNHEM90os/GLqlHyX?=
 =?us-ascii?Q?KtPq8WAjHH1sTi2ngoZiq9GoyuuhQER1ibNvUL0QVd5iUjmXN8YquqzCB5UE?=
 =?us-ascii?Q?+yqskyIlyMKz2mjZ1ODIdMP/4NhR7xOtpilVA6XBzrOR2+jx45RPh5bER7Q5?=
 =?us-ascii?Q?KeNu5N7Xmi7g8FC2jSQLAqtGxd77rOuIphn13cKO0N8msXR9+IA74ynmFbA+?=
 =?us-ascii?Q?EmqZoSl5D5i36gFYOteP9aFk1lETqwZ3IIWzWQ7l2djqRoZUrTOm1+zh3Gdx?=
 =?us-ascii?Q?0WWFf1A9QxzG1dEzETfmCnt9ek0kodHlhbRA/0iZ4/6l8nmoX/SRInDkX/MJ?=
 =?us-ascii?Q?7nAYziolME9QYb0+NwC9I9cGE5W6oXc+xpBYESi+cbgiX5XxkK+6zZbVz/on?=
 =?us-ascii?Q?ExbKGTYgZXTM45c1diH+N7WX8f2K4TSw+m4TiwT3wYIHxgVRY2mdrc5ztGvx?=
 =?us-ascii?Q?MZxKObVbSoXoQD2VGjkm61KPrmhKISmudmuvfIJH94/zTyWukv5Y4ZrWxSIf?=
 =?us-ascii?Q?11pffcs/ZmaRTRyw81dHCFOfaEdoDWNPNZg7MX5fDGOHnOr+ryAsY7MsazIJ?=
 =?us-ascii?Q?9q7qaqocoMzbDvBpLxGotfH0Agz36nw9DE8Sa7ICvZkH7yro2vVjHKhhlIx8?=
 =?us-ascii?Q?/rTuiqYpfZUGS0FYC3zVKHtExrtd/qDXZ1LasLNrVVxB8yPavWKyb/DNCZha?=
 =?us-ascii?Q?1L1YNSlLr3RfO5osp0RnLz2Au7PxN9Y4AMNaHU8zQvnn/CHHbNer5zLvLzc5?=
 =?us-ascii?Q?10zs0wM/1y7QULsoOxL3mC9zZVqNDD+81VJ+1HOkJkKJ2JMBnrRI6CKyRLlv?=
 =?us-ascii?Q?999e2Pl5aOINKcwe+bgOwovoDG2tS3DopFk/aWcULFKeu1JIyShmgk+GnH32?=
 =?us-ascii?Q?70SreuSYmYe3BQezF91n+V0U9oyDiFBxUpZgGdNM7vCIrEMTjmxAq0y0tK8m?=
 =?us-ascii?Q?J8Skhe5WYyb/M29xjnlFEm2eq8zAQR9DO2Pm/7Y/EK560SMGwzhAcZu9guPD?=
 =?us-ascii?Q?T546Z65Ao6gKlN0EyfJXsKysSIRNMhs15/5Tg1Y72iBS5kXFeKgw1adwfuzf?=
 =?us-ascii?Q?Jicy0tNFi0eg88EEbvHavnlFE7ErmaXV9GZAqj/molpG30f1OuFf11DQwEex?=
 =?us-ascii?Q?KYZphibq1RFnrJZVO6Glae7NxvxI0sHAq25IaA/qRbsUoMpBkfUZD1wVdSv/?=
 =?us-ascii?Q?xSQZYPHS8TvSHT6a4zI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6a61ec-f9f7-4b45-8ac0-08de1343b2c3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:24:21.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8BL3BuLPAWPhdv3MGpjV6U8Qb/nB8RLTk0j2aV0Bc4Ez6vpEZ6UeT0XC2y4BJc6fyLjajmdjGPuRA8nx+Zopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465

On Fri, Oct 24, 2025 at 02:15:44PM -0500, Alex Elder wrote:
> Change all the needs_*() functions so they are no longer inline, and return
> bool rather than int.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-fsl-qspi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 1e27647dd2a09..1944e63169d36 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -276,34 +276,34 @@ struct fsl_qspi {
>  	u32 memmap_phy;
>  };
>
> -static inline int needs_swap_endian(struct fsl_qspi *q)
> +static bool needs_swap_endian(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
>  }
>
> -static inline int needs_4x_clock(struct fsl_qspi *q)
> +static bool needs_4x_clock(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK);
>  }
>
> -static inline int needs_fill_txfifo(struct fsl_qspi *q)
> +static bool needs_fill_txfifo(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890);
>  }
>
> -static inline int needs_wakeup_wait_mode(struct fsl_qspi *q)
> +static bool needs_wakeup_wait_mode(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618);
>  }
>
> -static inline int needs_amba_base_offset(struct fsl_qspi *q)
> +static bool needs_amba_base_offset(struct fsl_qspi *q)
>  {
>  	return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL);
>  }
>
> -static inline int needs_tdh_setting(struct fsl_qspi *q)
> +static bool needs_tdh_setting(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>  }
>
>  /*
> --
> 2.48.1
>

