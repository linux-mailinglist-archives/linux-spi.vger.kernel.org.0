Return-Path: <linux-spi+bounces-3530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7D912BEE
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76AF1F22084
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA115FA94;
	Fri, 21 Jun 2024 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="FdpoLc6c"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2090.outbound.protection.outlook.com [40.107.237.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8ABDDC4;
	Fri, 21 Jun 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989005; cv=fail; b=dyENJMYIbgzwMreQN7ypScW7jSo1Z5A90PKOt0bt7oAFaqt4uGGBYp8mu55lD1qDBd7bO5wb9U//d0c6TdM5J5Cwd9kKlhHjc5wfRIm4EY05GOP4HalwrixGPp9XtlrzZ9Ikr2vm8DWSnHRni0T9Wvv1/z42OU7X6ZxFEKecABw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989005; c=relaxed/simple;
	bh=3VeFuVjxJtm23X0WSqYOiNA46EfZpI0Izu6jJUb1PuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ibnsOKlGVyh/rxa6PEbnklXA1SP0d5tsBhXN/mrXuCJl/v+OBJ4DDS3PCcP83K029X0uKVNI2hOkGFeCtGW+JXS5JyfR9g2GLDYbizqjnwjNQKLj/XAjnf3c2czlX2CoMx58tk7Ie5OCIoTAWMqE/uM4DBHpmTG59DyHcDBs4R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=FdpoLc6c; arc=fail smtp.client-ip=40.107.237.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOPZ85GHht4SXJVaXifeQSnm7iDQSPGS3nZVOb/yVZxHQL+yM1WeADiURrqPpID5ZPMevaqHbqwA/qXRzSLdcf6Ifqp4Mkt5wkjwUCy79yw8q4xC4C+q3zaR97SO2d87UC97/FogBm7T8ASKBKByqKb65DLIkBQSrF/mTcvVfA8nUYY6WVO0cyweIxV+lMVajYkZCeOlraoC/KsIeKJTcIUGb7emnEFYxZKoe7jhmALuCy4Q+5p46+zlXykEYNjurZZlWmO8WmBVhV/fUbpMHxoGv6zk1UvxS7FQxb4l3UluUFKZ+v7Wd7Ii5c0m5NfK7t2mk0SVOO6fF77dtGgcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+AWnPZhgQZ3x3HiML18RA2AVQESVbxHRnnFQhiffw8=;
 b=eGBA+n+vwVJ+LAUFr8yld9SpOnfa/ev4O3Pwent6jl/P8tAjH0gwYvPWDlA4OT1Nu7kzptYqZaLJYLbBCML6VXPbou3305SYEL17pnXNMWih/3Fbql7LRCPiXQq/XOcBLwH6NCB1nAb7FMBOceic2ycV0487krq6lEzC/btg02RGlY4bzoPIeZi2hBCEKnwXshpI9oemmQWfSDB0/8yQ6kl7kzg/5Us0YRFflE2ZqrmMkchpH5bLvzyFEeN6ncYSAxuvCUKKeOyD9dZ66boaPSxSHwAGYEBrWldSyAdSRHN/W26fJtvaSzELvIui1RJzF9EGHjMkebZSfaHitrQXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+AWnPZhgQZ3x3HiML18RA2AVQESVbxHRnnFQhiffw8=;
 b=FdpoLc6cjaF+tOJzD/9vzUFb1ZtD0zdKyv7YBWtY7gWw5vlIFMUQDXXuzaZUamtmNOv8WrgE/aItYVt34YUVmKPIPHYkTvCH+YCkpWrqvL31fzfLJT9IA+qqGQJ5oblMXb7hDQeflxv2cZSAb/Xndm7Ack9AJ0RJnWw2XPxElD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by CH0PR10MB5164.namprd10.prod.outlook.com (2603:10b6:610:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 16:56:39 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:56:39 +0000
Date: Fri, 21 Jun 2024 11:56:35 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Mark Brown <broonie@kernel.org>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com
Subject: Re: omap2-mcspi multi mode
Message-ID: <ZnWww9CF365YjF6P@colin-ia-desktop>
References: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
 <ZmFt7yfZFFJdsZuJ@localhost.localdomain>
 <ZmJ7E305ow91ez2U@euler>
 <ZmMrJ8uaw85a03Ce@finisterre.sirena.org.uk>
 <ZmhdWw/dV5HRU/Nh@colin-ia-desktop>
 <acaf2d70-d821-4951-9072-931cb56b1b9f@leemhuis.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acaf2d70-d821-4951-9072-931cb56b1b9f@leemhuis.info>
X-ClientProxiedBy: BN9PR03CA0733.namprd03.prod.outlook.com
 (2603:10b6:408:110::18) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|CH0PR10MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb12818-65a5-4227-84c5-08dc92131e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahb7WJIMw7XNqgJdxZkm/XvhmXPPk5dV/GNHIo0HY2aE/t2iju6DsuPkM3DR?=
 =?us-ascii?Q?rfCcJwRuvPlqu8thknhJHJCro/2a/7qMDxKO9Zuhlv8hpPC6IoEgHfmpNxtZ?=
 =?us-ascii?Q?3Gyy677ivX5/xQGC9X11V9BaPgVllxtifkzhzJ50AaFn4UTadk5rRCUavjke?=
 =?us-ascii?Q?SiW2/1NU1l5AJLcMEILzjCak6Xg6b3EgaS8qT23NgOtrO1+H4W4M3yO6+OqJ?=
 =?us-ascii?Q?a8Kqo77P4RVV6mAJ7eonyM+yf8mUhIF1ieNo2FrmeF48+FnfES7qnrAvIr9F?=
 =?us-ascii?Q?g3fgHv7/DDrjJDU3mNK77LHyZIHOVLLpERqpwBMu+mSX8rhvaGaDP6nxdfy5?=
 =?us-ascii?Q?eXSbWubd+H/BT6Jz0fKacCfbfGQQv/WNmkaGRjKymDXv0Ns84q/S/X+leV7x?=
 =?us-ascii?Q?ABGCYcwV/l0rZ3OwYJpl2dPIE/cWnhetMewOTZpGTXGC6dMhJszhO+Y+UNNp?=
 =?us-ascii?Q?r3hs1k/WS9drk7l/L/T32AvHKmWMBSfiewK2L6zeDr92n3ZXHeW3Bn35nG+6?=
 =?us-ascii?Q?JjsCb5DXNFSzAfKogdmdAGR5Q87Xf/wN0UCRr3iaHUbqm7V6PvsZPkn0DiTe?=
 =?us-ascii?Q?2IoD75jhV0Pa4pvOFJx3VtyAq5XUrWJTeNL6OQTFBLO4OUAkBIVsMpzndZOB?=
 =?us-ascii?Q?IIeT/IX0L5J1aMXHgEuAyousqS92X5xBJB2t5rtoMEq8ILNBVUSUI5tKICCe?=
 =?us-ascii?Q?I9281EygLRJ7Kkzm/ZX44mEDVoi/xtwu1cU9i6kb6taYMOUGHyCDaPy4BCdR?=
 =?us-ascii?Q?zxmTyXT9m0OHSTojQ/3YGAscqiIpUDVx2HXdpbPDfo85evdntBmbJjaVF6l9?=
 =?us-ascii?Q?gs5f2mJi+W3nIvATLrZtFFlPCdVKhT7WS/8y74aCyytsG2yIvnu6Rmec3TMN?=
 =?us-ascii?Q?9XbWZqelEZWhKzKIVl9Balmg8dvJZ5QOl1AGWn5QNpsT4gvMdW0vClkoNp/H?=
 =?us-ascii?Q?PtNPhW0mTI4hCXtUc1eXpEZwLf8C4Q14BlQun4BICIUZeYQjo7U4jKUrfu2R?=
 =?us-ascii?Q?d1isbsW6XtJe82wRiqiotetb3hq13Bxint1HDI3y/84FCzvZc/UQ2QDzksle?=
 =?us-ascii?Q?0AmuGm+XrSdZUbON8RVYkQ4CzBJXMI6+ViPHztEChWwx6cghpXYgKzUM1lHI?=
 =?us-ascii?Q?5GYz/tvy2euQfFiCOQNS8OnyhZBN4+GHBmIQqTT1NQdmYlCyUHW0fxUVMXlZ?=
 =?us-ascii?Q?bA8JOBRRRBO0fIyD8jNxgvIOHD2ngEFnorVXrHWxWKUM9KAKvhxJGPPALotG?=
 =?us-ascii?Q?4TualcwiMCDJLrfMwDpvqVgPhz0LCueQdIA1Z5q0L14axAbs4/y7oBL3MdEM?=
 =?us-ascii?Q?Kg9RvJLANFQ/x4+VpCh7pj0s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cg9NlwdNubdUgM/MnByVKMzr2Ivbjog8w32F2ZrG2GSDOnWbkJ38iBBtwuPc?=
 =?us-ascii?Q?f13zXa180+Wfw5vWXM1GyuY3Qwf+HqRBghYlRVP3xJt3VFBsRd1qn3ytfSbD?=
 =?us-ascii?Q?M+ri4cjCApMZjmH57KEcCI9kXysbvlUlrIBZELWe8jtt9fKeePzzLe9kNisH?=
 =?us-ascii?Q?KFJh3Ab7zHEZyJbSV3mfdgdGnkbTbpIZwT+rphEDndHDd7ZMRSpTua+5IoM/?=
 =?us-ascii?Q?yztmNIvbHYHzXm3aP6mVqsm5Gaxn7+q58z8qTstZlAG+CCJuk5PLj3x+6oCt?=
 =?us-ascii?Q?QMubPmsuAcnOHbgDbJF4xSxCmz7js9ovOuJQJbecOmC0rY1C/MX5/io5B5d8?=
 =?us-ascii?Q?NqmZMq5n6k6byHhRakUHY1jTQyyBKl9XyK7sMlb5PR3s10d5U8kA6PQ/gpR2?=
 =?us-ascii?Q?sgbjkSssn3u/BYhbxtrbyJ0jeQGKcrklgfqyy+hI0XAXNWIaWFr/9ny0ZBft?=
 =?us-ascii?Q?39ttVHC9ZDRt5GZdwEQcKQuVOqjNFrphGBEWO+jEiNE2/DJfQstN+ojHYFJ4?=
 =?us-ascii?Q?YUxR58ZUts11WWjT8LZMWMhEyfFp7QmK6jsuF8YkNHyUa+EcmQbWMracy2Qo?=
 =?us-ascii?Q?18fLO6AYSGRXAMtCp/Aeh+jtsKi0TMTgQ+cB7ihAvMaqcL59WR9ou8qReO+V?=
 =?us-ascii?Q?0M9iqXIZ/JcMpH/QZczwj2vJwY6kGRb4JcQgtmlDjedRvYQP+eHTWGCqisRC?=
 =?us-ascii?Q?ui3XmbH9U8s8jzwoRggwcPWEKBkc/1I6jTuDbSckLPG9Ea8whZ2qZ0q0UUSP?=
 =?us-ascii?Q?1hadhccPeZYcTBJpvSP1lduVzQManRmyljRBdL1ZU8/zk9RbcJKHazNW+y61?=
 =?us-ascii?Q?Ey94RJzD0mJACv9trjrFrG47YvxE6VqhCCjdioWwoMTMiPvbhB5GXkZ1Z8mC?=
 =?us-ascii?Q?I6gM1nBs62vJiQN5cwXb/+s6tpkVlq9odkMk2IV3+NNXOK798VybJzxYnzdp?=
 =?us-ascii?Q?zf2E15BgUVm9sJ+AHnsfSclDmnRkJabzQhKBOorL5fUQm95/ajOWPn8ZmfGn?=
 =?us-ascii?Q?ZFi7Z1v8Fxkg9MRHMIa6ZLyyeYZ7rT6zu73+EHgcDxJwz3pHXHJhq21s4Dy6?=
 =?us-ascii?Q?LsgTM1vrxJFk2WhhZDE6XMUbFtcod0fSz8xLwbJzRCiQrxW+647md39JGR+i?=
 =?us-ascii?Q?TdX5e+KNE1Y2574mOaWRXI6zA8ydkAUry8jzBFDtEN9Ip1uv2HKYxDx+LQwp?=
 =?us-ascii?Q?CLn+bUxxHcIp7sH9ga4SMMhj+RKweChQUlDHJjdj0H2eJEVKYzT9JLoMOL0T?=
 =?us-ascii?Q?r0zlXd6jB6Nh5fDJZoz9RTocUBLXwPI6sfzSN2R/igHFWY47P7LrP0Q1NEyX?=
 =?us-ascii?Q?0Xx2WRoIhKEwYDx6Itel4LfrVMiKwQY+OVuVLx4bru11toy33Nw7ccGrcYqR?=
 =?us-ascii?Q?ZbmfuAq+JJSpLitxhtv19BM7QQYkAgNyuBfi0YCUEfPM8gDlX+R6CItn314g?=
 =?us-ascii?Q?desNt7fjZcBCilC81K93wvK9VuyA62JJn5bxTLn1JU/W5OSGMeCL8j7ndnQs?=
 =?us-ascii?Q?ZiC8ToUa1MRHJKHLrj397k9Rs6GPTsLO7kd8ySMmwSVzgomrIerU13zgRUOi?=
 =?us-ascii?Q?QQSPdx5I+81w8pWOM/vU88emLH8AM2Z7LnvmC8N28dOdwPFnn1FTo9qp7y+R?=
 =?us-ascii?Q?w5BbUxtH64UxAEQzcZd3qI8=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb12818-65a5-4227-84c5-08dc92131e30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:56:38.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trDB1PjTEo5APLDj+QtG74Rbt06UQfECkIzyt3AKiet9LzKp+XKBiXG1ijW1AKCYNxQTDEU6YpxR9HqwduHUPitGe7N5bImsExJ3YjjoquU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5164

Hi Thorsten,

On Fri, Jun 21, 2024 at 10:21:26AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.06.24 16:21, Colin Foster wrote:
> > On Fri, Jun 07, 2024 at 04:45:43PM +0100, Mark Brown wrote:
> >> On Thu, Jun 06, 2024 at 10:14:27PM -0500, Colin Foster wrote:
> >>
> >>> So I think the question I have is:
> >>
> >>> Should the CS line be de-asserted at the end of "spi_write"?
> >>
> >> Absent bodging with cs_change after any spi message the chip select
> >> should be left deasserted.
> > 
> > Do you have hardware to reproduce my results of two spi messages no
> > longer toggling the CS line and leaving the line at GND through the
> > transactions?
> 
> Hmmm, I might have missed something, but it looks like nothing happened
> since that exchange. Did this regression fall through the cracks or can
> I consider the issue resolved for some reason?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

No, you haven't missed anything. This still feels like a regression to
me, but historically "regressions" I've found end up being a
misconfiguration on my part. I'm travelling this week so it won't be
until next week / weekend that I can get to anything.

I'll plan to look into a fix if it is indeed an issue.

Colin Foster

