Return-Path: <linux-spi+bounces-10070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B6B80FF7
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600963B5563
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316D1B7F4;
	Wed, 17 Sep 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EcAnkY1a"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AE2F7477;
	Wed, 17 Sep 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126533; cv=fail; b=jmjVN6CV6wkD2uMOYWv9Q10g+yVjbVl/L6EkB2LDZ2Er3BXPJh4h0DMYr3YfysRsYNO83VQXvwKfmz/I0IzDCb9gjg7yAsNO9Y//3XVXfYaaJpmk0JKaHDzPpprfUSC+Ed8yXU9KOlEzEAie3GdT8gECWN2kUsjTFbb1Mzu3PRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126533; c=relaxed/simple;
	bh=YOoQfBnmTM+CEBAaj/WA9R+CvI+tT15mfCVGU63bZEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUdOgtSGL9ovq0t+T9Hfk1ewzfnmr8mVVM2RJfmcOywXVh+sqytso7eNNQvi986r7jLk4Df887yYrUuGWEMthzaeMVJWCFCEnSeVVuy0P49r3P42e2Ec0OJv1a/2WEtvIIRXaeBvYVA4i4xgEppv07UaSzBGbTIVNk4QExteYoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EcAnkY1a; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBR6MDeIEDdfVGtaMXMbwne2L/Ji5clqawFh1f3PM/dJCUw8qugnHu2V5574lR2+4N8E7wbiulkaHH0xdR8FlvrBNbHt3bH9txIrP1Ij0Uh4yspRmLUZ8ls1zycyBWULJtYfcVBVed0ABxl5Tb3Ub9fENVVbGEqTmUMRb8v72gFETr94lX4nCS53IbkQm2WFxje/Jml0JMQ5woR49WFAOy6XKve0/tJi2tHrlhx8u/lyQWPgBwYYlXvEPau8wEoixPptDwSt/smoGmphEvKmo9cyqCK/GLJCMZnK4CzjVYm7NW2RQPLtKiEcx3yHcWIfnGL1KDmydUXBnh/Ncj7O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGQW38DH2igZZOTKqtK+2zLd6G+Kll2t3Co5DAybkDM=;
 b=M8KWj/biZLM4WVHhgp/x+uSCQ8wg/In0qZIvMyXfRCmEZPx7XWNg6GTg9BDFVAP1sbjVMmZcCrcvB96h7XL4iwxhejK3akcHHLobKUGRhNVadNXYxyAiHGCUDq8Z5Pxwu94Qlp55py54Jvr6w+XmzZEYSO1WPHby7w2yevVQn0eZiOjZJefRo2UauNG2jphXSASFqvS8Djzw9RyvISQ+YfAUNHiTAz1spfWn9CwAAJAXeZEv2UMHhaXjHzc7gv/3liygm+kcezUYb4ULzeA759/9z4tfvMWV+7i7QxWkFI0GfY1iD1FD4cgEcn3s2pWkjy3C8EOQk0RmsZeBF/S4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGQW38DH2igZZOTKqtK+2zLd6G+Kll2t3Co5DAybkDM=;
 b=EcAnkY1agMMnlPlf6lMsYGN4mBaBVtIX35Qke+zd+loMiSKnxjiQHT5IY9w4IF0Oa9rhRlPEk6EMTNGPTGyBEx/I6ECsU0/15ODanIFU/K7KgkFCWHs4N19L1p+M+Fjse0aBfzNoMgShV+iCyprd5omzy0L6yzBxKkRVxgAgIawdWBOcuNZJOOWvo1clD2bTXMt3sM4eQ2y8kF7hxqDaFKvMJV80ae9gmjEZqi7u4DV74RlIp+adNmiIbg9Gi9uwCfXa7IyjIVC2jBl2d95D2ZYwcg43HxMYJ+zpA/n/W7BT9/RhAPbkrxky4jqkwXYr8LNamlNizMMVO4xboLLwAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:28:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:28:48 +0000
Date: Wed, 17 Sep 2025 12:28:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] spi: spi-nxp-fspi: add the support for sample
 data from DQS pad
Message-ID: <aMrhuvpI3gszqvi0@lizhi-Precision-Tower-5810>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
 <20250917-flexspi-ddr-v2-4-bb9fe2a01889@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-ddr-v2-4-bb9fe2a01889@nxp.com>
