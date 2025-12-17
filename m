Return-Path: <linux-spi+bounces-11979-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1ACCC6952
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 09:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99D57300F1A2
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42921772A;
	Wed, 17 Dec 2025 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="d0t8IyFw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FE331232
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959706; cv=fail; b=NWKr5glh+8iTnwYqXV/A1Yii0l7dgSW7u58ZaB/HV8UOPeFL9F/gatKTZ1Ffmv/4hmLfCvVTgPHtjr47os7oLhAr/PoS7A/qzvMl2slRdfp8fIiTJRhNgvwAEc/lSS3JMSVpg/0vLXIDU6ncOwSTCJQUnD3YOe3smn3Q59eSfVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959706; c=relaxed/simple;
	bh=Lr4x0EKAZlb0HhSqmnxUBFOCjrtLsGJz33BdFljDYHQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o3F+y59598czOyMgx5SSO24wmAwxxBr1tTaHogIWLQqhdNhslW+ZICtvm2Tr7KGYfFs5KgVIFFkOtPlv1V3Re1H9b6DAUOGgrQdwA79qUKcNAeZskVXp81p9ntzZqEo8DwwQRlfvDTHspoOKTMHrT4o6mJ/ihcPFXfCDwZ/LV4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=d0t8IyFw; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH2nadx1335044;
	Wed, 17 Dec 2025 00:21:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=pKorRwOmU
	oaRGvlewNj/I8UJCk3T+87o42ikNV8dbBg=; b=d0t8IyFwHnikKb/RrRME6GlX/
	5lf0KGW2/kAgSL/ZHvfcYZOT9IlsWblqssHolFuKaOYjt3raGLSuGdh4vL0LTRjh
	9g356CWm7KeTCulVuvdWA5EM92F5AXHgusnIrELvx+85ZzH+3EMh0LamqohYTUb9
	Etr2VS/jBhuQEAJw7qwMDDr7vKjlxQdQkq8idGjuD5ap03KxvUe1rQfm85Fek/TB
	XRsxIc0ReQAO0owowE3nAhYRaQhHcCqBZL7GeOWliOSv9y7HMwYXKSTg4voWxnha
	L8mc8qTUCDY79kHQEvTUYXaXW2QpD1eLB0FzYC2QYFytLP4u/aaNVZ7sKepbQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b3k0sg9xh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 00:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJHkLUUppDLDEZXNnM3sjbq9NYzvnmdw5iwpsD7o8EsYAYAzQWmtdSeLyhZ1tpL8XrKeXR8cUrbV/wyoaGXSuYtG4BD3C2/kje9zmEPJksnfYRaCqsCZUiNFvcNely2agY4CfSSE0a8WN7yflWrDSvxNOiZ/Upfnd4zucBl1nkQ9lT1Uh5ja4xXVnqhHZ3om2oiMqIBGisV5QB4WWJYQdsLRyT3K0cJGzaRUWeik35iMX0Y498HfW7GA2a5mbMSEZDcrV3TCr2yXXplGK81wtZrS3XKgx0GtPKTwR2DOv39U5I3pcq+iFmMa/+SZJK2FkjkW76P3zBWc6jenFtFj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKorRwOmUoaRGvlewNj/I8UJCk3T+87o42ikNV8dbBg=;
 b=nNLeK73qTBBZcOfjHmUEkLbvDjoCd31sF2b/SEDbRmsxUFLIqNeQ3ufJD3EC157I+cU9qAvo4u49G8uvnfyNVJtEt2sfaBVGux7F7pCPIPp7fC+BOLOtZ62Y53yjVYEvImmVdgIbTt8/HyhMWvUG+38eB9AMcg9EEj8aLKcEAzRB0uSDDR2iSrciVkCaR0Lfs3W+WBlAR+kSKQC43bMERGCygaFcxFfuTxs6455JtsTPJ4GzcWbS6Gwz8jU1AOEZcnLi7fPlgZpkB2IWHnXPbFPl76CPQAjNoauH0ypBbDByYll+BpsaYVRhJ70tz8rYOfNbHMuC1/DMOI5v7/f9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by DS4PPF30373102B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:21:19 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%2]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 08:21:19 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>,
        "nm@ti.com" <nm@ti.com>, "afd@ti.com"
	<afd@ti.com>
Subject: [BUG][RT][ti-j72xx] spi: cadence-quadspi: boot failed with rtmutex
 deadlock detected
Thread-Topic: [BUG][RT][ti-j72xx] spi: cadence-quadspi: boot failed with
 rtmutex deadlock detected
Thread-Index: AQHcbywVGeetnNAIikOHtlMLiI+Qsw==
Date: Wed, 17 Dec 2025 08:21:19 +0000
Message-ID:
 <CO6PR11MB558695EFB87C578370014430CDABA@CO6PR11MB5586.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-12-17T08:21:18.733Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|DS4PPF30373102B:EE_
x-ms-office365-filtering-correlation-id: b1c42389-c425-44dd-fbb9-08de3d454146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?SFhFN0NsTE93MXk3ZitBOFNSWXZWejVydFR1VFNBK2RSOEpaWWU4ZDRW?=
 =?iso-2022-jp?B?YmJEc254OTJFTCtzYlpmVWNKMUx6dWU5WGpqUFBLTENMb1B4R21iaHRw?=
 =?iso-2022-jp?B?Y3F5M0p6blZpQWROZHJ4UEd4c3AvUnFkek03SmMwcTB5MENwRFF4Wmpn?=
 =?iso-2022-jp?B?N09YdkhQUlBWanJOTE50R0xza2tCMDV6UmFySEJyQjNoZjN1WFAzeVlY?=
 =?iso-2022-jp?B?dkNXR29URkVvL21Rekh4YU02bHRtRFZPL2VSVi9iZ3EyOUpvUUxDeERZ?=
 =?iso-2022-jp?B?bmRaVkppVTNqNHUrcG1tRStuSFgrV3V6S2FPSjdrZWVvL1Y5OGQ4c2l1?=
 =?iso-2022-jp?B?L2xSdDlxdXA2b3hpVHpjYjFHT2hTQ2sxdnpOVUlxcUNoMFhOYkdYWkEx?=
 =?iso-2022-jp?B?TVR5d2RuRDlnUjJtSndtRWRJVzdtNjRtSDRRdlFBNE9OeDJXTVFkWHhG?=
 =?iso-2022-jp?B?K3FWUmFRZUFxSWRHcXQzeXFCekdYbzAwNGw3Z29NV1BiKzRtSFFQR2pJ?=
 =?iso-2022-jp?B?VktnM2srMFZ0elNpQlFlMlRZbHRKNUxjaFhkWHViY1ZWb3dOVDRzY0lv?=
 =?iso-2022-jp?B?eGo3UmdwZ2E3TGhSUkkvWjQ4NzljR3ZSUnkvRWN4SUlheUppa0wvUG90?=
 =?iso-2022-jp?B?MmRjcTcxS2JjbUZsT2cxNmNNOXViOHF0MGJ4RHlBR01vVkphMzEvenIx?=
 =?iso-2022-jp?B?WmJiSFdEOVZHWXlXdVFNTmlSbjZiRi8xTFVhaXNrL3U2MDNoeTVCWlcw?=
 =?iso-2022-jp?B?T2NLWjJrN0RjL0d6YTJZaktValRMcVRVTXpCTHJMVWNIMWtOdnhLTkZC?=
 =?iso-2022-jp?B?OE9tcFBvN1ZiU1d5R3lWUVcwTHl4dVErQVlqU0RlWFFvRVVPdFBYbjhh?=
 =?iso-2022-jp?B?VlRSRksycFZqak92K0MxbkVoVEk4OWMyb0dGZkVuQnhtWnZ5blU0L2pM?=
 =?iso-2022-jp?B?ZGN2WGI5Qks3Y1IyUWpRcytiSGh5NlZwME83SGx3Yy93UHJwL3FFdk96?=
 =?iso-2022-jp?B?S3pPNnQwTm82YlJYVE0yTFY3N0NPb1ljU1UrLzlBMVo2VHhZbzhCRE1a?=
 =?iso-2022-jp?B?Q2xhS1ZOR0JsYnJrSHhlNmtXaVRObVBacVBsYVMyR25yOEdVSHFubk1S?=
 =?iso-2022-jp?B?SmRCN2JobjJuNXM4Ti9Sa2xKYTEyYWE2WUdpV1MrT0VReFpRMEZlbDR2?=
 =?iso-2022-jp?B?VVJ4S1ZvS0plU2JjdC9sZ0Vtd2MzL1VqZmozdGs2RWJpVXhoemZRV0lK?=
 =?iso-2022-jp?B?QlZuVDhxeFFFUFppWEpFbnNEWkUwTC9pbk5SRG1rMVF4WUUrUHIrRXVE?=
 =?iso-2022-jp?B?VFRTclFqMFFiNTZueTZnb3RsTEpRWC8yTCtRUU4wc3NDT2NhSVY4UnJX?=
 =?iso-2022-jp?B?SW02dTZoUW9LNWpLRDdjOFRlV0ZLaGl0V2V6TWJkWDh6K0ZZdWY0VHps?=
 =?iso-2022-jp?B?TXdua1VEbk9MRjRJSlRjbi9TcHZKdUliM1JpaG1yc2Y3R0NRRTNPMWFy?=
 =?iso-2022-jp?B?V21zSDY3U29Mc0xqcnlpNERESGd5SXVkc0Jya01EMWN6d1E3cFI5SFhl?=
 =?iso-2022-jp?B?OVBDMDRaY1I1bVMvdHNLRGYxSnF3Y01xSGwxczFoSzZybHZ2ZHNxa0VI?=
 =?iso-2022-jp?B?TkFINTRRRk91bXRIeWs4QlNuRjRSMGdCOEV6VEVRMml5ZDJOMk1tS2lH?=
 =?iso-2022-jp?B?WlJ1Nm54NFZjRk5WWnpMS1VETDZJeHJKNTIwd20vR0t2eGNrOU9Nb21R?=
 =?iso-2022-jp?B?Z3RPT0krM1J1Y3ZOVWlEeUJsKzB5YWpwdCsrSHlPVTFKWThWU05QK1Uz?=
 =?iso-2022-jp?B?dUU5NkRIL3NEend4bmI0MitaQThrNmUyQTFpaXY2dGFUSFFJWmRDZEFF?=
 =?iso-2022-jp?B?MURMQ21LZHFxcjNuT1FSanA4clBDVlRZeEtFMVpSWEdKcUlNS0JSWmhX?=
 =?iso-2022-jp?B?cjV1REllRXFKQzBBVE1TeGh3RkQySjVLbTJQYnJ1ZWpxY1FtNmpKcW5H?=
 =?iso-2022-jp?B?M1dXNnl1ek93a2RsN3JURTkzb0FYNW5WVll3NW1ocDdyOENoY1NtSUNL?=
 =?iso-2022-jp?B?b0dmMGV5R3lueE5vYTJXT00rYVdxbWF0Um5Ra2tjVHBNdDhMVmdvYTZn?=
 =?iso-2022-jp?B?UzdTdTNLZmlZcXlDMmpmT1NqclpwTm5KVFBSYyt2UkJtcFN3WUZ1cmJU?=
 =?iso-2022-jp?B?bkpRck9FNlVvblR6Mm9rbStvbDM1VDVJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZFNkS2lHSjdveGVyYitNRGdKb056L3Q4b0VQTTFuMmMxOTNZWG8xYlcx?=
 =?iso-2022-jp?B?bmQ2WTNqSWNFTXRqdTJZZWNlT1M1Ulozb1RFSmJFdlNleENSNEtjWjJp?=
 =?iso-2022-jp?B?aHlsZ3JDSERGc0ZnMDJKN0dIY2dPS2FZTU8reFlvM3orMEx1ZTg1dEZO?=
 =?iso-2022-jp?B?cVNxaFFRVWlmbUFvOTkvbklhQ1IydUg1aCtVT1E3c3d5bG5yc3llZlFp?=
 =?iso-2022-jp?B?aGxuRitpMHdkeGUwcXdnMWo2SHM0dkRpY2JQUDJ6MzlBRStFMCsxbEJL?=
 =?iso-2022-jp?B?bS81SHlGUUswOEIzK1kvNmhYKzZwODgrMmp5amxEbk1jenYwRkJBZGgx?=
 =?iso-2022-jp?B?a2RZWWFmcTRpdjE3YmRSRVF6SStiUTd0bTJkSEcyYktqRDhiWDV1THp6?=
 =?iso-2022-jp?B?RGNuQk9BRHNqNEZvK0M4ZHF2T0pDWnoxWitVZ281Tmk4OS9aMXI0WmFI?=
 =?iso-2022-jp?B?R01sZnh6djVZYi9ZQU90U2M0RGkybjRkZGxhWUpKUlpTZ2pVQ3dzZWYx?=
 =?iso-2022-jp?B?MFJwTjRpSCswU0ROM0p2QXB5dXJZZ01EODUvbDVyMUx3RUlFOHdaTGhD?=
 =?iso-2022-jp?B?V05ydCtTK0UwMnhjVlRrUXhaQ25GaFdEb29RclNqYVY1TThjZ1VmNnl0?=
 =?iso-2022-jp?B?NGdlUTMrL01yNFR6ZlpLaS9TaFlJVUlYdy9nblQzRFllU1RkZDBhTmpK?=
 =?iso-2022-jp?B?T1QrS2lSTjZPKzZXV0gvOWtERmJXeGYzOEhyamk4UzhkeWFzeWRvUlkx?=
 =?iso-2022-jp?B?MWZSNEZJZytMR0N0eTRJZWpxVE80WVZYZGNxR1Rwd3ZjM0tONzVPbmlI?=
 =?iso-2022-jp?B?Z2Jkc1JURldIZGw2RXY2Z1BITWxwV0k5cFpKRVdBWGloRXlhbUd6d1dP?=
 =?iso-2022-jp?B?T2VGaElKVnhvMWs1NFhyTkZrRURPbUUvZGR4QjRXU0FKam5kZkhKMitK?=
 =?iso-2022-jp?B?Tkg5ZEFXNmZiWitQVnk1OXFDZHBwSFY3ZUhYZ0dNQTg2T21VTnVOWGs0?=
 =?iso-2022-jp?B?RERDVDM3TDlVK3Z1KzBBbEc2aDQycS9wS2JVazNpcG1EN3ZiRUc0Q253?=
 =?iso-2022-jp?B?ZlhhN0tGeHhWNmlZTFdVZlc2YkZPQVZPZlVWOTJTMlNiZ1B2ZzM1eEs3?=
 =?iso-2022-jp?B?ZGRsMnFFVnBBam9Yd3lWU3ExQmNhdXIwdG5JV0VoR1ZJOUVGblZoS1cv?=
 =?iso-2022-jp?B?VWpFa1ZucU1zTlRucm5sTFZmNmxQTW1IamNZV2NhQUF5bWMwNUlzU2xY?=
 =?iso-2022-jp?B?QkliODlxME4vWWVleW5qc1dNWWE5dWsrbnN5ejhReVJQLzJWbXBFeGtp?=
 =?iso-2022-jp?B?SVRkTHVzVXQvZmlNdy9ncGRQWjBRUndFVjFMazFpeEpIcWFtcmxUZUpl?=
 =?iso-2022-jp?B?cWNMVTVMVXJibGp5TXpWR0VlRjY3YzVwK2N1R0d6K01FTzBaUUg3T2sr?=
 =?iso-2022-jp?B?eGF2K2RSc1pYODUrL0h4YlpJYTYxakE3SXBCSGlXVjI0Qm1DSmU4OFd0?=
 =?iso-2022-jp?B?QnJvaW1VaGpZVGtNMkdVemxlWTBiYXFiY1pZZ0RYRU9zQjMwMy9pc2tO?=
 =?iso-2022-jp?B?dEUvc2lMQ3RaWHBVaGpWWXhkOUZYR2NiNXRkbmU2ZjlyQW0vcTNWc2t5?=
 =?iso-2022-jp?B?WldYSkcxTFMxQmNUclZIWUdLZVQzdVdwZzRUam9GbFJqQitQR0xFdGgz?=
 =?iso-2022-jp?B?RnlYUCtKZ1ZKSm5pZmpyTndFaXZkOEMybmFncUNjSzE0OHptcVI5ZFh1?=
 =?iso-2022-jp?B?T0dPbkt4N1VuWkk5NmkvU3BPaThVZmM2eDg5UGhXOVAvaWYzcW00UEFM?=
 =?iso-2022-jp?B?aVdIUzNSTXF2Q3NnT01hd0JSYTZtRGhlMU5yZkVGUE5qM1VoNXR3Q0Ir?=
 =?iso-2022-jp?B?NWZOMVNSYUxhalErekk5K014UUgwR1MvNnhhSUp4SzFrWElVSEZjajAr?=
 =?iso-2022-jp?B?akVaQ25WUHRoQStSTEVkMjJ0WWowTFZhNlJVMVVxRmRhbitaSGxDN21W?=
 =?iso-2022-jp?B?MURhMll5ZHVSZ3E2dDBrYndGS2V3MCs5NHNYcDlWUnNPdGl6STFlc3dP?=
 =?iso-2022-jp?B?LzRCbVVNWCtvaC8wOC9OUWVTTkRyNE9RTTdyenBXNkgrOVhUUXd0K2ww?=
 =?iso-2022-jp?B?TDQ2SDlqbjVIV2dUSU5FR2RiSmJCNjJZaW9DNlQxTHZ1R2RxTWhIMGdB?=
 =?iso-2022-jp?B?MHc5OEwwSUVYK0QxVm9ZQTkwaVBvZkp6RFJMSjVLVUk0ZlQ3QUtIRkt1?=
 =?iso-2022-jp?B?eFpoSXp2NWFRRnUyNkgreWQycXlOdlVuMFV0WUc1S1ZRc3FJNmk2OTgz?=
 =?iso-2022-jp?B?Wm83bQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c42389-c425-44dd-fbb9-08de3d454146
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 08:21:19.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Z5hW2mRvObFp1fVgzcnOsUE7wCYVyrqoU9VePeeCuohCEjix1pwj/ftbrgXIQD8Esi940BrOAGLohYEbwLNoXv6UCLsJxHhPNrmsutdRWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
X-Proofpoint-GUID: Js8MdqC3njjb4cIy_xsVB5ZTvAM_lwvJ
X-Proofpoint-ORIG-GUID: Js8MdqC3njjb4cIy_xsVB5ZTvAM_lwvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA2NCBTYWx0ZWRfX6bgBRfmIuAKa
 Y5Pno8phD2dCSyA4hVRKuKI0fFBypoD4C1yeYCFkqoXx1xarX5R4UoaJSGagSpIv/vrSAhSZuEE
 5R2+SSH3WkakUu6Wz8/RcDF11NJ4I9Nf3WkHN0ePlzTZjX1v+ClLGO2aWlPoM6lZVhlwRd0UGLL
 4p3ZbNX1jRqGDvX729c90cUsDEmTuFanvbsgww8FTvKsITPOlYUipuiMaAAMnaNGVdmxU5FlZsj
 E63kQfAdl33Ayfb1bD7MsMBaQi1zGqJy6Z2rOi214jzUj5OQEf1ANEvI+g1ZOlHmEmch3AbKBLj
 ZHqQniI8jxW0Ry+XYpWVmoJnbNzepCjOpzjDd1cuv0e6PvAazFJkyKNjlbdm6J+qGyyn6cPIogr
 sJoKrLJ2rEoV8qIqib1Nkj3Na+fqLw==
X-Authority-Analysis: v=2.4 cv=PqeergM3 c=1 sm=1 tr=0 ts=69426803 cx=c_pps
 a=HiuaN0cSM6iMs60el9to+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=ZPSk82zQDygA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ykLWeeSMUmKRLsd6IYkA:9
 a=UAVRJdkkkM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170064

Hi all,=0A=
=0A=
I am seeing an reproducible issue in=0A=
drivers/spi/spi-cadence-quadspi.c on TI J72xx platform.=0A=
=0A=
Kernel:=0A=
  v6.1/standard/preempt-rt/ti-sdk-6.1/ti-j7xxx=0A=
  (based on Linux v6.1.159 PREEMPT_RT)=0A=
=0A=
Platform:=0A=
  TI J72xx=0A=
  QSPI controller: Cadence QuadSPI=0A=
=0A=
Problem description:=0A=
when boot fail with the following call trace:=0A=
[    2.028205] ------------[ cut here ]------------=0A=
[    2.028213] rtmutex deadlock detected=0A=
[    2.028227] WARNING: CPU: 1 PID: 50 at kernel/locking/rtmutex.c:1642 __r=
t_mutex_slowlock_locked.constprop.0+0x184/0x2dc=0A=
[    2.028246] Modules linked in:=0A=
[    2.028256] CPU: 1 PID: 50 Comm: kworker/u8:1 Not tainted 6.1.159-rt32-y=
octo-preempt-rt #1=0A=
[    2.028263] Hardware name: Texas Instruments AM62A7 SK (DT)=0A=
[    2.028269] Workqueue: events_unbound deferred_probe_work_func=0A=
[    2.028282] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)=0A=
[    2.028288] pc : __rt_mutex_slowlock_locked.constprop.0+0x184/0x2dc=0A=
[    2.028294] lr : __rt_mutex_slowlock_locked.constprop.0+0x184/0x2dc=0A=
[    2.028300] sp : fffffe000abef090=0A=
[    2.028302] x29: fffffe000abef110 x28: fffffe00090dc620 x27: 00000000000=
00001=0A=
[    2.028311] x26: fffffc0801af98f8 x25: 0000000000000000 x24: fffffc0804a=
c4088=0A=
[    2.028319] x23: 0000000000000000 x22: fffffe000abef098 x21: 00000000fff=
fffdd=0A=
[    2.028327] x20: fffffc0801a01d80 x19: fffffc08034b53e0 x18: fffffffffff=
fffff=0A=
[    2.028335] x17: 0000000000000000 x16: 0000000000000001 x15: fffffe000ab=
ef5b0=0A=
[    2.028343] x14: fffffc0804d1ad8e x13: 0a64657463657465 x12: 64206b636f6=
c6461=0A=
[    2.028351] x11: fffffffffffe0000 x10: 2d2d2d2d2d2d2d2d x9 : fffffe00080=
fc87c=0A=
[    2.028359] x8 : fffffe000abef090 x7 : 6b636f6c64616564 x6 : 00000000000=
0000c=0A=
[    2.028367] x5 : 00000000fffff141 x4 : fffffe000abeee40 x3 : 00000000000=
00000=0A=
[    2.028375] x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffc0801a=
01d80=0A=
[    2.028384] Call trace:=0A=
[    2.028386]  __rt_mutex_slowlock_locked.constprop.0+0x184/0x2dc=0A=
[    2.028393]  mutex_lock+0x98/0xbc=0A=
[    2.028401]  spi_controller_resume+0x28/0xbc=0A=
[    2.028410]  cqspi_resume+0x58/0xa4=0A=
[    2.028418]  pm_generic_runtime_resume+0x34/0x50=0A=
[    2.028426]  __genpd_runtime_resume+0x38/0x90=0A=
[    2.028434]  genpd_runtime_resume+0x148/0x27c=0A=
[    2.028443]  __rpm_callback+0x50/0x1b4=0A=
[    2.028452]  rpm_callback+0x74/0x80=0A=
[    2.028459]  rpm_resume+0x5e4/0x85c=0A=
[    2.028467]  __pm_runtime_resume+0x5c/0xc0=0A=
[    2.028474]  cqspi_exec_mem_op+0x64/0xf50=0A=
[    2.028481]  spi_mem_exec_op+0x3bc/0x410=0A=
[    2.028487]  spinand_reset_op.constprop.0+0x64/0xa0=0A=
[    2.028495]  spinand_probe+0xdc/0x650=0A=
[    2.028502]  spi_mem_probe+0x74/0xc4=0A=
[    2.028508]  spi_probe+0x8c/0xec=0A=
[    2.028515]  really_probe+0xc4/0x2e0=0A=
[    2.028523]  __driver_probe_device+0x80/0x120=0A=
[    2.028531]  driver_probe_device+0xdc/0x170=0A=
[    2.028539]  __device_attach_driver+0xc0/0x14c=0A=
[    2.028548]  bus_for_each_drv+0x88/0xec=0A=
[    2.028555]  __device_attach+0xa8/0x1ac=0A=
[    2.028563]  device_initial_probe+0x1c/0x30=0A=
[    2.028572]  bus_probe_device+0xa4/0xb0=0A=
[    2.028579]  device_add+0x380/0x784=0A=
[    2.028586]  __spi_add_device+0x74/0x114=0A=
[    2.028592]  spi_add_device+0x68/0xa0=0A=
[    2.028597]  spi_register_controller+0x730/0xb00=0A=
[    2.028602]  cqspi_probe+0x690/0x98c=0A=
[    2.028608]  platform_probe+0x70/0xcc=0A=
[    2.028615]  really_probe+0xc4/0x2e0=0A=
[    2.028623]  __driver_probe_device+0x80/0x120=0A=
[    2.028631]  driver_probe_device+0xdc/0x170=0A=
[    2.028639]  __device_attach_driver+0xc0/0x14c=0A=
[    2.028648]  bus_for_each_drv+0x88/0xec=0A=
[    2.028655]  __device_attach+0xa8/0x1ac=0A=
[    2.028663]  device_initial_probe+0x1c/0x30=0A=
[    2.028671]  bus_probe_device+0xa4/0xb0=0A=
[    2.028679]  deferred_probe_work_func+0x90/0xd0=0A=
[    2.028687]  process_one_work+0x1f8/0x4b0=0A=
[    2.028696]  worker_thread+0x238/0x440=0A=
[    2.028703]  kthread+0x138/0x140=0A=
[    2.028710]  ret_from_fork+0x10/0x20=0A=
[    2.028718] ---[ end trace 0000000000000000 ]---=0A=
=0A=
Analysis:=0A=
* 18db8c7f20a6 (HEAD) Revert "spi: cadence-qspi: fix pointer reference in r=
untime PM hooks"=0A=
*   7083c6620486 Merge branch 'v6.1/standard/base' into v6.1/standard/preem=
pt-rt/ti-sdk-6.1/ti-j7xxx=0A=
|\=0A=
| *   2c1b513331dc Merge tag 'v6.1.140' into v6.1/standard/base=0A=
| |\=0A=
| | * da3c5173c55f (tag: v6.1.140) Linux 6.1.140=0A=
| | * 05e85d376720 x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()=
=0A=
=0A=
It is ok at da3c5173c55f=1B$B!$=1B(Bbut it is bad at 7083c6620486.=0A=
I revert the commit(2c914aac952) which merged from stable release,  it also=
 ok at 18db8c7f20a6.=0A=
Maybe it is a compatibility issue between v6.1/standard/preempt-rt/ti-sdk-6=
.1/ti-j7xxx and the stable release.=0A=
=0A=
if this is an known issue ? =0A=
=0A=
Thanks,=0A=
Guocai He=

