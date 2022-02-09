Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE84AF3DE
	for <lists+linux-spi@lfdr.de>; Wed,  9 Feb 2022 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiBIOQP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Feb 2022 09:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiBIOQO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 09:16:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026BC06157B
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 06:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644416177; x=1675952177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0zEizQUKvoMPQmOYlBL0QcO/HvLpapPTgOYLG/zNbBo=;
  b=SUBNBfIZ+JPIeNPk2CbIwLXjwf/F63qBIy6sBPDT0HawH6ExcMux/MYm
   mF6iRADlChmAwNXfluzoMVeoD0QBfGu6HLIHMSj5r3uO6afKvBvKFNQQt
   evSzJ+IkjpfbfTibrT4cKAPwY3XqnyAv30LJGMyCszzvtg3aRC7txPP2+
   lrwo/TrHIy/Ai4D9IzWECasMD0PJuiTHvizujvhzY6ux9Ya/tbg2q362e
   K83J878QGtW5hfRdE7Fx+2aiIqbSM3Y8rUUNj8oQSQjEG84SwMvtjkWM2
   0XxWHxJmlOEMapPnN5AJTt1ILe2BaN9TrNkUYlatJ8pF+hGI1JzrUNfWA
   w==;
IronPort-SDR: ookV+P3MLHhd/JuISF7Kc2F2I1aEhDi5n0YTHHKyRlDnNhptf9RE6Xf1UNKxkAk+gsf+5zldR9
 sEiFSTYLsEf/ob/GwukOmvlUgSWLd50K/T0gvSfmCJT/yqRklbftV8d2jeSL+tCTgWT06ZxCry
 TdxhYd8mWWamqp74tTRdQhZ2AWA9+JdtbrKeMSBG10jfE7UTTovSUBfFURUsxz9OH2cG54FG88
 nG0HAaeRyGq/KB8T6XlPBAlBLfzUsaYQwQOkYGyVxsvB8TP7oW3O2og1/Q08krpTs1GH+8euA1
 wPsPXvOwXrgBSpSBhbC2LWVE
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="145398808"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 07:16:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 07:16:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Feb 2022 07:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmq0WE7PkJxjOnyu1iurFhVm/QEdHzvvRZjcdPIlsf4cYWwzyMsYKxNtjwTA5QbQJTQWQSLRoIOwUmmegb+9IvqQOctwiVk5TkPEc+aAK8DlAQgZ10vdZ9T7yzjD/775svDQ6wP8fSXfnzvpvzwrb2ImpPmZx2g0ULNyoz3M+TVO7VpSjx0gSL0Tnc5UD1dfD3+xpGsiutXPDWnojLYfRKYUUFLOUrwwxMdg3n4OIHxSB9K38WyNuboNuS4UTSudrDk9D/nR6e++PWZHRT+JfK6xSDPOUwAkqnHNPf1GPp+dq9Kbau4o8cRFL3+aH8+W8B7A9kicc28cSXE5FZS16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zEizQUKvoMPQmOYlBL0QcO/HvLpapPTgOYLG/zNbBo=;
 b=ESV/N0Yg+eGvbF2Bj7Cr9on2YieNKEvu61hAGfWADkUJN0j3/uzNWhwFuUB0nHxrlKD6Ueol8wAIzVLBsvIO3eOZRlImiAGQdjyfW0Rto/lvPm3ZbPIsG+C/e5fGlnlpsSQrHJr5pCuQB3pQM+4z2EqSZzCsg7YG6GVRvFIeH0xkT6yAWbLTwss4JJH2JU1T6q0vOFve2owIxqsov32opvk6jlEGRcPm62x4v1x1VC9mcnPgbSJKUqC8fPlkLIFp571lFqOdJuRrElIhMdyjmTYZdRkyjIVbOt+yP/aNGVcsr+jNx2cqycBf3RiOLY8LsxXytSrRI4EHS/jGuSAzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zEizQUKvoMPQmOYlBL0QcO/HvLpapPTgOYLG/zNbBo=;
 b=fDltJFl3tIWVMNePmbFZkyxKMg3aTcJmfFK4ocnHegfGxUxdmX1m1eDqSCYD5u0KAIyUeK7qCpNaG+wg12Cy8+8JyccbKp57e6I7sfh0LYN1DLOIwyLQnDOHsItVwxV0lLdK8jI3KjF4YGkhYbZrvEuZG+dqXfL/ANY4nSv5WQg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MWHPR11MB1277.namprd11.prod.outlook.com (2603:10b6:300:29::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 14:16:12 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 14:16:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>, <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <boris.brezillon@collabora.com>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <corbet@lwn.net>,
        <mauro.lima@eclypsium.com>, <alexander.sverdlin@nokia.com>,
        <andriy.shevchenko@linux.intel.com>, <hans-gert.dahmen@immu.ne>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI
 MEM
Thread-Topic: [PATCH v6 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to
 SPI MEM
Thread-Index: AQHYHb+WffyeWf2vb0aX96QKM8+hjA==
Date:   Wed, 9 Feb 2022 14:16:12 +0000
Message-ID: <d7522e9d-fc5d-7c9b-2cfe-8ca37178c5a1@microchip.com>
References: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd069f7d-9b56-4a36-11c9-08d9ebd6b9e3
x-ms-traffictypediagnostic: MWHPR11MB1277:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1277F8549D8431B679954579F02E9@MWHPR11MB1277.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tE+h3wLiUf6kNbNKwb2t9POgjv9NzDefy/n788NdSJjxEUHwGrQtBcdQyt5GUj25At7vpyivCdfcBVf3MZBFBIxufYbaYQh8LHRp0mgqSfGffIsdiCuMyr5C5mqn498ZgMXAHN7hhyIAfIdaop9nv6KXmZM3ciIKHqDSjZjpopZdegsuMjmhCW8nwN5rK0dnk6iodOy/4TF1aIciM/zdDj4D8k4yqZPHxLwGROunC6kEQLkCIjjHmbfltWcETRgN5JSklPVc4B7TVh0rwORKt/8unTGA5mblB56Du0qWBtjDHREw3BsDUyyNbtt82NPCqbkgJVjvrIdjD7ZPRs298iyMJjOPvt03xKfKzBqEa5houWU83rXPpyHzBAUD2sQFiUdMqpDEi328t2pCGYNwFBHJjJ14UET05cluzaLFv6yDpiqviqO9Oo9RmGCczaf5ElOvVySwpXpuzZ7UBmMb+k6dQ0Dnag2yG9/hIqASZnhSbIqOFxQUMCOVFFrN3r3bHu6UVLr0FsfFnUi9iBANx6Xi54mkujljFT+64cRx2c5C1LJdgFhy3IaUfNm7NJpeoUnciu9AgvwZe9a4xJndeiE+geU3EWrvNeSGCqLeK3ib+p//EwhpyLl4xqoobVCTnxtAkvsT8cEbqelq49wpFw8noLt6JG8O2aHSjlcSW3lmSO1/eMr5Dob0F/0MyYBZfH77EThd6E6U2kRnw+rTXqRg0sD7hZbN3qM/5TQ+EdERkJ5yjaf6byqrC07WmjMAHpRUVdv+EVgc5qx39J6FUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(186003)(6512007)(4744005)(31686004)(36756003)(6506007)(71200400001)(110136005)(7416002)(316002)(54906003)(64756008)(8936002)(66446008)(66476007)(66556008)(8676002)(38100700002)(91956017)(4326008)(122000001)(6486002)(2906002)(508600001)(38070700005)(31696002)(76116006)(66946007)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjZOZjNMRHlHampTTzFQUmVKRHkxSDFaMUlzYm9GaTYxTFhZT3lwSmNBQUxQ?=
 =?utf-8?B?ZDZ3ZTZDTENNK2FqYVQyRG45NXR5aUFNUWFaLzBHRnVuL3JxVGpxUHBucUpV?=
 =?utf-8?B?empmemtJaVV5WWt4OTJ4UXhBVU51dWU5MWMydVdwTFpSanNNYkZPZHFPMC9n?=
 =?utf-8?B?bkFrVTkrNEwrTDFIRUpGUEt2cUxjajFzZ3ZMRXlnS2lSMHZqcGszRXhRdGN5?=
 =?utf-8?B?YStpYjlQK2U0OWlFRTRjTi95MFZkYWJRRGorT3A0VE1FNmdnM2czK0dnZ1Vx?=
 =?utf-8?B?cVMxY0F6SDhYbTdMWVRrVlVPZW1Pb0dmWWxrQlN2QURrTHlSdmQ4MmIxMlV4?=
 =?utf-8?B?UXVRVENCZUZNQW9oMm94UFZEd2lQS09rQlp1MGpYakoxb1o5Mit4NVBudVhL?=
 =?utf-8?B?SVArZWdiN1ljODB2YXZPNEU1Qnl1NXVEM2YvSDJidmhKMXF3TEg1L2I3RVpI?=
 =?utf-8?B?QVJEVWs0STUwTVl2Q0dDRFN5WWRPUWlzVm5sS0ZENytMTGxpaGo1TDJlVkVC?=
 =?utf-8?B?NStLRktwejk4ZmNDVTl0WXF0Wm5TTHZjajVmUitDOHpkMG1tODFac2swUnVj?=
 =?utf-8?B?VDJRVTNtSzJLMXRyejlzK0tkL25JWUpBZHlRNGg5OVB1U2JrWjZQN0ttQzY4?=
 =?utf-8?B?b3NMb21HL1ZvOENWa0NpdEVwekRrUDBNUVdBdVgyV1dXWnl6NmVqbzk2NHov?=
 =?utf-8?B?RTUrQmRrZGlzcjZGU3Q0Wm03MkM2VGtVazNGSyt1S0JDd1pzUEpNc2FHWkZi?=
 =?utf-8?B?cHF4azV4WURmQm15Z1hPeUx5MUo4L2FTelhjM1Avb1J3TEE0LzhXdmpKcFBj?=
 =?utf-8?B?ZlpuRGV2MmprZ2IydkUvNHVWMjVJQWpSL0tId051UjdHa2ZYTUJUK0FaeHJq?=
 =?utf-8?B?aGxqU293eGdocDZUMWphaFkvbkVWSDZxRU1Uc0Z6dWVsRE8wZ2ZpR1daQWJt?=
 =?utf-8?B?QW1jMURjMjlBRFZLMnMzeDFzb0RZMElyeDVrUzdhVE1GVVlOOGN3Z2NBeXVz?=
 =?utf-8?B?SDNrTUpMWDRjUkFmSHI1QWZJTU1JcUxDL1JnT0FFeEtibTdBeFBkTGJKN2w5?=
 =?utf-8?B?OGZQWitmaEpVcjR1N0tEWmQ0SmhEbm9VQWh1RmVGdlA0cVVtbjFkRTZjdXNr?=
 =?utf-8?B?emlFeFhONzl2TDlWOW15SW5xc3VPclUvTDV1amJ5bW9oaWYzK0krTUYxc3I3?=
 =?utf-8?B?OVk3TmdyTWRmb3BnRXdIRW9OKzZtSFIvZ3JnNjQ0SURwd0NEaFRmeUdIWmJX?=
 =?utf-8?B?UmNTNWQvV0Z0alI3SEFBaUs3N2w5RzZLWnVLNmt4dDVWRU9CVTFqdXA0c0lt?=
 =?utf-8?B?LzE0cmhUUHdZSnZGWkVyMStKRmtJdWgyZ0hKK0RrNCtOUHl3cUlRaHVVcVl1?=
 =?utf-8?B?WjJreEx2VGJQSDNJZjhtVDRXeEJBMXpkRWtsUjNQeTJFK2Ezd0lrRjVQWXdQ?=
 =?utf-8?B?dHUwUUhkZ2hSUUR0eWVwOHd5OXI3WTV1VXRNbjBzc2doSGtXZVhvRUNYTEtm?=
 =?utf-8?B?TnBYVHZ1dTJ0bDZ4S0E2cml1WTk2c2lRRmI0ZmFNNTZJN3VlZjJRcTJ0ZE0v?=
 =?utf-8?B?eC9DWllxMTVHSUZoNEdkWTN5RW9KWlZIQTRiYTBnbDd5alYzam40TUJWWXd4?=
 =?utf-8?B?TmlGa1dyVk5CQkhjU09XUy9QUkpodTI0ZlorVVFLMkNDOXRoZGVhR05Nd2Z3?=
 =?utf-8?B?cm16d3BZRy9jejU5NGJrM0VlQkV2R2ViQXY4SWRwQ0pJdWVhNkVReklRRUJt?=
 =?utf-8?B?RUhDM1hSYUpyTHRkaFhmWkcxSHBQVkVXeDVzaDNad0xrTkxwY3BML3RMU2Fp?=
 =?utf-8?B?Mi8vYkxXdXdNWUlQejUvNFhiSGtXWkRNOEFKc3AxQ0tNNlQxZGlZTG1EQVIr?=
 =?utf-8?B?QzcwSTdvU2JqcTV6cWthZ1ZnK2hlUkkwWWgvV2t6RWd1VGdSanFpU05GV3F0?=
 =?utf-8?B?aHhQc2g1TFpaL0RldzlrSXVYekN0RG0wVGwxMG53WXlXOEREbXQ2OHNCbnZL?=
 =?utf-8?B?TDdvTEI1ZnoyRzFsQkNkYkk2NjhnRzdvcm5OTk53Ym4xQmd2TURQcnlwWGh1?=
 =?utf-8?B?WDBVdlUzU0wybmVERHB6NlVYWS9SOWE4Mm9QQ0h2VEtnQ2JUTnc4YmxYRVYw?=
 =?utf-8?B?Y1hYY0NhZkRCRjExck4xTVJEZks1aDZwWlZBa0g5ZkhMR1BSSXVQUzN3N2RZ?=
 =?utf-8?B?WEJDdGZwWmdIZzZIQUlHeFM2SkFndUpPM2dVMThVWTJXTDhPNnBqKzZTL0U1?=
 =?utf-8?B?WHRiVlNCYitCTjdRSGNlbDVKc1RRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16217497B7DFC849BACE88907AD58CE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd069f7d-9b56-4a36-11c9-08d9ebd6b9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 14:16:12.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDz0eZyS9LDrHX+0mHvtqnGWyiNFV05/uPWAXH+kiz33T5evVzp0T34DGV+WNB5kAf0K/DzDmk/Z1NqRO65oTrni2Pycy6+A2zoWjWXPpm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1277
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1hcmssDQoNClRoZSBzZXJpZXMgaXMgbG9va2luZyBnb29kIHRvIG1lLiBJZiB5b3UgdG9v
IGZpbmQgaXQgZ29vZCwgd291bGQgeW91DQp0YWtlIGl0IGRpcmVjdGx5IHRvIFNQSSB2aWEgYW4g
aW1tdXRhYmxlIGJyYW5jaCBhbmQgc3luYyB3aXRoIExlZT8NClRoZXJlJ3Mgbm8gbmVlZCB0byBz
eW5jIHdpdGggTVRELCBhcyBJIGhhdmVuJ3QgdG9vayBhbmQgd29uJ3QgdGFrZQ0KYW55IGludGVs
LXNwaSBwYXRjaGVzIGZvciB2NS4xNy4gSWYgeW91IHdhbnQgbWUgdG8gcHJvdmlkZSBhbiBpbW11
dGFibGUNCmJyYW5jaCB0byBib3RoIG9mIHlvdSwgdGhhdCdzIGZpbmUgYXMgd2VsbC4NCg0KQ2hl
ZXJzLA0KdGENCg==
