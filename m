Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A416AF4A8
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 20:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjCGTSR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 14:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjCGTRz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 14:17:55 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2080.outbound.protection.outlook.com [40.107.12.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD7CCDA2B
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 11:01:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A373CaMj1ka+G5Om12ydD17g+F4IJFG+iANxuA3yTyn23fjLALAYNXl245xuWrxr6bbk87VedYE0Dtf+lwJHsPAexUB+W2wiJydf6P4mqU3mwjwczZkqj3oW1xAqPTsP19t7E8BUJB+hJ6MtWYwn8VAaspG4GsDx/wDyP0eB7bLrPOyFPTVHmEgHPfLlksmmTPLRcIlG3VqFTMkNAQcnaHJOVY5zYQvpsVzZFY+Kxy1Bc4Azz0onkFDQ7SpBSwKdykUFZQndO4yoLtySApZ+m+KgldW3WwdAFIgMo36j1Qhzkd1aBl72pdz/29qkD8hSQijEqOifH396hADtjm+W4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eTprAtFyQs1JVs01dWiPCFRx/8MNVLq3hunosha5wU=;
 b=PUlAyVJW2YGyQj7EpDbzpAcwLf3x+SB4VJkPWjYj4xMXvSC/FW7ZJnsqDmN274G6AEodi2nPoepCrBwic4+VZa7+W19R+9bH/ca2HDZMyHlcqilphD+uQ8JyuLA1X1TM7P1AEWNdM6zJd1J2bcAgkcSJ4H+ng9+dG0uMaful9GuR99025eY74ExCxxsUfDXF/7mIbjt5Rw3n8uwU6vm+Mh4rEUvYdXpf7IbpgMpBjAfrhHY/gilvyVtXIyTrT+WTckd2ABSqluGt2OQUFZw93NuRGEF6XIEWz8Puzm1weFwN2UlsMD4UMTOHFfwTOV0UtVymzC8SAR5p38FFU+Kd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eTprAtFyQs1JVs01dWiPCFRx/8MNVLq3hunosha5wU=;
 b=YqnkabT5crbk9mXJww/i4SjcTJpoA1GE1hg5Dc87NfGGEy3UEh5UAhSaq4bDxS9tnp6Kqcndwp4eflVbj1kKWYvxSBFafU+a4V51vBvoTOuEe+K7j+H2E7njPzrbztIIgxeE7DLzktWCGOf0FOZd+PXskuDimijDduYqjk+MfC0mPnlo4yGKWpPDIVX/C8K1ORFFRIgV9lmIlwzKkm28X7relaM45fumtWCrsavt/BhLNXyWOb8aGY2SA7nAcp4BBR5KP6Lcz0oe6AvfkX8sDCAf3hOT1FQRpsMy418haNWj9H8xzcKz4LV9DmRlKmT7taydl/chAokFIJiaWvpavw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 19:01:55 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%8]) with mapi id 15.20.6156.027; Tue, 7 Mar 2023
 19:01:54 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Topic: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Index: AQHZUSGn3z/bFjp5CkqfEb9Cr4ssTa7vpOwAgAAHYAA=
