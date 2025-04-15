Return-Path: <linux-spi+bounces-7592-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200DA8956B
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67E03A9FAC
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552427A90B;
	Tue, 15 Apr 2025 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CdXiZx14"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010063.outbound.protection.outlook.com [52.101.229.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2527A13F;
	Tue, 15 Apr 2025 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702971; cv=fail; b=pru7lFy3JSxgp5c6n7Zy0bbK13ZmxKf0RFCp8vyUXKVV3edn0iPIHTvuVudWvm8FJJqthyzK/TvQ6lXyPdoIhNEesRBSCyp8Tw7iAMOOoX6H5c/S1y5nm3diUnMA0/2QyN+jQ4fIghFetXiiMiPzJNwGkpklFSze9q+O16DEbgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702971; c=relaxed/simple;
	bh=MbLT6MvfrL2svl+XlxkQWIfXHNPeYP4TDgKxUK6V4kI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=II3T3sNrTSn96rUK5tQsDDGbQ2mXkJWvx8044wxA+hcfHYXapbf8UdgYLDt8TArO3TUA+xWsfDIcQfv0WoI9++0rDpAdBddk9HNTchi8d95CWYHbJSqa8Lx6buQLW0tdru4SnZeKy4RLeRs8Wc2eiwHIw+U2FK3gNxQCENMwPAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CdXiZx14; arc=fail smtp.client-ip=52.101.229.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mokW5xEO+19F+M0uiTBgTnneBWZc8jwogqdjuJanrfWlst+waxhLrx66AZ/15CsLhVpY5TtD7hhAsxC71dxZkILLS3DuvN8KHjruskgZacS35E5BgOKLc8JKZv34XnIuTNdLdZ1ktz+n2fTJhvgsqQsBvltmEele71amJPXPxWbBkWBf9Gf9TZvhi/7dOoHHysKjO76Yd4IiDNXZJ3SltXA4UQNhiLZqbhxtdm8akNv+5Y23nNXRJVAzAzbiz56HtWLjTAeQ7jnIfaX9mtBlD9NO/eptyjSAAedKcL6qdbVbF22HYfWvZLDv28Mg5yNoqR9/IsnJfBbiCKvrpAxX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbLT6MvfrL2svl+XlxkQWIfXHNPeYP4TDgKxUK6V4kI=;
 b=mKxIjQVj+UnILHbUWCsxcOH6HK+UHiN4Sq7rnVkRa3M8c0nUonhYjrObDelNXUbX3sfvEr6QXhSFRyrS34oDaKCdOtni0insIk9qarWClylPR2C+LY4EJKN7Zk9Gvt99YxZUZRR/V4m+Im8Cq6DBsVET0mRhOhPs9B/N5ddVS1UsbmpAy1fjRJ9t3lzjVneBSnduScOB/JT8vqBM9ghmZ8+oXeAH+4K4kVn8153mUHNh8+CSzvGLYqKggFG1WpW4nLZOInItPoPZ3Is4aqeh7/THLu0a0gHT/S+naQt8+5sCPyZ+MrK3e5BjSOXDtek+pGQLK6qTM6O1EbWBLj0E/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbLT6MvfrL2svl+XlxkQWIfXHNPeYP4TDgKxUK6V4kI=;
 b=CdXiZx147gJrez8aDxNWva7F+gCK8b5tT9Laa0KM8mjwJiM/TcmdmYFVShIY+vZOGd/8HHs5qaBehYW+HKkhVbqBHDDjeq6gmmRzKOtfU0feBdTnjwVyTFp2Q/mvLhJ8Z/vne+s3f9ezF0pyntK1qvgoRY18L0bNKoOmIIORavY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14590.jpnprd01.prod.outlook.com (2603:1096:405:23d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 07:42:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 07:42:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 9/9] spi: rpc-if: Add write support for memory-mapped
 area
