Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8B6ABEE0
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 12:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCFL6C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 06:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCFL6B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 06:58:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE89005
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 03:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678103879; x=1709639879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8e/5HThmg6u1kKcsmCuax8hld2pAgKntXGa5WeCBAmU=;
  b=RgNGdL9wXkeXuGHpqzQtP3tJh943WJqdgI6Ls9PbqXTNGln87+DfIcM2
   PLIO635S628EfaG4dhED+4DFoyXtAxNaowH4XzGC1adFabppHkrNALKjn
   jZasV1wDH3lCXDl4gncYyMow1ODsS0IV7VJJIssy9vBoT7L+KFUasWKZZ
   8XKZcTQa9UOH1aaOj8GOAWdG2PEuU46Qe+LR5FIDEIZb3o/1UW74aidOc
   973IpwqZuKaA8s3BHXIn0GXROhusL0U6OL/STl8ehoEPOe42g9QwYEbIk
   oB+c97Whcr66JWojk3R9NHuGcSCX7Iff/d2BWyabaTf8YCuBCJ2b+TJNT
   A==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="203821178"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 04:57:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 04:57:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Mar 2023 04:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONBSUsRDGaBDHaN6duZjGFJhi+RAcNuAjN7iLa2/UBkYvhIVhVGeMMMsNYTcyAPiAue28x9do5aCagUHPW70PFft0ObrqVN1Fvo+AGZ1T3iwGeUSATwS0OZY2R69Bq/QwdkUrDSuTP+lX4C9W4kcwiaPqhfrVRqAXhua49Dhi1fKxK7E1lyZ0n1JwHCYnsShydpMhltjQMkP+kqNLDAYyX976dXiffRQAWYFAARYeiOODJQ66h01dcEbyOgnWa7h66PeOADyvbCJI+RcfiGOANGy9fhzUzI4StcI98Shi+gd5mo371JZeKw/Zto5hgN0s12WVk8c5kiAbRmynLmBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e/5HThmg6u1kKcsmCuax8hld2pAgKntXGa5WeCBAmU=;
 b=Q5v8fD4Jz9dTRqWFZPvKNbtZQbEf3XzpdhOm/ffaRWY83q+87X8qEvvFn0EMA8pCV2r5BZsil+RV/vRWp+1kvH1tjBC6Agtivuhea82EBLxLN/Px0bR/uNao2/TwoS2MKlLkMy5/Fx8kTGNs1DSLRMpsJTGXIt+ehQVtChmXT06O1+fKKjTypEnkL4WbOfBhdi9p92DofcJPYZf+r48drPIwvxlUGR5K9NW99brPAV8wY2lMOQEnqG+vjkVFzCHxpi/bFfreHUyiqmOqcEbaeUXqj7jSMuGQcN9M2lCs7b2nnHo60GOS5WlCa9FV9Kx3r9lkDqWCW/CtSHXUrycAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e/5HThmg6u1kKcsmCuax8hld2pAgKntXGa5WeCBAmU=;
 b=VZybACqIZzfKFVceaCj3PdR/XSO5TDumcrokPh1M9EXGJLgq0w9rt5RGwfpIYa/Nrm70rZ8EFqe451wDAIUETWkPQczlODSzqUrDT7xr+bnYUfc6xjbqBL2qvAOLbyoH8FPr3LCd+3UzbZsISSa0ayZHISncMRaBOXYxJqmVMAU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:57:57 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:57:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <tudor.ambarus@linaro.org>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH 06/87] spi: atmel: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH 06/87] spi: atmel: Convert to platform remove callback
 returning void
