Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5676978DE06
	for <lists+linux-spi@lfdr.de>; Wed, 30 Aug 2023 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbjH3S4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Aug 2023 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245483AbjH3PSQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Aug 2023 11:18:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687EE8;
        Wed, 30 Aug 2023 08:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmUiZ5bdW47gM6f3vcmRosHFEnAnI2qIFQqG+PY1MPQKyQ1U9h/3vMqE421OUzy3z3P5q91d+6j1g6WOG6khUFvkYrNUXydPidwaKKN1pqIRQm0CCtNDLThRtcDsA0/Sb2OF1MigcD/6qymwk3ZBb5CDkada4C/frzjB69by6hYu+ZlwSmtwY7yLM8U3cLDFk/2CCZxv+BlU1dLy9gxzkTtZw3GZSez5XxLY4dmlAt+jHacRbzDpXOSTpl6B8Z6jgIhPc8FIw0cZEinr1MWcEkFdkWb0vV6CBdC0ANVHqtmpCS7FxVd7flE9c+Xd1ulgypU1Ns7BIKaZlVH1XEImEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q1wqqY3M3XGRYVvsS/2wX3PuXWsctK2dcJiP462Les=;
 b=TxJdFlSI69kcoiMHrXJr1fzKvEP66vUTbqjudZJPQNSBGYvo2kRm+iY2BawDpH/KnWyJVp0flmFy7I3oKkhqOZhaYcDz6i9oNKWoTAUw78nv7uPQ5PMUYrAmveLyLfFa/EfVfDtp9830g9cmIGDqjP79pNpZIzKpnPbuP52dD7OwIspYl5DU6YsS7abiP9ceRPSByq0LRkCSTviMBUlPlnL8Qdzp24aLdvRsjDbl/lns29hkMZ/vbQtq2CoUlMCTkUyVEtrpPCM+RmTA/m/VVmkYcP6G+9YrW+OsG/5/azoSgb+Y2dJa7xBrd/8+kYdlAskUO1m1/Kit+D5XUydUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q1wqqY3M3XGRYVvsS/2wX3PuXWsctK2dcJiP462Les=;
 b=pVVCGw3+yiTH/LZyth5dw2zU2c38d+u+MIbG6SuTEu+HL7Im45wmCtO0ACRzwP7otA2E0pz1Tuulo4kVza6wAcMcXb3jTUukg3Vbwxfzfg5VyG4O+K+0tm8MEZQ6qEYtxCS+aBlzQdD8XWYb49d3UP53miy6WfCEhbzsUF1qbZM=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYAPR01MB6123.jpnprd01.prod.outlook.com (2603:1096:402:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:18:07 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::8e13:cc46:2137:9b03]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::8e13:cc46:2137:9b03%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 15:18:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Topic: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Index: AQHZ21J3se5Zb26g9EyYNYpYnGOcfLAC8SaAgAAAdzA=
