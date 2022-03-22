Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D74E3C7C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Mar 2022 11:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiCVKdu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Mar 2022 06:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiCVKdt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Mar 2022 06:33:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F45C358
        for <linux-spi@vger.kernel.org>; Tue, 22 Mar 2022 03:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647945141; x=1679481141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1gkU52w/6GnQ4zpHuKCMlgkLtH72l/sDZ5xjZ79EpHw=;
  b=TQyiDe5Wje9dTJD2Y8NlgRTr5vQcbQ9TK8fA084SFsZwa3wgNGcBZHIH
   hpz/zVtR2ZqdykoCJY+tY6DoMy61Yz5apyU3oEjDiIYi3iUdc7D6gDVQv
   gnUTf09GE/Oprj9BZO4lGRbpTOz5+4LlfuQMn2+Skdr41hjntnet2k5/7
   vcZbukz1bbhL60jJRaAmcrJJm8Z/Tl2xCI51/9r4l8Ir3RgSgIFkCmnWk
   OS3nQQ/2K12H1hWzg/cbKvqZbPEFWSFas+oFol4J3zpHe0nG/dRmzqnME
   YXbU0DYRE9hjYHxJNTkiFa17I0AcaL2rxDtd5JxpH/rHa3UrfBqJ1+fMG
   A==;
X-IronPort-AV: E=Sophos;i="5.90,201,1643644800"; 
   d="scan'208";a="200801853"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 18:32:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGzOZBEJeIzQs+XerTkDWoF4esK27864GFGMBTEPyVzmm2Fw8hbJtDFCsBHuuq0QHqiZXtC/7WqBhOjvgYNq+HdZN5xRsgbbDBty6PeqXcvn1NjSl+znUHv3BQtO8dB/NYTsmCyGeZpeVL/+6RoqnN23ziHjA9KYLQKePgJBDJaJKkSJrtXxiYPYm4ZMZZvAGItQEQOyPNSGCEvBMcACPF+Ad3omq592nBJSpMOkcxdXiKQ7KJaC1zQYJ86L3hO+VIemDDXxj6tJGE70Pd9+VmkigQprNCtd3R5Z8Jfn746gLoKU044qPyuhN9KeWBGzhrCan2zlfKnBfSMeJT5Yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gkU52w/6GnQ4zpHuKCMlgkLtH72l/sDZ5xjZ79EpHw=;
 b=JW+lk/DzyE7USALJL+ajS74eza2xGX2MT+LT6l5lEr6xMfHGT2HhsT6rFp69CAIAQnkeyhkzhnBkx6ePwOkoH4fxF2blZfSvv5QBPHxXdiK35+bZSBMq51NEOtPJJLI/7SYDJfBtle0LpzigWzoxXjwL7Em4st0jDwHdUagCs086KHxX+K5xVVgiVWAqZOKkhR7Ds8+BFdepaOY0cQZzDU1XsBy6eOiGXfo7Y0GcZ6YeqySFsrqPcVP1D++gZ5Gx8pCdY+3Q9zNsUeEZ9Cw2vzEwKydtCZiRCHG58iIQ3WdiptRzNcYOlKcsFDhLlVsHruwCYO3tJzmsbu/sWF4Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gkU52w/6GnQ4zpHuKCMlgkLtH72l/sDZ5xjZ79EpHw=;
 b=pfyqUt9mbfLRkEYFhuo5B/dFbSLS4Lr17vZ+jJ2jcb43OhWNbNc2hJhS5WWlzabn1B7il9dYLBsoQkhNlnA8mzi1a1RmctQZs9NpqXw/1tgj99FVhXHp5Muyw/k0p1/+pYoX12UUjfYgDBJUr+up13iNK4IampcceGTuPQgxOYM=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by SN6PR04MB4047.namprd04.prod.outlook.com (2603:10b6:805:46::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 10:32:19 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::995b:363e:8d1c:49af]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::995b:363e:8d1c:49af%6]) with mapi id 15.20.5081.022; Tue, 22 Mar 2022
 10:32:19 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Topic: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Index: AQHYLV3rnbk35M1FUEuh/urYvKkCb6y6TRQAgAAX5gCAABTXAIAHqt+AgAFRAwCAB9/FgA==