X-ClientProxiedBy: PH7PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:510:23d::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd540cc-8ce7-4267-539f-08ddf60747e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZD5hmtvNQUDJ2I+NhetNrRpQs9BI4tvrBZqFze/4GkjEMlWGNYDp6nTYYrPW?=
 =?us-ascii?Q?OP93eEPNnjOzRBqjEWYd/Qn1Wk4Vsi6AsSF6NOqUZe1MhIDUAC65DDM0ARIb?=
 =?us-ascii?Q?8BoNYVwRWHqMUvQj54pIENKWwVrxWMep+kMfbaQImJvpxAI3f5dG0qW3ndIr?=
 =?us-ascii?Q?rMha5JaTj40wqb3BPaGmD88L+RVZ1GpByKGJVQEoU0cRKbcuFj4B4qFN6M0l?=
 =?us-ascii?Q?2a9GFJwfBEtp7nsE7QayznFPDY75wNfuUjv7l/kMNynBpLKMJKqfGYoar8CB?=
 =?us-ascii?Q?oeCtEUoNzOSKIw+/mt0FS9WYTF9/FgMIj9SYe1T269ZcKHYWKkQ4etJxB+qt?=
 =?us-ascii?Q?w05x8KRzUSUNcvv+pddUDHz0eC9y4Qvkdc8b4kJ6dyuI3v0XbXj3OwbzC6lX?=
 =?us-ascii?Q?Exoqbn/WrScOTOjWh31+2JS8XUdAwXwN6TquY6fyBqWYjn4lNcsP94maMGRm?=
 =?us-ascii?Q?n8BZ958610Z4dRzCKdQAkdix02PR/LwSqRWbPQXjQOb/oPS5vy0074viLcRu?=
 =?us-ascii?Q?c1kJ5EuCdo09upA8A8sHKzFf0jR65c6u7bAmFHIcfZqgPSRNejRDX9nySupa?=
 =?us-ascii?Q?Eeebjk3E2GR2bLIHIXYHk0H5lZQRDLOvl3Ysps3VoqbZzFmDGr+jXZVvQ4J1?=
 =?us-ascii?Q?GMx61pcns62fUox6xvY7KmQVWEAu4+6Il6JGVjtsTExut2jDibenOrQKgjer?=
 =?us-ascii?Q?4AjfTRHFUt3MrQkMrR8WyeBS1x26xMOmsitnDWlHakr09XjolJ5rgmfzI2a3?=
 =?us-ascii?Q?8eoFpVKh6/qmVYSbO/WMBFuWkPgYdANRHq1HR0l5tP8yExej5gmRKiPE2epF?=
 =?us-ascii?Q?cQo70LKqMqbyJzoZWsUPFg7oCJRHZ/MfN0liQiEq8qvsD1iyd+hRw7GI3MkO?=
 =?us-ascii?Q?+nGXyJsPVJRZz9tMoK769Zq1QjeqG6+J1Q8vquAdznHUIbwpprSd62R2MX/N?=
 =?us-ascii?Q?uD7MmYK0yzNp/zKHj4/uQxmL7zy8dcWEUOjZR7oS3x24CUC7R7okBMLVn9r4?=
 =?us-ascii?Q?7GAkAFyayTOmaiX+bGJuRV+Ox9K9IIdVNmFocwaevCjhoMBXSwo8CnPiASfM?=
 =?us-ascii?Q?T7QsqCz04qm4hbqMWC83EQjms+H3cS9Asn7Ohi41thq6Xte27rNjeuEBFzy0?=
 =?us-ascii?Q?/Y1tw/R3txUsKPkxSObnyKlDWjSzbqdSAZoTEtmMmbluU+EpqdaS9o0Dro5z?=
 =?us-ascii?Q?gwU/69JmwqdFfRbShawlW9LtybVc7rZJw8lpHIfVAWIqg2NeqyYEe01sZEHh?=
 =?us-ascii?Q?V1GtYTyXbU/bJGDH2pOiUVd315Fb1vormVlwrqdQnMmzsYTP7T+C1hSBFd7+?=
 =?us-ascii?Q?0APZhB2YArwnBAAVkuIkYccTqXQ0AbtFTCUweDSHtatU9QU+LXm61W3WRAZw?=
 =?us-ascii?Q?1sTvq7E8Z64SKMADNjeeTQrDuvSV6hVuaqdQAooKFhkwksCMHiCLxF5Ey5aQ?=
 =?us-ascii?Q?t24qC5K++VrTNZRNkIujieBFwDv7tc/mRgJg5rH5gTCXZUu3hoo4pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOHZmlXCUuJdmi4mQpDeDukD4IFysCrxYtw8FQKbW3pxE7XNMxvgTxSy3BMu?=
 =?us-ascii?Q?decn3fHtft0teNmdraOE8JCgqu5D0SRF3Pk83n0YJeecVfjx7OTEz1yCgPBx?=
 =?us-ascii?Q?j786IwaCktfMc8kptXXHXOphdtVXFZQxUwPApoCR3xC1f7x23t5wVgJ/Lk3l?=
 =?us-ascii?Q?QFUVgiKlum2ggzp+KU7HLK2nRr0Zy1GNNvWvuhh8hqy2Wu2xAxCVHpki/Ryc?=
 =?us-ascii?Q?fp4dIMI0LOWHMVmv3EPGqrje49ZHLnJJQTJhyX3fJteDrfDB4aW/+Do6QrLp?=
 =?us-ascii?Q?hBXI2U/WSDAA9nPM+GwLrVmX9zHRpjFQG66Nx5opg9ZYb6o9puHgb87qepdk?=
 =?us-ascii?Q?1K/f3znu/q79d6Q7yJe8lVgLnCKXVp2+w4GCjseAS9DD3IyRriRpAcny/+7Y?=
 =?us-ascii?Q?xMxJF6kzBnWREInVnrraTHA7tVmQgxkNqEbI3xjQryocOaS4uJsktVEmvzJM?=
 =?us-ascii?Q?FsreYRN2iLdPIz727QISPcB+0RyilXlu6Zc5iVEerg0LTLm28QQijXw73bKL?=
 =?us-ascii?Q?uFngq9MmHOboDzHQKMFu7jARwBOJ68lrVQ7bP+YzFygAiY4kN+XFHozusCMj?=
 =?us-ascii?Q?rE8jDfJPdcyAbqgLhj+rrDD2gS4tg0cmC5L98BKWAmcoqweHTUrgr8rrL+2w?=
 =?us-ascii?Q?TML3Ww5KCVXenAId0piKAc/3V8LzyHvD3VVSbxVZ1yOkmJJ8BGceXh+JJ2QD?=
 =?us-ascii?Q?F3l9PAEKiyas8CGK0hWfxqNZiIXqAFG3dk5QCWC/FO8yj6nad23Pe4uB8uEW?=
 =?us-ascii?Q?xd2XP6EpAS3u/iR6h69NpEgxHlOaKCq0lpswcBx9/D15C51eAxuPipZzga3J?=
 =?us-ascii?Q?lFc+fI3OF6RywThqKP8n5BnNQdWEEm2pD9qug3t45n3inNnIWzjnlqF2LHuo?=
 =?us-ascii?Q?/BP8C7XGTgXQpbma9QUebv9WFIyF0eIQKAlochvmrmmw+cgEcALxDSx+E83U?=
 =?us-ascii?Q?F70YJEyNWvaKElESEq4PQXH1idcJ1reQwbKh5WguP1clvFzsGj2zJihnKs+I?=
 =?us-ascii?Q?SQ7C7s723EiAmm6hipPv9MPJyAYzDiV17pDjRrO0W9NxFCHMYdMI9Zt8vPQb?=
 =?us-ascii?Q?elNCxo+8qCBa0JZYfVAFJaO8m4t50C9YSSqu9+rr9J/KS/qcd99PPc3U6ESK?=
 =?us-ascii?Q?4DkKaZi97xi+L1uB0fRBYWgkrCxH2VaVlt2sarX0/5GXHudWZkULHG+KKFT8?=
 =?us-ascii?Q?Q+abGxZCXMdrjD8FcBq78qouEOzMgpNcHLC3u9Dzd/Ri6icIHOfZ8NM+l2So?=
 =?us-ascii?Q?/RWpaXs20HqwLnbSrvdYGPhcsw3Vr9k3uONJw51muzW7tYCfsZrQTuWQwsis?=
 =?us-ascii?Q?VqPfpKA8q5wBnDG7xiQeSvcS0Bt7Q7oWEOT7kZWp1YUgtBNPOWCGC4tTO4+w?=
 =?us-ascii?Q?I2z7nyp63iKHD4Vu0G8y9Ts0QIAidP13wXISx93IdkjDqYUMqtQErf6q0/Yq?=
 =?us-ascii?Q?Rn/0Dq3XdF0xbT1HAzbD5raIqypXR87U70hgmknucqjpcYUS23ms3SB4RCEo?=
 =?us-ascii?Q?J/oy/RJt4x9KdugDkvckx1NRjW/m7J/OBb2mqHC0cLvg/W2wvN3MmfiY70Jl?=
 =?us-ascii?Q?M6AJ7LCGlDwedQmfEH1OsLOJwY4sT122jskOFUtz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd540cc-8ce7-4267-539f-08ddf60747e9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:28:48.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmlKhusDwc1q2NbeWdG7CQFa3rSOZQFB9hCrU7zuaQfGES4TWYU4qW/JyZCMd9/VE30mB/V2ZpotYl1TCpBHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

