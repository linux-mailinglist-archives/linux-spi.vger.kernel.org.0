Return-Path: <linux-spi+bounces-9064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3416AFAD4A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 09:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441BC17D199
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780BA28A1E0;
	Mon,  7 Jul 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Bruker.onmicrosoft.com header.i=@Bruker.onmicrosoft.com header.b="SrmaTv+Y";
	dkim=pass (2048-bit key) header.d=bruker.com header.i=@bruker.com header.b="NIozl2MV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx-relay06-hz2.antispameurope.com (mx-relay06-hz2.antispameurope.com [83.246.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14267287250
	for <linux-spi@vger.kernel.org>; Mon,  7 Jul 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=83.246.65.92
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873586; cv=fail; b=OQ3i6P3y34C8FAtqwmDZnjtY1UqG42EzyBcul8w8W8xQf63CStsIeUz5v7QjY6RmABtOT5cHPudkjb7ZepW0uSzGC3Gjd/j4pA26jIh/8rlngd5njULhDfDAHr64tXU+ylOo8gCvrB+dXdORTTLFc5APo0bBt6r/UUPCPigLxjw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873586; c=relaxed/simple;
	bh=E+ZVpI87qa5fzJBR7LSm1D7Dp52JItz4URXqmeXju0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPEGwhNJLA+4T2eCzGCmtApbOcdKe6JPVrWwyWiHvnfWqjkn6c+/jhaanqk21GnWm+HaEsSjwd+niF127ByOgw+2zIaSi0sJV2Jc/FwjlSuNQgSuK8qJNmiiJxgWBs12Ncd3athPaTbOJVVOE4ONa1Zqd0kMdVZn2T5xvFaJq+o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bruker.com; spf=pass smtp.mailfrom=bruker.com; dkim=pass (1024-bit key) header.d=Bruker.onmicrosoft.com header.i=@Bruker.onmicrosoft.com header.b=SrmaTv+Y; dkim=pass (2048-bit key) header.d=bruker.com header.i=@bruker.com header.b=NIozl2MV; arc=fail smtp.client-ip=83.246.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bruker.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bruker.com
ARC-Authentication-Results: i=2; mx-gate06-hz2.hornetsecurity.com 1; spf=fail
 reason=mailfrom (ip=91.229.168.76, headerfrom=bruker.com)
 smtp.mailfrom=bruker.com smtp.helo=bruexc108.brumgt.local; dkim=pass
 header.d=bruker.onmicrosoft.com header.s=selector2-bruker-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=bruker.com
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=Sn7hR5IAkLoT5L0BGiQ64n/XZOG+FPwZnnF3/oBo/wQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1751873499;
 b=kSCjJ/A1Fj61Uyrg+qepXmBt5KL/hegrHGDwuvMhEgrhbLmy2Vq8X8Z9TEgwNlVwUCasM4fu
 rJ2OykqaBibeSGEc83wr1OneVgqQd+GWkYWg9u9bUjAHKiF7LlzlHMgQIDv1znjPc1sx8ZoEgM8
 2TZ4d7a+P4Gu3Z8E/vyA4lRTtS4JTmt5X5AFbX25ClBTHUDE2019z8HZYiz2HIWEN5LQVq/1gZ8
 QxLdFtxTTB6Uf3hx74hRLzTvmrujEeL/NVL+NEko/MmBW+TN62kPiTyC+gR+jzU66trbCkADHg8
 gXCJz8A2Cq7Snr81+XKx1rHRHCEeSgQjs3xWX8AyEI/tg==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1751873499;
 b=hQNV9GR8lWXk6FOTN4VA/hCY/YVT6DPeegRhM6mkQdWMi8N084oMphda1baiX+35j6i74jY3
 jte1zKMMLtbde3xTG1rupVfmHx2Ea4xlk7F5TO4uYqhBg9yWxi/Zw9ixywpVtrfMwew7gakq5rL
 et0FaFeICDmvrHH3svTmFtQBFrswp/c0hhfDTFvs7LhWiR/nKWRiwNvMs7dhnHGIz/S6lEaL9oM
 jI9feQrmrtH7xCNmJM3wiFP4z2KkssawtrrkPrJyc7GgXagBF5KHVovrlrQXP5q0MIL3ezh+BU2
 G1QYxPbPRQqd0ZIg6bL8uUDr3fnme77ptn5dODZbMDVyA==
