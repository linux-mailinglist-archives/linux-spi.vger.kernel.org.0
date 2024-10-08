Return-Path: <linux-spi+bounces-5147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14D994E39
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4281C24D46
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0861DEFE6;
	Tue,  8 Oct 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGFIAuEu"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44211DEFE3;
	Tue,  8 Oct 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393233; cv=fail; b=HlaPHc5sf9CRuYCBi+LgP3Oy5+5UyCxXC5Fbd7fzZuk7GK75WjPJ64nlUGNO00rPF1TX6YVTMYjsbm6YrESvUhTZv7dxkn7pGdH49VoDADkffnwj9r6u4hioenriImI2kG9uHubTht+qZEfAEQ7VzrM0vBCdpkbpB9TCvmRkHfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393233; c=relaxed/simple;
	bh=TVXC72wagavZTjj/9q990xUa33bTy+NI6IVSO6BJ1kM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ppqo0FgxgFYYK1hMDgyiwMlOyBhEGuZoX5n4Of/YKvKzSB15FYBD0ElXyU/xR0mAj1rjCaaPhHR1NdgB0XJSQ2fRD/xOB8EZ1Woq4Zukp/9EqWQO8LZuC4Mk2JEUDLusI03TOjad3sM3PRsvVDS99kOjoiUnL4TqeVSJwTGzRmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FGFIAuEu; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyKQNrVqJwFWb0sJp7YJUZbNtIn53bdbIdqwL43cf1ZzNOg/wDOdtiKNZ+1g2OJnZ/KOOzG87e6x2BLNEHm1yCP1DicGP06oA7S5YdKeTkzMdG27vcnL8sJA1NtWdIlww5wbVOdgsofKnfH0aM9RUuHMZQG9tXjG0HyMROgGmnxPyz3v4vGlJenNhEkWV8upej6HFMIZSHf+HgKAzjgMypcEOdTuenR+mgBtHgNt3E6nF1yPe31RCO4Kdw6HWC4pl6fpO/QiFGcHr2iaxsR6zUa4ZA+up8kiqeb61j/92vcl5iSBWx8r0lTxkrG+I8QobsiAZyh+lUWs3BiAj9QShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV5CgfWcW7L1QuPXHCJfe9vpWoqCxOEcLR8J4u5loes=;
 b=UDw2fYjEsvwPr7GIL69j/lm2dT3OgiHUzxq/r3/4plvINNAq8/tefIGjPT1WYtZYHjIZB74X9kmtmmGgLVG5EUjH+TKfcHeigf7oZ58nYqVUuIiz8LwXJdm/6UjPQOpLzNw5Wtl0861iOt1tWky8ApxMk0nyn0CEkji9PW5tJovMa1vVhSjpQl0e1OYgf4qXbDtgbsmkK8zPnPa2YGvEKPpDOBdX3hJZk1lQaRkiNeWACxhXyZ9FHgc3yyzy6PpUEO6e4Th4e/xLXFgoBxMVQTYNG9hXqpKxUj64Y+BGpUEaXhhDHvwypU6F0bszdxw5PQ3PXRJ6eyUbv6nZMTvKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV5CgfWcW7L1QuPXHCJfe9vpWoqCxOEcLR8J4u5loes=;
 b=FGFIAuEu8x+ysAH+CvfwPmNgg4g97BOD+TxSlQCIuHJs6pJoYB2uWk0yP15L34mb6eQu7jRUe/dnre4DoyEAcF2rFPgSD/OT/UTh3CW5HpMgFuRYzqvGJmH3eJrCdAVMTZXJCCRvt4WFAOr2NU/BpBy2kVEXq3kzdfAMMF+e3p4EMe9tDoeVdlDMYxfHLC4Iy+b95GOVAwr07dL78cMXvG2JAK2rhWOHqFksDiTV1rTja0XnyCzsIiNuq4T8UoFML5sthqGJW4xRD8ikP/iAalT/4ZrPQ1lXB269IVIhp7kR1wdWmrlB+ggxW+d+V3h0kUW9xcn13Qp6dWj1FXSC0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 13:13:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 13:13:47 +0000
Date: Tue, 8 Oct 2024 16:13:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: broonie@kernel.org, frank.li@nxp.com, shawnguo@kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] spi: spi-fsl-dspi: Fix casting warnings
Message-ID: <20241008131343.bu52qrnd2nrlkynf@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008055644.4900-2-hardevsinh.palaniya@siliconsignals.io>
 <20241008055644.4900-2-hardevsinh.palaniya@siliconsignals.io>
