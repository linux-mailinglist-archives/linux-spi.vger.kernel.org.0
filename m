Return-Path: <linux-spi+bounces-3373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77016903E93
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0448F2813C8
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B417C7CD;
	Tue, 11 Jun 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="oMcsH1mk"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A75AD2C;
	Tue, 11 Jun 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115685; cv=fail; b=KauJcd3LHEWqn4o6emzXG6gFUgzm1OZoO2Cqvhx5gJg6FJYXQ8QusPJP97Z5nQk9z7QsxAnhxH6sQdXYqCzTX4Ku6nyX1yMv+S24hzVZB1wVQUeJw8IQy3rICMMqtKrxYQ7dX4od/1B9NBgnlOei5efwvCOAxkDvPSXfZNAiAWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115685; c=relaxed/simple;
	bh=WohYFxrVQX2OhSJ8bMKaNgUY5Gf+44fdGeYPBiL5N14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z1zyC8mInxljGIvFrt++BuiA8wcmcjw0vZxAukrt4A7jLO7jrVpJVe29OACRRmnDthIEXEtpOBpbnubHGUFEJwmEnL78DzJTRtjJHTQyonEieS08W+TB2Ut18D1Md5HUQyPRXreSGG0tBu9qqZla3O4U79Mxboczddk32y/i484=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=oMcsH1mk; arc=fail smtp.client-ip=40.107.220.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdAsFvZIcN3Cc5Z1C/uiVtG3zi0HxwnxJe6DSWufUTH/pKbOPPaL6Cw2UPl5K/zdINmpt+WKR4bCwRyTZRAebVMvtY+zRFpuMLsSqKU1M/r9gYYtoIqDlJZiWH0ZsxTS/99qOCOv7DIdkQsG67hOyjTklAzOqfni5hfaryUMPz8TlOKojVRsnqkDDrWkihyfpP56nL7AHTa+ZlnxYrrbORgttq8w52lwG3wrKkhaGEF75Sns1OlLl5yMcPLJT/DjOtLTk9omTqHnGdPQ9Aqh2Uoy6bpZesY2VMA0oiDT+svQ5N2J1aSAQRqG92CvEwh662yTlGhNXxS/KrnNcSqhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9OrdR56qxF5XXhRzyIlayb056N3hUfN/nI5T3laWGA=;
 b=YKEJu5UDPa3PXKcOloOw3H4Iz6jf6zxt2NxGszrhdmAL5jrbpXFtKFPNyqxtwZAO9JlHePWsa42KN9X2rNASqhcsUWrpfeVW0SpWAN+SJrN+rs/Q2S+r14Jt0bPNT1z+llEHXgpSLquVpBqLJcdwyux00JEjH/lvqADYsq8v4v+QIwcful7W/94Mf/h5X4UDD5acpSEdgztwihUm3aV8Ei6ZK3vf+RrrpBFnuLk6Zk3K0/kHYONc/BwvRBgrxHO/BlbvgjxhLxvWqqn8zQ0T/52I7e06rKV/WGuv1yu69hiElfhHs6+mS4/Yp7svolHuSRO/Dh/Jpc+pxPFxM3hbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9OrdR56qxF5XXhRzyIlayb056N3hUfN/nI5T3laWGA=;
 b=oMcsH1mkbn75P+5f4kc4Zzkv//qsyJBxyggzF0Ad4QtEE1fKoLascc0EACskclBD++0zDuPP6GcyPnhpxC4ZuRV965/Q9zMlZm7mX4+PbvWCcv3M/kPBFFZSkvYQWGo2C/tZSwcJPdhRWSO6UitnNRQ5iQTclWqdWzxZvO0Qg6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 14:21:20 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:21:19 +0000
Date: Tue, 11 Jun 2024 09:21:15 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Mark Brown <broonie@kernel.org>,
	Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com
Subject: Re: omap2-mcspi multi mode
Message-ID: <ZmhdWw/dV5HRU/Nh@colin-ia-desktop>
References: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
 <ZmFt7yfZFFJdsZuJ@localhost.localdomain>
 <ZmJ7E305ow91ez2U@euler>
 <ZmMrJ8uaw85a03Ce@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmMrJ8uaw85a03Ce@finisterre.sirena.org.uk>
