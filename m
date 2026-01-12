Return-Path: <linux-spi+bounces-12292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C1D10D26
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74E530155F7
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528532AAB6;
	Mon, 12 Jan 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JWMiwXzN"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DE311C36;
	Mon, 12 Jan 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201934; cv=fail; b=aQXsIadB10mm7szolemdbv4qqqYEriVVSHiUq8n/pNVKh39aBfuVscuqzMQrtIhB80GvHG8Ijsmp2hMuV/8sJLzXP6G7deGLPv5sydgzSUCqgSn6174qYKmxf51XHMnFXrlPLxlOOG3PN0oK/FExl6OHnd9MszDllG9xuL/lg4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201934; c=relaxed/simple;
	bh=NPDl28R1JosLfHoF7Z1pIdOw8Xq7GICB462Ot5vupGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q0ciqJ6R0F3C74g1IhDeUR1rAAhhkWbG4Chi1oelqwhII4mBY3s6TiVgdQjqVn1oWVLvbPNNRCacrdzrb0p50tAYl5QD7i1VGwq/EP3gl9Vf2RqSap2hAJpdem7sY60uXVwjU6BsMrucIfep7DMwxMFf/n/jJ5YyvMckT/xDYy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JWMiwXzN; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiWjBw3NhX4cyS3lnH2JMD74N88jVMZeCHcUNTZ8zdAZq22MkAmlEy+wDn4fUqyzXbF8hhpiARDecpRSi+0gmlPdNLfrVIiAZ/HoP9cwDCD0WKlNz52Giz93YAC8RRZ9O5CgOgehwCvH7QZ1Satd0zchZpRTN2jzQPbm6KJ7wLTfDMwbk3Cr+Zo8hrLEIaKkC49M4gMAovVCSepFEL5dvpE3pkKRekOXmxgSeFORVYXy9BF0kgFJ1UHVl7tnh4b8swEhccsMePQ4n4DRm+E37Q9S8N/Yat8ObtRmqhXmd7QHmDKJk1SCRb5icIOyDKrDe/2XQw1ZKNitgOEwu0vhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sUtyRzyU2X/5L8qtvUfjHP+2SVXxP81mWDh1Of6sls=;
 b=bV5+glcNenM4PLDhrF7n5PnEJaopUOIuXyx5YBokvhqC3SNaXqGN4BI7tdgs+RgeNdrKsGKHEywf3ReINzXlWWA2KJ1N2zZ5tUtWgsRZ4sJRw6Z+zHlc+JgfU3tl8KuMS8wxeruIT/RK19BdgTFgrmRUb+NXoK02kzGRuOFOJA2Cd6OHIzFOlB6G/nz/Y0jnDPYMkWyuXjzQDR8mwkhm/WoB0XmC0GsM65T9Q2arK9fFVr5WwgRWOnYrK1HgP8lWH6BFk08FSTWZlM0Nu48Lz2FIKZmE3fnbYEC4yZzsWJCr062agUgskdXTKLZ4qLU27oyg9gC/5BuyTOqIY0ym4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sUtyRzyU2X/5L8qtvUfjHP+2SVXxP81mWDh1Of6sls=;
 b=JWMiwXzNiqiOjlBD+gmAlAWXLcpT4kC4lRUGBL4iAJAF3opUQxylUVz2aB5dST+coYssMF5Fh6RgICWhlnG+eI9u/GR29pvJIEWZHly6urfoSrIaiMVHn5qkomUIbjGlNigrb4JnG8Dn2pimUVEb51h3qEksdlxylLVWM9uGu3u7ePfoQ1DuDbl/eqM4qd4vSl/37dZgqYgxzeetI+eJ6iUoYdn81VKto5ObDIYHOAJzvXJVtBwqxWzndSq3+kIrQBFLjJuZmtNUZEtkS4x3KqbTkz8TBhiErzrB7G16Ib0Eygv03/ufay4bu+fBX/KkM/FGCjuqSEnRWkNoXybo5A==
