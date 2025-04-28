Return-Path: <linux-spi+bounces-7778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8DA9EAA2
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDF47AAFA8
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39F20D4E9;
	Mon, 28 Apr 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kAQY2+wX"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012063.outbound.protection.outlook.com [52.101.71.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55F1D6DB5;
	Mon, 28 Apr 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828412; cv=fail; b=eBK6pjOg/ZzzZdfyEhzB9AgiqNcBIPE8LefL5r6yqLxRLQ0ZnShdDZwI1UGt3ZBAO/hcMyBfofQOeqQrR3AF8uKBRWl8kgGqD+1dR9JbLIXOPJC/BFYG8zyYfOS0+Ym8g+a2fHniZ3Y7sX0fsgJB2IEXqrbf+/EMcy1bEedX/1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828412; c=relaxed/simple;
	bh=QmZCdx+HTwh8oNyVzerwgcoxXZEwhw2E2QgSxSXlw/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iT1c8xT8jbjcHu5PCgJ2v8qNnR7T04rA+oSh23larO52XYPCcNmwg/yfvf8JeJIEdsGhpX17mXWRqz1KBfu/IYWBlAgDzoU7I4aGHdfEpo4W/f+Z2cw4sMZVxEvfx+OjvwZTYWyN8r+khdOBOTGb/yDzEbSKhUWyOYwbOIaW4bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kAQY2+wX; arc=fail smtp.client-ip=52.101.71.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibVMAVfmO2Vw6P1yb/re5P7ZxmXgJiGtfxX7OPe8Ft+dKr7lxUiIZZxyDzPUH/Mn5ub088wWCDdK28MCpGzlKA8B2P2ikii6kUHrDyhHQ0q0Gymwu7Gqpnjg0x7zpWKiYBuTbRteLyy9ZHhUfh5SlEEWMlafR7kfs6K8/rh53B1O8COcn9r4WyfBEToPqtNMpFiHEJyQtJNwiEYVjUCjimNB1+XLhu4/BO9xXU+7rgUWaGw/D4xdaiGtyvidMz2ygjuRwesphNhrkbCpWlb8ar82ei5KY05JSXlJD+s400DvsSN/tMFXZzY0g14+VU/Fj029cwcNE5Ep2DDDyA2AzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmZCdx+HTwh8oNyVzerwgcoxXZEwhw2E2QgSxSXlw/0=;
 b=zC2YQy3pXgSLrfzp+pvF1E6QkJ0ZGLAcZlYnaL0hZxlay1HEBIsKeJbS0+O7uGv3gFj4SXDsWn6qYRHBORtehcSfa+kj/XI5jVhux5yD36YhyzCto1NvDE8ADpvEH60Q+VuB3DmlBg6sP5o+m9abiycQWx/5CrD12CFRAM1l+gSeK79udV6iJqoXpDUkr40gtPiUNhcQVUio8ZXabSJLbazaEIbLt+i9D5o+rAJjdAlEavLUXSW6hWlJg2lYYAV54Bs8tisoX3wkFZhOdtAUverr6RtcJP59qhJcv1gwDCp2LF1YPKEqG1GAgqPB3NPlpmYGIjbTxdYWk1NY+/+i3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmZCdx+HTwh8oNyVzerwgcoxXZEwhw2E2QgSxSXlw/0=;
 b=kAQY2+wXop8vQ3or3T1O+lhERqN1iBBUMh6C06q/5Gcf8Nfjv+XohLPBCaSh3z85iBqd8XGzylbD2Mf2g3Rg3FEGlQXqNHwLkh7DH3+L73S+N5BA/c+XViW6dFNGlYtAVHC6rM0naz3sioabLGIKH11IZP98ySj+Sbeuya83VE5TGMBh6Cl5hHq3d6Onc/lkpD4tAWpR/+g+aKX6uW88HeZudP5O7dXF8DK3gGCHG5JKODNvCJGKMUwvQOSbQIFHeQdTO++ByoBfpJmLofAKQ5CS4nc7H+q8I1AWugFAO+/30O7t6c8DvDB4bOFcvcYr4kIa4trkyYgSpYp04lYS1Q==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 08:20:07 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 08:20:07 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, Han Xu <han.xu@nxp.com>, Yogesh
 Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] spi: nxp-fspi: use devm instead of remove for
 driver detach
