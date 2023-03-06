Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466C36ABEDF
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCFL5s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCFL5o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 06:57:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D6BBA8
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678103861; x=1709639861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FfgIIzTORfGLzT4fkd80uqs3FTdS28K+iQND9fty9x0=;
  b=NspkeQp0TL45iAmNwUyWU1RxnS4L/MEiNS74XbCe7md2XtxATpqp46PH
   m8wBKAbEoGIRTgzzunA5kiZuvwZAzyKpE63CYiwshmc/9r1SnU7kn8W2x
   UU5sGKoXxQMVPMr4Gu8e4ohczLKIgyHlg0x7EC5JlxNmgLO4cMqi7Ao4N
   uGBnRkVYXXtTpQDLhkuXiXDROl2Nx2YWWOgb4yXVoq31qSrLVRfUvtayu
   tmglcOSIp9SIMwy5Fb8zXtpN7FhyDkPirKzHW/2GIIxcTtmgRYOcrGyFh
   hARANjTf8VZL5z8ujhOVBVl1RXf4BfcnhnmOqQQlpgVrcNQM9yV1ivNZ8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="203821113"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 04:57:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 04:57:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Mar 2023 04:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiOPSI4PY8ioOHkqCv4gh9a5ATjgx8SJgHAbU0GasDmqhMmKe20G3miheTCJ6RvHRQIwEDDNy/X53CkocfLf8Bezv+AevL9RErcD/2/m1wejJS1oD8i3QFCuW5Z/kFYgvHa3kp4T1pv/PaTb00HDhrTdxLDsFm/kCm5xTXBNdMBRRbG0Y7f8YG0h/tccedzKILGg0pNbFI7NCyD1ZfwT2TxmJHDgVkJp4TbikBZZh3c7POwHTp98ZRuGeRjg8cwosFQM5KlWtEPkGQTqdMIulPmzb90ALAPwbe5hUi0ycfsGsIQUAn0ZfuQJRD362tWXgYrOAYI99J56fmBaXAIMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfgIIzTORfGLzT4fkd80uqs3FTdS28K+iQND9fty9x0=;
 b=iinFII9wQbYZ899etBcOcQ133D0wJbLaf84Rk53GbV2oB5QAkjSn1S9krcZu++aAeTgzKVfmLH/tSdHIfz98CXlqC6o0+gkYfdE2WBktEPNBE69+kVWSn5grWC7CSlnxsssZRHfjYPHN58CTbSIRHxc93OjI9M/x9DZU2pQvbxTHH29bFIyjap9Bo/0E5AgC93+1EjGvg3VP2QHEbMoi5SihR8zBUUck26igsu9C5CB0nABUbLV2rCyKtvGTtAM5tRJO2auVf74pT17+RuY+cUX1v6NXwjizVBAW1bTQqU6PClUza+ZBnMza/fuEdziorYHwSfBEHz5jhgro4cOSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfgIIzTORfGLzT4fkd80uqs3FTdS28K+iQND9fty9x0=;
 b=jiAMRHoeMK0FOlc62t9c9P/wryxC9kQUhDFZm39MKZ5L5wveS+vNTYbEReLrf9r9hC4tpwiY4fbCz+xsy9NacuUoxEhGejWHCMykxq+pRQdQtVVbRV4u3RmNFX/03tyZUJ95KuK6uo8SR0HlIBO3jKKQaEW2478/Asib7/+tjpM=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:57:38 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:57:38 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <radu_nicolae.pirea@upb.ro>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH 04/87] spi: at91-usart: Convert to platform remove
 callback returning void
Thread-Topic: [PATCH 04/87] spi: at91-usart: Convert to platform remove
 callback returning void
