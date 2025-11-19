Return-Path: <linux-spi+bounces-11352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36907C704C2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29A5E5000CA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98BC2F5A3D;
	Wed, 19 Nov 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="D+2R/PWM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jHgtqX4l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0452EC080;
	Wed, 19 Nov 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570745; cv=fail; b=JfKYPBEKT0YZShjjRbuFy0FlHvFrm/sZ2ZgWYbEsmuRCTHDYjHvNF7zRNOkDtXIk5lcn07yno06LNbaoGsoFsWmfyG6G9hxhwhlxVWWrUC/Gydpvic1w9DzqWTlet5M8Hz2praEmOLsgUnMTtNM+VleBlGtUj6UTVI5f587fYHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570745; c=relaxed/simple;
	bh=QOLblHUs1XdjvbyAdN2Mui490rvzNxAC5rp4Aj04gEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XABmljo1XfFNQtqq2YhdFaM8MG/tnxdVHumoQ7jSdWWCRYN7IS/IpEkKWmcUDmXK9BN3wzJXKI/iDDnQP3hjsoX2afK2bFmUsHMXGaRMpsh6P60ZrnLn7LTnjr8LegePTged9Sw/WBj0sBZhdiJ2A+2xSKCiSz8kOLOtMI5a908=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=D+2R/PWM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jHgtqX4l; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5ekJj2326160;
	Wed, 19 Nov 2025 10:45:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=pHmwt+J/3A1+eyminh
	rPZlLlpGg4yiqenaeWhCNXTy0=; b=D+2R/PWMryeRx/5UtMlPBjNsZD23pzABjN
	L5P94H863nsx6PTHqLn3Jiye8/zb5PW8RnH/6iMU0d8aYj4jJreXB7JSdY0PfvTE
	QgMnaOXN2B0wjFNfb+P0rDNGwMoGd/r23c7Qs59u39XjVcdSnkoJ/PjhpJ4UCTfQ
	OXC/TvmMUyeyckfwgAiKrMa8iLm/0vAepcekG5/eL+Gs5J9SR1+82h9vcFr0QGhv
	Oh7bFWnrcqi5z7GlZO4sbWURqnioWJUsIhgYoeFOYo/y+TW9tUoZweEQUgqMse/T
	XZwIZYI5ri1zO1n0ErLkE3UYx5vEBf2nAJAPG1l+dW4qgiK4SvRA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021094.outbound.protection.outlook.com [40.93.194.94])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1d8yv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:45:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8aHeYUEIaRg2AZdTeqnrRTv7XoMRQx+jS90+AOE/GobcuOQ2iSSWNmkejY8ADA4Px+VRv0QomA3fplmmOqMIeDnrT60sEKlNUA1WBBUqQQFFyGy9uJhivzSz5JwrbfhC4rUWNKU8WjfbPtuYmOAN6BOU5HPCRIe8ZSkUpB8Gmbr3TKGik54X96GWIuudRijZaPmOk6nCrPU1JHc5x1VYSkyot2/mSa6yPpDYywOW1ReiateQ2My7n6v64N5YbEYgEmnO9pdXX6h0Uj8q6iMYYVAOyyjPEILlWh1IAVDez2ouxipd35mh00hOtWzXrxTZbzNrUY4LO/6YqwXITqHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHmwt+J/3A1+eyminhrPZlLlpGg4yiqenaeWhCNXTy0=;
 b=lBVRMk5YRDCRtD0OEHP/4yk/dIRtAJ03A8uIchNBtfDKs1kWQH8Q7jhE/hqNYOXe926/CG5j+IebyyVe++1EWheCPs2UKbIgidmvzRvaaU15jzioXUNwgAWrD5LJ/3nHQ6dWTNLBC1T9yDQGVFcNwBGI3pcvkixd3fQ2W9qIjQoXU4IylNGqrLcgbzPHJhg0TC8PBI9VDWolJFH6bRMir0UO3VPUGkrT0Sa2hZq08VOGv7p96/BVrXhdp0we4dsq8oS82p/DEMGcXqcTfqTm86PZne01BkVk/V8X3Pf+gcIjp6WFEjEbZOq5sEKvA88+HeXm7NTwAx4PNEodPzYEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHmwt+J/3A1+eyminhrPZlLlpGg4yiqenaeWhCNXTy0=;
 b=jHgtqX4lJnCBcAWM8hugpFuy+8ny9Js/MmdE7RpG/OCf/Wl4y05G/MF8Z5MISGvsodElFxVapaZL6Y61v5x9YZnYaksWllLNlN6t6bTJQpw2uvoX3vBlXqU0OSkqqQS8T9sJXxY/NVM1W/RpYk7/vuT1URdMFRTZ2R7+mHJzXJM=
