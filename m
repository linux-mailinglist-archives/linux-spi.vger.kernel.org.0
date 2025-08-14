Return-Path: <linux-spi+bounces-9438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1AB26ED4
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE094E1064
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE2223336;
	Thu, 14 Aug 2025 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eae7zx/d"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5F21A44C;
	Thu, 14 Aug 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195971; cv=fail; b=o0ALAwVqhPjrYxK+oiUV2mSHRddcdQgkK+GH0dKkIcxCtxWoQZGQxC85PtZqUGOsTtVJN/f5CzPARKQHmfGWwHQjYkf8d7N8BgBOlcaaZh4xS6X44Kx4UMH36/Bg/qIQDTGklHCsVrfoTcWzU/mx4niXgxDRfE8fYT6CU/fmLq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195971; c=relaxed/simple;
	bh=QmfGkSqUyQdlq3qnGNPKemU7Yrd4PKBIASXKcZhdQQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KS3JkUYtG6X9FqFC1d76IX05Zt/4eRJegUKA+SiWqw8YKmEqNbO13jVNbqBU0gyWC9PRGVY8+pGO6DtN5ZS/vinB4qQ8/Hqn0vvYvkAJNwQt8+KTyMMJrSad8x3wcFz20p9NV8msyHkwNQMgS88sN7MTyFznGoG0qc1clBOAbPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eae7zx/d; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Indn2fdDdVSIZ76rxUbbHXnFucKlF95NAs9MyDM9K0F0Otdxjt80cY2lRxmL1dZEqNlS/+mt0VbAm/zOJmSwZIXrORoK9zIw8iA9T+nVF43MZDUJBH4VvWic2+1CWkvipW9Uqv60Iy4OiEMAjAGwsMGsHTZU//uivxvCpUkCjaKXqUkLECAPnGzi/USyt1J/sQUqh+KAiDQDgRwjiCArjWjRqfKCtpbqUzCTvXn/XPliwAb8akbzlsONn5kFO//Q9hYdAEbTFpd6g+mkUfc/GUj6Hu44ZdDTFsNEDdkM0WuEHBYqXzhpJSkeU0+I8tCHA3lTkDhPB4ZqP21ZsyLxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJQm/KJLCpD0NEnLQW+JdqND7X4Uyq6aP5XuQXVm+aM=;
 b=WYKm+Fy9R7GANJTUmxU08SuPR0/AhmXzhkMBQrvCSojBKyOeWwKgjjcDYL5k7olfcOKz4gxqC/uWxaiyZkPFMkUZ+RJM5VLeZHweooFO6NqD1mLl3UhPGjm6v1jPPvqw5tSgU9d4YbmpzNwwxQ69GV8vpRvB8ymLH121qAYwq90c7+n4bEr09gJFWV+AeLnv2h3p6gRT1c5WbJGabLeObe+K2PYvXsS3p0NDXLavkEfySCM6g46p5EiDqa3e7eV8z2nf/qmi9LyD2TJEe7QI9jwFfje8ke45Uz+2q58sCBGOjb1IMFe1VERuTOPEKKgkMDIk/12R3HUGIaSn6EwOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJQm/KJLCpD0NEnLQW+JdqND7X4Uyq6aP5XuQXVm+aM=;
 b=eae7zx/daaoKoJk8bliqevMio1VUeSE3pF1K4Fz/KMfxTYKIRfcdmwpnOR4+cv6wm100QHYsrpmahdDYevtkYwsCeMdB8gBDV/qwInQbSlojzWTLy35DV9+ePklLRSwsjt2T8KiKY4kDh+OCdnQVf1bgMhgEMjJmxnhbyLoQdvpKUTJ5Jk80G5N+vK65IKHZQ6w1N1szODwGakv6N15zZQPut2FZ7vb0hvqL/VHOZlp/nY8YhIigJXmnTBl7dwRqJ88MwWUMP2AWN8CrU6QOqFJ+aCT6U/LjbtUoPPUb7bThdI/cp/DTobf5L0jG4pZPoRwHlUTvw9l30dnr7ZEvpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 18:26:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:26:06 +0000
