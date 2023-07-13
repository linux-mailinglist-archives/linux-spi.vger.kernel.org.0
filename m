Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9D752748
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jul 2023 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjGMPep (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Jul 2023 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjGMPeW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jul 2023 11:34:22 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2059.outbound.protection.outlook.com [40.107.12.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5592738;
        Thu, 13 Jul 2023 08:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzayopGNwXdpbf1Zc7+Sk7cadQYKEHUp4bWPzrSdVqtcRwWJRAY2kfsUA+rWXJA7uhMb9Egrj32CktGmwTXqU054A+3d5ANXc/+1WugEpB3es1GuAMUpKIpgjUZbELptCXWgpj3vgDY1e2/bE5ddG2g3Et+UK5IA3jBhZSQySu+FQOkdIhFugiwBmZno9iGncY4/n9PLpyeUXbVXGEU6sYiHJYtHPkrrxlOewwbi0UOMre4hZNuTxcjdcirz4zaLpztsJ7cceTZWF7nH5V+2cBgpETzHhSdJnPt+QPlKyJiGuyYSE1ofd4F7KiD2cKnbDcjRFaZklTahsCIe2YWewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUw7kP+xk+u/JqXXjyB5w0TA6IA8YYF920fGhJarXdg=;
 b=nxDheTbxFkk9CRCfHW5zOaOKNOJe9BahZfDGNKt/G8/679FtSKMESPx1HqNdyXzZ59PEHJd0s1c+LTAoLmlzgtOlyDG7tzlknSkEVZ7JM3jyAb1k5lShp7spIm8X6gOjS7Vtf3IHGbmKDQiSddStp6W/QDGNGjgsuzFbSRMdIBEFQumTwJz3o2PaGvits1aBbjwYAune4LXm4dnsMolGo75UQdYNCM42fhRN83tVBXyfdzZo1QtNejG7oi1nikIYABntDcDfHVLUkUcc1AaHFYFGqg6t74TQDSETqzD+iQXbuKo5jnx9VVM+7KFP2DS+zS1UuWA+ioG1nk7/D8YzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUw7kP+xk+u/JqXXjyB5w0TA6IA8YYF920fGhJarXdg=;
 b=hsJ479sJZ3o+v1rpjVYbAuCOZddH0C2jSZRQfElWSRg1YTBktjdT30qnLsm6UKTFhMIGllEDgUWlHRSX04vsTZ+q5iQ01ana03j8MrxNWtd3Le7sdlnT8v2bg2Vf6GktzZupryT0CKf3VSOo92zLHO5AW6lkA72VuWbgJwNfwyOBLX2H/FPzQ5PzwSd1j5Tn1J/5d/uUz67yy5Lm3LhRgBuBuxeHQA4yMy4h+PpXwJwApCPOObbAjDkVN0PMzNyk+nXtjgmTVAKr2ojNwmjF37LM/+/86p99Y9lNxkIfEXitlOCqBYblSMFQZrIdKnJ2xJyq9EW0qNwzDDIvkRHlEg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2102.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 15:34:10 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::19bf:f9b5:ef8f:b2a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::19bf:f9b5:ef8f:b2a%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:34:10 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BERGER Olivier <olivier.berger@csgroup.eu>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Backport to 4.14 and 4.19 commits 24c363623361 and 17ecffa28948 and
 a798a7086c38
Thread-Topic: Backport to 4.14 and 4.19 commits 24c363623361 and 17ecffa28948
 and a798a7086c38
Thread-Index: AQHZtZ93ynikpdZfvUSsdTkZPMTbbA==
Date:   Thu, 13 Jul 2023 15:34:10 +0000
Message-ID: <5201aa35-5855-53ec-d123-1a88523971da@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2102:EE_
x-ms-office365-filtering-correlation-id: 83bcada5-5249-4924-f042-08db83b69a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXsN8xN0y0mazVSNzBchnN9vpqOPVKuQjLatwldTN84nuVznmuovmeMXL9YhCOEhq32wVrRpQ3QxxLdd1GxHxeqmAbqLTwa1z4CNASfaYYlaUDPXNsBMaNEsVVvax51KkEAW41tMcQWtj0aSvh2g4wStyNdgscGDVOIfFJL55TqxheWACfmVJQjigMBFqz7hRIIYbdvr1TiHGZycrXrC+0txsuM4r0NrkODnZeWN0Swqfl2C/nv8or0ZdHLpj4Htzcy2NeHvqT/UvyOfEy/w/6vZRuyaOBSI5ivNEbMIk/J1ZRjZ5YcyHM5VA/npbEDNgFdxNgMjq3af/DABdgAQE0cUQzF2SJEDr9DhsRWYI8B00ZM384tJw5V6qW34idYY4tG7QkNLRVVex9hR87j6s4YzxIh52Gt8ESMBXD+p34fiPSuMxgh4Kbu7b/F8HFfmz9mIjKhvGQJaIso4L8i8JP5udzz2A7MVa0vmFkd80nc7P/mKwenD03BOqVpnj5ctB0+kPqmxsmYuykYTAY3NZuu8AAnDRnF7J6u0peUuBfibMesVswgcuIueQoFVGq8LrYZ975r4tjhPZkq/hKdqY70yjliR9JyaWnoigtjBNWxGqoTUIjPe0vGYFmgwGQuczvCGRUUNFKGT4sLVou3oMs9wbFTLqB05+oYE7uB0O7TBMYbxCJNfrHrsIlb/e1pc9dPdZd3LwNg1gGCGP3NVECVKoPZmIijdqm0bchrnj7g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(451199021)(38070700005)(36756003)(31696002)(38100700002)(86362001)(478600001)(122000001)(71200400001)(110136005)(54906003)(8676002)(6512007)(6486002)(44832011)(5660300002)(66446008)(91956017)(316002)(66946007)(2906002)(76116006)(66476007)(64756008)(66556008)(41300700001)(4326008)(31686004)(8936002)(2616005)(83380400001)(6506007)(26005)(186003)(107886003)(138113003)(98903001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZklPOUluMGNiR0xacnlCSnBwOTBBVGlZTWdyNllIdzhtdWRsWHBhZUYyVTVF?=
 =?utf-8?B?bEszZ2VUYmNzUThobWs4Vjk1anB1N0VkOExIVkt3aGtCZ3d6R0RjblhMUmdy?=
 =?utf-8?B?RFBZNTRNNEpZVVV5MVV0MEVpdUZtbHBld0pZdWJXL2JtMDNieEVQZUZVNG5N?=
 =?utf-8?B?ZnhqMUhqQnZvZFlTVnQyS0FFSWtha2x1eE9TanYwczJ0STV6bEJNazI0Zms0?=
 =?utf-8?B?RFlsWDNDUGE3dUVwbXd5bUUzSVhORXVmWVl5VkFLbGkxR1g0Lys1YUQyWVNT?=
 =?utf-8?B?eVJwVlF0clVHVzNVZUxibXdOWFRLcFhpMjhITm1VMFNTQWEzSi9MTFZNSDFt?=
 =?utf-8?B?alhyaGoyeFZYRUNkaXc1dnQrWmRia2lHa2l0ZXY3ZVZCNGJUZHBKYWdmbS9O?=
 =?utf-8?B?OFlmVzA1SHRONno1ZUpXTGV5MTRmQVNZa090Rk04ZDJxUVBjUnhJajBDV1hI?=
 =?utf-8?B?NVk1MWpHcTBqYXIvT0hTTEZHTGZSbFhJd2NEbkE2cGtrbWdUS2RKblNuZFdM?=
 =?utf-8?B?NENnOE5LMWdmbGplcVhGdm1NVW9rM0hIWjB6Rjh5WnhnR0l4SUVtVGxMN09E?=
 =?utf-8?B?VmJDem5mQlpTYWoxOUw4ZEVqM09EL2xMa0hHOFZodTJlNnRhZ1J6NmhNcHVE?=
 =?utf-8?B?U3BhaWM1b2laZ3lERlpuY3Q1RTBsT3B3bThxdlpMVjJsUUQ5QXJ6b0ZCa2ti?=
 =?utf-8?B?TEUzVUR5anJYOVhRUGJNZ1Y0M1FTMzA4QkNleGtueUZYcGhqbENrK1FkYWFX?=
 =?utf-8?B?aEt1L0EvZ2cxTDQ2Z2YzZndacHZtNnNZaFhZajdWNGkzRm5LelRUWVI1MWtU?=
 =?utf-8?B?bmZqM3JQM09mRWtGSHA0b2k2ZFR5eFJqQWpoT1BDcVRXQmhkNXV5V2cvNUV1?=
 =?utf-8?B?OU5mTEFEcGdtcFNaYXVtWGtVZzF4b2Y5b24xWFFtT3BMejkvZitnSDFyUTlP?=
 =?utf-8?B?MDY0a09USzM2VkMxWlE4TGNoUGpZcU1lcUdreUVMMVRCZGpETXdaakE0VlZW?=
 =?utf-8?B?TS9KYjNEWVpaYU9XV0g4V3pDS05tQloxWHhMemR1NVErWlpwSFlVSVFDbm5Q?=
 =?utf-8?B?aDdZczlwS2xSVHZuK3l3WEFvK2c1QVJZSGgwQTBJRFhCVWcvY0tDYTBDNmtN?=
 =?utf-8?B?aWVRWkYyWnhLcG5iN25rd2FMN0Vmcndyc2JzdVZZZnBiTVJKcStoNVpsWTRq?=
 =?utf-8?B?V0ZCeDgxRW03ZWdZNy9pQk05TnhvTFRGb2Zxa0NzQ05SUS9QMXlRSTZ3RENO?=
 =?utf-8?B?ZUlNOHhkVTQ3aHlPZUx4SkhrYmVWdUxZQzk3UnBmWFJMckNNbGtXY2Jrcldy?=
 =?utf-8?B?QnVhWU1aYmJCQzNESGFYSDgyQ0Q4UWdLZGlkY2hxbWVUVHpGc0luaTNtL0tp?=
 =?utf-8?B?QzZGdmc1SlV1Q0hLR3V5UTBCQ012SGVDbmJ5QnpNSFYyREJGc3VSZ2VrcDAy?=
 =?utf-8?B?ajUwZkRZaCtIYXc0RmNqMHd2MklHMU5zUUZlT2xOd3d6RWtaME4zZFJyWEdx?=
 =?utf-8?B?WmxMR2grSUJ5MFZFSzlZbDR4YU9lby9IelYzQldTUTNiZ3FZWjYzZ0hWUFZK?=
 =?utf-8?B?SVdrd29BSG95SitaZ0YwMTdHNnhNall5Smd0OGp5SHAxcFhoa1pDalp3OTRH?=
 =?utf-8?B?OG5CVUdIRW1yTFpYTVpsUzRSODV0QTZlaWYvYzVxVzV5WTBIVHN0RW9sUGM1?=
 =?utf-8?B?UEJJakV4ZHhTL08wZjFMVy9yZllJbmhPaXFVZTlCQUxRd0tsWVd3MmlHN1NZ?=
 =?utf-8?B?N01vTkNBQzZmS2JxZkZKa2dTU0lBbmJscjM4QWVuM1BVMmlGVEMyRUpVV1kv?=
 =?utf-8?B?c21Tdmp4ZnNqOVlkbUlzTWZTR2pXQUVkSHduYXg0Z0lMTWM2YmoxaTNaelVh?=
 =?utf-8?B?MXJjQVJ2d3lsdmFQaGFOaTlMYzlVNXhVZzk0Y3VvQ2grUTQxT0xlVUpQc2ZF?=
 =?utf-8?B?K3dLZ2lVVU1XR29ISUV2UW9SMFB6dUFDMkd0YnB6Sldha0tZNW1aTUhxdUc2?=
 =?utf-8?B?aS9hdnFwUmJQNnM0VjNNNHdNdFJpMk9EajVZUTZycCtOQ0tOUzRLU0I3OG56?=
 =?utf-8?B?Ris0d2Rmd3BwVWxGYVplZ2pvMi8zbGcvRHpIWjVoR1Y5emJURFBCekRLZ0ZF?=
 =?utf-8?B?RFFIRFJkdjVxN0ZQbE1BdUFQR1BvOVo0Szlzb3BQWTFrTW5MVWVQR3pSb2pn?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60C31AC859FF3D4D9ACEB1C7A756CB89@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bcada5-5249-4924-f042-08db83b69a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:34:10.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOOlCsCtn0nGWjP9PDxXw98tmQACPvTJ2bjuPwUyqyXMsFFGKY3DQXj2F6o8vuNKTJbqFO9SAZ8JbUE7bmVKArPtOOWHaZkArelW/CzXpKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2102
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksDQoNCkNvdWxkIHlvdSBwbGVhc2UgYmFja3BvcnQgdGhlIHRocmVlIGZvbGxvd2luZyBjb21t
aXRzIHRvIDQuMTQgYW5kIDQuMTk6DQoNCjI0YzM2MzYyMzM2MSAoInNwaTogc3BpLWZzbC1zcGk6
IHJlbW92ZSBhbHdheXMtdHJ1ZSBjb25kaXRpb25hbCBpbiANCmZzbF9zcGlfZG9fb25lX21zZyIp
DQoxN2VjZmZhMjg5NDggKCJzcGk6IHNwaS1mc2wtc3BpOiByZWxheCBtZXNzYWdlIHNhbml0eSBj
aGVja2luZyBhIGxpdHRsZSIpDQphNzk4YTcwODZjMzggKCJzcGk6IHNwaS1mc2wtc3BpOiBhbGxv
dyBjaGFuZ2luZyBiaXRzX3Blcl93b3JkIHdoaWxlIENTIA0KaXMgc3RpbGwgYWN0aXZlIikNCg0K
VGhvc2UgdGhyZWUgY29tbWl0cyAodGhlIGxhc3Qgb25lIGluZGVlZCkgYXJlIG5lZWRlZCB0byBv
dmVyY29tZSBhIA0KcHJvYmxlbSBpbnRyb2R1Y2VkIGluIDQuMTQuMjMwIGJ5IGNvbW1pdCA0MmMw
NDMxNmQ5MjcgKCJzcGk6IGZzbC1jcG06IA0KVXNlIDE2IGJpdCBtb2RlIGZvciBsYXJnZSB0cmFu
c2ZlcnMgd2l0aCBldmVuIHNpemUiKSwgd2hpY2ggbGVhZHMgdG8gdGhlIA0KZm9sbG93aW5nIGVy
cm9yIGluIGNlcnRhaW4gY2FzZXM6DQoNClsgIDE3NC45MDA1MjZdIGF0MjUgc3BpMC4zOiBiaXRz
X3Blcl93b3JkL3NwZWVkX2h6IHNob3VsZCBiZSBzYW1lIGZvciANCnRoZSBzYW1lIFNQSSB0cmFu
c2Zlcg0KWyAgMTc0LjkxMTg0NF0gc3BpX21hc3RlciBzcGkwOiBmYWlsZWQgdG8gdHJhbnNmZXIg
b25lIG1lc3NhZ2UgZnJvbSBxdWV1ZQ0KWyAgMzY2LjYzOTQ2N10gSU5GTzogdGFzayBvZDo0MDYg
YmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRzLg0KWyAgMzY2LjY0NTE1NV0gICAgICAg
Tm90IHRhaW50ZWQgNC4xNC4zMjAtczNrLWRldi1kaXJ0eSAjMzQyDQpbICAzNjYuNjUyOTk2XSAi
ZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tfdGltZW91dF9zZWNzIiANCmRpc2Fi
bGVzIHRoaXMgbWVzc2FnZS4NClsgIDQ4OS41MTk0NTBdIElORk86IHRhc2sgb2Q6NDA2IGJsb2Nr
ZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4NClsgIDQ4OS41MjUxNTZdICAgICAgIE5vdCB0
YWludGVkIDQuMTQuMzIwLXMzay1kZXYtZGlydHkgIzM0Mg0KWyAgNDg5LjUzMjkxNV0gImVjaG8g
MCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgDQpkaXNhYmxlcyB0
aGlzIG1lc3NhZ2UuDQouLi4NCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQo=