Received: from PH7P221CA0079.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::14)
 by BY5PR19MB4097.namprd19.prod.outlook.com (2603:10b6:a03:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:45:29 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::bd) by PH7P221CA0079.outlook.office365.com
 (2603:10b6:510:328::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.1
 via Frontend Transport; Wed, 19 Nov 2025 16:45:27 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 350EE406547;
	Wed, 19 Nov 2025 16:45:26 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 19C2C820257;
	Wed, 19 Nov 2025 16:45:26 +0000 (UTC)
Date: Wed, 19 Nov 2025 16:45:25 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org
Cc: andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <aR30JbIbx3MIySjM@opensource.cirrus.com>
References: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|BY5PR19MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: f87d666b-a124-4267-38d6-08de278b0b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r03mZDiJRQ392M9buuEuKIAlO07LrT1EfHrC99KVZbSYA5P0T1+A6w4dhbZt?=
 =?us-ascii?Q?Zb7m6LKe11FAIiX30GRSeEpXNX+b0ehTqNyCgwcYlaoszzeaxSG9yP51nEel?=
 =?us-ascii?Q?5G8A8MQXr0UUmFmVr/HpSBxK2+YhscGs+hZAknWE+l9ut+ojJmhCGQlIYdr3?=
 =?us-ascii?Q?E0yWT6c1DW0IhYDSZTtdN6HRmW1GWFqOodhLCUPwt/4qFMKoiTgxxzJcSQq/?=
 =?us-ascii?Q?xHsr4nf2+jr2JBHWheakGCTiLCmztrG2tBM3gdXhNjelw75M8CnqReZIJ6pm?=
 =?us-ascii?Q?EvSptJtP8pjaL22xAm3CzQaBhKpRFHzFuR33MiNCFSgt8N2A2o/7inoYqu1S?=
 =?us-ascii?Q?KbCS0RfreUmIb7tPQaqW7HA3jPEntu7dQdIEs2kEDwON4HPRYn+l1aJ6vDjo?=
 =?us-ascii?Q?dXjWyJtPjMtlEVA27TiwcOsIyl0/PLcTYGaf8ekELs54wXYJqP79EyfNRtGb?=
 =?us-ascii?Q?U10MQpqskpChKeki3X9cbDDRyZVQsOHlinq1o1iRKsv5ed/xWJMNP5o5DpFd?=
 =?us-ascii?Q?ARmfBuSgXWJKtN6/+FmIeZx784XDPeucSGax2WHDcho4CQEALtOSHbBXPZ7a?=
 =?us-ascii?Q?KyRbb5SgICaUorqXikogRY8WmLYgdUHe5KzvbSA5Bj4LWbchYnWFs4/mWpPG?=
 =?us-ascii?Q?gwSB46EC/uuS8ztlUwzvQjmhUdnlwTRM+qqwuCEX2DxrDaUD1Yed5gZpmlDg?=
 =?us-ascii?Q?3wEflqtGhv378FzXsXTnPHTtC/q1Mmlru8hj8szI/W8WdQpMJVr3OZvj+JYv?=
 =?us-ascii?Q?8hnllkh/szsQ2sQxZj5ZSHW3Q1hZpYxmhAUrkpoM0kp2JXNf5c2wfYcSuCmS?=
 =?us-ascii?Q?vW/UkKr5Xs8h1oLhcJ9bQzsWmOSrkqLSyAigNeWl4cjvyQmzr1KyRbUB2LHR?=
 =?us-ascii?Q?4QHmfwb+9GIFXPN/+BNdQMbO3bCHQwvHhY0BfIE8nWvoZJJ3nPV7m5gl0b9Y?=
 =?us-ascii?Q?B1tUF8jrRy5V2MMfyYENZft+oNNSfa1l3T+4OfQwDwW9GkV64PjeeMQ0WNsc?=
 =?us-ascii?Q?JSAI/uQcX1BAfAQibTibTKi0ZmNNKHWo8gKA+U15O0GvI9j9JZ9/S4dP0Mc8?=
 =?us-ascii?Q?nY/5+PiC1sWc05OOjhUIynj1++FqpO7rfeejcKbh2XGYWpK2EUsAOUkMo5/N?=
 =?us-ascii?Q?eD0N3jx9FsmYK57iRS3mbvjy1PVkqm6mj1uqaDHIMgyAu2TnQW8SOdgVDv0s?=
 =?us-ascii?Q?OlLikPRYkLmo08szPB/iIUuaIBDWbhxrOhhhyuu9h962HKeB+W2KoPcjZ5Ab?=
 =?us-ascii?Q?wQi2zetdWl3VI3GkzLuM0739JFoSCirTNnNPvf0vp+9m5gQlfkZff5tSqQdB?=
 =?us-ascii?Q?x09WQ/TYrHc6cL+ifuBXKfuWZcp24gVSdgQLyNhlJHx+TABntEYwfF0d9kXF?=
 =?us-ascii?Q?AC0PdYMqjSLv/jLGDVCncLgZKYnq458whPru+je5UC56VrqWw5ExE8xQJbbs?=
 =?us-ascii?Q?L6HRCHvNDDGlYPYixi2yc5+sga9HBCF/BMZjzPr1mGCYPTUYY4xubEceqBB4?=
 =?us-ascii?Q?ULcyWh1tss5tE7jttpd2pwrYFfuYWquSG7oOplHR4CpyJROaZKlXH3AfCBBT?=
 =?us-ascii?Q?I55NBOMGtcq+o62rNv0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:45:27.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87d666b-a124-4267-38d6-08de278b0b70
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4097
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691df42e cx=c_pps
 a=IKYxX5W+XLRgvfagleVcPw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=yPDV39VcGBVkaiJWqVsA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D25F7GYA-INbHLu8YGsxamvxEjPabw2O
X-Proofpoint-ORIG-GUID: D25F7GYA-INbHLu8YGsxamvxEjPabw2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEzMiBTYWx0ZWRfX5JUjAJPr/yYL
 IlPyiaQVqiVpEFt+qf1p5wzDVstQ6gKOHDy6P2UYr5B8P2Y10f6yjbplpjxq/XUMXptQ41W7LYR
 mB7m7gF9YhXmiG6P3NGb6T5cicA100Q6leMhGWWvUV6rGk16RoEQmsUcVI1EEm8wAS7e+F0/nfi
 XvDsW7TuV/ghmfd0sejxaaKDUUa+O8OU0MFWWx0NtuNAeiO+1pKIRnD5c7VPtwT9l73I2UMp8SJ
 Ua0Qv+/DmSUKddO9MAD9kSHyt4v208e29Ehvtx/qgsbxw/DRLG7X3mn28yMP+FLJa5ZOXu3Uc2G
 Q9pypk8nLOhTLrBxo4XTlszYQGqLz5bBMHdklHCLy5U/jdpfc18/YTuvashibG0xBjnjQZI87tT
 lQl9+unqlotyp7G7LuahK4pl9EG7cw==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 04:40:17PM +0000, Charles Keepax wrote:
> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently software
> nodes are added to support this case, however, the chip selects
> for these devices are specified using a bit of a hack. A software
> node is added with the same name as the pinctrl driver, as the look
> up was name based this caused the GPIO looks to return the pinctrl
> driver even though the swnode is not associated with the pinctrl
> driver. This was necessary as the swnodes did not support directly
> linking to real firmware nodes.
> 
> Since commit e5d527be7e69 ("gpio: swnode: don't use the
> swnode's name as the key for GPIO lookup") changed the lookup to
> be fwnode based this hack will no longer find the pinctrl driver,
> resulting in the driver not probing. But other patches also add support
> for linking a swnode to a real fwnode node [1]. As such switch over to
> just passing the real fwnode for the pinctrl property to avoid any
> issues.
> 
> [1] https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Apologies this probably should have a fixes tag, or two and I
probably should have marked it RFC. Lets have some discussion and
if people like the approach I will send a v2 with the tags
included.

Thanks,
Charles

