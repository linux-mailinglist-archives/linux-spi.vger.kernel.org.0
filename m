Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA102C4F5B
	for <lists+linux-spi@lfdr.de>; Thu, 26 Nov 2020 08:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKZHXv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Nov 2020 02:23:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47533 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgKZHXv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Nov 2020 02:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606375937; x=1637911937;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s/5oXWacXRDU495EkNFXW/drjHOgSL8oZ7La+cF8cq0=;
  b=c09V4jIe63qIwZg2sNO3E7Z69ShRc3zlMI4Us1/au95dABqzA3RUOJH8
   oBpxI5m6zzZRZyPvhD7ATgJv8Uu3oJTa7ThhWaTaexWDZRSoW/HysFUny
   F8BadwbC9MSqBkJEJn2+Yyz1YfiHEu7hdhpetiH6d0zudjDp24dbLRbj/
   l46IqBpdxX+ZgAUGe4oHCbOSotte/pNekY603QYLivVdMKTYSSlQanEYu
   mwB59N1R7sQN7rg6izGyw4KO0F+kpm+Sx3C9Qhj7YMrXLROn7C6kjsmX1
   3kRI4hVYkXYjPD4FUn0yDSm27/ky7BhkQ4KHY1ffVgbxZgZ8GM3DX2k38
   A==;
IronPort-SDR: fe3zI9z36LxAy7RjMhQ/1SdD00yS0CWRkQNz12Jhkeuge3sKvWJmWx8LarIIH13QF3FClbfxGD
 EPfcvN5FS+qFRpxP4G3MMXgkmBielaZIk9edaPuHS19Yvj/yKOUp97+X/CWSjjQ51E198CCRES
 D1r2QN0IWpkDxIEWyWRzdad8LsfXsPZtW127+nq7M3oqkZnnAd6Kg7zswRXyYMWN61gLTgrM7d
 1xZO2HZBhH7T0tHjiIKCbOjrMxHG5eAgBPYHgb04FzpiHScVvhF8ZN7ACsf/USxv3lk+6ZoDio
 w6k=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="257172193"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 15:32:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ2oU+0cU/Y2r9OCntnPr2ohGKVCKO64I3ofL3uov4PXcnEsjQQTJd2igL9Yf7n1oj/pn/YN/PgUrTOt5P9vLyZTSLmDCWuLdCjDUyXjR0geTRZpm1kW5AczFtgShwhUpTgiSXPXnG+MbAbhhlz3HVOovuCpYsw3pfOgZ4CgOcc/sVNfKmxE8fiv7Lw8CPEllfbB58dxyTQjmmYbVMPeOnEcPx/HHV9wXSgHXwJggHNHVk2qSLcNJWlxzgsKSeJQsZgP1IQNgapFv/NNCtxNVxDtQhNrVmRTW9euC8BmJJh7ybLq8/YG0HWCl3bIbFlODNla0SNL49W6c7aEAlRkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GScAfNcHaoiKDVdrFQSx/8RRkY3Y75TxPmOK07Ck1Aw=;
 b=jEI8xnHXA27dOTQA/6Fu5WC/n/s5QEoSkc3WUBkvXFINxG5ROgHthBQsW3vs5TgF2wLRiorWqv+DEM7ei9ZBcSy/y4VTIQWtX1DPXFKV8i4nIqPZJolgr8euRsr6X34LCbOww+qADHu8m5DtZyYK0VmonPNb0/ZtF6xDy8CN36e5sk4DOkgTdl+mjTydwP50DxNgVJ86VNrzcvL0lwxTgXGLB/xZon0AT+qEM2hSlKrAMPl03/zAcG71JRxoB4s/pzjbtRpV4sTAk9bt4lEeIowzoX3KPi+BKP/eOF9+DQW+ZVgxCe/sSCsIeBM0X+GEXIthA+ckeyCQ58/MEVPFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GScAfNcHaoiKDVdrFQSx/8RRkY3Y75TxPmOK07Ck1Aw=;
 b=VoC/bcT7LiNezNd/O+mDr55550wNxk/6ousyE3PS3XsnT0HkmSRml11vknwLiMMy7w4/9WhRSKIlojYD+YR6xdVfhEbM7lJ30uEAOO5Yn3ub/RDYpZthHCQ4k3GzqsxOmeH8bP52t8YiCOi0bUTqfJqlfBYfcmddu8ssFMkhDag=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7077.namprd04.prod.outlook.com (2603:10b6:610:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 07:23:48 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 07:23:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sean Anderson <seanga2@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] spi: dw: Add support for 32-bits max xfer size
Thread-Topic: [PATCH 1/3] spi: dw: Add support for 32-bits max xfer size
Thread-Index: AQHWvmvw8As+5km3TUebXVhjeYQ6BQ==
Date:   Thu, 26 Nov 2020 07:23:48 +0000
Message-ID: <CH2PR04MB65223BD289204982B3A676C7E7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
 <20201119120253.390883-2-damien.lemoal@wdc.com>
 <20201125195221.3pnqipxej3ta7rlc@mobilestation>
 <82628758-d7a0-299c-51d1-4960dcea2809@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b00b3777-ce19-484b-21b3-08d891dc3778