Received: from smtp-out.all-for-one.com ([91.229.168.76]) by mx-relay06-hz2.antispameurope.com;
 Mon, 07 Jul 2025 09:31:39 +0200
Received: from bruexc108.brumgt.local (10.251.3.84) by bruexc108.brumgt.local
 (10.251.3.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:30:38 +0200
Received: from FR6P281CU001.outbound.protection.outlook.com (10.251.3.124) by
 bruexc108.brumgt.local (10.251.3.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10 via Frontend Transport; Mon, 7 Jul 2025 09:30:38 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5ia1EASy6btja8sAhpKm77MdIaGY4uaw2PoJrzORZjWPgu7x4qzPwcXSjdghfqiYsT0s/BCDkwrc5VG6EGyYVVWhXJ/VBxHDh7AlhX6NDxOxV1BkWnEmsukK2zeIC4OERyZlkdBP3fRF0SF6c+ssEehEeQOTnAcWRKwn+R0syOsYsrIw0wQjtisCYyeQVuh40mk1kjuWrsZTC83xPWNm7ko3Wwp6zY+j3eBOQvctIr5dVHdWcdvLi5zcVjeAKMqtZPG3xOH3uyiK5iRoQUA3NrIrVvFm8vIaxsYWlUxI+96THpTzBEBnrtfaFDqdXCcC/gD5CVX3VbkhiyMz5plOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn7hR5IAkLoT5L0BGiQ64n/XZOG+FPwZnnF3/oBo/wQ=;
 b=t9xt62sd8qSka0gFGc8X+rZar/Fesz5B0ftgapy2iJTY7ehnDU2uX30Cq30SBuLnkCHVUBXSjvVQ+6+H3QY/xfyn7YmlChipOVk+xJNf+mu4yJeewbPbh3osUxN3A5pBkFiux20feoY8Wz3gp6re+TWuwieA1dHN5sun4PLvkvu2hcQQ3iCU8bbHozmafLEn6gvYtnMzBh0gh4ANP6XWIguMRc6O3xxw049XcuEvOl8yZ/fP2AOeA4mITJmw+7ZnAwGq1VPK95dBGv4sPHeplZUyMogaUZB+BDYF7XZtvkFPK6VE1Jlbg+GZccYfsBcJ2XUsrXdKt/vdEs3uuAwkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bruker.com; dmarc=pass action=none header.from=bruker.com;
 dkim=pass header.d=bruker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Bruker.onmicrosoft.com; s=selector2-Bruker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn7hR5IAkLoT5L0BGiQ64n/XZOG+FPwZnnF3/oBo/wQ=;
 b=SrmaTv+Y//HLvMjVVl7CkG9Rt6apbJOJCQoYyp4M+F4JvVkRJoVShj3DQU/X6Qyf6DXIyvJhTak4dFk6KkKpirPXL5uYN6mRcEyw/LNRrkVleaSndLOrfvDZxFEa47Tf0TrIXbHDH10Og4I+Nn8VJO+tsOLZdXg4r1r7/UOz0l4=
Received: from FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d3::6) by
 FR3PPFEF176FF63.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::1a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 07:30:30 +0000
Received: from FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d0e:acae:7d6d:f567]) by FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d0e:acae:7d6d:f567%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:30:29 +0000
From: "Hohn, Torben" <Torben.Hohn@bruker.com>
To: Mark Brown <broonie@kernel.org>
CC: "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
	"frogger@hardanger.blackshift.org" <frogger@hardanger.blackshift.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>
Subject: AW: [PATCH v2] spi: Raise limit on number of chip selects
Thread-Topic: [PATCH v2] spi: Raise limit on number of chip selects
Thread-Index: AQHb5rZPfQusim3qPkGfN64hDqfGqLQW2AgAgATR8EU=
Date: Mon, 7 Jul 2025 07:30:29 +0000
Message-ID: <FR4P281MB34343BD0D260C127866768298346A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
References: <FR4P281MB343441EB901D3DD286B923D6837AA@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
 <aF553GU_btT81_b_@finisterre.sirena.org.uk>
In-Reply-To: <aF553GU_btT81_b_@finisterre.sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Enabled=True;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_SiteId=375ce1b8-8db1-479b-a12c-06fa9d2a2eaf;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_SetDate=2025-07-07T07:30:29.2230000Z;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Name=-Bruker
 Confidential-;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_ContentBits=3;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bruker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR4P281MB3434:EE_|FR3PPFEF176FF63:EE_
