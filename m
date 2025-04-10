Return-Path: <linux-spi+bounces-7535-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02635A84FFB
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412861B6374C
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 23:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93B921129C;
	Thu, 10 Apr 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JYt5jp6t"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16A20C002;
	Thu, 10 Apr 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744326495; cv=fail; b=cwiSCm6+GTIDk5fe9vLX/aPCCbAqFGVeKwAIl2bKDc//1JAhkGX7AxfRvYK9LA+VjI+ut4cIkTKhhi8EfcDe0Q7AJTOSjgP/BxuBIuCfSMJyuqJuU709GHYYJqwxDqf4oSnzR2fed7qTmcHbPCHQlCsTpKzAljonub/UgXoLpDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744326495; c=relaxed/simple;
	bh=5P0TMq9GZBhlzA2uv8W1h5FUbmy5ZV196iSvnTbnz6o=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ADb6urFHkia0UX9tK2nraE39zEFjsJVxR0dG1vp5/EDM1ts4XTNiSHzsniLnhkxPzwzg+PIHydpOpTeW7HxvIiXjtLqsN5xBAFoKTvvgn9bdi2xD7oEQQDn+sC+ehaMPlfzKx3aUQ+yLbJHpqqrm7ix5hejYsTPvEZUwqPtFmG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JYt5jp6t; arc=fail smtp.client-ip=40.107.74.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M22ThS856RRaA4TQMjPvwvfbDPOwDN4X0iEi/olOCzN1clfdgizd2uI6/coxAdWYjA4UYk9cUDAulzjE9Hl/TZa4D9QiFdyfPEWNFOZ7SuV9ANfQmQ9kRxNw6xkDPgzCEPtH6c2lTD+uRbtGtI3bTyRBlCmclBZnQr10I4hzt7MHr0tmeweQC1x67cugk3BR7zah0ljRzvskTAD+5blB4JzYVvn4cFUjIfwXN75HJboBqOqHFPhX8zCCGJAhP1R3JFq+XXZ+KGnOH/1jHcR+1/iw9BQymOsswal3E/Kr+sVN7KtvuAFhzxtfnXPG9qwJZ3B/akSLIgsA53eqV3pCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqGmn3GeEG+g8AYJNWH0zEq21ohCmUPolnCJSeS0dQ8=;
 b=k1ZsSFMtHL7OEhnczK+99M6fUua4DHEYV4anNWf7wVcdn61IWTsO5NtpG2IEmvfDsNuA7h/0s4R/0gZdn6eXGgaUeY3wZJ4sRYgBVmyQDTMLa/6B+aMIFe8xG5opVmNJx7TD4HY8ma8WngeyC8nRulX2LMY2V+V5asRk0pMMdo6Y1QQW43NR6nYwuJh00Gav1pOc8tFn+JUeZacsEX69EV7FzZaJvvRL9Lwah1zC6aGl2wJaGlpOsUWaW7YgLPSOU2EGInY8bf2mCQLFDeUsxxvFOdj5bO4omZc7Z3Zw1gHALzV3OKuHuxHG+hss1r5XooDMv060TK5EMpqCRcOoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqGmn3GeEG+g8AYJNWH0zEq21ohCmUPolnCJSeS0dQ8=;
 b=JYt5jp6tsQWHqsZhPLagyft/0eOlTPBxMpLs+IS2/HvjYF4WhCiIhOnlZ/TqP6w1xuHv7O/HBb2+3NpRGa0Gg8nEDVKMadOAJvxhWp2H5v1bVJwIJiPm+2Taoiwa4At9k1h9q6f7l/wjaKOqMo5PEfoclgSHkJ8ciR4rBQedQKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB13678.jpnprd01.prod.outlook.com
 (2603:1096:604:37c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 23:08:07 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 23:08:07 +0000
Message-ID: <87mscnhay1.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <CAMuHMdV3Wm=aES=WZtYNGQrA1W3OFGrrOR=Nwb2FXACeVmPzAg@mail.gmail.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
	<8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdV3Wm=aES=WZtYNGQrA1W3OFGrrOR=Nwb2FXACeVmPzAg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 23:08:07 +0000
X-ClientProxiedBy: TYCP301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB13678:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c4efdc-4029-4437-b7f9-08dd78848e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/dxR15uArmdj+mXoI4b+D1kDsI11Iz+lgU/vFwxndVTgt8RNN6Q2X7eJL5I?=
 =?us-ascii?Q?C/rS7SKkJvisMKEqHyDz8+xyvtOOS1RAnCLpfrStCc8RiXcwJ1npdV/vUQoj?=
 =?us-ascii?Q?ogQ4HnisIMxDA/L3c4aW2z0Qtc1pm9XDFEIZaBeRL8d8hWvA0dmfm2NlPru9?=
 =?us-ascii?Q?AFOWYuYsfvddGNFPanmxMiCrao/ddehg290mkXDS8rP82dBkY5aRInNb35ve?=
 =?us-ascii?Q?EF0qIpS2RvKjUenDgG7HSBnKPfzSDubDp/Xg/MxAPpC6LPNIWmFBuu64PSvZ?=
 =?us-ascii?Q?P7OSfe/V3uZ+BrVIpR4+QHT1R10Wd2wQPhJprog0MbEwDLUntgtQduyRGY6T?=
 =?us-ascii?Q?zHNVNUK8i7l4KlR+cWE9oF7vhUqUjfCXoNDuwGbflxQ8jWzx1XzCUcr/PdFp?=
 =?us-ascii?Q?lhjTb7R5PU35v+t5TaCW0GMnXIJWMoDjdZ0J85h6+9iKTF2Z0EUcz8t3NQZw?=
 =?us-ascii?Q?stECCaIJctzkh1A4D20EfPbC7DNKH4676+w9WKbLGN9vKtfRFbccbe0vGTCG?=
 =?us-ascii?Q?a1yPtgS3xqVDNnnwsXyNbgoEUhtPeHnyAsFiJBnbHQngBgwSFyE0cUbeUB78?=
 =?us-ascii?Q?+pw83i95GPwodlF7IpTuBCB9ZwII4N4nss/WpDKT+B0CjJcKrNhIInEX4Vfk?=
 =?us-ascii?Q?daUnxifUoQJVBLKS5n7cXNPFw0bs5/OiR4lZ4713pmKpiPmU1UIz+N80V4WB?=
 =?us-ascii?Q?gbjWOqYLqp1pJy48hdl4w5AmTaZ4No0SN79+YiadTXYnUzLijyfS0gbwpuuF?=
 =?us-ascii?Q?sBcr0N3G44/nvmIw2goxpTHPSLCbn50I8J+67MhLoQILD+AEP/P+fLp+Ipqe?=
 =?us-ascii?Q?Rl6plwGSu/kvbHIZoifqR5YOx7CyjqCgaTqY5wffMI0sIQJea/3XHHK0QsUh?=
 =?us-ascii?Q?ielwr/Mon7cxELhZtveIJlfPIvMI/5HQrPxKx6p3LUG7zPZL3X2poqMDuLCl?=
 =?us-ascii?Q?LjIxMcxrwaPzM1Jnwkb3Glu1+ilSRIvF2KmX4WuCD/V0oSWwWcq3QEchu0xj?=
 =?us-ascii?Q?lYhyxw3faB8r3NnsWS3LgMr67clszgzmjcM7nQvCaTakTr9KvJRYDVbDXZmO?=
 =?us-ascii?Q?+KQSAIQmqcRxuA+/H+rozR6Ze9K2N36A2mZWvDaUBQ3SOePRUJS3KXaEOtej?=
 =?us-ascii?Q?NERvvQlmYcgclblXJaYFDVqLA7hF2xzdBB6r1GAIM9EbDsWBKVtOxgZlnLYo?=
 =?us-ascii?Q?GDh/aMaZpXG1hZDLsH2YTzVeBajQ8SojupQHgHKna/hxMaJYglp/YXIec6Qp?=
 =?us-ascii?Q?+nspWgNzXsC38UQtfalWWDPjKXnFEmumSg5JT8pOJtjFFIfx4gh94lnDENhY?=
 =?us-ascii?Q?KaOIz+9I1gkOo7VPaclL4hjKMdsiIptIT6dijrletNTfmoS+zucB/rRg7Ek7?=
 =?us-ascii?Q?ujEytwWPXLeLVciUjPGRsPhLQFj6zYUwV0QyH/DfXCDbmS3RAZBagDqaC8mN?=
 =?us-ascii?Q?YuEmQlt6qMJtPWRBatm9XiaLe6qrTFHa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPTTuvH9SWC6RNgD/CNiN9X/4bZWaBqGvqSXAQEgA/v5YowN+c7uGMN0ELlq?=
 =?us-ascii?Q?pFFrxHd80X2moyZ5SLMVRS7OtCBwe/kZqtR1HUZ/t16V5ayu3FOqD5bVQsDo?=
 =?us-ascii?Q?t5D4dljCBVHTQUOdYqJq0dqJvCoX7LJmLurog8NkFRhvpDWCBACjGrMDAMvv?=
 =?us-ascii?Q?s9JgHUSh8fXwijHwP6SBarDunC+cuAVrzYoXotB8M0ATwFKhzXIZPF9nx1vk?=
 =?us-ascii?Q?O0dnq9Tt7qD/bBnNRBAC8ymB3BCH4PSZn9qLGoEPxeSviq6TBW4VZniQnF1q?=
 =?us-ascii?Q?KJl3dhGIYAQkpam2jh+eWAA+Z39/Px35yMSjGoYdTnKRLpaJ39T+00adx++w?=
 =?us-ascii?Q?SUnpnAASe6TIVqpv6OyhvKePCaS69gz0HAN6G1801HiGuHklWdK6JXxDQR33?=
 =?us-ascii?Q?HQU1rtDxtkk28ki1gbRBmpTUkS6frO9gWfOycPE7pr/mtYZyl0XPJKDtsEES?=
 =?us-ascii?Q?i6RVZCGH6P9IABwlID2KB8++gV0nH+nnscZgcZA1DKl8pPw61+MYRtS+bW8N?=
 =?us-ascii?Q?cWy9VMjCuhXLf42wEQlP9e59ecP2gBxbtAmPJACwf72x9wA3T58INLV8Opjc?=
 =?us-ascii?Q?+Jx3Eu30bb1YwM6h1s8s2dtUydcc6z0hU7upBUiFd/jXO/tXg/Kljf+k9CGK?=
 =?us-ascii?Q?Ec+WdqTOTqAnOmdl2VNKjjoSWspDumArW7ehUbBqJD7nnE7iYTTZqPvTJLHC?=
 =?us-ascii?Q?RewpGuvx/0uhnICbLpblwO+hy5/9fOMADvMIQNlYwQErLSgE/SoE6WwNfn9Z?=
 =?us-ascii?Q?anTY93hFzw33nZXA2pWkvpRJRR5X2IQtM1XSJj3Jl3aCoHh0dahym6RP/XQA?=
 =?us-ascii?Q?SldeMxfWg2K4uhwNUAqEBRKcSW/rdpVzs5XZjKm5oEkWCG8iM/h5SBNMLy1L?=
 =?us-ascii?Q?zlfD/Awp5Abrlb6xHKbJryBF9t+j/y+DL4R1gDtrY1e1Lo/9LywHHTP+F1XH?=
 =?us-ascii?Q?YTR0pEHEbZmRzKyi//LQcV5vnXgLljG0i1a7pT9U+wzo746SG+uNkfD6Ga2M?=
 =?us-ascii?Q?/gPHtzsEtucx8w1yBMENl0kDO3b7A9AewzhhBwUCNPhFRPADSGqQCZUsbsWI?=
 =?us-ascii?Q?uHEYneJqF425F+efp0eWcdZ8bWa23gKikyDrzpOjHRvNwwoFNWXVOXp3CISc?=
 =?us-ascii?Q?aFhZ7jnFtYNNjdnCbX7AOMNBXcoikXU+d3uOfUCT9vJ4G3aFzjqwVYMqQIJ3?=
 =?us-ascii?Q?javPCjebE2lrhDnH+RrkrFjIEKAEMM8nfvaLTQePQxZ6hnkiCvUcM7INCeXE?=
 =?us-ascii?Q?NBLGtyPxbllIVdoEg6lWqYTY1/dYNor0jt/8d8EWDcIUJ+2MLge9Ow6L2ezF?=
 =?us-ascii?Q?UtLndwY0KAWZzFxjurIBOvMxIdAVUGCgb8f8QfoUn7j/Jx/bgdDfdATl/I/G?=
 =?us-ascii?Q?ckxITSlaSFHpdpsHP8AtKWWWorbGefsWoGwlONHokyi8zN9rX6JZqSUaT1WI?=
 =?us-ascii?Q?nfI7fy8G0AHXeFTxsGHu5sphbWbKWgK8pnSYdqcBWQStCeXBUN5/f8rdbZ8g?=
 =?us-ascii?Q?frcI1Ga3hFF4m++3x7qjlOYTp706rfwRTlN7p7XojXQBxiZ4jLTDy/LPxrER?=
 =?us-ascii?Q?eq1B39KmwrPKAjOzv1lYMhtRzmnx7rb5EdaleWLykRsHeeLtGmY99NgW2JVM?=
 =?us-ascii?Q?SxALf8f8BaWILfXlZq8vJME=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c4efdc-4029-4437-b7f9-08dd78848e20
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 23:08:07.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXcUFu3+maBow9mdH4YkrfFuUO1BKgh2GCt6wPYKWxpgywpWlG5flu5ogDyZloBn4632qxnyB6qShTOYcuT/Vc18j98wQQhB2PkpE6Or4XGDp74Uir45K2RrJlm58G2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13678


Hi Geert

> > > Don't you have to initialize SITMDR[123] unconditionally, as reception
> > > requires transmitting dummy data on R-Car (cfr. SPI_CONTROLLER_MUST_TX)?
> >
> > Good catch, but I added 1 restriction for MSIOF-I2S mode.
> > I have explained it on top of this driver. The restriction is
> > "MSIOF-I2S doesn't work as Clock/Frame Provider Mode".
> > So, dummy transmit for RX is not needed/assumed.
> > I think it is one of big-diff between MSIOF-SPI ?
> 
> IC.  Being just a mortal sound-noob, I didn't know what "Clock/Frame
> Provider Mode" means ;-) Oh, now I understand. I had missed
> completely that you are running MSIOF in slave mode. So everything
> should be fine.

ASoC is now using Provider/Consumer instead of Master/Slave.
Veteran engineers are not familiar with it :)

>     /* SITSCR */
>     #define SITSCR_V(p, d) ((p << 8) + d)
> 
> is unused, and can be removed.

OK, Thanks.
Will remove in v2

Thank you for your help !!

Best regards
---
Kuninori Morimoto