On Wed, Sep 17, 2025 at 03:27:09PM +0800, Haibo Chen wrote:
> flexspi define four mode for sample clock source selection.
> Here is the list of modes:
> mode 0: Dummy Read strobe generated by FlexSPI Controller and loopback
>         internally
> mode 1: Dummy Read strobe generated by FlexSPI Controller and loopback
>         from DQS pad
> mode 2: Reserved
> mode 3: Flash provided Read strobe and input from DQS pad
>
> In default, flexspi use mode 0 after reset. And for DTR mode, flexspi
> only support 8D-8D-8D mode. For 8D-8D-8D mode, IC suggest to use mode 3,
> otherwise read always get incorrect data.
>
> For DTR mode, flexspi will automatically div 2 of the root clock
> and output to device. the formula is:
>     device_clock = root_clock / (is_dtr ? 2 : 1)
> So correct the clock rate setting for DTR mode to get the max
> performance.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index bd61f951d6befdb78cdd84d4531aab378a47c56f..d25679fafad7a94a7ea2a79d7e3da53f4939c9fa 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -399,7 +399,8 @@ struct nxp_fspi {
>  	struct mutex lock;
>  	struct pm_qos_request pm_qos_req;
>  	int selected;
> -#define FSPI_NEED_INIT		(1 << 0)
> +#define FSPI_NEED_INIT		BIT(0)
> +#define FSPI_DTR_MODE		BIT(1)
>  	int flags;
>  };
>
> @@ -655,6 +656,40 @@ static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
>  	return;
>  }
>
> +/*
> + * Sample Clock source selection for Flash Reading
> + * Four modes defined by fspi:
> + * mode 0: Dummy Read strobe generated by FlexSPI Controller
> + *         and loopback internally
> + * mode 1: Dummy Read strobe generated by FlexSPI Controller
> + *         and loopback from DQS pad
> + * mode 2: Reserved
> + * mode 3: Flash provided Read strobe and input from DQS pad
> + *
> + * fspi default use mode 0 after reset
> + */
> +static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
> +						 bool op_is_dtr)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * For 8D-8D-8D mode, need to use mode 3 (Flash provided Read
> +	 * strobe and input from DQS pad), otherwise read operaton may
> +	 * meet issue.
> +	 * This mode require flash device connect the DQS pad on board.
> +	 * For other modes, still use mode 0, keep align with before.
> +	 * spi_nor_suspend will disable 8D-8D-8D mode, also need to
> +	 * change the mode back to mode 0.
> +	 */
> +	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
> +	if (op_is_dtr)
> +		reg |= FSPI_MCR0_RXCLKSRC(3);
> +	else	/*select mode 0 */
> +		reg &= ~FSPI_MCR0_RXCLKSRC(3);
> +	fspi_writel(f, reg, f->iobase + FSPI_MCR0);
> +}
> +
>  static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
>  {
>  	int ret;
> @@ -736,15 +771,18 @@ static void nxp_fspi_dll_override(struct nxp_fspi *f)
>  static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>  				const struct spi_mem_op *op)
>  {
> +	/* flexspi only support one DTR mode: 8D-8D-8D */
> +	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
>  	unsigned long rate = op->max_freq;
>  	int ret;
>  	uint64_t size_kb;
>
>  	/*
>  	 * Return, if previously selected target device is same as current
> -	 * requested target device.
> +	 * requested target device. Also the DTR or STR mode do not change.
>  	 */
> -	if (f->selected == spi_get_chipselect(spi, 0))
> +	if ((f->selected == spi_get_chipselect(spi, 0)) &&
> +	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr))
>  		return;
>
>  	/* Reset FLSHxxCR0 registers */
> @@ -761,6 +799,18 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>
>  	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
>
> +	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
> +
> +	if (op_is_dtr) {
> +		f->flags |= FSPI_DTR_MODE;
> +		/* For DTR mode, flexspi will default div 2 and output to device.
> +		 * so here to config the root clock to 2 * device rate.
> +		 */

Does it pass check patch? suppose multi-line comments is
 /*
  * For DTR ...
  */

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +		rate = rate * 2;
> +	} else {
> +		f->flags &= ~FSPI_DTR_MODE;
> +	}
> +
>  	nxp_fspi_clk_disable_unprep(f);
>
>  	ret = clk_set_rate(f->clk, rate);
>
> --
> 2.34.1
>

