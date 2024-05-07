Return-Path: <linux-spi+bounces-2758-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C238BDCCB
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 09:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51A51C223C7
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FEB13C3FA;
	Tue,  7 May 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zqV1R0jO";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m0PiswWf"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28F13C800;
	Tue,  7 May 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068707; cv=fail; b=JMIIwLIQRiUJm/c6YEdNR4yfUiYUwQXzwaIoyszD3BkB7MIYqmq2/k1dNOMG72LEvbZa3laDQewi5FxcMfbycJ3p5rKYXoPn1SpXfrYs0Ikt3tqNfLrm0W5qGwhqYjozVRH9KAfuYsYRl9DfQugV1eaV4Bm06r7+tzY/mcamGM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068707; c=relaxed/simple;
	bh=5EssCNVHJo6pjKWHB7PpDbfaBu5itJo78VDNsi6q5lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8G07FARxZNZQFFA5xfrsCpT5guIeuXQ3NHx5YHs7UHfb/EX+jemCwBV6mLRbD/3ZFHtceaGu2Np9RDj0Ng9GRjZjvM4Bo6j5izcMbVWKwa8Im2OfBklZg+dWKNlnvjjfxrhYaAGUwHLmz6MQoynH7Tf1HzMdaXjVAPRjYNSzj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zqV1R0jO; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m0PiswWf; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715068705; x=1746604705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5EssCNVHJo6pjKWHB7PpDbfaBu5itJo78VDNsi6q5lM=;
  b=zqV1R0jORbP+Hm3OKvftMFinF+1reoHZtOyWzsMO/WFkaz8/hr5mj7Va
   KwMUYly2eucHWCoRdJl1dJiMIRtlomeQldsEpd6DurlLtaryxX6yM7Y97
   7VO9js5/C6SJYPR0G3yeqnqyfwXDYRCE5o0S5/Fp5ZKJ6ZPfaUSIDPo+r
   3HmEIgWE7UBfV4MMHtLx1doP3LOZwWJc0S3bYl97GQb4EgwNFSo9FmuRQ
   fWEPQuQHrwKyl57/Bh+jquOTCIB8k5UZGhWrRjpVwZvZ+vmaB+unRUnXV
   owtUe6Mu8hPB2ooKkyoYW3M0i4Dy3UaHJThdpA3bFZlmNAnML9kRTS6WJ
   w==;
X-CSE-ConnectionGUID: pDU4R+kjSCq2Htzn5riqEg==
X-CSE-MsgGUID: 0hVTZVqUQSSb+w9hyCzVeA==
X-IronPort-AV: E=Sophos;i="6.07,260,1708412400"; 
   d="scan'208";a="23940927"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2024 00:58:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:58:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 00:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZdq11/nOISorHsivC6PZKXvFyNiPeikFelFMyQAcHxb7XfJZKV53qIDYGuxLS8znsYFRcZgwM8nT/AXIbgNrgw8fEp9nKNtG1CQHD9QNiuwVSn8Urc2HdWiVDrgVbTV7oQIwrmUofonJYs8f5Sn38/QiiQbFrovTdX9cdLbpepFd44Myn0WaV8e/SZ4MHXtxsfVjzhXSu/49OAz5os+lHlJcGI+XeM1ydLjgia5lI7Hta2CvJ+duzUQkwcgLhPpcHpMGqYjejry0RrNz3f2G6HgnD1i8ROVqd4l3NvWH9qTRV8FeT6katJYef8xXgcz5Wl0ILbr25qCcHNQ5OFdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EssCNVHJo6pjKWHB7PpDbfaBu5itJo78VDNsi6q5lM=;
 b=ljnU/oq23uaY+fescegS37Ws+qp0hGfP//dIZldR4FCD3zqqqgsXO4qpxQbC1Bv63pWPEN6oYjyUgS5dHy7w1LQpF94b+2OiqVOUrM5bv7Qb2Vo096djKgfsaiaRbQ7V07l4BDFNnUtgx6pmxB6FX0Gicv3VihLNB+lJwp3aswP2pVQusb0Txox5FNo/w3tmF8tprFLXRfR3K0K6YW9HLitZ9Sv8I6FHCkCwa2Vxrspdm5lhDnrsW2VApTFk3yd2XkE3/JvZVHnylenx0LRJrXwwTxBAILJTENA1DmFBkM+6LDP2mhE4PNNjLs+lbtiMvc+W5/ORS39l3PyLvyV42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EssCNVHJo6pjKWHB7PpDbfaBu5itJo78VDNsi6q5lM=;
 b=m0PiswWfXTJgQf2QvYdX9T24HAfHgqXV5OcHhOsDkFKJqNRG5uprSlU79ndfqTSMVbX7mVo6T86IO/JrO4EjKeHOQGdb3akeclV4o5w0x/B11h8MODatQ384pMiWJCW2SZql1gv+nztyXxx3wnsDfSajPWbfm4lUK0iB13nt2btmlfjq12iAKIqK2XqiB5SqjkhwDrSTYPG//YRD7GtrFjbX7jywMZX1lze02ogrVF6shsPhs/q/XNUQw+0L9PjG5SThDHfLOVpNtC9SJlYCHmGe0riEEC3d/pbcyjpkXvrYZBB0EaU07AdqoSpERC1u2ahsiCEFpgZFe63fV3jMzw==