x-ms-office365-filtering-correlation-id: 5914eeb3-8bfb-4921-cb8d-08ddbd28266d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?SHVMWHVSTUF3eHljUmQyUCstTWVIcXNEOWpIZnBtNFhvT2tHcFdJWDlvTncy?=
 =?utf-7?B?RElxR0s2RWNNU0tpa3l3UXltaXkwWDQ4NVJ0bjFrUFVPVCstcWxNNUtjajFN?=
 =?utf-7?B?YkdyQ3pPaUttMUtNT3RRWmhHU0xUM0RnUkM0M2phQThhVEEvUCstQ3BaS3c=?=
 =?utf-7?B?Ky1CVFY4V21QZHY1RUx3d0hLUWYvRVZ0RGU1UU9PM3VHbmkwMXIrLVNXbyst?=
 =?utf-7?B?c01KZ3E4STU5cGRuQXNpQWtHYkM3WHQ0eWlZa3dhNWNOWkJGd3dQVzlCRFVZ?=
 =?utf-7?B?eXAvbjNlTzRzZ1lPOW9USm4zR241OVIzcHlld29NL1BnV010c0VUMXFNR1h2?=
 =?utf-7?B?dUhkVFRMcystSmxMMGd5SzdhKy1ReEZwelFFZzVtZ3JwTTQ3allrS2t3b1l2?=
 =?utf-7?B?UW5ucXFRdEZFM1gxR2Z6YTBnSSstUzE1OTM2QWxPZUV2VHY5TmVUNGl6NGpz?=
 =?utf-7?B?alozREx0TWVqQ0dFalVNenhoeXZITm9oUUk5RWJDbkZpLzdydVB0OER1aVpR?=
 =?utf-7?B?OHBVZ3FZUlhBdVZ6eER4dWZsZzBSR2hmRGRGNGZBaXRVMFZXOFQ5RWhRNkJx?=
 =?utf-7?B?Zm9wOVUwd1FDd3lJRHRobTFsaDVxaGpxSDFydlRxUjlUKy1oejFLSXY5dnlY?=
 =?utf-7?B?clVhb0lUcmFSM090dnFpY2ZBMm1qTktGenN2Ym5aMmZFZUk3bnY1Smo2WWU4?=
 =?utf-7?B?L2dSSzFGUnkwV1dPWXYzSTh2c1dCbFBzalIzSlZPcVlZREcxMVBUUTExd1Fw?=
 =?utf-7?B?Z0xzT2xmalRac0F2bTlNRVZrZ2Zsa29GQzY1clBQclhuR1BZb243Vk9YVnkw?=
 =?utf-7?B?OUNnYXlJUXBlcHhTNmU3TWttaXZHU0pubExyU1BQSTJQak5idFJFbk51Ky16?=
 =?utf-7?B?N3FYYTNrMUNrTDE3RTcydWUwS2wwTjNxWVhwVll6QllVNGZjNE1CZSstYktK?=
 =?utf-7?B?aCstKy1OdncrLWp4czYvZWNXbEl0OW9zNTBsZXpnZExTdks5M0l5WEtQMU8v?=
 =?utf-7?B?dDVVeldiYlErLXlLQkJNeElrTjhscVgwM3Zab1o4WE1uekhiSnU1cE52cnkv?=
 =?utf-7?B?b3c2WVNhZGNjRlpCQVUzSDJkQXRNS2hXWG43c1JIR01nZHVmZlhkVkdBZUxU?=
 =?utf-7?B?VUJEZDUwdWltNmtRSjl5dVQya01PL3NvV09yakp2OWQ5TlQyUnhqUGlaelRu?=
 =?utf-7?B?NzBnRjNTSk1oNkIrLU56cDUyRGZlQmViRWJDb2FqUzQzbjJFOGNXT3NuQ1M3?=
 =?utf-7?B?NXhhUXN5QkxEV29DVFBNci9wZVdKZXFCWWZoWk1DZ1FXaDlubE5sSmFCbUpV?=
 =?utf-7?B?enkrLXdRNmx1cVAyU3RlRVIxOVI0MFgyU0s3Y0lGbEw2UEZGWVN3SGpCcktj?=
 =?utf-7?B?andaS2lOZWI5TUF3WngrLXVRaDhTdmVpZnVKZTdzMjBxcERZeFFaYVY0ODIw?=
 =?utf-7?B?NVh4UXdzclo2MXllTjFYNUZIZkZVdnNUR3hUejJTMGRnYmVHc1Jqb1lpYjgv?=
 =?utf-7?B?dzRLVURvbWNvWGt6VHc1dm5yL0w3VDBEREUrLUFlMDhlanIyd3EwSDlEVkJS?=
 =?utf-7?B?eGVEbnFtMUNxc2pkYkZKQzl2bEx5RUhkcGNOT3I5d0Y2VkpaMzlYdkRKSnJR?=
 =?utf-7?B?QTdmSEMxVUpteG96RUR4SE83ZFJWcGZxNmh2WlFZZXJLdE9EY1BWSTIxZURH?=
 =?utf-7?B?c1g1SDdLcmlaYTRSdFhqZFNMSzI2VkluR01naE5hckNaWE0rLVJqbThvSjB6?=
 =?utf-7?B?TjAxbzFDcm5vWVN6ZUJpRmZSVXhGaWVHdmtoaXpnVXpPRElUay9rdDZtOHlU?=
 =?utf-7?B?OVh1VjREZ2lzUG53c3pPQTcvVUZXQ3VNNmtrbWNKVDU4SnhETndhS0hnUzA1?=
 =?utf-7?B?SWhGRFJhWXFOTkdWMXd0TzhzRWV3aVYwOHl6Y2lremJ3YmhwVEtiVVlsNDNo?=
 =?utf-7?B?R3prQlhRbHppN3JaMUVmSWVGTDlsZ2Z2b05yYjRVaVdnK0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?bG1nTWg4c21lV1d3NVJsaUFwZFRYSystbTBOQnBtMlovOCstNDNBaUdWUkRu?=
 =?utf-7?B?bFNjV1BUMVBHVHJVY1JKSmdkZzlEWEY2RG1Jc0hOL0tFRFFOOUZUS3BaZVhh?=
 =?utf-7?B?YWtyOTkxV3F0Tmo1VmswZEJ3VmIrLVd4WURITDh1bHdwMURBZmFpdHR1b2F0?=
 =?utf-7?B?Q29RNystUnQvSHdLRWllbk1DM0I1ekRoNHZORVFDKy1FUlQxdWNyTTBqVVI=?=
 =?utf-7?B?bystWjZtTlhnQkpra0tWc2NuSU9DVGxyNTVTVjdicGJ4cFFlSkx0anE5OTdK?=
 =?utf-7?B?dTd3OHNVbVFzWmJQQ1VNZ0NtSFJha3JKQTBBKy13NS9KKy04MGRQc2xVaVNG?=
 =?utf-7?B?S2swVHRCN0U5Q3BBcS9uKy1Pa05NKy1BV3VyTVJ1UUxKN0tzT0dTaHI0RVNC?=
 =?utf-7?B?eGc3dExzZlVUTnRQRHJIdTdVMzczSEJoZ05wU3BPUHl3aWM4Snh4Sm1kSjRp?=
 =?utf-7?B?TjEvbnRGYlJnYlVmN1l0a21jNVdmTkVJWVlyczlwc1JpV2pndnJBekk4SXFx?=
 =?utf-7?B?emhIUHl0bHRodllSY3d6c1NBaEliZHhPVkhDRGlYd3p4bU5ZSndnUEFoTXZ1?=
 =?utf-7?B?bDFtYms0NHFCbjhzNjFZaWpoV2pRM2d6ZFVXb3paa0VPZE5Rb2N1Y1ViOW1a?=
 =?utf-7?B?czhCL3BmWTZvU1ZFWXVmeE05WkcxQ0NaSjMxbHpJa1k4d0gvZ1RXVFg1dU9H?=
 =?utf-7?B?YWs3b1F1bWFTTU9ua1crLUZaV3JHRzZpUHFlelZ3bUlvWGlFNTNlR21hVlYv?=
 =?utf-7?B?WTVZOWlCbGdiN2tqb3BuUENkY0lMd0ozRTFSRGtIb0FVWUY4N1YzNmxhSFY5?=
 =?utf-7?B?YjlYWVltaXdmczhtT3dPMVoyRFl2QldQVHNiRElxZElYa2QzdkRFKy1sTm0=?=
 =?utf-7?B?MistRE8zTWVjZjRPSFNEbUpUUVpXeVhNaDZYSnJEZFp0a0ZhM1V0emczQ2Fh?=
 =?utf-7?B?WURGalF2N3pXYXlBT1hIa2NjbHJqYU1Fb0VKZ2YyTDVRSTUwUDV5TmxxZ0dj?=
 =?utf-7?B?T3BDMmtxYmRVUElPaFZaaDhYdkFoMjBwNWFQZHEyMWo4dlpHVTlBdFk3MnhU?=
 =?utf-7?B?YnNmRlZyS2RRc0wrLUdPdnpuWkQxZUFyUHF2ZHl1TklKZC9BY2dEWjVLNWZV?=
 =?utf-7?B?QzNPZUxkeEQ4NVdhODc3enBxeVJQbEg1ZnVUWEQ0dTJyZDdhdkgyL1htbVNG?=
 =?utf-7?B?bFc0L2p6NHdOUWxmMjhWNUpCbC8vckIrLTM2YU5ISzdVMWxVdFFHMFd0ajJL?=
 =?utf-7?B?S2ZNTzYwR05RN01JMm9saS9EdVpPMHVPYUw1RFJBVE5ieFQzYWpNVHhxemt0?=
 =?utf-7?B?V25Tclc0YURtWmZMeDZ6ekg3SWwzSHNpaWdScHNrejR5aTM5c2lPTjgwTTdE?=
 =?utf-7?B?YzlJeTVMTWFUczE0WFZYUXV3em5PMnVWU2I4UWxnYktuTDlNUjBIazdFbWVP?=
 =?utf-7?B?WE1Ma0xSamJZcDRLb2hPMi9yMm1GSE4ydXJLd1VKRURlbUhqOTBnbVJGS2d1?=
 =?utf-7?B?M2N1cllTSmFXM0dINXFRcWh6Vlh5N1NpSy9RNUtaemM4YSstVlFhNkdNT0Qv?=
 =?utf-7?B?b3ZqYmFYVmlKY0JGOHN4b0ZFM3l4UFY2NzAzRDZHazZCWU8wN0g2Si9wZ2Uy?=
 =?utf-7?B?MEEwdjV6RnU4WFlTdTUrLTJxQzY4a080MGhSU1ZYVXFqTW90SzNJVCstU2Q4?=
 =?utf-7?B?djZkUm03bGJjY1g4MXRWeVZyOUl4VzRQeWVEbm94VHV1ZUlGcFFwU1FsaUhX?=
 =?utf-7?B?TjhSY0NrdVVneWc1VGh2TGlMeEpUZXdtSjhvdkZWbTJSTlVyR3QyelB3QWtE?=
 =?utf-7?B?eC9Fbk9QYmFuRVdvanZwcmo3dURzU3RaZHhGUC9GWS9BeWQweWY1cFUzYUVK?=
 =?utf-7?B?c2JDcmZGWnZOdHVGVEh6S214YU4yVVdwanlMdll6MFkrLUc5WE5YM1VGUlMv?=
 =?utf-7?B?WDVFNG1jKy1WcFlhRHNLYTg5Y1ZYbU4rLSstYldXMnF3a0JYUVIxYzQ1bHBr?=
 =?utf-7?B?aGlwRC9LWVl3VS9XV0NaQk8vdjNRYldIMUhESFMzQ3pjL0tWR2V1bistL2d3?=
 =?utf-7?B?ZnJMeXM5aU1HUG1vODFUKy02TTMyRXNuNm51Y05NNVRUdHRUN0VPQm53eXA=?=
 =?utf-7?B?Ky1IMk5zUkpwb0tvYlA2MEE2bldJUXdNWHk3bE9FaUFkcDFhcnU1NkhLY0pk?=
 =?utf-7?B?cUU3NFN4Y1c=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914eeb3-8bfb-4921-cb8d-08ddbd28266d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 07:30:29.7154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 375ce1b8-8db1-479b-a12c-06fa9d2a2eaf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ztet97MxPteoYHcO4lfJz1PTWUcAqEUEgQu2akDPIWtWzkJJAnKDcVT7iMZXNe5itDk+7HV+SMlXQ3rjW3D8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFEF176FF63