X-ClientProxiedBy: MN2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:208:120::17) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d185508-611d-4df4-a9a9-08dc8a21c332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ou5KVwcabBSM+62NS6UMTzZn9B0tjwcy7nb5ydiqEgKO805DApbp7v+8ag9O?=
 =?us-ascii?Q?e5HB9l71is+sTFtDJHNC6gmNwlc+geUjk7oZ4eIHUjgBqhPGImOU1X/3BELL?=
 =?us-ascii?Q?jYv2alpxAyT8daLkP1suzpNhV2zAndH2vI+baT2KK2Gd9z51Enexa+kFNyto?=
 =?us-ascii?Q?MV4Tg8w4VU5jQjbB1AiGJPPws72866EC1iIRPqrWESQ+cKbd/uC87m4nPI9z?=
 =?us-ascii?Q?aev+nBAoTU121+b+VVmYbpiHvT9gLLmHVMfi+r5QNscI8PnTPwPiRZGKo+Jz?=
 =?us-ascii?Q?mlCseHZhxo+4t6ohFLkuVYqfpF9EypDL0O7Q6ShccMxvS62HpH1x8FkNaFtr?=
 =?us-ascii?Q?SGYdVwZskjJG274zTiDVgespNZlbMQHtfyfaLIcWmOnapVQqyZpItrsBNvQ8?=
 =?us-ascii?Q?d2HI5Qq5U+hRIT54jCxDF3UmV54HdLR4DHZmIH8SCw7hVOMQHn6WhyK61i9i?=
 =?us-ascii?Q?s14et5ZXEhIu+FMZSxpufpsZ5UVT3a8bTKoZnQK9TrAkUdSfJ104tDLOByR+?=
 =?us-ascii?Q?jrAAw6zfWBclZXRcuz8opwCCZCEsdTppnXqrKJ8EgUN958axQdePVW15RPST?=
 =?us-ascii?Q?q2mEZ0WibgzFjjBYtIdAq5cYYYneSoyfEx28hZYVyIw2eyQlgwqPiKrWS6G9?=
 =?us-ascii?Q?rCF5GoviWUNW/xi7GGzTGtjLqQ0dsVOvzOGq4YZIexWnkdX7exNd6npJ5Goo?=
 =?us-ascii?Q?+4rxkJVce2ja6wgB1lMGmnx84vZM0n5P1MGZhQR+PzQcqPitI9zOMEmcp9hF?=
 =?us-ascii?Q?vrZFi7aiIfv9VybXLk6YQNR1T5fOerxMSyWWD+6eV9dQJLGCnGie9Xf0L6d3?=
 =?us-ascii?Q?3/Ex5AWqMxa/QbYnBsF5caFSfvTdwIbtpZSRUdRmNAbseyAl16jgbgBWRydy?=
 =?us-ascii?Q?eH63ROkeuoEtTLE513HDSASIqe8Isddbp5lEnLrlkwHg4rCMYiE8oj9lT00g?=
 =?us-ascii?Q?Pq+35CCZMJCueXQqJrWGWWlE4jE8nvITrTqSNOc41mPaDgFKghVbPty+napo?=
 =?us-ascii?Q?slPPPrxD1AARTH0+mo2Ki3hqCEgPSp30jqL8mQ9OXSOsgyMWDIFAWcE5xIXp?=
 =?us-ascii?Q?RRvf68xl9yL9+B+t6iWblUTRkKX5fQSweL4Z9/3B8PGXSLuvrldBZLejtwgC?=
 =?us-ascii?Q?pBqNcgSPJpnFuLny+2IgPR4UIMJI11NQ3VtNn0nGcIqGKR0yW1aBhQ8JHxVb?=
 =?us-ascii?Q?GqB6CfSjJwTglxBza8ug78LfjmewEepGOKA+y4R0ye4wr1FfqIsScOIgKNf1?=
 =?us-ascii?Q?Z4/EmcSaDQG3kD8n9TubyVLpVsF8/fB+SaomPZFbWtr+oL8dZa25Qei/qToH?=
 =?us-ascii?Q?jXXOyFYVS83Vf6uZNCbSSkRr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngDkAbbvRizTL1iLviCQlr4fLId0FVYXgJ0nSU/PHSpN4wLjFIT3lyih/5Yf?=
 =?us-ascii?Q?w3pzQy7bCm9Zl1G5lLfKKp9VrFtv9mHdo9VYeGNWdHUnq9xzkuEoF8S6KCBN?=
 =?us-ascii?Q?pyYJxvoW1BCiRP6dyiXQk1+kuAsAagcd1Cb9U+cYHohTy15b3u4WMbE4LkL9?=
 =?us-ascii?Q?57lKQQzT2OTYTGcBK7QU40n0vpfmi/bl2dufodIUbDEiCK5GNJaJ7LgBbjad?=
 =?us-ascii?Q?ORDzMqJmUIYg/P7Z2QmU5kLQESYXdExoy9K+HdmXtcPXAWta/ALE/LMQT9hi?=
 =?us-ascii?Q?Yw4wjBOCx3cm0Jo4FuyeIYe1geBFjn6MR5t9jUgAMS/w7D0WmYs8rK++OjXY?=
 =?us-ascii?Q?CfHFRa/Khrh4nL2y2pNTfv0+u7vEKRp1foswa4N8eiwIc0NJw6dey+U5IhyF?=
 =?us-ascii?Q?b4AZYentgBxteSoKyzQ45u8SP7JIALj+502iUMIVwpcgEPFziaBGG8HsgZkX?=
 =?us-ascii?Q?pZZo7Q0DC8t6tuCRHur0Mq+K51JcdlpPmAUXm18mzP+GIfrhXlziuFjskUxv?=
 =?us-ascii?Q?q8ozhWsRGxcLuGsix+G42LjyU9Z2Y4Ht+BCxt5JdTY04I1h+kcY1HaE09xDX?=
 =?us-ascii?Q?LV5LuxxrXn1FctdWzk0rmYlDZ9NfY4PoD12tkxSbfDqSJ4z7hn6JxP+9mo/t?=
 =?us-ascii?Q?zgcxEQXKiv4DhT6pNcuU3GMh/KNvM+0ZtTc7VnnzsGdwiSu66JEluyi/xrA0?=
 =?us-ascii?Q?KRZVDTPi16wjW+eA4GBTXte7xIaEq4DfL9PPr69Bc3L8I0lVH64s2F2i6QY1?=
 =?us-ascii?Q?Lp4QmVsAMUkZ6DfaBA/MNAGjFgRXGXkQItk2GrOWUtrHTpXxTQsjW++0D40j?=
 =?us-ascii?Q?Nqmyd48fGw2urfC/f+gMVm++CdSJM+NHDnVbuDeeBaVQRLh+CcInu33YavnT?=
 =?us-ascii?Q?zFc1993q6VxHXQAxZZN7lcEL94YfS4XlsNhxTISRPtYVbH7e6ioUXAKpeGzo?=
 =?us-ascii?Q?OGLfZg96BnCBWbz+1zfhgr/Fd/OcZPhSpqcgW1IodkO2beJEXd0Lx/+/vyVE?=
 =?us-ascii?Q?/h3DhUT/d+ZvW8jwS10QyQgA/YAH6eZbXVAyaeMlzGJYfq7+vWXFSeu+X24U?=
 =?us-ascii?Q?SJt92KLEe+WnlUbdNo91wGn8iVYkpl8ZUF/kmeeRryv9BZ4OuHL4UwBxcyDL?=
 =?us-ascii?Q?l8ESzi4PnQtaFkpDpi28qjAIb0C5T+Pc8AiJeJYIkhlL1pwPWIfRJswAGrS6?=
 =?us-ascii?Q?kZFIvusXoZwm0b0y7cCjIX1VXvQbufrhMw3gngA/1TSOpWaSyVNOvPyNBklL?=
 =?us-ascii?Q?O8L9EXW48FqBTecL4oAd10492l3DCghTCChD37h1zfpbKn0hLohMAvKhaodQ?=
 =?us-ascii?Q?QbljpUKPJ+AcLx+txv6tHZqZj1XJuNCSGiZ6FrS5NydASolFWZ+FJdpV2bt3?=
 =?us-ascii?Q?nf+aYaQcRz1fMv+NPzXMcdbOMaoTmkh5oc57UaaJHeHB6DA5GdZ2V7Tc3vlT?=
 =?us-ascii?Q?LtxYxxayxe+2OSJsbgjsksbqH6vOlhabpCQPVmbD/ysioUmECpC9kPAgyHtz?=
 =?us-ascii?Q?mdAGxJvEA7l+zjmHFH7V3keKmBvYitgtGRARw5burOQcvkNofTIDytaSIgJ8?=
 =?us-ascii?Q?AjTYzZYyVjx1vsygmbDquJiu3OgaoxaV/oLqGevwdIsCi7Zs/ppGBs5/+OvC?=
 =?us-ascii?Q?IaHqE+HzmqcMW+ja9Vo2TW8=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d185508-611d-4df4-a9a9-08dc8a21c332
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:21:19.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCjQM1IsV7iS5O8QeNrNTBbI6D/5sgQdR5iz2eKeko8wJuVhMwcE0mbDYdAuHc2DziOhofqOswym+JZl1X7nzlD7iZV+1QPHG8Cm+oKINmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510

Hi Louis,

On Fri, Jun 07, 2024 at 04:45:43PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 10:14:27PM -0500, Colin Foster wrote:
> 
> > So I think the question I have is:
> 
> > Should the CS line be de-asserted at the end of "spi_write"?
> 
> Absent bodging with cs_change after any spi message the chip select
> should be left deasserted.

Do you have hardware to reproduce my results of two spi messages no
longer toggling the CS line and leaving the line at GND through the
transactions?


