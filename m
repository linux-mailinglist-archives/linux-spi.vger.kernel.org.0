Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7454C390
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiFOIdx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 04:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbiFOIdr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 04:33:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DDEF02
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655282026; x=1686818026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xStkzPFhB8OQrWpc4UooOwVMnRdcZcP/47UMx+DeriM=;
  b=BblZBVmfdUVZTNbfl3yccuf+/Xx2WizOlg1hT45QflC86SB9z7xfX3jv
   0BkkVjlsxcIFGkZTKnIxD6rV2yWMNXPzxkdSxelE1SwGnNxnolM7pyIrw
   T7PFB3wGizH6j829BujdsUSH/7BoMF9EvbqkMDmMrQZzfdV5lMaKujzxh
   KgeEXXiHN7R9fg6x4m5xqfcFl4wSNJkyGqQEqh2kpj3SnukOA8CDVVMeM
   dCvzMY+dW0EnPVa5jVsmfC20wwRDRCRfoE/H32rXHkXUqFVx1bhcrganV
   g88rAnuTgRWIYtPiWR52dTpcGN6+IlQJHcvqdhKrDXtETnQha4NRQvfV/
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="100102319"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:33:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:33:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 01:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALTyzMajlzvlTlD2V8PphZ/hMjaBwlaFNdSc5De+kQFIZHjkibs7oX0M/Uyammq3HqsBe/LDkQ3n9Or+JpOQOpzbgh79ey0vnj1J1wMVupckPYe/wOYs3rqfFGbT2C/zCSWH4QvZu7l7WwKabFIfMnMy+CQXrM1EayRfq5JTz9z+psEIgYAft2yELtfU2FbUWSM5z9lsloC3EetWQLUw02hxyhPLRGAblKiNcCxrnPmT3v4NEMeFbITOO9mx2k1ep3TXxOl5fBaDjN6MsWWXfRmqM5qS4DePAohYvn3aaZLpoxirVNfOF62O6eiGeociMTZDXfYbU70Pn3pwt9Ap5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xStkzPFhB8OQrWpc4UooOwVMnRdcZcP/47UMx+DeriM=;
 b=APlAfw2fS/ynjjyguQGQd3CILODDlmFs6gwQDB2e/PDj8jZ7jNz5aGipxvwNe65VDVIOShqi7v/E5M7mJTFnNubZY4dO5aSW1gXVzi1KVj0qPQtZoFmAte6zTqYbjOfLwe9YyV5uSpPbjdkTqOAJjWq81X3aAOmMRXOqrT9/0ARMi8G/ruXz8aYjYKXtTtGt0L2bh+yeFe3+6NpSs7G3usYm4touJfwrNuu8KShSeVsRViGSORVEolLbIzikpl0cpj5N9o57m5dnzA4Jh2QJjwobUufCKw2Qa1WDRVL/jxgfPR/L87xG3zVWwKpK+SOVVCzjAKaM0MNjKehgk+U1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xStkzPFhB8OQrWpc4UooOwVMnRdcZcP/47UMx+DeriM=;
 b=Uooc7sGuXGwdEje84vxUlvYVkisDPGPsyJdZtzITT//VoUnCgrdpSAcezfjhfDyeHBOqEGk0CPpynj83pcvfT5kKMs6XoPjsx5Vw8e9tT22ToYeeBQ2YkPOSTt5sKbviXuCUXqFDWx1OCcwh2Jm4dvr28uyWtyH8/0dWzLU2Ry0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3785.namprd11.prod.outlook.com (2603:10b6:5:13f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 08:33:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 08:33:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <linux-spi@vger.kernel.org>