Date: Thu, 14 Aug 2025 14:25:57 -0400
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
Subject: Re: [PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for S32G
Message-ID: <aJ4qNVIp788gc2ZU@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-10-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-10-9586d7815d14@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 46459f2e-cfad-428d-75d3-08dddb6008a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYbJyg9Hxs7kgvLd7b39ZR8qiO0p5Yr5iz/3C8yKAoCt8EUzohX72q4N/zyX?=
 =?us-ascii?Q?MRn+H9nyIRzGbtZYzZdTuOGbvDpLmagOm674w8aifnqIE8KQxWvr2kHbCPmu?=
 =?us-ascii?Q?M/+fIqlUvSWiNyu0bhCVQf3Ayz1z7PhZmYRQrJs8AQmQ/C2UiqFBzI8XvzmZ?=
 =?us-ascii?Q?+nV/fosA3s1PpZjpXBGs5jBgMzEc2Bhrfc7ieTKmJNwag+/rlf9ZIu2hJtxK?=
 =?us-ascii?Q?igxzIgfQq0Hefm3LI3Aar4Vao/xyepg61FEtPMFvRPigPG6ogwZMPAM12ldx?=
 =?us-ascii?Q?5lNC6nwVs+tx0Cr3a8Fk5kbJViAfIDpqsUNGIqRWPT12keJFyzh4zZbjaWy2?=
 =?us-ascii?Q?q8eG49p2fYdFVEkjt+Gtq+vunDlM5FFFf4u4KrKO+IfNJcAn8cENsqPjS1Kf?=
 =?us-ascii?Q?rwdTv7GtLsrIlx/L/742iQGyUJJAYOlhR1qiak6rWaq/qD5rqbtWxyVHPRri?=
 =?us-ascii?Q?KWAtyxkU4LM3vh9E+LxuRTuwCyAyEi2A0DDJjg8h1jRMtdku/DXbVgQSdYvj?=
 =?us-ascii?Q?CAtjbApniBLcumuWY3EKXZa0S2iKO31773v1zmz1ugy/hygbh3JiSExoFGiU?=
 =?us-ascii?Q?DlPWOLdwjReqyO0RsjanhIm1Ncn0I5n23IPmWUjH202XhG1riuol7SqDg62j?=
 =?us-ascii?Q?73M4/GPLJrfBLDgwUCjhPNerlHRWQmwShA6ZZCHM2cZsAq4V99nsvThpRv0o?=
 =?us-ascii?Q?JPJELgMDwm2XCm875A2Eb8wkM6Hmu2X2ci+ewVVbEU4/Jtk22gkGRW2eRoNl?=
 =?us-ascii?Q?psm5KTj0UM0mHptq3FzykG3Ipch7ksnwx2OlTZNGyGDjC6/qaaJeSEHIVZ/t?=
 =?us-ascii?Q?GzWXevp2LNQp8sNrwAHpJyZYI383AvXHCzMz7TXMg6xy1a6N5m1iGnIiIchF?=
 =?us-ascii?Q?ulWotd2LMG8ib+vGvhpoQinZRIF7Fw8aSNrL8BSXsZpzZ8niqu/ISMNSQ2+B?=
 =?us-ascii?Q?chpc6Zh7tov/bbSJofa3MyWqxDeQGjEvPexc14fclzS2R67rTxPYS4yzM+Ku?=
 =?us-ascii?Q?l55h5n33ySYNh8ab3XipkDM7lMIaUnUzT8acyvD4o1CztSR1T6+19ZqMqelz?=
 =?us-ascii?Q?Yg+QXz0t53o1Ufc9A5tMeL5aIEnbtQ/3GNXdNIDW95h1Q5GVbHZ7c5FruZaY?=
 =?us-ascii?Q?T/dDip1fYHEwT/3kObpxIeinq01/qMVSr59KH9A4UvLeArqIFUjDDlW6sS6p?=
 =?us-ascii?Q?iZ+z9mOiE6hmynfuJLbnt741ofWhXvtwB+wSs2wcjwHhYlhHsE5+XVJNJqgX?=
 =?us-ascii?Q?mX1H8ctaQg9ijs3UmXys2HbLL8S2j8uqVCu0ZwOeIPeRVS4L0nYzf4u0ZtLJ?=
 =?us-ascii?Q?XYG2vu9hG8AndHlqXC30ExT+ki1bGOUt9oP+wdnZAvM6eoed0/5iCrKcZfsg?=
 =?us-ascii?Q?ncWZaRRfRIiqKVhTnshR6Qx4ZaxOJue9S9NEiqOqNY4aGcdThKyVrUjQ/BNQ?=
 =?us-ascii?Q?Oq+d16J/F78Pmpzon+z+xSD85LoIqiZh7BJ8QwaGO6DjlvGDwbzYCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FKXgqo5CfQE2XiR9mKMHe9vcNo/rDBdZp9kulqW2C6BUWLe2nQV/r3Efr6sK?=
 =?us-ascii?Q?7rRwDoONX/b1r9u+v0gPjzVmpPNXMIF8ucxy7sPvhJlVceUfRsmFfNnqaNyK?=
 =?us-ascii?Q?wIqgrf2uY2iBLkhZXfooSj2ie43lvzTA4DJAB/PImt0oON5knGOS6sYUPg4B?=
 =?us-ascii?Q?x7E3rJ3NdTuRAiJU6H8kDUfGe6FgveF8UCzJFS0zwPSa09/x8sMpVCHldJgo?=
 =?us-ascii?Q?SNMwHZoHm2OEXY52H/umYHuV462EAXMSU2tGPip4zPJRs+eria+a/rGsrjMj?=
 =?us-ascii?Q?lBOSNfEILYBf61dGSQflrjQ3u2mv3jLAJI4dL1Drp7SuyEiByMoxxypZaEXs?=
 =?us-ascii?Q?0TuC8FFwdASmhobnFRkOaj1RSvElW0Bt1Z6/lGYi2DBuh9ISVdS4D+qEVawu?=
 =?us-ascii?Q?DMcnv6+GtnNo+BiEu6WEzVGLKaisuKSkk+lfKuZ1MCNcLbcsteui9L9GgoPF?=
 =?us-ascii?Q?1PMxk+crStiEXNMB59t9zxaFnvK1TvFGijtsNFwwqOOfAS2huoVeo9DnQoIL?=
 =?us-ascii?Q?6sEbazQshb21gp5KfrOtbmagIF0+q21AMcSTqk3JqWpadUsBG0jDlBkgR/si?=
 =?us-ascii?Q?RWXicFIjT1TxPcpE8BxRSmXW9BfSkH3Hq9HxASNzP+QYcQdj6peKkxPSW9nx?=
 =?us-ascii?Q?0RJXM+nHgF1ob+P8bN8mD6jpwAJ5uexH9+TkLbjHMbQMZCHOhKkmZIay/xiA?=
 =?us-ascii?Q?nydBqPs4QhLoEHcnzAmsUgXtk0VX5gnNubppbs6ZL/kYeYNwJfvXP4hFDLso?=
 =?us-ascii?Q?94p+DYkwf+b6tMBt6C53DwTkbSpVqyfBTr5ZmL7ZVwOowPUVcZMmoJWUMdxL?=
 =?us-ascii?Q?iAODs6CEJ74qcFW9GE0nUQoZVvJdXEE3F8YjrdYrTVNAfwcQg2pjKs/bJwt8?=
 =?us-ascii?Q?qjvl+S5RLZbZba3eDmRgxH1zaNoB5zvD2/SYSaUdd/VZW6g+63+XwSyd8tHr?=
 =?us-ascii?Q?WZt8spRuDbsYP2FltzpFzCQLUmJnsQEYSy5xKUbMDwJE6FAVFeOb2wlt/mMj?=
 =?us-ascii?Q?mvRwlSIfxgFr45sr1B/JnHfP5rvEa5PXK0xieLI6WCDYtUPgBT0GWtece/U6?=
 =?us-ascii?Q?93NiwTf6+DhoqV9pwsff84Ku2wRG/2oFEFEpePsivrfnxmMKHti1SUkdUoQb?=
 =?us-ascii?Q?dFXn44jHV0qnJaRCWiw/URkeOnlRj+KRIl67Ygcq6ygWBbcaQXkEr2iMwfoS?=
 =?us-ascii?Q?lOB402qPuCBF687BU408qgEz5/+q8/JG824xix8b0EHuGg2UesUwHJu0csAG?=
 =?us-ascii?Q?hJvtKR5C89mYo5jN3s/LytlIR9Hg4AhDNgmve4FN14cN690jn4n0qeaNX/8C?=
 =?us-ascii?Q?YAs5YaTypjQ2IYMW/t4CRqC7+4bCsAZjVO9app3YAD9tmGfuhqR8MfVs+5wy?=
 =?us-ascii?Q?yLg3Ky0m02TCbhHAjkpmIQtmq1K6f1LThinq5nQxBq8nPC3QfmtJmyEPVbs+?=
 =?us-ascii?Q?R+YaPiNGrRp0R3gQaHdDWX9K+Y6fduq6jvoruaA+U9n9Po4Xq/gH7tLYaGEl?=
 =?us-ascii?Q?QnuTXPdTr7qB1s2XGSU3t4d7o0j5GcGYZa1JQ663V0HEaNj+t6kSeHyCev85?=
 =?us-ascii?Q?44HIY7qQOl21CX6WgkI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46459f2e-cfad-428d-75d3-08dddb6008a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:26:06.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaaQjJ2BJTY8fHvzdkGBl9uUksKQdgHsHhr8AyoTnL3yPB+Tb0W4RYChE6+mCnHra0kc31sp28RhnPxWS6aDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

On Thu, Aug 14, 2025 at 05:06:50PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> S32G doesn't have the max prescale erratum and it can query the max
> number of CS from hardware, so add those settings.

binding doc should first patch. Create new patch serial for add S32G
support only.

Frank
>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 6d0138b27785..a4727ca37d90 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -159,9 +159,15 @@ static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>  	.query_hw_for_num_cs = false,
>  };
>
> +static struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
> +	.prescale_err = false,
> +	.query_hw_for_num_cs = true,
> +};
> +
>  static const struct of_device_id fsl_lpspi_dt_ids[] = {
>  	{ .compatible = "fsl,imx7ulp-spi", .data = &imx7ulp_lpspi_devtype_data,},
>  	{ .compatible = "fsl,imx93-spi", .data = &imx93_lpspi_devtype_data,},
> +	{ .compatible = "nxp,s32g2-lpspi", .data = &s32g_lpspi_devtype_data,},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);
>
> --
> 2.34.1
>

