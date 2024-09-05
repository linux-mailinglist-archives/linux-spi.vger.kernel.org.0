Return-Path: <linux-spi+bounces-4648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DA96CC64
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038171F21552
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 01:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B00C2ED;
	Thu,  5 Sep 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJPap6MY"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CF946F;
	Thu,  5 Sep 2024 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500950; cv=fail; b=YQS+qUTZ+ZQ/ErOg/ddXOJKrC5QuWeswca0oYmIqaTxrmqk9Jubowx9PXbzjpChty92TaOf6Lnloum8kBcUErLRBprgnHgISL6qz0piPHHEHGWLMw5+00J3s3Ld/JLCeAOP/YdG3ZUqW2fdfB6znO32FduraJZWgl6fmv08MweM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500950; c=relaxed/simple;
	bh=Xuj3dPxS+oPicNqy8javJvjcQwaQPmSLRzZ01XDIrhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekFQ4RUdUW4X+JnttHhBTURc7VC5W+93yBeTF8K/DyAMM24g/MPOHHrgFRM4rsi+lz4dt+nEdJK39p/jqYFBIDCpAmGQtFyORoc0ndKHGMDE1RjkMenC14lslYdvB8O2xFFI9Sl4jToWdU0U7JjBIyBbeDw5FTrgE/eGk34sLYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nJPap6MY; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcjZHSmoJodyKsFLRONp9VIKOnmeEFZEoBgAs4OHutCTjZgEfQIpNXYD3aFB0nl03mxYDJCtI5Met4rk+XVBK0bLPdYmN7JhXNkBgjU0FOe1wouWoCPAA+T+Vf2ImojoT5k4mv3qNwRK8SDPao91opTPJYtDLg0DvNy5qJPxAQ8c+vHrSHFabgIYqxeZdh7PjLNl5K1o3tNqbIhNDvArgamEq7RPiG0hDLOyUFANTMg9y0btE9Dmmaw8DOH5+QdlNetiH6xBDjLIZ0nuqZTUAJDleglXfWLkW8CW/z08dH50UDBBiIDKqklvBajS5YIFCO41J30KHtR7cNDWJu7xmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xuj3dPxS+oPicNqy8javJvjcQwaQPmSLRzZ01XDIrhI=;
 b=jleXXqcpPNYLKrnsTbWRzEcr9Rq36aUnbuM9YiYK4M9jc0N7TMD1NBhSs9yYU5Ryb09fB8k8a5g791M25Jz5hqwR0DZWx+xJDMBBJqfc8sUX1Qr0v/fPQ9sBE/PWppK3FHvvgNcvstNPjR9mS0RACBwRO6U0NN0eZSp6Ft4nT4dv/Xc9VBkNby1fGg8baYftnoJWPCdxWkc44+i4G/JPSM24D0fdRFurUn9F/FO/YrenAdGjQdktuk6/6l3z0aD8tnh3w4e85bSIE+IQgbgn38ySP5NVH33vAaFlMACskGvAHqm0NlyH5aFQKs2SOrhLdLbJyD7CtdQfXaP53EMy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xuj3dPxS+oPicNqy8javJvjcQwaQPmSLRzZ01XDIrhI=;
 b=nJPap6MY58TsuIZprCfepIJXgBlTbQ3Y599YrdDAb5raAv0Idm0gtPPPrfwis19ouo7mJUNh9rX8RPK1iNtKXAxYtae3ZLbyUuaeiJLTpLq41pW+ItkZsH6IBK3XRId25tAGOUAbcRQWzsjJDjnoF4FcffLqZ4cuZSTUZWumyRWSz06p1Cfidh1rkrC6aRbyaYccmepQ20VCWUUTbjw5LMTZA29KCZHRyuHqWaBIWMkRD7vrxNBpjUZVHRQN9m4/GmGQ4VyLhVjdnZTJUSoHeenE/LmEhrboGg8vISgS+tg6mEzTs56fIbS7SyH1rwvzRiqZSMOl4UDb0K6NzNThSw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10113.eurprd04.prod.outlook.com (2603:10a6:800:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 01:49:03 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:49:03 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Han Xu <han.xu@nxp.com>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>, "hs@denx.de"
	<hs@denx.de>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
Thread-Topic: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
Thread-Index: AQHa/zKZBqHzbVFLl0SLABwYA1cFarJIaisAgAACQVA=
Date: Thu, 5 Sep 2024 01:49:03 +0000
Message-ID:
 <DU0PR04MB9496D185069B3F9D3422BDAE909D2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
 <20240905012617.1864997-3-haibo.chen@nxp.com>
 <CAOMZO5ALKfz-w3taJBwCLu+pAnrcGaa-9=EtLH6FFJWBkq=t2g@mail.gmail.com>
In-Reply-To:
 <CAOMZO5ALKfz-w3taJBwCLu+pAnrcGaa-9=EtLH6FFJWBkq=t2g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI2PR04MB10113:EE_
x-ms-office365-filtering-correlation-id: 32a573cf-7eef-4ec7-f34d-08dccd4ceb9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUNTMExvODZDc2F5a0VCYVlHZGdJUlQ2UXpJMldpS0hyOVZ5L0pkZmFFcGVK?=
 =?utf-8?B?Qjl2SEluVzhsVFdQSW9yZlJnZFdmVlBmSzlYanBBVGE2OVgwMTFUbkhxWkpV?=
 =?utf-8?B?KzNpRCtyVkdSZFlDQUUzYm1hV3ZEZHpKcUhCSXdGOFF3b050d3FXdXk5TEJn?=
 =?utf-8?B?TVU1NktTOGNpMDlzU3ErM3JQQ2ZiaHJRbml4emUvSUNoa3JLM2dETzFsalJ1?=
 =?utf-8?B?bURnTW5JajJKUHZZSGs1dmQzTkhjczNyZ2VRL1VMUFZOUFNObGZXYS9PSGc2?=
 =?utf-8?B?YXBWR3cwWHA0Zm9oUk1QeVhxVjF3ZXh5dmdKbFUzNVlEdWpuT0ZVUUk2dGM1?=
 =?utf-8?B?eHF6czJlQklQVldNaEVnYWp5RVhFNU80N3hpU2l3STNvTlAzU2taU3ZrRk1T?=
 =?utf-8?B?cEFGdXdtVG9ISWZwQ1o0aG9Tazd1azk3akE2a3ZNVVZLaFI5MHIrVFBoSDN4?=
 =?utf-8?B?VENSN1BPVGpuNXZkUG1XRDlOQjNWK0FwVzcxYVpxUEJtTjg2Q0pucVJRc2ho?=
 =?utf-8?B?bG9BaldrOENhNWlOdjAzMG5rU1h3L2h4OFBwaFBJZHVhS21BM2hLbW91Wnc3?=
 =?utf-8?B?R1lFR2lVdHBWTlBCZUJBVnpMR3pHdUczZGdmeFE1TnlITlVRdGhXeFE4SVZz?=
 =?utf-8?B?SmdBdFNyVEtXTnozeDgrU3BMM0NxUU55Wi9DR3ptWXUxYU9ucXhLQUNDdFpU?=
 =?utf-8?B?SDFMNFRxU2dmc1NaU0Rhd0syN0NFeXdCS2xSNDhoVDBNWkplSGJCSEZmOCtY?=
 =?utf-8?B?QlFQUklSZVJ1ZkRCZjExZ3Zzc3pFWGhuR2dOV3VYRmU0QTlHTVZaSWFoNEhj?=
 =?utf-8?B?UDA2Ykg1TEI5aUtzeEJJRHRXdEVhcVNIMjJnMHhTN0lEem9YN25YTG1yWUNS?=
 =?utf-8?B?b1ZUSlE0U3MzZHJVdWdjdjRsNlgxd016b3lIK0k2eEZRUlJxRERidTRQK3Qw?=
 =?utf-8?B?enFRdVNWdVRTT2ZLM3FURlRqWUZ1V1RsUGZnN0JFV2hBZkVqejVhZE9PWHBh?=
 =?utf-8?B?bzVkVWpHamk4Ny9ZWmp3NkNXSXB5N1ExV0d5elZRMDZDNEc0SDAzYU13V2FY?=
 =?utf-8?B?eGRReHdBTUdOVlpmdkFhY25hK0dRMmZEUzhmeVBGVXdVcDhNeEZwcGJIRWZr?=
 =?utf-8?B?a2JWNHNSQURWWXpLenExWWFTSEg2Q3M4cktxRGJ6dWJPKzFJRk9vZjg4YlZE?=
 =?utf-8?B?QlBJdHY0SUVoNU9UV21ldlZ5eDNBNWJFTkxFMVpzKzdHdFlhdUFyUWlhYk9a?=
 =?utf-8?B?NTZzZjNMcFk2QVhMVE1KNEpFd0xXNHl4M1lQSEQwMlNXd2FFT3lhRUo0YlNa?=
 =?utf-8?B?SzdqR3VudDByWnVnMnUxaWtlcGY4ZW85Zld5anhESm9tUU5NNUJUZktJQWxr?=
 =?utf-8?B?cWdkUnVkZlhCb1ZjVlRIcHdhVitIL2swZ2hob2F6R1U0a1JuWXNmUE9QV2Jz?=
 =?utf-8?B?eXpYMHlMcmIvRzh1YzMzSlQ4VEZxeGwxNmFoZVQ1V1NNYmd6QnJiR2UwK1Jz?=
 =?utf-8?B?YWorTFhiYmFDdDA3WDlxSlh6U2lhUUJZYjdNRmZjbTlCSkg3MVN2L2xsRjRM?=
 =?utf-8?B?SHNEbDBIWTNqSzBVUEhWcDJ0UmtjUUM1KyttMFc4LytmeXJWcTNTNHF4UHRF?=
 =?utf-8?B?VWVYWmtoUW5iZFdOTTN1ZVZPY1d6TlRObHljZXZIMVpvWlN5ZkF1UFdZZ0pw?=
 =?utf-8?B?dk9URlBNcWpTbmNKOUlOWlF4WlNZNmZ6bUU4TEozZHRSKzRNbytkRzRsSExl?=
 =?utf-8?B?NWh4WGpvdktoUGZsZFBBZUpNZ0NCc2dnSmJsV2w5ZktjVDhGNmsvSHBJY3p3?=
 =?utf-8?B?RUFSYWRPbG1nZ1JXMHNDdlZOd3Njd014Q280VWlCYnVZazRsVktLL2ZCb0t1?=
 =?utf-8?B?ZDZJeUx1OE9jWjhuVjFDTU9KSU9rY29ML2tTb0FxMTB4V2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1BSK1M3Sy9Ga082WDIxV2xDSnFKN2o1dXBXRWRiUTdBUHYzTWprc0NRd3dp?=
 =?utf-8?B?VDRDZXo3Y1o5SndDNThCRmtGV1BnVU9XSVpuS0M0WnFRb1pGTFk0Q3lDR0Jm?=
 =?utf-8?B?OXl6bVM3SU93OUNXaUpPTnU0S3lidEl0aFc5cmhWN04zNTV1MGI2RkVYZEpz?=
 =?utf-8?B?M3Z3YkNjaG1Penhzcm1FZmM4aCtwOWl1SEtKS0x0T0xwZTZyeFlCZ1ZYaVdk?=
 =?utf-8?B?ZXkydWQ0ME4xN0tSVFRqWmxWbmwwbi82VGRLYXAzZ1ZMU21yektqTnU2cndo?=
 =?utf-8?B?UnVjdFlVMDViTmMvUzR3bDJrZWZuRUFiSysyVWMrL3V0REFDKzRQdWJoL3Ix?=
 =?utf-8?B?S2NTNytWZ3RMODA0WGY4T1g3WW5PRmFRdHRtcWZQQmJ4VThaaWpQSXppdmdZ?=
 =?utf-8?B?RVdiRGNMT2RmTzNUUHlSeTJ5M1NQaXc0UTRpckJ5V3FYRURKYzNWbXEzTUtQ?=
 =?utf-8?B?dHNBejF0WERTN2NqMW9yVkJpVEhDTDZFVUxJTlpHUDVIMjVzQUZzZEl6bUcr?=
 =?utf-8?B?SW1oY20yUDdiaVNnTTMveEdHSldxRHd6RDRUSkxTNEptZXpqZGd1NExYT1hy?=
 =?utf-8?B?VXhmS0VicTdvTzlvMktUTFVKbXA1cHU4ZjhBQ25RSHIySHp5K2s2a0o5L25u?=
 =?utf-8?B?LzlGcGRyU2hHcEh1dDNYL3JsR2s4d0ZyM2RMdzJWdzdDczRteU1MRXN6SXRq?=
 =?utf-8?B?d3RCaCttbGdEVXRlVXJEd1JvVDk2bTRCQ1A2dTdtNUkxNGJ4WTRhYThSNTJB?=
 =?utf-8?B?Mm1QK3l3eGRzNmxGUEVQSnh5c1NHOGIzYkc2VStVMUhpcXlPcis0TmJEWFpn?=
 =?utf-8?B?R1ExZVF3YWk2Vm12RThjYUpiNnd3UEY0cE5zczVndGh0SFdJUGRzalVXZFUz?=
 =?utf-8?B?UGtlOGN6UUg3NFQvSVFxUnBRK1ROajg4N1dZclRRWnBTR3lEMjArdSt5S0NK?=
 =?utf-8?B?TGlWZEJMTkRWM1JDa0FCeGhFelFuOHBNczg1TGxyK0k1VTVGSkZjbXJ1Y0g2?=
 =?utf-8?B?RER6NmhGNWRzRXhJTHZFT0ZUMDlYcXVScjRweGU3WnlPUm5mY29kR2RYaTZl?=
 =?utf-8?B?UkhZZ2FZNGdkMGhpT3dVRlFWZDBhR2xVN1dhWHZBN202SkNydk1SZFpGOWVn?=
 =?utf-8?B?emJ4dmtHeEcwem9MYXY5RWx2RU1McVQxZkdzelJOZFJxdEJ1TEpOSkpyK2E1?=
 =?utf-8?B?Vkx6SWM4WTU2RUJSS2xFbGFJYWZnd1NBMmppZkJUSW5oV1VPcjhpb25Qd0Ni?=
 =?utf-8?B?bGlTMEVsRTRwbDVJNVU3SFNkTHcxZmtuM1luR0E1NGNjZFFYbUV2RUo5RlQ3?=
 =?utf-8?B?NmE4dTNHTm45SXZaYjh4OGRCNHFXN3pOd1FDT09iQ2w0eDlLK21RM3lQam1E?=
 =?utf-8?B?Y0FwUWtVS1dzVVZISFo3b1RwenMyeU91cjBRdWlJSzUvWE1aRGRYWi9SSkdq?=
 =?utf-8?B?R2ZsV2t5WjYzdlRXRGR1YmN3VmhxSHdpc0YwZjg2YTdPUDUxNG50M29xTWkx?=
 =?utf-8?B?SHJvc1NoNksxUEFxRlU3clZHdnFlTlY0RVFpaE1Yd21QTER3WDFJSUg1L0Yv?=
 =?utf-8?B?YmZaeElGUVZMZnpZMmpFWjhHQ1pNK2RHLzkxdDRnMUNtNVRjNGRIaGNvOWJj?=
 =?utf-8?B?eHAwbFh6ZW5PZEd1M1QxR1pEcC9XTmlrMmUwRW5KbkNGSkM4R1VCcnpBUnd0?=
 =?utf-8?B?TTFoSVgrMVIvb1IwVHJDaTF4VjlzNEdheUNiRVBZbzcxb1hpbUp2dm84R2xy?=
 =?utf-8?B?Wlp5SVB6R011N2c0dTVFQ0pXeWJ5M1FZTGRySzhpRUFOby9yTEIrczdKTDFi?=
 =?utf-8?B?dW9PU3BJbkVBeFVnMDBIUzR5V0wzWjRMbHArYWxVQkZ6cHFWYmhmbUljaXJa?=
 =?utf-8?B?OWd1UlZYeVp1QllPaE4zamx6VzN1N3gzamZ2R3RrREt2SFZXckh4VThvTmZ2?=
 =?utf-8?B?ZWRpcjU3K0QxdVp5NWZ3RlJrMlZxcTRKUUtmaDhNVUQ5aUI0NFkrVm02Q1R1?=
 =?utf-8?B?ZmQ1RkZ6OGZwUDdWY1NZRTA1R0tsZG9FQ09Zdnc0UzBBLzhKN3o3ck1BLzl3?=
 =?utf-8?B?ekUxd2Q2Q3M2aDBaQlFxUjlYSTYyTnNGYlZLV0VVVGJ6RCtzZWZQMlNKekhH?=
 =?utf-8?Q?lN0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a573cf-7eef-4ec7-f34d-08dccd4ceb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 01:49:03.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BOW+9t6c/dU8gbcDTdtELYtZ/rZnIU7AYQWpOOr78UVV6B/QFNP5UfA67hHaW/MdEV1s6nQgxGP4c5of0W3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10113

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNOW5tDnmnIg15pelIDk6MzgNCj4gVG86IEJv
dWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEhhbiBYdSA8aGFuLnh1QG54cC5j
b20+OyB5b2dlc2hnYXVyLjgzQGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyByb2Jo
QGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBzaW5naC5rdWxkZWVwODdrQGdtYWlsLmNvbTsgaHNAZGVueC5kZTsNCj4g
bGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDIvM10gc3BpOiBmc3BpOiBhZGQgc3VwcG9ydCBmb3IgaW14OHVscA0KPiANCj4gSGkgSGFp
Ym8sDQo+IA0KPiBPbiBXZWQsIFNlcCA0LCAyMDI0IGF0IDEwOjI24oCvUE0gPGhhaWJvLmNoZW5A
bnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEBAIC0zNzMsNiArMzY3LDE2IEBAIHN0YXRpYyBzdHJ1
Y3QgbnhwX2ZzcGlfZGV2dHlwZV9kYXRhIGlteDhkeGxfZGF0YSA9DQo+IHsNCj4gPiAgICAgICAg
IC50eGZpZm8gPSBTWl8xSywgICAgICAgIC8qICgxMjggKiA2NCBiaXRzKSAgKi8NCj4gPiAgICAg
ICAgIC5haGJfYnVmX3NpemUgPSBTWl8ySywgIC8qICgyNTYgKiA2NCBiaXRzKSAgKi8NCj4gPiAg
ICAgICAgIC5xdWlya3MgPSBGU1BJX1FVSVJLX1VTRV9JUF9PTkxZLA0KPiA+ICsgICAgICAgLmx1
dF9udW0gPSAzMiwNCj4gPiArICAgICAgIC5saXR0bGVfZW5kaWFuID0gdHJ1ZSwgIC8qIGxpdHRs
ZS1lbmRpYW4gICAgKi8NCj4gDQo+IFRoZSBhZGRpdGlvbiBvZiBsaXR0bGVfZW5kaWFuIHRvIGlt
eDhkbCBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaC4NCg0KSGkgRmFiaW8sDQoNCkkgb25seSBh
ZGQgdGhlIC5sdXRfbnVtIGhlcmUsIGRvIG5vdCB0b3VjaCAubGV0dGxlX2VuZGlhbiBoZXJlLCBh
bmQgSSBhZGQgYW5vdGhlciA4dWxwIGluIHRoZSBmb2xsb3cgbGluZSwgYnV0IGZvcm1hdCBwYXRj
aCBzaG93IGluIHRoaXMgd2F5LiBBbnl0aGluZyBJIGNhbiBkbyB0byBhZGp1c3QgaG93IHRvIGZv
cm1hdCBwYXRjaD8NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBUaGUgY29tbWVu
dCBpcyBwb2ludGxlc3MgdG9vLg0K

