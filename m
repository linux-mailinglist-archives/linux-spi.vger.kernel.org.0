Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182E6AF02F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjCGS3X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjCGS2v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 13:28:51 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2074.outbound.protection.outlook.com [40.107.9.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFFADC29
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 10:21:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqXYTQQNMRstKh/RNEBpTcwv1OOG4rVNiRIsQUeH7R/oVQpAZNOOdr22i973I4aNkfX7gap/oCR3I88VzjgiUTDvvEIwdFo6jvP8KNc9LlIjNoHiUUOwStEZzRtoYlgQVkXcoB2krMwZCaxBqAm0HSJf1ff/NsHyIYUvRKO5bjz+dm1JfF+zmzlusQkKmoTlxHpic7/kgm8n9r71Fo/KWPHZafL0Hx6ZnU0Dl7CwfdJaEYjIS+PiTtTjgEKAUlE/Y0JorNWdWpSga18AHXFb1TLVUfI1mJAWD4HN2a3UUenYtaP92qLBi9SfbTq+EAWulicIw7k69CFe22o2c25wVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPg+2UBjmolmNx8VJBPFV/q4librf66iiZRbm8PlXVs=;
 b=f7eeqJKfX6fq1ICpbaO6mK0sRS/AXOj+nuAMITZ/FvwufEM71DKQcxVDTWks0/S8mPBrMZj2x/JL5mDKnEFmTKRarPjvoXqB4eNswQtiSBsxmr1DY9W2X0bDTVYjE4a4nIXFQ7ofpwcrIKryPRd5ujow99i/IwzALOXLOeDfqcgpO3alGJyavR1gUqMxbN374vA14aG3ztN0wiGnJFrRm2dlac64NNRZVQboOdPSkai4YzmYSbsNaA8pfB6tuQLKTG3fNgjjxEE2Ct/m06Xbl6DT6gr2O+BHNnh1JGsGYHMRJFmeacHAIEYtCtLsR4meIBOaI2eWV8yTljFXkojcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPg+2UBjmolmNx8VJBPFV/q4librf66iiZRbm8PlXVs=;
 b=b2v+O3Ux/M+ZSeLh4yb7pFUmp58rgFwrTE/25/MF9cKph8AFbsumTQ6ztlhK1jlKa3kaqVJS0sptcCq1y7Kz/eOWRFwOJcVAzfdu4L7ioRUPR8b1LUtWxeWQIqQq7vfjGV608Whhep2y5jRmxuOb2tI6idwIOJJjJeRMkeS4xk2HVgxzFtJ1CMOOsHtnyE0PXbdnexsvuWG2XvCxit/PGCUoz1YU95uBbtSD/AWh1J8CpafMw62Iz+A87WsR1fmyZ+n/FbClL3d+CEDM+K/wcXxPIp7SQ4Np+mbjtDdZfSyYpwshSmRUwW0f1uyiHAB9ek4mJdEw2ga8QTOXpL33WQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 18:21:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%8]) with mapi id 15.20.6156.027; Tue, 7 Mar 2023
 18:21:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Topic: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Index: AQHZUSGnqRoxLSJMQE+6Z3U70utuNg==