Received: from DU7P250CA0026.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::9) by
 VI1PR10MB3197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:12:04 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::f) by DU7P250CA0026.outlook.office365.com
 (2603:10a6:10:54f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 07:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 07:12:02 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 12 Jan
 2026 08:13:26 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 12 Jan
 2026 08:11:57 +0100
Message-ID: <faacf28a-7877-4500-9c2f-f60589462ed5@foss.st.com>
Date: Mon, 12 Jan 2026 08:11:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] spi: Drop duplicate of_node assignment
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
	<broonie@kernel.org>, Varshini Rajendran <varshini.rajendran@microchip.com>,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, Sunny Luo
	<sunny.luo@amlogic.com>, Janne Grunau <j@jannau.net>, Chin-Ting Kuo
	<chin-ting_kuo@aspeedtech.com>, CL Wang <cl634@andestech.com>, "Manikandan
 Muralidharan" <manikandan.m@microchip.com>, David Lechner
	<dlechner@baylibre.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, Hang Zhou <929513338@qq.com>, Jun Guo
	<jun.guo@cixtech.com>, Philipp Stanner <phasta@kernel.org>, Charles Keepax
	<ckeepax@opensource.cirrus.com>, Bartosz Golaszewski <brgl@kernel.org>,
	=?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, Shiji Yang
	<yangshiji66@outlook.com>, James Clark <james.clark@linaro.org>, "Jonathan
 Marek" <jonathan@marek.ca>, Carlos Song <carlos.song@nxp.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Huacai Chen <chenhuacai@kernel.org>, "Xianwei
 Zhao" <xianwei.zhao@amlogic.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>, Sergio Perez Gonzalez
	<sperezglz@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, "Qianfeng
 Rong" <rongqianfeng@vivo.com>, Haibo Chen <haibo.chen@nxp.com>, Gabor Juhos
	<j4g8y7@gmail.com>, Md Sadre Alam <quic_mdalam@quicinc.com>, Rosen Penev
	<rosenp@gmail.com>, Luis de Arquer <luis.dearquer@inertim.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Cosmin Tanislav
	<cosmin-gabriel.tanislav.xa@renesas.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Longbin Li
	<looong.bin@gmail.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?=
	<clement.legoffic@foss.st.com>, Alessandro Grassi
	<alessandro.grassi@mailbox.org>, Chen-Yu Tsai <wens@kernel.org>, Darshan R
	<rathod.darshan.0896@gmail.com>, Aaron Kling <webgeek1234@gmail.com>,
	Vishwaroop A <va@nvidia.com>, Haixu Cui <quic_haixcui@quicinc.com>, "Darshan
 Rathod" <darshanrathod475@gmail.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <asahi@lists.linux.dev>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-rpi-kernel@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	<patches@opensource.cirrus.com>, <imx@lists.linux.dev>,
	<linux-arm-msm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, "Sven
 Peter" <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Wanner
	<ryan.wanner@microchip.com>, Michael Hennerich
	<michael.hennerich@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Kamal Dasu <kamal.dasu@broadcom.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>, Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, William Zhang
	<william.zhang@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, "Anand
 Gore" <anand.gore@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, David Rhodes <david.rhodes@cirrus.com>, "Richard
 Fitzgerald" <rf@opensource.cirrus.com>, Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins
	<nick.hawkins@hpe.com>, Yang Shen <shenyang39@huawei.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"Lixu Zhang" <lixu.zhang@intel.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Avi Fishman
	<avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry
	<tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen
	<yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Han Xu
	<han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, Linus Walleij
	<linusw@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
	<haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "Chris
 Packham" <chris.packham@alliedtelesis.co.nz>, Heiko Stuebner
	<heiko@sntech.de>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, "Andi
 Shyti" <andi.shyti@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, "Paul
 Walmsley" <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
	"Orson Zhai" <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, Li-hao Kuo <lhjeff911@gmail.com>,
	Masahisa Kojima <masahisa.kojima@linaro.org>, Jassi Brar
	<jaswinder.singh@linaro.org>, "Laxman Dewangan" <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?=
	<j.neuschaefer@gmx.net>, Michal Simek <michal.simek@amd.com>, Max Filippov
	<jcmvbkbc@gmail.com>