Received: from CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 07:58:07 +0000
Received: from CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510]) by CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:57:55 +0000
From: <Prajna.Rajendrakumar@microchip.com>
To: <broonie@kernel.org>, <krzk@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>,
	<Valentina.FernandezAlanis@microchip.com>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <Daire.McNamara@microchip.com>,
	<Prajna.Rajendrakumar@microchip.com>
Subject: Re: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Thread-Topic: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Thread-Index: AQHanJ37n9FOOFXPxkOxyyvGvn4yU7GEB80AgAFxNICAAB8MgIAF122A
Date: Tue, 7 May 2024 07:57:55 +0000
Message-ID: <1ba98f27f1cc4cd6c3db0b398fa3252c20ef5c3a.camel@microchip.com>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
	 <20240502143410.12629-3-prajna.rajendrakumar@microchip.com>
	 <10671947-f418-4520-a29f-4ce129770e65@kernel.org>
	 <1edb6c4c1a66c1a2009278b99f897e3a71b592c6.camel@microchip.com>
	 <7b6489b7-ec9f-4fc7-af72-4d5cc87acd7f@kernel.org>
In-Reply-To: <7b6489b7-ec9f-4fc7-af72-4d5cc87acd7f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8386:EE_|PH8PR11MB6756:EE_
x-ms-office365-filtering-correlation-id: 2c492028-021d-4f07-bb50-08dc6e6b67a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NG9SbzhXdXpaSkxrRnpvdE5McEFLV25wVU5DTEc1eFdMVURpVEpzZmU0WjVj?=
 =?utf-8?B?UEo3K0FSNm5VQWNkWForZmNidFFqM205akZnbVBXMkpQSm5jOU9xejBXdmt6?=
 =?utf-8?B?SDVvWkdxd093Y1BrazJ5U0dCaXdWcXlMdG5DTnowRms4alJYQ2FJV1Jhc0RC?=
 =?utf-8?B?LzNNejNhYVNkcTJabFhOc0xGMkV5S29qcXJTQXVPcUtISmwvZHpIaGgyQlQy?=
 =?utf-8?B?d01aZG1xa05wMzBXc2YyeStOQVJjYzU0akJKc1RZMWFiR3JFc3BOQ3FvME5t?=
 =?utf-8?B?S2lLR3l6Uzc4d3ZNMGRPMEpDbEI0K3Npayt3NmNkNzJ2R1FhZ21YUTFTWmNx?=
 =?utf-8?B?Y2IrdWFZN3N1MlNnNkU2eCszcUJycFpEQzJLdFllcUQvYmp2MWZVY1BHSDlk?=
 =?utf-8?B?K2RPUlEyUzA1Ti9uV2ZMMm1hb0NoZkRoUU1iQUExTFJ5bFNkM21YWGVRQXRQ?=
 =?utf-8?B?d1dqSEdVbUFkUDFMS2FrYm8wOUZURGhRRGpzTTNlUitNOHhwVVU3VFUyWFJa?=
 =?utf-8?B?MmdsWGRPNU0rTC8vMEtzazh5N3g2M1RBMldLMFNsUkJHSndyY2VJajE5RGly?=
 =?utf-8?B?SU43UGtpVUI4T1RaWFR6NHFZL1ZJeW1wbi92UjlXUUtlT0prckZnQ2JBTk14?=
 =?utf-8?B?TG1pY2syZGU5ZzVsdmZSVXlnc2QzNEF3ejlYRStOY1hBR216M0d5M1VmVmM3?=
 =?utf-8?B?N0JjK0tWK3dEZEpYUlBoK2RSMDlGTEl0ZW5aRnhMN1JSZXhQSEIwaFhIbUpQ?=
 =?utf-8?B?VGVLTm4xOHhyYXYrL1IvQkhqUHRDY1BwU0JqZEl2aUNBaEJ0WnkvaUhPbGxM?=
 =?utf-8?B?M3B5VW0xTS9sNFMwNkxDN0lrdDRaZXlGcHNUR2Zvb3JxY0xTdEJwbTRKanZC?=
 =?utf-8?B?djMwY0R2bTdFdHpUT3BLZjRXenc4Mno1eGhVczhLOUdiR3NHMjcwdUZtTTIw?=
 =?utf-8?B?WFAzVVU3N29vL0ZQemJhenlaVFBHQXpUTE9pMWM0VDlaMkc3U2h4VDR2VlNB?=
 =?utf-8?B?dDdTTkxHdCtYWEQ1aWlTYWhCQXZscERadDlmODJFOTdZUVROdDBEQ1EzcjZX?=
 =?utf-8?B?K3NnaU1RNDByT0p1TVZPSWZmMXBERnBvYWdXL0pTU25IS25TZ0lndnpxM1A2?=
 =?utf-8?B?cWFxZjhMTk91ajF4SG9GcHJCY2s4aHRDemRHZmpWdER0Rkl6RENMRndibWx1?=
 =?utf-8?B?ZVlKVkIxRXNvQ3FiVjM5Yk9UTkVXQjJSd3RSNjVsNnF3R3c2a2lMOW5SSll4?=
 =?utf-8?B?OUZmYjBTSEdndTFjeDVLNUlRZW04MUdLRnlKakhGLytZeDRBdFppcTA0UlRG?=
 =?utf-8?B?R3l6cmVhdHVNSHIzUGVQRGluYWlxcnZlWkxsV3FDRnNBTjA1SXdKNGJPNmR5?=
 =?utf-8?B?SUdKc21Ibno1dVNXajNVM1pKSE9NajdEZXRwQWEvV2h0Sjl1MGdyRHpJdWhR?=
 =?utf-8?B?WG9DR1A3VXZGRTl6a3Rzd2hrK3dTNTlQdkJOUWxPbmtjNkxVbmZYcHJjYVAr?=
 =?utf-8?B?ZzJHTGpKYmVoUjRHTUFzTHVMVlBUQURGc0FTSHJLbC8xREkyZ2N0OG92RVVO?=
 =?utf-8?B?dnhHeXBrckJ0NWNROXBRMmRwSzJZNy9RaUE3QWxldUtPcXRnZVdMOUw4WlhB?=
 =?utf-8?B?MnpZZWlCaVIrZkNQdFlEWjZyWjBlNkZicE8yaTFFM3lQd2g4MFRCOUhuMEVN?=
 =?utf-8?B?dzJucy8wejJQbUdlSWZCdnNVT3B0UnpnczFETHNHOGwrdEludWlxb2JNby8r?=
 =?utf-8?B?bW1nWWpEVW54TjF4aEY4dWYvV3NieTV2dzliNGRwSCtCbUxMYjdCbkNISjdR?=
 =?utf-8?B?eUhxVjdhRUwwRlNYcU0vUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8386.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFoNXNkRGZOZUI4QlhNOVBHYUkxY0Q0eWgrNnQ0WEpBc05DdGhzNUxGN010?=
 =?utf-8?B?WUc0SFNsTzRPdk9zdDBvZ3l4ZW5OZDN1VHlqbEpPM05ZVkJuQXRLT0RMdi9Y?=
 =?utf-8?B?NWNodkxLc3k0alc1cWE5TEV4YWxheUo3MkZnRmE3ZVVnVThDTlFweUtReVU3?=
 =?utf-8?B?Nk9yL1hQZXhTTzI0T2dDY2sraDhVQlBnSE1zL2lwOXE5YnBzd0UwTXRJN3gz?=
 =?utf-8?B?SlB1VmJKekpmY0tKSzl0REZHY1RuQ1RRcmpZbndxVkEySkhKYnFvd2NacklT?=
 =?utf-8?B?VHExZ2oyWHlpTjlGeUk3bnlaMHJCc1g1dHJMTEVjUmkvYU4zNVZ4cE5JWEVZ?=
 =?utf-8?B?YkN1SlpSYlY0T29KUUE4dUkrNHFrVEEwOEZuZzNTWHVra0FrWWZrNU9VWGZ5?=
 =?utf-8?B?czRLQXEweituZlNXSUtwYWpyQzVwWFo0QXB2WWltWGkxdlNpZFNGWGhmT2NV?=
 =?utf-8?B?N2UrT0dNdjhIUm94MUxmeFN2RGJ4UFBHUVZuSEErSGU2SUtpdlFGVUUwWGtB?=
 =?utf-8?B?cVlrWEhOZ0RUSzg1U1YwMU5aNm1LcDh4SSt5SWZjZGZyT2xWdzhmYThYeHV0?=
 =?utf-8?B?ZXlzcjVad2VvRGMxVWZwVjlXbEQwVGVEUjBjNmg2QXByaklDdVFVLzBhZ0cv?=
 =?utf-8?B?dGNVY1pkVHEzWGt0UlcvQkJEcDI0eVBUcUU5KzUweWhkVGVqcGFnQmtEMVY3?=
 =?utf-8?B?OGRyU24ySG11NXJDVnE0U0U5R0REY3RxRzRXdEZKMEpNV1BnTjM1Y0Z2WFcr?=
 =?utf-8?B?VjJGL0d1YzJldXlBajZkZTU4T1FwR3VacW5veG5CUmZqVlplNFNlcFh5MHN1?=
 =?utf-8?B?L2RBRGNSM0VLMHozeUs5MEthMENXdE1Da3ZUaFlKckZhcjRiSTBqOWxJQnlz?=
 =?utf-8?B?d0JCNnpKL2ZTSkNWWmxxY3RVeUJrOVk3M2sxN0xTRFBQaUVlTFBEM0wxT05n?=
 =?utf-8?B?c1k5QUtLcUhnblA4RjJRQ0NwUS84Wk1WVGhXYTR5RWhLOTk2OER6aWdTajk2?=
 =?utf-8?B?bVEwWDBvcjY1L3Nua2VMOVk1MEF0UXZXK0t3ZHFBbzkxRHdLQU5Tei8vbTNJ?=
 =?utf-8?B?S1lyYzhNT2NHdzNoQkJoTmV4SWlGR0pQYnh6ckFkcGNzMG1aNjJDTEdUbm1w?=
 =?utf-8?B?M2N3ZXNUNFdWdlloMko0ejRZYlUxMHRLdy95anZ3RWxpVGJOVEJxUys3Y292?=
 =?utf-8?B?b2Jjdy95ZnhlRmNIKytra3ltWVNITFB3bjlKSVl1aFVRMHJDallhVXhmUkJK?=
 =?utf-8?B?NHZuMjBUcmZnREhweHd4amhXbnlsdys0Z25LMFRYa2xkc1FrSGpTTzhxQWFB?=
 =?utf-8?B?N3dkYmF5WXdKQld3K0NRalk5OTgwc2UvL0FWVmJ0Ykp0NkNTWTRPTXBhMlRo?=
 =?utf-8?B?QWRDRklNMExVVVJ4N0hHaHpJNVBWdnBIT1g4eFQvUWwyUnR4QzZIc0pHby95?=
 =?utf-8?B?SlY0S2ZrLzhTQTNudk9yMkIyRmE4aHN0WHMrb0pzZFhSbmR2MWZFeitqY0pt?=
 =?utf-8?B?NURsWHc1dCt6eTdiVkI2TUpuQnE4alA4RUUxQnVTMWlWSDkwMDRBamlwb2VG?=
 =?utf-8?B?aHE2by9YZGRpQnhwNHZxRHFlWWRtcEVjU0sxajQ2ZEFPZVp4NmRNbTRpSnRn?=
 =?utf-8?B?KzVoT0tQWXRLQmc4RjFSMkErb205WWpXUUZYeFBFYVZKKzR1ZVZ3Kzgzbzc0?=
 =?utf-8?B?WFc2VFlNVnRLM1ZFbjc0NnNWRnlDQlo2RXFXdHZHd2Q5a2w1RlBITm1BMzE5?=
 =?utf-8?B?eDVyV3dQMks0UWp4WWJYbVlSYURYVEN2RDVHZkMzVzVyN2pvMTljYU84TTc3?=
 =?utf-8?B?V0taYXcvdk9VK016L055UC9LeG4wdjRIeHg1TzczcFNpQ1l5V0tpUHpHZ3JW?=
 =?utf-8?B?TjFSTis3a2hsSDFvNENjbVFWaUxWUDYxTUJsTjFJRUljUU14VTdlc2VrR1k3?=
 =?utf-8?B?UTdTbC9mTnZrSGV3dG1HSHlFS2hkbmVJbWVSVnVZeVVqblh2dXhrMkkvTEd5?=
 =?utf-8?B?Z3M2eDcwVVFSbjhSS0hLNGVyZi9KeTUvL2oyK1hBVktqZTVSaGZUSU14ZlVH?=
 =?utf-8?B?UktnbDFaTDBEU2NoeitzakJKeEZhWnRlbUhUQm9TVTVHVlNPTThBWTg4T0hz?=
 =?utf-8?B?VkV5YlJza3RzNEk2QmNRdjRYYnJadkFoeG1FZFZIaGR0d0lBanRSYXpQakZE?=
 =?utf-8?Q?qquizikxZR8myi7goH6k24k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D47EAD9DCBDE446841E3E0654D8F8B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8386.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c492028-021d-4f07-bb50-08dc6e6b67a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 07:57:55.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1FkIofsqbmsiuo/mdb5N28ownNH7YAI1L3pPu4Gc8EqdKAJcO5jROaft+3ECgePQgAk1EL5nl0FIzG85q7NIeyfCxR72KQtHKzNGWKh1S9Ug2GmL6XegzPoRSy/REDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756