X-OriginatorOrg: bruker.com
X-cloud-security-sender:torben.hohn@bruker.com
X-cloud-security-recipient:linux-spi@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay06-hz2.antispameurope.com with 4bbGBh4qljznlLB
X-cloud-security-connect: smtp-out.all-for-one.com[91.229.168.76], TLS=1, IP=91.229.168.76
X-cloud-security-Digest:994187259b4a24605fb67b77ea2b7b5b
X-cloud-security:scantime:2.276
DKIM-Signature: a=rsa-sha256;
 bh=Sn7hR5IAkLoT5L0BGiQ64n/XZOG+FPwZnnF3/oBo/wQ=; c=relaxed/relaxed;
 d=bruker.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1751873499; v=1;
 b=NIozl2MVZw2sbGpIx5cRoc742Z2Zidnrc7jjFVwCfjuHZmcoHs0j3yzEI3zQfph4LlN8S+uA
 8MPSxRE2JLfcxokiSuuhn5XVBCzS1kaGE5FGShb9wD9WH7X436J1XnIhRnp4gKPeSCezcaJ+1pv
 uObnc+fUnVLY2kqQFe9eq6luSU8egEPpRg9mwhFGJyU4pXWqRR76BZTyZQiSc4wlWBgwyPgEyy8
 YlqI3cZ0WEgTl/Sz9yfnhP/MuyG/a6tK67MvExUcLi+ekp/O3zdp7aahdN/vNF/eg+snhCyYWxU
 xX3BEkSZCXQWVXNeMB7CSmakTkBw/Xifd26Z6D/adluTQ==

