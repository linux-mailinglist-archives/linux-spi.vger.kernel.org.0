Return-Path: <linux-spi+bounces-4650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027E96CCEC
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 05:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3CF285867
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFDF131182;
	Thu,  5 Sep 2024 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dMxPRpx3"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2225634;
	Thu,  5 Sep 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505560; cv=fail; b=bXoNQDdSXTaRcNTjmx6dIYyrktlDtWqzUhg0PbBZ34Oo4nzBqwsnMwC7vu0Z1temceTtONOra/tPBklo0B4fldEMhi3QaSUT4JGfEIpAlh7B7q6MINn62VXYCY5i6A3lboEcHNEPjZW8IgH6DXmGqvNl1Xn/lT7CYQ84vaqJUYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505560; c=relaxed/simple;
	bh=qC5uYqK+Db3G+eWc1bXsErOBm7KvOr7qghPbcYu0ct8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3AmHxSUklEcyxSGRRhHKFfkznXba3hZiLBA9qwA/nos3iC6KVAdaYReZ+dZ705BMrKJEk82c2NfJqxxXf1T+qrjUlIqBy4u2h7wyeweiPLECBi/2cH3weOJCnvHLbRcxeOSu2Xxo0Q8brJDSHRsOAXjhv1E3Jz4bW+D8mm9gwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dMxPRpx3; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoZvb4kZF0YbQwIOYOWqizHknUWzB/wcaGyHt+mwTg9z4G/WLO6e2c/+vezRY6lvJKcvG1Gq70BOy8Zwcdl0WQMUddXVWfnLssrx48Xf27qla9GU1T76hZ0Jk3+9a4t4d+TCV5FdYrOI+T4RFglLT5xzOjEWLLiV8ZMipDEHavTkOHdqg3dVaHRiMp5waceD9ejVB4tWSARf1c67dszrStSE46DKbgqwjivO7wvNq1KCa2PNHGMNU0LZ8CePRLdMeqMR+cHWbp+G++G9Hnf52zRTXgvHM9jTDWAkdFF0gQuu+Hb6xjebR87Kg9h+DuEJoQ1XBOqo9wKHIOs3kOLiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZblqvOaSqU/bmZFT3A/1RDuCNc8yLjfR4yT0cMZ5Ho=;
 b=jAFwmSsxr3gi7vzUgu4LYQ70Tt/nF3GnLB6FDEC1x0I+4yr7Ob+ahqRDpAWh8A7j+8yu4KBMHl3do9a23SUYqFV6mWyZRTx+qL+LXbgxduEyku6sd7B6+w2EiuXvIdV0ZLJf5vLwafx43Z+oQEjT/jMek2b444t3PNPE9B5W29eyasjsLQjiANjiP2OImbjbB6tHS1ugNPX0VBf0CAPchwDqriCN6urYm+MAJhFfY/56IRFDyJGGPRdZmTp2InHgud36i9oBenNVavK7V18icpMd6Kp8vPpsZb9cwhXo80OoQmNb7yAn11TOi/BBsA8md7/q1W7T5DItlKbT3yIbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZblqvOaSqU/bmZFT3A/1RDuCNc8yLjfR4yT0cMZ5Ho=;
 b=dMxPRpx3FvvVFl7QoJryrVlHqd0oxDXnQGXqDUbZhH3Gbst/JcKHclwftDzsZChFl5QrOGZ8KqQ7RH5PbT2yJ0IHndZkWZyBMVY1D6BxS4+GIK+VfqB/IILM1j3dbeyfCEXg3/vxEY4bCH+EkUmMV1sMI5rjUWjXi/F6zUtSahH+Apd1+89U9h4M65l6efEG1ounCSzswrD7vLRJ3+t2L5CijaqURBRitAaRQ6NLi/7NoLVkmhxjJLd8ARSUnjh3vMmJMSCepEoxWT4vcVwTn8NYHB0XoY6X0soPljRly6fxRKUFS/dr7FhOhX6s27dVAYRRRpm3dkWd0LVD6hyvKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 03:05:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:05:55 +0000
Date: Wed, 4 Sep 2024 23:05:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
	"yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>,
	"hs@denx.de" <hs@denx.de>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