Date:   Tue, 7 Mar 2023 19:01:54 +0000
Message-ID: <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
In-Reply-To: <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2187:EE_
x-ms-office365-filtering-correlation-id: ae745735-7a9c-4175-e946-08db1f3e6b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g65o0pUN/wOCGVE/rVFqui4KFX8zpQ/yGdJvsXhyrpgqY8REgqr9/yuC42VTtMxKRZF2PYQpqZ+M3gwj8/89duKb+QjnhsCfalOJOHonre6J7wLTQqdHsNoCVzKyS2rcsjQnmeBxeRCWT5oHG0oZmrMV81qs/+TVrErVENeVTeiO+Pe0RGO/92CJD0kLigw7u/Y1cboTTrhSxLFz6JY+5YqjAtzbwGVeZYc2R4GPh6NaNqDLA2on4jirOlm/RnkySLQJ4f39QNDWLzyLU5iCbi9kZRltsPypypvYogzfuDHLsdUG1qGGsHGsjYZHXZeQnoOJ7mdsWzT+/Qj9l12KCcS+xf6ldtq62yUgwwfOc78Lop+Gic3qxA3eHklInDDQlpMWUd43JC8tvXzwH0Iil5ouuExWr76qtOKZtODoCi9bf5+A2Gs5dBGJ1ZiUCgVCt62fVe7nZYg1TSCfjDjdiR77uLAwHWPfhtO1lP9EepBGSPp/Etc5g4WLcXZiQItzse9T26ffK2/H/RQXEse4WgyfZUaUlnTAwBbJ8B8ovY8rC2zB1eGKUNleoCFNUj5d/ooqEyzMPkfGSLvbJdXjUoIXuT3aqvOEV8cgzTWI5BhL6j2G4kMXSMhPZNoXU4Ttwqv/rhTp0K/ApFX90os0Yn+tL3xUHX+6wOJ4jpYhg9gPuqI8LON3tG0DGp6IxZzXf67k4uis0X2P7f4CJj63fPGiOl9+AvvGLfXfuV0qO7vTKc7FJJzJ6//x0QSCkX0iYy/jhPXOBaX5sKDhxL20dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199018)(76116006)(4326008)(8676002)(91956017)(66476007)(66446008)(66946007)(64756008)(83380400001)(6916009)(66556008)(186003)(66574015)(31696002)(122000001)(86362001)(38100700002)(38070700005)(36756003)(26005)(316002)(6512007)(2616005)(478600001)(6506007)(6486002)(71200400001)(44832011)(5660300002)(31686004)(2906002)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWU3SFUxUnE4bzA1cWhpQi91RldXS1p2VHkyUy8rWmRKYnhkN05kWTZrdlNr?=
 =?utf-8?B?dlFrNzlvdDk5MDlTQWNWV2M2ekNyRDFINzRVM1Y1QVlmNzAwTXZvbFZ5Z1Fi?=
 =?utf-8?B?TDZ5NldSOFFVaGM1enM1SDNJZk1TakNKbFNzV3I4d2FqMzVxdFYrU0RJeGpy?=
 =?utf-8?B?eDVEQTlLd3M4SjlESE1tVHZPUitNbVE1QjFwN3IybXZxcTV6YXRZZlAvWWdV?=
 =?utf-8?B?ODNZUGhoanhuK1hBZlF3djZZNUc3d21QWFJLa2RBejB4bUdpUTE2Ymtad1VO?=
 =?utf-8?B?UWpOTzVIelpuLzh0Z0JwYW5mMVRGREZKQzliMG9uWnZDSy8wdTBacWFqUE8v?=
 =?utf-8?B?SVkyVG9XSUFNaTBjVUF6cisxT200T1lPaDlKOHFHb2E2cjc4aTlpd29qdkpY?=
 =?utf-8?B?UWJseE9SckFIc3RKdTh3TDFjMXFTTG9XSU45T2ZteVQ5aFQwNldSZ1BmaVk4?=
 =?utf-8?B?ZzZwU2NSblIwT2xtbkhXTFBBazVvU2JWWnZyYndZWThiY0JmUHFjNHNvTFZC?=
 =?utf-8?B?OVQwSzI3OHRaZVB2Rk5FK1h1REdGclRQODRDTVM4T1RqbjNMWGdRcmtXNzFm?=
 =?utf-8?B?OXVzNmNYcXNtM3ZWUk1WYVdFbUticWl2cHM1bCtLNldycGpFQzVYWDFDWWdF?=
 =?utf-8?B?ZSs0aC9zaVV3cDE3OUhmbUk3K2Q5bENQUzgxZm9QNERjS0Z5amZ3Vmt0aHBD?=
 =?utf-8?B?SFJzbzFHR29YU1NsTE5Yd0R4VUoyempPaytXSjYyZDdjV3VGTDdLWlhvV3Nr?=
 =?utf-8?B?ZGh1dkd3dnJYS1hUSXdUeENUclB3cjZubnBCaFlPMzVDZWxQOXg1dlpNYUhH?=
 =?utf-8?B?MlZVMkR0S3NGOEhrNGc0cGtNOHdnNXRnTldIWGhmelpXSExIU2ZSc0E0bi82?=
 =?utf-8?B?WFpndnZhKy9XU1VkNUVtMmpxNHEvVDQ1QnpmYUJsRkJOb1Q1V1FtOGxtUzg0?=
 =?utf-8?B?SGNwbmdTTDZKdFRLV09BbHVFbEhkc0srNXJYYkpYVlpvNzlrR3hqZ0I2am1w?=
 =?utf-8?B?SUpsYU4wNk0wV2RHMjlaN0xFNnVOQWpkOUZsK2g0bkZwTElXRDRWQ01mV2hX?=
 =?utf-8?B?RTI5UE4zQ0p2WmtwOWtKeU9SS01FWWU3L2h4YlRJa2Z3RW5RWkcvYkRwbnds?=
 =?utf-8?B?T2dvaEF5RTVvc29TVDJpNS9sREI5VXZZdC9zRCtQcm03OEJjQm9UZnB4T3hD?=
 =?utf-8?B?NEZMQXRxdno0THE5MVo4N2NDcG4zc2Y3dnp5WnJOL3ZzaEtXZkxqeUpac3dp?=
 =?utf-8?B?Y3REUDlzQlB4UUozWDd1S0M2K1BGbXorTjBMKzh5SU1nR29rOGdrWDZOeFBp?=
 =?utf-8?B?TVdoUHcvVGRWU0VseWF1ZkNNclpHNEZRWjljYkg3alRDZ2d2dU5uYzJ1cjlu?=
 =?utf-8?B?UVFsVUJWbUxzNTNhUmYvcmVGaG1qZnNvNWlrUkduRXdCb2RwMy9XTndkc05L?=
 =?utf-8?B?V3RRSjlHanVpeDZuMGdEOC94cFowc1RjVkVhd2lhMzFqRmhiYlg4dWJvaG1F?=
 =?utf-8?B?SkJZSEdlZnZGSVRPb0N6cGwxaHYrWDYwQXREWkVqZnNoVUtPdFdPT2dVNVhF?=
 =?utf-8?B?NkdYeHM4QWRMSjAyQjVraVB1ZkRQdHovdkx4Y0VZU0hERldzdnI0NTdpSkdQ?=
 =?utf-8?B?VHBUNUlDY1oyWndGYjhHV0NqaGJGRjRWNUd0TmsyMDJjSFJoMmpaRWZQOXNK?=
 =?utf-8?B?S2VmSVNYcDVXS0szOFRWRjVpZ1FCdUs1TlNJWXo4UVFnTGp3MDhUejlDSVd5?=
 =?utf-8?B?YkpLQzJNaVdPNFlnK1ZLZW9SSWVPUllWaHZjMzVtVGZId3RnTDZ5MXhVcGxw?=
 =?utf-8?B?SnlxR0d0ZjZ5MUprMEVpWjAyb2grdkhCTXFjSkdJajZuZHRjWnU3Vjd2VTBK?=
 =?utf-8?B?MVk4RUZIZ2l0dlNmekFmOXYvdGVWbklIR3p0T0xVaUtnemlaUERlZUxQTDFr?=
 =?utf-8?B?TFZZa2JoZFJXTm83VEZ2UFdwTTBueHNSRGhZMERhYmxxVEV6RXBQRllKN1Mx?=
 =?utf-8?B?cURLNE9vM3l6aVNObXFYVThocis0R0dKelJaRUlVVXZKZHJjSFFWNjdOdXVs?=
 =?utf-8?B?SWd0OTk1Y0JCdWVNRUJhVjNVSi9Zak9kYUhBYmNpdWw3ME83Q29GbmlLbWRN?=
 =?utf-8?B?MTZhTUtYNVZleU1rYXg2VklOM3RxT3BYMFNvYmpyUjMyMjJCbGZ5NnBnMDMz?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE00C9F346B21F40859B5A94B81085B3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae745735-7a9c-4175-e946-08db1f3e6b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 19:01:54.8405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytB1x3pGF/lPXIH5TIFFhfo5/VOfx5/AFwFO/uz5OuTFg9a/W5iLVdn3dPxcsmruhhaxbro14eA6Y0P2S5mtUPSed5labhULneGi7DIRIIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCkxlIDA3LzAzLzIwMjMgw6AgMTk6MzUsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
