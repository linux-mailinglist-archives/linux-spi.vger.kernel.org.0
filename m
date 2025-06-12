Return-Path: <linux-spi+bounces-8471-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E24AD6EBB
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727B01896E00
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31C22CBE9;
	Thu, 12 Jun 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XtdnW3jH"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649315AF6;
	Thu, 12 Jun 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726923; cv=fail; b=aulRiRA/3/QHEUlqxOs+jlFVHrP7IMj3WjQ53tHHpzQC9GT/1MWa7dW1rX2rDv62QJi4dtqYp7Grw0P5QuIPi62P0hooKoQk152h834ReDdpZrFjGQh7rkd9qU25UQYAkAkwcW7qloKbiX3Zu6rQdwW9lSPLQktb3ogI6b5912A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726923; c=relaxed/simple;
	bh=lP4rW7pUpB8RrjwkpoWbXnLuTQy0R73FPrzuDXG8AUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hV0DBkjLOw+SOs5PaQnkvC6+dvnNaqDM0GfHUDnjIP6TC67KV8px0L2bl3wqqu5dP3qNGOoT11yOFnAv/OiiB9GEk0JC/n/i8clfpWnG8mv5pA1kwg48uBrEO22r1J3wAPVSlpqf05HzZT8u70Fwla6Dsglbtz6XRyN3QPDmUSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XtdnW3jH; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiVCKQIrCsnnLET+55W1yqDpaZlbJmxz4w3wr1ezw0ITm9xgmVhX70tNTZzimT5OaPUfMclOxiewICgpWV6zCpwU61bMejQUKMS7JrHxlIRB0tr6UVI+D6v3tXyvkoBqmDHBveoUVeYudERup7hpTW+rR62+QNA6IFqRluz3kt/rMHxaBBRv+09A6QUfVW8D/N24sRKwSSv9w2pnGlipnRGd0c2QoWguluurnMrsWQL9BdiK7jrjVTUfAk94BzRD/iu4udcRpGNumrDHfnG2+CnNI4phj5VjjwN1j8KG0CCEr6bpFQlMp1yzHZRftItAMfbuE7mcmnXIt4VSaXO0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP4rW7pUpB8RrjwkpoWbXnLuTQy0R73FPrzuDXG8AUc=;
 b=HY1IGfnmAPjghjK1QFy73soZj7ltZDg2ul63mkrL8Dpm/wrfS9ZAmFtNcAU74w0IYjzJOBmgqhjgjOeicPa7ct/hDlnwyWaCfh9np64Mk2S7JQxUPIPBDygD51uxLioX4D55XRTijHv/LOxy4/bZ0m/pfNQPLZ4xwSDel3Sq5r5dQAquNWtsRwTGoge0zMmjsyPVhkdSJeb0p4aiGfT9pAXDSA/dLeDRMw8Es2lk1WZEXL0wEstc08WL704RBHhM2RZ7XhrwM12EJ3wOJTviLwwDmLEIJ4SihmbL+cLjGseAQ2YpibENMTUZ7QAUoHAHupDG880QeMgCpvAC089zFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP4rW7pUpB8RrjwkpoWbXnLuTQy0R73FPrzuDXG8AUc=;
 b=XtdnW3jHt9R7MSZovtYDLm5eTNncWUbajUutBsRQENRC7BAAS/kwQvHJmHtDTwuwqbXiahD8B5BsgrjzHGhg5WqeEf6LU32zjvQkji7/pVot1QSggR07juYWtvCKk2pcGvl2ff8lQu6cesAI3QR6xA28BV2tD17ff01oycdajVS4R57pwJ227+mYpL3WCLU36tMqlp3NrnVEt6Pk7g/PaAklUWwWdCz4KHxY+eNnTUFs5xUXw0IEVi7hbQ8TY8lj7mAWDMybtJb/tqVbMIr77FGJ+MPKCfI+j4F97EA+c89ZWteKHyCSduLiK4c1g/RGkrznoUiHPvryGAn3kAKTBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10955.eurprd04.prod.outlook.com (2603:10a6:800:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 11:15:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 11:15:17 +0000
Date: Thu, 12 Jun 2025 14:15:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250612111514.rfb3gpmlilznrfxs@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
X-ClientProxiedBy: VI1PR0902CA0029.eurprd09.prod.outlook.com
 (2603:10a6:802:1::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: 067d1158-bae9-4582-7bfb-08dda9a2692b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3SfwXbeKFi96rviEoeOj8TeBQfspvL8gDWiD4yBnvYv/oJnmK3XCLaJssFhS?=
 =?us-ascii?Q?mYukM45Rhh5+94WFdPvkKVJGQj5GDjEy3ynEQeC0OR/prug91k5e06ma0kCh?=
 =?us-ascii?Q?3602/n27IfuagzTfYJXC7yDbubeuHxk4ByD7icyZat8kIJ+e6YinsQZQRryi?=
 =?us-ascii?Q?eELzdNeQMgDOlDFYv7tn0OcqePE8HOZJUCtOuHWot0/GDZQOcqXtUrIYNQxt?=
 =?us-ascii?Q?RXCEj/ZlZplFIPx/fzhoG032G7TrJN7BYH6zpHy4mbCKniDtUhJKm3DF+uOh?=
 =?us-ascii?Q?DHaXFYk3ujn6svcaAH+ZMqLcQ0V93cR9aybbL6ZewwSVfKGqsfz2Hquo6tgx?=
 =?us-ascii?Q?IGojMBHMxdJ5iN3eUwRtRK5dayzSqwV8QsXaM5uwap3gaKRP4/ITTAXuchUN?=
 =?us-ascii?Q?8vSdknvWHJUvtu7Q9nsHMN2dLkP0GYOzLIlGDt/25UGNXcNoMFANrYtd8Vde?=
 =?us-ascii?Q?LeGrfwJ6k0vDYj+XuKntUZJz4/W+BAQW95d7dfD5yFeRWxroYwfiWAUyJun8?=
 =?us-ascii?Q?PTwmuG/P9e151cqUuNvSdRIcSYffhuvAO2/ozvDkwRkxj7e0Tf5seGug36G6?=
 =?us-ascii?Q?3MWeQp/DxQk/XiaxlbA96yf4kA85btabM29oOVqe+3UhL+CEQwH6PaKa3zXO?=
 =?us-ascii?Q?2eTQ1Ii8ZOIELMR7RqBEPwEVrcAnnDVzKB/kuIhJz+ObpJU1mQ1pmfAuKNR5?=
 =?us-ascii?Q?wUZySeEaeLgVEc9M6iCcDjYFAii1fUD6Yo/bRDVm+iWxcGq6D+3q8sO3WqtY?=
 =?us-ascii?Q?WzQdhbXJTMn0moKUzfuQ36hMXTBgFClrMfTDVZaCm2s+5h3Fd6y+tHYQ/3Ui?=
 =?us-ascii?Q?ymmMo9PDMH7szbc8RwxCdeAIflOVukRQhZOJLfgkZMUCfzGKwO1ywYRzAgJ6?=
 =?us-ascii?Q?wpEluZUDNQduj7POWpcumh18c1AXoSIUOFwnltoDHGme2lyu0iiIvWPOTG/w?=
 =?us-ascii?Q?ZP8I+jmX8CHtSNQVPqBwmKjNiFZZ3ai14n+nY/tDU6q3qTKGrQvOduDs7Oyn?=
 =?us-ascii?Q?9+6oAxjqDP6cAnGFGuSclS0KWbHHthR9vgt+DVGD4tBox4KQQky39F4hy0hL?=
 =?us-ascii?Q?s1ooNoIMQbj2TH/IHLlmUnsapBzYtFYYlE6uAD+oxu1p7p6QKuiUSa58T1Yt?=
 =?us-ascii?Q?yjdZXdbO1Qv8XtnRYIYSaX+uMBkdq7Qy34YAzo2TgcXNkv0BcEodW+aigEqj?=
 =?us-ascii?Q?7Uy7rsBn64wB6P/Cw/hVs5W3iiOxvWGl4Kr06BwttJkTyebCBmE4rpKIY70K?=
 =?us-ascii?Q?Y/QZ7RG0AgitVLQAsC3lmgSVgxgCVwnyqc1ZFvUCaWLVbtD1DC4XDc0viYMg?=
 =?us-ascii?Q?D3Lf5K0EVLYGzVBKNSgezeN75DMPb1+Wssl8NtQRZ42PreBVIkQXo13bKc7V?=
 =?us-ascii?Q?+LgIUJAo6J72F+hIrL/KPrFJOrE0ZUnAsGyFUMNr33eRM2ScUB1ejC8BRKrv?=
 =?us-ascii?Q?H/XU3q9KWM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4rYWw5WPH6+NeRQ8dvUErlqTrDvpI0vJZriy8DeYuIlzjWc0Prm2hkF4XU0Q?=
 =?us-ascii?Q?mJHeu/O2AmQpUKWVN/rN3JebN5MCxhP6ktLOugP+JC+h2aaO8bP+d6M6iSCY?=
 =?us-ascii?Q?G+CvTP3bDp+X6q7vZjdqiLvZI1lZmL06bMfViH2oCfWLUGiL8JBMN6sPn+tu?=
 =?us-ascii?Q?tnu46UY+IuCoBjQeW/hJpEmPS2F2sGB4NQI2FZLFSKsSVYrxOX6VA6WlssSj?=
 =?us-ascii?Q?XSlIaJZ1YcPqfyeSAhOrTQETDuyy3YV26sdZ7NbAYhe8tQWrW4MYd5LWQ5BE?=
 =?us-ascii?Q?QdoWPmiflLJTUZ8ZLcU63QWtNHd9gyaOioc6UdCQrGnRNAy/pt5k0PPlDDpo?=
 =?us-ascii?Q?8AMEOGEf7GdCfEU9KBVe6t9tucG0bIkt6VRutgVZbNv906vraC+sCBMj88Gr?=
 =?us-ascii?Q?xoOU7ZNtx/A8qCSsjhExyMfyVvYYY13TL/uiGqtJhwbmC7h7nocqQyvhFJW7?=
 =?us-ascii?Q?cn+fXhMGqZQrloC/lnj2oOktYmFZIwrDy4vvMGVCWR59kkRa6Nvae7IJJ8JP?=
 =?us-ascii?Q?YNcZDebWvfyKHVna9dl0+YR2Xu1k+ph5P3WxloPfxHA/cVRsKGgbbPrZ6nOx?=
 =?us-ascii?Q?A/V+xl0UYTIIzHfVhjvIRBJiLqqxRxHl/7au4ujuL5h1IGQuJLtzfSh7R+i8?=
 =?us-ascii?Q?ml0fE9Ka3GOrAZGuguj1uu3xBloEqApWG03TnK9vm8nxysdcUvtvBON4vEp8?=
 =?us-ascii?Q?CEmQ3Nhhexvn/uWwNvTmnZD/sdyMk1VOnUBWzcpV9FEpI97BS/D+DF8+FiX2?=
 =?us-ascii?Q?Uhpc/4fv/pbDSPwtlrSEPyf3bfDVml6paMQKPHdR68GHBFIVKOM3yUuinTFr?=
 =?us-ascii?Q?3bgkXtZOP/8na6mrcc4DN8xvk+hfsYUwHPVx10vv+Ru83t+5TE6kEhmcIr8w?=
 =?us-ascii?Q?Ek/LIr+85AftteeslC7WOQA6lXzPhn+cNxmy390+eb/jOFFg0ICOMT/MjbZJ?=
 =?us-ascii?Q?99W+t8J3bXqwj+YdMLxHGPHNiV7tZIN1S80TEHH7NIahMZ7LsPJuQa0d4rBV?=
 =?us-ascii?Q?HWA45c1BBi1NX/RYLar6AdER7X60Qm+urcnNFap3zeeOTAuPpCG39MyZdTZ5?=
 =?us-ascii?Q?kKwjQeOSwWi8ANtYbVMAprgFSRTU1NssqW+kohLV5cZeCTYRlNSBPmIy9Bd8?=
 =?us-ascii?Q?FVtz+XC2H8mTjm/hb+Uwij6FVzA95tx8p154SKThZ6TUdhiCcG0gmGkEn7ZI?=
 =?us-ascii?Q?Au65IMO+8ppRlAKzxmhs2WfQAfw7y7hNIp+5CVIXGFFVhaf+NyNRA2w1EmyG?=
 =?us-ascii?Q?HjYtBiCtJzHk+aRx+ZbEpofjf94WseM6bTcGEfEg5C5xI3Yq4yiXP1ybBWbM?=
 =?us-ascii?Q?5M0CA4uO2dvS3KSwWGMMq5F7Qssa1QlTYtZKgpZJbEI/zrhNvjeKcY72zobP?=
 =?us-ascii?Q?nSbmheUcEK/hwR2lA9Dz2CoqyyS0hcyvSyoEP/mrbTL2+TyCmEpzWDFlJH6p?=
 =?us-ascii?Q?NYESrcc6qBgswCbefj2Ym4uPrY5F4g0SLtZO0jkz+KjAxfGXviY6FpQfzUfu?=
 =?us-ascii?Q?TsisbdZDU85SR080Zu6iGQdktETbYLfrqrOPv9GVUiQab2+Ct6ZcwuPIGfP4?=
 =?us-ascii?Q?ehGSfOlTx94NLFkSZnrgeD13BCTmDNeU19d6LzpRxfKR22Xz2e2J3Qje0syo?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067d1158-bae9-4582-7bfb-08dda9a2692b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:15:17.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cscGklYGkpUbdbxSMeTsRh21PRO+KZD2MbXPWyCJ3T0VuN9rfSDtElOXn4Nh2AZR2xeDYbvhzpeqdk285CdlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10955

On Thu, Jun 12, 2025 at 12:05:26PM +0100, James Clark wrote:
> (No idea why it goes faster when it's under load, but I hope that can be
> ignored for this test)

Might be because of dynamic CPU frequency scaling as done by the governor.
If the CPU utilization of spidev_test isn't high enough, the governor
will prefer lower CPU frequencies. You can try to repeat the test with
the "performance" governor and/or setting the min frequency equal to the
max one.

That's why I don't like the DMA mode in DSPI, it's still CPU-bound,
because the DMA buffers are very small (you can only provide one TX FIFO
worth of data per DMA transfer, rather than the whole buffer).

FWIW, the XSPI FIFO performance should be higher.

