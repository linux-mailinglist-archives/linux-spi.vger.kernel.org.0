Return-Path: <linux-spi+bounces-9442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F32B26F05
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7769178190
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E422FAF8;
	Thu, 14 Aug 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwUz+Tj0"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44231984B;
	Thu, 14 Aug 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196579; cv=fail; b=sEoB9gWONDL9vbYJHdMz0zDWMzIZIdOrGbvcvI0U8WfLBNUCK6IHHmC4edYj5CbBhpZyl0YGSJaFA/fA73AKrp8upVRpphC5Pa0eX07C/Sl5Vls0E+ueMHFCyceeKtnT01s+E4p5n1XpwICQfC2BynUR6pQZghWM64hZcpGtlsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196579; c=relaxed/simple;
	bh=xcJ0NJYxFXztOKlLLiFJKxb8M/eT7ns82u21ycq9xiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9ySDyzb49ro9+3bKpBXLpRD/q68BtcpY6U9zwd+/thWFaSAhQqcrAeAAdRyeJLdH9rWIZ5AnA5sF5nHYHI8ZmC/JQ9P5lklaywTjB2wn2mMROaoV1lHmTrR1paL3djacLgxDFaZKtAzKkeeEoFfDcRdAMz7zFO8vxM8hIflGjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UwUz+Tj0; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8IsLc2oBRxQYl6lg96J5MygtWWafR5yn24NV8QiHqsXmZ0uDTp0FsPiQI+5wR8neWnWolA7qnhxjXJRMlsjzH+9VJTEi4A40+pQ6AhSGnm6CXPBm9Cle5XhgmQH5G9+lnfimRUBY5fffXrs04lyNdmqAMieuQls9ByT9uwwEJzpoqSDmy4xENB1U3jTsmDrTbr2KavIY16FDaSByO5TM2a8j4IrKKYxsMTT/O+LubVXRbRfnh14CoKYGUJUeNUOGA5w1snJhdlXjSBJ/A0yIqVnPm1ABAXDm8cVs/LBzibdMNOgWrmBNpzNFFh1FbWkwJinH8lfZINTk8qWox0w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cnXLk7jMRzE3jxwMO9LyRD2hJcuR078P7RlYGmbtrE=;
 b=R7ucWh2Vc9qLmnT14W+jUpNx/jfIvQ2KFhZRyQTOBJe+vtYZApQ7hXoDD2enJ8Gzw7U/pevFI746L+MoCP/q+H8gzpDOzBOItjcRGiYKtCNMBuc6BLvyS6g+nKR8+QC8wlnsss2MYdvsgBvPWUG1cS/2u8nN0m2ap2VcuueOr9DjI3yqZc/nHhT0vxNBbx18b9m+uDy+EqGQhk8cp2uwtNyQVMHgnmejNUBUHCPq2qcYlXcFsEyfVCRcTeNii/ZTTl+kMSWz9ysfFNck50ivoVIxOTpnUjjJj0VXlhXdUFOR2JpzJ9ND+PHBN7RB88fSVBbWMLSF13rw2DXk/uof3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cnXLk7jMRzE3jxwMO9LyRD2hJcuR078P7RlYGmbtrE=;
 b=UwUz+Tj0SfY5Ma3yq0mxvmG8T1HL8AvMf0vXoe1UUI06+p79zjhTD9C4shZsxluti3r1LLMqk+Pk8LfywP5FF1NdB2bPzuRJ3O4aOwAGilFWQPJj0/G/abjeZm946A3mM+CqlfNRfh/jLxKKMT10B482xYjzWh7fNyUa42vaOcJCo6oIWJULaLYM2J//JMeR/oFnMfEBXQT/+TNr8TTkGnaCU2zFHLbAOBE9mbwyOvwPSk9p0ojrMjUn5tnbdzy+cvq9tlE0Et231sWADoR6M9Dyo8z7guSv7rvA+IIXQ2Bqs1Fl+DfagD7f/pRvQ3/2ZUZBmItqNSuzUrD1v7niKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by FRWPR04MB11222.eurprd04.prod.outlook.com (2603:10a6:d10:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 18:36:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:36:11 +0000