x-ms-traffictypediagnostic: CH2PR04MB7077:
x-microsoft-antispam-prvs: <CH2PR04MB7077E23418636CB4D7F3002DE7F90@CH2PR04MB7077.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NB84ZrcHmxAzFfn5uWIRUjiG/TUbzVahXxQynRRIVl0yZ4cug2OgCB8FldocZD5GSIsWhOUowt6ttCLWIVZw6qDz24FvKw1NRIvZo9EC7Y1dvFt/476YABKUCjKnsJ99FoapvSJgF/GCX008+8cG87eXosfISncWRjdpMBZFMxwKsam1Ba1aKN1nqD4AwYTapxK27Hrm4cHDwv0jyhZj+2M0OCmI/aHF0gdTIOb3O2w5TR6wQeMdsfvhBOYlYPtkfkQlHQkEhikeWPQ6ZYalEf7HDej6v8fCz0yzixUpZR0O9hlfB8vrmymGYdhZA0tw+iYMjgGpCSE9dSBTgsjU0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(54906003)(71200400001)(110136005)(2906002)(4326008)(52536014)(33656002)(8676002)(5660300002)(9686003)(53546011)(8936002)(6506007)(83380400001)(55016002)(186003)(66476007)(478600001)(7696005)(64756008)(66556008)(66446008)(316002)(86362001)(66946007)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GcIlPVtgPHXjhMQC67DMleL1ebgoCHKBHKr5/EQPpYXnzwatSx2YV7AIFg42?=
 =?us-ascii?Q?W0ZdaKjcaaZOZbksBMSjzm8L36A6vtx4abH4z7bGss8NBreBrrmQKykSpgNx?=
 =?us-ascii?Q?3ZdzJDYK0Fv5LKc8YARMgfTy2T2cDTbSdCFtuP9qkCD2uJmiZvYHq1P/4zGU?=
 =?us-ascii?Q?IBdExz2RzMu2ayYBxCydLdFIE6pNwkr60TwPUdywDIov8QtuMJPdbs1Gtifg?=
 =?us-ascii?Q?SCNqsrYFGa595OTaNcPN7gD+xU0+VBWbqdILDX4i0hG/KB0sne7XEYkUlM0/?=
 =?us-ascii?Q?vtfnBTxl0Dt/KfDoSSZ8InvU3JDWK0yTu8xQlVj1KP55EUPdvUtXq5Y4HSpQ?=
 =?us-ascii?Q?RAEwgvm2wCIy8R7zSqtMG8/ofBmrQUDyUo807YvK7ljQMEVN5OpJBUF1kevS?=
 =?us-ascii?Q?UyI+0Hv238Q91aycFV2TDHaarYqOJD3ZX2bun6iuoxyydmQcRVax+rAFh+nv?=
 =?us-ascii?Q?kNhIceOjBVQQDUPow9jCZdgrrO20DY0NgC1vnW87NprNxJx69xcazu/Loutg?=
 =?us-ascii?Q?nwFHuyrUXd1Kf5LMAdJEUbexu/eyZKP6nThuMgZFMztRvr/3LWPFBR8p1E7j?=
 =?us-ascii?Q?G6tXfL1Kph7TuRB0nsiVFHGon2bEIyn+dgVsvtgen9qzdQuncPQszfeAk32+?=
 =?us-ascii?Q?ITtYnQqFj3fc5lOiDrt8NiXoI90XKvi4SXnF+cU+UK32cfzqnVFzqyGhhD0l?=
 =?us-ascii?Q?zJBGTRJydyxsdyE7/mDazre5Ym85yxQb08diZKgBUo02/Z93EQYFez3OSJ86?=
 =?us-ascii?Q?jWKtuf6su+YF9sFXSqXuIsxw+ZYj1gpJ02TU7BooFzH+LVKGAz5lE9kCGG5Q?=
 =?us-ascii?Q?+RYgUSKOQq3h496tINVhOQhDKQtb9OPdIPJutL2eVU6dyUT5RRk37SeKslrV?=
 =?us-ascii?Q?n/npr8hcdg+q3PptdOxpuXxLsgrJIO+y1pJ6PjYJSGhwbdSV6qTfYemZctg2?=
 =?us-ascii?Q?pVTma+VtwcUHyWysTFFLAPLcdumyECLAFvFWUBJKev4YVSHUEdRKMD59NVeR?=
 =?us-ascii?Q?72KFUxzJOwOUnnUSaY1OM5uG+l2KCX6DWtJ/5tI8q5cd3Q3KNQz6KO8koWQf?=
 =?us-ascii?Q?ACj0MPUt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00b3777-ce19-484b-21b3-08d891dc3778
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 07:23:48.1352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L91vKxBdaAI0YqpBDrJnsLLuX6subF/UCkjrvLUcGoCcuQXy2BszeJM/YZJdjLk192CIMinWz8jubu+uRWIYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7077
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/26 13:55, Sean Anderson wrote:=0A=
> On 11/25/20 2:52 PM, Serge Semin wrote:=0A=
[...]=0A=
>>> +	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {=0A=
>>> +		u32 cr0;=0A=
>>> +=0A=
>>> +		/*=0A=
>>> +		 * Detect APB SSI CTRLR0 size by looking at the data=0A=
>>> +		 * frame size field.=0A=
>>> +		 */=0A=
>>=0A=
>>> +		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);=0A=
>>=0A=
>> This isn't going to work because you need to disable the SSI controller=
=0A=
>> first. Then please revert the change or cleanup the register and disable=
=0A=
>> the controller back after finishing the detection.=0A=
> =0A=
> In U-Boot at least, ctrlr0 is written before every transfer, so there is=
=0A=
> no need to restore it afterward. Same for enr. I don't know whether this=
=0A=
> holds true for Linux.=0A=
=0A=
Same in Linux too. The base value for cr0 is prepared and saved in chip->cr=
0=0A=
field when the controller is scanned/reset and that saved base value is use=
d for=0A=
updating cr0 on every transfer. Serge point here was to have the DFS32 dete=
ction=0A=
not result in the initial cr0 value changing, as some older versions of the=
 DW=0A=
controller may react to it. The cr0 save/restore in the detection does not=
=0A=
matter for the K210 though. Since this is only done on scan/reset and not i=
n the=0A=
fast path, I think it is OK and definitely safer.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