Date:   Wed, 30 Aug 2023 15:18:05 +0000
Message-ID: <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
In-Reply-To: <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYAPR01MB6123:EE_
x-ms-office365-filtering-correlation-id: 723bf8d1-8198-45ea-5f6a-08dba96c4f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rd1jODXnv2+F7vRThvWMHanzxBlHle7SdXaY7Pvze8Bc6ojXMKnEs0kyadjZlYS09+OziC4NuahvD3dQiObRTeEmMHnz+C/6qvWSw54BHnVo0fbM6ReCzVyXp6njmUfvbjEfNwH6rAcTPEONVFZY9woDdEdxrxvJphufHpGwgWRMYLCzw0KqL16VovBiWKJINiJvcJlS/fZ/pK8qfiLan6ywOOB4KxpPE13I9+5dXypSfEIeQJ+1urh3i8lcgXN2a+RZ5VpOJhp7ax7NY8pbEOyew5Eaf+/iAjPys5mBsHLWHTeSMWM4pSamF4dV240FgSn2SEpKfJaZ/WQHCD8gBMQYe/uNR0Tw2Jz5pU/Pr4jw9RQPPiOQYaHLJ9zylcnt7qHPocrklnbFJa9eRg1tc4QWkdDR/ex5g0DGOMziW/yk5HUGHPObnTWILSyaZKA8lI7o+bBlazD0JwPkSwRTnpArmi+tzJY/6GMSZBaXJRU2Dowr1Ujf965yCxLLejWDnrVYdhOrKqXDpgEiWbuZ+FQUuIeFrlqPsX7Jn8wOWNRY5kP/JVVxoJi9bjPlYH1Ip7VN9YyuU7TS3cDQ4QnOTpkPVeVn7VSBXTiiwsW0mXg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(33656002)(66556008)(6916009)(66446008)(64756008)(2906002)(54906003)(66946007)(76116006)(316002)(66476007)(55016003)(41300700001)(53546011)(9686003)(71200400001)(7696005)(6506007)(5660300002)(52536014)(26005)(83380400001)(86362001)(966005)(38070700005)(38100700002)(122000001)(8936002)(4326008)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXdNak92b0kwQkRHTGE0OFZJdmtRcG1yRUFTdThYZnV4YVBHZ1BpS2NlMUdh?=
 =?utf-8?B?WkhqcHo2SHl4MWtHU2dqckwrQWFFc0EwUXRuRVRIaGxKY0JyVFZmYXpONWg0?=
 =?utf-8?B?WnFXb3NGYWY3TzlvMWlrWlRKaExhSGRkWFdNdUNMOEpwN1Y3SExLOGY0bmFh?=
 =?utf-8?B?bzRBOCtmQ3pjWjhnM0wzOXVaMlZ3NkF5QnREUVZkS3dZSHBKYjdMNVJKYlZv?=
 =?utf-8?B?ZU4wTWpEdGhHeGs2V1ptWmVnTmJOQmN5bjBzNGpJdTlLVzRVVUsyTys4WmZj?=
 =?utf-8?B?dEc0VzZZS3lCU3lkY2ovdTNiVUtzMGZIeXNuR0pXQ08zSGJkWFROem8zbjFP?=
 =?utf-8?B?a3R5SUQ5N3RVaWlYaXNHOWpCR1dCS01UYm1FbXhzbmhoQkJYVitmZTBPRFll?=
 =?utf-8?B?OXo5VVk3Ni9BUG1XZVdzTkRKV1NFSE43SkkxTGk4MExmaWQvcVRjUFlyNUF6?=
 =?utf-8?B?TWZzYkF4OUxpODNHZGJTSlYvTkhZUDk2N3hyKzNJdGtFVlRpQ1N6cHFBRWoz?=
 =?utf-8?B?WUdPS0IyaUR1eFM5RXhrNzhvdjIrSjRqei9hZTg1R29OZEYrL3QwT3J2dlJG?=
 =?utf-8?B?Zktqc25CcjNEeXcyR1RIS2ZPbUozc2JQU293N1lYTHhiSmVtc0dKMVJVK1Zw?=
 =?utf-8?B?Y2JuNTd1TDNoUnVVUVVXTit2RThSTXZrRzRvU2Q5S3RaV2RoLzEvaGFHbFBF?=
 =?utf-8?B?dWhPVGVkT1VHWTdheVVQQ2szWEFzdFdFdWhDVFpUSnhMMTNBSnR4S0E2emxa?=
 =?utf-8?B?bklTVDVlZmpXQzA2cStlR3E3a0VjSmtpbTc4V2Jtb2FGbE95YzM1RmVGSlNI?=
 =?utf-8?B?QXpONVpVcVZuK2VUZzJuUW5qMEJOYW1LM3BldVRKNUtwc1dNU0l6dzQwYmVz?=
 =?utf-8?B?OU9BTlR5cXZPSnh5Rys4bC95RlB2Qy9ESmFlOU9iOFJZZzQ3a3RCT2NZeU5E?=
 =?utf-8?B?K0hmTDFoQ2FBc3VvbUVBcUlrUnlBWkZEb3p3c1FJU3pINHAzTXByb29IV3FR?=
 =?utf-8?B?VGt1NXZUN3R3TzRYbjNLMWlLRmoyQTIzcDFzYm8xNTE3NVdvRzYrTk9CMW1n?=
 =?utf-8?B?NnlFVDRXZ2hqNjlGaTZkTUo4QTFCcnk5Y2toWUIxMWlPbjNmQUUreG96S3hv?=
 =?utf-8?B?eHNocWM1U3l3dTYxT2lZQ0FYYUJTMVJnTWg3djRrdSs2dnBEbUhxeFN2NHY0?=
 =?utf-8?B?bTVZN05iMFF0Tmc1NGJ2ckdMaEJoY1NvNHdsZzFzL3pXT2p3Sk16clVRRVBz?=
 =?utf-8?B?MUN6M3h1VU11YUFNb2wxWHBhMFRtRDdJV0ZwSlNhZWt1MXYyWDIzMUtuRVhH?=
 =?utf-8?B?bjhyRHo0d2xtVHNIczlNN0U2czV6Y21IaEZtMWdEU2tXVmx4SmxMTXFrUmNz?=
 =?utf-8?B?clVwVjBxT2JwSUVnbE4rWU5xeExlNm1nNk1tV010dnIzcjhyZGxPbVNTakc0?=
 =?utf-8?B?b0dJUFdOT01jQkNXSGV5VndtUG4vNmd4T09pQkEwSHc3aWJTVTdIL05tM1dV?=
 =?utf-8?B?TFBXQzRCZEpobWVvWG55YUpLcTBBaFZYMFFNamF2d2hNNDN0MC8yOEJEVk1p?=
 =?utf-8?B?WThGZnRpOWdCdG1pNW40RWIrOUlvT0xMRnBqSHlXMUYzVnEweWFFWUl5Z3dx?=
 =?utf-8?B?WTkxV3U5T1FSUktxRkZPdzM0OHZTeDczdGo1bUkreW9RUHBDMEpwOVY3TTRK?=
 =?utf-8?B?QlZaNUtSYm1WWUxIU3ZUek5FbjRnVWFVc1hzZGM2bUZFaVhMNmtpQmJlRmt2?=
 =?utf-8?B?TDNaVTkwQnN4TnJnL1NZTjVHOXVuaGM4NzZzRzkrRXpJaVlkMEtLN1JMTVJD?=
 =?utf-8?B?QVYzUUhHQ0E4Zmg3NUxxajhGOHE5YlI4d3grcDBQTmJ3ZHl6K3h1QVYwcndn?=
 =?utf-8?B?QXdQNEVGVlBOVnZ6c1Vla1VBbE0rckkzQmVuZUkzWURKbU1NR3RzWDVGZTEv?=
 =?utf-8?B?YkpNU2krWkkyYkZ3RkNFOU9SZDM1RUtDZm1EbCthRGpMQkxueFN6MHNyeTF4?=
 =?utf-8?B?cjU2SmNuR2VIUmlzZC9zcGp1MHJmLzMyOUJqQUNjczk0NGd0OUo5MndmUWdk?=
 =?utf-8?B?UmxKVW9BWFkyVFRCUTFqRVpuNmJVeWxrUnB2cjMxLzJtZ2pNZVJGUUFVMEts?=
 =?utf-8?B?bFVpWW5hbElja0E1QWg1WFUxR3V6V21nK1VuMVRYWHFhbGNXUFpycEtDL0Vx?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723bf8d1-8198-45ea-5f6a-08dba96c4f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 15:18:05.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiCG0ET53fLd57bimGMJm9bPbW9buo2ECtxPkKQdNQZQMFZda+NXP//7fBl8xgTi4257psQPlS7bZRPcY+heOl3Fk2g88YCTfZ5mmkiX5sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBtZW1vcnk6IHJlbmVzYXMtcnBjLWlmOiBGaXggSU8gc3RhdGUg