Thread-Topic: [PATCH v2 5/5] spi: nxp-fspi: use devm instead of remove for
 driver detach
Thread-Index: AQHbtOr+0qwBIKefDkWhn/dxcX1e8bO0usiAgAQH9ZA=
Date: Mon, 28 Apr 2025 08:20:07 +0000
Message-ID:
 <DU0PR04MB949641E4A006431C6D68B77490812@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
 <20250424-flexspipatch-v2-5-e9eb643e2286@nxp.com>
 <ed290edc-c310-4259-9b44-ad43c425cc28@oracle.com>
In-Reply-To: <ed290edc-c310-4259-9b44-ad43c425cc28@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU4PR04MB10361:EE_
x-ms-office365-filtering-correlation-id: 8ddf2e05-5938-4cb0-13a5-08dd862d7c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFBSU2wyVVo4bDRXWjljS1ZzSUFRNm1jZEM4STByeTFjTE5mS25Zd0hScDg4?=
 =?utf-8?B?NTkrTGFubG9VNFJxWkczbnRtVXozSCtkaDN5U2xDL3BsNHZVS2x2ZXczL0Jr?=
 =?utf-8?B?aDRHOVRvdmRIWUN6eFRvc0tucW9FYTRXa3VQWXNwaTMvU2lRUGgwNUZ5dlQr?=
 =?utf-8?B?MTArTUZGc1hLNkw5RVhYUkFaRlJIZ1JRd0FnYlliVmMrRVJRL1ZvbkJsV2tN?=
 =?utf-8?B?aURYRUd6WnNBMDc3KytEbXk3RTE5eG1hRTJTeUp6RGNCejBDby8yankvOFp0?=
 =?utf-8?B?cGI5L1JqYUx6dkY3em45bFB0QlBiVnBCZ0grQ2M5ejFuZEd5RXN0S2tyYmF1?=
 =?utf-8?B?ZEQwUjZEVURGeWVxTlBEVVlPYXdjTFRBZ3h2V2xrVGl2bjA3Wk5iRXlwa2xJ?=
 =?utf-8?B?M3RMVWZIVkFWc0liMWJuKzNCU1QvN2dBMVZpRkVJYnVPREVzT3U0S29XMktJ?=
 =?utf-8?B?ZjlYcXJHOHlJU3RjRmM4Tmt4bk8vMEpQaThiOHBUMVFoY2t4TUltUXQxN1BD?=
 =?utf-8?B?N2dFVExTdkVsMXdYYnE1WTB1dHMwZE5YeUczb1puSlJwazg5Y0s3b0RyeU40?=
 =?utf-8?B?NERpZmhnQmlLRnJ0cWhTTmZaSTBsTVFOa1NUL0ZPVlZSbjlpRXEwL2JGTXov?=
 =?utf-8?B?ZFBFcHNMcHptaUtXdGd0RiswRXB0dTM2aUZLY2tFNmg3YXIxQk5Nd3JaK2VV?=
 =?utf-8?B?RllWdldSUSs1T0s4amorNWliU3BmYWc0VG5JU1cydFV1V0h3dm9mVDZKbEI3?=
 =?utf-8?B?V1h3UUVNR3UvVWNFNlZwMWJ1dW5WaEZ3UVFmRHl2ZVVSVU5XemczZW9UTTdo?=
 =?utf-8?B?QWlxdlNkMkJ2ZzNNOCtjSEFic0d1aFVjZGYxSmdab3pWTW5xN2V1aEQ2Q2FQ?=
 =?utf-8?B?ZTNFUHR4b0lIbTlUMXNvQVlzYzRLWVBpVzg4NExiSzRiM25QVkoyZzdpRk5o?=
 =?utf-8?B?M21rdzlpdlJXd3ZjMENxWk12bGhtcTFIdjdKSzhwM2FFdDR6V1hzSkYyaHFL?=
 =?utf-8?B?MTM2RWZaLzB4bDRGcFoyVG5YUjhHMHA2ajROdlBiazgyYXU1U2JCRThWcTl2?=
 =?utf-8?B?NDNLb01YdldBMnVBN0dLQS9RaHdOQmxHSFpuUG1ZMklCdTFxeEw2bjE1UjBn?=
 =?utf-8?B?VTZnMUg4VnhZNHppcVczbFNXa0hJZjB0a3U0bVpKSmwvUEVWZWRtWXdKK0t1?=
 =?utf-8?B?TkdzbCtQQnp6U1BkUUswc29XRGpUNSszeTZ3eXVMUjlVNElqVUw0aDNmQlpx?=
 =?utf-8?B?ek1wdVpQbllnVG5IcHFaa0JUTDY1NHFiM0VJcVR4TFlPbDZPUVlUUWMxNEx5?=
 =?utf-8?B?VExYdjI0NjdwYVBqaGpvbVlFMlZxQ3pxU0xwWEZmSDB4M1NxQ2ZBV21nZUJL?=
 =?utf-8?B?enM1eDNIekdEUlNkV1FqbzREbHErVDZ0ZEFwb1hIdzJVQkFhYzFYZnJYSjFZ?=
 =?utf-8?B?VU9WQW84V1NzUVl2Wkl0Z3phVkVBMFR4bUtvMlEwWVgzTmRwYmRMRUpOaVNR?=
 =?utf-8?B?QnBrSkR4dm9pQ3hPM3laWVlHREtIdm9LS1NJb3o4azhrTnQ5UXFDV040ZDJl?=
 =?utf-8?B?a05sT1lvOWk2WVZMTGNPaFdJWm1SbjYxd1cvWDNybEt3NCtrQm05QW93ZzN6?=
 =?utf-8?B?Ny8vRWpFWEtxbEhPVHE5ZFRtVkdaUGRWT0ZQazdtQk1wVHh1aDJNNFU3NGZQ?=
 =?utf-8?B?enA0eVJ3NTB5Sm9xYXh0bW5TVGRxemIzdE9rMmFxbGlvSmxwa2JqRjVqZmZF?=
 =?utf-8?B?Q1BOMGNiNzRzUFIzQklqUkh1S2lIcExlVWJPOTkxTkpzdmxMTzN6VXlhdXh0?=
 =?utf-8?B?cWppcXBHTFo3Q0tqdjQ1NjV5RE04K1QvNlBqRGhCTzN2S2tZaU5TNUZGa01S?=
 =?utf-8?B?WHJ1UDQzQXp0Y2JnaUhRQ3FzeHAzYzJBU283NWtsTDRJRXlTZ28yMzBNWk0y?=
 =?utf-8?B?aWR4ZTVoblhFRjVsOWZHaFRubEtVNHJhamY2eGFOSEVsTi9iYWYralkyckhQ?=
 =?utf-8?B?OWUzYVRxLy9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmJhZjE1dHNYR1N1ZWlrWWN5M0ZvUmtsVkJMVDJ5RnErc09TaUVydWhmQWNK?=
 =?utf-8?B?WGV6cWFRL3ovVjBxZmc1K0d2TU0rNHMxWFE1d3UyUXc2bXVuWEVUR0JxbkR2?=
 =?utf-8?B?TUJRbmxuZTd4VUdBb0hKVEpYTE9FblYrT1J2UFdVQ21OR29Hbzd4OFpCUExH?=
 =?utf-8?B?Uk5HQ2dLWEZkSjRVVWRxcUIwVjM5dWtlbXNtNkZrMTdDZGY3UVQxUGRHRjBD?=
 =?utf-8?B?NTMydXdiTWh3OFU0ZjVVQld5cVdaV0grQ1g2M2NIQ0JGbFpCVkhuZ2NzY2tO?=
 =?utf-8?B?OENCamI5bkRVeWFtWTFhbHJ6VS8wUm1FY3p2VHBFT1ZSSGt6a2x1bjVRT3gr?=
 =?utf-8?B?RFZVQ2ZnZ3k4WjVzL21HdVdaKzd0SVVYY2Z5RmdVeDJ4WjVReDJ1cnQ3WE5q?=
 =?utf-8?B?akhhRVJYcGdEOE9IdVFON3BSZ1pDRk5kY3Z3RGNZVHo0dFBBQUJ5VGZtaHBU?=
 =?utf-8?B?a3FCNVpEcG9aVnlSMjk1TU8xaXFPbGdkVS9wZ1B3YmMydWxtWXgzandIVVdi?=
 =?utf-8?B?MmZ0WkhrVzNzZGJSTVNKOCtlekc5MEs2N0RmQUZzUldZdE5XUTZ2UW9XUzM1?=
 =?utf-8?B?bHVZdzBoTHA2QnR1allvK3A5bmxiektCTWFYMDl1WjA4UWx4QUg1ODNXVE5u?=
 =?utf-8?B?aHV6MlJVbTA2MEJLT2dSdGZDWUZpbDVSRkpUb28walBEWVhvSWpYSlJOZ2ZN?=
 =?utf-8?B?cFJMcHkrM3pubDdpUGZoNDZEWDVYVmRmZHFLSklRV3FRUlpSYks3dG9uR3dO?=
 =?utf-8?B?UDY1OXZRM1RyRW1Hd3JtaDhjZ2VoVzQyRTVybEJFTWZ4OEtuSjNlSDRBaWxQ?=
 =?utf-8?B?VHZ5NFFvNFpIbm81L04wVUhiVStiaTkwNHE0NkRUZ25oV2NXaHVZRXl4cEl2?=
 =?utf-8?B?SUxHSTI3YW5EMy95cy8rbCtKb0o0dFo4U25FZHBGbUhWbUtFRkwxQTBrcUg5?=
 =?utf-8?B?WFhUL283d2ppZ1kzQlQ3VWlZa0FOcG1jS3BhTWtVZkJEMXpTbW1NeU54dXJy?=
 =?utf-8?B?MG9aOTZ6TW83Y284NXFZeGhCOTdJSE9oei9PMXJwaHc0TDJHbzZrTUJ1L2hr?=
 =?utf-8?B?VjI5Tk8vdTNISi95QnhaNGZXOGVYSmtRRzkvMWNZYXp4YitQdGpuZGlsclo0?=
 =?utf-8?B?YVdlMHF4bTJ0QlltOHRWa0o1UVpTTnQ5UXg5WDJKbk4wbmVFN0FKNU4zRjd6?=
 =?utf-8?B?b1k5RUVaM1h2dmM5Y1FQbXBPZFJWL1l6M1ZMR0N0dk91QkQrT3RxME1DaXdz?=
 =?utf-8?B?c2diNzB0V2dEeUFSbmNXb3NZeDZiMXI5QjkrS204SXdqN1JLeEFnN2ZmdTlC?=
 =?utf-8?B?ZUtjMk1yeWxVdE0vYnZKSmRvc3IxYmJ1Y0hwR2pyZ3A1Kzhvc214Z2tlOVpr?=
 =?utf-8?B?ampIMWU5QWJUQXBpb2RUTEJWb0VZc3FXTEJOOWRKSkJXTENLSUZqMWEvb0tP?=
 =?utf-8?B?YU5HZy9LRUxvMW00dDMxMHVZOWRVNnh4NnprWlVXNWgyYzhoQzVEcFZpNkUy?=
 =?utf-8?B?d0hJd2EvSEFsSUxyZWQ3cU9tbWM2a2llblNBK1pLY2VnSFRjbmVEWkxBdW1m?=
 =?utf-8?B?UFZjeC9WNjJXeFViQmJnYk54dEgzeFhrOW1WNWU0R1dMeS80MzZNeWFlQm1O?=
 =?utf-8?B?UVR6WUw5cHlzMmdBaCt0WXFUWThXZTBXWEE4Y2lnUzJwR203VW1SNmVTd1ps?=
 =?utf-8?B?VW4rUmNIT0c1eUYwVENHUHU4Qlk1dzVMMTh6UFUwOTRPNlNmL084RjV1WlZO?=
 =?utf-8?B?U3RkdGJCb094Vk9kOUFZOHllR3FWM2lIZmE5cW05bkVCWk1YVTBqZGtXZmgw?=
 =?utf-8?B?cTVBQnhCOVpZZ3BENDZZREhFQ2FKUGJ0OHlsVkw4TVI5ejZYeGZkRkM2WXcv?=
 =?utf-8?B?M1phUmhoYzdHNWxnMVV4OVdKZUMxc1dpaXRjRGlzNWdZTmE3RGFuelhFczRN?=
 =?utf-8?B?Z3BZSkcySCt3VXlab1p2NGFhY3VxUmRmVDdMb1ExVDNUUE5xbXZvamlzeWkx?=
 =?utf-8?B?UkM1UEIzRTZodkhQVEpEcUY4amlwSE5rZkovZlBtN0JWcmx3Skpzd012cVJP?=
 =?utf-8?B?THQ0UkMwOW5UMlh4WnBvMVlqVWlsa083bXo1eHBUdC9wdVZMVExGQ2EzUzU4?=
 =?utf-8?Q?puzY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddf2e05-5938-4cb0-13a5-08dd862d7c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:20:07.3055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPXhn3+j6m+0FujhYIapRUX7kwUSeSmODg7jy2mFRs4szuR/Wy9IdjkAdCVYczJaYc9ZkL/adbM3NSld6YJQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBTE9LIFRJV0FSSSA8YWxvay5h