X-ClientProxiedBy: VI1PR09CA0099.eurprd09.prod.outlook.com
 (2603:10a6:803:78::22) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 669e27c3-3065-4cf7-1f34-08dce79b0b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTyqNBHWW+G7mTfq9GsQTv+SWH8Ws6i0UPSBT4SOXIMMboHbY0IDZR1Mn9AB?=
 =?us-ascii?Q?ZFG829JElhzW5+WFMgjCwpJbBc486uSH4jant5zBs+4HklGgu7wEWhl9m2BK?=
 =?us-ascii?Q?o0/krryLPmspu9bKS8XGnt5JL2XcQFVdeg4ok8dGwBML06TsIxvtXmUKHG7g?=
 =?us-ascii?Q?mESHeBQ5lFXrUw302iT3W9YVf1tKlP11aA7RmGagcv1b02kI6O04JXFakbhC?=
 =?us-ascii?Q?a7HfI+MPnaSYpQqQsqRghLz0xEMmu6/melUAcpO6EiPb4xciwNHfmHtwGTNx?=
 =?us-ascii?Q?froZM/9cK3XAsYz675Yq0zbDgtLfhn86jlZrnuyIzQUUsJVoCMEi+3AWxn4w?=
 =?us-ascii?Q?suD2tICqVjdWuPprcr0C8CbqU9ng2eVzIEZrz5C2RFYIw6AA5hnPKfdSU8Pj?=
 =?us-ascii?Q?FIPqb8KttU6WMd2K0dJtIk+V5w/RKf3hwlOk5Z4uTN11as+NYOA3jGmd21uT?=
 =?us-ascii?Q?FJRzrM51UIrkSdrrHO9g/sbquOp0RQZ4okqx1zVXeqUYsC/nQUMo8FdSxugy?=
 =?us-ascii?Q?4QVqBtdYI50dsc004Y2fMyFZjxTqH03ceCbJyMWAvD8UnR+M0GadvvuuQF8Z?=
 =?us-ascii?Q?leQLxKgKwF7TJto9EZLVFEIEJ3vxZO82WdYQsjeKn0XH5wHX5LmUoRclDPNT?=
 =?us-ascii?Q?mbcZ+T3X4hwQMscF7wQQLaueKO9o55STgXFJO5DgEkp9jqbyyTknI0B/N+kf?=
 =?us-ascii?Q?N8H4aT6lNnvtb8RWk4+iDTfr9iKvchE24Ui6/ubvvkdaRZVjqwYJazH3TcJe?=
 =?us-ascii?Q?B7Up4qNKVcL1xS+UNnmchOIYvn9Xky/E3lvw4qz8ASp7oW09HYzrER1TNAVn?=
 =?us-ascii?Q?OMbqJCicT1wFgpt+ngi9gJIv0hVpGkBcP4a3FWAqlMx85fnYG8BEi+m9niC9?=
 =?us-ascii?Q?qKVIRuFVc7E3n5HdpGV4zlCvoMI5MEiWsN+NHzsSQJHNatUK22mQeNMWKgVy?=
 =?us-ascii?Q?zsaNrT4s0hqg/Yiur2eg0mYcTcRdQ/pNnJzwxw8xgXnhfRWowQ/2giy9Mj2H?=
 =?us-ascii?Q?AB8FEQlEqns4wZhWIp5Eeo62zyP6MklCSBRD1r7DXItuUTZpEOuI7rJ5zgTT?=
 =?us-ascii?Q?xnN4aJOzpMoyuc4o0pFFB2/zlzkPT4M1fGxduny0kkGl0GiQKD1HzDBhDhcO?=
 =?us-ascii?Q?tQPO2co8JgganNhUAk4GVBNU802tuklZYRqdduYBC29Kgk0ZP+9nJ8iIr4+8?=
 =?us-ascii?Q?PzwysCuCSwe/hLKM4OxV+hwLkHKWjdv0FBnKL/o2fdHo/mfIDURxh+4bgLgE?=
 =?us-ascii?Q?osi8l4r/Ty81BOyKJdCHw4VMn8C87c6H+4L6dvkpqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KpRNFfc/qBYZ5YcMkJDC6XJyGBkayuejGV6AesmmtoMuVzJ+tp/2ivpEER6q?=
 =?us-ascii?Q?x94xwE4TbfhZP+3PnwCjSCa/MuyA9Ri1S7tr78/MKiLlv9zWN/58wXlk3sYk?=
 =?us-ascii?Q?ukyswyZq1NfDOaRNhU0w8/1vnoUQOD2uffFXZ37MFaSylSYjRh3usInVGka+?=
 =?us-ascii?Q?84n6CoERO8hfXEECYZYkGwj17dfHCI4rEkXRODeJbebyAHO33rng7YDyt16N?=
 =?us-ascii?Q?wJPyj1TTLuoqXB2X4hK4ypPg5xsBG7MmQmeiw8vsmhUMSXx2nwhTSpI47AnR?=
 =?us-ascii?Q?sTtsPjR3xSf9k9+I7HZ4ZTVvivBY3Lj0X2UB61qpUkgDYJFmq7bVusSNhAPU?=
 =?us-ascii?Q?1+kgw6e0vPyBZYtZpeLirBipCV1ZLzdbO9Rqz91A4PSq3OyGMOxOsiK/zu30?=
 =?us-ascii?Q?fNQoEm+R9COPiJemm7pz9v7ysuzjGUraKCXNF255SpVk/R+7PvTl6dRjq18+?=
 =?us-ascii?Q?TDZ+n1SwCUUCCnVaNmHd6vz2Vrl1sB+Smgpe8ZyNlYdT6EHcLhqyUEEKXPSF?=
 =?us-ascii?Q?MT4MaSrPrdxmfJxVUQqiok27gFPpHdzXoxhX9Q9utwCKzExLF4ooioqUJ1ZM?=
 =?us-ascii?Q?UJus5+VfD/7KVbmOeJIttlH15ineA8d6aSjyAU1MkkeUr0cnTJxmXcZ/qWtY?=
 =?us-ascii?Q?oVNTrThxL2X90nktBhuX67cbKovDC0zmipXlhY4SpnRo5RQCqlnYIiQnP0zY?=
 =?us-ascii?Q?i/QYKjigVkmfPXWHk16h3BjgpTgM+V9JY6+afDmD2cpbwTgPFbsei5MQm+Qm?=
 =?us-ascii?Q?yxq4V+LzXycbj9Y6gJwhCiLJgOEXTrO0KW6/gaPl7XpmqOX3u2fItRYAsqMR?=
 =?us-ascii?Q?zg8ix4eKFi0ZsxV7CTTjuWLNc79TeN8Vtsm9LyMczlxV60AAG/Q2mo3Ua1rI?=
 =?us-ascii?Q?m7OjfD2qtsO4hJsauU1fyuh/LoBGf3e/CMukKvFObT+SuzPhPDshLJOxl4ko?=
 =?us-ascii?Q?j9mXee7494MvUdCjD+H/9imm0o+Y3sJFHZcUR/RKGgBO0uiwZkcS7VP7O1mV?=
 =?us-ascii?Q?g7JO5QyreRTcCva+hxBITxyHjfFxPYbOUa1m6NZfeRAUsxdLWbI9XLoshoKD?=
 =?us-ascii?Q?N06qtdMokxNG9yqRJ8QdI1EdRwEe3UbNPLP8389I6wCdC6I7fEV4LFcfwr9D?=
 =?us-ascii?Q?fTbrYon6xbUfSYgDuEI+mzIBrPOdtfaqC2ZFk7nXmqm48SFe1vnbzyh3hp3B?=
 =?us-ascii?Q?AjWqTTk77wM/1v5vWWsW4otSByk42Bhw61xegMUOk5XGM05Fb3jqfXsIzWP1?=
 =?us-ascii?Q?xyvaGXIumhFDflTqdgXJXTOQJrcNL6MkjhFz+HPdKTjqBsIXF0WiMXg9P6Tb?=
 =?us-ascii?Q?WrDJ4LP1Y9Vd03gJRXou9sIC/YNtWOMVz1rfl7LpZcErBUxJfux8l1H9Feif?=
 =?us-ascii?Q?GbF8gJUWZMxkIIJdOlPkhVACiz/TmxbyCD3YrFMnxRYXeqNRW3XjeDHk3R3D?=
 =?us-ascii?Q?fKHhhWkzwGLuhMcZTjY+4GKlVwo2BOFi/VUiF++Ee0Z19trhC6Gt5dQaUQ63?=
 =?us-ascii?Q?8jJsVPycJIMisFZ1i2iypsEEybSpYGTa+OGMhDZDgdGeYsGUPAXor3pTG0i8?=
 =?us-ascii?Q?dR/DPNlMKfczZU9dg4SwCnpi8W8E0mU4q6VOLu/s6fQkP7FeE9b3eIYY8rtn?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669e27c3-3065-4cf7-1f34-08dce79b0b12
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 13:13:47.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoKjMUBOBLpgIpkQWnLAesGUMN41fNhCOirbE+4Jvmc86Zkn2N9gwp7zwB4khrSQVmJCfsOBEcZdTEwlfBzFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386

On Tue, Oct 08, 2024 at 11:25:45AM +0530, Hardevsinh Palaniya wrote:
> Sparse warnings:
> 
> drivers/spi/spi-fsl-dspi.c:283:17: warning: incorrect type in assignment (different base types)
> drivers/spi/spi-fsl-dspi.c:283:17:    expected unsigned int [usertype]
> drivers/spi/spi-fsl-dspi.c:283:17:    got restricted __be32 [usertype]
> drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
> drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
> drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
> drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
> drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
> drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
> drivers/spi/spi-fsl-dspi.c:295:17: warning: incorrect type in assignment (different base types)
> drivers/spi/spi-fsl-dspi.c:295:17:    expected unsigned int [usertype]
> drivers/spi/spi-fsl-dspi.c:295:17:    got restricted __be16 [usertype]
> drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
> drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
> drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
> drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

