Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43654C411
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiFOI7L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346642AbiFOI64 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 04:58:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1349FBF49
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655283535; x=1686819535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MRWyO9nVfzLnF/0NuSTE6QONp5QltFV4fhv19cBCXFw=;
  b=eJjQfAMiutvGN6k+hD695Xwy2CroQoL3CgGcAwuk88XkR+pPez4kO3pm
   kiMPkXW/k0E9K7P4RNn1zscO3vFT8kQAEhyfeHt3xv65JfqWwkRkt/R/y
   Qin7Wwyv9pYZe2Uk4Uw/Nk2Pvmns8qzD5omNEwAXZV6LeC64cQgr62cno
   XLSyAZS8S/rYjH+AU6Vz4NAX1SfFgVyp+EJ5esdOhOT2lpwnN/3Wz0mUq
   dLo70wY388u/eVqcQ+NmMi1yK7JMEUxAPlWTlNq67X+By+pl0jrVZsb92
   7ICPQmVsT08FDxlzJGnjfGKA0jEYZDbwmAp056jxzQoO4/98cLqbF6PPF
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="163435837"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:58:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:58:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 01:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=istCrhfoLUZfj/mbLV+gPSG2pa4FilsyjPb9Ma1d7ISi0cbMTHlF9mjFUBL09RhbSa8fKHn0lRqop9Zq2b8No08Lostkef6Hni4ITzU3pvVBhGqy/GpbUys4TpyH6MfKtmXkIiflB92bV6ZTys6R/9stviPVJnnTYLyLuO4tCDfWykE9yNcrKjldvgmrKOfqTOiy0KBHB7JFl4WaBnahDIOYlz12BvbA3VOy1hXw3p2vTD4g3XWLiTRKyObmlzBOnc31VdHzo+uK9moj80EfkEvGHNElgDBm6GWxsFm3tcRc3Zz4KBUEh/DVeaL8FSidoSaYGUW49/QXdzQolTRCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRWyO9nVfzLnF/0NuSTE6QONp5QltFV4fhv19cBCXFw=;
 b=F65nHT6/UK8OJaJdxiG5vwhTMLDfwTqx6JPX9u5ods3Eb54kw9/SCkGVneZvmrIi5KBjTCggBz4IpOsr04Tn5FOhcyicvN74FviZjf+4cVjRN+9fpAMk2H3oiMMFZzuZT5njAag5CCu+VLoXjh5gGFbH2bXFHX6J4gB7Y8ciSB0kuFpaGe82M+s0pe+pR77R92efBgdcMOCjPHbnnAgkTjYet4pSIAoNOVzToPPHTVZOB1Y6OjQbHzbyh5B/9bJ9l1hBaXWko6S5shrgaOHmTeQP1jbhAQWxt/NpNXxXCfpoG06Se0UIgbaCJTa28IIXIQzhYtyIBp0+01qQidoQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRWyO9nVfzLnF/0NuSTE6QONp5QltFV4fhv19cBCXFw=;
 b=MU39G2wfzX/VP/J0riqNqOTze57Bvfpsv22/VxuIg+Q7dfNyuwn9gCZYLxUzBsl5XccXBRsvERkfDeATLvyK0YyuSpfocr+CTA5BTU0BgelpokeuROhKlaIEJdePLLajASLg4dub9nMDOQS0Q75RAMlbTl5tMpDN1RBZfKP30w4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3514.namprd11.prod.outlook.com (2603:10b6:5:61::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Wed, 15 Jun
 2022 08:58:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 08:58:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <linux-spi@vger.kernel.org>
Subject: Re: [bug report] spi: add support for microchip fpga spi controllers
Thread-Topic: [bug report] spi: add support for microchip fpga spi controllers
Thread-Index: AQHYgI9M7pD2jxZORUmau+4lbz6Nba1QI6iAgAACawCAAASmgA==
Date:   Wed, 15 Jun 2022 08:58:53 +0000
Message-ID: <f8829b05-12f0-58c0-80af-1e164f142324@microchip.com>
References: <YqmTuWEPKkIH7cBs@kili>
 <70502137-6c04-4206-382d-2731a2205875@microchip.com>
 <20220615084042.GH2168@kadam>
In-Reply-To: <20220615084042.GH2168@kadam>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ecdcdca-60eb-4a4f-d018-08da4ead45fb
x-ms-traffictypediagnostic: DM6PR11MB3514:EE_
x-microsoft-antispam-prvs: <DM6PR11MB351422E12C581DC83BCA06CA98AD9@DM6PR11MB3514.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHnSkF7SbXAhKm+IP3Uh9kz6+R/ibAvc/Rh6C7DddrGCn6cZ4VKhs6ZUeJ1Yk9Gz/WcaG7xVe9pMOBgZXvrUFEnsw3fWwmDUFbENsNQj9GOeOgFjEnPiNUCHCGiLmt1ZuTdPuU9NAf4OcU0dH+i2XSXzgd7KhB2rbDtkrWOAbmbrlp4esubd1ixuwk0q0EJ2ztz8KxqHnxzRMSLkoXilq2r9/dAhIX8NRZIuFRa5JOniivyHsgVymzRLm6GscOeQFDDRP0rOwEitJyeS5KGXApE2RzU2UuR3cblMKsv5B4jjAmWzeqRJql8xZ6dj1vSfYZz4yXVVtrKsWHeOz4c5I9X1ZG/dvU2MG4OHJ2yqkeFwctMYVJyGcFZlqS1y2u2vwY9amhtEq9ZxlG9/kanl8yhpA8ZUOdQ1PovOEMxio2NE1Mho/WsH5dOqJj7EondwWgPpndBgICC5qCfri10hf7LGWCr6yVss+rVErRPRIP2kS4dPjPs1yCAwr4Aipzx6dIWbQ3Nk1h3TxIVK2hNgHZ3yfxr16GBJKRHYA6Ep004XiOBmIMZACnvIUfj89T8VC/3bqtsnA3DuXpcZ/qNsr9bSF9wcgdsnEeOddfev7JOtIQ/tWeSRnTpOKTFTyPCsN/SVutNn6JDA2brCBkKhl64tgSSQqP640rma9ZHzUfQL//CUez7HLBaO8mS6n1NGRUPereIHNWWcnbjEUBL6j5MqKUGHDI/QU2tl8TZIaLWEsWumptJBQXYuM+kAczYT9y/ZTeKNh5xms7YRO/HeFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(36756003)(66446008)(8676002)(31686004)(86362001)(4326008)(64756008)(26005)(5660300002)(122000001)(6506007)(66946007)(8936002)(2906002)(71200400001)(316002)(66556008)(6486002)(2616005)(186003)(6916009)(91956017)(53546011)(31696002)(38100700002)(66476007)(83380400001)(6512007)(38070700005)(508600001)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3J6YWpMZ3Y2eFpGK3g5L0NnSEtzWWh5ajl2bnJORWs5Mk1LUW5Ua1JMZ2M2?=
 =?utf-8?B?ZXNxakJxZnZTVHJuWCsrbmtYWkVjTUFtenRCaktDaGw2VjArNXEwRTYxWGdC?=
 =?utf-8?B?TmszbTdBZ1JQQmZvQ0Q4QU1uRURoSEtVV1FEeCtXR0FDU1h1VUt3VzZvY2xQ?=
 =?utf-8?B?WFlLUWhMQnBzalk1TzlzMldnc25jWnB0eThUS0NMQjBsQUpNaE1QZUxCSjdN?=
 =?utf-8?B?RENIb3NpVmhkVHlhc0dDNUFZRG5Xb3Q0dDk4T29BSmxkNHlOMFlTR21xN1B4?=
 =?utf-8?B?VDAwWHIvaVdwNGFhYzdTQjRta2R6aHhQTEZUayt0RmhVY2RJaC9RODI2ME5S?=
 =?utf-8?B?eGllc2ZvbzdVR3JyeUdxUzB6MkpNMGdkbUVJRVF5QWRSMGcwSmZBK1IvWkVV?=
 =?utf-8?B?Z1ZVMzVaTmF4MW5ESXRZQlZWWVN2cVA1Y1F4c1V1TTlDb0UrTjRLZkNYRlB2?=
 =?utf-8?B?dG9qUUJ3Uzd1bkVEYXVVKzU0KzVMcGIwRzVGS0w5QjJsd0tUOHhVOFJwZllh?=
 =?utf-8?B?dWlZbjhZYXJPSDJKeTNtc3Y0MTcwUTNzZmNvdFBjV1FxT0pWWUxqaGk3dmZs?=
 =?utf-8?B?dDZSWmxUdDZmc2lZa2FtblcxdGd6WklES0NKcnpZVTRjYWt6RVYyR1N2SkV3?=
 =?utf-8?B?WHJVZSt2dzNBZncxNTFva0cxeWpHaEpWbGdFS0NtSUc5RDhBTUQ2MDRJQytY?=
 =?utf-8?B?dGhTdlNGWEhTM1pyNjFHNHRUL1A3Tno2Um9Oc0JEclMxY0xGUm1UUTgzWUlt?=
 =?utf-8?B?Sm1xTGR2S3hiT0F3VStjU2JNcGhPSzdIQnQzMno0MSthREd6aW1PTVVTUGdZ?=
 =?utf-8?B?QWthOTVKbU1KNkNneVhIeDBnbUl1ZzlDL0xoYmpyL3hydlhLNy9xcEZUMG9N?=
 =?utf-8?B?YStlNkxPNG5FQWxJZnFxbjBCbDFzZWYxRHNqRUdaWXlOYUhiYlVtNHdKUXlG?=
 =?utf-8?B?N0tWRXlyVm0vbkxuQU9pOHpJaEJ4bS9oeXZTSkxUSGRVQjQvamxxYW03LzNN?=
 =?utf-8?B?YzFoV2hBR0hXMG03Z3JEWVdzVVBzbVE0d3N0a25vTmFYZTBkTjBiSjc0bTh0?=
 =?utf-8?B?L0NCMllkakxxVHdTRG9NdGNIMzVUOVNUd09MWWMyYy9XOTgzMjhIaTlmdXRL?=
 =?utf-8?B?SHBiVFJkWjU5YUl2eWp0dnkxQ2htTXdqbG5VdVhVdmYyM0ZiUHRuZHhmbEFM?=
 =?utf-8?B?SElvdTVHclJWM1p4MnZ5a2w4bmtGc29PVnEvWHE5SitHandtSVdZbWFyOHBm?=
 =?utf-8?B?ZkFhWThqOWhwY2YvZEQvbG9hU1JEbGJVV2M5d2diSGQ2TWZMOVdjUGhXaFVE?=
 =?utf-8?B?YUM0UGpFMVVZYzdEZXlTZ0syYjF6OGk3Sko4MGFQVVNHc0VybGtwTGdNYkxa?=
 =?utf-8?B?b1pyZ29XdzdrSDVCNUVYNWlEU1oyTWR1cHhqVlFrTndNd0dLSmVDS3V6K3o3?=
 =?utf-8?B?UDA3RWhHeGxqcW1aUVRNRFg1TlhhTS93K2xPQmJLZGxJNHJWaFViZ1F0Z0lt?=
 =?utf-8?B?Qm1ZeVJ3eUFMTUdncERtTkhpLytRMGxUOXF4eFFNalVML0s4RnJ2YitXNUFu?=
 =?utf-8?B?cWE2c0VVRldSTEZ1bEE4eVJEeTFKZzN3Q0kzMDYzeGxzN2pINERSV1dwZm04?=
 =?utf-8?B?V1NTNG9SV2toeTF5cEdOK0RuMk9EUDl5d2o2Mm1hYTYvK0NHSzhETnJmYVZZ?=
 =?utf-8?B?emtQclpRZDdXdzJoNjFjamxQU0V3aFZ6dUs4NmR6TUN1WVJkdEdYLzlydTZh?=
 =?utf-8?B?Vk9BNEs5NnFGM29VdXNvdmlYczV5Q1I1QThvZHdvYXVqbGR2cFlKNS9kYW9X?=
 =?utf-8?B?ODFMczZaVm1mRTBsOVd1MkhwdlhDN01qN0Z4Vklrb1pJcDc5eUo4ZUZJbFcy?=
 =?utf-8?B?aWZIbHVzb3JNQnJQOURrRHk1S2hRN2IwN3o2cmlHWlJZbGdadnAzdloyMFFB?=
 =?utf-8?B?VkVqdit4UDdIYnZEUGVwQmhxdWlwbDBLWDdSSldBVmxQSjg3SUJXK3hDK0dL?=
 =?utf-8?B?bGI5M0xDRlZXVHE2ZlVGeDVuZFJRN2R3allZTkwvVHVBdllqbGhOMTlkejFZ?=
 =?utf-8?B?Qm5zV1UxUk04WHlCTklvNFdXVURPM2xsUWpFWlNtNjhKeWhKMk5udXJwTEFw?=
 =?utf-8?B?SWRMSFQzYlpKMEpydzNwSkZoR3JwOXFUTlBOK0dZd2hIT3RjV1liKzV6bld3?=
 =?utf-8?B?NTllVS96OEttU2pSWWpaTGVZQ1k2NFZHbTA3U3lmZzlqVXQ0RlA5SkVGb0NJ?=
 =?utf-8?B?RnZTS2h2K2Y3c3hZaFh4a05wbWdkbG9UWFRJRnpIS0xLbW9HY1ZyK0tiUXoz?=
 =?utf-8?B?WGwvZzhrOG1QbUtTRmNzZU9LK2NDYWFpMmRtaDh2czZIMnZXLzdJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C38E4354FE43D4AB2B4E90CD53F17B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecdcdca-60eb-4a4f-d018-08da4ead45fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 08:58:53.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uodsObkpLDj2ohCrU3sndKP61CJntFeROhKTPrsNR3P5+oTjqIc3F6OW7GXZ9gYkU/usp+IrAlBBF/qXUQkiZXAIqFgoaD8IjzUq1bXk940=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3514
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTUvMDYvMjAyMiAwOTo0MCwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAxNSwgMjAyMiBhdCAwODoz
MzozNUFNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+PiAgICAg
ICA1NDEgICAgICAgICBzcGktPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+Pj4g
ICAgICAgNTQyICAgICAgICAgaWYgKHNwaS0+aXJxIDw9IDApIHsNCj4+PiAgICAgICA1NDMgICAg
ICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgSVJRICVkIGZvciBTUEkg
Y29udHJvbGxlclxuIiwgc3BpLT5pcnEpOw0KPj4+ICAgICAgIDU0NCAgICAgICAgICAgICAgICAg
cmV0ID0gc3BpLT5pcnE7DQo+Pj4gICAgICAgNTQ1ICAgICAgICAgICAgICAgICBnb3RvIGVycm9y
X3JlbGVhc2VfbWFzdGVyOw0KPj4+ICAgICAgIDU0NiAgICAgICAgIH0NCj4+PiAgICAgICA1NDcN
Cj4+PiAgICAgICA1NDggICAgICAgICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYs
IHNwaS0+aXJxLCBtY2hwX2NvcmVzcGlfaW50ZXJydXB0LA0KPj4+ICAgICAgIDU0OSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9TSEFSRUQsIGRldl9uYW1lKCZwZGV2LT5kZXYp
LCBtYXN0ZXIpOw0KPj4+ICAgICAgIDU1MCAgICAgICAgIGlmIChyZXQpIHsNCj4+PiAgICAgICA1
NTEgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImNvdWxkIG5vdCByZXF1ZXN0
IGlycTogJWRcbiIsIHJldCk7DQo+Pj4gICAgICAgNTUyICAgICAgICAgICAgICAgICBnb3RvIGVy
cm9yX3JlbGVhc2VfbWFzdGVyOw0KPj4+ICAgICAgIDU1MyAgICAgICAgIH0NCj4+PiAgICAgICA1
NTQNCj4+PiAgICAgICA1NTUgICAgICAgICBzcGktPmNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+
ZGV2LCBOVUxMKTsNCj4+PiAgICAgICA1NTYgICAgICAgICBpZiAoIXNwaS0+Y2xrIHx8IElTX0VS
UihzcGktPmNsaykpIHsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eDQo+Pj4g
TlVMTA0KPj4+DQo+Pj4gLS0+IDU1NyAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihzcGkt
PmNsayk7DQo+Pj4NCj4+PiByZXQgaXMgMC9zdWNjZXNzLg0KPj4+DQo+Pj4gTm9ybWFsbHkgd2hl
biBmdW5jdGlvbnMgbGlrZSB0aGlzIHJldHVybiBOVUxMLCB5b3UncmUgc3VwcG9zZWQgdG8ganVz
dA0KPj4+IGFjY2VwdCB0aGUgTlVMTCBhbmQgYWRkIHRlc3RzIGZvciBpdCB0byBhdm9pZCBOVUxM
IHJlbGF0ZWQgYnVncy4gIEluDQo+Pj4gdGhpcyBkcml2ZXIgaWYgc3BpLT5jbGsgaXMgTlVMTCB0
aGVuIGl0IGxlYWRzIHRvIHNwaV9oeiA9PSAwIHdoaWNoIGxlYWRzDQo+Pj4gdG8gYSBkaXZpZGUg
YnkgemVybyBidWcuICBTbyBpdCdzIG5vdCBjbGVhciB3aGljaCB3YXkgdG8gZ28gb24gdGhpcz8N
Cj4+PiBGaXggdGhlIGVycm9yIGNvZGUgb3IgYWRkIG1vcmUgY2hlY2tzIGZvciBOVUxMPw0KPj4N
Cj4+IEFtIEkgYmVpbmcgZHVtYiBoZXJlLCBvciBzaG91bGQgdGhlIG51bGwgY2hlY2sganVzdCBi
ZSByZW1vdmVkIGxpa2UNCj4+IGV2ZXJ5IG90aGVyIGRyaXZlcj8gQXMgaW4sIGRldm1fY2xrX2dl
dCB3aWxsIG9ubHkgcmV0dXJuIGEgdmFsaWQNCj4+IGNsayBvciBhbiBJU19FUlIoKSBjb25kaXRp
b24uDQo+IA0KPiBJdCBjYW4gcmV0dXJuIE5VTEwgaWYgQ09ORklHX0hBVkVfQ0xLIGlzIGRpc2Fi
bGVkLiAgSSBkb24ndCBrbm93IHRoZQ0KPiBoYXJkd2FyZSBvciBpZiB0aGF0IENPTkZJR18gaXMg
ZXNzZW50aWFsIGZvciBib290aW5nLg0KDQpFaGggSSBndWVzcyBpdCBpcyAvcG9zc2libGUvIHRo
YXQgQ09ORklHX0hBVkVfQ0xLIGNvdWxkIGJlIG9mZg0KaWYgc29tZW9uZSBpcyBhY2Nlc3Npbmcg
dGhlIEZQR0EgZnJvbSBhbm90aGVyIGRldmljZS4NCkluIHRoYXQgY2FzZSwgbmVpdGhlciBvcHRp
b24gcmVhbGx5IHBhcnRpY3VsYXJseSBhcHBlYWxzIHRvIG1lLg0KSnVzdCByZXR1cm4gLUVOT0RF
ViBJIGd1ZXNzPw0KDQo+IA0KPj4NCj4+IFRoZSBjb3JyZWN0IHNvbHV0aW9uIHNlZW1zIHRvIG1l
IHRvIGJlIHJlbW92ZSB0aGUgIXNwaS0+Y2xrIGNoZWNrPw0KPiANCj4gVGhhdCdzIHRoZSBub3Jt
YWwgc29sdXRpb24sIHllcy4gIEJ1dCBpZiB5b3UgZG8gdGhhdCwgdGhlbiBwbGVhc2UgYWRkIGEN
Cj4gY2hlY2sgdG8gcHJldmVudCB0aGUgZGl2aWRlIGJ5IHplcm86DQo+IGBncmVwIC13IGNsayBk
cml2ZXJzL3NwaS9zcGktbWljcm9jaGlwLWNvcmUuY2ANCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBj
YXJwZW50ZXINCj4gDQoNCg==
