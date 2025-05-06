Return-Path: <linux-spi+bounces-7917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F6AABB44
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B1218961D6
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBEA4B1E74;
	Tue,  6 May 2025 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iO0CNhBj"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659B4B1E4D;
	Tue,  6 May 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512383; cv=fail; b=SkSyiQzTOcKeb9QDmmMnM59DmsrYNpmdhm07MXt0wzPxjHE0QMV+O/o4+D32YM/Gkh8YADbZER+PmVqwCWRFNj5PjvEAJNXRrAJExACEdttqYPEU8xoALUezPV0IkM6CqaYlTJ4+z3qZ+2uwBfwixTcJBUBjSGgtre7/km2o3bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512383; c=relaxed/simple;
	bh=afo/8+PLgjWN+NAkN7ylNSg7bzRI0+623xMMB2OekJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=roiJq497a1yEJuIideh2Oa7H04mc/W60d98gkXebJX9iI1i7rxlwBnVWlbVxGffpfYHTS8E2/p8DEJIEj9bkF6ZSmcNFiUlFqXs1jSKmHTOlFMruz5GegYNEURemfdUq0GMwq87KHkfC8Ima9pnx7qzXeRI6BTgJmlYxo/8M2x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iO0CNhBj; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAorrQTtQuXCCeW7FaE8YJx+ZZ62zoK62VuLHEfw66qCEYu5twpDsCPuclIQL5jrvKQcUOSWEru0/zFoUnNJhZG/wUJAV2vhxvdjM5DRNQl+Ji8vxIlAqQzb8PfuNo1071q202nn80oumtexoU+5ZV2yDdCt3gLoVTt4bxIxQ2Ik1sqEhMvnKxLUtW8GTBGeCysHYNjZf3Wk597xxJqTxNUTBdxmyszcFcEoYzv6I5WPb4thmyL4CIa+BbGt4yRFCOYaC3k7f9f05G5qliwGspU2+4UarLV779jPWyhfH74df2Pw7Eq97R1LvnHR0qnwe/JAFxMDB2ke/uHbzerOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afo/8+PLgjWN+NAkN7ylNSg7bzRI0+623xMMB2OekJQ=;
 b=F5BlbrO+Oa0nCYDTojBsQCKPADy2zUQG06WEyR8XFvw2/MJot5Loi6l7xrVIapuTT6p2V/i39VYXFyildffMQNo3/ErwHek2JuNtS8bgn06K6OB1wBSe2rmMbq66rHBoSN6vBVWUFCQmGH4Tb7/nrfdP7zPlX0zBSsJKxNUEEXNFPxgHv+9qeYOj8M44Wcl19UuKbPZVv9YLhxlV941eQS6+V4u+PRffBXRVHGVFQxa1ra14S6fMUTbzDAJWmazGcFmmU3Y7h/WuwxkHrtMC9ipbyUfa2oXq1czOAq2svPQPLQwIQ3gARMJlw1/DO/ffsM+WvXKY1m7Qe2lbrpeoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afo/8+PLgjWN+NAkN7ylNSg7bzRI0+623xMMB2OekJQ=;
 b=iO0CNhBjtUPu5iestOi8IrwkD9BmR+rpreehDvPUha9C8SmRa2RDwLszVO/Lkt09WRW7G80d7kyT/nAbndcGk15fu7u/RwPIyxaucFlrL8urbKwy++oMyNBFHBSzHtGw67gd/e8EjjzfDxsjinnwCn9JWJYzANQcq/pS24MlBIeFtBcDa6OerhlexvrlHVEcmPrGl9bQFmRKoG3XBSs3zwVpgja1a9mkRyLBU3XbotK3/1H8a3hBrh+yZBf21gPkPjVBRnub/rlsiUfNcyy95kh44cZoq3GtMjx4An8vP9s1avr2fooNNZh2vnfAFaCqHI4wi48cf0YCw8toKw2D6A==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 06:19:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 06:19:37 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Mark Brown <broonie@kernel.org>