YmFzZWQgb24gZmxhc2gNCj4gdHlwZQ0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IENDIGh5cGVyYnVz
LCBzcGkNCj4gDQo+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDQ6NTjigK9QTSBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgUlov
RzJMLWFsaWtlIFNvQ3MgdXNlIDIgZGlmZmVyZW50IFNQSSBzZXJpYWwgZmxhc2ggbWVtb3JpZXMN
Cj4gPiAgMSkgQVQyNVFMMTI4QSAgZW1iZWRkZWQgaW4gUlove0cyVUwsRml2ZX0gU01BUkMgRVZL
cw0KPiA+ICAyKSBNVDI1UVU1MTJBQiBlbWJlZGRlZCBpbiBSWi97RzJMLEcyTEMsVjJMfSBTTUFS
QyBFVktzDQo+ID4NCj4gPiBBcyBwZXIgc2VjdGlvbiA4LjE0IG9uIHRoZSBBVDI1UUwxMjhBIGhh
cmR3YXJlIG1hbnVhbCwNCj4gPiBJTzEuLklPMyBtdXN0IGJlIHNldCB0byBIaS1aIHN0YXRlIGZv
ciB0aGlzIGZsYXNoIGZvciBmYXN0IHJlYWQgcXVhZCBJTy4NCj4gPiBTbmlwcGV0IGZyb20gSFcg
bWFudWFsIHNlY3Rpb24gOC4xNDoNCj4gPiBUaGUgdXBwZXIgbmliYmxlIG9mIHRoZSBNb2RlKE03
LTQpIGNvbnRyb2xzIHRoZSBsZW5ndGggb2YgdGhlIG5leHQNCj4gPiBGQVNUIFJlYWQgUXVhZCBJ
TyBpbnN0cnVjdGlvbiB0aHJvdWdoIHRoZSBpbmNsdXNpb24gb3IgZXhjbHVzaW9uIG9mDQo+ID4g
dGhlIGZpcnN0IGJ5dGUgaW5zdHJ1Y3Rpb24gY29kZS4gVGhlIGxvd2VyIG5pYmJsZSBiaXRzIG9m
IHRoZQ0KPiA+IE1vZGUoTTMtMCkgYXJlIGRvbid0IGNhcmUuIEhvd2V2ZXIsIHRoZSBJTyBwaW5z
IG11c3QgYmUgaGlnaC1pbXBlZGFuY2UNCj4gPiBiZWZvcmUgdGhlIGZhbGxpbmcgZWRnZSBvZiB0
aGUgZmlyc3QgZGF0YSBvdXQgY2xvY2suDQo+ID4NCj4gPiBBcyBwZXIgdGhlIEZpZ3VyZSAyMDog
UVVBRCBJTlBVVC9PVVRQVVQgRkFTVCBSRUFEIG9uIE1UMjVRVTUxMkFCDQo+ID4gbWVudGlvbnMN
Cj4gPiBJTzEuLklPMiB0byBiZSBpbiBIaS1aIHN0YXRlIGFuZCBJTzMgaW4gJzEnIHN0YXRlDQo+
ID4NCj4gPiBBZGQgYSB2YXJpYWJsZSBpbzNfZnYgdG8gc3RydWN0IHJwY2lmX3ByaXYgYW5kIGNo
ZWNrIHRoZSBjaGlsZCBub2RlDQo+ID4gY29tcGF0aWJsZSB2YWx1ZSB0byBkZXRlY3QgbWljcm9u
IGZsYXNoIGFuZCBzZXQgSU8xLi5JTzMgc3RhdGVzIGJhc2VkDQo+ID4gb24gZmxhc2ggdHlwZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+IEkgZ3Vlc3MgdGhpcyBp
c3N1ZSBpcyBub3QgdW5pcXVlIHRvIFJlbmVzYXMgcGxhdGZvcm1zLi4uDQo+IA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWVtb3J5L3JlbmVzYXMtcnBjLWlmLmMNCj4gPiArKysgYi9kcml2ZXJzL21lbW9y
eS9yZW5lc2FzLXJwYy1pZi5jDQo+ID4gQEAgLTE4OSw2ICsxODksNyBAQCBzdHJ1Y3QgcnBjaWZf
cHJpdiB7DQo+ID4gICAgICAgICB1MzIgZW5hYmxlOyAgICAgICAgICAgICAvKiBEUkVOUiBvciBT
TUVOUiAqLw0KPiA+ICAgICAgICAgdTMyIGR1bW15OyAgICAgICAgICAgICAgLyogRFJETUNSIG9y
IFNNRE1DUiAqLw0KPiA+ICAgICAgICAgdTMyIGRkcjsgICAgICAgICAgICAgICAgLyogRFJEUkVO
UiBvciBTTURSRU5SICovDQo+ID4gKyAgICAgICB1MzIgaW8zX2Z2Ow0KPiA+ICB9Ow0KPiA+DQo+
ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnBjaWZfaW5mbyBycGNpZl9pbmZvX3I4YTc3OTYgPSB7
IEBAIC0zNjcsNw0KPiA+ICszNjgsOCBAQCBpbnQgcnBjaWZfaHdfaW5pdChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGJvb2wgaHlwZXJmbGFzaCkNCj4gPiAgICAgICAgICAgICAgICAgcmVnbWFwX3VwZGF0
ZV9iaXRzKHJwYy0+cmVnbWFwLCBSUENJRl9DTU5DUiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFJQQ0lGX0NNTkNSX01PSUlPKDMpIHwNCj4gUlBDSUZfQ01OQ1JfSU9G
VigzKSB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSUENJRl9DTU5D
Ul9CU1ooMyksDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSUENJRl9D
TU5DUl9NT0lJTygxKSB8DQo+IFJQQ0lGX0NNTkNSX0lPRlYoMikgfA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUlBDSUZfQ01OQ1JfTU9JSU8oMSkgfA0KPiBSUENJRl9D
TU5DUl9JTzBGVigyKSB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
UENJRl9DTU5DUl9JTzJGVigzKSB8IHJwYy0+aW8zX2Z2DQo+ID4gKyB8DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBSUENJRl9DTU5DUl9CU1ooaHlwZXJmbGFzaCA/IDEg
OiAwKSk7DQo+ID4gICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgIHJlZ21hcF91cGRh
dGVfYml0cyhycGMtPnJlZ21hcCwgUlBDSUZfQ01OQ1IsIEBAIC03NzQsNg0KPiA+ICs3NzYsMTIg
QEAgc3RhdGljIGludCBycGNpZl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
KyAgICAgICBpZiAocnBjLT5pbmZvLT50eXBlID09IFJQQ0lGX1JaX0cyTCAmJg0KPiANCj4gV291
bGRuJ3QgdGhpcyBhcHBseSB0byBub24tUlovRzJMIHN5c3RlbXMsIHRvbz8NCg0KSXQgYXBwbGll
cywgaWYgdGhlIGRldmljZSB1c2VzIHRoZSBmbGFzaFsxXSBvciBbMl0gYW5kIGl0IG5lZWRzDQo0
LWJpdCB0eCBzdXBwb3J0Lg0KDQpbMV0gRmlndXJlIDIwOiBRVUFEIElOUFVUL09VVFBVVCBGQVNU
IFJFQUQg4oCTIEVCaC9FQ2gNCmh0dHBzOi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLS9tZWRpYS9j
bGllbnQvZ2xvYmFsL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLXNoZWV0L25vci1mbGFzaC9zZXJp
YWwtbm9yL210MjVxL2RpZS1yZXYtYS9tdDI1cV9xbGtzX3VfNTEyX2FiYV8wLnBkZj9yZXY9M2U1
YjJhNTc0ZjdiNDc5MGI2ZTU4ZGFjZjRjODg5YjINCg0KWzJdIHNlY3Rpb24gOC4xNA0KDQpodHRw
czovL3d3dy5yZW5lc2FzLmNvbS9ldS9lbi9kb2N1bWVudC9kc3QvYXQyNXFsMTI4YS1kYXRhc2hl
ZXQ/cj0xNjA4NTg2DQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiArICAgICAgICAgICBvZl9k
ZXZpY2VfaXNfY29tcGF0aWJsZShmbGFzaCwgIm1pY3JvbixtdDI1cXU1MTJhIikpDQo+ID4gKyAg
ICAgICAgICAgICAgIHJwYy0+aW8zX2Z2ID0gUlBDSUZfQ01OQ1JfSU8zRlYoMSk7DQo+ID4gKyAg
ICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIHJwYy0+aW8zX2Z2ID0gUlBDSUZfQ01OQ1Jf
SU8zRlYoMyk7DQo+ID4gKw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gDQo+IEdy
e29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4g
DQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5
b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBj
b252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tl
ci4NCj4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJv
Z3JhbW1lciIgb3Igc29tZXRoaW5nDQo+IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