T24gRnJpLCAyMDI0LTA1LTAzIGF0IDE2OjQ2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRl
biBnZXQgZW1haWwgZnJvbQ0KPiBrcnprQGtlcm5lbC5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGlt
cG9ydGFudCBhdCANCj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0
aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
T24gMDMvMDUvMjAyNCAxNDo1NCwgUHJham5hLlJhamVuZHJha3VtYXJAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4gPiA+ID4gKyAgLSBpZjoNCj4gPiA+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4g
PiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+
ID4gPiA+ICsgICAgICAgICAgICBjb25zdDogbWljcm9jaGlwLG1wZnMtc3BpDQo+ID4gPiA+ICsg
ICAgICBub3Q6DQo+ID4gPiA+ICsgICAgICAgIHJlcXVpcmVkOg0KPiA+ID4gPiArICAgICAgICAg
IC0gY3MtZ3Bpb3MNCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFy
ZSBleHByZXNzaW5nIGhlcmUuIERpZCB5b3UgYWN0dWFsbHkNCj4gPiA+IHZhbGlkYXRlIGl0IHRo
YXQgaXQgYWNoaWV2ZXMgZXhhY3RseSB3aGF0IHlvdSB3YW50Pw0KPiA+IA0KPiA+IFNpbmNlIHRo
ZSBjb250cm9sbGVyIHN1cHBvcnRzIG9ubHkgb25lIGNoaXAgc2VsZWN0LCB0aGUgbnVtLWNzDQo+
ID4gc2hvdWxkDQo+ID4gZGVmYXVsdCB0byAxIGFuZCBjYW5ub3QgZXhjZWVkIDEgdW5sZXNzIEdQ
SU9zIGFyZSB1c2VkIGFzIGNoaXANCj4gPiBzZWxlY3RzLg0KPiANCj4gVGhhdCdzIG5vdCByZWFs
bHkgdGhlIGFuc3dlci4uLiBvciB5b3Ugd2FudCB0byBzYXkgeW91IGRpZCBub3QgdGVzdA0KPiBp
dD8NCj4gDQpJIG92ZXJsb29rZWQgbWVudGlvbmluZyB0aGlzIGluIG15IHByZXZpb3VzIHJlcGx5
LiBJdCdzIGJlZW4gdGhvcm91Z2hseQ0KdmFsaWRhdGVkLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQo+IA0KQmVzdCByZWdhcmRzLA0KUHJham5hDQo=