Message-ID: <ZtkgCCAWt+Oof9xI@lizhi-Precision-Tower-5810>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
 <20240905012617.1864997-3-haibo.chen@nxp.com>
 <CAOMZO5ALKfz-w3taJBwCLu+pAnrcGaa-9=EtLH6FFJWBkq=t2g@mail.gmail.com>
 <DU0PR04MB9496D185069B3F9D3422BDAE909D2@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9496D185069B3F9D3422BDAE909D2@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: f97dbf33-d3cc-4491-62f8-08dccd57a86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGJxMWoydXQyVXNMOWNFQzEwWWU2Q3NOVGJodjlpM2JqNFpJZGY5U09CTG0w?=
 =?utf-8?B?dzFsUUM4RlpLWGZDUVY4eWkra3pwVUN6cENKUXJJdVRnNU9CSHZnZk5ES1R1?=
 =?utf-8?B?cFRsZjUzd0lGYU1ybnZLbTJWS3dtVDdSNENOYVZtMkRMdEdVZEQ5OUswVXZ4?=
 =?utf-8?B?RC9PdWNlYmhUT3dlT1AyYzV5MVBJZnFzRSs5MnljbVB0amtiQ3FZMndNajh5?=
 =?utf-8?B?UndHSm9xZmtxWWN5d3ZDUml0a2ViT1JEaWIySzBZKzk4UVJXMmRxTFBSQUpk?=
 =?utf-8?B?b0hTMzBtZkQzTndwdGVJeDN0TnJqak1sdzk1bndyYXJNNUxwUFNDRmlkeFZC?=
 =?utf-8?B?bFhxMWNXcTFuMFdXQkprNGtuTkx0K29ZcE8wYitZTE1ONVMyU2toeURFMWgr?=
 =?utf-8?B?UGdZM1dqd3VRZUwvaXA2dzlYVjNneUVqTFkralpWMEhJR1lnbFVqQ1hvbkNy?=
 =?utf-8?B?RkVIVmNvUytPNDVFWkc2R0I3RE05QUd1alFTdFUrKzh3YVVhK1o3aUxhNnZ3?=
 =?utf-8?B?Mm52ZFBuVllYR2d1UlMwdFlWdmFWK3lObjZOOVp0bllPbTNTbU1yYnBrYzdt?=
 =?utf-8?B?R0MxYlZBU1kwWUIrdG1oL0g5RzMrNUhlb0RIb204S0lQUFJEK3hwNTVJZzFq?=
 =?utf-8?B?Y2tBdlVzajI4Umwxa1BBSkVXRjVBd0wyb0ZEaVA4QWpPS3pBcUZjejJmZmt5?=
 =?utf-8?B?ZzgxNVozeDI4SXhQeXdvOVJzQTBXNXJvMEVqblVsd2ZGZ0ZaR29vbG80OWxP?=
 =?utf-8?B?OFVNOWFWYjFTbC9zWDNEOE5ETlRRU05BYnlMak9kK1FsL2kyczBkYXBoSUor?=
 =?utf-8?B?MGExZi9zNjBwTlVyb3FIeFdBTlkrUGRJYjdEMFlYMVVZYWJtWFpybFYvdmhI?=
 =?utf-8?B?Y3d0QlVKQ0ZKMEtpLzNXS25LZzdJc252VXdkZ2E1RFVxVG5ZOGlKL2JxbUQ4?=
 =?utf-8?B?M2ZNa0o4eXpzYnZLNHREazJvMHlkcVY0R2xseWt5Wkkrakk1QzVHVDFUcHMr?=
 =?utf-8?B?OXRlV09mYzhnZmVBUHoyelBWQW9kK0dMdGQxTndMWUZ0eEVxS1h6dHJrenVa?=
 =?utf-8?B?RGNWTFdnRDNlZEpsakJoNm5HbzcwUGNxWHZrYVFlUjZFaUxIMnFobXo4ellU?=
 =?utf-8?B?QzQycktBUW9mai8yQTVVZGRsdGphekphVjkzK2pibWVvYjBGT0xpemFqN3Ri?=
 =?utf-8?B?eXJzMVM3L1phRWR2aHByb2p4ejhqMjMybmxZT054cTV3d1ZnUXYxMTFPS3ZI?=
 =?utf-8?B?ZWJKTHdvb0oyNVlZWi9xOUhjWlBZblUxM3A0ZXVhb2V5WExTUjBCZjV0YURE?=
 =?utf-8?B?aDlsLzBiQkJsTHBDV085TTNjQUxBRGVqeFNWOThJa0NZWlFrRCthZXYva1Na?=
 =?utf-8?B?SXhwYzBRMHNFbUpJdVZncUdzc25qSjFqSTJpeVR0QjgxN3IydUFpY3lybGNh?=
 =?utf-8?B?eFlmUTNDNmIvOG82MzZ6K3RBSCtlTHU0S2g1UCtLeGkzM0RTaG93dWdOeEN5?=
 =?utf-8?B?bDByY0VxMFAzSkNxRCtDcFdrQjBVRExvZWFyYWhVanpzUFN6ZysxZUlraVNW?=
 =?utf-8?B?aCtXMUpFelg3Y1F2REpRNnpIWUovazVUcmRaN0Zwb3F5M1UwNXVQS1VNeDRR?=
 =?utf-8?B?eE91cE1KVTZvMlZsZExpVUVGRlBBK1d4VzBTdjR4L05FTWh0dTd6UWRZRUJL?=
 =?utf-8?B?RE9OWFFSaiticzY2QlNIeUpzc1RtblArNnQrN2EzNEI4N1RROEJ3c1FlaEtQ?=
 =?utf-8?B?blowWHl4VFEwYUorZWdXYzBOa3QxZzNVNHpXNFVLVHhXMlEzUWdPRVFLRWxR?=
 =?utf-8?B?RE1XYm8rSkhYMGE2WG9UbHBWS2RFM3dmUWEzSGVkRm5GQUY2WXY4amUvSTRR?=
 =?utf-8?B?VFZzTS9KZ0psMXRuU1p4aUFTWEhQaTUvZHBFVWRtWFBQRGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2lFMDB6Q05tNkFValZoU3hmRFMycWRHY0t5ZkpTd1ZNMW0yUCtzckJidUZO?=
 =?utf-8?B?Njl5VUt0UGRpcDdsd1hnS2xKRzFLS2VXNXprVE1nMVRISXdSWFlreWl5Y3Qy?=
 =?utf-8?B?U0ZyQUVhMGZCaGVUQlVlRVRFOVg1TmZiaHlPTjdwWHdYdktIb1BIekE5aE5v?=
 =?utf-8?B?RFlWL05ndlRqQ1RWa2dGT1ZROTZyOU1lSG5sRkpoYWY1WGdQY2RzRncyNkZv?=
 =?utf-8?B?YW5PVmluOExYamFDU0Q5MSs1ODZKUXlmbEp1Ukl1cFQ3OXBxbWNObkwxYUsw?=
 =?utf-8?B?UkpjWUtFb004Qk11RVhucEZsZEo2cnNPSjlpRzRRL0VyWmJlK0MvUXBvRWFD?=
 =?utf-8?B?Mmt3Z0kxVGdOL0Z0dU81bDQ4RkkwVWZmVHhtYlVvQWtyWmpaZHVVcWx4ck1y?=
 =?utf-8?B?SXFCb2RTWDNENXJySldOWG5jTEE5TlVkTjJmaTJXSk44SThyRlh1UE10SzQ0?=
 =?utf-8?B?RklzWUF2TEtRRjVrTktZbFhuekplTHZvaW5VQU5sZFpxYmNjQ1pFUWpBUGpR?=
 =?utf-8?B?NHFGWkZzM2xVeWYyVGNnVklvYUtzT3J6WTEyQjhkb2xIUWRNV1pCL2hLVmF6?=
 =?utf-8?B?TGEzNGdkcUtWYjRRckR5bmxiTVdyM2VIVCtPSGRQMWdWdGM0UWlEUEZGYkwr?=
 =?utf-8?B?cUtkM1BueVRoN2dZNTdESzlMOGZjdEVZZkZQSDE3Zjc5ZjFqQXlrb1ZJeVd4?=
 =?utf-8?B?cFRBR2pqT3dTVnhqdzdjSXNHU29HTk5VRmExOXE0bjlub3JlbzhEWU5VN0FK?=
 =?utf-8?B?L1p2RG5lSms4WkNpWDNBQ2t5UVB5TUFjZGE4OXdCNlhCK3VEckNiaG4zMFFp?=
 =?utf-8?B?WkQ1dDlkY1NDNzVmR0tnUTE1RjU3SmVDelc5ZlNKaE0yMDk5M1AzTzhycXNl?=
 =?utf-8?B?dlpHV294L2NiSkdwQTdwckl4NEtWUkVESnk2OTNUWTJubHFIOTA0NU5ySmgz?=
 =?utf-8?B?T2dxcWZEVGNxVkxpSklUTnFkMzFwUlBKbktoaXNBUkJRVEFjVUtvenBwOUFE?=
 =?utf-8?B?SXo3RGhqNFpHbDZRaUdWWFVOaVlKcWhFcHhwV0dQa05oYkJUSWpuM0xQZy9n?=
 =?utf-8?B?Tm1vNkFDZEtmbVJzOUFmY05LVy81ZGkzajZjNnNxWDZkOG1NVURRTjFFZlJm?=
 =?utf-8?B?bVhQZzdpMCsxUm96bmZWMjc3aUZJUmM4M0l1THhVS3JXVkFRckR2SU1qNFh1?=
 =?utf-8?B?TG5NZ09vOWtMTHlyMHdqaVgwSWFWWTV5S1R2dzdtYVdHMXBWZVY3NlBwcEFJ?=
 =?utf-8?B?MG8vZmpyZHpKblF5dVNQQmphejRlbEZwa3RuckJSR2JGWS9Oa1REcFEyK05D?=
 =?utf-8?B?THlHQnE0WmFnci93UzFFaDhXbjA0SGNzRitUOE5BalhXWnNVZXpHaDk0VEsx?=
 =?utf-8?B?ZTZTUHRJWHZPM2hHckJZa2NMaTlPdW1uOWZONkZVM04xaXA2RUMzZnUyUDRi?=
 =?utf-8?B?YStiSXl1czlOUWl0eWlKa0JNNjZZeldDM0JZYUhaYXRqeDRXL3RROTI4aTl2?=
 =?utf-8?B?ODNtWVhEeWlmUytZQ2kvemlHM0lBS3VGbTJ0Wno1SWEzcTBmcXJmd0pORWFv?=
 =?utf-8?B?L1ZDV0hmaldDVW5ienE4K1IxMUN0ZmNZNEdLbDhLUEhxdzFGelBieEQ2SmlH?=
 =?utf-8?B?RVBSdDlzTllNK2h1SHlFamE3U29QbFJSbFpUTkRKSk9kZHladktHc1JYbDJt?=
 =?utf-8?B?aU9EdURwaThSUktwcEVJSnhLVzdZWXRwY1pBSU9QbUxySSs0YWpwRy8vSTdH?=
 =?utf-8?B?UFlrdENPcWVBMU92dWhaVlU2M2NiaERrVlhTSFNnaWI3bk5lVVpCZEt5R0Z5?=
 =?utf-8?B?MHJXTUt6RXdaSHRoMXk3OWkwSWxvcU5yTjN0ZTN3eDhHVGsvTmRNRGxRWTFq?=
 =?utf-8?B?S1R2THcwczhjdkJaczVFZ0MreTcvMDJicm5pUXFPZ2x2ZEliSmdkdjJBSzVO?=
 =?utf-8?B?cXFlRTFYaEVsckVZYkduR1NMSzJPWHZ2SFg5YnlUV1JCMG9jSlVjc2JzWlNR?=
 =?utf-8?B?MUVEZjBvd2NpMlF3TXpkMzhJUEdwVUxUQ3loUTN1Y3dOSXJSQ3BRYzhCa1J4?=
 =?utf-8?B?STRyd0xSYms3M2R1TjhBUmlZSHM1RHlya3gybmIzd2I5YjJERUMxemdaS3Bx?=
 =?utf-8?Q?bOg1GuVGMR7hSbibtzKSCu1pw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97dbf33-d3cc-4491-62f8-08dccd57a86c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:05:55.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh7eyMhLljvb9VYeMBvJWIafsi6i4bJdlstWI+apHx2+eDXZrY2r01DtUMmIVXKmX1YOZtXX68AUnWg3osIaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

