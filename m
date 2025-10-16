Return-Path: <linux-spi+bounces-10696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE87BE3C24
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39861A65C53
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEF339B31;
	Thu, 16 Oct 2025 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Owe7tokX"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023082.outbound.protection.outlook.com [40.107.162.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604118A6C4;
	Thu, 16 Oct 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621970; cv=fail; b=XSfI+G+XIcaTMY35PbYHRksUh8fwtiEGx8l/CAf5vWHs8hzoASaM6kNQrM4uKX2Jz0iyTeYf5FCVaTFdUBiMu7Cs4Gk/L1uC1Ui2fN+v0gW83oLdTVTTJDEuid9CNC7c2ABvopNJNoscs9UOCr1ugNTneTMEztrvDTT/kAtA0eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621970; c=relaxed/simple;
	bh=PPdf1strXqevKfvsGfnrho0sQtNLKGNkMc6qPa3vhTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ge+yZ8ownZqwbh3WG+0NjettSHCI5HGLO1V5I9cd0uCUs5m3e50d/7mFHAgkcEB8kpITr4tlt2i2Ar73V0mc8r8JKeajUmx2aWpiBESWi2i2zXzfJY29DjawOPeOobhm/XjJaYlYtkHjJxYRB1s0xewb2ULH5taNskY5PPin72Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Owe7tokX; arc=fail smtp.client-ip=40.107.162.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeM1hf77LXiiHw+VZ8mtvKn4T3GZCvAOYcFk5A/85k/m53n34Ve8YeJ1dTwBup8OQy8VCwh8SkhurbObtVN83aEZFDStT8ECe2rzCz+EB7W4kidTHBnk+UnychatiVtxs5XeE6r/pv2UtLUpKMCBLmnoHi0DcQ6vdkTUzJo41k40TnUqbd6Y01jbVbCrCWhAF8fNdtaYMEqP3gH2GhvfJITmEUMnw1ar8DFJ3MG58V+N74m6WN9TShsKh0+shJcxyoKJlFd/mmN0C19c5gXj9hDHJR5rB6Ctyf7WB7lI+mRBUDvelJDbHd+h14AGKVpQEdfY+ncoL3qrgN0WLBFrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPdf1strXqevKfvsGfnrho0sQtNLKGNkMc6qPa3vhTE=;
 b=emwj5Q+j5C6GGko5yKSx/l9wRKf3rmfs9R72gLsQ0Wi/uw0KDm4tMyfnduIjT7UjbQSEdV/oIFnXUGjEyJCi91y9liiP8bxNKnuIKLTxyeI2rk+FovwOEz7KBFSACMoAqf+O6Hya3GZpG3qzufAqpw9T+QqhCLhUeFVhYaxH9E5r0CKHPLvktqOd+8BSyRhbaPQvgr51QIzYjnNOePVR8xmugOu+KFI9GwM0iGEuTlS9YmKUNGnwlmXerNPy+QjR+3jEvJdcLQ1TAiBewQV2gL3iuc7WUAwc04gp5GKfEC8k3hboZpMvTWheE11PL/IYY5XNUB0bCcK3BK71JE7jZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPdf1strXqevKfvsGfnrho0sQtNLKGNkMc6qPa3vhTE=;
 b=Owe7tokXC7hU2FDabY3HcwiJenVLMHCahLVMRU3jebqF5kDCR2DH0ssjua57BAxqn13VuJVsqSvCfxtP6RT8ZTWcG+qOLN7rh8jufjpVS1aDdqakm2D7JOT5ckIKy0MAj5c2zVs4a9VDtvNIPJQpjeFaE6DtUg49SwrmN+kfVbPyYdtbZJYSREn/30eKX5d0blgq36rNN5BtTk4zPhPnDqo4cq+NwzOAZO8XKOEvFjTKi2ToRysDonw5d3iv/69rjSFxU0TtBW8QL5FnMvIfa+Z+uRHqCLRZNcqY6uKxSC3jnzPr/0/q4hpv8tYWs/dX3zPZL87/IHM/nOaMgUgnkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10321.eurprd08.prod.outlook.com (2603:10a6:20b:5e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 13:39:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 13:39:22 +0000
Message-ID: <177bcba2-2358-424a-a22c-9bd8b42cbeae@iopsys.eu>
Date: Thu, 16 Oct 2025 16:39:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/16] spi: airoha: remove unnecessary restriction
 length
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <20251012121707.2296160-3-mikhail.kshevetskiy@iopsys.eu>
 <dbefe024-9b5c-4531-abb9-a1a7e9d3d769@sirena.org.uk>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <dbefe024-9b5c-4531-abb9-a1a7e9d3d769@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0019.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0b2bce-20b5-4ad3-d523-08de0cb969c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmZaODFPSU5VKzVtT2FheEcwckl4WjduYXgyWHhvM0ZocGRqQmN2b21Qcndr?=
 =?utf-8?B?eG4vZjhBUUxSbmZjUGZlR1pxT2dhQzZUK0RIWTY4aTAyZEYxa0svQmk4YjRV?=
 =?utf-8?B?S25nUHdsd2dMSlpGRjNheXdDMER0WHY0a3k3dnhoaUlkV2dkQ045OEtqZHdH?=
 =?utf-8?B?cXFmL3R3QzBpa0g4WXlveU9WeWdWL1NaY1dBMXZ4ZzYxeWd6SmllSjlpRHdH?=
 =?utf-8?B?Q0RuVFhQQlVhV2xvVXNIQmlSR01EUE52RmRSNG1BaGR3Q2RMUmg5M1dQZW5T?=
 =?utf-8?B?M3lxUWtMeDhQMUhGM1BlV0dNdzE2cHk0Tjc5MFFMWUNUV2pxa1RIcEtVbUlO?=
 =?utf-8?B?RlZxaEp5c3VSUGJxbkhBampsRnVMWDEzZklvRnBsUXdkK0ZDaUNEU2dDWjdu?=
 =?utf-8?B?UURYWnBaMW1IWExxRGN2aWhqL0JGZFBHMUlleHhDdzFFTkFOcnFFeElrTFlW?=
 =?utf-8?B?M0pzMlJYQkJ2UFpwWStaTllyVTh6di9XSFgwQWxFeWQ3Y2YyNWs3NWFSMmNu?=
 =?utf-8?B?c1pHb09VT2cxVHRRWCtNKzk1d21TVitnZkttcGFlcGI4WW9oNVJLRk0zSExL?=
 =?utf-8?B?b1NYaWw0b2Y5YUJjSWQ0SWF3WXZnc2U0RThJREZrb05PR3ZVRU1hcVVSTmVs?=
 =?utf-8?B?TDlzbXRjNHAxV1NzdnlkbFhqUm1jM1FtZVU3cmVzNFppM2xtY3FtSU11bDJL?=
 =?utf-8?B?SFBDN1JzWitwMEF5L0xYSlVxOHV3ZmZwYWtLQWlkRWNsU213ZGhIazNQdkJz?=
 =?utf-8?B?SEpSYkEvUStHbnlwTUtQNithcVFaMXo3c2ZTUnhxY0lWTVlWdmYwQW1EcWFo?=
 =?utf-8?B?NjQyS0NGUFNFSGFMcm1CNmNOMlNlRnFJam9RRTRldUhKdGxRWGRORHUyeFpk?=
 =?utf-8?B?aVJsYWZ0cGUwa0pWNVFqS3BhRzIxUVQ4UmJrVzJocndENG4xTDZqVGlCQ2Fx?=
 =?utf-8?B?NzJrbmVnNFVyRnlEeUVCOW1Jc1Y5VTFPMmVURTQwd3ZvUGJleSs4eWNYUFpq?=
 =?utf-8?B?QlFRVk5SYWEyeHMyRzdvbnk0TExLK053aFFweEU1ZFRZMy9wbDh4c1ZkU0FH?=
 =?utf-8?B?NEY0cmZGMVcrQU43dzg1MGw3Wlo3NTc1YllTR3ZpUUVUSi9MMUhFdGpvWjA4?=
 =?utf-8?B?V3hEdyt1R28zY0wvTjdRS2NENFQ4RkFwR0xyZUNhSXFnR0FnQ2Y3RE9WempN?=
 =?utf-8?B?M0hCblZqZmJReEhNcURrYTdWOUswTGdsSGpmMnhxTkw5WXI3RlFUWTZBaVlL?=
 =?utf-8?B?LzN5Q1pQSWIzdHZoTExVVGZKd3JTWVBHUTVwcGNQRVI2eExxOTZ3R0p0aTFj?=
 =?utf-8?B?QjlYaklWc0dzY09LWDdPNjhEZVRLWldOYzlDUzEvUnRLZHgyL3dHVTRGbC9z?=
 =?utf-8?B?QldEMlhvZkU1WkVLcEZYZU5ycm5yeUpMVUtieHh3eit6NnNUSjBNZDNld1Vk?=
 =?utf-8?B?V2JSOFN5VmY0MVdSdjhhRXoyOHpPanZSdTNkcTZJY3Ezb1RBdGhaSkJPRjZE?=
 =?utf-8?B?RXRtQ0xJemtpc3ExUkVCSlgvdlFDckJzUVR6NFcyaWN3Lzdlb2taQXRYR0FQ?=
 =?utf-8?B?QkdYWEkrSGl1aXJkUVRsOGUrT1kxckZ2QUdmNThKVDUyVnFYWEN3dGduWWpv?=
 =?utf-8?B?c2tYY2xOR21BcnRKNTIzU3VUeGdjMzhzV0dGZkt6WWFUZWZUeG4vOWtnSVVa?=
 =?utf-8?B?NWl6cmx5SUhTNHUrVGh4Tk5mclJaRCs2aHJVcXZ4c0tVZWtMVFRFcFdTUTdu?=
 =?utf-8?B?UXhSRnR0aWhOYmx6VWhtMXljblQrclVRL0NsMDR4S3VsNjhxUFUrMERhZDBv?=
 =?utf-8?B?Y25iUTFEb1k4amIzdGcxc3d2SldZV0VXNlpBdmZVRmVHK3hPSklVVXdVNkow?=
 =?utf-8?B?WXZmSldJV3dIT3NzcHFSMGtXMDZPVHZFaFlRbUNmRWtVajVSYnUrR3VNcXN3?=
 =?utf-8?Q?dwhDByNxFgNq3D6JRWnKdiZBJtvPj0Hh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzVERC9zSStreUwzOFM3bDl1WHdMQmg2Yjh0MWtxZU5VcTFQQzFtNk9ISVk1?=
 =?utf-8?B?WC9mYkJEeTlzY2NxSyt4SXMvUzZxVjRxNzVqY2VqQWx4N2JBb3J3OHRUQU1Q?=
 =?utf-8?B?VzdlM1NiRFUxQVRTaWdFWFE0dzlmMENCZ2RWeXQvTnVNTDJPaFloQi9YUXA2?=
 =?utf-8?B?ZDRqdEZlZ2JsczRObUJLNWNjeW9KSjJVbklScnkvUm0yTmdaWTZCQ21yQW5H?=
 =?utf-8?B?QWc3RWtuWTVQUEJxM0lwRW1DR0lrai85MWkzbWUzRkFFTHdiWXJLbnp4KytR?=
 =?utf-8?B?U1JMNW5rL3hoTHFZYUlaVDdXVmorYUtQRDE0cG56U1JvbjVXaGRTM1NwLzdW?=
 =?utf-8?B?Q1RoSGR2V0xNRmovWmZJOEM2ZDZMU2N5dHlaWmtqMFQydXNsbzZUVTNCMnNU?=
 =?utf-8?B?QWd0MXk2SCtxN1JRRHFXMUZxRTN0OTExZFV4cmZGKzFveWZkdDAxQTJzUmkr?=
 =?utf-8?B?T3FsOEhuMjZTcmV3bHQ5M1o1UVVDMWdaMWFwMDc4U2lWREdUcC9GM3Q2a3Yw?=
 =?utf-8?B?MTBWQXdSRGVqUDRxbEdCY2EvdEovREliazFvOXVIUkVmV0UzdE9YYkFLbVJD?=
 =?utf-8?B?b2JWR0N1SzlFeGh4ekVaZk5ieWh1cVBKU0FxSHd3a01MUEJpaFR6eE1VdXpq?=
 =?utf-8?B?UlI0MTI1VU1wZ3NQdlh6LytzZXorMWJ1OStkMFVoelFraW1yRmRSVTkvc09T?=
 =?utf-8?B?MDJJSXdnUEFma2pRUHB0T1FhVlpZb3BtSi9PS3RiQS8zSnRScGhydTBCWnY3?=
 =?utf-8?B?OG4rL1JnaTNvS3FXcGFQS1RRWXFyeHIzYTBaaUwwV09YUFVtR0dVY2dSeEhC?=
 =?utf-8?B?elJ5U3JkYm9zcndwdmZPSkwvaFhpaENKa1NwZW1YUkhGd0x5T1ZOeGt3SnFJ?=
 =?utf-8?B?VjhHSVphMHRHZmxMbGdwZUp4cmkxTm5PU28xRmdueXNBVHdDVHBtNitWUStK?=
 =?utf-8?B?SCtFUXBaM1UzNTNrczRnckRJaERGc3dEMFkvRWg4cXV0WkxDdURUam5XNU55?=
 =?utf-8?B?WmlZSWdzRERrS0lleFNJc3hBallzRElmMVY3SDduaW9FZ3c1RmduNkxhRkhT?=
 =?utf-8?B?bXJ5cjUxcFFIRGwzS0VqS3k0NDkzUjFNd2JJS3Vma0pDanZOWjJDYmhKdjZl?=
 =?utf-8?B?a2x0VkhpOS9ZaEdBaUlyTU1hY21LYzNselRQaU5ud3B4bGNZTW8rK2l0ZmhU?=
 =?utf-8?B?SU91eWdEbnNrdWxxRG1yRUVvbUZlY2NnQ0Exam5FRjNNb3NZcFRBTEY0SEF3?=
 =?utf-8?B?eHk1OVNoOVhEV3paeHk2MnpkaHZzSWp2eW8rSllHWnM3dkNxMjJBTnJPcWpV?=
 =?utf-8?B?KzFtUTFuWnNGVlo4RU1NTWluUUk3Yzg4N2FMUjFIa215emlTcmR3RFU4TEtW?=
 =?utf-8?B?OVZvZW90NFc3SXE0TFlGblFUN2dGSEppckxESHlPVTFXTUpZaFNXRHVXK1p3?=
 =?utf-8?B?ZnllcnAyMmdoR25Nb0tQdXN1b1JIb24yYk1XSHlmaTBKMHVmemxmWEdQWGFY?=
 =?utf-8?B?cmN5SE1uRkJnK2ZHTUlyenhPYXFGTGVLYkl3Y2VRYW8rdXROem1ETWNTZTdi?=
 =?utf-8?B?bVhhUHF0NUt3d2Q1U0orZkFZZ2dVNm8yQ0JlV1QreDZVOVFkcm9Lb041TlZM?=
 =?utf-8?B?dDRrR3Y1NDVhZWVoQkFBWWMvVUp4TFM3R1Q3YksvRm1oSk1pSkNld2cvUG5t?=
 =?utf-8?B?UEV2U0xjTGE1Q0EvUms2WWRLdFREVjREbDZlT2J2Q1pZVGtRTnJLSmM0cWNn?=
 =?utf-8?B?T2h1bkFxV2ZmcjFsMkZKZFdGMWNwZytPdW8vSE8zbkQ2MzFhcWVUQUl4ZS9t?=
 =?utf-8?B?ci9QWXhSUm9HazJUYUtmb2FBbzl2SUlvYzlIVHZ1VUpKRjFBbVd6Zk5LZkpG?=
 =?utf-8?B?QmIybjJkTU54NGtKTnRvWUhSTnU0UHBRTVFsYTI2U1plVmJWWHhqRFg0RXlm?=
 =?utf-8?B?ejM2SlhJN3NGellhUGNoTThqa0NSWXlRUHNQOUhKVytCaG0rZGR5MWcvaTFE?=
 =?utf-8?B?Q2o0WlRVU1VHVUwwS1U2SDBESk92bUlGSWQxVDlHekkzZk0zdnhkRmh1R25N?=
 =?utf-8?B?Mzd2QTRVemNSbVYyaExrekxaaG5VV3podGJFSjR2K21wWU5XN3BIT2tNNW5N?=
 =?utf-8?B?cjh4YnZPT25MUm5JYXQvNWQyTlN2VlkxdjdUcjRzcm9Md0JGUDBVN3M0Mmpw?=
 =?utf-8?Q?khMwH3hOyIzuaClcXdr5tgU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b2bce-20b5-4ad3-d523-08de0cb969c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:39:21.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyWUYzquHp/LGB7SkbqeXlC33CUlaNF81wyyFgjZxtwv03A3hyPKx3fbmlbv0c9nxubr7rzt4R6tviPNX2oKc6gQtQ+rBqv60DO4WHjbaqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10321

On 10/16/25 15:04, Mark Brown wrote:
> On Sun, Oct 12, 2025 at 03:16:53PM +0300, Mikhail Kshevetskiy wrote:
>> The "length < 160" restriction is not needed because airoha_snand_write_data()
>> and airoha_snand_read_data() will properly handle data transfers above
>> SPI_MAX_TRANSFER_SIZE.
> Non-fix changes should be after fixes so there aren't any spurious
> dependencies.

Could you give me an advice?

This patch series consist of:
1) bug fixes (patches 1, 3, 5, 6, 13)
2) removing of boot related dirty hack, absolutely necessary for older
kernels (patch 12 and preparation patches 9-11)
3) improvements (patches: 2, 8)
4) cleanups (patches: 4, 7)
5) support of en7523 SoC (patches: 14-16)

What will be the best order of changes?

Regards,
Mikhail Kshevetskiy