VHVlLCBNYXIgMDcsIDIwMjMgYXQgMDY6MjE6MzZQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+DQo+PiBPbiBwb3dlcnBjIENQTSBzb2MsIFNQSSBoYW5kbGVzIHdvcmRzIGluIHJl
dmVyc2VkIGJ5dGUgb3JkZXIuIFRoZXJlZm9yZQ0KPj4gd2hlbiBzb21lIGRyaXZlcnMgbGlrZSB0
aGUgR1BJTyBtYXg3MzAxIGRyaXZlciByZXF1ZXN0IDE2IGJpdHMgZGF0YSwNCj4+IGRhdGEgaXMg
c2VudCBpbiB3cm9uZyBieXRlIG9yZGVyLg0KPiANCj4gQ2xlYXJseSBpZiB0aGUgZGV2aWNlIGlz
IGJ5dGUgc3dhcHBpbmcgdGhlIGRhdGEgaW5jb3JyZWN0bHkgdGhlbiB5b3UnbGwNCj4gbmVlZCB0
byBkbyBhbiBleHRyYSBzd2FwIGluIHRoZSBDUFUgYmVmb3JlIHNlbmRpbmcgdG8gdGhlIGRldmlj
ZSwgb3IgZ2V0DQo+IHRoZSBETUEgY29udHJvbGxlciB0byBkbyBpdCBpZiB0aGF0J3MgYSBmZWF0
dXJlIGl0IGhhcywgd2hlbiB1c2luZyB0aGUNCj4gMTYgYml0IG1vZGUuDQo+IA0KPj4gV2UgY291
bGQgZG8gYXMgaW4gc3BpLWZzbC1zcGkuYyBTUEkgZHJpdmVyIGZvciB0aGUgUUUgc29jIGFuZCBm
b3JjZSA4DQo+PiBiaXRzIHRyYW5zZmVyIGF0IGFsbCB0aW1lOg0KPiANCj4gUmlnaHQsIHRoYXQn
cyB0aGUgc2ltcGxlc3QgdGhpbmcuDQoNClllcyBpdCBpcyBmb3IgdGhlIGdlbmVyYWwgY2FzZSwg
YnV0IEkgbmVlZCB0byBiZSBhYmxlIHRvIGNvbnRpbnVlIHVzaW5nIA0KdGhhdCByZXZlcnRpbmcg
MTYgYml0cyBtb2RlIGZvciBzb21lIHNwZWNpYWwgY2FzZXMgbGlrZSBteSBGUEdBIGxvYWRlci4N
Cg0KPiANCj4+IFdoYXQgY291bGQgYmUgdGhlIGJlc3Qgc29sdXRpb24gdG8gZm9yY2UgOCBiaXRz
IHRyYW5zZmVyIG9uIGdlbmVyaWMNCj4+IGRyaXZlcnMgbGlrZSBHUElPIG1heDczMDEgd2hpbGUg
c3RpbGwgYWxsb3dpbmcgYXdhcmUgZHJpdmVycyBsaWtlIG15DQo+PiBGUEdBIGxvYWRlciB0byB1
c2UgMTYgYml0cyBtb2RlIGJ5IHJldmVyc2luZyB3b3JkcyBieSBpdHNlbGYgPw0KPiANCj4gSWYg
eW91ciBGUEdBIGxvYWRlciBpcyBhbHJlYWR5IHJldmVyc2luZyB3b3JkcyB5b3UgbWF5IGFzIHdl
bGwganVzdCBtb3ZlDQo+IGl0IGludG8gdGhlIGNvbnRyb2xsZXIgZHJpdmVyLg0KDQpXZWxsLCBt
eSBsb2FkZXIgcmV2ZXJ0cyB3b3JkcyAiaW4gcGxhY2UiIGJlY2F1c2UgaXQgaXMgdGhlIG9uZSB3
aG8gaGFzIA0KYWxsb2NhdGVkIGFuZCBwcmVwYXJlZCB0aGUgRE1BIGJ1ZmZlci4gQnV0IGlmIHdl
IG1vdmUgdGhhdCBzd2FwaW5nIGludG8gDQp0aGUgU1BJIGNvbnRyb2xsZXIgZHJpdmVyLCBpdCB3
b24ndCBiZSBwb3NzaWJsZSB0byBkbyBpdCAiaW4gcGxhY2UiIA0KYmVjYXVzZSB0aGUgY29udHJv
bGxlciBjYW5ub3Qga25vdyBpdCB0aGUgY2FsbGVyIHBsYW5zIHRvIHJlLXVzZSBkYXRhIA0KYWZ0
ZXIuIEFuZCBJJ20gbm90IHN1cmUgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGlmIHdlIHN0YXJ0IGhh
dmluZyB0aGUgDQpjb250cm9sZXIgdG8gc3RhcnQga21hbGxvY2luZyBuZXcgRE1BIGJ1ZmZlcnMg
b24gdGhlIGZseS4NCg0KV2hhdCBhYm91dCBhIG5ldyBmbGFnIGF0IFNQSSBkZXZpY2UgcmVnaXN0
cmF0aW9uIHRvIHRlbGwgdGhlIFNQSSANCnN1YnN5c3RlbSB0aGF0IHRoaXMgU1BJIGRldmljZSBk
cml2ZXIgd2FudHMgInJhdy9uYXRpdmUgMTYgYml0cyIgZGF0YSANCmJlaW5nIHNlbnQgYXMtaXMs
IHRoYXQgbXkgbG9hZGVyIHdvdWxkIHNldCBpbiBvcmRlciB0byB0ZWxsIHRoZSANCmNvbnRyb2xl
ciAiSSBoYXZlIHByZXBhcmVkIHRoZSBkYXRhLCBzZW5kIGl0IGluIHlvdXIgbmF0aXZlIDE2IGJp
dHMgDQpvcmRlciBtb2RlIiA/DQpBbmQgZm9yIGFsbCBkZXZpY2VzIG5vdCBzZXR0aW5nIHRoYXQg
ZmxhZ3MsIHRoZSBjb250cm9sbGVyIHdvdWxkIA0KZmFsbGJhY2sgdG8gOCBiaXRzIG1vZGUuDQoN
ClRoYW5rcw0KQ2hyaXN0b3BoZQ0K
