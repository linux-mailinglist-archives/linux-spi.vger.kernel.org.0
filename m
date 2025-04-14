Return-Path: <linux-spi+bounces-7562-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F84A8750E
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 02:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA60B3B2DB6
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46514F117;
	Mon, 14 Apr 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="cp2qI8y/"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48D14B07A;
	Mon, 14 Apr 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591508; cv=fail; b=XYtGGy1seJhcqvDxsr1YIBY/IP3DLBzHbzDWP9iwTic4MepR1tiaPKS+pQ++kX8SNkZkfWhcM24RwJ8RDSYIWxYr2Xw8nURYDp90dP1S4wai7co1k0hDvizbTECUAyJagsqrdbY/IRD3YKGfuFUMBqwgpB7enKUtPQu3g+TyCtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591508; c=relaxed/simple;
	bh=kngjR/znO1IotHE7dsbRh4gg/o56tFcWtT7z3rbIVrE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gpg2L4+DzqoidkTsC0tWBY9L2td1K+4LA8B+Ub7yBJP6jmaSAeqlwJzuuybRaDDXH/kWwaKbnXcTlI5mrow8rrZBWvP+QbSLLezxkU48cWdvT33kIS4xPR9qyFzZ+Q770O4hsRW9kNtxqz190+x7meHBHMvpNmAuc8olOno7qiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=cp2qI8y/; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glTXmbsYU2RFLC+9ZHX8cqSGzy5f0zcQ8MVlDB1OeXcGb4jalCG8SUH5kUQAgP5tCh8mWiHjoH1+WYIe0y/illRG4mBg0pcpvvzIu/aKbOuf70vQv5b3Sn8A6/N+Lc8T90DqTH7K81o2suaUB6A+m4xHhBsJ0dJh55qP5PVuF2A9uEwLEStcPBYCacIvt1IpXHsjpDPHLVUGQsITabhRooXaQl+nILf/7qIhaNqlok/c8zNpEix2LXtgq18Qu+hsNM+PndfWlo72PNDEFdA0bNPKEEWodMlN24adSXbUI/v1M39abfYXnucoFSIzB1bq4penKCR6QfaKe+9XZ43WvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEIhNgKj2+FWyx0l0GSz8v1BsWTU/KHaJ4b255uM2i8=;
 b=S5/F3J54Z7bRXN11oh0L5Rl7s4iFcpReR2ORyQq63wqlboy5VgLHQDKvhCSJi1y6RXx5eTCjK7OU0ksJXZkLkREVji7wZIAC33ALu2y9BDhJYYVzmrQ2a5epQL4nvoWXk8IqJBSTvc/I9YnAWH7xHPszAW+834MMMGe/Ts446Gkipu5wc7ElL38+lnN/ZODFmQTLbXCg73s+KAUI/e9tK6iCQzU4Tf5gvqZHY20er8p7plHQIG3Mri3psdy3PjGPprZi3rpmdQKgSUENqfeMN3Jx6zltTuPc4sjJAxJk4URkniLWLryN5inneZ3ZP7DELulPViybGiOS19p4HKsl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEIhNgKj2+FWyx0l0GSz8v1BsWTU/KHaJ4b255uM2i8=;
 b=cp2qI8y/AnOovRtHx8G38315CCnzOQ+pKR4E/JsEW9srTXh3/a9Hg3rcVEuFqTAlzECk7OB/SYqL4Qdp+gq5+14XQ8PxjjvVKf2GvnM5m6jTG9uyzi7WhL4jKcDfve/nC6n1Te7u3ljo2+a/7bhjVAzHcgqnnEMqBOKilZF8fxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYYPR01MB12862.jpnprd01.prod.outlook.com
 (2603:1096:405:157::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Mon, 14 Apr
 2025 00:44:58 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 00:44:58 +0000
Message-ID: <87h62rr2pi.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
In-Reply-To: <20250411194140.GA3767706-robh@kernel.org>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
	<87frifh5ls.wl-kuninori.morimoto.gx@renesas.com>
	<20250411194140.GA3767706-robh@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 14 Apr 2025 00:44:58 +0000
X-ClientProxiedBy: TYAPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::24) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYYPR01MB12862:EE_
X-MS-Office365-Filtering-Correlation-Id: d91c1239-5c60-4b0c-e6e3-08dd7aed94f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pb1fAzyrWrsSQ32rLpdjhYAX9mBnCimNwjCOFONGyZtLcQHy3rSSMnVvERvA?=
 =?us-ascii?Q?lptlo2cPn9HAjtH6WZ8POsCwjLF4Wrrx+nvYc9GkpnT05klTtMT/rEbP8INR?=
 =?us-ascii?Q?2GmYTj/JxeR5Z6j/xq56vWRuzPTt4GBQlJMZS8hIjDjEoAsgLD1N7UKl0haF?=
 =?us-ascii?Q?wbZSF5DusHH2H/uFAmEO2vfgjxDH/gtIWOH09cZet+eZ/AGzMiwJyYiJB1F3?=
 =?us-ascii?Q?aWWa65Heps1QwOeBAhBYcEShFJrDRIoLboQ0XgeFgfvaA69CgYlEYh4eSfD3?=
 =?us-ascii?Q?1pSylWpGXIpLeyrGg2fJOGPtfVNY6U5uxXulmgzgNClistb+255J1pxzvv9D?=
 =?us-ascii?Q?08MAFBydTnOaP8sCakIZx8SeK8bn3O8drCuJKsSuh5l+LXHHvuRq3AIox9a0?=
 =?us-ascii?Q?Cc2yjKAr47NXL5T6bLrmTynoYXC3RHPfcDnhPKamMMlL4icHZImbaPDI2jhg?=
 =?us-ascii?Q?RvdEI7attoJWFO7JnVlJUua7DggCxv/4f8FmdYW0IwNqVimkFl4GLrzK+KI8?=
 =?us-ascii?Q?YpqBN5RfeaGFKKA1TfPDxSNS1q0xOGe1dBlmTX6w0poMJaNQfE4JxgyiT0PS?=
 =?us-ascii?Q?UO9I+oLrB3fH5Kq8wK8G2xJtBo4TNt48+FWx2iXEaOwrzRwD1g5UkIhXAGxy?=
 =?us-ascii?Q?8XGuxeaMXs6YGMbUSjrdwv3vpK5c3QDmDWFYXxnCwRs82eBgV4IqVKbJSCb1?=
 =?us-ascii?Q?XwxmK5kB8+jXXPiKi9rnvvWiG/MJ6QIMDcZbfd8wfh/6pYhlJVuZ2jd44eP5?=
 =?us-ascii?Q?7BZO9SVohsP+pQ8+eW1zhjUVWV9AghGYiet8+Ke1HKHzgDtOgPdUQFgNU5Q0?=
 =?us-ascii?Q?h6H4Tm9TDK5Mk5Rmh2v1pjeZT3iXx0QbiqL5HY9aW/4uFuyarlLR/w4YemTW?=
 =?us-ascii?Q?hTtecKLx5rJbKrFTz31gef72DRhv/9UZlR9CEZh+fv9QAYUqjwofOIKqKpNV?=
 =?us-ascii?Q?yMXTEnF7t/FAPtj6KXNLUknLfD0R+pauhot1w3Yyg55hK+zjM6hBKxA+blU1?=
 =?us-ascii?Q?1k8NVT0m4FnfrNhEypRa2G4RHzFBEN86I5dNgTMXPLs+SacnPiP4h4E8rZTt?=
 =?us-ascii?Q?+a+X7fH+1a1woGU4JaVBX/WG6Qf5BjviwRLFSNftHT5qjAJMcFNBCZKqIxmS?=
 =?us-ascii?Q?xvyzfldI6pEf8k9yfhSee98hvbdP+GJPKDqTZ9I+CgGqkFY/VHdeS/2YIqva?=
 =?us-ascii?Q?Bm0KgEleq6Xh5YsLucB4mLte9rBIeXeh/Ztjt4XA9SmL6mOkO3ZY3OYqpaDK?=
 =?us-ascii?Q?FU+FqY+CF/7ZHJibByBgCSgohVbgQNTj9hjAkxfzUgKJrtwHMDJPL2QGnTDy?=
 =?us-ascii?Q?Sg9U+VobiSdpvjEURZP40uCWf2NZco3daYTppuNYMRvDH361dzfl96siectW?=
 =?us-ascii?Q?/8BA91BvSoe2u4m1ZllG9C+LOpEi8jwm9BC1X41J7Vowownj4wq1BJQIPS0P?=
 =?us-ascii?Q?b9oI7IwS+jg3/fb+ym2rngPSBru5GON1bnMOnohkqGLdgBFD9rggIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDnpwGbIC4zNiYSeiD641zFEGfHteu3wRoBdz9Q5Zf8Fwk/ctJR+QAw+5AB/?=
 =?us-ascii?Q?aM1TPW6F4qwIlcxjafCBn5Li8CW5hqOlk15+2oRiYDuuUHvb8GTeYVus+q1M?=
 =?us-ascii?Q?m7lRdj33JAlFtFjhENqx1hxqAJDwgMquEORSLnwRHjc3yTZa7imKwRsbu+pB?=
 =?us-ascii?Q?0H+k7HwhbqLjZ0JNDeAUbpBQsI+aSiFd7501erCPn2lqgfVXRY5WVYcAgAnf?=
 =?us-ascii?Q?UTLatG4DKOJxv434TilEqrbhVf9eAozr74whpxeeiAqgwa2psKBpAnQ+UIKM?=
 =?us-ascii?Q?e6dg6ypeUJk7SkgmL/lAHZBcRhQ3Jhtvi7GjaS4A8vEElrNg7JJuzAx2tYW5?=
 =?us-ascii?Q?IZ3zwjWLSduopbexkiVMU18aktaIFo/SVlewbhp9MhjeZ9TiuiuObQUeVa1+?=
 =?us-ascii?Q?k8UDpOxOun0cBcoTG7F+Lw/lI5hyWSeMBIG5NmBxQN9MY43saE49trx9uUav?=
 =?us-ascii?Q?65JN4fAt2sf4kj3Zcec8m1iZbw28aAUNHCUUiX1uq2m3ziKsEnyNzByN92v4?=
 =?us-ascii?Q?K1zDfovT6wsg0ITz+eYGWV+T4k1sCEhDB/XBA7oP2stCi4pkT+qvUYR9T5Rl?=
 =?us-ascii?Q?bzwahIza60Efhcq3D4c94IVtGwO859eGHs76TaLNAxBDU3+oURWYVyS8iPoo?=
 =?us-ascii?Q?ckUeRJ/xoB355RxZStJteeM2NdlTk0x1EkPynyEDPqeqlBajQikwLFHVNgUw?=
 =?us-ascii?Q?1PUoadO9NZlIlhw3KeoyUXa7PY+j1eSkklhwGggbT5gPCn/mqJYCOXQrPIlh?=
 =?us-ascii?Q?lXFZNCGRrOS9TEkzO6dFkyExuB3+QqnvxWVrULysyO8I0r9C4Ukm5cGL8bN6?=
 =?us-ascii?Q?PbxTfudn5N0yMik9eS7JjMXkgs4NM9hacK8PGPXRmGyGZXj7skUOwWFhHCNO?=
 =?us-ascii?Q?dbfdR4bWksUxoxOfQ6WfAdKCwEkjBB6DIDH0J3+ozoLFN+KrDQTlnRjEQaf2?=
 =?us-ascii?Q?fVsylrMyO4Hz4X6cztaoz9RODXM6miotx07Sslz4vsrqDq2xOBR7y+oqxuEF?=
 =?us-ascii?Q?rV9VbO5Bd+LPCnWSA7cJmCMAKp7zGgVKvsyRfhuVLAYQMgPuyf84wXQb+zDn?=
 =?us-ascii?Q?e06seSTvSNXDmNh6jra/hgTeoiy4kaIpYXj8MbwBu4LWg35eeap4wUzNgtVs?=
 =?us-ascii?Q?ocZmL4YMgi62O4YNCUKtQv/6Pab29vnVhugyh59cPXNSmrt2INwY8VMwubGK?=
 =?us-ascii?Q?q7kqgHbWBSil4+tuOP0N6N81aNxvakPp8oAiYwHjHpJvWRXB+iuAy1NmrmyB?=
 =?us-ascii?Q?lVVTP1a34uJ8ur0nSpNXoBot4b/2BS2WxhJ4Xj+xQpST9U0hFBDRhiJDgX18?=
 =?us-ascii?Q?tbtO+KrePkK/AA+GiKqn9LYCFKDNZ2LKbgU5ujE61cymqCx1wooq/+FM86UA?=
 =?us-ascii?Q?ruYoUA6n+zzHCqU15wnGbe8ZyhzQjMzZ6kUEPvM+7o+WGX/awwSGvCaRzrla?=
 =?us-ascii?Q?aT1tIn2v4u8ruyQTizik6kVZ6cNZ1odb0IN0RQG1MWi6iVvenYLcn+5tKfT5?=
 =?us-ascii?Q?UQvr2VNJ71JD4PEFGy86nta8xVNTHUoscDhnRVlo4PIf+dRqSHK5yXI0e/4/?=
 =?us-ascii?Q?7HFvs2W5DU9nslulBXe4gga69E0zF4loePn/7Oii5FdLF28yGRMRXKWcNlbG?=
 =?us-ascii?Q?+5a64QB7m5qS0idwku2UrBQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91c1239-5c60-4b0c-e6e3-08dd7aed94f2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 00:44:58.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68eFgyIonds+TmhwKrem3lgkTJrgxxyi2hhCQWUn464K9hh3wR/71Kecf6za+xX+PNVGQM7xU7eR3G+sqBhwlOhjqUbPzethoI0gYVddSm8lgVx7JUI2vMqlfvKjLCqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12862


Hi Rob

> > Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> > both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> > uses Of-Graph in DT.
> > 
> > MSIOF-SPI/I2S are using same DT compatible properties.
> > MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> > MSIOF-SPI doesn't use  Of-Graph.
> > 
> > Adds schema for MSIOF-I2S (= Sound).
> > Because MSIOF is no longer SPI specific device, remove spi specific schema
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
(snip)
> if:
>   properties:
>     $nodename:
>       pattern: '^spi@'
> then:
>   $ref: spi-controller.yaml#
> 
> Or just always use 'spi' node name even if used for i2s.
(snip)
> > +  "#address-cells":
> > +    enum: [0, 1]
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> 
> Then drop these.
(snip)
> > +  # for MSIOF-I2S
> > +  port:
> > +    $ref: ../sound/audio-graph-port.yaml#/definitions/port-base
> > +    unevaluatedProperties: false
> > +    patternProperties:
> > +      "^endpoint(@[0-9a-f]+)?":
> > +        $ref: audio-graph-port.yaml#/definitions/endpoint-base
> 
> The correct way is:
> 
> port:
>   $ref: audio-graph-port.yaml#
>   unevaluatedProperties: false

Thanks. will fix in v3

Best regards
---
Kuninori Morimoto