Thread-Index: AQHZUCLjMP3awUvSCUqxQYKX1rK34Q==
Date:   Mon, 6 Mar 2023 11:57:56 +0000
Message-ID: <356ea801-98ca-3f31-7d6a-2f8c6755432d@microchip.com>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-7-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303172041.2103336-7-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH8PR11MB7141:EE_
x-ms-office365-filtering-correlation-id: 049fb878-8ad7-496d-2df3-08db1e3a0639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpKa+lcpJtgbu6CY2+G6Ubrn6oqqDsHYCdAjiUwx3BqsUj/STOtI2h52qa33ufWN1sL0K0LqVwtV6vL+ngFI10g64udtRQUQlC2UvrhXTXkgY+IrECnB5jl8rhHRLkj1Td9XyxIi9EUo5iRfS/DbeFp4y1sJQMRC/cRDJBC5x9+8ydxfVhudtO8XIVM41oqMFy8IZ4GBxaSy7+epfq9AIyrnmjc9kimbqWIOZ6sasco0NHwNI1cvdeb2PdqgS8rID2QzJwHnrmlWmyOgF0Ce+oKGcBep2nxNct7p7f5w3ssVclKaX7WrMQRA3H6XYRsXPur6QRgANxNgBrpSUP74YN0ioTowAcldYm1IMw3OSgpyKc89g8xXAOhVTBOYV9PmS9mLw9YYklpP9fa+EmLTiCb8YoTV+5Rn1RZ/5uzV9ez4wNtdUlW9QKAm+cucpVE72Z7+WaZnQUCxjPDteFt3CVzEek47hKGz3y3ZcVvGRj1mstj3ynoCL6KtcXEwjXjMW36itWIGZeEpRNdbA8AzbyslIDqTdgthcpP6iQKa0nYXcrJh1gNu+bWR1fj7Jsupu0oiDv75JfbEz9/Xx3pCioLrsLhf4ez7zbcHYU71fAsMZGE31P+ZmorGWi4uzjHuN3wcHL+byJDHpQPZVBJkLrtpzWXWmSShlBPz4P2ffbJAm4/G8AYUIWEi1rCNOltLKTGFgHfu4/Nfj8MZsmuNIViSiEMaupVb78H2OB2wnbl8aUxSapgZs3miwnO7YpdVckCPr+HvvTBXEEBgb8k1WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(186003)(91956017)(122000001)(38100700002)(38070700005)(8936002)(66446008)(66556008)(66946007)(41300700001)(66476007)(4326008)(8676002)(2906002)(5660300002)(76116006)(71200400001)(66574015)(478600001)(53546011)(2616005)(6512007)(6506007)(26005)(64756008)(6486002)(316002)(110136005)(54906003)(36756003)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzdpYjJUUXlLd2tpa29HZGV2UUVmcmwreGgxemNuSFE4eXpDMkxNVUZ3UXY4?=
 =?utf-8?B?Yk9uR2hXQ21lL0wva3hHTzFMTTlMaU05R0VOSnI1ZTh5ZEs5NkVWckd3WVJK?=
 =?utf-8?B?K0tyNURRWWZDOWZEQmltZnBVajRZUUgwdkFGZHNzblVTOTQ4NFVEZkZ3c0th?=
 =?utf-8?B?ZGllWUdCNmgzcjFCRGx4cWRYT1RCMk9uUEM0a2ZtQUhGdjhkczV5SGw2RkI0?=
 =?utf-8?B?a05PVDk3d1NNUERjNGpXamxVMmpuR0ZpSk9QZHJ1MlhtNlhsb0M1eHlOUGNh?=
 =?utf-8?B?VlQ2VjFGMW1sS2ZwaFd0Snd4T3R5UElHM0MycGtDVGc1YnBDNzNCTFZ2U2F2?=
 =?utf-8?B?eFAwV2dhaUdPU05wcXVwcUJ1NC9nSWJFb3hLZERpNFNYcXg4eXFkb2NCQUtM?=
 =?utf-8?B?a2grMjVJWUpXSUp1U0tUSVVsbldESlk1TmR0bHVhMVBVclh6Z1ZkRmd3SlM4?=
 =?utf-8?B?NzVwQU12RmdiOWhGelR0WkRiZ1lhQVlFVjJZSEdMSFFIUjU0SE5WVzJqWElS?=
 =?utf-8?B?ZXQraURnTWllRHBkUVo5b2NOeTIwdDZKYTRreXNJWVRwUFZGU08zWnhVcnQz?=
 =?utf-8?B?YUJEc0d5K2pvM3JjYWQzYTNBS3lySXBJRzh2MUdFdnU0Wk9rbW1IK0s3eC92?=
 =?utf-8?B?dEkwZUo3VDFYUm9mZXgrT0hVWDYwWXEyY0dHR2lqcjl6VnluV0hnY0YrR05K?=
 =?utf-8?B?TmQ4alJjWmF5bXlCM0M5QVMzQ3FtZEZLcDVGcjVzRkdpb1RRV1BMK0FDSHBO?=
 =?utf-8?B?RUlRNndnMlMxblNoMkgvdXY0aWptR0lTd1QyR3NPN0hWT2wrb0E0bFFYRld6?=
 =?utf-8?B?T1R1bjJBdGFnZ0Q5VnBBM0Z0OGt6bTJyZ0U0SGZLNFZYQkttY041ZC9pVCtn?=
 =?utf-8?B?RTVtZi84TlFPS1BDZzV6ZUNDU2dwYnI0RFpQcWpwTkpZQlFDTVg4WUdFeW5j?=
 =?utf-8?B?SDJFR1J4VDZ4cWFJeHBXemJTWCs5a2hYTHRNTTBERU5GekxCUjJEV0dnRWFH?=
 =?utf-8?B?V1N4QUlJYUtZdXRZTS9vTFBBN01RR3RMd24raGhYVXBtUFpXVCtPeHdJS01x?=
 =?utf-8?B?OEJRZEVvRTdTWWZnR2dNRGhqcE9QcmJBOWwzY2M4cXgxNzhxN2ExOW95Nklt?=
 =?utf-8?B?dlc5Tk0zZ05YMWdFMm1rYVRDOVZONWJQM3dISGhXQlFSYTFZTHZxRUhvTXNx?=
 =?utf-8?B?SEhrUzQ2QjJzTTNMYWpoV0JVVk05NlRRSldWVzFKd2FTNzU2OXdpK1dac0hN?=
 =?utf-8?B?WTQzUThhU0ZtUU5uKzVsdmpIaFU0ZVVVSWkrelBMRWxBc1BVWnJDYm80Zjln?=
 =?utf-8?B?UGhINW5XUnVORW9Ldk8zenVyNFY0TGMrS1hQTHBiZVl5VTcyM0s5STR0dE9F?=
 =?utf-8?B?NWFjcytscFJKZ2xEd1V2eGdQaG5oQVJwbkFCQTVXMWZrWkR1MllZRUpyaTc1?=
 =?utf-8?B?SStmeHdUdk1HL0NmTXdUd0VrNHRSUHFHVXZPaEtEL1prbmpjZmQzSzhSYmlW?=
 =?utf-8?B?QmFZTS8zVEQrOFZLWStSTVdRemtsN1VwdDhzU2xYaExlZGUxS0RBczZYSEd5?=
 =?utf-8?B?QytjOGl5WTlFMHEyMHVUWFJTc213c2s0Z3N2Q25EaGkyMzZaSjE5MUtHeGFu?=
 =?utf-8?B?RE5zYnVZUkdvb1BWVGZONTBGUWhyMkNBZ2J5UTNlbEs0NnppdVlUalhrNlc3?=
 =?utf-8?B?cmJOQ1NwWVVVUDhua1pVL2k5bVdHYU4rUnVxR0NiTEdIUEt1cndZU2tJUkFr?=
 =?utf-8?B?ellhcHVzR3JWeHhaVUhsamRvUlNncHV2RnBDN1JmdXdKRlFHWnpxS21hR1JW?=
 =?utf-8?B?RU44azFwbEFOdklFWThlY2FjMjVtaEhxdm9VcldFdFIvZUlDNkFQTG8ySTN4?=
 =?utf-8?B?SzVyT1dKdkowV0xVd1ZzaXhUZEY1R0dvUHpyTk1mK0toQitKTVI2TDBuZ2Fa?=
 =?utf-8?B?dVo2RmhDV3J2eGx0dXZPVXNtSHcvL1lmZmxDQnJsajFEYVBSSXlwZE5GZVJD?=
 =?utf-8?B?TjVzaW5scVg1OVhseW40TG9UVFczOC93STlPL3BzTVJ0NTZxam5XeXZwVTdV?=
 =?utf-8?B?aDRLcldWQnU5d3kvbHF1QjNkVjVtTGxFREhMNXJib0F6Q01Zb1ZNWkpHc2VD?=
 =?utf-8?B?UGdQbTdVRHhkNFRnWjNWVDdLc2w1WGVuZmg3RmNSYXgyS0EvOHQzNWpsMjRS?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7773CBD0DF9E5848966BA13EAEB853EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049fb878-8ad7-496d-2df3-08db1e3a0639
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:57:56.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0YvDnYTkXa+s1mOQTrDZZVTcpUI0QLyIj4tJMW7TCnTq3Oq/yVz+KwkfNloIHAsFhAuwhsBgV0MBoN8W+DmVrVYqbPzMIkEViOI+MbS/uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
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
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMgfCA2ICsrLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYyBiL2RyaXZlcnMvc3BpL3NwaS1h
dG1lbC5jDQo+IGluZGV4IDVjNTY3OGYwNjVmMy4uNzNmODBjOGFjMmZmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGktYXRtZWwu
Yw0KPiBAQCAtMTU5Niw3ICsxNTk2LDcgQEAgc3RhdGljIGludCBhdG1lbF9zcGlfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0K
PiANCj4gLXN0YXRpYyBpbnQgYXRtZWxfc3BpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiArc3RhdGljIHZvaWQgYXRtZWxfc3BpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBzcGlfY29udHJvbGxlciAgICpo
b3N0ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAgICAgICAgc3RydWN0IGF0bWVs
X3NwaSAgICAgICAgKmFzID0gc3BpX2NvbnRyb2xsZXJfZ2V0X2RldmRhdGEoaG9zdCk7DQo+IEBA
IC0xNjI3LDggKzE2MjcsNiBAQCBzdGF0aWMgaW50IGF0bWVsX3NwaV9yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAgICAgICAgcG1fcnVudGltZV9wdXRfbm9pZGxl
KCZwZGV2LT5kZXYpOw0KPiAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsN
Cj4gLQ0KPiAtICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbnQgYXRtZWxf
c3BpX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IEBAIC0xNzEyLDcgKzE3
MTAsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhdG1lbF9zcGlfZHJpdmVyID0g
ew0KPiAgICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gYXRtZWxfc3BpX2R0X2lkcywN
Cj4gICAgICAgICB9LA0KPiAgICAgICAgIC5wcm9iZSAgICAgICAgICA9IGF0bWVsX3NwaV9wcm9i
ZSwNCj4gLSAgICAgICAucmVtb3ZlICAgICAgICAgPSBhdG1lbF9zcGlfcmVtb3ZlLA0KPiArICAg
ICAgIC5yZW1vdmVfbmV3ICAgICA9IGF0bWVsX3NwaV9yZW1vdmUsDQo+ICB9Ow0KPiAgbW9kdWxl
X3BsYXRmb3JtX2RyaXZlcihhdG1lbF9zcGlfZHJpdmVyKTsNCj4gDQo+IC0tDQo+IDIuMzkuMQ0K
PiANCg0K
