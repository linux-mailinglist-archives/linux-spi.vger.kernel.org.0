Return-Path: <linux-spi+bounces-11266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D0C6704D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 03:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 605E94E1B06
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 02:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78061C861A;
	Tue, 18 Nov 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7fWOVgI"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1C2F690F;
	Tue, 18 Nov 2025 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432968; cv=fail; b=h/GzNw1RScfU5ecNu0bwGGRCF9F+8dn7JtnQb4IPmzWJS+H9lvLt6v3CM9MkCQn7GcSJc4rs0okG6f33vPGaytYQ89myhJrCPZS+2kRAhay7t/cFztadJYavsXhL8fQ2hIfl1yVOCnLkeQ+2KQS+8OtMxqmhu5pehQLlbxZd0ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432968; c=relaxed/simple;
	bh=XnYwP1yH89WBB8hUmdeJw7Som2H47VhPi2sdYmBTvBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWsMnPn61fhc+XRb81HSgAWaGsKGsxrQlbCR5h+SFC/XY8uMdAr4AuigG/y8muwYkP63GC27r6oULt9c6+4OfPH5gkR4whIrJTI940Y1NuuYAgBC3mVGdHDPoEJ/0tHDPcfNAlr8qkgbvxj0MadJJxXG0Sz25zkwV8l+R1N5r+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F7fWOVgI; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcPxSTrERajAcwMvoR8tdWQ5uct/1oWHelrUWM8Yn5pvoEJbm+Co13I3pBhchGTPOHsA21fcYHYIdmw94K0ApTaJnQHYC93Um5Je4sd97RKmTmE1uReFojUnaqiFCDSNDAmy4zg8GvervI9TjfFPZUBz/OUM/n2hirkG7CcL2kgzPY/Um4q3Jcj3O2Fy4HwZd7Yr2T68KAoZQLVSVIs14bQxJIuPiK8uusJFuzBie8KkTMeOYnELi2LqEmyf6P47LNbutD+kE/DtCSLUEsAY4+ixA93ixsC7w6JGW7zYeIcbtpcUbNAkHNmAZDARI1ebw8nm07wSHqtiqyWVxy6Tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnYwP1yH89WBB8hUmdeJw7Som2H47VhPi2sdYmBTvBQ=;
 b=NQkBmzZuh6g/EYMI7XpzetXdNOFbQBon0Os91C62h1L7cDaAPKzSAEC9pyI8XboHgh7dEb5LuZ/u6FPj3POEC9YLZrnXrred+ZW2LunLTpAVgxBv3E5WeVmEW3B8BvV37bSC8HnBpWMSujsbPwt0TBPF0JTaAIJCR1B0NF+jnE/vr0HGL2o8OrcHIk4wSeVsxOdti+ybXV6AK5eunKf3appevA1N/TeDXQGOUILGEoehDBpCufgevlAS1HuMtlfCHIFgCXuiOLpEOVpg2zWbzrpd1WUHk6Q1Xbi6RGI66HxkecaADsjiQmCnfiBWkJHVuhVMHZfmTg+ZnfSmhydCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnYwP1yH89WBB8hUmdeJw7Som2H47VhPi2sdYmBTvBQ=;
 b=F7fWOVgI5O8E06mJHN3hmEs63O0lQHrV+2MZ6rQAAc2/LoUaYg0poct3t9i+UOjVcsfXXqS2P2ddlTdi7+rdQhtpLl1sXtz2UeMV/uPTvVGDvRe1yNjvgN4/NBHztpjMgxrWBQ7yx6HRu9q7s4Z8WMJw0xjARmZJa+8mgvbd+7ZIkJHo51/CdadOCYgGpDwZGh4O8x3xuF8XhtEo4zcSgcXHhZA1rC05mH/ZlZxHCwZ55MdtnzvHRNDfHys1jrdADcGTF7tf6Mfp3nr8TH8mQ1zi1M0NYQGard+MWRK0vLovf+NYDiIGJEYmDHkJejL0iOCnH21ufh5AkIwnp9Wg3Q==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB11756.eurprd04.prod.outlook.com (2603:10a6:10:627::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 02:29:23 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 02:29:23 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Mark Brown <broonie@kernel.org>
CC: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/2] spi: add driver for NXP XSPI controller
Thread-Topic: [PATCH v2 2/2] spi: add driver for NXP XSPI controller
Thread-Index: AQHcV7HnX4oJQuIbPkeWW57OQSxyJrT3HxGAgACXkZA=
Date: Tue, 18 Nov 2025 02:29:22 +0000
Message-ID:
 <DU0PR04MB9496206DEF7F3C00BA2C493D90D6A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251117-xspi-v2-0-e651323993fe@nxp.com>
 <20251117-xspi-v2-2-e651323993fe@nxp.com> <aRtao9FoPug78T93@sirena.co.uk>