Hello Mark,


-Bruker Confidential-
+AD4- On Thu, Jun 26, 2025 at 04:58:20PM +-0000, Hohn, Torben wrote:
+AD4- +AD4- Hello Marc,
+AD4-
+AD4- That isn't my name...

Sorry for that. I was also communicating with Marc Kleine-Budde and got con=
fused.

+AD4-
+AD4- +AD4- +-+ACM-define SPI+AF8-CS+AF8-CNT+AF8-MAX 16
+AD4-
+AD4- +AD4- If this is increased to 24 now, we need to carry another patch =
on top of mainline again once we add another Chipselect
+AD4- +AD4- into our FPGA, or into the next iteration of our hardware. We w=
ould really prefer that a Kconfig value is used.
+AD4- +AD4- We have handed a patch to pengutronix, because they can send pr=
oper emails.

+AD4- +AD4- In the IIO framework there is a Konfig Value for something simi=
lar:
+AD4- +AD4- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/include/linux/iio/trigger.h+ACM-n74
+AD4-
+AD4- This doesn't really work, we're supposed to support single kernel ima=
ge
+AD4- so putting per platform configuration in Kconfig ends up being at bes=
t a
+AD4- usability problem.  At some point it's better to just bite the bullet
+AD4- and make things dynamic.