On Thu, Sep 05, 2024 at 01:49:03AM +0000, Bough Chen wrote:
>
> > -----Original Message-----
> > From: Fabio Estevam <festevam@gmail.com>
> > Sent: 2024年9月5日 9:38
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Han Xu <han.xu@nxp.com>; yogeshgaur.83@gmail.com;
> > broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; singh.kuldeep87k@gmail.com; hs@denx.de;
> > linux-spi@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
> >
> > Hi Haibo,
> >
> > On Wed, Sep 4, 2024 at 10:26 PM <haibo.chen@nxp.com> wrote:
> >
> > > @@ -373,6 +367,16 @@ static struct nxp_fspi_devtype_data imx8dxl_data =
> > {
> > >         .txfifo = SZ_1K,        /* (128 * 64 bits)  */
> > >         .ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> > >         .quirks = FSPI_QUIRK_USE_IP_ONLY,
> > > +       .lut_num = 32,
> > > +       .little_endian = true,  /* little-endian    */
> >
> > The addition of little_endian to imx8dl should be a separate patch.
>
> Hi Fabio,
>
> I only add the .lut_num here, do not touch .lettle_endian here, and I add another 8ulp in the follow line, but format patch show in this way. Anything I can do to adjust how to format patch?

you can try below diff option.
  --patience
           Generate a diff using the "patience diff" algorithm.

  --histogram
           Generate a diff using the "histogram diff" algorithm.

  --anchored=<text>
           Generate a diff using the "anchored diff" algorithm.

I suggest split to two patches, one patch convert to hardcode 16 to
lut_num, no function change.  The other one is add 7ulp part.

Frank

>
> Best Regards
> Haibo Chen
> >
> > The comment is pointless too.