Date: Thu, 14 Aug 2025 14:36:02 -0400
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
Subject: Re: [PATCH 08/13] spi: spi-fsl-lpspi: Make prescale erratum a bool
Message-ID: <aJ4sktG1NoMPu5wZ@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-8-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-8-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH8PR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:510:2da::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|FRWPR04MB11222:EE_
X-MS-Office365-Filtering-Correlation-Id: 2368e338-8781-45a1-6c10-08dddb617124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UrjrySHhEu7Pahb+i7xvnS7S0GDj6L//HaWyGXafkNCLhPwvD8f7ctNKR++F?=
 =?us-ascii?Q?AZRo+XSn8sNKo2+wrCxxuGyPlvGeiDMYcgD2ObXWs40BxcsxfbqSKWsF3CWb?=
 =?us-ascii?Q?rhmprJ5868FQxuUn73hCMRDVMCkt4YQ5CXjgMB1uTizppv4vyMfQpwJ1qdM4?=
 =?us-ascii?Q?2PoZQyoo4B535BV3PxGMiRgTWEf4WGew9x1zMYyfF8t33SGqnkYkOSyO0ML/?=
 =?us-ascii?Q?GpoClNSrLHqk5HEdHoRSzZAYtnSSWn27N1GB8ph8eLhFEGat9rXuVI9j27zX?=
 =?us-ascii?Q?AIu4LzZTCLM5oL1xvwRspEYTY6JMR6W7mireGTsPAYYGTkXZzAfOSxR3uYst?=
 =?us-ascii?Q?zEL4RA54ckM631TKewGe41Y1acK153d9UkG1otbToMs3bgrTDJnKeEOkogRN?=
 =?us-ascii?Q?pmBvP8+PsIGgGofSsr0VoCWUWob+huNVwOIgNbgqReO/v66p8qTbVI7K0okT?=
 =?us-ascii?Q?RTDpSJkasE+5AjB2s23iD+ZtWdsfRwvkxv/971k5J99ca7+cKsujX5UlPGon?=
 =?us-ascii?Q?t/B7nYoog/yF52qPWDOaDHX6PpNFByi1AFVc1WHsaoYLLqm0amC/yzeacfUT?=
 =?us-ascii?Q?p+6bUPQMyTOvGn366eFLNM8onGxLpNcJqm7erWOeWzGMtM5Zm5GdkWOQYiRp?=
 =?us-ascii?Q?ZHNfooVGTMir2KqQRSsfLAkzdUIW3j7IQkc6DE01Da5ZycpFxy3NEYr1Mgqf?=
 =?us-ascii?Q?Gg0RYxzc+SvAHlN9MxeCAnxcHKK0y3TdT0jsxg7vvXY63wQUW/DT0Jups82/?=
 =?us-ascii?Q?6ZuIvHB6LKgMek8nkT+IdR2vDjN9leWtL6MV0qHa8brdJYOAYq+2c5+BSbrP?=
 =?us-ascii?Q?r9pZveMISxFbyqiI/8y1j521bJWOSiPf7R/z46zPJUaIogubHW3vF1QynZg9?=
 =?us-ascii?Q?v1xeFL0uBUAhL267gpZbZN6uO/2Ccsgn39bH8DTKiPEf3YqPYdelUWH9YlES?=
 =?us-ascii?Q?UNfFApqd9K6EFgmKTDrCKUfX8udhZurBA+JH/CeqL+/+UUsExWMaeekapIVF?=
 =?us-ascii?Q?k1vYPO4wVGE9GhvoMCJZ0x2KxjEmd+E48fn0y+WNqa1VUuDm/Pg3xvYK+1kB?=
 =?us-ascii?Q?2hibcfrFYMMSx5lQVuA1JwyTkcAIW69GZBi1fjV0nQTe8MC28MDfJzhdBlTZ?=
 =?us-ascii?Q?6Jb9qyGzev7kzZUuhPUOz5bfWADwCDjx7LR2l2TaLMWDzhuXHTMRYhJ9nbso?=
 =?us-ascii?Q?HEj2tswIA/wGsLwFpBDFmR3bCEuzEhxiEZRa57ICxvQlCMe94+gKRj1cgzdM?=
 =?us-ascii?Q?YGQwWjXbFyTepeEzcd+9Y+WLlnuuxOdxDLgKCg5gIEBtx/8498pBnrgLC2E/?=
 =?us-ascii?Q?yBgY6oGLGQpgre4cSWDopi6d7/BA+QCfLLYxKM54NkGXKEE2S6du3JOU4MVy?=
 =?us-ascii?Q?hbvyBVl3cr0Ohmc/bQxEWWuBpf4mQE+DEGmDdnF4luT66BaN+1t2uMwGNEMY?=
 =?us-ascii?Q?RuTw/dfp2lSzSMoMpexZajS9rYVDBIppvK2Tcd82oI3PX0R2aZa2OWf8h55I?=
 =?us-ascii?Q?NG45kyEmBGDc0/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUnm8G6QCRCA/Qob6awWpuZjgx5MoDLUt6H2zkA0NTPGma9K1oJboMiDpfNv?=
 =?us-ascii?Q?T5ojyVElUj2csFwZRRGKSVKHaiV7yg/GLUaKWkRzeVElbYG9ml3iHpPc5CGW?=
 =?us-ascii?Q?z0Xs8c10I8n/4CVkVxh3EQtE6LS1pxjVh0iYawa72cm6g4VgHpO52WwsryCP?=
 =?us-ascii?Q?NzFqMXrK+2ZVSsRr8TN71tWfkRFU7vURA56Ptl1iQfc1pI+53NB6XxfRy+vx?=
 =?us-ascii?Q?y/JXM0j6U9HfV4MeAd+1Lz6ue7DZijG25Gdh4AJlbLVE/Fp6+VjW5O7IEA/y?=
 =?us-ascii?Q?2jhG3nB+a43hmG2pFHrLLAASCo90vfPLzl/k5wjiD6axWC6q/my/I1NFMznA?=
 =?us-ascii?Q?jh0veJtltvcnmG1MYTJOvMSlXJ5bUF4NxiwBWacnGLMy3OaB1mgorCaOiqbd?=
 =?us-ascii?Q?4JEa1VaU1hHSN+4wX+550XM91CB4L/LKxSaZjlgkML9tpsxNUgQ0iWWx01HN?=
 =?us-ascii?Q?A0B0z/kPpBwJ+hSh94V/aTLHf+D+Ur3kA8wAwbi0VySPluA+KxlEc4mA1owk?=
 =?us-ascii?Q?gHoS0YVWxR7JTViYCKap/4GQ8rRkicacpgoiCSMbNywLmCk1ZZCQ4J3l0q2o?=
 =?us-ascii?Q?gw2SRoZiBfLtCOgOCCqE4q2RuzgFaT9rCy4AT+ph+HznTnN+AYnr886rVhlb?=
 =?us-ascii?Q?SRjtMHjOezyYDv6k6efHRrln74mI+Lbt6rgGWeVrKVsEQH0QKoBvfn9yT5P8?=
 =?us-ascii?Q?LA8Z1SnYjYPRSph5vPy9icyrg0hhEXXOrUyLb8Z5pBCBhlLQGoMLOUB+oJ/o?=
 =?us-ascii?Q?D86Z+tdAlEU4dq5KVDuvzcP6j1449PV5+bZBOOkAik4h+zc//B+qWovyRMOF?=
 =?us-ascii?Q?UReRIqdlX9mawwc+f3Yz8ry5LI3/uMycQcq7DJRthIkHFsPC2hlWTR7Thehp?=
 =?us-ascii?Q?VlbIEmEGkeYfyw/cpXdZEb0xgkNLUg1JHRXmsGpONEPsc0KQRPvW6UJy1m/0?=
 =?us-ascii?Q?SL12I6P6OSuHz+naRZGXtK0/0FB51/nLddjAUdJ13Um98+osqHecE783Z2N1?=
 =?us-ascii?Q?s62jWTxelzIg5oG8zaeLeUxZVeJD3XKMEzCYL5hX81y83UrQRtDrUSJVwDGN?=
 =?us-ascii?Q?lOYBOiU8Nw+z0aRdFmn+QMgbEh4PfIje4eBeEx2zIgx2rDm8vDx31AbbhOhJ?=
 =?us-ascii?Q?FvwGqbsvaldc8dRycPPGI5/C/iEXVQHRf+y+QhLOWAh07iLAwKTez0+pvYXN?=
 =?us-ascii?Q?N5ZJNAQ8scIEsRYnwR4OoyDN29WQK/2lfgyYGJM27PPxKuURqTdTcxUfb9ej?=
 =?us-ascii?Q?ldAb3ysVWLXWEIghfbRhSCDAD296pgCE4zb05aVMn8gDX9ptpXI5AF2jrMJV?=
 =?us-ascii?Q?xYdxq1ao2nB1SmfvsINmbiYz4sLFDkUzTrxBen/UM5dw2LloT/SrD1cYQXiY?=
 =?us-ascii?Q?nXo1tu29jvjBkzf3Gu7ZfR/WJJcnX307XY76gwa18oaLJDi3WZA6T1Z2hFOy?=
 =?us-ascii?Q?ZUsBqY16MFvnpUIMsUuzkXz8E0ycgsddyABNHkLoc5tvTAWxD/zFdx55y4RJ?=
 =?us-ascii?Q?/vf+h/RTbBkS48rPYC+iVUAu6D8ogOXr64DGyb2MKw9q1hoUPQIyuhM0oizI?=
 =?us-ascii?Q?HfyqerPFDxggjnPANKn5KxA0TWZwpccksovvSbTX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2368e338-8781-45a1-6c10-08dddb617124
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:36:11.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56995M3vwu0cKo7q68XqFKhXvYRy8yjmp5Q8qOUo+1M7NIVEdjlHY2r4x2M5+ZB4IjJokrzuokwd7kmQwKPpQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11222