Thread-Index: AQHZUCLYA2B5MoxLgEyoTSR8tQo4Ag==
Date:   Mon, 6 Mar 2023 11:57:38 +0000
Message-ID: <a98b763e-5586-c940-4848-98ff851db637@microchip.com>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303172041.2103336-5-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5557:EE_
x-ms-office365-filtering-correlation-id: e6ff8894-4cc8-43bd-dd76-08db1e39fb72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tg9//YpCx0/VNglGiazFJdv2xAaX5Kg1nz65rxufi7fowSF9RLD4baHyYsA3xmp9fDvdeqawq7YvFoTpQ7je4bs2ihAtESV1v7RAKjdI5ZScWkTlMoIrpAk/YZq5iFOjScPC8keEdvuy0QI9nug/6dOCECh59K7G+PSIQW1MBWJMcERY/o18xo/NH1d5VGlq6UcKH6GpURuWf0tcbA0V/1tG9xJ8fU3IGYI59N1Otxagrb96yfrNcnW7YJINyQUFj/PSO9Bm0ZzkciH20wvQqoboMN9xGxwIkp0KvmL51v1VvEwOJGdo8Mc4G6u1s4174itjxyoiShplb5MJont2qZlhcsTQBZEn1NVhaRJMYX6KlmX5PHx+NZyra2Vpg0pUQp2a6TfaS+Q7SS6Ja4HUncHRrrOg/+LMpHtRfGn/eefn3D+LsYV8sIitjeQjfE6Ux8OvBV/HMni70K7rx+6xCBNxrArslK0yTX0lYz4eHCiOr31WmL0llYY8Aa5v1PLBzGhJH0PMcZM1bWoKueN38cQckDazBwb6jZh2RtNVQKZfPxScVS65OYWc5giMU36RDVOQ2bXC2XL6so2xSmaXzGzBM++ZR+Ft/+Ea4MYl22paENT4Lw9tH/zcFAEHnY7/BfESktVKVGwBTeO3JM5d+iNsHZRqpfkE1ym86o6JY6U2qEA7ycwzXYwg9RInaFDxR1PEv0navlCpZBGa8LI+6l3OCZD90zQEt00P3IEnDIFHqrekZ6W+W7FN7SWriOEzvo+qXyRogTbegZ/Ju7HxzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199018)(6506007)(6512007)(53546011)(6486002)(36756003)(38070700005)(83380400001)(31696002)(86362001)(122000001)(38100700002)(186003)(26005)(2616005)(41300700001)(91956017)(66476007)(66946007)(66556008)(76116006)(66446008)(4326008)(8676002)(64756008)(2906002)(8936002)(31686004)(5660300002)(71200400001)(316002)(54906003)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ZlVS9vM0tSTU92ejhCZExJdEtKQUh6eHYzeTNGVFg4aVRVQmQ0Tml4Z0ky?=
 =?utf-8?B?cFU3c2ptUVJtbEtrT2YzdkhhTjBaN2FOVUtrTWVDcHpkWTBqd3p4ZVJ2dmtl?=
 =?utf-8?B?L3ZjRUozK1hxRXZZS29HVExyNTRoaHdnbTJKWGJ3ZnIxMUViVmU2ZFF1dlk1?=
 =?utf-8?B?NHN3YzM4RVpYdXpSbUphY0ovOE9HM2M1VEthZmVVenNJcW9pZHIwci8rWkJK?=
 =?utf-8?B?N2J4Z0x3bkZ0ZmIzakVUZ3QvbWczdEFJTXAwM1NUWk8rT1AxS1BSaVdMdjZv?=
 =?utf-8?B?WXlqUnZvNjNOOU5NMXhyWUV2bmYrSFA5YWpZVERDdGhGRFB3ejJ4ZGNDTVdH?=
 =?utf-8?B?SWNvNUJCUTFLWVlWRnhiTTRFdGhnUVNqWUQxbDlzWXNuekw5SEhrOXFDUUgz?=
 =?utf-8?B?OW5kSmNzT295N0pZTm1PbTJYVXlESjBMeVgydkFQbmxFckcyNEQzZU8wUDBz?=
 =?utf-8?B?Q29oNFNaSlBBWGE1NVNaVnNvazZHcHEra3RQVVhsZlYydVFhOFlWUUpLbG1J?=
 =?utf-8?B?REdsQ3ltckUxcHBiTHhSeEh3dHhjM2d6WFdTRjZHSFNNSmx6aGkzVnFqSmRT?=
 =?utf-8?B?REQzNjdzUUQrRjU5Zzk4SVcyUjAzaEIwV0hZUHNiQ2luck9sbVp1QmF2OUV0?=
 =?utf-8?B?SkZ5enVGVzV3OEdLNjR0OCtrb29NZVpsS0U3NW85Rm55VlVjMnJleDRFcVR0?=
 =?utf-8?B?ZVZ5eXU0Z3ZpMG51MjEveGw4RnFKQ3lmWTZNVUZObUFQbXdxWEFvaVFTTC9v?=
 =?utf-8?B?cElxVU9ZYlJJTXFnMmkzb3EzTnRKK3l1Vjc5bk53bWRqMTJxdnNkQ0RwREpu?=
 =?utf-8?B?dFJUNit3LzNQaStlS3AxWGhpcEdETWMrNldPajJFdTExcGY0L3lQcm1va1lY?=
 =?utf-8?B?M3M2cUVIUnpWcGtKWDZQenpKUlNVMHdWMytsZ3lvZVVicFVYdHB5OXp6eHBF?=
 =?utf-8?B?WEZuSHpVVHNvYUx1MVA4WE9zQThVeWd1aHR6YWIzNEJFN21uaTBVTmtnNjVI?=
 =?utf-8?B?ZUtsTFRQY1FzUkRmOUpPKzl3OE5MWGhDem5qc2lHbUx4clN1ZkRzTnQ1L3Jz?=
 =?utf-8?B?UEFaSTlVS1prRTBYNFZCdXF5WWs5NW90Z0QyZERXazhwcTRVSHVaYVkrampV?=
 =?utf-8?B?NzgyejZJUEZaV1FsNW04M3JRdytZT09UcE9ZMmNYWjZnNGZyK0p3azJrZTJw?=
 =?utf-8?B?bHgrTlNWYUtrdHNwRXJQaVA1ZG1JRjd5a0hSSkRHLzliMjJSak5wOFFiKzQx?=
 =?utf-8?B?WG9qUkRQb2pQdVdBNEdWV0RWb3pLcXBHK1g3T2tSWk5PL0RWeDZqY1hlN3Yw?=
 =?utf-8?B?TlFXOTBpYjNJbURyc1JuSUVJMVNtYjJmYldKVEJwVlo0L0NHSGZwR0tWMS9O?=
 =?utf-8?B?aDZhYitQZjIyS054U0FSSFNRcHFGZ3hzS09yS3pKN1laZFV1Z0RTekIvY24r?=
 =?utf-8?B?NXpEVUNURW5BdWlBaU9JbEduU3dMSS9mSDMrMmZCSjhZbittSTJKWTl1eG9T?=
 =?utf-8?B?WE9Nb3puTHBXc1dVNzZTcVFraTNjTlVLVHE5RnkrcVhjSHZmU0hNZWtCWFFQ?=
 =?utf-8?B?TmdTLytnQnpzWkJ6anFCbEJmMWJrU0paV3hTNEtlSzhkaVI0cjZURUlRNlM2?=
 =?utf-8?B?VDd2QzRQZER5WUVyR1F1RFRSQmNpL29CTnRLcnRjeFo0RTJ2UCtaUUZJV2Yw?=
 =?utf-8?B?SHRVQVcyTWR1dllnQVRsenEvUEtVcS9ldHZMRFU0UDVvZ0xIVVYxN3UrT2ZG?=
 =?utf-8?B?VUQ0MTA4MVpkY2lXcmRTN1J1bGFTY0xJd0RVQzBtWlBrandFSDE1cDd4dnFk?=
 =?utf-8?B?M1VMejloWW11NmEzNXczejZZalE2MVpKcUZHQ3pUbjI4Z3FXRHp6czNzelFs?=
 =?utf-8?B?Q1MvazF1REFVT1BLQVRxSnJQQXZ0VktRUVNrZ0lyeHVKM2lKRmdVN3JyTWNL?=
 =?utf-8?B?ZmpZUEFWS1lZa3djL0o1OGRsNU5INVk2R1N4UktsL2dUSkpScERQSWxBVFp6?=
 =?utf-8?B?N2xwL2IycDhrRTlJY1ZLMENvdUEwRk1yc05lYmJia3VUUmlYeDYvaUxseGww?=
 =?utf-8?B?aHRrNXpBVHdCTHJpdEd6a3ExVkNuZGdIR2hhbEJTUExBck9oV3BFWER0MExn?=
 =?utf-8?B?NXBuUVpXWXZlMGZQRHFFZ2JPU1d1SjVJZFZ5SkNnbGZxZWJDbzJyaEVNWWg2?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36656AD76A3C5D4096C1A4B6F598DFDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ff8894-4cc8-43bd-dd76-08db1e39fb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:57:38.3010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aaAOzXwvpCEB9Ku48pLXjmCuLH4jXj/39gGm14M+Of2LiydX0OzunIdrRbLk+fWzhdwKQcznUv9sRSVk6WYsS2NnRU9fGdk6wX0U8HESzLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5557
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMDMuMDMuMjAyMyAxOToxOSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIC5yZW1vdmUoKSBjYWxsYmFjayBm
b3IgYSBwbGF0Zm9ybSBkcml2ZXIgcmV0dXJucyBhbiBpbnQgd2hpY2ggbWFrZXMNCj4gbWFueSBk
cml2ZXIgYXV0aG9ycyB3cm9uZ2x5IGFzc3VtZSBpdCdzIHBvc3NpYmxlIHRvIGRvIGVycm9yIGhh
bmRsaW5nIGJ5DQo+IHJldHVybmluZyBhbiBlcnJvciBjb2RlLiBIb3dldmVyIHRoZSB2YWx1ZSBy
ZXR1cm5lZCBpcyAobW9zdGx5KSBpZ25vcmVkDQo+IGFuZCB0aGlzIHR5cGljYWxseSByZXN1bHRz
IGluIHJlc291cmNlIGxlYWtzLiBUbyBpbXByb3ZlIGhlcmUgdGhlcmUgaXMgYQ0KPiBxdWVzdCB0
byBtYWtlIHRoZSByZW1vdmUgY2FsbGJhY2sgcmV0dXJuIHZvaWQuIEluIHRoZSBmaXJzdCBzdGVw
IG9mIHRoaXMNCj4gcXVlc3QgYWxsIGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0byAucmVtb3ZlX25l
dygpIHdoaWNoIGFscmVhZHkgcmV0dXJucw0KPiB2b2lkLg0KPiANCj4gVHJpdmlhbGx5IGNvbnZl
cnQgdGhpcyBkcml2ZXIgZnJvbSBhbHdheXMgcmV0dXJuaW5nIHplcm8gaW4gdGhlIHJlbW92ZQ0K
PiBjYWxsYmFjayB0byB0aGUgdm9pZCByZXR1cm5pbmcgdmFyaWFudC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+
DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLWF0OTEtdXNhcnQuYyB8IDYgKyst
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1hdDkxLXVzYXJ0LmMgYi9kcml2ZXJz
L3NwaS9zcGktYXQ5MS11c2FydC5jDQo+IGluZGV4IGZhYjlkMjIzZTI0YS4uNGZiMzY1M2I1OTQx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktYXQ5MS11c2FydC5jDQo+ICsrKyBiL2Ry
aXZlcnMvc3BpL3NwaS1hdDkxLXVzYXJ0LmMNCj4gQEAgLTY0NywxNSArNjQ3LDEzIEBAIF9fbWF5
YmVfdW51c2VkIHN0YXRpYyBpbnQgYXQ5MV91c2FydF9zcGlfcmVzdW1lKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gICAgICAgICByZXR1cm4gc3BpX2NvbnRyb2xsZXJfcmVzdW1lKGN0cmwpOw0KPiAg
fQ0KPiANCj4gLXN0YXRpYyBpbnQgYXQ5MV91c2FydF9zcGlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICtzdGF0aWMgdm9pZCBhdDkxX3VzYXJ0X3NwaV9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3Qgc3BpX2Nv
bnRyb2xsZXIgKmN0bHIgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gICAgICAgICBz
dHJ1Y3QgYXQ5MV91c2FydF9zcGkgKmF1cyA9IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRhKGN0
bHIpOw0KPiANCj4gICAgICAgICBhdDkxX3VzYXJ0X3NwaV9yZWxlYXNlX2RtYShjdGxyKTsNCj4g
ICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoYXVzLT5jbGspOw0KPiAtDQo+IC0gICAgICAg
cmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGF0
OTFfdXNhcnRfc3BpX3BtX29wcyA9IHsNCj4gQEAgLTY3MCw3ICs2NjgsNyBAQCBzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBhdDkxX3VzYXJ0X3NwaV9kcml2ZXIgPSB7DQo+ICAgICAgICAg
ICAgICAgICAucG0gPSAmYXQ5MV91c2FydF9zcGlfcG1fb3BzLA0KPiAgICAgICAgIH0sDQo+ICAg
ICAgICAgLnByb2JlID0gYXQ5MV91c2FydF9zcGlfcHJvYmUsDQo+IC0gICAgICAgLnJlbW92ZSA9
IGF0OTFfdXNhcnRfc3BpX3JlbW92ZSwNCj4gKyAgICAgICAucmVtb3ZlX25ldyA9IGF0OTFfdXNh
cnRfc3BpX3JlbW92ZSwNCj4gIH07DQo+IA0KPiAgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihhdDkx
X3VzYXJ0X3NwaV9kcml2ZXIpOw0KPiAtLQ0KPiAyLjM5LjENCj4gDQoNCg==
