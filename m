Return-Path: <linux-spi+bounces-10988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95BC2F517
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 05:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046D83B73E6
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 04:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFFE1E51E1;
	Tue,  4 Nov 2025 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h73+F2LV"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC911D5CFB;
	Tue,  4 Nov 2025 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231729; cv=fail; b=J21cQdUV4pQQfLNymdjjiD09U2i0LIb5HG5cU++gR/QxnB0ngwWtR3/MrRdd2SsBmqgJp/zROvUdjpF3OWPiNlDmhU/5LGO7wvJzQACUwCXrVnQRfU101lToS+6p5FevVvXYwnCiyH11hAaPvzdEh3PUvckQMo25quHlgLnNCXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231729; c=relaxed/simple;
	bh=ztOUKEEBQ/O99Z9q9xZFuoCEWblpyk9MFdpKMNR9GFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJDHleUaecsC4YCuo65pqHVD/rBArlcH1Y+H3nbpbuiogfCsyArndBjH82rHAgKvYlHc4PhfQG8BIYYrhpCa9A1p6R8vFIcv/NHrMrK1jkSlKJ+Xxi88PSek9cO3H92DI0ZtklDtIqTPeYrR8pRbjbeauCCcOoA2+NzHyIPlov8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h73+F2LV; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdpbT36tCE64UaAVgSKwMzN014xpO/FNN4HBLOV6IKB5r6A+pQw6rOYSpTexNQYfBlUsaf0VxzSm1BE1HL3uNR+5r0BFSTyG44P0C5/WRkFE2TjV7W2yT0si8f4mgPXd9kSuawYHt4pq+ORFAbpkvTDZRM5i/UNS6QyQZvZOI2L+K+xHz7gFJ01UzmZJwTIKPEiWAToGkFNzgLTFg/SKmKM0zQMOvDakkxOfj+9jwLcx/WTRMQcCJhK03vSmfdL+LWzN8X7FpciKOJYiokJDjOR4XRG/NCPebhrCuX2Un5HGYkWib+RgfF6gVOCtmM0m8fpqr/p3BWJMvfOYayVg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztOUKEEBQ/O99Z9q9xZFuoCEWblpyk9MFdpKMNR9GFE=;
 b=Yn3ra6qWwD3YfzfP+91HgUkOMp4SSAMZpl+AotmicgrSrcEu+dPGFgaIEjNmAOuUw15PkeUiChXdMs3OqgMN8/0EW64kJlavG1ZG+YEWNYM52GrV5HsbX6C+z1OVRSI/NkMQjaTskiG/Y7l6XmHhxPiQ9McqSk/l6/ub/HzwFWcwkwaJ06JYyAsz+R1Xpm2PPx4L8wHWu/pIFAcCdzwhGaxMuLQexYgogGi2wLIzYyFFkztZsRwpPXd+eZpMa10xO040iSrOFZNBhjOzfE4KVQkUpD4e9ULPcJi7w2oPHFqI+qgxSSqyDVieNpiCO8bUsT1pwAVu8kl4rNKQUzcV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztOUKEEBQ/O99Z9q9xZFuoCEWblpyk9MFdpKMNR9GFE=;
 b=h73+F2LVrwawubz/2qeTVHgrxkP3Qfr445XVI020n6WO2FaGLMuq7qZ49AxxW2VE9Rp1P9ng1WahykwtF0K63Wj2TwAvTuOkcuUm9k+Rbhu/2Y9A6gEoaNuLa3LDsKHLDuvfzMmrBsseff30bW4TrgHyUic53p0WxjtwNyR5nUKmy9tOwC8eiVcNZPKu3WPW0WNc4yMzNWYfZNjeP1UDUY7v1ExxqT9DrzaMVbyAKwxgaJIc34GsLy2x21ECXQAEzbKg/G4rpzzWVR88GpHQs2g8n8CSe+tXlu0YMSiEi/CyophQS9Cdie8KeElO19Da48kpqE3OSbUSx0eF9NjvmA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB11531.eurprd04.prod.outlook.com (2603:10a6:102:4df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:48:43 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:48:43 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Han Xu <han.xu@nxp.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: spi: Document imx94 xspi
Thread-Topic: [PATCH 1/2] dt-bindings: spi: Document imx94 xspi
Thread-Index: AQHcTTggOYdocW1miECDSsMDsaV0TbTh69gAgAAE+iA=
Date: Tue, 4 Nov 2025 04:48:43 +0000
Message-ID:
 <DU0PR04MB949619DF95B0A688EC4A6D6A90C4A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
 <20251104-xspi-v1-1-1502847ade40@nxp.com>
 <176223036803.847185.12615558425940080887.robh@kernel.org>
In-Reply-To: <176223036803.847185.12615558425940080887.robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA1PR04MB11531:EE_
x-ms-office365-filtering-correlation-id: 47250ebd-1bfb-4bdf-7bba-08de1b5d6e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?NGVXN3BiWmI3MHpDQ2Z1WmhXZUtKdnN3SmorNlhqT2J5ZHpzdWpaYUhvSFFN?=
 =?gb2312?B?cWJVNEova25tTC9DRnZSRUc3VFVaNmYyNmFTTUtpYmFoalVoeC9XMmhTTENp?=
 =?gb2312?B?emdaenhOdWRDZnMrV0NZK25PTUZoNzZkMFBDbXF4RnkxMXRUV2NLcXBDYU4v?=
 =?gb2312?B?MjRtZjd4dDA5Z0VhMWtDeFRra01Rc1oxY085WEU0QnFuTGlwRTNYTXpZY0tE?=
 =?gb2312?B?elUyUWVDWFJmOENzNE9obWFoZ28wamIvd0hpTTIrbjBOaGZLWGdFNTJvYURM?=
 =?gb2312?B?b3ZpZFVoUlE3Q09MVVVielFnL24xY0kvbW5lcHUyb2o5SVVINDBoQm9OWXNJ?=
 =?gb2312?B?TloxS1QvSWVoZmlJRlZYVnppY3JhN1JCeGo5eVU4aTF6WTBPN3R6d01ZOHZy?=
 =?gb2312?B?L1owVll2K2RjcVNTaktmYlVpS2g2M3RlcEx0aGpJMlpHeTg5bVN1WVIvRlQ0?=
 =?gb2312?B?SFRaSXBDRFhhT1hFY1c5Rjc1dk1CaTBoMks1VjFDRUVTQjY0cnZFeFNGU2N0?=
 =?gb2312?B?MVZPWVhkK09LWmlQeU9Mam5wbEp6RmFBK1hJU0VLMEdBMXJlTDN5ZFdyMVdz?=
 =?gb2312?B?TXo2UVZQeHdVNzJjVjBqL2pnL2JYT2FqNm41NVYrYThsN1NOZ0NWc1UyUitV?=
 =?gb2312?B?MkhOdzZEb0RLd1pTYWR3SUx3VTgrREdjVGUrRXdoOHYzcFNsUEt4Q280RTRn?=
 =?gb2312?B?bnNQVFk5c1VsbE1xT1NxKzlxSXA0OEdFNmxLVDVtcGdmMUk0L2p0Qk5yQWtS?=
 =?gb2312?B?T2hucXFXNHZsR01Lbk1CNDYvVW1BNzI0WTAzdWgra3k1WkZmQzVYL2tJQUsz?=
 =?gb2312?B?Qkt0UzAvV1NjUGNweVVudmp6c0hqcmxGNlRvNjNjbmlyWXp2RmFVL1Y5VWxs?=
 =?gb2312?B?R2ltTEhOcG9vK0dHS2RzQ2FXaVRSYlpTcmF0VHdkZU5TaGQ2NW53R0hxWUxZ?=
 =?gb2312?B?aFRzTWtJNFZ1UmVaR0RPWU9RaFhmUHNIcVpzeVN6eCtDVUltV1h4aHRkQmdp?=
 =?gb2312?B?OERoNi9uYk5TZWZrdXl1NVdFWnd5eGpmd090ZjZLU2wzRXhsNktpUDVmY1Np?=
 =?gb2312?B?dDg2K3Q3WnRzNXp6bEdvanJKU1ROVGE5UG81NFlnQzVnV1d0SlgrWnBaSDhr?=
 =?gb2312?B?U09yU0RvSkxtZ3B3OEVZTnkrV25GMFpkTEtheEF4Y2JSZC9mRTRQbE9seUo0?=
 =?gb2312?B?ZXMxR3ROYzRvWE1WT1FRaUNrSFRyK2lvSEduMGFoeGczNFlPSFlMWmZhbERu?=
 =?gb2312?B?aG1nV1Y0Kzd1ZndaMVk4TVZteFNaTkVHc3NUSkJ5OVpBQmRTSTEzM3RMR01K?=
 =?gb2312?B?ZnN2Wnk5cndUKzdFS1o2V1lOSmxsam8vbnNVYThHeE40dElqeGhTYzJNNjRW?=
 =?gb2312?B?em5lMFJkWDMxSVNiaTJPVzUzZURzWFM0RU5rUmFDS21pSkVkTXhvZU1ESWtS?=
 =?gb2312?B?UmJWaURFS1BBMTgrWlJqOXFXNHh3YWlGRGxCM3RvUm96emFKOEJCcE5RZEpa?=
 =?gb2312?B?ZUYvUHhDNHBIRlpWelFiS0h4bDgrQjdsRzBhZzRXd1dYVnc1UDhsYWhXNUtC?=
 =?gb2312?B?STVVc1Z0ak5xd0k5cUlJaWlFaDgxSkY4dUNycVhOdTNtUnNuT0FZVFNud1cr?=
 =?gb2312?B?UUEyR0lEa243M3ZxaFJUdVI1VmJ5WnNRYmthd2VIbFpkaWhyVDBSVEJtdG1w?=
 =?gb2312?B?RGZTU01xc0RxNFgzREFpVnNrMHRQS3J1bzNHVlN4dkhMODVvbFJsb21vSWhk?=
 =?gb2312?B?WDBNVXVqT3VUTEI1ditNQnVGdFBua3dpUDJReTVnTlkzY1d4dnBlQlAvL3cy?=
 =?gb2312?B?V0pYTUhCRXgwSWpIMXBhVk1pQVlPKzduUE44UnNFcVc5ZE0wQzBld1BaUEdL?=
 =?gb2312?B?SGhHYVl5eHZOK1FBejJBaHJORFUzeW9XSWozYVRFNnk0S0NXaHZnZ1BsZzhh?=
 =?gb2312?B?eGEvUTQ1YldNK3VjRXMydzRvZnhJY1VhT1lDTkRUNFJwMzI2a1ZUdlFtY3Za?=
 =?gb2312?B?ditNK3lHVnFzd3lxYzVWTXdkcmxaaytXYkZ5UFF6Ty9NYVF4L0dIeHNlVW9X?=
 =?gb2312?Q?rDQAf/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZGhURThQZzhTRWhKVm1WTThyVHNLZTRrbUo0VXR3V1JGV2RuN0R5Vkl3ZTBk?=
 =?gb2312?B?aWZBckxCZHhsa0tmMVY0eDlmOFFTV0wwc2Q3aks0ZWJkYUNVWUVlTkc4SlRl?=
 =?gb2312?B?b1VuWG5WUFhobVp6SXRVQlJBTm9vOE9yZlFXTnJ5Z3hNN0hVYjhTTzNQekFC?=
 =?gb2312?B?d2lqQmkrMW80MXFlMjJaNFVaWGE4Q2UyRkh2MUZwaTJxNERtazB3aXh6UEgr?=
 =?gb2312?B?TWw3bm02ODh0V2NlT0V1YlVkRGwrQlRwNlBFdGU0ZGZVdWZjalhqbUIwc2I0?=
 =?gb2312?B?Z3M5aUZWTnEwYWpyVEZsWERkTEVXWWRUR2kxVytkRzlLT3F4cXUvWklhOXZT?=
 =?gb2312?B?Zzg0K0FrU0tDWXFLdTdYK3hBMHlGa2J0ZkFrbE92cVVYRmtXUWxvRndpOURC?=
 =?gb2312?B?aG9sZFN2eTl0U3ZsdnhXM0FSdVdKbzZ0SlJ4VE9JczljaEVOK0x0L29qdkps?=
 =?gb2312?B?Q1pRMjlnN01RUUZSVCtQQ3kvNjRVY21VeVQ3WjRNcHpnME82OUd2Y2tEVDFv?=
 =?gb2312?B?ZjJMZklqOWhWYjZsTDdQSXBOUDdERDhXaWdRTEJxdm4zc3ZrSFR1WG5KK2pJ?=
 =?gb2312?B?eVd6YUw0ZU00Smhva2hzL0dDVWp1akcrUnh1Vk5McnNZdXZZbTFiUzRrREhT?=
 =?gb2312?B?WEFLUisxVFdacFk0NklMUElISmFDcUU1TjVJWWg1RzZ2WHMxTnVWRWI0cHZq?=
 =?gb2312?B?ZDNkV3hadjRwMzRmUkhsU1dXQzBPdDFmeExDREZWSlQzOXZUSFlrTVFqM3E5?=
 =?gb2312?B?TnR0YS9lNW8zRkVwSXd5WFprUHIxeUorQUluZmpBY0taaGpaRDZ2ODNGSWRM?=
 =?gb2312?B?YUhGRHlBRDJiaHFVREtKbGExMnJYOWxvcGhkVVE4MG9QWW9VMmZsL1dSWmY2?=
 =?gb2312?B?dG10eVYrcS9UaWZ3V25jN2pOY3RleGlFcWhGdGRXUDJ0dGR1dWhHTXAxL2ZT?=
 =?gb2312?B?VEwxQlN6TW14M3pyQ1VBa0ZPdW1xazJmYlNYY1R5bElhOFlVYW1lM3VxQ3Bj?=
 =?gb2312?B?SkJXazVuTmhSbHhLUEtONGFiT2ViL1JhWlVnQ1IyT2JXMGc1cWVGZDBXaGlv?=
 =?gb2312?B?aFVRYmtCR0c4V09WYU1pa0FhOXRzWlI5NTE0R0xQT3hOU2lqSk81QzlmTHpM?=
 =?gb2312?B?blVzdG1Wd0Fyd25tNUV1OEd6b0l0d0xSY0JndnhabkZjdHhZQVRnZVJQU2x1?=
 =?gb2312?B?N3BTc1l6Y0NacXNwVmtETW9ieFRjZlJtSHdYVDJFZnVsMStFb0JEdndjZ2tQ?=
 =?gb2312?B?dzlxTEFGV0NQL0p3b0g1WkRIcjVFTzRSSkUzMC9QR3pib1NtQk5sL2NCYWxv?=
 =?gb2312?B?REFmdHN4WUx1NGFSTVlpck9JcWQrRURmekRtWHBvczM1c3lsSWd5b2xEODd2?=
 =?gb2312?B?cnVRNDZYODEzNDBHRjZzdjdQZGV3bys4cW1FVjBKSFBRQlFSSUVPMW9xVUsw?=
 =?gb2312?B?WXJOdDdBK1lCTVJQYURjeThlMVJOOTVQdnBmeUNjYkNYRU1nMXl4R08rV1Ro?=
 =?gb2312?B?MnhRZGs2TUVpVDNqNzF4MndvYkpMbmUwdWRCV1U5TnhwZzMvS05lUWpKby91?=
 =?gb2312?B?QlowV0xDVThBTmhsY3pQZGNBTS9xVXdBMVoyOGlJdThpZURVeVM0Q0dCbHFk?=
 =?gb2312?B?WU5JQjExQWFiU0trWktHVHNpUjJTN3I4Y0piQndGS2lsU0JUekFCUUZIZUxz?=
 =?gb2312?B?cVhPYWZxdE9jUEc3OTE3WTVzL1JiVmJkTGtJcGM5S2dXaEdmNzQzbkxnaTJp?=
 =?gb2312?B?cnhhWmJoSUlqYjZ6SWE0MGpUVHM5UkI3NjZNM2NxR0ZNeEx2UmZpSE1Fa0JN?=
 =?gb2312?B?VWhVVGsyWTZmbmtzQ2NsRnpuVWdBaXBIeEsvWkh6R3ZEMUxCQ2pjNkpaa1l1?=
 =?gb2312?B?RXh4UG1zUmtjQmdENGs5OXppS0tJc2xyZmZCQmRzOWFQZG1wdlVWMDQ1aWs4?=
 =?gb2312?B?dzVOUXl2UGFCZllFc3hva0RGRFoxdnlMRE9Yb3FxSTJDbjV4cFJ1djlzRzAv?=
 =?gb2312?B?akVqWnlaM0xxODJrbVhEaTFHV1RJajNPSGt5M3lQMGU5amM1aTBiaEtSTUp6?=
 =?gb2312?B?cG9wVDlxSUVGNGRHWUl5aVpmZDF2ZjBOQnVJMG0weFp6Um9UN21sTU9UK1kz?=
 =?gb2312?Q?Hy7M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47250ebd-1bfb-4bdf-7bba-08de1b5d6e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:48:43.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9FivOGDhLhD6GaIag7CvPlA7epjhSmbUxOn8dfh3HX/oAXLuB9bfVINOC+JiokW1NCdSiLPPkbpzlbREnJ9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11531

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8
cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI1xOoxMdTCNMjVIDEyOjI2DQo+IFRvOiBCb3Vn
aCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBNYXJrIEJyb3duIDxicm9vbmllQGtl
cm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1zcGlAdmdl
ci5rZXJuZWwub3JnOyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBpbXhA
bGlzdHMubGludXguZGV2OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSGFuIFh1IDxoYW4u
eHVAbnhwLmNvbT47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBzcGk6IERvY3VtZW50IGlt
eDk0IHhzcGkNCj4gDQo+IA0KPiBPbiBUdWUsIDA0IE5vdiAyMDI1IDExOjA3OjM2ICswODAwLCBI
YWlibyBDaGVuIHdyb3RlOg0KPiA+IERvY3VtZW50IGlteDk0IHhzcGkgdGhhdCBzdXBwb3J0cyBp
bnRlcmZhY2UgdG8gc2VyaWFsIGZsYXNoIHN1cHBvcnRpbmcNCj4gPiBmb2xsb3dpbmcgZmVhdHVy
ZXM6DQo+ID4NCj4gPiAtIFNpbmdsZS1iaXQgU1BJLCBEdWFsIFNQSSwgUXVhZCBTUEkgYW5kIE9j
dGFsIFNQSS4NCj4gPiAtIFNpbmdsZSBEYXRhIFJhdGUgb3IgRG91YmxlIERhdGEgUmF0ZSBtb2Rl
cy4NCj4gPiAtIERpcmVjdCBtZW1vcnkgbWFwcGluZyBvZiBhbGwgQUhCIG1lbW9yeSBhY2Nlc3Nl
cyB0byB0aGUNCj4gPiAgIGNoaXAgc3lzdGVtIG1lbW9yeSBzcGFjZS4NCj4gPiAtIE11bHRpLW1h
c3RlciBBSEIgYWNjZXNzZXMgd2l0aCBwcmlvcml0eS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1ueHAteHNwaS55YW1sICAgICAgfCA4NA0KPiArKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDggKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOTIgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRf
YmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vy
cm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW54cC14c3BpLmV4YW1wbGUuZHRiOg0KPiAv
ZXhhbXBsZS0wL3NvYy9zcGlANDJiOTAwMDA6IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdp
dGggY29tcGF0aWJsZToNCj4gWydueHAsaW14OTQzLXhzcGknXQ0KDQpTb3JyeSwgc2VlbXMgbXkg
ZHQtc2NoZW1hIG5lZWQgdG8gdXBkYXRlLiANCldpbGwgcmUtcnVuIHRoZSBiaW5kaW5nIGNoZWNr
IGJlZm9yZSBzZW5kIFYyLg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBkb2MgcmVmZXJl
bmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0KPiANCj4gU2VlDQo+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBh
dGNod29yDQo+IGsub3psYWJzLm9yZyUyRnByb2plY3QlMkZkZXZpY2V0cmVlLWJpbmRpbmdzJTJG
cGF0Y2glMkYyMDI1MTEwNC14c3BpLXYxLQ0KPiAxLTE1MDI4NDdhZGU0MCU0MG54cC5jb20mZGF0
YT0wNSU3QzAyJTdDaGFpYm8uY2hlbiU0MG54cC5jb20lN0MNCj4gZTVjYjQwY2UyNGY1NDg0Yjdk
MmYwOGRlMWI1YTQ4ZDklN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzDQo+IDUlN0Mw
JTdDMCU3QzYzODk3ODI3MTc0NDM3MDM2MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlgN
Cj4gQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlz
SWtGT0lqb2lUV0ZwYkMNCj4gSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT01
SThMZkhrRngzOTR3JTJCZm8zcGo4Mm83WWwNCj4gN3hXdGhOa2ppcDlIbVRycFZvJTNEJnJlc2Vy
dmVkPTANCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUgbGF0
ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeSBzaG91bGQNCj4gYmUgbm90ZWQgaW4gKnRo
aXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hl
Y2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBlcnJvcihzKSwNCj4gdGhlbiBtYWtlIHN1cmUg
J3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0K
PiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxlYXNlIGNoZWNr
IGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5b3Vyc2VsZi4g
Tm90ZQ0KPiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4gYmUgc2V0IHRvIHlvdXIgc2NoZW1hIGZp
bGUgdG8gc3BlZWQgdXAgY2hlY2tpbmcNCj4geW91ciBzY2hlbWEuIEhvd2V2ZXIsIGl0IG11c3Qg
YmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0aCB5b3VyIHNjaGVtYS4NCg0K

