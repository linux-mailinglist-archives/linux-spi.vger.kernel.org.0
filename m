Return-Path: <linux-spi+bounces-8480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF5AAD740F
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FE8169DA3
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5F2222DA;
	Thu, 12 Jun 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LATQDbKE"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABE226CF1;
	Thu, 12 Jun 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739012; cv=fail; b=AGlG3aR3rIe8z1JtBiRcvkVGKrncXljyvw3UYTQRO44VfvDZDM5utZo/pYKze6We0F607Mqo8rdyLi9fUYFslto0sap2wpxKQbKGT7g4U5Td70q5q6cSePay0sCR35l+bDBPrlpMB6lHzqNlr63Hu6rrk9EWgftsmBp7ofY/XVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739012; c=relaxed/simple;
	bh=D/7+iOtOtKEQp03KvCa/CO/YO1l8C5Aa+O9hOf8Hgfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1DxpsCPVKIKkjOyzYFa2UMNwXE1lPNXT+EYpZhZk72iWcMSs15H2clxWcxc1ZI8C5/ov8XkiK+Qw+dvjgd1Jc3wzwv6/BArFb0jUuy01rRvzqEaMceN4xNVjkB6bZPPoItevt8pmp0paJjuGY72Cm6V1S6eYKMPq9SEJQGXSQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LATQDbKE; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnMWFPKPnpcCJ+j/nkruTxx6c2ODHL8LVG5OBd8bANKhqIpqqJY2K9uaNAYkcZkHh9EcqwHheYhI8qzNBRsmal3m54V08i704cV8wACTasHvfKr6+WdQRAp2TQyxn3w2ot8jRlw4yP31M5oG1Cpfy/DVPbsGPAGtp/Ag/2/2UyFKUyx0b/r3kwfjuQ4zgw7HxemUEbVL4qCedge/VU+yQpyvcl7ReV9tJEywcRMqrPU9O/EAEvM1gD74ZVs9sUQnoscCz67aFZhTUGqn5xpZXYKBGUjLyFco2j+fAvPGGkIhBYTdadi7xtiRTG5Kw9DjW0yK21yMxNBxCoq0Dg0+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbd2gT7/EnoJhXuyBQtku7sXuWIEYZJqD3DgKaPVGe0=;
 b=mjcYk6txWyMBgSihhiGahSX14oVRtUJCdVc8Ma5tCcqEkhiEZtB+MUwAsXLKITFuXX6Is6WaDUvSne2OxOT9tdSM44vnKQa9+J+AXvTN5Yk2hZQ41za4BvxfFQWftHWQx8V/nK+RVjlonAX+mibggD6py51SUaMON8uapreDbYMnVGuU4gmHQSCtHlwLCuQokzyD/rr/4zrGPc0kNqAsod9VTJcuB9zQGP3fac/fzP+SLCzIZMWP9mZ31hEPFQZHZDZ/+kCJxAaq0Gu1YAjMCnLYSKBi3/xKqhwHKwg0SBvA0HSc2ysKaXj2q3JbiRfW1ysHdP/VtUEZvEN8nYi8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbd2gT7/EnoJhXuyBQtku7sXuWIEYZJqD3DgKaPVGe0=;
 b=LATQDbKEKrMmMsgqHPjiKCWSu2Dtsvv0oi1cjeYkJF4soVFBXfxL9cX9S1khB5QGeVJzEp/qO6fSRXGv1iBzpbfsXrnFFTSJ5f8T02p/5KVCTBDBGds08ArsLezQ35Admb49ZHQIcyjgCvaf4ayBuzlmM16g+I7KNBX3Ua1pbeeK7QMbQHXJGjIB4nMuzpzHBzpuRzwHt1zI6RoUUqwVwabGLRzWD1OoTdT2zqIGoeH+xtI+rj433TltT1L/zoVrNX/0l43Oa1mRHSiBQQTXCMk/c4xmSsM52UUtWT9sEuDL1lE5VGNfo5gmXvZqpr05SowhTM5POzdDoxOxAfRy5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9091.eurprd04.prod.outlook.com (2603:10a6:102:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 14:36:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:36:47 +0000
Date: Thu, 12 Jun 2025 17:36:44 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250612143644.cmw6d4iiootipafp@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
X-ClientProxiedBy: VI1PR09CA0160.eurprd09.prod.outlook.com
 (2603:10a6:800:120::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 758066b2-d405-4242-428d-08dda9be8f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHPxnaysq28UpR9HLoY2ePnzNoIivVaNtZ68LhWZ2in9GF29o9XGrkGVCTXp?=
 =?us-ascii?Q?0CDKEFu6pwCYeQr7/8jTTW+CpP8B9rsd0LGXd2E81t+yRNP9OgO5yV5+P/e9?=
 =?us-ascii?Q?L4pevW400fIwmH9H+ZVDpLV7Ld5powz/HbBzY0YW8HuTg3hjXNo5OSum1fgw?=
 =?us-ascii?Q?WE5of/K82WN6CKap+36zhCB4qnrSScTf2UsWkXEqFcA+5jLmTThmL0oLEdy1?=
 =?us-ascii?Q?Nv7e2SdEFDFwyw36he+WWROrOfJw84yRQWeyzY3OvVTIXqM6icCKwJQKQyvQ?=
 =?us-ascii?Q?FLJwh/QOOuWouRtndBSEFr+eRNo/Dw5unRITAZ7Y/RdYkqXbnFR/hJUh1Skm?=
 =?us-ascii?Q?TriICGA5o81GHiSUtSHhQnjOpg24myiIJFSpmkNSPK8pMUHzLoIHtO786CmT?=
 =?us-ascii?Q?WSGDI2CsEmqJOCvB/uoN4YPR7R9zIReUIVoQU/29cIotlEjzBL+HG12KtfYE?=
 =?us-ascii?Q?Bmg5LrNLrBYtTj019E6A3p7H75BOaZXSCp6EB5QAzu0Yob1qmFlWkzM6kEMS?=
 =?us-ascii?Q?byz0TOwSdI1WWnMEjQqaOGmOMzv/Nqy+m1AHnx5nVqdHatoW2Hfrn3nCVV+K?=
 =?us-ascii?Q?KzqLnbypYnBbbEfZAoA/D0cAuzYTlsfNY8oOs+i+RAnWoBNj1HWgkM8rj7WC?=
 =?us-ascii?Q?dODerAeELkDr5GrYNDImHIT3G+pUheJBenFvCWwRQ2uM0Mp/uu36yLu8oypD?=
 =?us-ascii?Q?C5u5QegiTg0c0KksyxqbqI6QmdGBWws3/kYU/wo9Z3R6ghxEHtH+xqy7LTAx?=
 =?us-ascii?Q?6n8Kj43vGJw8OQo2xKn4GHvvFL73D9cYgsLWTBnOfvFIbJxDFBv+IbVuM+Za?=
 =?us-ascii?Q?770BkD1GXHDzkdZ0LQd5EXuK09kiAIzTNqd3JoQhKrl+p9vjGGtTzAqbbOKm?=
 =?us-ascii?Q?TqrjVvpThuFIOlnnsWR5I3RnF1D8DLSnOXk5/q/4pbF7dOE+iF3J1HuPJ8GE?=
 =?us-ascii?Q?KKJIG2FPvTNln5LRD2QkarRhAuGx6SfAbL2WUPzT0vj/sB4L9hbbsfx8/hXi?=
 =?us-ascii?Q?u61mE8wwxq5yEntmCBIAVFBvUuwSu5d8HjncWl/RDyzRNuos2yFeycqFPaAP?=
 =?us-ascii?Q?2uVf9EsX43Aj2RCgwOKGTPkIOfTLscMKKhHdevwtzHdWH7VdijDDvv2TRWad?=
 =?us-ascii?Q?pBwxliBzZgVzhrwwXl+SLb+H4kdFCcL7/K0us6NH6Ez4c7mPtjuXb6f0CwKU?=
 =?us-ascii?Q?glQFKW0pKkvntZEDILGck5FRlrYFylYCyW/gOE/2Oe67uQKPOLgCPWNCnT0Z?=
 =?us-ascii?Q?azpi/w/MFSTCjw/JjVC1bC/jG3iPzYBFo8tLu52nnyxqHXy2LEZglHZsJHmn?=
 =?us-ascii?Q?jstD8+biOTgRX4MaNqOFpE0ncawoGcAru9s/i37Y0yGVpd8535On5vt+CNJo?=
 =?us-ascii?Q?7nt9atqrxSmGPNA4sx5Y64GuK1AmK2HvJprprwhE1CU/bW1cSZEtxyAADTyH?=
 =?us-ascii?Q?BrwTbk9WGqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrYK41kWyB66mHb8tYvyGDfJ6YXt6qm2R5x4L8Q5cMnUX91qOJP6EYMHHr0W?=
 =?us-ascii?Q?xYTs5gCEySpdVtn5Lu5snDSzkkMYcCo6dB+tOduMLIHfIF5nBlzr76rCkX4N?=
 =?us-ascii?Q?Tq6auwL8kembcThroQkhz2xN9cw6pmQiq0o+RB9a9aLI5kTC7C9MN9Ujuup1?=
 =?us-ascii?Q?QWzxd5OcHkK64K0hpFoB7dKTPfZpMOxmsB+ik83XKdQhhqedv6GU7gBF0IFD?=
 =?us-ascii?Q?rEmr8FzFKwmvKpgoEtH6tW3hdaC+iHJDrwZZcAViPw+JJrRJRRa0ETkfxOiY?=
 =?us-ascii?Q?eT190AXS8fVXgTkOUoq7n2109gLPzfdypUAOfMOJvVkwQ5gRE+MdXk+l0sQ7?=
 =?us-ascii?Q?w1eWXTxAoWwdVe1A9deZ2OVg7F2Oh7LOqfjAGXnewLJ7o9sjKAc6PBPeF6td?=
 =?us-ascii?Q?RKFw/2WgUN5qAv3KJKHGKOm0DFNSZ9CnWsxAyr6v9m43v0WucpiLju8iUdUg?=
 =?us-ascii?Q?yd+jXWuzrE89nvhCqkm1kZEgB+CY0PPwq8o+jiAdZ6ttem1iPwu+Ascwf5xw?=
 =?us-ascii?Q?3kDCU0jVTyhLqEMIo0OOFzPXviK6pQ3ybYJ6wPuTiKVCXdVFuDsJC6FF4erf?=
 =?us-ascii?Q?NJOIMLYNgDOLtcx9pqZdQzK52HG6n3okIg1mgQHTJLkQxDsli6JAL4F4tGX4?=
 =?us-ascii?Q?dwbHmgntrkj7J+xSHTT3r+edAfYDBsIIACrsAv28csgoFAYCOEGtOKsebKIA?=
 =?us-ascii?Q?nhN5E86ZN+mbYFGwDGYE2AuWUAJGDABjNTEnrl4ukVl2OVCCPE64ry2FTHYQ?=
 =?us-ascii?Q?rr65c98WoG7xGEgAS26oEtShwHh6f5hpM2TKeEMzdP1RGiQJ1Raj6N5YGLnv?=
 =?us-ascii?Q?2pAiNo74NtKmI09rtySpG8ZNrXzQ5Sedg2yWz0mXGbcYmbtHKkPz9tWkL89r?=
 =?us-ascii?Q?nZEflSbsjSOnut32Rt2y5V5tdMj9O037bX1OZYjlQQsqX2eckSctydEzQazi?=
 =?us-ascii?Q?ybQXe0CT/Y0l6eGHiISexPyhKDqjLsHcSlHE1rHG+LhLL3sJFER0Neti0UoP?=
 =?us-ascii?Q?KoOKliPh43UX7zm2gKWdH9ODT2q+TPSM8zh7CA5b3JrBNpmUzdhSG8MLsLvz?=
 =?us-ascii?Q?+7OMFoD3y2ywFc9BJUxL+/NelCZ/Uz5sVmCHLZUbJApSAKGpX4pkJVL3w+Op?=
 =?us-ascii?Q?aAC/D3vUxHkiuViiccjUVhMuROmj3Xh5HjuKDY+wtcZqTqAGf/wNiSyzTmIB?=
 =?us-ascii?Q?RVD1vbEhfP/IqmoT4LLWtNT3CcBFX7dlfZt6djaHwJ0+X19B3ao7WCj2CCXV?=
 =?us-ascii?Q?Y8wl0/x9tWU9g0CBsTjYdY27b77VxnBQHWwPKl0DB6raCHoN3Gr4rS28jwEP?=
 =?us-ascii?Q?Gcay14VP+swlA3RmU5QkxkwN7dUhAVOSnMZ4qXS0oOUV3nBdNDyHviOG64xa?=
 =?us-ascii?Q?XtnAkVFw4Hz4p/zipCHbIuAAJFe8iaN2luEryIOSmETo5rnsJ67ANhfDSVLM?=
 =?us-ascii?Q?pjmZQIx9N0SyolKVZZCXssEUaU5xMG6xJNI94YKD7KsNy0vHYvEZafnkV6e6?=
 =?us-ascii?Q?yOWkYtBiMxsowy/GBiOQ/AGvm3A5xPYtKMbSWO8oWhX+6dMK4MLrDG1I5VkW?=
 =?us-ascii?Q?Jr5+TIe/logU47ZMOZVmWVaitANoIKdCrnmCg1ixfW7IbrT9plLvyMxYvVc1?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758066b2-d405-4242-428d-08dda9be8f71
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:36:47.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af3AMG2yhFjSTCqxGnsBfrUcK9wIdO6SbfXj8UI0uy73k5wHdRdT34YIASVa8L4Spzt4xDPSeHiYX1JSGQSo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9091

On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
> > FWIW, the XSPI FIFO performance should be higher.
> 
> This leads me to realise a mistake in my original figures. My head was stuck
> in target mode where we use DMA so I forgot to force DMA in host mode to run
> the performance tests. The previous figures were all XSPI mode and the small
> difference in performance could have been just down to the layout of the
> code changing?
> 
> Changing it to DMA mode gives figures that make much more sense:
> 
> Coherent (4096 byte transfers): 6534 kbps
> Non-coherent:                   7347 kbps
> 
> Coherent (16 byte transfers):    447 kbps
> Non-coherent:                    448 kbps
> 
> 
> Just for comparison running the same test in XSPI mode:
> 
> 4096 byte transfers:            2143 kbps
> 16 byte transfers:               637 kbps

So to be clear, the 'non-coherent' test was done just with patch 2
applied, or also with 3?

