Return-Path: <linux-spi+bounces-11928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866ACBF5DA
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 19:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 116C830012E5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82624677F;
	Mon, 15 Dec 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hYjNEBEh"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963F226D00;
	Mon, 15 Dec 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822424; cv=fail; b=QpxLIu/3/qNAT4sfsQX16t5h/b6qAfYHOG+m7r1po59bALlPTTxjbqUj47A6XUyX+KKlLheRsI2iMevF+KSqz+8oeYYnJwlS2sZNI9DS1bOIrTq0NUif8upTzNi8EhW9Eza34e2GQIWv9y9DKmp2uPenBm6XMaEF1JyBOTJYqkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822424; c=relaxed/simple;
	bh=X7ez2V2FUyDC87myrG4uzMQRdXq5h4ND/0TMf8TEOtk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjpH787oZ+XjYIggqwWyqy6wy/4UvXvMgg177P9GHpBKdiT+3aLg9SZD2YZtbVpBGc7BcnRBUYLW95FiyDk4sEs7sLwm/x+VC2z7+xipFwxnK2VlsSEXQnHvVV7uqQKCNNiOUN6+7/pPPShxGXMrhEKqOXy2ZGyt4AX8EBWDCYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hYjNEBEh; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE9cRhpVzpe7yhKAliibIeUtrbGkST1e0ax6eHNjNUenvhOjcHi9sIjtxAfXq2GfSEDh4sLaYs9Z0zXTqNalzwwLMvZuX5zSBr4rJf0EmFG69DDtIYIZoiGt3drc8s4FHFwBeFZJ2TZ9blQ2+t9b0GqCsZUjGsSulK0GoqW6xjndg4Xik5uRouqBZf2HiGFV5ktiHwUc10lk27y/C7O3/DA7ya0gi2MnZykxRnV0ZTBqU+hNJSc73uburqjQxiHJ/12xFJn7a8K7m/4Zh+pP4+kkiGkAAb2uZF8WlxSKOJNZowWiugh/kjHbzQev/sqCsbKXJcSx7FIa8fvLBVDSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnotYOTphPqzUVMuJF/jJ26SjYy2pIE5kcW8jpSJeNE=;
 b=ieZ3WP2n8zCmYUpudvOVkWGLkHK7qrcPrRMMmF/nmN5KJ94WYkaSpTpb+wiJDIYo6vXIirmYam7hPaNJ42xRsk7HBXEUn71ex5N3fKdtDCZ1q/z/tGy8zzL2OtNlaTBx1cu0sTUrhmc+pFOwRFjBrH9B0ikW18rqlrsb9pPmxf27Lo9g4SYwrcWCZml2BF6LqFRSJemU8Vubghvuu5YC2z1TJuOkmqMfBH+BNrOZOrx5iI2nL1jbuznHbFbUI5D6F5JQLBOl3YSnoIpQOCZyryLcZ7xPUTRj63plL+F9kJmuy0zNahSVvHxpGXdmCzhEJRNmQIpqY5ciTFhf6kw50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnotYOTphPqzUVMuJF/jJ26SjYy2pIE5kcW8jpSJeNE=;
 b=hYjNEBEhhmFaUprMOhMj+JTMWNcOzA5dHIr05blh0zMueDn7W8EbW+HpxYsQP4D38JLB0oHcDNec6mBPku0v0euLQv9PYlN+cByFuqtYYbY4hKWind6Ykp60K5s8NfDypEX38N5zYey75pQvwLSPTDyWfWSWA5JotXTqoZc0RvY=
