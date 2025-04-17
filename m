Return-Path: <linux-spi+bounces-7652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C711AA92D42
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 00:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2225D8E3DBA
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E595212B1E;
	Thu, 17 Apr 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hinnuoxU"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010064.outbound.protection.outlook.com [52.101.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62D13E41A;
	Thu, 17 Apr 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929080; cv=fail; b=oBEpP7w6twO3HeHb7v3xRl3FB2PbFA3ALU3JVSOVXYnmdaEC3A8hBSvmPoBhzl1LtF+4SXgHnx01jt+j4JY8jAdzZ54aUAQx5TVjLl0vrBbd0lJr4AxK7uCjCJmEN9RuT+0iyrYmAiXp5ufzDEKdOKmHbYzmYFkShc/jurp0Qbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929080; c=relaxed/simple;
	bh=PM8n2DRLlXkvJmhbRkTRGkKLgA5OVKJ5+m7lOdyJmKU=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WrK+9oWR5/VxSo8dfPH7wtRKuDkxUv3azZnjjHbt4ca/lID751LyRXTqRRauDulPWU5KMGoM8JdB9dQ/Lr+5f5G+H/XLUPrjSfEmuOwBFnYjH5zbSHvMJrIlfI9ufga6b58sKP4Pe8MQ8OqDIhaQjZ4yVq3inKlnKulCcByyS7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hinnuoxU; arc=fail smtp.client-ip=52.101.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCRzEOioxQgZGk4gEw2bFPRQrBqwG5sgabHzuj+k5lc5nWJoLFchsgIrMhlW6WQS9hCbzum1b3qWXGm4R65R+ifQom60liqPFF3Sr4545t5UW5Cr3zSNMRybG8QOMykupEEKG/LFCLOvhhIreaRjuwkcl022Nqnpryssw++BB7E26yPFFstN0C1COrekpkpEE8nduEGcH0bUXP/EC6fwtQFhSJ6xQ3F8u6KEGqCBSlNXRyaY7EsGkCrXHIbaiSiTRa8ucCCPJ51W03Msr1T39h8gRmD4dQt/JIVvUVDuYH7NOJIQALk3fwJ5zg8M992zLmxViPowR61Lx8Z/cqWxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6ZldBcrpCHPRGCpia9bSDD3DJRZFfRwBZTI9YOLNYA=;
 b=Y9N6RCerwcveKFjf+iMnxQ9Qk7gGtdVaatyXuQ9gTC4W5/7Kkapr1eJsmJyPq4td90D+UBX7brKeBK0Pax+bF4tc4C+erBr890eDZUnRun83eJVjTl5EEL5VE3HNfCN7S0B/meUXIUdjQ8nXWRoa3ls83HxsagCpWQqWI4B3zSvNQioyuSX2yuSJSTR1WA6aXlTKQ2IHEfBvRXK9wzbj/f8ZxNPzOLxxNi8IMYyOjSSVEHhhfe8fQE9IVt1YLFJ4aA84gputEq93etE9W4qp4mzOvCsbY6NDzI3xPFWrKSI2pY/WqC8TUChfBAXym9a+Ac+JP5IHYjqVVWCIrp6nVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6ZldBcrpCHPRGCpia9bSDD3DJRZFfRwBZTI9YOLNYA=;
 b=hinnuoxUo6YPoJU6qLbdBZL+ARAcO4g3tJLpKTw04jALxiI8MfE2BJadjsOqGcx4KR8E4jw67j8UwrhUnpule+yNU9LGYgX8kV3Ihtqk0XfizmjZFfixULkaIN2KC8IDydSx/aSJoK6k+Ssx2UfIMFzuuPectjqA0+MpOsXSVHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB10277.jpnprd01.prod.outlook.com
 (2603:1096:400:1d7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 22:31:09 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 22:31:09 +0000
Message-ID: <875xj24dzq.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
In-Reply-To: <CAMuHMdUKBdTyA0fnfpQT6iad3S7+z3dJkh4UnS14miqgFcUhuA@mail.gmail.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
	<87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
	<87msch81yh.wl-kuninori.morimoto.gx@renesas.com>
	<87plhb4qbb.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUKBdTyA0fnfpQT6iad3S7+z3dJkh4UnS14miqgFcUhuA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 22:31:08 +0000
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB10277:EE_
X-MS-Office365-Filtering-Correlation-Id: a24a75e6-6fc7-4cd0-45dd-08dd7dff8caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qMCQRu1xmwCBix6lQAlSCHyXi5Lr5IbjtZ9FLywFTtwkR7OiRt3AvQbCjy3?=
 =?us-ascii?Q?r8I6B6skcm602bJYjn76vQ3HORDUzpcEMhD0065LrFih8Vj86D037Rqu835/?=
 =?us-ascii?Q?YjlTyvd7TPyRXSNbCj7PLc7Z3EqU2FSkaj7mUxIQiCa7PjIQp2un20tKmWXU?=
 =?us-ascii?Q?tOjlXBg/D6U2sFc/ysx/d10lq0Ar6+1UhvVIDByBNWSIdwaUimP3E0JIgV7h?=
 =?us-ascii?Q?LwyEkxpWm13D3TcYA65+ZqxY/Y+bXV5CPfwhoyMneeqy1k2K47mc/I4UfhfJ?=
 =?us-ascii?Q?DgAizZudyGgM4OY/ZiGITq1ia2g+hpsfAYmRc4Htnr0OOUGLfflQAA1z+bvJ?=
 =?us-ascii?Q?A7Hh1cuTbtUZAsUmzISQ0A/b5wcQgLJBW2D6dMB2cZ4hZ0P9lpMHzWPIgXlg?=
 =?us-ascii?Q?q/S7ED+ptia0L0VoWiQhopapwUbqthTDO93/R/xDEDn+1DCEj8UenlIElJoi?=
 =?us-ascii?Q?eESIqAxAcNij/6EiHtQeMPqbFI/XY1e2AePYRChKaqR71UKGbBUPyhVKBJUe?=
 =?us-ascii?Q?hXs83JRJNW6w1ZQgdE9vFH+X27/wX8hjDttEpAwvGo/OyjB1G1Uapw+vP2+M?=
 =?us-ascii?Q?DZYcfXkORgFJuyuR/UYAX9AQ9Fe6X+K/jhM5UpedJ9ytJIF22uoCNgOy0EP8?=
 =?us-ascii?Q?0WxsoH+5olMOugXDg+mdFXxhVRrIg9QMS8muBQPhFl1w0vmFg2kR0MeyHYoL?=
 =?us-ascii?Q?COURvBCulbw/SkDcDTgjMw/0bPZOZPOaeExiKS8iudemskh0LwKQYiNyTQDB?=
 =?us-ascii?Q?0fil/LxKx3NoSPowk2v++i01eqiH5V8M6CAo6byzZAJA+B/Km6gQDu5L/Rmm?=
 =?us-ascii?Q?kpUBJtvJ9kHm+drRCYivd7IbgDIj28QK5LFucjAMQkDgeJZBLePUr4hLcQES?=
 =?us-ascii?Q?8bnfeURvSNBTRbWFZNOzlfw3l/eCSLxgDecjBl7mFDMUfIg7mpwrX8ZBQkql?=
 =?us-ascii?Q?2mk7n+a/UmSij/WJoXK9UbBNEQM8Sxif1MVtJcSgGGKJu44ApMFCLq1x6/H3?=
 =?us-ascii?Q?ctPxf9M7B7pxXbqFqEzOqtY2zbGhZWCBhX1qU8ZvgXQy2xqtiJYBvgOXWoZl?=
 =?us-ascii?Q?+r1CUhzfhVSr9OWaJhlavi3102KmY83enhme8/tZgnjO+ATBOVWKx/XFPX1A?=
 =?us-ascii?Q?ufpIhnPqHSI7hV8C2s5/ZQXzLQSVnBTrn6GaJaYe+CbgmxD5NXYYl+wTcyjX?=
 =?us-ascii?Q?uyjvmuoTgDYv8lQyyu74rnXK6gWgL05EIdQ2W6cw4JDVWKIT4XTJqGKo43C/?=
 =?us-ascii?Q?e0bHHvrqAm/q0gCI8unefE3vn/bfuohaz1ooKorPrbAKjglfz89uzbhRD9ry?=
 =?us-ascii?Q?cL5z1A5UZC7KwfsWJiNDcCjmXa1b6nlIP8Nvp/C1U7uGuQlaKt2BmnWurZJU?=
 =?us-ascii?Q?u5AouKhWHK4WvNfRZlqOfNaL1gTN4j73VaZleEJQkAQwWdSBJtqDmaWyXEQQ?=
 =?us-ascii?Q?PmZ3aWx7JCXL/BXq6G0sXrA+ixjJprfhgdeu7PH628fcpU6RxzX8vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXFo27lp2mtZU1LlIR81u5/7tqdtLPVTq44Y/WVq1izENi6S1tBB6c9S25SW?=
 =?us-ascii?Q?pfTEXojELLd1os4hpv3zk62IrkxgcSPtfAYJnDinFmEn+iD0a2TkZO0bXHzC?=
 =?us-ascii?Q?yda9LVMwdWoN+mXDGYSX2wJe31IocMvhOMWtLe4T4u7WMqGBc3Doavw6AGQo?=
 =?us-ascii?Q?EwtAjmQx8RX6QvEQ2T/oWH3+RR0mBWdAe6xNV5XIbRmWQPCkH9hitjUrstas?=
 =?us-ascii?Q?O61tTiGe1QfZU+IaiyAZ+ET6udik6Q+1TaTVC74Zb7DaEJ3G2v359Aq/BYm4?=
 =?us-ascii?Q?cd/c3zbkkceWQfeRwQ9MkTE1+ZkD3cgLYt4NXpJknzSrxXYjIR4qn6i1Un2d?=
 =?us-ascii?Q?7Px027ZwnP46u1AqSKDUPGr5kQHyDD/NPgfCjQYShyX/IQNXvTTLOzDsCTMQ?=
 =?us-ascii?Q?ctLiepIzQq7Sn3NOzLqI601a+dSeH42VY0QrY0XDqV3+taUjtFsc0TLLs96z?=
 =?us-ascii?Q?CegeyJbsrz7ZQrxECwj+ZueHjhH4V6KHt9Ee4i+2hSS+bAHPToy6FOAXzIHT?=
 =?us-ascii?Q?RAUWy1kgx1UIUAQNATSSXtiHOGmsE9p/cS06xL6VJnyz0N0ABfNqgr87bSQ9?=
 =?us-ascii?Q?kNVb8HsJW3U3Z1ZOBm+vI/205EovIrKyfAtqdH+C0j63FyfzOtbooa6LDFau?=
 =?us-ascii?Q?6DBg14jRDZS5pOyeeozSsuzofq5DEc5Mo4i6Qe3yUX+Hj9us+pIYV20/8t0I?=
 =?us-ascii?Q?V7WX5MhhZ556iaCWTLHTk4npLVMmZtGAyu7T5UylF9+CDJb/HnPzBuxah5oy?=
 =?us-ascii?Q?gaTz/Rx6OGjSDMY4wDABC1k6j8/hUrctQWQ6WsDHY96XPNW05876x2dBFSvC?=
 =?us-ascii?Q?arUqM/xMoYh5Y4m7VPbt8PrXxGmgwm5fWRlw4IewvX2XVlEKRmO1A4VgH/BW?=
 =?us-ascii?Q?x0VwubIiO9YM4EiESlgKO5ocGKDWysMmhjZKzLFJgwTyGB2zOuX/FqTrpZgO?=
 =?us-ascii?Q?KOyEbVp8ZPy7sed/rQZBT4/8bb9+PjGPHRF0tsyIJC9QG18QAKSf1RWPMO1R?=
 =?us-ascii?Q?GiYQw0S7fzOtTI0JdU6YWmRJXeVuBfKNZCOkcSO8ur6VkKKidQ1sOf1wqo8k?=
 =?us-ascii?Q?5kZkABTJe97W21dq0ZoUArQ5G0vdTgwUymY0sAkAH/5MvRhaypwpvYexKbua?=
 =?us-ascii?Q?iVVJUyTetYbV9e9waq5lf63PeFMiYZjriKJBet9xEYf02sHmOQoIjc9N7nJ0?=
 =?us-ascii?Q?l3Txx9uJ/zA9QqJA00WZ92HhNTSNOKxnxzka3TYYJQrMwwa8683Vp95xTjh8?=
 =?us-ascii?Q?Jcc7S5NZ15ZgbVOv2s0x2r16qeYaf1skTTO449MiTCnJVhUsiAHpTNQ5Gfcy?=
 =?us-ascii?Q?Oo9raDOMy4NwEuOtu6bZFCbC+ZyqiRva7cObhWutUyHagIrDmig0TbGLOy7b?=
 =?us-ascii?Q?bbaMu9y589GO6FGZaEXkqmiIcLHQsu5t7CRB+WIKXRnBBZR5lkTwXSemej7j?=
 =?us-ascii?Q?6T7K9cWT7SGJV6azWZoH5CZHqcz0HCVgIRdeEUb6Pl1OLCPSpBP0oVfnhU29?=
 =?us-ascii?Q?BJXvPAWiWVTwOPY5SGGIcFkiuTC4Pbt+xnkvtL+tEjvarSUCTcS+I275xwA5?=
 =?us-ascii?Q?E/MgYYdCxhIzZh7XSOniwotyjpLu8tkTTJ+AQ198mmm+dQuhQ+yBXqXSTOCP?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24a75e6-6fc7-4cd0-45dd-08dd7dff8caf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:31:08.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjZ/4jTpQTFkJ8+32D3el5RwEWwZXV7q+nfCGHtn8uH/vwKycyAERAZMsbTVPxiCreQ2kqTJnZHGiGCnyNsLlZLIxAonds2nQNxIbcDPR7Kx2EeqHb6hpxthiFX6YBi1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10277


Hi Geert, Rob, Mark

> >         [SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #address-cells for SPI bus
> >           also defined at [Board file]
> >         [SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #size-cells for SPI bus
> >           also defined at [Board file]
> >
> > MSIOF dt-bindings doesn't load spi-controller.yaml, but why I got "spi_bus_bridge"
> > warning ?? I wonder dt compiler (?) automatically check "spi" node ?
> > I have tryed some code, my expectation seems correct (In case of node name was "spi@xxx",
> > I got many SPI related warnings even though I didn't load spi-controller).
> 
> These come from dtc, which makes its own assumptions:
> 
>     $ git grep spi_bus_bridge
>     scripts/dtc/checks.c:static void check_spi_bus_bridge(struct check
> *c, struct dt_info *dti, struct node *node)
>     scripts/dtc/checks.c:WARNING(spi_bus_bridge, check_spi_bus_bridge,
> NULL, &addr_size_cells);
>     scripts/dtc/checks.c:WARNING(spi_bus_reg, check_spi_bus_reg, NULL,
> &reg_format, &spi_bus_bridge);
>     scripts/dtc/checks.c:   &spi_bus_bridge,
> 
> Perhaps we do need to extend the use of role-specifying properties
> like "interrupt-controller" (in Device Tree Specification v0.4 and in
> dt-schema) and the few others in Documentation/devicetree/bindings:
> 
>     gpio-controller
>     mctp-controller
>     msi-controller
>     system-power-controller

Hmm... but I'm not familiar with DT. Should I do it ??
Except from SPI warning, and focus to MSIOF-I2S, my patch itself is
not so bad, right ?
I will post v4 patch-set, with comment above.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

