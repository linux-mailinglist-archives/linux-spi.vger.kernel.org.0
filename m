Return-Path: <linux-spi+bounces-8425-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C141AD350A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597727A7EFD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629C18024;
	Tue, 10 Jun 2025 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KEAFrH4O"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018F2253F8;
	Tue, 10 Jun 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555272; cv=fail; b=jA7G0x5z2Xj/bsjoTVUcrLaetaxycDa10G1mXZKu9K/G6hrqqx0Rig5dXWKher4cqIGvZY4hhtw8L9O+tKJjjG3xbC8jl8E227mlKBz5WmH+bdMZ7Tjwvx1tHxKO6ZmNegEhM3Q9PYB2DTBMjUmTfVbg6V/IdpbIbvkHsox7xSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555272; c=relaxed/simple;
	bh=LMpKkoov/lNwUlH1q0kqfYuv3P67zXEbD7aCju6Xanc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ckr0I79Vqf+iPS4Ig5MKgqUMOL9lxCmCVtR3pxSdmIkrRUxK8gvIljAQw/BICvCF1KvzgzTu1N0bRIcd5CIpIeiddjg2WvZpPNtbi6+KM/Klr8qbfEdD/xxPBKpc9F9pBlLK7egRc2nBf8ybitBSpAsV+mT7vSleTJmdR7g9Gbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KEAFrH4O; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wp4Wyre02vnDa48H6pE89Cfa/cslarznom8e/b33iRlAacfgKLVwaFDweq3AcivXny6Q5ux/7DHCd1k4wSJOTkDk4GkNZCUMegb7IGNcZzCxvQokTwa6c0qfGMvFcrDgL/teW+rJOvo9JoijmclXh9FUHr6oTrrnJRheghYb47OXtgpHLCfgbwBgLDQqgt88Q3Xfc9UlFCl3q/oSYbXePlM4nC1RL40gpSrTlWR42upEsYtvPRkTYfUzmVRfIsdMGO8bqmqFjHuIPFJ1vPGzclsKwfs6HY0lfr2YxeakcTWNYtbj9sp5KAhA13FK4htkA+F+8ma0qZEYoeM8vGiScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An0RvIpwNiqZa0fUR1LapRuY1nXX0C/vUSQROEjbV2E=;
 b=r9nhAYCpcSWj0FNJCVYib8htcc0mvFlhajYQcbj0kzR72KfRAJIgiIshN82ekAuhQ8F9fGjcqj1Kfsk6DHzbiz4TY6/t2awNa/LfAqULzIrvpGrW8uIiRFc6+Mcce7fXRBaRsXjjfERzAvGjeeVeB0eKjX4PsrwagvpfTdznX8NMuuYFpb7Ue9K8+ZPbaUI1dPKxbr7vbG9385MgfcfpWKTumD9+yEh01wZmgg8LxwHyS9UI48g6thUdGkFmJU29iXp7OcxRnUwIm/3g/YT/EwSPcu+wfMptmVdO4WMxgWlC8bxENvCydIa5MWOJwMo1UDJCXInGzKn8bzC7qucpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An0RvIpwNiqZa0fUR1LapRuY1nXX0C/vUSQROEjbV2E=;
 b=KEAFrH4OIRZIPxRmKvwOIMP+OcXm0piuukbD5oqJJw1iir7y3VshboaluMfLEs9KQP17mWoNtR76afpXZmxkHXgtC/n8C0D+4eQ42jqD1VBKH2I4V6KvmOkKdkYwfLuiU7w+v2klxgCcfcXi6H0cT0dSDtwOLUHtfVw+IVehFvmSiXYGV+kd+x+3dmFbhsL40Jd+9LmfozU2AYhqgAfcI3CAOhUGgHOt8TOI+fr7rc4j7+d03MdOheyxBWx3gTpKWyM4/fmXmrnXE8OqeDNCTKkiDeD2jEtCVH/2HhyONxeH/vo5UyA02OjNloG+T424JzwqOSxRTTrpZB7p2SuGiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9293.eurprd04.prod.outlook.com (2603:10a6:102:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 11:34:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 11:34:26 +0000
Date: Tue, 10 Jun 2025 14:34:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Message-ID: <20250610113423.zztoyabv4qzsaawt@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
X-ClientProxiedBy: VI1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9293:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b16cf5-0493-4b17-7d32-08dda812c149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VetehiwYGhXl7Oo44aqiXVb/WnC6fBjFokRkmvYSFzLdFPbQcXFIIhd4c0+T?=
 =?us-ascii?Q?Nwrq8aoKG2dQRD7ziIc+egT+Xc3UQG+VY4KD1gMfiOWT7WFa+9Eaprf8IAyq?=
 =?us-ascii?Q?8bowOB3yUjIhp/PWlrNikkcFbnx4BRaZFL8JMidFZ6T/IBrp/AV/m6Ezsc/H?=
 =?us-ascii?Q?ram4o23PQm9A9dC5zckSV7M/yWyaXof6YM9D4iTltmHh3aTzIexZy27CkcHW?=
 =?us-ascii?Q?6PB0B3Oi+xOtivc4QCwPB6ah1+UjNCZEPaQ8kAehH5W1a3BSuUaLuGgDPHYk?=
 =?us-ascii?Q?GOurcbsvyD9ZhKASwsVmfkM+aE//M6MdGM+G1dBbal2Yf43J1NyaYAsqxyZ2?=
 =?us-ascii?Q?Goc8BkSFkwqUCtKdmgZI3YdFtRZSQHgBsNsDOgU5Y0vTFqZe1tSu/j6wgvTq?=
 =?us-ascii?Q?o0jyhuwKUP2Gle/DO+qoj61kYKOzYrHGgZ34X733f5/jKW0cmx+B8O60VpB2?=
 =?us-ascii?Q?xpu3K6Kp2BDAqBRD4fF2GhoY53ZYSTyAvMvKVJBhOYcuULy0miMPUIdB0Mlq?=
 =?us-ascii?Q?XYFKETwT/aBQjYYb7h3DG6jEMIVqCNLWUZSvUOVvd52AbC1v0ro0SGpOE//S?=
 =?us-ascii?Q?DOQN/t80op/MbYnj3uX9Jh8t0zk7NGfcNtiluiKSoGaNa5PV12Ql11RLk17F?=
 =?us-ascii?Q?6smokok5GAEnyMgb1J0hnbhTss+DLOAk2qbujVVE+v3+jqenoN2w7GkRz+5e?=
 =?us-ascii?Q?KcOBKdIRjYIhH3DqqwxRRKaj6FUmSYCq0WatghjExVVgEWdvOskbPkDxv2X1?=
 =?us-ascii?Q?Jv9Ef8Fghx3ufj+o3ZH7m41LeJOM86R44ey4KEJxWV7s2PAv1RN/byV1uPep?=
 =?us-ascii?Q?559qX+w/dUaFKFtkSmFWW8XyrO7ErEQnRy305Ksycrd6Q3BUyLwhJ1qxFbMX?=
 =?us-ascii?Q?2eyeZDsX7vJ8yCZqxVgz1TSUaSd9xu/Awdjt4zwhP149D5/YMFsjgdP13fuv?=
 =?us-ascii?Q?ti+WroNW3KUMUQDu8oAcT9EbPQcyFyFdw328BKSON07DcExHiRNIoiuEHVR2?=
 =?us-ascii?Q?QHdfn1DqKbkFpYKv12YuSpTkOUg2uQiQt8F2NsuNa5FszX362ceCg9z6UOYH?=
 =?us-ascii?Q?fsOTlV+9k0ZTlgAWwag0Htg/pI/C4+ZwfpDxOL6kBdao2GEZjJ+s6n1EL526?=
 =?us-ascii?Q?ob7v/qjORHhj7iSeGDS4jTzZKvvRVRK/TfPuiLN2w9KI8XbEC2q+ClVNV4eN?=
 =?us-ascii?Q?rFLDzT/Wm8hEqMw8xvyz11RyqOYjMfcrYtO/DvnZkjrnjEnBGGGnoFACCSZV?=
 =?us-ascii?Q?AkJ6DUORJMVazzWRfY4iNXCsUHOoVVKeuuYKcj/51iYhSeBsPZUdH9Kqi7Y6?=
 =?us-ascii?Q?9DU8DI6Q/a87QywC9qNJ9+z4V1ZvvPLfiRKHdLM5Nx2IfvTQU4JDKlRJTmW3?=
 =?us-ascii?Q?wZuuj4czHYXT8cDZdCMOAoFVzco5cRwtaCFbtkj9gWWuEDMJDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c5clPL22dfb5yag0F2l6ZF/52WR57e9SgX+gj3IQA/XvBR0mEEDifGh4t+/4?=
 =?us-ascii?Q?GiR4w5qGvV8spOe5rlRZtkHgsH2YhbLHcfAqBuPT1c/iMthRAWVTzZZElneV?=
 =?us-ascii?Q?HTiIecOXvr2nTm0Nc04KbYs3qXrYgLaG0hKqNy09FVlAm5pvx3RDWp0R6q3q?=
 =?us-ascii?Q?gyf1WhKxMbJIRFjmkD96AW7+o3Pi3QQuxuMCFzBjkMb8+sVZEBUFa4XVoTtn?=
 =?us-ascii?Q?UfSKKUkvNduwzgUinuJmWr7bwb0WOUS2e627IYreoNI8lqoGCMcsqg/qA0F0?=
 =?us-ascii?Q?4e0J7lTEA/w8l9pTGdl4eV0Q9HScrNq9j3ab6m5sohlWM1s8ArH+S/vTyfqp?=
 =?us-ascii?Q?RJOXJZw+Bdm1nz742ZZQCJXGW+XszBpLpQSjtRWqhO4HL99HHp0a/mqWEJwe?=
 =?us-ascii?Q?hdQSF+pJ/W6cEWLTnGIQtB8HDW4RR4iiz7UNXEDpbKP4RSxB+v2E9zFhIIAW?=
 =?us-ascii?Q?nvA/rxSxE2pVd7++TaKkBJN+OFhJ1R7qgfGP66b82Yytxyl/J6pLP9z+Kp6q?=
 =?us-ascii?Q?IPMoQRIA1cOUCDwaykxjVAZPZuJuI7UGsvO2+FMCfbuFu2kCjPkp0AOjD6Zv?=
 =?us-ascii?Q?KldRvT43GUqVSruHtBUqxybLkKQg68h/YNw+fgltNi3l/FoV6JHqe175P6Vg?=
 =?us-ascii?Q?wTh8VKFT5Gu1mG74uCOAFr1CgMSWIZfynBw4A0bkBkFNYnv1Q5otQv52euHh?=
 =?us-ascii?Q?iC8lNgPivEd67HEjMuP9RtmATSnEWz0LlBRdTxIRIg78OTKoKQKYgzYz06Hi?=
 =?us-ascii?Q?eRCnq6xIsoUDCdrtojpypRAv2A6BOFiTh+AOamUfZziZLZjfXuZ4HzGm4aLm?=
 =?us-ascii?Q?T7E8/xdR9ObM2+PLFTSfWshbq31rVz9/P1fZ1PWVmzsNDoCTELE+xjDeuUe8?=
 =?us-ascii?Q?eABNJN/CKeIl9MXRXZIHkbQAij+xIILJ3vwN33pKHFIeOOknzEjTHGLQL+cx?=
 =?us-ascii?Q?rTbk2tCUt4/6g7GeP+g0s8K6BE/Ot6pcrJr9bhObZ5hzSEtK9T3FQq9n//6/?=
 =?us-ascii?Q?jRW+RJSm+P3tgbpK3jv4btKoOQ9ns7cRNLbkC/Lvo/caqk02KY/LBqMZc/YC?=
 =?us-ascii?Q?imBkd0vxZL+uLyDc/KG4P96ymYqwMKYqrO0fXYrx1O5Vm6BIGcb7HtSZ/DA2?=
 =?us-ascii?Q?NTN7MyCMuhfZjUm0VUZjNxCcgc6PWfAp0/h1WU6Qp0tVOUNzYVS32rxINGtr?=
 =?us-ascii?Q?nU/p8eZQblLM1/sZosdbsuuYWT9F5Gi+GIXLtPKtc9gVgwxcTUq2AtjbzYAL?=
 =?us-ascii?Q?oI4bWpba1ZzMHcOCHWPpkTZjA68414xr+PZ9wJF7QTq57zJFQfRlRpcvx1i1?=
 =?us-ascii?Q?JvuAWElVbrR1RZUug9dJXzSgwZVcbnhSpiSoHRjq/4A2YQb6gQz8h6zcdvZ8?=
 =?us-ascii?Q?H6ZqWcAUe8oLAqcv/vA7ILw7DATIlLMJvSS83+s4iJZkMbsVnvWW/HsaMWJH?=
 =?us-ascii?Q?eUdJM6BU09HkHIMy7tF+wdVcPHyoM5+djIgbiN8gnnSI1ylRAC6nMq/+JZbx?=
 =?us-ascii?Q?P+7K7vqrP+cFIWXAsZcvzBn+HNvq96+yA+ANAOZK9/m0caBQIFh+rVL11VrK?=
 =?us-ascii?Q?QFP16TFqi6kxRgCHHN3vV14DQPX28lHk5KM1NN5uXpU/ccCkTG7EipCQM/Qb?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b16cf5-0493-4b17-7d32-08dda812c149
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:34:26.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6efn5kpCmFSDYYNKGt6g+7tZ/h/vazS+wpcw4zjolATSx4jtgxHFbewBwUeIHwInLH0Q8ZN4KDJve4iZRdGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9293

On Mon, Jun 09, 2025 at 04:32:38PM +0100, James Clark wrote:
> In target mode, extra interrupts can be received between the end of a
> transfer and halting the module if the host continues sending more data.

Presumably you mean not just any extra interrupts can be received, but
specifically CMDTCF, since that triggers the complete(&dspi->xfer_done)
call. Other interrupt sources are masked in XSPI mode and should be
irrelevant.

> If the interrupt from this occurs after the reinit_completion() then the
> completion counter is left at a non-zero value. The next unrelated
> transfer initiated by userspace will then complete immediately without
> waiting for the interrupt or writing to the RX buffer.
> 
> Fix it by resetting the counter before the transfer so that lingering
> values are cleared. This is done after clearing the FIFOs and the
> status register but before the transfer is initiated, so no interrupts
> should be received at this point resulting in other race conditions.

Sorry, I don't have a lot of experience with the target mode, and when I
introduced the XSPI FIFO mode, I didn't take target mode into consideration.

The question is, does the module support XSPI FIFO writes in target
mode? In the LS1028A reference manual, I see PUSHR_SLAVE has the upper
16 bits (for the command) hidden, specifically there is no CTAS field
there that would point to one of the CTARE0/CTARE1 registers.
Cross-checking with the S32G3 RM, I see nothing fundamentally different.

I am surprised, given this fact, that the CMDTCF interrupt would fire at
all in target mode.

> 
> Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")

To be clear, if you ran 'git bisect' to track down this issue, it
wouldn't have pointed you to this commit, would it?