Received: from BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:13:37 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::b9) by BYAPR08CA0068.outlook.office365.com
 (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 18:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:13:36 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 12:13:32 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 12:13:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 12:13:32 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BFIDWIF2803659;
	Mon, 15 Dec 2025 12:13:32 -0600
Date: Mon, 15 Dec 2025 12:13:32 -0600
From: Nishanth Menon <nm@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Anurag Dutta <a-dutta@ti.com>, <grmoore@opensource.altera.com>,
	<francesco@dolcini.it>, <s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gehariprasath@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Fix clock disable on probe
 failure path
Message-ID: <20251215181332.dks5uzcmycdfyejs@underpass>
References: <20251212072312.2711806-1-a-dutta@ti.com>
 <20251212072312.2711806-3-a-dutta@ti.com>
 <aTvV31zHFV30tR-N@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTvV31zHFV30tR-N@sirena.co.uk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: afa9f68b-59a0-4d30-7bfb-08de3c05aa69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5Q9F5HHRy3iJU0STI/w5Tf1N9K1p7RrzwMaSLfSuo7zGcGrBX04XBiAYbBX?=
 =?us-ascii?Q?c1WfB7LTUYz5cNNuSIIhgmAlm/Of8r/2YQMUvl8HbTNQLdpEawHoWQnILvai?=
 =?us-ascii?Q?B6Yf8IspLGs/7jG3KR2VRztJBT/nVpY9dDOIWG8Rpx/e44E3U8cURtXtHLXr?=
 =?us-ascii?Q?XXhvC/InJod1uQYGwBYKqW2dnCTC3oamKMnlFNuVFbvuFszy/dYsQeObGhVg?=
 =?us-ascii?Q?ChawUvgbzvqPVBT4DWQgtbeTv0wTzJL8UH0+L0bupUWMCX0yIt1zHAtuPt9Y?=
 =?us-ascii?Q?EV//UY09RcvsDLIMrORo9Zn1N8ssywGGDjXtoSa7TF2ZrLwvAcmYjp62efet?=
 =?us-ascii?Q?9zu2SY6XJqyTqk/KbHMHIimuv216lohVL0xB0kedPnvNusb/RiEy15c79N1Z?=
 =?us-ascii?Q?fK2ptdC+PHroNLuD0dP5rWyv4PC5baYwYgyxnqOl4lNZfRNR4rUpeSGBjUXE?=
 =?us-ascii?Q?rfwo2qLSmlCt5vPflYztWgThlB4XD8hwMO+kfpiOMmbOFGkMtlBxqmFFUD4c?=
 =?us-ascii?Q?H5YBp5ModxysQo6Ta5Qj6f8ChadQIXUur/wMe4QDbKgdooN6hXB/XpfSA8Zx?=
 =?us-ascii?Q?t0ATbLQ5iKgIG3K7+mNt4PFAO0RvCsTmjnMjfNXNEi9Xh8iCoA3T0GgC9BAT?=
 =?us-ascii?Q?KcTCqEfVl+fNQchDIC6v8rUi3vtLDnrpOuilqmi+RmQJzDnZr6lAjFh84Va5?=
 =?us-ascii?Q?AhM70kUNsa81PQEzxvbOVU63Lv7b0mUa7zkR3HalfU8tCOe6NooYYxeM3uEr?=
 =?us-ascii?Q?lEi/py/2DnbITlJJcZ6I5nTh81/HCN3Vup1V17tBZSe0Zfnd8KG4mETk+xaZ?=
 =?us-ascii?Q?IJbG7+8htvJQgzx3+wvn7kLLe/lmnxlO1yV5b+y4JCMaImLWHFDhY91FUO6z?=
 =?us-ascii?Q?1oZvNmCK8oiIZ2L+1D9KJSu8VLvqDhxP1pV2jNxaYRNFrzeOM5kfAbp4nlml?=
 =?us-ascii?Q?SzAbfCEDW75r+h1TiFau9XNOOQcVNEVygSGvBbSnYn//NvVhYf1AsBYwkNi+?=
 =?us-ascii?Q?rEr6tKeTHvO8hygS5IFts8pVm6my8raj2ee/UuGSGFJs9ObmT7s7poVQ8CY/?=
 =?us-ascii?Q?mIVn3t932RMtOf7fl6maE9aDrY46fsYyuZH9V4gnE5E1WDzA0G+dwzVa8GPA?=
 =?us-ascii?Q?hlSLUx0Vwldv4S8BhG4Da3VD+lVPw29AtHWjjM3N2fRzpWjH0Xsa/0njtd6m?=
 =?us-ascii?Q?S66vZI84Jd5cEHPVr0N0FcHMvYNjYhWrpCXKYzu+xZPQVFRyRt8v5SAjWVcJ?=
 =?us-ascii?Q?wy5E+PwlUOk2S4QtOJIzsDqBMbrHYuiycq/viuVDXzJHbc2uRPq7Zb4qWLhd?=
 =?us-ascii?Q?4OGtB51Y4XPwO5I9HS0b/jYp5I4HNgc7Cs2tk1AhlOdfMGaO3JS7HG4XiAag?=
 =?us-ascii?Q?OHxRpmkf06uZ5dZNNilwobCR30PtVomKALEPwPDub7vsujL1hXksU10LE6wM?=
 =?us-ascii?Q?iUQuScAL2H03by7/QWiZcvovvDpe+3xHAz+acdLVM1L/Oii5ftVvNGBQm8L7?=
 =?us-ascii?Q?cLZg43Vc+kDs/4Qv0FfuIC1EoLgvG7M75fW4bSxs4MjiGHQAiSst74Z3FDOq?=
 =?us-ascii?Q?eYae2LINoG4/U8HgGHo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:13:36.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa9f68b-59a0-4d30-7bfb-08de3c05aa69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981

On 17:44-20251212, Mark Brown wrote:
> On Fri, Dec 12, 2025 at 12:53:12PM +0530, Anurag Dutta wrote:
> > When cqspi_request_mmap_dma() returns -EPROBE_DEFER after runtime PM
> > is enabled, the error path calls clk_disable_unprepare() on an already
> > disabled clock, causing an imbalance.
> > 
> > Use pm_runtime_get_sync() to increment the usage counter and resume the
> > device. This prevents runtime_suspend() from being invoked and causing
> > a double clock disable.
> 
> Thanks - this is working for me with a hack to trigger the issue,
> hopefully others seeing the issue in real scenarios can confirm.

This seems to fix the warnings I had reported at least.

gist: https://gist.github.com/nmenon/f062ebcb51f97859e97c9716a27fa494

Tested-by: Nishanth Menon <nm@ti.com>


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

