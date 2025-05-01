Return-Path: <linux-spi+bounces-7818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F3AA60CA
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56C71BC29B5
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DF1F3FE8;
	Thu,  1 May 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YqUd86g2";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="G3M52XCx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A338385;
	Thu,  1 May 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113640; cv=fail; b=XrfC2f70oIW1tDt5wg66IuII0SFC6wMrSjtxLCPsu9rxWDkPiNHkJcd/Vg1DMxanOi48PvYDSY26bQRrmcaN5ZDXtY6NscLdcioi0kB/J5pvDOlYg9f9mIkxcYoZnu8x4NkhlatNvIInYMFQ5ZessJuAVQnFWE5ihHz0D8qTqRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113640; c=relaxed/simple;
	bh=5VAWc8syFGlTkVcgy9sOUR1IiQ/18xP01ls3Z25mrjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc0SXUXVGEfCaqQ4THTtof2Ni4wi1tWclpiAemhYD0bf6svht9T+mJEd7biozpkLV/hD8pQ6J6hlni9sHLtl95r4GJqqeYWeus0f50Cur6ZlMT+o5q3aaniF9YiSAKsYqmOOojHI9BbKB/MEnESoAn3CRD4dCL4mx0arRQGrdE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YqUd86g2; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=G3M52XCx; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541DQOf0002883;
	Thu, 1 May 2025 10:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=YuaIsxlkH/ZTGPT+X/
	9b6zU72J91unx57LFxwKCH2W8=; b=YqUd86g2nuR08BVyuSMntZMF2KjelBYPU9
	+HaBR5lkSGEzMBJsDUh3XvB8ZfeVVq6dXo6p2iVstMKlkV1U2m4TrC685LdtWpQz
	Vz/c2vtu02JZFCmGacVCTx3nZwdjlpU8zRS23tDfpAGgDeL3w1akXEMegyYS58kT
	Qj2SDefWAx/GR5cws4OAXwMWYY9gyX+JODbXzbW2LMdzRfKWHmFv9L3miNLppscU
	QFDrWxZ1Q4gpMhUpgibarYqdZggnHbE7f5tYpmJMrzBBsqVyhaINtyEUpFyIoYII
	/umTRT7HRLFl7rsglBJ+urutA958Tli0Qttaws331XpmT5kXRhkw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 46bqj79fu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:33:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMHltjBmUsZn3G60+rGWVD68YYe13K4KqYPFbl9limDmrRqwm14A5czWE7Qp4g4g8wyXvsxCDx4xtPUS58dtXgRSGRVZex9XQbDSYYOOX6/nTMXEZsfyY45BKn2nzzJW840Ga54g8RtM6Y4Ewc52OpjSynmynGpwkgCp/pOZdPjR4/RxAwUhavX3e2nYUGzorN/czGIIBE3qLmV0vcq1N6D8q8swxzybV+t5CL19LsrnUg1H+/tqjzw68HCDGvQez4GxuCUg8E5uaGl3ghv9tGu0KE2j2QgrWOykJI38cdVOmaNftToYWv4vks5+p5M9tI7L3VkaW0O01kiK02WFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuaIsxlkH/ZTGPT+X/9b6zU72J91unx57LFxwKCH2W8=;
 b=WLkqqAuplJltuBkvtCGeWfqti8v+wBQWGuW+xyxQn8QFVT4ALSRFGzygCjCPjLeCr7ZdLx90jYSZJJ69fhIAkIiCW6lOJA58Zr3dtmxpjvUqzESmJSOlKy6x3hasEurA61nqMao0uER3fwkuMU85xE5+9Qah3wCdWbM2y9aXr0odSLvzNmjH1zTKh/izQTZ+d6/H+NxQU+HcBpl4Y2x/yZm1n1X1BMi+D00q9m51Tkc4qcYWMcRuccS3R+ppV+rjfxSJoUzmbT+/Ly/tCSSCrki0rFtTcgGaTaGRk0YNNW1Zpoo0ur+PSQU8ygT5pJ46bzA1C9D+2wmbV1QpqexCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bootlin.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuaIsxlkH/ZTGPT+X/9b6zU72J91unx57LFxwKCH2W8=;
 b=G3M52XCxf8qmpxOQcbGpceq1ggUgUQ46ZFfM1dkUeWR10GjsXpuUMqaRutSZUev1Wag11CffBYcQp3BViluqL1BE6tSHSvPvwSgHaIntM9MTyUSnseLs3EFoXRoPUqhMA/rlC7ca9mozggo1d9jlXtH79aX6ZeuxKZlwSgdtQ7U=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by CO1PR19MB5125.namprd19.prod.outlook.com (2603:10b6:303:d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 1 May
 2025 15:33:36 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::3e) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 1 May 2025 15:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.20
 via Frontend Transport; Thu, 1 May 2025 15:33:35 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A5258406547;
	Thu,  1 May 2025 15:33:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 891C4820244;
	Thu,  1 May 2025 15:33:33 +0000 (UTC)