On Thu, Aug 14, 2025 at 05:06:48PM +0100, James Clark wrote:
> This erratum only ever results in a max value of 1, otherwise the full 3
> bits are available. To avoid repeating the same prescale values for
> every new device's devdata, make it a bool.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 332a852b746f..1013d5c994e9 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -96,7 +96,7 @@ static const char * const pincfgs[] = {
>  };
>
>  struct fsl_lpspi_devtype_data {
> -	u8 prescale_max;
> +	bool prescale_err : 1;
>  };
>
>  struct lpspi_config {
> @@ -144,13 +144,16 @@ struct fsl_lpspi_data {
>  /*
>   * ERR051608 fixed or not:
>   * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
> + *
> + * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise the full
> + * 3 bits are available (0-7).
>   */
>  static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
> -	.prescale_max = 1,
> +	.prescale_err = true,

I think prescale_max is good and clear enough, you can treat 0 as no
limit for prescale.

Frank
>  };
>
>  static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> -	.prescale_max = 7,
> +	.prescale_err = false,
>  };
>
>  static const struct of_device_id fsl_lpspi_dt_ids[] = {
> @@ -329,12 +332,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>  {
>  	struct lpspi_config config = fsl_lpspi->config;
>  	unsigned int perclk_rate, div;
> -	u8 prescale_max;
> +	u8 prescale_max = fsl_lpspi->devtype_data->prescale_err ? 1 : 7;
>  	u8 prescale;
>  	int scldiv;
>
>  	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
> -	prescale_max = fsl_lpspi->devtype_data->prescale_max;
>
>  	if (!config.speed_hz) {
>  		dev_err(fsl_lpspi->dev,
>
> --
> 2.34.1
>

