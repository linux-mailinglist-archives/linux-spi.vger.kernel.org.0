Return-Path: <linux-spi+bounces-8645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8660ADF045
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459567A51F2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B42EE96F;
	Wed, 18 Jun 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HCoK/Srl"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011031.outbound.protection.outlook.com [52.103.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7F3B1AB;
	Wed, 18 Jun 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258449; cv=fail; b=UL60D7vh8NrKDYOYNCSmu/9xKfjVMJXj+RNqwqYL/y7jcQ6xFoSZUOK8JRPXd48blMdjEZOs8Kn48BAmleLpqc8+ApYCnPvo89CJtp2goMvPJzwcO3ZOXDU5EfEFsrDvGVkGC3KQ6Uy0xCI1EgaZk8UzUxcskXvyEutqSoMdef4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258449; c=relaxed/simple;
	bh=ZwcPF4VMSO1+DjKK7anvl807rMuSltZZUaujnp6/Qdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C16YwPiqp+L4PoI2BzKiyy74QHMCcStkHT+H3CLbSBloG9WQHi2ax62LCUygajQhSEPNCbweUvbzT1vIf8aKaM1jknf7pw6S5ZsErhdFAr9sxlCVdgapWB4polFKVubI8m5gwaTKAOvUTQN+ny15Rijwj2zDQleEvR6IylPwk5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HCoK/Srl; arc=fail smtp.client-ip=52.103.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILSfqx/tL+Zqd9AtjfE+9gWFrWte0mC8zUGdGTBSvWucdsekJ43hZ5lr/Bjgw+2nMljFGF68rCtSS+mrtTV1lkNUTNUGmkz244j0byX2rJ1in9TUowxb3+Q6OFD/EcCIokyXGEH9eQ0mvrQV4eAIaDRthRL39lsX5QweZ2uXQ4iM2PGp0lpjUHrqOxL0Ttj56O/ePLEBYw3rj+jH8B8O9/Z6F8PyZziv+S/Cd+wcumXT9WsxGOBvVCLpSaLK/PWWfO5qAV19FO/X5nUnThaX0MZbWb1pz1CRpJ7gVzI6u4dmkXieNWwmayNtf1aKyD7NjD2tfaWGaGNbzUFppFrOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SndJ3D//UXzzISkLSycnMdjy0DbpJGqs6fVzFUFPbw=;
 b=oUVIl/uNNh3Cg5uGAUeHQLA4hBfggVVzW2hECAh1LvGdt95Kdn7yf30v5+c9Lu5ngy3DWvNW5OvaMJl+LHPr0SnCdO8YuvYc9jsHRKsonLbQXmumzJTG+++Ud/E7n4YDupPlYkZC48a/78wkNng4bfjtBojVUIGPR4aMB5NJOLibO9fbge5XCkbLaI+rUFaGf8N5J2PJw72217UlG4k6RT4+nAv6MTd/qoK7h+JDWLTCX6IwWQoxa2VqJCanSPJJHtuKWUYMjLn5Ec0clhHGCM5lhTy5xnNDNfJtt7f8cxrp8GuOJRkrm2o160OH/AdNnRv5kUG3KRE9UAMpAYa3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SndJ3D//UXzzISkLSycnMdjy0DbpJGqs6fVzFUFPbw=;
 b=HCoK/SrlyxHfNn0Xd9MxFwMfFplHfyvJ6zRWvDX6c1n3fFAxS4B0t0+e0nsFoDtGFFMno1I7aAZfsiANea8zN0F/L0mytIYsX5PmSDMJKB3N0UhXDFaPZHfNQacIh6OPhhCgEcjdw+xrgjdy231Xo8LRkLik8zdbDPZSlueJgT6cfaQ1fzFAkjnz2Xdr9QILC3pcYOH0ka0Ytc1weGG9/S8vkLymmK0Il/dCnEm1hijy0XH+cTeJRqoR2yN3rQ9K6X+h7W6MNd1owTAxQpMIKUfLKNIH2+E2icD8PK/BSityRQE57qLvjZFcaNe0gOxxFbi6gwRai36upWgvdbpOmw==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:04 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:04 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 02/16] MIPS: lantiq: xway: mark dma_init() as static