Date: Thu, 1 May 2025 16:33:32 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 2/3] spi: cs42l43: Make handling missing spk-id GPIOs
 explicit
Message-ID: <aBOUTIoIPeyJSvam@opensource.cirrus.com>
References: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
 <20250501-n-smatch-fixes-v2-2-d2ad9c1f2e67@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501-n-smatch-fixes-v2-2-d2ad9c1f2e67@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CO1PR19MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 288d6d20-5e8d-40de-1f57-08dd88c58974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d6T5kU+8ACUmvMj/VGCkzD5wQVXV/JCOxK11sz55zNMYWL6tODMX5zXVTevc?=
 =?us-ascii?Q?YQQCUWGtaaQT80xSdF3KlHKBJZ/fE1BAQIKeo0sbZYfMFt7+ebeVigcKVHxv?=
 =?us-ascii?Q?4A5+OjTNDaT6YRr+ip87LHR1KuQAjIP4lpd7PMpeAxGzYra6jyXGpFdb157h?=
 =?us-ascii?Q?+QJfn0fsdnxuVabGCK3OzjVBT1eLeb8QguK6f1mgGLXzE39QASMuxH//1wKQ?=
 =?us-ascii?Q?t+xE3v1L2dRCHEXo3798l/r6RPW+CC6w71724jGdm6wDFm1dwSIcxeuo9R7w?=
 =?us-ascii?Q?z1DxyVVZ9EuLUt8klnyU2QOhuhiJ+zQRwH9/h5t1Ca//gcT8LUjM3f9Q2twR?=
 =?us-ascii?Q?tvLz73Duot0FsgV0vzG7n7Vo9J6RAAbXA4rdkGtIhV3pmXxCJigJT1jNbwaL?=
 =?us-ascii?Q?4w3i/obYPC1agPW24D59FDnVNK7yH7VJcH/jbGnMOCB4i6rzq0I5aZMekp08?=
 =?us-ascii?Q?ZoplLeDaFIu9GJp4cb9RVXddnjC2WderLUl2XwLpz8o74A+Smf7WoFgZY9o+?=
 =?us-ascii?Q?eBopBz6Hb/JLsVzVnMXUNQTaiQN3qMi4T2oC38+n5QikIny0Ph9dCgLNLHF9?=
 =?us-ascii?Q?wmbT22ITW0FyLz5DkNkJNaFhlRG4ojksJO+pj/0VK4Qhl1jmV4bhMPFd1cpQ?=
 =?us-ascii?Q?fEMeHXg7HKOK54WxJLmFTOKeRNG5S5Famz8NVFhBZoAYusW7mCQY9B8fQ170?=
 =?us-ascii?Q?zOP7vT7dsHwFXdCZoOIXZ87Ml8ASw/KQ6kPNQFZdMAHy6yQLtIFz5fQ24Qkk?=
 =?us-ascii?Q?y/KvzeiLiRKgILcBEEi4LC+EoYkZhguXmKZi73CNoozmnVioI2xxSqx34oLQ?=
 =?us-ascii?Q?HccrdNua38C6d/whAlSpFyKFGULLZHa0jG1K0GpHlCVCw7rRcVKLOe/osxBL?=
 =?us-ascii?Q?SNjS4pAUGXRvBgIHWGzR3bERsPm4pJkOpUWJbVEt7g9/df2iE27TvQ6vBYLp?=
 =?us-ascii?Q?5OZ2gwLfv/rLZzx1R7wvl3KLp+8HhAOi7+rEoZBpj5GgrnX/UNd42JGTjQ30?=
 =?us-ascii?Q?KQBAnE5aTMQHOBGmU5A5WBeY1bwdlBcqrLUlvdtEe0F8/QjipJ1sVHazfWn6?=
 =?us-ascii?Q?cR4+fkA3ZMFPTz12uVA2Kkp8jBO6j+DSf829ZLcsrei7rPnGjd71OnT2WjRG?=
 =?us-ascii?Q?Q9AsbHQVxwbVvGIH1H9OHM2GDj4MZDASfRDMtqAOUqLzn1uYam13hl2w7VDW?=
 =?us-ascii?Q?LFqO27gryBqMh6zWl9nf4doKjnPlEzy5Rl0Y6gQOzn982pt9q6HzZ8pAzrGo?=
 =?us-ascii?Q?l9Eb/5fXYt2dsM5B8YzOioDLpcqmZZR8SXx5jlNkIxrK3lb4lcLoqB2Yd/z9?=
 =?us-ascii?Q?CV2NKxF2FSVt7574zjMIYAqFUXYzCrkjWEQiW0HYyrPwUzWWRk2SdOeSsOrH?=
 =?us-ascii?Q?yS6wDin+LsEVIXk/EX/daGgEB2rL+VLPVzYcO8RC0WkmOvdCO42dT5oDRm71?=
 =?us-ascii?Q?5cMq+ZayfY24tgrdCpKUq6slnrO52RR7F1jZ8DO13TJ7Iul1mg2yDxH4D2NP?=
 =?us-ascii?Q?aZw+1vG86bHo/kAp1+WfhZ40/Xixa/BNdlo1?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 15:33:35.0421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d6d20-5e8d-40de-1f57-08dd88c58974
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5125
X-Proofpoint-ORIG-GUID: UjLVVQS0pbFsF5kMABN4-WoIPz4cLxv0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDExNyBTYWx0ZWRfX/YaYMVf6iijT +BoTTfXM50Rs7PjlagjesHTqx9jbPmUqSxwkTuw6Hnv7Ty3U5XBUpCTiFF5cSKNjCRZiCdKTai4 fYP9fQkKYnlatVh6eB5KRRcx4lE8QtDZe18Sz0ZL5NYBmBOVfuTcNFPxle2dKxScKxOI7diUSOa
 sqoWuW42s3tc6EppCan+exhHiG95PDorNy28aYXaIiy5+wOKwfpYDprscBnYJGx6A+eIMCtqwid oBwGDOEu7sIIxWGNI0ZW1xYAjKFqTvUd4HZ5CDtFmn+0HyJ3UC04RmqjWYSqBxRHKUkQkTvBvw9 p/V9rZ9D4aSNoX+QTF1W62Ns5CHafFzLHo8NE4u2d0s3cImHR0yKibWFhvueYgqfOy7fBN/qIWg
 bGLS0LAfjs7lbn3y0DT8BhCM6yIVZrZqrdm0v6t8SjwdeBhWS+67hEgpKm4IWo0TseTdGS/y
X-Proofpoint-GUID: UjLVVQS0pbFsF5kMABN4-WoIPz4cLxv0
X-Authority-Analysis: v=2.4 cv=CfcI5Krl c=1 sm=1 tr=0 ts=68139455 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8 a=hg09IQHefwcbD2Ic6kwA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

On Thu, May 01, 2025 at 05:02:00PM +0200, Krzysztof Kozlowski wrote:
> gpiod_get_array_optional() for spk-id GPIOs can return NULL, if they are
> missing, so do not pass the value to PTR_ERR but instead explicitly
> treat NULL as acceptable condition.  The old code was correct, but
> misleading because PTR_ERR usually is used on errors.
> 
> Reported by Smatch:
>   drivers/spi/spi-cs42l43.c:241 cs42l43_get_speaker_id_gpios() warn: passing zero to 'PTR_ERR'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