LnRpd2FyaUBvcmFjbGUuY29tPg0KPiBTZW50OiAyMDI15bm0NOaciDI25pelIDI6NDYNCj4gVG86
IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+
OyBZb2dlc2gNCj4gR2F1ciA8eW9nZXNoZ2F1ci44M0BnbWFpbC5jb20+OyBNYXJrIEJyb3duIDxi
cm9vbmllQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBpbXhA
bGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgNS81XSBzcGk6IG54cC1mc3BpOiB1c2UgZGV2bSBpbnN0ZWFkIG9mIHJl
bW92ZSBmb3IgZHJpdmVyDQo+IGRldGFjaA0KPiANCj4gDQo+IA0KPiBPbiAyNC0wNC0yMDI1IDEz
OjAzLCBIYWlibyBDaGVuIHdyb3RlOg0KPiA+ICsJLyogZW5hYmxlIGNsb2NrIGZpcnN0IHNpbmNl
IHRoZXJlIGlzIHJlaWdzdGVyIGFjY2VzcyAqLw0KPiANCj4gdHlwbyByZWdpc3Rlcg0KDQpUaGFu
a3MsIHdpbGwgZml4IGluIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiAN
Cj4gPiArCXBtX3J1bnRpbWVfZ2V0X3N5bmMoZi0+ZGV2KTsNCj4gPiArDQo+ID4gKwkvKiBkaXNh
YmxlIHRoZSBoYXJkd2FyZSAqLw0KPiA+ICsJZnNwaV93cml0ZWwoZiwgRlNQSV9NQ1IwX01ESVMs
IGYtPmlvYmFzZSArIEZTUElfTUNSMCk7DQo+IA0KPiANCj4gVGhhbmtzLA0KPiBBbG9rDQoNCg==