References: <20260108203004.3538449-1-andriy.shevchenko@linux.intel.com>
 <20260108203004.3538449-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260108203004.3538449-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|VI1PR10MB3197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5c2bce-94d6-45d7-965b-08de51a9e2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|32650700017|36860700013|7053199007|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnZWRDJoUC8rR0xOTER6aDdYSlN3bWdqOXJnelZzSlVLeXRscDI2ZURBOHBB?=
 =?utf-8?B?dHg5YWRmZnpFVllnT2pBQjM1Wm52bVI3dUZmSHlibGcwWEQ2K2QxNEZKNFR1?=
 =?utf-8?B?RmtuOU50Njc2dWhMbE1Ma3M1c2o4VUFreVNuVEQyR3dHTCtiaGM5aWJweUFG?=
 =?utf-8?B?MUJGeldDYnRSUllrdGVKMUVVYUVCTlh2RVZCWDc0T1VQMWU5RmhKa1ZleUhK?=
 =?utf-8?B?SkEwL3ZyT0djV3QrNEx6UlpqaTE0K2RJNFlRdERoZkQzQjhQM0hDOUhoUHZl?=
 =?utf-8?B?Vy9GQys0QXhXbHRiVStlbURnczhLRUowTXl1Tk9XRzU3cjQzL3oxUGR2b1Bt?=
 =?utf-8?B?WU9CdXVMVFdjenFuMDMxTk9URGRQc2s4RVVycVYwaGxtVlptUDZXcmw0MWhm?=
 =?utf-8?B?S3VSNU1PUDkvM3dPaDVYNXJTVzE0aHUyY0o4U0FUZkV3Nm1CMDFSSk5HaS9m?=
 =?utf-8?B?akpObmVSTDRFbXdyM0NPcHFGRVlqZW55ZHdma1dGVmZ6K2hKelU2WlFRazV0?=
 =?utf-8?B?TWJLQm10dW1uRXVLV1FRU3A3V2pwbHFObTAxRVArcjI5aGZrelVYQW9SY1RR?=
 =?utf-8?B?R2EzMUtGejdFSmkxdkluUTc1MUxzZzIxZFhvUUlpREMrYnM4TEFndmVadVps?=
 =?utf-8?B?TnVZMlBtQmtSVmgxbTlzckpmd1c1YmhMWEJUdHpsOEtDM3ZDODh3OXhqNUVK?=
 =?utf-8?B?MU1lcUFhTEQzTkdVQjBpSmFFSldnc21sTU4wRnQxaWhOaDNqSnZnTkVSZ2pu?=
 =?utf-8?B?ZCt3TlBkQWZzL3Vtem1ZYzI2a05CcDk4RE12bUdBZUNta084ZnN1WXBUdXkr?=
 =?utf-8?B?UTl3Q2F2WmdqVEV4dTRtY1ZXQU9HN3BSZitheGZYeDYxQUZLODFZSHNJWHEy?=
 =?utf-8?B?UHNSY2VsQU4zNksrODd1T1dhYkY0b2dVeVEzTFcxUUlVaERQUlFwQko0L3A4?=
 =?utf-8?B?SDVGeCt5Vks4RnlGMVZTZ0lsMGZqeGVtQmRoZjB5SWM5YVN1RUp0dWltRTZN?=
 =?utf-8?B?bG9Dd0NxNVhhVlZQeVE0dGd5cmdibXk5VWVRblNYVE82QlVWaGgyUjNwblhD?=
 =?utf-8?B?YkNVN082dnJoTzFRLzQ3RTZXdWVlWE9udjNYbUU1OE1IQWhJRzZWMnQwNzI0?=
 =?utf-8?B?dE9Tc0hSTVNNbTZiem9OUUtqNi85QzhZS2wzUSs0cXBrNTZEaWZCZTl5ck0x?=
 =?utf-8?B?UmlPK05YSDVKQmR0RzlMeXp5bnZFQlpVc1lwUTV3cWRHM2k4MXk5aWd0NE1P?=
 =?utf-8?B?UHV4VXRRQ1krZmpZU0xJVVJBOE9lM2FtT2hpZHVXb1YwZFc2bi9rRU9oK2tP?=
 =?utf-8?B?T0svRmZ3clFsYW9UZnNRY1BFNGJFRjBhalpPb1ZUdnpCOFVQWFpPRmRsd1NQ?=
 =?utf-8?B?VlM3OEhyWTE4bjJ5UWJKV1p5MHZvYWlNcTFTKzhtU2VIWkJKbzZGcXM0ZjhR?=
 =?utf-8?B?bXNkQ1hjeThtVzhWQ1ZzZ1prMFNBYmdoYkMrNU9NZ1VJOHVNaHhyMlRaRWhG?=
 =?utf-8?B?bHRwVjVyc0p5Snl0aE42ZHN0bTIrYnVPVkNGM1lja2o1Q1o5cTJxOXpuZDFj?=
 =?utf-8?B?NWlpSkliL0NIUG90dTBSSFVFZHgrYXEyVVRYK0JmRllDR1ExazJ2RDgySmk0?=
 =?utf-8?B?UGNvQWxDdVFscXp3Vm5uUEpESEFjakEzQ2hEWVNjZDI0Qys5MHNmWkdHZWdj?=
 =?utf-8?B?dUdTaGM2TUttMHorTVlxRW4wL2Y2MStVQUpQWGZEQVpFb0c0ZmVyMythU1dF?=
 =?utf-8?B?ejlMcGQvZ01NdDRlMjB0QWhqK3lFWFozNTB2aTh3WTFLVCt5akgrMHVnSkht?=
 =?utf-8?B?bEpWNFkzV1haMUtIRnY5S3lUcGhoQy9MZUFZSnpYcDF2SVM1MExvSllnb2JV?=
 =?utf-8?B?a3o0WWtiRk50UVJnVFNLOUplcnNucndNb1AxVzBzMExaR0IxdUwyN0REMWtF?=
 =?utf-8?B?UlVGOXVMSlVJSWt0VFE5WS9oSXpNUklhRHJBU3RtZzhSKzFWZjFkN1NXZzU1?=
 =?utf-8?B?VGdYYjZJNCtEMUV1WXA2Z29JQlRQVVRzaFQyS2wxQnkrWHVnN0dUSGR4YSt3?=
 =?utf-8?B?Uk5PNGcrYW94WDk1aXhQK1BydWFFalhoNXl2UUZNTTRmT28vZUZSenltaW5C?=
 =?utf-8?B?K002UGkyL3BkcEQxa3MzSXdNUkVsZDR4RlAzdTFOakkzNFNMd09rUlowcURr?=
 =?utf-8?B?QXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(32650700017)(36860700013)(7053199007)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P6BK0ZgB8SUTDfdxaJ8c8uL2dwTw5IEdwkAzylPE9GisUNIQvtA5bN+iI85qmoZR8i60+K5BvP6ArNOViQn0ERimnfKEfjDW+qbxwC5iKX9HkBzfP2v7377aWnloj08itWVqr2QWGH2HO2l601gVnXYqiIk3J43SxEiqnn3aPUgWOvWR3PshG2P+DhiOony75p4grRcx/VJiH15Kpf+oekulACyL/ix2yRIW4Qcfqwmk8U+1U3yZF5kFs9V82SJ2JB9aXDJyxRy7dbiaaIf4DHIum/Mh5OcmsBMb6j0pqyBxRbCsFqrfj8VPj5ZW71yBpCNFxfGyFgprSD624xGOAe3LWUe6M4rXcIg6A4eIBSTkq3z+djWm+KQS94f2BNUYlBv95TTKNP651EKDI86sUgWoig0yBV2TuLLdTyvATXPghfUrXnq87/L9vl+TKbIONKtNb6EVBumKiP2oi9X7tdhuLMjtFuNfK8K33b9p0F60nVvHyaQbH9rl7PQ/eCrCi6P/WzSwWHUk5TgDE7xXdR7/BfUAEfXVvCas//cGrzr6edD8AGoxHAwls8yWjtmbtdvEqWLOoFhtD0k+txJuD0ofeWOyt6LAYwTWmtd96915CwgcqXxaekOrYWjKNn6C4RJJSQHBEXjXfwmajIxQGbgZ3rwY7epTWeybKuFvwrPk06eiGxF2YcrjI+amIA4b
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:12:02.9802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5c2bce-94d6-45d7-965b-08de51a9e2df
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3197



On 1/8/26 21:23, Andy Shevchenko wrote:
> The SPI core provides the default of_node for the controller,
> inherited from the actual (parent) device. No need to repeat it
> in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

>  drivers/spi/spi-stm32-ospi.c         | 1 -
>  drivers/spi/spi-stm32-qspi.c         | 1 -
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks

