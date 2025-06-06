Return-Path: <linux-spi+bounces-8372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C261ACFF02
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6E3AB886
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA121FC0FC;
	Fri,  6 Jun 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UxhzmmsG"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F74A0A;
	Fri,  6 Jun 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201335; cv=fail; b=Tt9BGqC7ILHhMnYQcqWff5SgTw+F7/ig1stllF3MVbIb/P+aBZ3O5hwpo0+p2xojY2ACCWvKloVcAu6NENln811Eh7HbvnrgzjccQyzJYWgfujQn9d88zSUNe1jcy0kIdFHH7O/7ORQy6lsSDUidym+fMJIiKE9nmGSD2CzBVnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201335; c=relaxed/simple;
	bh=bR2t6FFlLpfjJqoaUwDHBXKVXxu9op8f68TcWKAGglM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SU/HUP6m3E2RiMkK4q8S9h0dMRKADR/KKHX9KRT8m4nWPhtSCMOrA99dXm4KhjTzbKuBbtdNUubyGw1a9M0FQ4c4Pu1+H/+XR2q1y1sjJBBOk2wHctIYr9FccDpHAySxj+66Wo01djYo2bSnEMKuQ2DGkfOnNnvM2+QdWU/i2QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UxhzmmsG; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYpY00Vcz8iO+/Y5rnNhQZ/+9YVUy7fi05uqGvtfEMrc7ha8b93B8atinyUCVEn8ep65/RbehPoQcyQ+wFDWVqrxZgq3wu4Tp++z2pu1onyT0wRziy95+zjE1xpx0U3RqTWJ4K/3nFoTKcabIGN9H98OX2K06bmo3+fu6hgRXcbJWvGrY2HlVE2gEWFrRZiLLEoKAQlQWN8xtsucjYm56fFcA6qiqiqTs+qxLMiS/aQC12K1LAILpqW3kX46Llc7uCpNV18g4mIKCAg6BBwxiMBNicHSfZHa2RU+H7aeabdhuj4Q2/LEZSm8grtFzx8FYiJQ6B0puZsqsV9r/xE8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR2t6FFlLpfjJqoaUwDHBXKVXxu9op8f68TcWKAGglM=;
 b=IaLmZ6plzremG+Ap3/eMsWoTplL6Y74hggrxkQYbJ8PqbkEPTZwi6yo+B491fQ6Y3IXDjIWGhwGiqRkmCBAJJ25hGoTFKy8OCSyHQ3BE0/94AVplKg08H4om03lsAXwP9VK0JZZEnCaVUOEOup+E0stnB7Eh08IQSyic/KsRgu+5VRr9yAor0bLfjDw9dIh39pfolwSn8Dl87UoNEVXmBfpOCQpQh+tI9w4pr40inVMrpLr3Fo9CeJP/5A5g40b53lZwb+M3490BOv9z37H8R0Jf7MNwCbBjGMHrRZoOcuGoOZJIFDM9gq7jXYO1OJ90kioNzPlPhP9p0REiz5pjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR2t6FFlLpfjJqoaUwDHBXKVXxu9op8f68TcWKAGglM=;
 b=UxhzmmsGSFORWDbTseAqW38S7vNYZCy6ZRylil3EbuJot4Lo6oqi6h7lW4m4XwwkMSrJTMonC4xnrNukUlDR7fcbUqwNCfeMdeez385PAbWMPqK8579RxtUehgBKT/Kx0rx3187aMM+hiTS4uJ49rxIJ/B3uSIjaIwdZiiGSRey4L1/BX0V06snbz4/XKxYylD9wy6X8TaGExqBmoQVnwG+oVpwHAtlSH8W2imrharKLvmIk93dWxFLyiJrKnyMi6XIeZ5QC0Bqc59kdGY7XLozt/5cNS3TWeSDtKLcjkGw1uy1nj0XWMrRt/ZOVujABFkmetSt67+J13g/bH6Sivw==
Received: from IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7)
 by CY5PR11MB6281.namprd11.prod.outlook.com (2603:10b6:930:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 09:15:29 +0000
Received: from IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::fa56:fac3:2d22:311f]) by IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::fa56:fac3:2d22:311f%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 09:15:29 +0000
From: <Thangaraj.S@microchip.com>
To: <dan.carpenter@linaro.org>
CC: <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next] spi: spi-pci1xxxx: Fix error code in probe
Thread-Topic: [PATCH next] spi: spi-pci1xxxx: Fix error code in probe
Thread-Index: AQHb1sIAf3cxr89dH0GxQwe8etbSebP12IAA
Date: Fri, 6 Jun 2025 09:15:29 +0000
Message-ID: <5813d7e82bcbae960712a77651a1dc448919a1b4.camel@microchip.com>
References: <aEKvDrUxD19GWi0u@stanley.mountain>
In-Reply-To: <aEKvDrUxD19GWi0u@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8804:EE_|CY5PR11MB6281:EE_
x-ms-office365-filtering-correlation-id: ba0aea3f-bead-4c76-ed48-08dda4daaea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emF2b05ZSmJsZjFtUGtPVW5UbEFCaDJFbVBBVkprcFlLam9QWEFRM1FSMXRI?=
 =?utf-8?B?c09yUEc1VnFDaVRzV1p2OVVuVnc0bDJNYjV3NFZBZmZCSnFScU9nWkF5RWJ2?=
 =?utf-8?B?UFg1Y1k3SGNtcnYwWkV0YjlIVTZ6OUNDd05ueTh3OXExb0ZoMEQ1ZVUyOWQ1?=
 =?utf-8?B?WXlmVWpIZmJxQ2pvbFc3c3lZU3dGam9rbWtPaHNRV0IydnFsMGxtTlFWR3Mz?=
 =?utf-8?B?bXI0VTM1YVZsUmpRSllUcEU5OUdBQXh4YVdVSFpkWkN5L3c1K0J6OGJ5T3Fn?=
 =?utf-8?B?Vjk5SENsNXcxMEt4N3ZlSk0wVlZLU0wzekcxUW9XcWluVlN4UnpnaThzbjdR?=
 =?utf-8?B?MTRXVFA2cUlPaVlvU2ZOL01kOWN1MnhCRzI0c3ZWa3p5RWFyWFhodlJCTEtt?=
 =?utf-8?B?MkliQUZoeFNzekdEWnpWeHo4TnYwTExQSEtkcCt6aExoaTFDZnVaY1pWd0xS?=
 =?utf-8?B?WUpTeHZrV1BFTFBWaDFGUmFVNjlTemZ3S2lkejRWZURjVVlDZURLSHdwUWtM?=
 =?utf-8?B?K25ZRnlyUW9aSXhMcHZucEY2Y2lCOWl3amVBalhsZnEvYmVIOEFGWmUrNFo3?=
 =?utf-8?B?Y0RUaGprSjlnVyt6UjJJajQvbVBZY3d3VnFmWlArNWMxOCtpbW82OHlZOXE0?=
 =?utf-8?B?STJkVTF2eVE0TE9VekRsK1JnUmxzdUtqcDF1VnRDdVlPRnJvQlJnNXZ1ZUg3?=
 =?utf-8?B?cjhqRWZXM1lNaGxla1NBZ0VMQUkybVdKdFE0cG1mL3Uvd2dFVVphQnZPbUN3?=
 =?utf-8?B?eHZ3c3JJSlUrYi9VUll3K1lHZjNWOXR2dXd5eDROWmg4M1ljbVV1bk5SN0I3?=
 =?utf-8?B?QVdEU0t4OGhjK1l0L1l6TGhlVDdRc0w2Zk5HYTVWaEZGUW44V2VITUdRT3Uy?=
 =?utf-8?B?ek12Rm1nMWh5cjJ2SC9xZzc0NjVza1RwSVdteHBjbHZ0d2g0aXhDMEc2SkE0?=
 =?utf-8?B?ZUEydW9GL1JlQUN1MHc2Q3hENEg2SVNMdzBoZHVEcXFvcDlZRVVwMGYvVHd4?=
 =?utf-8?B?emxGdmRYa1ZVZHRqdDFkZnpVNVVDcE9md2cweHA3WkVsZlp3c2N5MStmK3Qy?=
 =?utf-8?B?eHM4cWRHWHFmbkFvVWN4NXQwU2FYUldsNGNZOGp4dTZQbTE2SmZYQkxiRGVp?=
 =?utf-8?B?TVR6bDd5V1AyNFJpZXpwNWo1Z1RzaHlXekl0a2gzc21NazQzL1p5ekRxR0xZ?=
 =?utf-8?B?VkR6MkRiQTFVZWdiY0EwK3R4aHgzSC8wZm9kMFZoclpzVndheVlzb0JHR01t?=
 =?utf-8?B?OE5kSUpLQStKNmgxZ3QzVjRPUG1zRVZITWF5dlNyQ3NmNzhDQXpCTlVXdmRi?=
 =?utf-8?B?Wko4QWo2ZEg4SThNanhRSkxxamh5aitIMXFNTFNweFRKVmtLaXloSkZLbS9k?=
 =?utf-8?B?RWZodUFMRjA0WGFSc2pBUDRYUk0zUzJ5NUl2ekNYQzdPRFdMaFlCYkZHS20x?=
 =?utf-8?B?TnNUZXI4M0RLY3FMZGhJS1F2L1dnR05nc2ZSdmNqczVTbHlmWW1LNWpmOEx3?=
 =?utf-8?B?YnNBbmR1Smh3Ym1ZMUZoT3VkSmhnN2l3RllMMFNvNzNxMHNPMCtoY2tkN253?=
 =?utf-8?B?T0pLT3lXSGR4ak02TXRBT3VTR2xrMGpFNnliVHRDYVF4RjkvQnZaY2RuWG05?=
 =?utf-8?B?QmdFb2RzanZsSUZ5alN5NXRHNUlpRTVKM2s5L1M4WFlyZC9wQzF4bm5mRW5T?=
 =?utf-8?B?Q1pKVHV3R2pFdjRPcFdBMG5pQ1pGUmJVN3JhdmR3UXBYeUJ1QWJUOUpnVFFQ?=
 =?utf-8?B?UnkzL082ZDAxbG1HUm9TSDdRZVQ3UDBFZlBSdWs1NWY5Z0NXUHZQZFpuQWE3?=
 =?utf-8?B?TXB2VkJDem85M3BpeWpNV3JNWkRXdmwzaWRnSUpaVDRNL0NVRDYwN0JTcXhs?=
 =?utf-8?B?VzM1aUZQVHJydzhsMUs3Q0tQRDBFRk9CdElldkM1Y1RCVmJUdEV2cllXUUpC?=
 =?utf-8?B?OWhCMnhKUmw3R0JpaUJBM2FPWmUvUklXU3hYa1VFTDZKYVptTkhHaEx1WXJt?=
 =?utf-8?B?eUk2NDZ1TnhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d25RTlRCbnhZLzVhalFWNGpselFubWNXVzFBSDdlUEY2UFJ2QWFrQndXMmpO?=
 =?utf-8?B?T3pyVzQxdGFINXYzQ1BEbVc3bmdnaTBUUGE0OG5JeGIzT1hKM01Fam5kWmc5?=
 =?utf-8?B?NmJTTjRSRDNMOElkc3g4WGtzb3hKdVZQQldlVHBZeDlMeW04RFNGWDdXVGtK?=
 =?utf-8?B?NHl1S2tFZC9mb2RVWEFNWW9mcTRMUUJtSG5IaThYbzNrUWpwczgvb3dLN3Vu?=
 =?utf-8?B?aitYVW13SE9keXF1Tmloankrcm1GTjUycDVKWVVNcnljSXc1bHdteGhHZFJR?=
 =?utf-8?B?Y0JiKzlJa0ZiN25QeitrSGFub051c2lpQjhWZTAvMHgrWDFlU2lpMG5MaDJj?=
 =?utf-8?B?N3h1Qm1uTkZCNmg1TFB3WlhCVGw5Rjk3MUdWV28xK2crWTlqM21tQ2xkRm5E?=
 =?utf-8?B?U1o0YXcvU2tScGY1QzRKL0d3NnJRUDN3S2o5dU1tN2JuSS91R0JjelpBSjIw?=
 =?utf-8?B?R3dVd0hOSWFNU2V0M0tsTTBpR3J1S0xuOWwveDd2eFQ3NnB4UFhuRitrdTY1?=
 =?utf-8?B?Q2JERG9zYnluVEUyQU1tRHNlMWRWTE12VjV4L2RDb3JDNzc0QTJGeVBCWC9w?=
 =?utf-8?B?QkxIL1lXTlc1Y0RRclRJN3VQb3RSUkZSdHdqeXBmUklYVkRSRFpBRGhPUGRp?=
 =?utf-8?B?a3FPcVdnbmNUQ1pZamszby8rTVFXTVdaRVg1dmgzWXdDYmdsZ3dOK25YV1Bw?=
 =?utf-8?B?L0x0NWhGZ3E4djlLbHdudHNRWDhhNzNleUxhYWlMalN6KzcxMTlITlZaTnNq?=
 =?utf-8?B?OGd1SGhCS21uMG9UK3N4T0dnT05LaFVYMmNnbGtxS1EvNXRXVDVRL0dGR01R?=
 =?utf-8?B?MTNheVMrSGVUYUFRYnRTWmIrc0ZaeURDdkNQanYrdWtIL1MycjlMVmFUb2oz?=
 =?utf-8?B?TjIreDFsRFJDYkpqeXpUb2xNRzNiQ3J5c2JJYlRpRDJoWGQxVVo2cFEwak5H?=
 =?utf-8?B?WGNNMzRhaWZGcldhR1dIUW4wSFErbTJoZlAxc2hRd3dqMjdoWWhyRFpGaE5H?=
 =?utf-8?B?b2dTdkg3cWJXZUFocFhpY3F1RjM5aEFuazRid3lDZlJrTXdocWpxb2NLZDhp?=
 =?utf-8?B?TWk5R2drOTIzM0ZOYjExOHRzeU5jV20wcm92QlNFaXI1N093VVB1SU1TeFpT?=
 =?utf-8?B?VUlZeG90cExUSW5UdzJHaDBiTUxQbEluazVUVzJ2L2lDems0SW8ydEpKTnYz?=
 =?utf-8?B?TU5DSnlhYVJCRUkwN3hYUWJXREZLaUxJcFo4a045cWxHd3NiK3pPZTloS0Fm?=
 =?utf-8?B?am01N3RYQ3JMZTJzUjhDWitjRm1JMjFwak9Hd3FoR3Z4R3VSNVFWbWptb2NF?=
 =?utf-8?B?dVdNaTJxMmRvcU4vS2s4dHk3RUNsNXRuQ1JtdUQ5aFJEeTlKWmpid2NSZFR2?=
 =?utf-8?B?UlZQWmVTald5NnRRNlhqWnhEeDRmWnVzbEFoVEhCWU1UTXhydEZwMWNYeHlV?=
 =?utf-8?B?ZTF3L25CYTUrMXYzN1BqNUluemdlWDQwREo4aGhFcDI4U29laERxOFZsSDdV?=
 =?utf-8?B?RnhwVllFRm9tTFdObmtOMThXM05MSE93UXp6RDBITFhvUm9XbWJkVy9IcTJI?=
 =?utf-8?B?KzVGWDhvZlRZYWdsZkIxcFpwNDdtNzBwdVBEYk8xUWdiRStzU2kyeFNTV2Iw?=
 =?utf-8?B?bHd1RjBaZWF4a0dSejlvQUVsOTQ0Zm9DT3lnWEszR2VtdG5qOU5kYnFlRENZ?=
 =?utf-8?B?ZXVMOGg2Uk82VmtpYnUyeVdLWUVsZkJMMStEV2pqM2tkdHlDSXdVTTdEOEVp?=
 =?utf-8?B?dTNtUWliSFE0czB5cVdIcEYzeStMcTNJQnNzUktLcTc4MzB1UU10aGozV3Fs?=
 =?utf-8?B?OXlRRXF2ZmVUdmdlZkdJVzBkbXMvWWg4ZEF6dFZjM2RNZmFmNUNhYzlQbS9r?=
 =?utf-8?B?RzdCaDdic3FRdTRPaVlpV3MyMk5MSEdXOVowQXdyUVZRTnZpTzgycU5CVkRj?=
 =?utf-8?B?TUJ3ZFJrSEIrYThSNFRCQzhCaGJscTdCUVZkcEZXczJvUlNzOVA2WGZWbzN2?=
 =?utf-8?B?Z3N2N24yK3IwY204Y21UaGFGRUVrUXpyc0ZRRlpCa2I1R1dQc1Exbmk5VDAz?=
 =?utf-8?B?RjYvdUdCQjNqRUs2Z01OOGQwT283NEkrd0JNUEpaMTJDUXZlc2hDejFiL1ls?=
 =?utf-8?B?MzV5YkFja2FPTUNFSXlvK3VLVEU5K3VVRHRralhLWHJFZ0JPZEpBNzFCaU9x?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E7037BE30CE9D43AA6CA7B854F809DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0aea3f-bead-4c76-ed48-08dda4daaea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 09:15:29.6349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kywpv9LA1RUrcz72CV08OElD/JoSOswcCDog+IifydpzdNLB7SujSo45ra2nSw2sB3zoiMq9TR2OIrr4mcsSWoecajBHVe3CrUBP1KRmZs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6281

T24gRnJpLCAyMDI1LTA2LTA2IGF0IDEyOjA0ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFJldHVybiB0aGUg
ZXJyb3IgY29kZSBpZiBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKSBmYWlscy4gIERvbid0IHJldHVy
bg0KPiBzdWNjZXNzLg0KPiANCj4gRml4ZXM6IGI0NjA4ZTk0NDE3NyAoInNwaTogc3BpLXBjaTF4
eHh4OiBGaXggUHJvYmUgZmFpbHVyZSB3aXRoIER1YWwNCj4gU1BJIGluc3RhbmNlIHdpdGggSU5U
eCBpbnRlcnJ1cHRzIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBsaW5hcm8ub3JnPg0KPiANCg0KUmV2aWV3ZWQtYnk6IFRoYW5nYXJhaiBTYW15bmF0aGFu
IDx0aGFuZ2FyYWouc0BtaWNyb2NoaXAuY29tPg0K