After looking a bit more throughly at the code, i dont think it is necessar=
y to make this dynamic.
The Value at hand is actually the number of Chipselects a Device might have=
 and not the the maximum number
of Chipselects a Controller might have.

However, the check that is failing is this one:

if (ctlr-+AD4-num+AF8-chipselect +AD4- SPI+AF8-CS+AF8-CNT+AF8-MAX) +AHs-
                dev+AF8-err(+ACY-ctlr-+AD4-dev, +ACI-No. of CS is more than=
 max. no. of supported CS+AFw-n+ACI-)+ADs-
                return -EINVAL+ADs-
+AH0-

I do now believe, that the proper fix is to remove this check, and then red=
uce SPI+AF8-CS+AF8-CNT+AF8-MAX to 4 again.
Because it was increased to 16 only to satify this condition here. The code=
 however does not depend on ctrl-+AD4-num+AF8-chipselects being smaller
than SPI+AF8-CS+AF8-CNT+AF8-MAX. The only occurence of this in struct spi+A=
F8-controller is the last+AF8-cs stuff, which just requires array sizes of =
the maximum
number a device might have.

I guess the define should get a better name that makes this relationship mo=
re clear. like SPI+AF8-CS+AF8-CNT+AF8-MAX+AF8-PER+AF8-DEV or something ?
We have discovered the b4 web submit and are now able to post proper patche=
s. Will do that once we have tested this here.

Regards,
Torben