CC: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Thread-Topic: [PATCH v3 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Thread-Index: AQHbuCUFqEFEcqdyWke/i16IPHKZJLO+RB2AgAbnXZA=
Date: Tue, 6 May 2025 06:19:37 +0000
Message-ID:
 <DU0PR04MB949636EC30DB6362BF2B141B90892@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
 <20250428-flexspipatch-v3-2-61d5e8f591bc@nxp.com>
 <aBPdy8rR8M9x38w9@finisterre.sirena.org.uk>
In-Reply-To: <aBPdy8rR8M9x38w9@finisterre.sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|GVXPR04MB10564:EE_
x-ms-office365-filtering-correlation-id: 9140ecb9-a7be-49db-8bef-08dd8c65fa79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?N3JZc3B3Zzc0Vm5wa0lJKzIrWXJNSnVXUzd1cXZaZGMxQWtYVHFCTkhReUVt?=
 =?gb2312?B?S2hIUkEydXFkL3FRUWhtNzU3dUcxRXB3aHV0L2xtR0VaUUtlUDdRNGpEcExv?=
 =?gb2312?B?NytVZjVlUE9rbmZQaGZjVWdaNFo4V2c3c2U3Z040MzIvQWxyVzU4MCtZaURp?=
 =?gb2312?B?YU9jQWZUS2RxZ0M3RHBxcnY4VXlic2dHSXh3dys3N0REMDc2M1I1bkNUWmFK?=
 =?gb2312?B?T0dyb0tJVHRaRDNtWmlEMzFQK01LeTN2ZWJmajdwUGV6WElSeHJtRUg1U2xr?=
 =?gb2312?B?UEFwbW1JK2pRUVhjZWZWY1p5ZUdwbXRHelVQTFNJUFNZNlJhR3BXT1RrMXlh?=
 =?gb2312?B?cmdsQk9KWHFnaXEyWEpzOGpJUlRjOGRuOHdUOTBuTFRzblhCQU9ON0hDZE5H?=
 =?gb2312?B?T2xUSUZTNlNPbnRNYmZBK2FHSXpCQnM5UjY1UTI1S3ZReDBsWTNTUEI3Q1Rr?=
 =?gb2312?B?TmhNNEFxaU9GZXRmTVNGRDhldWFDaksyZVgyejFBNEZHSU1tQWZPdll4Mkt3?=
 =?gb2312?B?VTVUTlE0enlEMmZGdE5pUW8zemgvYUtFV3FxRmN4SktoVFBzOXh5YU1QUUxw?=
 =?gb2312?B?dDJpbW5zUmdBRlhhdHVTZ2szSENUdEdjUjdkclg2OHRpVGN5L3hQejRoU0pD?=
 =?gb2312?B?YU12T0F3bEZYSElhcldadVFaSGEwcTBOaERJQjRHWDE1ZlJ3bytJTGpXQ0xI?=
 =?gb2312?B?NGIzc29xWXkvaERtK0t0WlhIUDM5KzJLMjRqTnI0QWtQV3YzQzBFSFhacHZR?=
 =?gb2312?B?c3RNWmdRRjdMNEovNUtoTXBuejFTL3l6OW1IUHg4RWNGWUxNem5ZcytmMzln?=
 =?gb2312?B?bTdROWhpU0xKN1JVYm1SN1FzMW40WWZjTnZDand2SG42U1dyczQrdk10MFpr?=
 =?gb2312?B?ckM1WUxmQ0lCK2R1T3hDUXZMQS9jUVF6Q1JFQVdMYXplWEVReW5wbElZYXl1?=
 =?gb2312?B?UGJkV2xJMFMxOFR0bU5Ma0hXZDJXS0FtV1paZGoweTlYWXNpRWhRVENwZlJt?=
 =?gb2312?B?dTRBZS8vQkVQTkIvTnhiSFBQQVhrUmh3NlZ1RGowTVFTYzdHTkVpL0tKSml3?=
 =?gb2312?B?TUUzTC9TR2ljaWVsaVViL0hZV3B3SFlaRTZIYnNhR2pCTWFaRmFkK1VYQ2F6?=
 =?gb2312?B?QVI0U09WQ0FzOXNnZnBGN0hWa2xNY2VHcmlqdHRydHhKTXYxSkJCdnBHcmhR?=
 =?gb2312?B?aTVkWkMwMStKRXVaU0pSVGtPbERUVHJ1NXRmaGFiOWVUUUZQUGZ5VXltZkJE?=
 =?gb2312?B?dVRWSzB5NDk2OWRvUlJwaUhyRWN5cHBib24xblZDOXZ6YzJtdWxhVHp3ZUpl?=
 =?gb2312?B?SllHaDEwYUZsTjlwL3JlY0tUWnZvZ1p0ZkRUc2lMQ0NSQTFqbmQ5OGhLcU15?=
 =?gb2312?B?b0xPWVpoZ0FzUmh4YnMxZi84REdINFRXWmxNaEF0aENkSCtMc1FUOHJsREM0?=
 =?gb2312?B?SDBLUHNTNytKeVJxWUhlYjM4ZHA3MS9Bc2NNcENWVUtCbytEZkkrUVNEbVBD?=
 =?gb2312?B?YldMUkZsaUxYRzlYQTdQMmFOdU5OVjBWTkxocllJSVdKR2tZMGxVTCtzb2Vh?=
 =?gb2312?B?NHI0QXlHT3RiNk1LSk41RWp1YVJLdzBxN1dGS0g1TzdoZGNPdFJ3YmcwSW5u?=
 =?gb2312?B?NklJdy8rWi8vSktXTlowaUxOK1pRY21BZUtSbUJBOVROSXdjQzhvUW1jT1Z6?=
 =?gb2312?B?MGhPWWhTK3RqZ3hPc0VFRC9nN3VZdVBHckJPWEZ2TnphdVFMaU9ZQ1hDa0ZW?=
 =?gb2312?B?dFBHMVk5ajgvOFU1YTJSNTZPaWRUelhFczBoM1hlL01xa3UrTlp6N2lteWpp?=
 =?gb2312?B?d3hVVFYvQzhDVG8zcHRmVW02Ukl0T1ZvSG5taHRHM2ZvQVJrcy9BTjg5V0JJ?=
 =?gb2312?B?L1BsZktEVFdPREg5V1dCZnFqSytyM3J3T2tLK1lXK1BUMlNVRmk1UVZzVXZi?=
 =?gb2312?B?bXBsWDR1ZEExMjZvMzRqQUp0WGwwTlFSaEZzUWRwU2lFSDFyT2ZMb1NVYVZp?=
 =?gb2312?Q?7jmPb4fAsl6PK70mhuiEr4Lo5p+fBw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WXpYNStnV2lycXhVSzg2VE4wRE8yZ1JkWmF4YmdZNksvclJsbXVQdXduVHNQ?=
 =?gb2312?B?QkFxMklRV29KcUx1NXU1emxYWkZ3aHNnTktsczNFQzRPNXhCVGRJRmlCMmh5?=
 =?gb2312?B?dUQwSGpKTzkrTnJQUXlsZ0ZsYTMxd1JxemxBRVBoRFg1N0QrNlRrYjR6MW81?=
 =?gb2312?B?SW9vNEM2OCtBT01JZXNQeXhjV29EYzVRUSswTktPeWlaMllReUVJb3ZDQTBK?=
 =?gb2312?B?Nm05SEhERVFrOFVHWjMyZnFZVkJKeHpzOG5mT3UwR3psZHMrSHFNU2ZlYVNH?=
 =?gb2312?B?aWdVbVJaUytySTZJU0dvRFNzeG5lREdIR2JKVHdHQUpqWldkMGpoVFlQUDZL?=
 =?gb2312?B?TjF0cGgrTVVhMEZzeGZTbUJ6RlIxVzIvbXdKMTNURU5FZlJrMjNRc0ZTKzV0?=
 =?gb2312?B?Zld0d3lMZVdXQUJmVktaWllQRUZjWWhYeU1hWE9SdnVBNkNHL01ySDVEVGM2?=
 =?gb2312?B?T2hobVpzZ1NhK2o1R2FzYlBSdEdMYnZpV1FaMWcvWkd2eUxDUWt2cG9uVHJS?=
 =?gb2312?B?ZGJnQzNHL2pFVGtnK3dpZHlxMEQzKzQ2aVNQWU9mWUlzUWlzblB1ZlNkOEpT?=
 =?gb2312?B?TGdQcVZ1YVZlby9QRTBjWXFrK2RLT3lCb0xNU0l2RHBUUlBCOHdUN1B0Y2Vl?=
 =?gb2312?B?NTlTVk9XT0ZqQUdaR29PVDVHRjg0WVRJRm1xL2lEMm56aWdKOXdJZHJ3TzdY?=
 =?gb2312?B?STZZbmtNeDExR0FoT255dkxCdzdnOVBaR0s4cTBlV3VTL2NnaDN5L2IxcEZB?=
 =?gb2312?B?WXk2LzZ2a3M0amg4bVNXSUVualVaRlFOUExHeTNFTjFPUjhIN09tcHp4YXBv?=
 =?gb2312?B?UHhjZGxDMlFGOFVYREcreWJ1eFJFYWNlVXhybENDQ21SdnNJRjZYb3M3akh4?=
 =?gb2312?B?WDRjVm9qa1crclNvVVRCRUMzZ2pLV1VJMnhnTmQ0N0FnRGdDTy9EdHFTajFM?=
 =?gb2312?B?UHpVZWtsYmpCY1BQci9DQys1S3RsYlVSaFNZK1padmI4REtSNVN1RzA4TVhs?=
 =?gb2312?B?cFU2NFRqSHRyY2FHUG5yenJyNFpNNlVmM1FsY3Jrcm5ZRFozNUlBY1BtUEVo?=
 =?gb2312?B?bUFuaGhoL0hRRVh0b1FBOXFVbkFYVjkrcDl0a3EwSG1kOXI1dDdCb1pCVlp1?=
 =?gb2312?B?bnd2VmFmbTJGdnpaVkQ2cXJNWEllbk56YjVMcGkyRjluYlJ5UWltbzFwRUcr?=
 =?gb2312?B?UFY2VVduRk9GQ0FTcW5BZzYzd1lObmxTMCtrNVlwYmN5YmIyUElNTTFEZC9Q?=
 =?gb2312?B?Qmd5bzNtVFBxN1pySk9SVTZvRjNCeDg1S2x6YUlaRWRnUXNSWG9VZnlEb01S?=
 =?gb2312?B?ODY1WGF2K0lCOE1qdmZSTUVuODNWNFc3dDdNLy9CN2diRTQ4L1JTR2VVRFBp?=
 =?gb2312?B?S3R1TXhKZ0dHMkNTQ2MyMW00R20rbUp1R2NEUkZOQWpkcGNuL2dRd2R5cklJ?=
 =?gb2312?B?K3BJUC84ak9wOXMrWFp6c2ttYUVZRTBNK0lXQkE4dTBQQlZyc2lwTUpON1FZ?=
 =?gb2312?B?dndheEhpRkVCOTBZM251Ym5JREJHUnNSb1QwR1BGVS9vVVl6WWdvem1uRGlY?=
 =?gb2312?B?azVZU2JyaHpkem14bWpXem1yU2NUemhQODY2VW84MmZCdmgyRHNyYmljLzMy?=
 =?gb2312?B?TEhlcGQxTzJEaXBRcisweXVIVXpneGtqT2dzWDIzTzVZaHY0U0pvOVVrSTJj?=
 =?gb2312?B?dGZNYmhubmZRWVRPYklqRU1MUWRVaDVUL0RLSUZxVUVCUy8yL25scUMwSVdM?=
 =?gb2312?B?MjhJQ0w4ZnJPdENSSlN4TXl4V0dvZjN0RTVnckIyNTRRcGJudG9wOTVpcFFn?=
 =?gb2312?B?aDNmWjJEamhiRm9ONmxDekZRQjJsS2ZTTkhaOTlNdjFFd3lxeW1IenhhL2Ir?=
 =?gb2312?B?aFZ5MEVsNzRiK2ZYdCtkUDJQOGpxK2k4eTJmT1MzTUlyWStqbHhrRWpJT2Fu?=
 =?gb2312?B?cUNJaHlLemtGNnNsVmdNNEp3ZzhzN1cvWXFSRndTT3BVb2NodDgyVWVEek9z?=
 =?gb2312?B?TGRpSVpCVmtLZEViY2lLcHNWeWltN3ZYWjBOUmY4VXc3b1lFMUVRcDkwSFdS?=
 =?gb2312?B?cnJmeUY4YkUyaUlsSVR1UHcxV3YvSHBnNDdNTHlvNHI2SHFvaHNJMzhkdWRF?=
 =?gb2312?Q?wSYU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9140ecb9-a7be-49db-8bef-08dd8c65fa79
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 06:19:37.7834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/5/cHrjLIKiJchfp1Y+RCVeShoKW6o9SCfkKSlYHwL2/nkhNth7EBdMCBzjCyGoslLipJGqUlcm7TgK7LLZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jXUwjLI1SA0OjQ3DQo+IFRvOiBCb3VnaCBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBIYW4gWHUgPGhhbi54dUBueHAuY29tPjsgWW9n
ZXNoIEdhdXIgPHlvZ2VzaGdhdXIuODNAZ21haWwuY29tPjsNCj4gbGludXgtc3BpQHZnZXIua2Vy
bmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvNV0gc3BpOiBzcGktbnhwLWZzcGk6IGVuYWJs
ZSBydW50aW1lIHBtIGZvciBmc3BpDQo+IA0KPiBPbiBNb24sIEFwciAyOCwgMjAyNSBhdCAwNjow
Njo0NFBNICswODAwLCBIYWlibyBDaGVuIHdyb3RlOg0KPiA+IEVuYWJsZSB0aGUgcnVudGltZSBQ
TSBpbiBmc3BpIGRyaXZlci4NCj4gPiBBbHNvIGZvciBzeXN0ZW0gUE0sIE9uIHNvbWUgYm9hcmQg
bGlrZSBpLk1YOFVMUC1FVksgYm9hcmQsIGFmdGVyDQo+ID4gc3lzdGVtIHN1c3BlbmQsIElPTVVY
IG1vZHVsZSB3aWxsIGxvc3QgcG93ZXIsIHNvIGFsbCB0aGUgcGluY3RybA0KPiA+IHNldHRpbmcg
d2lsbCBsb3N0IHdoZW4gc3lzdGVtIHJlc3VtZSBiYWNrLCBuZWVkIGRyaXZlciB0byBzYXZlL3Jl
c3RvcmUNCj4gPiB0aGUgcGluY3RybCBzZXR0aW5nLg0KPiANCj4gSSB0aGluayBJIHdvdWxkIGV4
cGVjdCB0aGUgcGluY3RybCBkcml2ZXIgdG8gZGVhbCB3aXRoIHJlc3RvcmluZyB0aGUgcGluIHN0
YXR1cyBvdmVyDQo+IHJlc3VtZT8gIEJ1dCBwZXJoYXBzIHRoYXQncyBub3QgdGhlIHdheSB0aGF0
IEFQSSB3b3Jrcz8NCg0KSGkgTWFyaywNCg0KSSBjaGVjayB0aGUgcGluY3RybCBkcml2ZXIsIHNl
ZW1zIHBpbmN0cmwgb25seSBzdXBwb3J0IHRvIHNhdmUvcmVzdG9yZSB0aGUgaG9nIHBhZCwgcmVm
ZXIgdG8gcGluY3RybF9mb3JjZV9zbGVlcC9waW5jdHJsX2ZvcmNlX2RlZmF1bHQsIGZvciBvdGhl
ciBwYWQgd2hpY2ggZHJpdmVyIG93bmVkLCBuZWVkIGRyaXZlciB0byBoYW5kbGUsIHJlZmVyIHRv
IHBpbmN0cmxfcG1fc2VsZWN0X3NsZWVwX3N0YXRlL3BpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRf
c3RhdGUuIA0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo=