Date:   Tue, 7 Mar 2023 18:21:36 +0000
Message-ID: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3187:EE_
x-ms-office365-filtering-correlation-id: 3e9ba495-601b-4e51-7072-08db1f38c9bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46lo8xd7bjbG5EF2w7xPdxEWkgoqCIqS15zxhBCaoMuFdoSAYkGk0xvFotr+P6H3Lf9dIBJzuvmZlD80qMw+5j7Hs2i7iQ5yBzhFpDwBVfmKBdxXoAoGz8dTJ0lQoUtlb31s8Of4ZiMr4WeN6+Q4sH+MX1ytUEEDkA53j00CzzbAuWIuDVlgvCjIzpQCX7/1RhozJvCqY5uBxHxI7p/waorHlESCve2CNH2dJ2j2UDoIzc+u7WAaWNLJ0O96wNg0P84T5NuYhq/rdXFQZg8wWBB6GtfjnlvaBk8zw5w+E1QD5L5kSm3G9gcx/mKkAvW8qPZNjFG5s55ypVY1PtD4WkiKuQr1FQ4fyn9KSlK2Zj9RUL5Y4PGGb47hghavQUqpmoWTFUoQBs69NktvXgPn1ERGTeZi1UULp2fdwWt74FYfkuhqUdDqsdtY4BPPj8PwJUKjO9aEqbYEFeOn9gwgcOQedzhYTceXWxkVNVFuzJvmE/Xc4ZwNxn99hIZANtAAcVCqyUdfdUMdlmc0lDzxWXVJLAjBKcbeCGFyNzAS3C0BbFFCZgscknl+BEGR6nbM2m15BZjiwViw2WVVVH5zIuNj0GZvvhlfVc1swlUShMAfw+qRSB4nVJSrryBvRsCZpJRHxeKp/Rb28cNJRQrIu4V6InrNkU3SDzGCZhNRdgP+wZgf3waEbkjQYv8XxqXR0mkpE2bOETzN/rMJcSsilyrfU5LaX8MzttgxIqiS91n52iDkkmTEDXfrHGvX2WtosWQCZVOVgjNvJHrCX5E/HEGf/WGr6NQtDew5Y20zqz5eVpRuFYYeMvZZb2MoJC4U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199018)(31686004)(36756003)(76116006)(66946007)(41300700001)(66556008)(66446008)(8676002)(2906002)(66476007)(64756008)(5660300002)(44832011)(86362001)(38100700002)(38070700005)(8936002)(122000001)(31696002)(26005)(71200400001)(6486002)(316002)(91956017)(478600001)(6506007)(110136005)(6512007)(83380400001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVnOWtaNTM3MkpIN2NaRnMzV2xMT0NLM25LTTVFMWdxeWdwSUszVnpITzJp?=
 =?utf-8?B?MGZRZi80WlVCbXNiVlVsRy8reUNSSVJQODE1ZkUvNWpsVzRHSURpUlg2STBn?=
 =?utf-8?B?UnZkUUdVSmR5QUZoanNaNE9iaW9yQ0dyRGhYV2NCTmlneXJqRCtvWjZ0NEsv?=
 =?utf-8?B?cHVvczJpZmxVcFhzV0lSYmpaWEFrRGwrT0czOW9qUXIwN3M0eXM2ckZlTDhk?=
 =?utf-8?B?cjZ1SzlvWWZ2UEJLMndaZW1NMHJlME15cGprUFJiYWVsM1hwdWFxRElWZTZr?=
 =?utf-8?B?Rmw5ZUQ3dERITDdhbjlBSWRxKzNIQWoxOXZWaVZXOTVXVXJGaVMzYWxKWWtm?=
 =?utf-8?B?Rjc2cGFxaGVlaENaZURzS1JiK0ozUmNUZDZsYktHVHkrZjV2cXV5UEJVR3py?=
 =?utf-8?B?OW9UQWdDc1RmVkVzbWg4QS9iakpUQndnZkFhM0I2S2IwZzhPb1ZFRkNUTkV5?=
 =?utf-8?B?Ym1LbHoyL2J0dWJGSVVDVVErQnZjT3lFdy9lTlZqb1BiNnJwenNCOE5uQUk2?=
 =?utf-8?B?Y1V3T0xSa0lIcjJUeVY4OG9xeHpQWGEwNStJYXdKS2ZpN05TdDVtVjdTV3Er?=
 =?utf-8?B?RWtYRlhjTmVONW4rd1Z0Uk5DNW10MmZ5L0llRUFUR1FWRHhtR25iN2s4Q1Zq?=
 =?utf-8?B?YWpHMnpSYTg2MWV1bGs5UC93eGRuem5mWjNEUVQzRnhrcCtaSEVwc3hZUEZX?=
 =?utf-8?B?dHZ6a1ZEdHhFZHBPOXlXWTM3OHM0QnhyeDFORmhtNCtrNk1nVGFYcEVYL1RH?=
 =?utf-8?B?dU9YSDc5OE9vK3hpQ0xpNEZkMllKOUM3OC9MWjFjQWVrT3lNVmljUUxOVWpK?=
 =?utf-8?B?RXJPcElpeXZjTWVPNGJLNmF4RHlsWGgrTi9BdElRVE1qZG9JTUlrT1lnVkl2?=
 =?utf-8?B?LzRIYkJ6TWZidUlkeUsxa3I5cmlMR05TSjhINFhoL2haT0grWm5ROWJMc212?=
 =?utf-8?B?ZUwya2JCbzVMTnpONUtsUEMra21PQlU5TTRsZnluWUZFRyt0RGZIRVI1aCt0?=
 =?utf-8?B?YURLdHNvWS9QUlhDNGdmQmM3MWl4SHdST0h5Vk05bVhzRTgySFVmaTR5QTFl?=
 =?utf-8?B?dmREeTBnaWlJdnNhRmxVUG4vZmk2bTBNU1dCRzRsbG5Yanp0RUpGSTV4WUQv?=
 =?utf-8?B?NEhNd3IyL1Z4MmhmcDlqbVpqZWx1NkhMYlZFbVlVclRDNmRQaXFYU1lVdjl0?=
 =?utf-8?B?SldjQ0ZEbDJPUjRtemRwUjZxQytJSlRWcGtvTkZqQysxVjliSHIySE5Va2Yy?=
 =?utf-8?B?QVdxeTlxMDIrSDlYS1VnM08vazlFODlyV0xBZFpVbkozSldwOWtsc0p4SHNL?=
 =?utf-8?B?UkxRcGVZbDE2dlUwSnhuK3V6U0F1RU1kbHZrdWwrQW12LzdxdmFmanpYRU5Y?=
 =?utf-8?B?Z3RKam1NWXEyYy8zdlUzdGVRR0gxTU55VGRpN1JVMHVUeTR1bjIwZmZUeVhS?=
 =?utf-8?B?Qy9DaW5UN3RxLzVWdkU5YzVFaHJtam5KV1A5T3BWam15eE1KMm1jd2FTekcz?=
 =?utf-8?B?UnFuNHJYZTQrbW5JRGxPSm41dnU0SUxVUFZ2dm4rVTV0V2lFaWl3V1VidTdu?=
 =?utf-8?B?ekhQTDgzbHJyU2xFSUVXdW5MeUhvcGtYRTQvWnNqdTZIRldSeFdFTDJTUCs4?=
 =?utf-8?B?VzY1ZzJEeDNRRjFUeUQ4YXN5Vm1xRVRlcmVYemx4K0srZUFrNFhtYU9jTktP?=
 =?utf-8?B?WnliY0ZNV0NVb2d2dHkyOWJpK09GOGh1aSsyVGtRRUZLb3VqRjBJbFVMNy9p?=
 =?utf-8?B?d1NTTTJaQWRsVnQxMUd6SlUvL2VoTFFpazBTb2ZybUlaTjZmWG9IbDJWTTAw?=
 =?utf-8?B?bkhvQldVcXk4czIva053Njhld3hPc0VONndndlBaKysrdlYwRTlaWFUycEF2?=
 =?utf-8?B?U1NxcGdOWklJZzJvUFV5K1gzQ1BmTTdIakwxMWR0ZzJsUmdDamV5czJMQ2Jj?=
 =?utf-8?B?TzhpT2dQWHcwSXVpczc4ZjVxMlhzb2I0Q0ZKWm1tRkdYL0FFMEFrK3pZTTZS?=
 =?utf-8?B?NnBIL3NJaytFUEw0bndhL2JLbkI2Y28zUjhMa2NHMnlyd3BWZlhVKzVZcHFZ?=
 =?utf-8?B?R0FPcmlvOWJDNWtxeGF3dlBDTW93d2NURHlaS3lGMDdyUXIxYUFIS0c4TDQz?=
 =?utf-8?B?OEphVXBYOW5SM0N2YW1hempqTWNwSU1ubmFoRUJSYTBKOFJ0ZWpCWGRTbHZO?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18A1091FDA6CED4892008920D307960F@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9ba495-601b-4e51-7072-08db1f38c9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 18:21:36.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnQ/0l5aVES+8yrJmAq7KKyhxSlLW3JAG7LKJUsTks1oAQoe1fSCZFHgDU7L1ELSZcZhsmakhv/neDx9YjY/loyvdyjPGts9T+jqG4ytjA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGVsbG8sDQoNCkknbSB3b25kZXJpbmcgaG93IHRvIHNvbHZlIHRoZSBmb2xsb3dpbmcgaXNzdWU6
DQoNCk9uIHBvd2VycGMgQ1BNIHNvYywgU1BJIGhhbmRsZXMgd29yZHMgaW4gcmV2ZXJzZWQgYnl0
ZSBvcmRlci4gVGhlcmVmb3JlIA0Kd2hlbiBzb21lIGRyaXZlcnMgbGlrZSB0aGUgR1BJTyBtYXg3
MzAxIGRyaXZlciByZXF1ZXN0IDE2IGJpdHMgZGF0YSwgDQpkYXRhIGlzIHNlbnQgaW4gd3Jvbmcg
Ynl0ZSBvcmRlci4NCg0KJCBnaXQgZ3JlcCBiaXRzX3Blcl93b3JkIGdwaW8tbWF4NzMwMS5jDQpn
cGlvLW1heDczMDEuYzogLyogYml0c19wZXJfd29yZCBjYW5ub3QgYmUgY29uZmlndXJlZCBpbiBw
bGF0Zm9ybSBkYXRhICovDQpncGlvLW1heDczMDEuYzogICAgICAgICBzcGktPmJpdHNfcGVyX3dv
cmQgPSAxNjsNCg0KV2UgY291bGQgZG8gYXMgaW4gc3BpLWZzbC1zcGkuYyBTUEkgZHJpdmVyIGZv
ciB0aGUgUUUgc29jIGFuZCBmb3JjZSA4IA0KYml0cyB0cmFuc2ZlciBhdCBhbGwgdGltZToNCg0K
c3RhdGljIGludCBtc3BpX2FwcGx5X3FlX21vZGVfcXVpcmtzKHN0cnVjdCBzcGlfbXBjOHh4eF9j
cyAqY3MsDQoJCQkJc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwNCgkJCQlpbnQgYml0c19wZXJfd29y
ZCkNCnsNCgkvKiBRRSB1c2VzIExpdHRsZSBFbmRpYW4gZm9yIHdvcmRzID4gOA0KCSAqIHNvIHRy
YW5zZm9ybSBhbGwgd29yZHMgPiA4IGludG8gOCBiaXRzDQoJICogVW5mb3J0bmF0bHkgdGhhdCBk
b2Vzbid0IHdvcmsgZm9yIExTQiBzbw0KCSAqIHJlamVjdCB0aGVzZSBmb3Igbm93ICovDQoJLyog
Tm90ZTogMzIgYml0cyB3b3JkLCBMU0Igd29ya3MgaWZmDQoJICogdGZjci9yZmNyIGlzIHNldCB0
byBDUE1GQ1JfR0JMICovDQoJaWYgKHNwaS0+bW9kZSAmIFNQSV9MU0JfRklSU1QgJiYNCgkgICAg
Yml0c19wZXJfd29yZCA+IDgpDQoJCXJldHVybiAtRUlOVkFMOw0KCWlmIChiaXRzX3Blcl93b3Jk
ID4gOCkNCgkJcmV0dXJuIDg7IC8qIHByZXRlbmQgaXRzIDggYml0cyAqLw0KCXJldHVybiBiaXRz
X3Blcl93b3JkOw0KfQ0KDQoNCg0KQnV0IHRoaXMgd291bGQgYmUgYSBwaXR0eSBiZWNhdXNlIDgg
Yml0cyBtb2RlIGlzIGZhciBsZXNzIGVmZmljaWVudCBhbmQgDQpyZXF1aXJlcyBtdWNoIGxvd2Vy
IHRyYW5zZmVyIHNwZWVkIG9uIHBvd2VycGMgQ1BNIHNvYy4NCg0KSSBoYXZlIHNvbWUgKG91dCBv
ZiB0cmVlIGZvciBub3cpIGRyaXZlciB0aGF0IGlzIHVzZWQgdG8gbG9hZCBhIEZQR0EgDQp0aHJv
dWdoIFNQSSBhbmQgaGFzIHRvIHRyYW5zZmVyIGFzIG11Y2ggYXMgMzAwIGtieXRlcyBkYXRhLiBU
aGF0IGRyaXZlciANCmtub3dzIHRoYXQgd29yZHMgaGF2ZSB0byBiZSBzdWJtaXR0ZWQgaW4gcmV2
ZXJzZWQgYnl0ZSBvcmRlciBhbmQgaXMgYWJsZSANCnRvIHVzZSB0aGUgU1BJIGRyaXZlciBhdCBm
dWxsIHNwZWVkIGluIDE2IGJpdHMgdHJhbnNmZXIgbW9kZSwgYnV0IHdoZW4gSSANCnVzZSBtYXg3
MzAxIEdQSU8gZHJpdmVyIGl0IGlzIGEgcHJvYmxlbS4NCg0KV2hhdCBjb3VsZCBiZSB0aGUgYmVz
dCBzb2x1dGlvbiB0byBmb3JjZSA4IGJpdHMgdHJhbnNmZXIgb24gZ2VuZXJpYyANCmRyaXZlcnMg
bGlrZSBHUElPIG1heDczMDEgd2hpbGUgc3RpbGwgYWxsb3dpbmcgYXdhcmUgZHJpdmVycyBsaWtl
IG15IA0KRlBHQSBsb2FkZXIgdG8gdXNlIDE2IGJpdHMgbW9kZSBieSByZXZlcnNpbmcgd29yZHMg
YnkgaXRzZWxmID8NCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQo=