In-Reply-To: <aRtao9FoPug78T93@sirena.co.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU4PR04MB11756:EE_
x-ms-office365-filtering-correlation-id: 113535b9-75f8-4173-3257-08de264a4931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?a2VkcE5UVGhKbXFESFZYMi90WFVTeXBrNDUwNys4anlDemthUFo5TzF0cUZZ?=
 =?gb2312?B?S0ZFeEN0d0J4b1plMk0wMVZkVDVPSUQvZE4xSzlLU2QrbGtMUldLYlF4aktP?=
 =?gb2312?B?emV6Y3E3akdPaTVFYnVFVTJHNnBZbUtxeFFjN1E0cEhQVURReTVSVGtzbUpW?=
 =?gb2312?B?czFrczlCM0J3ZytjQWNyRE1ZOUdhR3BrY3lSSVlrT2FUVjRkWExTNjlZZ2l2?=
 =?gb2312?B?OThyUGxHbEtsYjREOU1sc21tMnFjcTVFbFVmc3ltc1ExazY4b0RSM0NDZThP?=
 =?gb2312?B?M0JSUzZjTlp4T2RFbExBZkpuM1pIVXJneE1VZ3h3Y2laR3FJcXQ3emI5S3k5?=
 =?gb2312?B?M1FIblBzNnNMb0VUaC8vSy9kc1Z0ZkV2ZVBHNUppYjVhNEJnZkFJVHFPZUxQ?=
 =?gb2312?B?Ukl2ZGNSL2QyMmN4Z3dxK0pacGRrTlZIL2RSQzF0elpHcVN6Y0pYdjZ3SVRN?=
 =?gb2312?B?dUpxbmVaQzN5V0tmSWUyeVZDbGZrSGlhazJ5Q0xDcmFxbGVpUGcxZ1EzdXlB?=
 =?gb2312?B?NEhCbXdUaURiZzY2SmVtVzBFZlR6WVhaMUNkRWVFY2x2QzFCWDNmbGUvaWhO?=
 =?gb2312?B?ZjlKWnNqY0tRQ0FJTysvTzJrU2ZxUFViZEZFeXMxaUxOdFR5SmhkT3hxaS9q?=
 =?gb2312?B?NEprTDNFaWJmZ3dUMHNLdllGaXY0OUtEUFVzYzZMdU9FdHlQVEo4OStTYjZH?=
 =?gb2312?B?OW1iTkExa3d1K0t4dlU0ZityUThROEthbmlrandvYjRrek9qTXlJZEpMSjlT?=
 =?gb2312?B?WGowUFpRenQxL2o4ZHYvakRDQ3Bjd21lNXgwYlh3TWtJNmhYclNibTVFcE42?=
 =?gb2312?B?VDBPSzFBd3owcGlSaTNUUmh5NXkyN21BdkdnSU15bTJSU1RnOFdNOU4wZUlm?=
 =?gb2312?B?Kzk0VTlBTGlDdlk2WGVXak1QeW9XZEVhMW1Kc2k4bUQwWW1iQi9oQmtzOHRq?=
 =?gb2312?B?UUsrWFlzOHRKRFpJMWNnL3YzVzRabWFSWDV0YlllYlFHQmpPNWpHcjV4Tk4v?=
 =?gb2312?B?MS85UTU4aHFJWkxJY3lFckdqbXlheG9KOXdmL2kzbC9kd3NsNWFoakFHNlBa?=
 =?gb2312?B?dnMxcUh6dUovL3lXTExrL3RLQXJWOFV3cEVGUE9FelBUUHpJbURlaVBZbDlD?=
 =?gb2312?B?dE5vM2ZTbjRKeDhPaHpmT1ZXSFJqUkxqZ01HRHJkeEJDTWlIS3hUVXpSK1FB?=
 =?gb2312?B?WVFIbG1LSW5ZUTZtaUZ6Y0hRZ2x4REplalE4WU1hZGZSbTVpcXJMRFNjSmwv?=
 =?gb2312?B?MUFFVTF2czRZUTBUZlo5anhKQmQxREE1MTNwbW93dFRmU0R1K0pXdm5KWTBm?=
 =?gb2312?B?aXplZEpBQ2t3bHVWRzdXZ3BTWSsrUWpvdkFNbjl3eFBPK2prWmVxY1hpWU5G?=
 =?gb2312?B?WUg0VUk5ZzE3UmxVSnNORlNzNjArRC9ESlhwVXUwWHBXNG5EOGFKWVJUcTda?=
 =?gb2312?B?WVJEYmtGTzcvMzdrZGhiTHBYQmF3dktrNkQ3d3kzZjBmZ3pvK20rN2Y3eGFO?=
 =?gb2312?B?MTM5V3hhZE1ZV09NbGxoSEdlcWhVaDJjL1A2Sk44eHQzYkZiY1g3QzRTZlM5?=
 =?gb2312?B?eE9WUm15bUtaYTE4aHV4MzJCWEhXUitlZW1Ca1dSR1BRS1Rvckl2STRnc2pS?=
 =?gb2312?B?K0VaM0krZ1U0V1FyaW5BMXRwcVNhL3ZCUlZlaVMyZFVyVmxyR29KdjFVTVVC?=
 =?gb2312?B?Z3czck8vd1BCZk5UWTdFS3RTaGMyOG1rU3Z0UkhqbE5zak91VWt1Y1M5cXNH?=
 =?gb2312?B?YWU0dmFORWdGM0dmSTloWUdCK1lGMWdGSVNiZ1BzNFhUOU80c2VVc0FxaXRG?=
 =?gb2312?B?WkZrU2pDZ2ZVWWZoVzJGeUZzdlRNUEljZ3Voa2YyQm1TYktlNVlTSnpjbkRO?=
 =?gb2312?B?YTZTWlR1ajhlcjNnRytBVit4ci9JSEQrZzN2RXB6Nk1NbDY4czhPUkdsRVlD?=
 =?gb2312?B?Ym5UVFlrYy9ORDUvOGJMbko0Qi9CbDV0TUgxZUtFRzExOC9VM0lGUWNZMVg2?=
 =?gb2312?B?Zmx1eDZqb2FoOGcvbVVmOXllT3U1VVd3MjBWRnJNM3JrTFQrbGFQSlJiS0Mx?=
 =?gb2312?Q?pKZvP8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WTJWdGZqSXFsSjhyKyswTGFFQlo2QjRXVjIzenU3MUpsZElRdlI4OWhhL2Nq?=
 =?gb2312?B?UGZKOHFTcmxtbHpFUkU3YkdWdm02RnpQUGplVE9NTnV6bE5sYW9pYi9BTkl5?=
 =?gb2312?B?dUtNZlRmaUw1ajJJdllWWi9RdGxDS1M3aWorOHFVNXp5Sk4vOUhHOCtGWE9n?=
 =?gb2312?B?TmI0MXZ6d3RpMjBNMytJeHd6N1p2SzAwL3JzcFFsbmlKaUJHLzdpMkFyeVVv?=
 =?gb2312?B?eTRoUzF4MkIzejhXU1JMNzRPNGZFYzBJNUFnbkVscDFaVFVwNlJ3U3ZtaW9K?=
 =?gb2312?B?bnNPY3pEbnlYTjM0NmJFYjBOM2xDREgzcGkxQWtSTHRXb3JzQWFPM09WZUNZ?=
 =?gb2312?B?RGNTRzE3ZUloRlNqZ1ZaUXlqbjZHUzZKdWsxemV5Ri9wcWdXR1dDWXkyMnQy?=
 =?gb2312?B?UWF4bTNBamxWOUMvTHNBNUliYy9SeWV6Tm5NNnh3V0NoUUxBK1FVRm42Z2tq?=
 =?gb2312?B?N0cyYmZFZEdiR29UZFZqOXltOUpPdmtoT0lLakdwOFNTa0FxcThpOStucEtl?=
 =?gb2312?B?U2FUKzBHVFJGOHJiL3BiSHR2Rys3c3QxaVVLOGY5UkhtTzhoT0w4YkxmMmZa?=
 =?gb2312?B?S1RLQUxJaUgrbTg0T3oxQkFSd2lpOGZSYWl4bEJ5QUk5eTVMQmRYaFZXanhI?=
 =?gb2312?B?RlhOTGd1UmZwVkdKN0grVWJLRjFCMktHemdOUXNlVVVuZXdnYTF4TFZYWmFi?=
 =?gb2312?B?NmRYVk1aNE1qRXNPeWdZWjNqRXFSbUhqM3pVb2VNWHNMeTdaRnlYaXpNZkxC?=
 =?gb2312?B?NXUxQ0IyOFRhajVUQytZeTVYYlBoVm5XSU9paG5PV0F2ZTkzNGptQzlNZzVF?=
 =?gb2312?B?VGM4MGZyVnUyVDhOL3IxYW1keFk2NEJkUmtjVUxlUlZMc3Vlb0NKSVdFL1Bx?=
 =?gb2312?B?V1pKcFdDM0cvUFVTc0dxeWQ2NVJmb20vL0hJak5TVWJ6Z0grRGpSalUvWjl3?=
 =?gb2312?B?bGZEaDhNOFEwQTlqKzBuN3BKNDM2SGhMVHI5enFYYXk4TU9RQlgvdXgxTVpH?=
 =?gb2312?B?RUplUk42U2s3bWo5aWY0dmFZdnVvWmEzaGNzc0FuM2RDakpRcTJsRElLMFAv?=
 =?gb2312?B?dC9Ea2ljM2VpV0M5THlZa3BBMXgxdU9XVHhpelhqaGt6T1V4SkZSanozWFVh?=
 =?gb2312?B?cTRGU1VvK2tzWWJzUGNEV1U0bkNuVHNrckpkdCtHRWtIWGJaYXFKOENITFdO?=
 =?gb2312?B?Mm9XWFlBNk81azFJVlVhTnFxSWljOXIrRXljdC9WVTJXQ1RvMXF2bnBCS0VC?=
 =?gb2312?B?SEcwRGtwTmtBV1hUU1NYVGhsRElxNzdhVjJBK2dRaTl1Zzc1MXp0ZHVCaEZU?=
 =?gb2312?B?MkM1b1U0WDZRbGNTUndiMmFPdmRhVTI2MmtoYjhKTnZtTzF0TlZUeFhGRW1X?=
 =?gb2312?B?enFhYlN0ODFvc3NOWWtaMWFxUE9weEJDUUVLdTBZSUNRNHV5Q0tZQkpyVjln?=
 =?gb2312?B?VDJHN3FOOFhUWFJ6djhibDlkYVo5U2hCS3B1Uzlla3Z5eHlta1RMRVBOYnpF?=
 =?gb2312?B?VFl4cGlkVW15bys1Q1NEeUhLLzZyNlhWc2p4ckNPSVg0dy9BTFhHYms0aHMw?=
 =?gb2312?B?ZVNXZnhieFJTbWpKTjgvbCtic04yQkd1ZVl1RUw1Q213aFRqM2VGNUdEd2I1?=
 =?gb2312?B?Umt3N2d0ekV0RUVpWWkveTc4Y2syMm1ocHpFQytHRFQxM3ZVdEFxam44b1N5?=
 =?gb2312?B?NWNpUlFXZWRtR005SlYzZzdlZTVhVFVGcmNtNUlyMjE1WmxUUktwd3daQUkw?=
 =?gb2312?B?empES3E0WVJURSttai8wbUlUaDJ1Y09tREhibENDL2E1SlRmT3JMZTV2bno1?=
 =?gb2312?B?OFRBWU9VVDNBY3JRUEJXQjRBU1l4UHNzRnI2WTFKSGkyMGxpdDZva2crZUIw?=
 =?gb2312?B?b3lRcEpzSnZaOVJjM0lWKytWbjIxTWo2QmpIc1M2WkFmend1djNOeFNmR29R?=
 =?gb2312?B?dzFWNjFGWUErdjMyN05FTENZVEdRSTZhemV0U0pGR21PTTZGQ3c2Sk9TMjVG?=
 =?gb2312?B?OGhKdEV1UmRDQVduTU5sVVpHdlVuWW5ZclFXMVNKU1V3Q2FCZkozMVphMys5?=
 =?gb2312?B?ZGZqNWFMaENLZmZ1elpMOGJOdFdMTFB3OTgvOENNNTY5bzNyY01zWHJMenBY?=
 =?gb2312?Q?57cI=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 113535b9-75f8-4173-3257-08de264a4931
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 02:29:22.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TTUoWGE8JzE+THqe4Acc2ExkO4IINNj9sOmIPwTPHDRFRlzVc1jG0Euuj8V7F/ccSdnqf1rWWq+bFkfmqsEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11756

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEx1MIxOMjVIDE6MjYNCj4gVG86IEJvdWdoIENo
ZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6
aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hh
d24NCj4gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRy
b25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGxpbnV4LXNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJd
IHNwaTogYWRkIGRyaXZlciBmb3IgTlhQIFhTUEkgY29udHJvbGxlcg0KPiANCj4gT24gTW9uLCBO
b3YgMTcsIDIwMjUgYXQgMDc6MDQ6MjVQTSArMDgwMCwgSGFpYm8gQ2hlbiB3cm90ZToNCj4gDQo+
ID4gQWRkIGRyaXZlciBzdXBwb3J0IGZvciBOWFAgWFNQSSBjb250cm9sbGVyLg0KPiA+DQo+ID4g
WFNQSSBpcyBhIGZsZXhzaWJsZSBTUEkgaG9zdCBjb250cm9sbGVyIHdoaWNoIHN1cHBvcnRzIHVw
IHRvDQo+ID4gMiBleHRlcm5hbCBkZXZpY2VzICgyIENTKS4gSXQgc3VwcG9ydCBTaW5nbGUvRHVh
bC9RdWFkL09jdGFsIG1vZGUgZGF0YQ0KPiA+IHRyYW5zZmVyLg0KPiANCj4gVGhpcyBsb29rcyBw
cmV0dHkgZ29vZCwgYSBjb3VwbGUgb2Ygc21hbGwgcG9pbnRzOg0KPiANCj4gPiArc3RhdGljIGly
cXJldHVybl90IG54cF94c3BpX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkgew0K
PiA+ICsJc3RydWN0IG54cF94c3BpICp4c3BpID0gZGV2X2lkOw0KPiA+ICsJdTMyIHJlZzsNCj4g
PiArDQo+ID4gKwkvKiBDbGVhciBpbnRlcnJ1cHQgKi8NCj4gPiArCXJlZyA9IHJlYWRsKHhzcGkt
PmlvYmFzZSArIFhTUElfRlIpOw0KPiA+ICsJd3JpdGVsKFhTUElfRlJfVEZGLCB4c3BpLT5pb2Jh
c2UgKyBYU1BJX0ZSKTsNCj4gPiArDQo+ID4gKwlpZiAocmVnICYgWFNQSV9GUl9URkYpDQo+ID4g
KwkJY29tcGxldGUoJnhzcGktPmMpOw0KPiA+ICsNCj4gPiArCXJldHVybiBJUlFfSEFORExFRDsN
Cj4gPiArfQ0KPiANCj4gVGhpcyBqdXN0IHVuY29uZGl0aW9uYWxseSBhY2tzIGludGVycnVwdHMg
d2l0aG91dCBjaGVja2luZyBpZiB0aGVyZSB3YXMgYWN0dWFsbHkNCj4gYW55dGhpbmcgdGhlcmUg
LSB0aGF0IG1lYW5zIHRoYXQgaWYgc29tZSBkZXNpZ24gc2hhcmVzIHRoZSBpbnRlcnJ1cHQgb3Ig
aXQNCj4gc3B1cmlvdXNseSBmaXJlcyB0aGVuIHRoZSBpbnRlcnJ1cHQgY29yZSB3b24ndCBoYW5k
bGUgdGhpbmdzIHByb3Blcmx5LiAgVGhlDQo+IGRyaXZlciBzaG91bGQgcmVhbGx5IHJldHVybiBJ
UlFfTk9ORSBpZiB0aGVyZSBpcyBubyBpbnRlcnJ1cHQgcGVuZGluZy4NCg0KWWVzLCByZWFzb25h
YmxlLCB3aWxsIGFkZCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gKwkJV0FSTl9PTighKHJl
ZyAmIFhTUElfRlJfVEJGRikpOw0KPiA+ICsJCWlmIChpID09IEFMSUdOX0RPV04ob3AtPmRhdGEu
bmJ5dGVzLCA0KSkgew0KPiA+ICsJCQkvKiBVc2UgMHhGRiBmb3IgZXh0cmEgYnl0ZXMgKi8NCj4g
PiArCQkJbGVmdCA9IDB4RkZGRkZGRkY7DQo+ID4gKwkJCS8qIFRoZSBsYXN0IDEgdG8gMyBieXRl
cyAqLw0KPiA+ICsJCQltZW1jcHkoKHU4ICopJmxlZnQsIGJ1ZiArIGksIG9wLT5kYXRhLm5ieXRl
cyAtIGkpOw0KPiA+ICsJCQl3cml0ZWwobGVmdCwgYmFzZSArIFhTUElfVEJEUik7DQo+ID4gKwkJ
fSBlbHNlDQo+ID4gKwkJCXdyaXRlbCgqKHUzMiAqKShidWYgKyBpKSwgYmFzZSArIFhTUElfVEJE
Uik7DQo+IA0KPiBJZiBvbmUgc2lkZSBvZiB0aGUgaWYgaGFzIHsgfSB0aGV5IGJvdGggc2hvdWxk
Lg0KDQpPaywgd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzDQpIYWlibyBDaGVu
DQo=