Subject: Re: [bug report] spi: add support for microchip fpga spi controllers
Thread-Topic: [bug report] spi: add support for microchip fpga spi controllers
Thread-Index: AQHYgI9M7pD2jxZORUmau+4lbz6Nba1QI6iA
Date:   Wed, 15 Jun 2022 08:33:35 +0000
Message-ID: <70502137-6c04-4206-382d-2731a2205875@microchip.com>
References: <YqmTuWEPKkIH7cBs@kili>
In-Reply-To: <YqmTuWEPKkIH7cBs@kili>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 721eb5c7-5c86-4850-963a-08da4ea9bd52
x-ms-traffictypediagnostic: DM6PR11MB3785:EE_
x-microsoft-antispam-prvs: <DM6PR11MB37854D856E94F82C06BF955698AD9@DM6PR11MB3785.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQmbcDACt4231LgHoUSW+Rp2m0RaTFJTTBvrS+Rph/Pl4KrnONOcDyI3OnnanNdUHEdAam+7KYCPZjbbdymjA/0p81JDvZ6w0++WVrId14QLqhzRhWMlIX51pEGD7btemgIYDr/r9fC0wVY8alaEwGc39SIkvReOLnhalzvnZb9y+uacor8Y3mgfbpBrEiJq0a2ARpjHn7WgixmjIiu5TMMEQ4WyOKsAxE6rTB4XyWTl6wgJE7ypG88Po1wg1YgLSbEd8ktgJEaeuhwlCpwUf5ilevvxO/iB52rNmWhwagxloz1hTEzg8JQ9rxVXbpxPcQ7NalPWFgt+Bkt3qcm+WregMOX8DhxSly3eHQMkNG0ZSuVZIhg6aUq1L+w1b7/3x49Apy5tCy7FHpnlyE97yZiAbCyuOuzNOR6SsMnaVFjTy1L8EmXvZ7lMuve2zNj6hdWEygeZm8B7rUbCmPfJMjsWplCz1KpTYMsKR6f2yPHrURZzSvuN2cVzdsxkmsz9TOVwLrCB3VEDtLghIlIJwJWeShMd2yGaI7RM+XHG3o0Cb/b/7c5SaRXqnz/fs4NvphBpBj3g1ElpolUAftB+/TMq+3INhdFSFkdg8ozrNGJ/V8LEpRhIq1TrqEl2cG9fPzYqb8hr5jZciZ5rYOTHkR58UVlwAYjrVZMw3c3L7AkWrWysfQhtS1e5UQecXa9/edq5vdIGdd9x07yinCsnRdS9gySg4N8+iNwnR/c2Rpm1/iJB48BdCJ2VFvsOLZQZwF6JIdpzGnuGTlwcmZ+zhEYck/H7kt//1jhjyWTBvccVbdjNh76/2USfita6Em9d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(76116006)(5660300002)(8936002)(91956017)(6512007)(508600001)(8676002)(86362001)(186003)(66446008)(66556008)(66946007)(6486002)(64756008)(66476007)(4326008)(31696002)(26005)(6506007)(38100700002)(53546011)(6916009)(38070700005)(71200400001)(122000001)(316002)(83380400001)(36756003)(31686004)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0hwVlFGak9kMXpZY2FwNnBtZXBMdnkzZlBFbWUzeHFDbUFpWUpvaVNObXhz?=
 =?utf-8?B?RWNJT2VGVlpPeVJiaW5yWVNNZWgzMFkzSVBWOTBzemttQXcvMDNoQVZuQXd4?=
 =?utf-8?B?cFI0ejdUOWFNU0ljZitKWUdhc1QwZWluUjhiL1dlVm9CQ0hOWnVwOVRXMCt6?=
 =?utf-8?B?QU04L2tKU2JyRytXQklSRlRLSVJ0TVZmaEdaSGdIVU1pc1N6b2NBNVNXQmpG?=
 =?utf-8?B?MW9yeWtMK2Vsc0xPdjN4ZU83RGpKUE5OM3lwNzFFMHR4NVBCdkMvN2VzTHpE?=
 =?utf-8?B?c2sySlcrYXVwazhWT0xUS1FsYmc4S2NIQkhZNmtGRFRCcnJONzJCdDBzY212?=
 =?utf-8?B?dUFBU2cxaDdaZVVXUkd4Zkt6TmpCMkNGcnBucjhLQWlmblN5TWUrdndhMXpX?=
 =?utf-8?B?UnRIS1BtTFUzeG9DN1BRbDA2UzdnZzlDcUlVdXNoMDkremlqeEFoTVpPdFZx?=
 =?utf-8?B?czFYM2JEU1o5T3liK1lRaWpBQnVrSTFwTnQ0QmlOUFRNTSs2aVhXYXRpUG9o?=
 =?utf-8?B?VDE4T1B3S2xHa3dqb0N3emRkM2xkc0U3a25jbk9zT3p3c2Y5dFhhYnQ4V1l0?=
 =?utf-8?B?TUtkTWFPTXRiU05EbytFZzdxOGl0YVJTRjhzM1JRV2lGbjgveDdRdWNHRS9w?=
 =?utf-8?B?Wmluc3BmMVhnUWxqRHJXb0pJZEVOcXI4WGIyM1A5bEJVSjRqSlNMdnBXbzBo?=
 =?utf-8?B?NDF5TFBDOVlZUW5MSTIyeDF6RlN2a1hBRmtWdE1vbU5sS0I1SndHWFJsUUt2?=
 =?utf-8?B?SWtqMm9uTktlSTdsajlNekRTT3d6OTRHcDFIOTljSnc4TjE2MUhoMXJUZjgx?=
 =?utf-8?B?bnZGK2o3Uk9mdkNObVkxQVNRRjdtcmZNVklJZURKY1lyZ1E2dmptQ2MvS1p6?=
 =?utf-8?B?eGxsUkpocXJJQlFIdW52MEVkUWpzVmQxS1JPQnRGTFdDOE9xMS9DYXlSdXFj?=
 =?utf-8?B?ZWxHZFBrMFdGQUkyY3JxWUMyaVdKY1hETWVFVm9sdVMxdEFQTXZtNlVLWGtO?=
 =?utf-8?B?TTk4a1lGNTZveHQ5WDNHdThpUC9qc2NuQ0xiOEY2MGdmNGlkazNPcmRtemdm?=
 =?utf-8?B?TzI1OG1yS1FNckpmbW91UUFwc2V1T21Ob204UWJza2FlLzZCZERhU1hISFFV?=
 =?utf-8?B?OHhFT1g3RStMMmNQdVgyNEVZaVYvNUZ1S0JjaWY5bit4MWNpaWUwTU9HRVZ2?=
 =?utf-8?B?bU0wQ2plcm5xZVB2WjQ5b3BBTm4vMHduM29iRDhESjBDZE9Qd0lBSmJIRFRH?=
 =?utf-8?B?bzM2R2ptSlVJS2dIekpkUFdFNjd3OHVVdkJlVktJZ3J1YTdhZ1JhK0tjQWpK?=
 =?utf-8?B?bmVJTURTd2lJSE5KY29DMkVkQy9VdUdFa2JvMlhzek5kK0F6aURCTVRsY2pP?=
 =?utf-8?B?bHUxVVhZT2dER0h2SmdGYWVwRHJheDBYWDlJbFg4QUtKTmZ4cVk0WmZEWWlt?=
 =?utf-8?B?OUZqV3FRdmxsQmh6OVVIT2NWT1liUFRYbkx3WXAzNitCbm92engyd0s5T2lx?=
 =?utf-8?B?RCtGU0g1UUJFSE1IMGkrK3ZLNGFWK1hWZ3JyQllFcFdqYmtaSGROQ3FhN2lq?=
 =?utf-8?B?bXVSUzZhbEp6djJ3R0k1QTZVUHMvWWtmL0lQOEhlL3N3SFR4UCtNdmRWSS9V?=
 =?utf-8?B?d2xRR2tMdUtrQk5HN3psK1lkNURIN0JGclFrQWROTWJGMS9vTUl1ZUdqVVZy?=
 =?utf-8?B?RmQwekNjU0hibms0eHR1SEl2YWJ3ZXREb2RmSU8zOVRUTyt3MENxdS9pVXFF?=
 =?utf-8?B?NGRiR1ZpeUx5dHV4YldkVUx1YjgzK0tQR2MydmRITDV5RUs0aG1iN3JTMXBF?=
 =?utf-8?B?TmRuYXRRSUpib1lPYzdmWmlDam5wVXVPSGlCNVV1TnB2M0NxdVp0bk9vcnlh?=
 =?utf-8?B?YUpMaEJvbnViZVlVVFJmaHZJeVFhZEFKS2wxaVlqcVJVOTBGNFZmTk5UbWdo?=
 =?utf-8?B?SnJCYXI4eUV3UEoxcndyaWszdUNqMW9HdmZ1Sjd5ZU1OU0IxY3BSQTVIYkRZ?=
 =?utf-8?B?d3RlZFNFQ3RXNEw3aDQrcHlMMGlUT3R4L1FYSFRnWXlpak9JdXVtOXNFYnp6?=
 =?utf-8?B?azF2eFNPY0NKUzY3YVdXbzRCdE8veS9NbmsweGcxZkJBWWhXenhKRjlCS24v?=
 =?utf-8?B?WkoxSlFjRGRrbGJnNVVWdms3STdTQm1PQktXcUcycGlWMXRqcHNBM0hhcUJK?=
 =?utf-8?B?N2Ivb3I5NFpqcCs3SWJaQzNKV1VPc0thelVXWEZJMi9IZHBjS1MrczRNY2RP?=
 =?utf-8?B?UTI3UGVKMXJCSlJmN1RzYTNIMkl6bndUZmhwcVpuU3FQK2twa3B6cm5TVEoy?=
 =?utf-8?B?T01XdnI3RUNtZGNLQjhLM3NLSTRRTkF1SkxtLzJjVEtFc3BRb2JGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A498DACE341B748B73E862B0C93D603@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721eb5c7-5c86-4850-963a-08da4ea9bd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 08:33:35.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoCyAETUPQzfY5JezQhj6v2dIoRrE0EAot6YAtSAeSPk6SAWLnRzAfiNUcCm/q4tt2jujnJSguyXxCoLL/YDiptLzaU7FaJPUTUhOWzkeTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3785
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTUvMDYvMjAyMiAwOTowOSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIZWxsbyBDb25vciBEb29sZXksDQo+IA0KPiBU
aGUgcGF0Y2ggOWFjOGQxNzY5NGI2OiAic3BpOiBhZGQgc3VwcG9ydCBmb3IgbWljcm9jaGlwIGZw
Z2Egc3BpDQo+IGNvbnRyb2xsZXJzIiBmcm9tIEp1biA3LCAyMDIyLCBsZWFkcyB0byB0aGUgZm9s
bG93aW5nIFNtYXRjaCBzdGF0aWMNCj4gY2hlY2tlciB3YXJuaW5nOg0KPiANCj4gICAgICAgICAg
ZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmM6NTU3IG1jaHBfY29yZXNwaV9wcm9iZSgp
DQo+ICAgICAgICAgIHdhcm46IHBhc3NpbmcgemVybyB0byAnUFRSX0VSUicNCj4gDQo+IGRyaXZl
cnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS5jDQo+ICAgICAgNTA2IHN0YXRpYyBpbnQgbWNocF9j
b3Jlc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgNTA3IHsN
Cj4gICAgICA1MDggICAgICAgICBzdHJ1Y3Qgc3BpX21hc3RlciAqbWFzdGVyOw0KPiAgICAgIDUw
OSAgICAgICAgIHN0cnVjdCBtY2hwX2NvcmVzcGkgKnNwaTsNCj4gICAgICA1MTAgICAgICAgICBz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gICAgICA1MTEgICAgICAgICB1MzIgbnVtX2NzOw0KPiAg
ICAgIDUxMiAgICAgICAgIGludCByZXQgPSAwOw0KPiAgICAgIDUxMw0KPiAgICAgIDUxNCAgICAg
ICAgIG1hc3RlciA9IHNwaV9hbGxvY19tYXN0ZXIoJnBkZXYtPmRldiwgc2l6ZW9mKCpzcGkpKTsN
Cj4gICAgICA1MTUgICAgICAgICBpZiAoIW1hc3RlcikNCj4gICAgICA1MTYgICAgICAgICAgICAg
ICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIC1FTk9NRU0sDQo+ICAgICAgNTE3
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidW5hYmxlIHRvIGFsbG9jYXRl
IG1hc3RlciBmb3IgU1BJIGNvbnRyb2xsZXJcbiIpOw0KPiAgICAgIDUxOA0KPiAgICAgIDUxOSAg
ICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1hc3Rlcik7DQo+ICAgICAgNTIwDQo+
ICAgICAgNTIxICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKHBkZXYtPmRldi5vZl9u
b2RlLCAibnVtLWNzIiwgJm51bV9jcykpDQo+ICAgICAgNTIyICAgICAgICAgICAgICAgICBudW1f
Y3MgPSBNQVhfQ1M7DQo+ICAgICAgNTIzDQo+ICAgICAgNTI0ICAgICAgICAgbWFzdGVyLT5udW1f
Y2hpcHNlbGVjdCA9IG51bV9jczsNCj4gICAgICA1MjUgICAgICAgICBtYXN0ZXItPm1vZGVfYml0
cyA9IFNQSV9DUE9MIHwgU1BJX0NQSEEgfCBTUElfQ1NfSElHSDsNCj4gICAgICA1MjYgICAgICAg
ICBtYXN0ZXItPnNldHVwID0gbWNocF9jb3Jlc3BpX3NldHVwOw0KPiAgICAgIDUyNyAgICAgICAg
IG1hc3Rlci0+Yml0c19wZXJfd29yZF9tYXNrID0gU1BJX0JQV19NQVNLKDgpOw0KPiAgICAgIDUy
OCAgICAgICAgIG1hc3Rlci0+dHJhbnNmZXJfb25lID0gbWNocF9jb3Jlc3BpX3RyYW5zZmVyX29u
ZTsNCj4gICAgICA1MjkgICAgICAgICBtYXN0ZXItPnByZXBhcmVfbWVzc2FnZSA9IG1jaHBfY29y
ZXNwaV9wcmVwYXJlX21lc3NhZ2U7DQo+ICAgICAgNTMwICAgICAgICAgbWFzdGVyLT5zZXRfY3Mg
PSBtY2hwX2NvcmVzcGlfc2V0X2NzOw0KPiAgICAgIDUzMSAgICAgICAgIG1hc3Rlci0+ZGV2Lm9m
X25vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gICAgICA1MzINCj4gICAgICA1MzMgICAgICAg
ICBzcGkgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rlcik7DQo+ICAgICAgNTM0DQo+ICAg
ICAgNTM1ICAgICAgICAgc3BpLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBf
cmVzb3VyY2UocGRldiwgMCwgJnJlcyk7DQo+ICAgICAgNTM2ICAgICAgICAgaWYgKElTX0VSUihz
cGktPnJlZ3MpKSB7DQo+ICAgICAgNTM3ICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHNw
aS0+cmVncyk7DQo+ICAgICAgNTM4ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX3JlbGVhc2Vf
bWFzdGVyOw0KPiAgICAgIDUzOSAgICAgICAgIH0NCj4gICAgICA1NDANCj4gICAgICA1NDEgICAg
ICAgICBzcGktPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ICAgICAgNTQyICAg
ICAgICAgaWYgKHNwaS0+aXJxIDw9IDApIHsNCj4gICAgICA1NDMgICAgICAgICAgICAgICAgIGRl
dl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgSVJRICVkIGZvciBTUEkgY29udHJvbGxlclxuIiwg
c3BpLT5pcnEpOw0KPiAgICAgIDU0NCAgICAgICAgICAgICAgICAgcmV0ID0gc3BpLT5pcnE7DQo+
ICAgICAgNTQ1ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX3JlbGVhc2VfbWFzdGVyOw0KPiAg
ICAgIDU0NiAgICAgICAgIH0NCj4gICAgICA1NDcNCj4gICAgICA1NDggICAgICAgICByZXQgPSBk
ZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHNwaS0+aXJxLCBtY2hwX2NvcmVzcGlfaW50ZXJy
dXB0LA0KPiAgICAgIDU0OSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9TSEFS
RUQsIGRldl9uYW1lKCZwZGV2LT5kZXYpLCBtYXN0ZXIpOw0KPiAgICAgIDU1MCAgICAgICAgIGlm
IChyZXQpIHsNCj4gICAgICA1NTEgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwg
ImNvdWxkIG5vdCByZXF1ZXN0IGlycTogJWRcbiIsIHJldCk7DQo+ICAgICAgNTUyICAgICAgICAg
ICAgICAgICBnb3RvIGVycm9yX3JlbGVhc2VfbWFzdGVyOw0KPiAgICAgIDU1MyAgICAgICAgIH0N
Cj4gICAgICA1NTQNCj4gICAgICA1NTUgICAgICAgICBzcGktPmNsayA9IGRldm1fY2xrX2dldCgm
cGRldi0+ZGV2LCBOVUxMKTsNCj4gICAgICA1NTYgICAgICAgICBpZiAoIXNwaS0+Y2xrIHx8IElT
X0VSUihzcGktPmNsaykpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eDQo+IE5V
TEwNCj4gDQo+IC0tPiA1NTcgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoc3BpLT5jbGsp
Ow0KPiANCj4gcmV0IGlzIDAvc3VjY2Vzcy4NCj4gDQo+IE5vcm1hbGx5IHdoZW4gZnVuY3Rpb25z
IGxpa2UgdGhpcyByZXR1cm4gTlVMTCwgeW91J3JlIHN1cHBvc2VkIHRvIGp1c3QNCj4gYWNjZXB0
IHRoZSBOVUxMIGFuZCBhZGQgdGVzdHMgZm9yIGl0IHRvIGF2b2lkIE5VTEwgcmVsYXRlZCBidWdz
LiAgSW4NCj4gdGhpcyBkcml2ZXIgaWYgc3BpLT5jbGsgaXMgTlVMTCB0aGVuIGl0IGxlYWRzIHRv
IHNwaV9oeiA9PSAwIHdoaWNoIGxlYWRzDQo+IHRvIGEgZGl2aWRlIGJ5IHplcm8gYnVnLiAgU28g
aXQncyBub3QgY2xlYXIgd2hpY2ggd2F5IHRvIGdvIG9uIHRoaXM/DQo+IEZpeCB0aGUgZXJyb3Ig
Y29kZSBvciBhZGQgbW9yZSBjaGVja3MgZm9yIE5VTEw/DQoNCkFtIEkgYmVpbmcgZHVtYiBoZXJl
LCBvciBzaG91bGQgdGhlIG51bGwgY2hlY2sganVzdCBiZSByZW1vdmVkIGxpa2UNCmV2ZXJ5IG90
aGVyIGRyaXZlcj8gQXMgaW4sIGRldm1fY2xrX2dldCB3aWxsIG9ubHkgcmV0dXJuIGEgdmFsaWQN
CmNsayBvciBhbiBJU19FUlIoKSBjb25kaXRpb24uDQoNClRoZSBjb3JyZWN0IHNvbHV0aW9uIHNl
ZW1zIHRvIG1lIHRvIGJlIHJlbW92ZSB0aGUgIXNwaS0+Y2xrIGNoZWNrPw0KVGhhbmtzIGZvciB0
aGUgcmVwb3J0IQ0KQ29ub3IuDQoNCj4gDQo+ICAgICAgNTU4ICAgICAgICAgICAgICAgICBkZXZf
ZXJyKCZwZGV2LT5kZXYsICJjb3VsZCBub3QgZ2V0IGNsazogJWRcbiIsIHJldCk7DQo+ICAgICAg
NTU5ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX3JlbGVhc2VfbWFzdGVyOw0KPiAgICAgIDU2
MCAgICAgICAgIH0NCj4gICAgICA1NjENCj4gICAgICA1NjIgICAgICAgICByZXQgPSBjbGtfcHJl
cGFyZV9lbmFibGUoc3BpLT5jbGspOw0KPiAgICAgIDU2MyAgICAgICAgIGlmIChyZXQpIHsNCj4g
ICAgICA1NjQgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBl
bmFibGUgY2xvY2tcbiIpOw0KPiAgICAgIDU2NSAgICAgICAgICAgICAgICAgZ290byBlcnJvcl9y
ZWxlYXNlX21hc3RlcjsNCj4gICAgICA1NjYgICAgICAgICB9DQo+ICAgICAgNTY3DQo+ICAgICAg
NTY4ICAgICAgICAgbWNocF9jb3Jlc3BpX2luaXQobWFzdGVyLCBzcGkpOw0KPiAgICAgIDU2OQ0K
PiAgICAgIDU3MCAgICAgICAgIHJldCA9IGRldm1fc3BpX3JlZ2lzdGVyX21hc3RlcigmcGRldi0+
ZGV2LCBtYXN0ZXIpOw0KPiAgICAgIDU3MSAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICA1NzIg
ICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwNCj4gICAgICA1NzMgICAgICAgICAg
ICAgICAgICAgICAgICAgInVuYWJsZSB0byByZWdpc3RlciBtYXN0ZXIgZm9yIFNQSSBjb250cm9s
bGVyXG4iKTsNCj4gICAgICA1NzQgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfcmVsZWFzZV9o
YXJkd2FyZTsNCj4gICAgICA1NzUgICAgICAgICB9DQo+ICAgICAgNTc2DQo+ICAgICAgNTc3ICAg
ICAgICAgZGV2X2luZm8oJnBkZXYtPmRldiwgIlJlZ2lzdGVyZWQgU1BJIGNvbnRyb2xsZXIgJWRc
biIsIG1hc3Rlci0+YnVzX251bSk7DQo+ICAgICAgNTc4DQo+ICAgICAgNTc5ICAgICAgICAgcmV0
dXJuIDA7DQo+ICAgICAgNTgwDQo+ICAgICAgNTgxIGVycm9yX3JlbGVhc2VfaGFyZHdhcmU6DQo+
ICAgICAgNTgyICAgICAgICAgbWNocF9jb3Jlc3BpX2Rpc2FibGUoc3BpKTsNCj4gICAgICA1ODMg
ICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoc3BpLT5jbGspOw0KPiAgICAgIDU4NCBlcnJv
cl9yZWxlYXNlX21hc3RlcjoNCj4gICAgICA1ODUgICAgICAgICBzcGlfbWFzdGVyX3B1dChtYXN0
ZXIpOw0KPiAgICAgIDU4Ng0KPiAgICAgIDU4NyAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAg
NTg4IH0NCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCg0K