Thread-Topic: [PATCH v4 9/9] spi: rpc-if: Add write support for memory-mapped
 area
Thread-Index: AQHboxNq6R3Mo+M7FE6C8Pw16UUp6rOkUysAgAAaMiA=
Date: Tue, 15 Apr 2025 07:42:40 +0000
Message-ID:
 <TY3PR01MB11346E4256E4C18EED32EEFAA86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250401143537.224047-1-biju.das.jz@bp.renesas.com>
 <20250401143537.224047-10-biju.das.jz@bp.renesas.com>
 <5cefa668-8920-456b-ac82-0ce7f9226fcc@kernel.org>
In-Reply-To: <5cefa668-8920-456b-ac82-0ce7f9226fcc@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14590:EE_
x-ms-office365-filtering-correlation-id: ac581b18-c981-4a71-4625-08dd7bf119e9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkJ4cWZUL045OS9XZ3o4SU11QVhMR2RWWXhtbE4xb1JBcEM3cHFDTXhrQnFS?=
 =?utf-8?B?NWpYdWY0ZFY5dHFIRXkzcGVPVzFuclhYTjlsckFRQWJrenRuWnJmeEFOM3BL?=
 =?utf-8?B?bjJ3aTBvdENuZnlQQVNWNzRkalhkL3lUNWttT2dEbWxnWnlYcklNN0JTZEJH?=
 =?utf-8?B?cjVSUnRMa2NIOGpLa1V4bHJZYTl2LzhaMzZ6cDBuK3NhaTFtR292ZVVTMU1n?=
 =?utf-8?B?cldzSzhHbDE2THBPTmVEa2crVk1Mb3hyTk5pbTV5bDBwU0x1OXJnQW1qcWJ6?=
 =?utf-8?B?TjgxOElVSGJtQnVrSDBDVkRXU2xRMlEzVGlIN1o0cU01dlhIZGNhTHNaRG5p?=
 =?utf-8?B?QXd1MkwzZFJ4VkxZbklVWUlpR3BXa2FPT1NqanB1NEdZem1XSGRFTWlOZkpE?=
 =?utf-8?B?WFNNUUoyWFE2QWREVjluaG9xTnl0eXRGekhOYXlMMUlJcFd3Qmw5YlRSbVUv?=
 =?utf-8?B?azNBZWpudlhqWWxGTURyMGFaL2l5RXZOby9TV292dTZTa3BXVHNIeWRQbnNX?=
 =?utf-8?B?Vk9VWkpyWEZFMmNHNGRPcStXUzBRU2h2MzZ3R1EvbEU2NzlnRDNhS3VCV053?=
 =?utf-8?B?UDc0ODdHbkcxdFVpRkt2YVk5dm9KM21lLzZwNEM5cThTK3JzRkkvWnhZT2Ja?=
 =?utf-8?B?WVMrOXl1Z1gweHBpVjhDZEh5bmhtbEU5L25GOVJOdE5rUTc0eERodmlMYkFB?=
 =?utf-8?B?LzhLOFh4YkU3RHUvS1BTV2V5RytueW1uc0xnVFM5OXpSUnFtd24zNnNyWnRQ?=
 =?utf-8?B?Vk0yNmZkYk1WSmhoZndaSWtZR2w4d3BrWDFSQ0VjcHZ5aUlySnE0WXBBQ0pk?=
 =?utf-8?B?ckdHdXo0MGVtanZPZjdZSW9QaE1URGRhRmNCZEsrU0lBU01kRmpEN0NTSmFk?=
 =?utf-8?B?U1RJQllOYnRMTCtia1p2eS9XNGFxZUI0NE1IOGdlclhOc0tzRG9meStZRlJI?=
 =?utf-8?B?a2J1ZjlQdDUzZkpyU3ZjdDdhZFVSeWNuWE1JT1ErV3ZkZGhZR3k3WDcwNXhF?=
 =?utf-8?B?VmEra1lRL1RnZ3dFMHBCV1NyZ0RTb1cwU2lRekFRNFR1Z1pBTnNMNmtrWmR6?=
 =?utf-8?B?UnlSQi8zdDF1Z0UwMzlzMXJuTGVrazNxWk9YZW43UElRVWh1dERXMGxvNUdF?=
 =?utf-8?B?QWxKcUdOdmhXSjEzaXFneG1ZTEFCRDZKTjVxaXVBQ1NSVDYvNVlHeGl0eTRN?=
 =?utf-8?B?dWlIS0hDQ0VtN1FWcXBMYlJCTXVrd29HeDQvczJxd3V1QjVHbTE4Tmw2UDNr?=
 =?utf-8?B?dkxsRVgvRmF4VG9NTkMrMHBvczcyZXplQUczSkpDNXUwcVJaais4MFk4NVRq?=
 =?utf-8?B?Y0VSU1dqZkhWVFlFeFRRRDZNdFR4ejdkMGRrKzhsTEVwNit6aTZNb0ZPdkFz?=
 =?utf-8?B?U1JGMlZZRDlUbndxeDFqRDFRMnN3aFF6RWd4Y2daMnhQeG5kZHBmVlZFMU5Q?=
 =?utf-8?B?NGh3WjdzT1hMQmFiRWFMakNlYUxnQXVpanQybTRHTS95M1lpVXBLUzJzVmpk?=
 =?utf-8?B?TWFYb0JncVFoNHRzWkZWOU5mckdTYjRVYzVBWXhFSXFvTG94aThYS3hFOTlG?=
 =?utf-8?B?cHBVWFZiUUNza1RaMTVoWU83QWFQOFg0cytKb0tZMnp5dzBaWFMwV3VRU3hS?=
 =?utf-8?B?VkdwaFhIZ28wdXVnSEV0L005S1Y4WSt4c01Mb0VsVUQyM0YwWVQ4Y3Vxdmsy?=
 =?utf-8?B?ODdOV0FVdXVOVjZaVDlwYnRHOGwwSk9meFpRYXZWZmFhYUNjNXJHd1grUFJ5?=
 =?utf-8?B?R3dJVVQxUEV3OWcwNkNaTnVpK3VmTllIcG03UkJVZk91a3EvTmc3MjNYQzVJ?=
 =?utf-8?B?S09RcTExb3A4VTc3MHQvRGUvcEVuY09Ma0o2ZVM0bWpHS2dGMDVUbllFcDlX?=
 =?utf-8?B?SEtWTEluTkRKRnRZQWdvVkpVZWNYTEptQ0RZYW03Wm1pYUdVQ3FBQ1YxRlo0?=
 =?utf-8?B?bXhSZ2FSTHlGbW82NTg2UkkyelUyU21KLzBKTlZGSTVoYUpZejRBYURXWE5y?=
 =?utf-8?B?RGsvOVZia2JnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHVnS2pkc3NNNysyRXF1TmswUEE4WTd3WG03WFh1QXVpZU5HczBsRk5HeFJ2?=
 =?utf-8?B?WVFCS1V4b3dWVW9PNVN1S090eFlsd2NmaWFrczB3ZWZDVlFuSEhtRXRWUVI1?=
 =?utf-8?B?Ym9XMjRIZE9BL3lhZHV6RVpza05CcnhLK1g3blFncXorNTJueWl0blhEbzFL?=
 =?utf-8?B?b051YTA2TnJrN3hsQ215TEZJOVdpbXhwbjliUGZhYmJ5TEZ6ZXNhbmlaU0RJ?=
 =?utf-8?B?WGhERlhrRzZwOGp3WkVnMUxPSk1LUjl1V2tiY2JQbnB6NGRTcmlzSlJqbEox?=
 =?utf-8?B?RGxFZXRZZnBCUWNUU2pBazV1VDUyQkNUNktGbWo0SDI2d1VyTTlkQzI4STdl?=
 =?utf-8?B?a3JOaW1wWUh5VUNucmVYa24vZUswbDlieHBSdnFqcHZwVzBQclhnL09RVEJm?=
 =?utf-8?B?RzF5d2lkZEpHNWdDR3laV08rNTdVVGhjMjRjVkc2N05WOVBHMVBoTXJmclgw?=
 =?utf-8?B?MEs2a0xncVQ1TEcwc1FmRzNaQ0tET1NiU1lWbnFFS01Ud0pUL3A2dFQ2cnV3?=
 =?utf-8?B?Q203TXNTRWNPWlF6OVBESXlTbzdYaGZic1NiT1g0NU1GMjBZS0d4TTUvcG9D?=
 =?utf-8?B?MnlsNEpKaHlPMFlCaHJ5Q3IzTm1HUUhqQk12RUdCRlhwalRab1NVNHpRVEtO?=
 =?utf-8?B?WlFRQ2RVbW8xUFh0Q3FrcGVmbFNiM3J2dEFTcXU1cEowbjEvNzBPU2NsWHVU?=
 =?utf-8?B?QmxyNGpxdTFkSmdJTUdSeE1yNkkzRDV2VldtQUU0amt2VXBOOHhOeEJWd256?=
 =?utf-8?B?VUMwNVp6WTZIRFo3REd2RlJBVzEyWVlYZW5GeUc1R0hlNjNPWm9IWU9wd2Ez?=
 =?utf-8?B?akI3S3lIVmtWNW8wbEhPU2xKZUgzZXRQQmVHc3hmcEdyQVprNEZOUjkyV0pT?=
 =?utf-8?B?UWRNSjhmTVNGZ3FxMkdBemJMYWxuRnFPMGhFVkd6K0syZ1lWZVAySlpic2tV?=
 =?utf-8?B?Vkw4T1lZR0o0eGVrajlldXVCUENwNXZuM1FZbjNSblFjU3c1cW9Va3RQR1E2?=
 =?utf-8?B?dHlUdXdzR1laVlYxcFBOYzJnMkEwclNOQ0h4cThpekJJUWp3MkJTN0NteXo5?=
 =?utf-8?B?YXRsVHVEeGs0eWlHbk9RUXUzUzQ5WVFoWlZCbkVtZG1kRFg3YlhlNkFmOE1E?=
 =?utf-8?B?LyswL2xIcXNHMjgxcVlPT3ppeURsUlNsYlZkdTA0bGpYc1RFMGhpWW1MSjB6?=
 =?utf-8?B?d2hkMDhQRkxVMHhMMkh5MCtsMUNCNzdBWlBEZDQ5YW1EWWF5L2hGSGQvbFQ4?=
 =?utf-8?B?SEQxb3lEekVMRHlyUGZvMFR5Q3NCMm5QZVR3UlNBUXdqMHZYMm9RSUx1S1Zq?=
 =?utf-8?B?LytSbEhNb3h4aVJBN1I1UkhGUFVLRWpRVk11TUI3bkp0NFhEblBpK3pXb0NL?=
 =?utf-8?B?eldhblV5bzJlMUsyTktJT2M1UTV5Qkd6U1ArVE9WcEgyck5aa3A2TEtYbU43?=
 =?utf-8?B?OE9STUsxeFVuNXkzTVRaa0hDS0plOGVnc0pYOXQxaFN0RkdPaHBYdXhjVWlZ?=
 =?utf-8?B?MjFBcktzcHlIRjFEdzNhVkFzZ3l4VkJXTFJDT1MvL2hOdGdGTEI0bDRBNkJE?=
 =?utf-8?B?blEycGxBejVSRUhyMTRkeGZxbWJYcUJnR3RVcGJYSkxJeHF3MmcyczBESDJs?=
 =?utf-8?B?SVdTNHV3KzlqTkhheGY0YWEvYklNeHRzSFJnaDNrWVU4YnVseEtBNUxiQml6?=
 =?utf-8?B?UXF6eHFBT0lVT3R0R3d1T3lDa3ZLNkNlOHdNUG9YQTZsWW1VbFlIS3A0SDYv?=
 =?utf-8?B?TThJUUlhNUJqVWRKOTBPV3FXa1FzaEh0bkFscVQrWmpGMTM2SExyODNXckN5?=
 =?utf-8?B?ck1WUThtUzJER2pTMzFqNm1sOHhNdTV2MkcxTHlLZW56VmpYSmFDR0w5NTkw?=
 =?utf-8?B?Wm0vY01LNGtTcGR1WU9FZjlBRkIrYWNwMGNNN0ZZRjB6akZmZG4wMW9jbk0w?=
 =?utf-8?B?eVE1S081c1IvQjlnNWcrTXNDY2VRcG5FT1JNVVpsMk9QMTFBWXdPVHc5YWhO?=
 =?utf-8?B?cm9iL01mNGdzdmxoNW85K1M0UlAvZml1UXJQanExOEZaQm9FL2JFM0JNeFVm?=
 =?utf-8?B?dEQzQU0yekZDT0ZEMHdnMDRzTmVjTm9OOFNtOE5QRVorUUZPOWFqUlh3akgx?=
 =?utf-8?B?K25WNUVieDVjRUh6bWk4SEk3SnZyR3Y4VGVwemIvT3dGdDNSYjFCT1RsSFgv?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac581b18-c981-4a71-4625-08dd7bf119e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 07:42:40.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hth0jBSxeFmpKEu3WI80grLf46hUHJT3dE5McEwKmhHqN79Pf36jbTXUi9NPA4ECXmzzGuMsYbFbHDAaqJ+R7lqI2Ut8zwdNw9d2dIvuL9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14590

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAxNSBBcHJpbCAyMDI1IDA3OjA3DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgOS85XSBzcGk6IHJwYy1pZjogQWRkIHdyaXRlIHN1cHBvcnQgZm9yIG1l
bW9yeS1tYXBwZWQgYXJlYQ0KPiANCj4gT24gMDEvMDQvMjAyNSAxNjozNSwgQmlqdSBEYXMgd3Jv
dGU6DQo+ID4gQWRkIHdyaXRlIHN1cHBvcnQgZm9yIG1lbW9yeS1tYXBwZWQgYXJlYSBhcyB4U1BJ
IGludGVyZmFjZSByZXF1aXJlIGl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYzLT52NDoNCj4gPiAg
KiBObyBjaGFuZ2UuDQo+ID4gdjItPnYzOg0KPiA+ICAqIE5vIGNoYW5nZS4NCj4gPiB2MS0+djI6
DQo+ID4gICogTm8gY2hhbmdlLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NwaS9zcGktcnBjLWlm
LmMgfCAxNiArKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IFRoYXQncyBhbHNvIHVucmVsYXRlZCBjaGFuZ2UgdG8g
bWVtb3J5IGNvbnRyb2xsZXIuIENvdmVyIGxldHRlciBleHBsYWlucyBub3RoaW5nIGFib3V0IGRl
cGVuZGVuY2llcw0KPiBhbmQgbWVyZ2luZyAoY2hlY2tlZCBmZXcgZmlyc3QgbGluZXMgd2hlcmUg
dGhpcyBzaG91bGQgYmUgZG9jdW1lbnRlZCkuDQoNClRoYW5rcywgSSBtaXNzZWQgdGhhdC4gSSB3
aWxsIHVwZGF0ZSB0aGUgY292ZXIgbGV0dGVyIGZvciBtZXJnZSBkZXBlbmRlbmN5Lg0KDQpDaGVl
cnMsDQpCaWp1DQo=