Date:   Tue, 22 Mar 2022 10:32:19 +0000
Message-ID: <YjmlsZl1Xg/Xkg37@x1-carbon>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
 <20220311142550.haw5jnrjycavr43m@mobilestation> <Yitv+tKTH2RpTV2K@x1-carbon>
 <20220311170558.5bj4vwbalufpmc3f@mobilestation> <YjHwCcRW0kXMhiLk@x1-carbon>
 <a5bc14e4a116717a68889f9a576ba9a332d25c80.camel@pengutronix.de>
In-Reply-To: <a5bc14e4a116717a68889f9a576ba9a332d25c80.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee7aeda2-add5-4f09-39cc-08da0bef3e19
x-ms-traffictypediagnostic: SN6PR04MB4047:EE_
x-microsoft-antispam-prvs: <SN6PR04MB40470BAAF66A6ACED51346BDF2179@SN6PR04MB4047.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOzdk8bCurjX3s0U8gc7J5ux5bHxUC+R+rGFtCZQ6eZpxFTpWO2rIrugYkrBH5WvQf4YWnjdvzPaHBt0fG+L2MX3QB0o3pD+SAzdDM+Y+FO6n51XvJ3PA7z49cRd+HMXIT4DkyJbRa2icAc90DdF5+IkXukp5DZAuGFTyRLJlbluav5xbTt1WNHUbU7+6OX+KNEWcYYru+By6SrSub7k6dCU4a2gZSi8PWDUoxJUr5KqA+yZ3DkF5dH7xS/02MWjRqDuxWprZJDBXu0uS6YN7F0q2omdGGr59DHYCPxmqQEA+qSEhPBMUW4P3FxjqL1RMxpRscaT1FhsrCVwWvQESu/dK4NCJ+LAUX/Q9F/ClphSOyTdoqmCnAYgY8hIwHXtLNI5vzqvL/mY7YXSuQn9XkC6JbjMgrdjVgzFbPUf2lXR2eauBjG/q15iCwGd4IqCWvxChAztmuLh3hYywCBHEUUmbKccwEpXaXNttqO34gVC234YU3Rs2IT/LXnjLjDDHyFJgcxqI1bbDC716VhFjoTkwL6fk4RtCx6IntyYN6dyu2VEYPz9cM2UPQiR8rRTz2+gYG/YLWU3Jtif8jUNGL/M/M9rfV0ohlXdksoEYqxBRUoPR9GGWyGwmAm9X1qFPwsVKt9jRiNOSgCNLI/mPUp3C+/3QMci2oV1Gq5PXHOx8nmmLKhn1SehLX3khcmSa8N6VLjmnW9KrVcEzF2xZMxyb2mUNy5umkntY+zQ7TPKJdIDPck7PKEujjyWDV1UR/lyDHSPsMKLxAux4sTCfZ+vpy2p2QV6jDE0tNUbX80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(82960400001)(122000001)(38100700002)(33716001)(71200400001)(966005)(6486002)(508600001)(2906002)(8936002)(5660300002)(6506007)(6916009)(38070700005)(54906003)(316002)(6512007)(9686003)(66446008)(64756008)(76116006)(8676002)(66476007)(66556008)(66946007)(83380400001)(26005)(186003)(86362001)(91956017)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlByZ3VNUWpkdlRHTWx5Y2lYUHVHQXl2QzRTNW82UXNVdGJMbkdiSWFRaUMy?=
 =?utf-8?B?QkthcDBXNE1zVFRkOGNURDQzd1F0bGh1dElTbnlVRllPbWduM1RzV0h6ZGE0?=
 =?utf-8?B?TFU2WTdOTUlzN3BFdXQ4blBnVnZDaEJPc1RkWHM4QUk0RXlCcmRiQWVBeVFl?=
 =?utf-8?B?cGxGSzZua2krd0FzbTAyVXAzSmVZRWtwVnptMHpsN0UzUlpaQnprZVBjWXdI?=
 =?utf-8?B?NURzZHdPMlI2bmhIUW8xbUVqd2lFUVNUbFRtT3poWCtZVUVQRms5U0VIZXg4?=
 =?utf-8?B?Yk1WQ0RiNXBqcGR0VWdyWEpCMFRGWTNnSzBEWXFYOTVXUVV0eFBnb3hLZkJY?=
 =?utf-8?B?SG05R1QvTFlUVlpqZzFtN1NtcGdhZEVDaUNTWkNNSmJqTDhzL3A5U0dHTktu?=
 =?utf-8?B?RFhjVElTbDBZUjdKajhmcWMxVHN5VkpVTjNyM0hEbDlPdEpYVGJ0S0RtNjY4?=
 =?utf-8?B?NnhFQUI2akpyRTZtMlVIbXhKaUxnMUJ5T043RmhFWXlQSTl2L2s4WEhMK2tR?=
 =?utf-8?B?L3hEK0FoV0h6dzN2U0ZYTFhoZlNVc3FvMi9CYmh6bmZnZTFWN1F6d2lNU0Ri?=
 =?utf-8?B?UmJGd3pPS3hQdWJRdVRLZi9SWVh2VUhKNzRja3BUZENCMmNnRzBTV3NrN0h5?=
 =?utf-8?B?NFdNazNWamYyWmVpV0hKTGJjVW51R20wb0xaWWp0cHYzRUVIZ0ZCTjg1MXV4?=
 =?utf-8?B?VWl3clk5QTMrL2xpQUNQaUlLZUsrbGNSZTRJSGFRK3M0TjRmWTIzYmcyaGwy?=
 =?utf-8?B?Y3RNcjh2OXdYSUtjMEc5YkJLbGRNaGJoY0ljNi9DOW5ZL0tLQkhOQllxTHph?=
 =?utf-8?B?V1BaNDlEdWQ5WHNvWWhsK3RoMWFvUi80MThORzZ2R1Z0ZDhiY2tZOE0yVkpl?=
 =?utf-8?B?VUhKeVQ3b2xTSVpVZFphZlQxcUsxdGtRbHY4eUg1NkFjQ2VTaXBSQThqOURk?=
 =?utf-8?B?ZDZiaUJJUGNUdkNjTkozTjViWTd2eTExa0thZFB6TUtTandOelNyb1BHK1g4?=
 =?utf-8?B?bnhGMHFyYnEzd2ZXNWZnbVJEUFFoblZGeUdGWFJCbGtJbXBwR3dlaDQvd1Fx?=
 =?utf-8?B?UDEzMnpRVFdEdzJhL2gyWWQyQ0lManhhZXhSR05sK21FQTFlaGFRbjVocXRQ?=
 =?utf-8?B?Z3pKbVhGSjVHY1JNTXlRNTFJWFRYVFp6WWlmbjB4UHF0L21TTGFYWldyT2VL?=
 =?utf-8?B?azUzTUNacmwvUXRGQTEzQy9ONU9Fa0FDcWNEd3dGWEl1VW8xT293SFZOd21E?=
 =?utf-8?B?N0JGVFVneTl5S2QxUFdhb2dDb2dKRGNPQ2NRblJBNCs3MGo1MkxIcmRISEl5?=
 =?utf-8?B?MmhydG0xR1plNDJzWUV1dytqdVJyeEM2LzBYdjROMy9XeWIvMHVjQXkySmxB?=
 =?utf-8?B?V25ERzNEejlUM1pMUTZoNXB0cUJaZS9XKzdYL0FGVGVtT29yb2FIRW90TDYy?=
 =?utf-8?B?WnJsK3d1Ym1iQ2hjaU1pSFpod2JYZkZodzBxTmNrY05GYXhzWmZZdVRTQXAr?=
 =?utf-8?B?NjYwK3ROcStuamYyQWM5dFU1eGwyQ1MzN0tIamU0VlpGdVdkU1VkaVkySXdS?=
 =?utf-8?B?TFRJTzJTT3dNMEZmSDhtWVNTbmVPNE9PU1Z5bVg5Y2lSRzdqNnBpWDU4RHc4?=
 =?utf-8?B?YXRlOS9pcngrNHI1Vk9BUlNRNzFtR1BIQ1Z5VDhzL25LMmxkd0ZEbHc2MFRD?=
 =?utf-8?B?dXdOK3RCZ2hEaGpRK01lcjJiaFdRbWZoNFcydTlMTjdmeUhrZVA4dGVDVkE1?=
 =?utf-8?B?aVE5YUhMVm5QNDNXa2JLZDMvMklxdFZVenY2empBTDZJclVtVWIzSFcveHdk?=
 =?utf-8?B?aTM3Yk8yTmNUUU43em9XMzRKQ1h6SURTdVpSZDY1c0k3NFNWYkV2ZFNYcFlw?=
 =?utf-8?B?ZkY0Si9MdkFBVnBraUNzZzdvT1c0aG05c3prMldaek1EcHFhNWZVVmFHcmdU?=
 =?utf-8?B?SDE2ZXF0UmU3SWRMUXd3S0pwNDNWeGN1QmFIb1ZkRVNhOWhDSzB4YnB3QjJr?=
 =?utf-8?B?OXdWQ0xGQnBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64BFE367A2877C4FA6E9D4CD3D65EA07@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7aeda2-add5-4f09-39cc-08da0bef3e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 10:32:19.2027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYdNhbMvOn5FuYIn4AEy0bx1HulciAD3xzfxNHT7BHPsedWk0gbeaGBdr7nq3hwy8nr9vugx2szvvPFQBqFANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4047
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCBNYXIgMTcsIDIwMjIgYXQgMTE6MTc6MzRBTSArMDEwMCwgUGhpbGlwcCBaYWJlbCB3
cm90ZToNCj4gSGkgTmlrbGFzLCBTZXJnZSwNCj4gDQo+IE9uIE1pLCAyMDIyLTAzLTE2IGF0IDE0
OjExICswMDAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4gPiA+IFdoYXQg
YWJvdXQgdGhlIHNlbGYtcmVzZXQgYmFzZWQgY29udHJvbGxlcnM/DQo+ID4gPiA+IA0KPiA+ID4g
PiBOb3Qgc3VyZSB3aGF0IHNwZWNpZmljIGZlYXR1cmUgaW4gdGhlIFNQSSBjb250cm9sbGVyIHlv
dSBhcmUNCj4gPiA+ID4gcmVmZXJyaW5nIHRvLg0KPiA+ID4gDQo+ID4gPiBJIGFtIHNwZWFraW5n
IGFib3V0IHRoZSByZXNldC1jb250cm9sbGVyIGxpbmVzLiBUaGV5IGNhbiBiZSBvZiB0d28NCj4g
PiA+IHR5cGVzOiBtYW51YWxseSBhc3NlcnRlZC9kZS1hc3NlcnRlZCBhbmQgc2VsZi1kZWFzc2Vy
dGVkLiBJdCdzDQo+ID4gPiBwbGF0Zm9ybS1zcGVjaWZpYyBhbmQgbWFpbmx5IGRlcGVuZHMgb24g
dGhlIHJlc2V0LWNvbnRyb2xsZXINCj4gPiA+IGltcGxlbWVudGF0aW9uLg0KPiANCj4gSSBhc3N1
bWUgdGhpcyBpcyB0aGVvcmV0aWNhbC4gT3IgYXJlIHRoZXJlIGFueSBwbGF0Zm9ybXMgd2hlcmUg
c3BpLWR3LQ0KPiBtbWlvIGNvdWxkIGJlIHVzZWQgd2l0aCBhIHNlbGYtZGVhc3NlcnRpbmcgcmVz
ZXQgY29udHJvbGxlcj8NCg0KTm9uZSB0aGF0IEkgYW0gYXdhcmUgb2YuDQoNCj4gDQo+ID4gPiBT
ZWVpbmcgeW91IGFyZSBhZGRpbmcgYSBmdWxsLXJlc2V0IGN5Y2xlIGFueXdheSwgSSBzdWdnZXN0
IHRvIGFkZCBhDQo+ID4gPiBzdXBwb3J0IGZvciB0aGUgYm90aCB0eXBlcyBvZiByZXNldC4gTGlr
ZSB0aGlzOg0KPiA+ID4gDQo+ID4gPiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiA+IC4u
Lg0KPiA+ID4gDQo+ID4gPiByZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChkd3NtbWlvLT5yc3Rj
KTsNCj4gPiA+IGlmIChyZXQgPT0gLUVOT1RTVVBQKSB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
cmV0ID0gcmVzZXRfY29udHJvbF9yZXNldChkd3NtbWlvLT5yc3RjKTsNCj4gPiA+IH0gZWxzZSBp
ZiAoIXJldCkgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHVkZWxheSgyKTsNCj4gDQo+IFdoZXJl
IGRvIHRoZSAyIG1pY3Jvc2Vjb25kcyBjb21lIGZyb20/DQoNClRoaXMgd2FzIGp1c3Qgc29tZSBh
cmJpdHJhcnkgbnVtYmVyLCB0byBlbnN1cmUgdGhhdCB0aGUgcmVzZXQgd2FzIGhlbGQgbG9uZw0K
ZW5vdWdoIGZvciB0aGUgZGV2aWNlIHRvIGdldCByZXNldC4NCg0KVHdvIHN0bSBhbmQgdHdvIG52
aWRpYSBTUEkgY29udHJvbGxlciBkcml2ZXJzIGhhZCBhIHVkZWxheSgyKSBiZXR3ZWVuDQphc3Nl
cnQoKSBhbmQgZGVhc3NlcnQoKSwgc28gaXQgc2VlbWVkIGxpa2UgYSByZWFzb25hYmxlIHRpbWUg
dG8gaG9sZCByZXNldC4NCihFdmVuIGlmIHRoZSBzdG0gYW5kIG52aWRpYSBTUEkgY29udHJvbGxl
cnMgYXJlIGNvbXBsZXRlbHkgZGlmZmVyZW50LikNCg0KPiANCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqByZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGR3c21taW8tPnJzdGMpOw0KPiA+ID4gfQ0K
PiA+ID4gaWYgKHJldCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsNCj4gPiA+IA0K
PiA+ID4gKiBQbGVhc2UgZG9uJ3QgZm9yZ2V0IHRvIGFkZCB0aGUgaW5jbHVkZSBsaW5lLg0KPiA+
IA0KPiA+IFdvdywgdGhhdCBpcyB1Z2x5LCBhbmQgSSBvbmx5IHNlZSBvbmUgb3RoZXIgZHJpdmVy
IGRvaW5nIGl0IHRoaXMgd2F5Lg0KPiANCj4gV2hpY2ggb25lPw0KDQpodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jP2g9djUuMTcj
bjcwMzUNCg0KPiANCj4gPiAoQWxsIGRyaXZlcnMgaW4gZHJpdmVycy9zcGkgc2ltcGx5IGRvIGFz
c2VydCgpICsgdWRlbGF5KCkgKw0KPiA+IGRlYXNzZXJ0KCkpLg0KPiANCj4gYXNzZXJ0KCkgd2ls
bCByZXR1cm4gLUVOT1RTVVBQIGlmIHRoZSByZXNldCBjb250cm9sbGVyIGlzIHNlbGYtDQo+IGRl
YXNzZXJ0aW5nLiBUaGF0J3Mgd2h5IHRoZXkgc2hvdWxkIGltcGxlbWVudCBwcm9wZXIgZXJyb3Ig
aGFuZGxpbmcgaWYNCj4gdGhlIGRyaXZlciBtYXkgYmUgdXNlZCBvbiBhIHBsYXRmb3JtIHdpdGgg
YSBzZWxmLWRlYXNzZXJ0aW5nIHJlc2V0DQo+IGNvbnRyb2xsZXIgaW4gdGhlIGZ1dHVyZS4NCj4g
DQo+ID4gSWYgdGhpcyBpcyB0aGUgd2F5IHRvIGhhbmRsZSBib3RoIHJlc2V0IGNvbnRyb2wgdHlw
ZXMsIHRoZXJlIHNob3VsZA0KPiA+IHByb2JhYmx5IGJlIGEgY29tbW9uIGhlbHBlciBmdW5jdGlv
biBpbiBkcml2ZXJzL3Jlc2V0L2NvcmUuYy4NCj4gPiANCj4gPiBSaWdodCBub3csIEknZCByYXRo
ZXIgZHJvcCB0aGlzIHBhdGNoIHRoYW4gYmVpbmcgZ3VpbHR5IG9mIGNvcHkNCj4gPiBwYXN0aW5n
IHRoaXMgcGF0dGVybiBmdXRoZXIuIChDb25zaWRlcmluZyB0aGF0IHRoaXMgcGF0Y2ggZG9lcyBu
b3QNCj4gPiBzb2x2ZSBhbnkga25vd24gaXNzdWUuKQ0KPiANCj4gSWYgaXQgZG9lc24ndCBzb2x2
ZSBhbnkgaXNzdWUsIEknZCBzYXkgZHJvcCBpdC4NCg0KVGhhdCBpcyB0aGUgcGxhbiBmb3Igbm93
Lg0KDQo+IA0KPiA+IFBoaWxpcHAgWmFiZWwsIHJlc2V0IGNvbnRyb2xsZXIgbWFpbnRhaW5lciBp
cyBhbHJlYWR5IG9uIENDLCB3b3VsZCBiZQ0KPiA+IG5pY2UgdG8gaGVhciBoaXMgcG9pbnQgb2Yg
dmlldy4NCj4gDQo+IEkgd291bGQgYmUgb3BlbiB0byByZXNldF9jb250cm9sX2Fzc2VydF9kZWxh
eV9kZWFzc2VydF9vcl9yZXNldCgpIGtpbmQNCj4gb2YgaGVscGVycyAobm90IHdpdGggdGhpcyBu
YW1lKSBpZiB0aGVyZSBhcmUgbXVsdGlwbGUgdXNlcnMuIEJ1dCBJJ2QNCj4gcHJlZmVyIHN1Y2gg
YSB0aGluZyB0byBiZSBpbnRyb2R1Y2VkIGZvciBkcml2ZXJzIHRoYXQgYXJlIGFjdHVhbGx5IHVz
ZWQNCj4gYm90aCB3aXRoIHNlbGYtZGVhc3NlcnRpbmcgcmVzZXQgY29udHJvbGxlcnMgYW5kIHdp
dGggcmVzZXQgY29udHJvbGxlcnMNCj4gd2l0aCBtYW51YWxseSBjb250cm9sbGFibGUgcmVzZXQg
bGluZXMsIHdpdGggYW4gZXhwbGFuYXRpb24gd2h5IHRoaXMgaXMNCj4gYmV0dGVyIHRoYW4ganVz
dCB1c2luZyByZXNldF9jb250cm9sX3Jlc2V0KCkgYW5kIGltcGxlbWVudGluZyAucmVzZXQoKQ0K
PiBpbiBhbGwgcmVsZXZhbnQgcmVzZXQgY29udHJvbGxlciBkcml2ZXJzLg0KDQpJIHNlZSB5b3Vy
IHBvaW50LiBNYW55IGRyaXZlcnMgc2hvdWxkIHByb2JhYmx5IGNoYW5nZSBhc3NlcnQoKSArDQp1
ZGVsYXkoeCkgKyBkZWFzc2VydCgpIHdpdGggYSByZXNldF9jb250cm9sX3Jlc2V0KCksIHNpbmNl
IC5yZXNldCgpDQppbXBsZW1lbnRhdGlvbiBzaG91bGQgaGF2ZSB0aGUgY29ycmVjdCBkZWxheSBm
b3IgZWFjaCBTb0MuDQouLmJ1dCBJIGd1ZXNzIG9mdGVuIHRoZSBtYW51YWwgZm9yIHNvbWUgaGFy
ZHdhcmUgYmxvY2sgc3RhdGVzIHRoZSBob3cgbG9uZw0KcmVzZXQgaGFzIHRvIGJlIGhlbGQuIFNv
IGZvciB0aGF0IHRvIHdvcmsgdGhlIGRlbGF5IGluIC5yZXNldCgpIGhhcyB0byBiZQ0KZ3JlYXRl
ciBlcXVhbCB0aGUgbG9uZ2VzdCByZXNldCB0aW1lIG5lZWRlZCBmb3IgYWxsIGhhcmR3YXJlIGlu
IHRoYXQgU29DPw0KDQoNCktpbmQgcmVnYXJkcywNCk5pa2xhcw==