Date: Wed, 18 Jun 2025 22:53:15 +0800
Message-ID:
 <OSBPR01MB1670BA742E713D60C54C1EE6BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-3-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 51697192-c15a-42a3-80ba-08ddae77f7e5
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXddCYXUi1i6D2szTHGIEFTmfA8rbNXRpZvkos/ouVM1jEai4URVSbni0Ryd3hfX9UQ5nVxPsIXnzt37bGJHuhNUe+XOHMl6ZkNSubw17w1o422R7iJQE5NDgWbSS0xWHUyJz2LuQ95iWD3TAw7APzRQis02Bb30iBW8JqBa1O60gUnaHsOnD5BEKHWU4XEYougZLy+QEa5yENA9mbGIbVvd1T/qWio8k9tJRqUxmGKVUAROinkdoNRMxdS+IlAgSWcqjmgFgwdT1SZvjsDT3ASOzRfe2XfJ9IrfnoamuwOkVMhpG0RvO64eZyO9C7kCPnRkxPgdM4LNpnX1TnnrhRbBwbvbBXBeDzkv9FoH6Sm/eBG4xyhF6wTCI7ahho7Q8UVnRprDRkNUmrEXGkUVbFn5lb4KJ1J/a+qN93l7LghE4Y1idc8Es3w0DN5MwY75JrvlYACuGOAN87bQTJwwnCdQ16ThWZ1z1uJElnbpBcmCp0xI1FG0O9a9jb4Aq1UO83oBw0fhGZhsWMCz0V1gMxoKKTgMgpI1JehCzYiK4+vjCWNtKgp/I3oN1j+Z5JLEoYZ3VWlWGP+l6+ILWIdQvAnVK/vEAn1Mh3DYXAt7kOsQDwarUTj4fskMOSGH6e28aCkQCtGGc9UnCl643DZIcbu9fs70PdXD8VeXNZbjANPHHRcVH1hNz4Z032CkeNyQJLPs+EMknQ27hhtJcTerS3HLVSTs1NqmSKdQ0yibl6t2fs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eHg1BpIXUk0FQ1/l+KzCMXRvaTBLIhJIrPMqAMmV2dtwbnjdNczveu4B/AHc?=
 =?us-ascii?Q?YCnPGiGsH4X/VqfO5Zz0dGAFcLtHtrP4PdjQQce2hF3QuBjjxN9eP4LNtMsD?=
 =?us-ascii?Q?axsF67c6sNLX9I9TtSkvKZ9dln7FYz/3mi4PBKGJ+vxMsp0tHOmga/MyPqVU?=
 =?us-ascii?Q?MLLBiqbNAivnyo7kDLiO+GMNThzC/YNkTp2LvlD2ljXeD/cze6XLcBTqhxAB?=
 =?us-ascii?Q?VtfiDuDevrvHZkAFSPnYAZq3M7vfnVeo2hbRDUQq3ltuaSlix3hdHUJiwQSS?=
 =?us-ascii?Q?bBgDpdy9c2NxLKdvqQZtIAD8VydxchhmR5QlaCdwqDVSznsPzyeqBMI0G/9E?=
 =?us-ascii?Q?gYQV3T1U/xYfa6C6Q3fAzQUjr5T8fMGOi2xCeDnvVJ2Qr0uIGFslFQtMU5S9?=
 =?us-ascii?Q?oCqKmXD83m++np3lsK8OxNXPB3wD/CaSJmo0P+obXkmZupKQC+4vVGc6/GpD?=
 =?us-ascii?Q?8l8i6R6V94W4VfL2oKlxwcubgy+ifoWZyXbXu5dqgkWnWu0AsqXNYkma71N1?=
 =?us-ascii?Q?Oe/xRRlx7ASuoifGhhJWI0AZTjd1t1FqI3WjuSMrZopbfQWfTnEnK4Z10PMI?=
 =?us-ascii?Q?tRi5gq4A7o65Mcnk7iISpK1mR6VHY8HcSwvLz1CfPHxp9jQMyH3BAOfo6d1O?=
 =?us-ascii?Q?wkM78tk8rsQiHHiQXS3uOvQBJbNTzqOejpFRns0LkfAVJNd8zOCzEOXETB7D?=
 =?us-ascii?Q?4UPNXUq4Cn2zTS/+0mpOuZBHL9ItYv6xtCoTc4PCAiCiPUvuiTMzxf9tbU9s?=
 =?us-ascii?Q?r9hRt8t/oqZv8P+NVlhDJkadU5cSZ9BPVekhXv7QOewOfuhhlK5bfxV0QiBh?=
 =?us-ascii?Q?R2MW5kD7UjA3t2AyhldKeBnxdqyz2WsEz1V/skbwXwlqonX9Q5R4T13Gh5Tn?=
 =?us-ascii?Q?Yhkd6mNLWc6Q90eWp7AEO8aXEbXfwcgRAXCgNibh7S01a2DtyDFwbo06VwGx?=
 =?us-ascii?Q?j6ahgoiX+opu9P6pDDWxn62cazN7RevX5I258hTBaGoKtopv9Z/WgL7bJx2H?=
 =?us-ascii?Q?uEPTcYdFKy8tvKxA3mlNzhCq9FSmJM5EPokS3U0U8MIrhXBQUvcQLJyE5szd?=
 =?us-ascii?Q?kM/MFUGmDe5KmhnbNLSn2ofl7yvCYtAJfC6Nh29nt7kOrDLf4oz99SM5Pgns?=
 =?us-ascii?Q?/0XOhGPBwg2zM+FaqW6HT2D7d23BAujBqXNgB7Z5Tfj9vxvznzpgTr9a9LfR?=
 =?us-ascii?Q?SWxTMvSr/R+JO/UHfCENV6fvK+ZWUSBJc4wMB178xzYzbirBKcvFZ6RkAxU?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DabnP0vye8scGqKWrqk8/aSx7TCXecfe/YEHeQlCIgqHqjSEoISDSJtbbx9e?=
 =?us-ascii?Q?rYHr8N4XjbE3ZkLc8rQ2HcAl7uSsu30A8DRuYVPj+GoWBNrRuY77GplDJDk9?=
 =?us-ascii?Q?aiT6gKBHM0VUWL1pMaYtcdqDVt7slxCqWOKWb4ZWBZjAN6eTwj/6Dr6YEbET?=
 =?us-ascii?Q?c+3N50X9v/9AT8ihVPVu8fp+jY8QAWOSx0I/z7D4k7XWc2h5Phw8h5d0NfNM?=
 =?us-ascii?Q?ALC92YSpHbrtjZX3xslFwlL1Lvc4Kow047dVFuezJWUiWD+XARyBYtZqOJGA?=
 =?us-ascii?Q?4ZCvgdzzuN78DgpqAgmZFd8gZUFbXwmlZFDhPOg2Hi7eXy8tYVoDGRcZrjzY?=
 =?us-ascii?Q?lot3lmpGBHXVOXbV3Xk8mVOliI+mb66eqMoTpPtNsi2ykLsobdML0JBmQ3fY?=
 =?us-ascii?Q?oZ33jurdRVmTcm2TA79+0SESVfpVu7vmLWESX2KhcT3Y4Jrqr79kmArvhDBD?=
 =?us-ascii?Q?2IgMu/IEDX22KnPGvnlvxn41ZIAuumPwOsD4cmqV/cwsqWyAieDzwADcQtAX?=
 =?us-ascii?Q?dylX78POt0JLhCaaXGC7rDJSjGTJ0c3xiQxNRMuxbEKlQYFzCdWtNeF0hV0V?=
 =?us-ascii?Q?teAqyw1C9XpQtNbsbljrxbDpUYLSFKLF9DvKd1FtPH9IitkpaVl9t9A42pXw?=
 =?us-ascii?Q?dyzMN4WN2iyp3gtIett1J98FPM5h8njRFI52dSK3RwkYPEbz/DuKovDe2s4C?=
 =?us-ascii?Q?mizzvftZSwX9q73Qfkz/LVCdoYzpGD7+pLKgHcA1UOV93YpRuOqH1K7rXjWJ?=
 =?us-ascii?Q?vF+kYM7a0bw6sYPh+pnOwJYvGOqN5N/BPmCVrMM7Aa7E4ShrMMw1onJFwrd9?=
 =?us-ascii?Q?acoLLw+XJRysYTTYJ4BjOuB5hyT2vv5Eh7HmiJSHIhysWKW3e7SolPsW6qT0?=
 =?us-ascii?Q?HOBjwDN7cKDTTgrQimWRS4amqmDxiNwpi6WBl0jlpXCqtQUKH/yRr48yqVb1?=
 =?us-ascii?Q?IRDbFlbqEK8ncbSeG/lJQw+ZhyPutAMSbovcUV40D2GxNSbMhk0XbgHyFs6X?=
 =?us-ascii?Q?k/404VYDo765I+1M6R4S0SODS0Uwb/WZagYs59TnHOuXgq5hGXWNUPaoYUiT?=
 =?us-ascii?Q?MErODYTWnX5zwkIfRsu6gsT44HTzQEi/PH4uez7a7NMxSR6bg74BhaQzy/Op?=
 =?us-ascii?Q?gRPSeGZNpfhbOF3sXL023HHxREZd+HoG69kjKeahKhcOwv12Wg3e+P7J1/ku?=
 =?us-ascii?Q?XyA1LZ6CpSBlTvp+qEkkgBDA+VsIydJTIaADcaQ18phLq+patU4AFXKTsDsh?=
 =?us-ascii?Q?8eo4zi0K1ALLsbCckawy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51697192-c15a-42a3-80ba-08ddae77f7e5
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:04.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes build warning:

arch/mips/lantiq/xway/dma.c:293:1: error: no previous prototype for 'dma_init' [-Werror=missing-prototypes]
  293 | dma_init(void)
      | ^~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/xway/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 934ac7293..4693eba6c 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -289,7 +289,7 @@ static struct platform_driver dma_driver = {
 	},
 };
 
-int __init
+static int __init
 dma_init(void)
 {
 	return platform_driver_register(&dma_driver);
-- 
2.50.0


