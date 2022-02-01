Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2D4A5FF3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiBAPZG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 10:25:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29114 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiBAPZF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 10:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643729105; x=1675265105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=58ocPU0uEnMkUKLqY1tubTsVog/8TMEKNzAvLjD0vGA=;
  b=Q1AzQGcPOGGVcGT409AudEsH9/o2F38iSzG4ITCCelw5Jfi55Zi++ZmZ
   QXfQ46MPudWLX3hnhE5rCc51ELn7kzO/bwmvvPYP5BhpWW2YK6Hcd2+wt
   GfzSOqLsJ/keplHjTSbJfJeNAo/jHUE+jb/GUOdi8T0jCnAL+5H9NE1t9
   r1fWRO//CQBPu+ui2xXw/v18BHzQSCOd/NlX6hHqQnzg/XR5V/M/PAifd
   eT2q3Q4/H3f/Qh+B4QDpKGvogP/+8qfQ5aoIzGlWecrrk6RR7LslU7pii
   H5uiosWIHPqmhC4LNnuZXY1kierJ8WZYz1f1YQFNblEZ+jNFEFTTaWq76
   g==;
IronPort-SDR: N4jCE5cA/wRD9GlqTQk+CNSrOhnDVsgRjusACa9pQUZ0AKSmbU5J0wAIPlv/WdubvEP7E065z3
 DD1mmQdCYNWB007hZ4i9kpvLn2+2B0jCVI8PO4Mg5HlLdr0zcUpATGg2xWaGQjsFlmuGPgvLcE
 agV915rweq9WG0zeiTnx8khoTLoklaoJIrDfl3hZ27fADr7ecLyjSnS+kIKhawTrPbmLEdPh+k
 0qCBnsY/90UEjDatEncYYKumybI8j6V7E3OjNZM609mwtt9wfFDRAs816bEg2nOdqpjxWvHj6e
 m7wUDV8VSb0boNoQdRecFPCR
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="84324086"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Feb 2022 08:25:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Feb 2022 08:25:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 1 Feb 2022 08:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaB6wqciglKigeGSjogvpIXnagoUacJabJLj+/lzvavTLtozPog8uEgsbdI2m5S0tmNYNjsLmIHmXeeyRlGEA+ljdPjAA6MB6a4j87lCYvW5fU/xMDUEEMHbZRr1PBOTpdUNDmdpvKfMwTq3ITMcstGYgVrrVayEdgPLPPHDUS5FmUoSoFsauJkwCNBI8LiK1I602Zs1fntRRn7q1TxaqgTRpDvozf2tibALLZ9NyKXX00IenFurdUAwE/aEqpeuf8GaZ3O0Eif7QILnC6oXvz9SQmChbzB1hM0bEQarVEMq202BGaQl9MyA4uAX6v6khPQz17GOgJE+LFcsfpA9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58ocPU0uEnMkUKLqY1tubTsVog/8TMEKNzAvLjD0vGA=;
 b=Fx8zt5qjIKlTtLsgNkru0ogH/V47lB3kX77UOEq+dq4HWWa3cjg0lwP7FooNsx2lr7A96vycxKBJ9Sm7G1ErD3jhaXYMYy41oIkn2nuHLaXJVWWIrS/kJRMG9zP+TqMFuAT8VXRHs04SDTnldTG4u6ede8dTynKNsGL8zz9/hJGMY7NDan5iz5dS7kR0QuBhn1/e0aYbyFj0oplvBXGVF14r7h3WtdtlWuk7n1fyAfQypLPBVubhK5it952l/0g4fc0nPE33TrFXPC17AIidTHP079XkNRlDd/u4NcuLEPr2ZSaHCCnbwPsbdBBmyeJ4UZqPAEP2qUyZcgvc5/fVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58ocPU0uEnMkUKLqY1tubTsVog/8TMEKNzAvLjD0vGA=;
 b=V92U8hHyOg+MjbveuXXu9FraKwsmY9bn0imahI3kO8SfX/9tX6ZUkJ8bMZu61zf9ntAmp7HsEC1IuTIxICCk3R6YJ7+TG/oQfEpD7cOWbwAE7dsoEiIkasMDqqFDczYrk6r6eNdDIZ5r46owNS+w6nmKpgXu9q7eDnj6zN0dP14=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN8PR11MB3556.namprd11.prod.outlook.com (2603:10b6:408:8d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 15:24:59 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dd70:c5d5:fa3:7d94]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dd70:c5d5:fa3:7d94%2]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:24:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>, <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <boris.brezillon@collabora.com>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <corbet@lwn.net>,
        <mauro.lima@eclypsium.com>, <alexander.sverdlin@nokia.com>,
        <andriy.shevchenko@linux.intel.com>, <hans-gert.dahmen@immu.ne>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Thread-Topic: [PATCH v5 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Thread-Index: AQHYF3/fLAfXZX5xPUSyfvHuaqhb6g==
Date:   Tue, 1 Feb 2022 15:24:58 +0000
Message-ID: <ed2a0fe0-c78d-7f09-6f68-b378cb09931e@microchip.com>
References: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
 <20211220164625.9400-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20211220164625.9400-3-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33f66622-6e55-445b-0b49-08d9e5970234
x-ms-traffictypediagnostic: BN8PR11MB3556:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3556038A99FA297770482339F0269@BN8PR11MB3556.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vRFsbe1/Q0aysnHR5GuFvQ0IHymwd89BpG9PKjUkUMUNOQc7qHJ4nulFCvYqIO4/kDccuFTHIR0mJz108NS8cWx4JDwBwyKsoKwIQgMA3j4w7DcAuD0Tg8luJ7mlFFNf7SAw0DSSO1F46djXwL1WWH1AOGU2fQ55kaU3aNSPOBM9t9FM3ffv4DWAsybTvoxkCw5nM5V0kMAUcmFXxqybihhH6jg/iE2FbSLqpeLTWMYCcSEulp1Z42ssGwUrIaewd7QbHWx+MZP/EwASlnd3uEqPBwbqoEG0VLT034wO0kN1yI78Tp6Qj3hh9qi3ZbypLBMF8pJniobF7i1bHii9CD9FklLV6vChN76XwQnS566ECz+9RNv330LOfbTglor1POKE4B79Oxbo4hNHzSBnhrm15mlD7YynRZLgFe4wcSgvg0pKLF9ijGrVg0IcgrQPJTAP7e8cGGduH+KDeyXFYXPRJKpYKG1u4uMscA7x3gD4WmnzLHL0IK1tAUUlnbjRCtyAqMCM9LAxldllavUaRI0NFhwO6oR/FeHusH4XDBhxqpz9Pw87Y98MRwWtts8GSN+zKDP2Rr8SVT3OnCvSx3sHI5yWT/ndBB/gU2Mt95rqn9DGuVfs8A778nh3NQIH0pPufbcoI+ObmKu2y8q9PWJVKVKGD3btoZOlpAd57ng6u9Mf9EOLgt26pWhq9ZtWuM/uG8AXhmUpHQTO/iq5q3HMV9xHSslehKWZnx+Yrfd+tUxVYv59nq/KMBrvuyytz+3clsOqCAisZOi/WS8Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(31696002)(31686004)(26005)(86362001)(8676002)(6486002)(83380400001)(122000001)(4326008)(36756003)(2906002)(186003)(5660300002)(91956017)(76116006)(8936002)(66446008)(66476007)(64756008)(66946007)(66556008)(7416002)(2616005)(54906003)(38100700002)(110136005)(6512007)(6506007)(71200400001)(316002)(38070700005)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ROVy9iNW53b2hEWENWYnFNaVNMUEVIbHllSXFPaGE2UmtaTEtHeGprc2pQ?=
 =?utf-8?B?Qm9WdVA2K0RtaG5QTEM1VUNCUFhhMUhCdno1b2VEOHNRMmo4S0tEeEc1cDdY?=
 =?utf-8?B?Z1VQTDUvWHMrQk01QkFZaGtXYmVpY2w2TUFlQllLOHFPSUtSaEJhdm9zU3hp?=
 =?utf-8?B?NTE5dC91cHNLOHJueThhT0JzQ2s1VkVadElYK3crL1dMV1k0cVlVaHB1bHpW?=
 =?utf-8?B?T3pnaXlJdVN3R2pyVlpGbVZXZjBNV01HdFI2dG9ncFdQdHh4UlUyS3A0NVY0?=
 =?utf-8?B?VHB0ZnMrWDFpdWMxS1dPeFc3NFF1SUgvWXFDRkpBbFVua1d0ZkJJY2Q4Vnlu?=
 =?utf-8?B?RThWQ1FwRm01VXBtMzFpNjZaaFlISVpMMHhnOWxiM2gzVFRKbFJydmZTTE9q?=
 =?utf-8?B?YzFGYUpOSzRKd1ExZEpqTG00RWpMTWhuSmZUbTlQWWlSa0FkV0xzNkFpQnJQ?=
 =?utf-8?B?WDZ0MGRSek5aQmdTL0J1bUxBWWNSZTNTS054Q25iemV1ZHE5WWIvUE0vMGJT?=
 =?utf-8?B?TW9McGpUSDJudE83bUFpL29NdmZXRlBkRWkxYkhZc1VBYzRQenBoZlU4RHNM?=
 =?utf-8?B?L0YrT0VPY3Z1OEhvb2xiZW5uOHo3a2U1TlhsSHZOK2x2b3VMMldseVE0TURy?=
 =?utf-8?B?a2NSUmdGT3hsc2RXdmpJTDFpVkdCRzluV3BqcGtBRGpQQkQ5L3o2a2VOUzZ2?=
 =?utf-8?B?aUxsQWFHZW5GcGpubStYYytTZFAzV205eng5YzV6RWFzWVlaWnd2NjBWZnJI?=
 =?utf-8?B?MXIwbnZpb0QvSXNhaXBlZk9LMXQ3bnhiMzFaY0YvZGRaaU56dGQ0SWJvOE54?=
 =?utf-8?B?enNZWE5VdE1KSzJjdDVFWlg4YVFHREpvZDQwUlF0ajl4S3hTaE5zSDY1L2w5?=
 =?utf-8?B?VUk4akJDQWtCY2JuTGE1eU1VUnBESDJQRlVYeW5pLy9qbWJJSUxRalUrcURi?=
 =?utf-8?B?TGxJSVdQYVBENnduaU13a293emd2aE9sZ3lmOGtyaHJrM1c1YkRxQks5QWxD?=
 =?utf-8?B?WUcyOFE1cVFLZnVYQnlJUEgyc3dXWFpZWWtDNURsUm5Gcnc1aVNDVlU3OEdV?=
 =?utf-8?B?VjR2ZEJ1dy8rdkpVeGNMRWdIaVZtNzRXYW9jcDFVNUVkcytpdytXQys1azVF?=
 =?utf-8?B?MitrblJlQzZrY1dld3ZreHB5NjE1MmZvbG9aU1JjcjhwckNYZE5lR1JDRGpJ?=
 =?utf-8?B?ZWcyUUNaelZ5a1ZPSHl2ZTFDVDJMMEtmUlBvUkJwM0hsS2NJaGdnN25mOVlF?=
 =?utf-8?B?RkVZeExacDhFRTJNMWFPNjB2NFRpcTlicFIrMjhGd0xMVTJOeHJJN2svaTRV?=
 =?utf-8?B?MDEwV2ZDY3hFUkVBQ0VxYnljY2NMM05jaDJ5bFdLaVNZemozZUNld296bk9X?=
 =?utf-8?B?ZkVzSTBlTDFVRzRBSVIrZE95bHVvSmErMDhCZkdHN0pvS3RJM2cwRTNpOG9S?=
 =?utf-8?B?Tk5vaEgyaXZHemtaNXFucDNuOEtjTU8wUDlCSnFjY25oUVBMSUJMZUE3ZVZF?=
 =?utf-8?B?SzRkL1lnUXR5K2NpS21EcE9ucFJScHM1ajVWbzFwOWQ1YUV4UHBvS3hWalIr?=
 =?utf-8?B?ZitidHY3NVY5ZGZ6Z0pZbTR1cm9nUzhDeVpmN1ZQdGZBQktObmYxa2hKYk9Y?=
 =?utf-8?B?THhpYytUQlRvbGY1TnB3SnkrM09PVWs0NWNvNnF4c1pJQXlnam5YTnp6VTF2?=
 =?utf-8?B?cVJCWU5sWng1VFQrTVR1T1ZUUGtWTS94VXdHRkFla3FhekF4ai9HMVRUUHhv?=
 =?utf-8?B?M3pRdHd6NW5XaEZBSVhNTktFK0VHWno4TUUvNTBQOFF3VXZlOGxFazRpdFFJ?=
 =?utf-8?B?OVZaMmdyVzIwWlBETGxRRWFraEt0cmthb2cxcEwxazd0U01ONi8zRi9sVGJv?=
 =?utf-8?B?bVJjeWVtVDJ2TXpURGNXN1k3d3NabS8yOVY3aXVkMFc1T1lMajNoZGlzY3ZZ?=
 =?utf-8?B?M0xnYWowVWowakZ1WkdvYTlod0IzUkFUMG16TmM0ZUFPZkNiYkQ1TkpYTDVp?=
 =?utf-8?B?TVE2RXlobFp2L2VBNjR6ZVhQT2owN3VraGZyYWVnNzJWa3ovaTRXUURSTzJ5?=
 =?utf-8?B?alVqdU0rSElSU3RiZ1VacUdLZGVsdzFsVGMrVFpQQlVIdE5LRFd6SzlIekhj?=
 =?utf-8?B?NWN3aEdkaEE5cnIxTzRqb2U1ZnRablVhYnBZalBweW9XVktIMlh0Tm5xbExn?=
 =?utf-8?B?MWJsTmVFMEs2Vm53OUpRdDhRQ3VYTFpLTU1aNE5VOTVzYStCelRyS1MvalhX?=
 =?utf-8?B?bC9UUUIrczFOUkEyTDhVbHVNbjNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC8C3396C5BE6644A69C70A0584B1CDE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f66622-6e55-445b-0b49-08d9e5970234
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 15:24:58.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mTd6Lzor6GLokID3MACy1vPxS6NkQU1W2cA1IPr2JmiLWLZ7HABfRYYrEeNMYwyugb8K/w4akp/TpL2UzW5S5eETum1Cim7+spe9gQUIoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3556
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNw
aS5jIGIvZHJpdmVycy9zcGkvc3BpLWludGVsLmMNCj4gc2ltaWxhcml0eSBpbmRleCA1OSUNCj4g
cmVuYW1lIGZyb20gZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9pbnRlbC1zcGkuYw0K
PiByZW5hbWUgdG8gZHJpdmVycy9zcGkvc3BpLWludGVsLmMNCj4gaW5kZXggZjM1NTk3Y2JlYTBj
Li4zYjEyNjkyNzQxOWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJv
bGxlcnMvaW50ZWwtc3BpLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWludGVsLmMNCg0KY3V0
DQoNCj4gLXN0YXRpYyBpbnQgaW50ZWxfc3BpX2VyYXNlKHN0cnVjdCBzcGlfbm9yICpub3IsIGxv
ZmZfdCBvZmZzKQ0KPiArc3RhdGljIGludCBpbnRlbF9zcGlfZXJhc2Uoc3RydWN0IGludGVsX3Nw
aSAqaXNwaSwgY29uc3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiAgew0KPiAtICAgICAgIHNp
emVfdCBlcmFzZV9zaXplLCBsZW4gPSBub3ItPm10ZC5lcmFzZXNpemU7DQo+IC0gICAgICAgc3Ry
dWN0IGludGVsX3NwaSAqaXNwaSA9IG5vci0+cHJpdjsNCj4gKyAgICAgICB1OCBvcGNvZGUgPSBv
cC0+Y21kLm9wY29kZTsNCj4gKyAgICAgICB1MzIgYWRkciA9IG9wLT5hZGRyLnZhbDsNCj4gICAg
ICAgICB1MzIgdmFsLCBzdGF0dXMsIGNtZDsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gLSAg
ICAgICAvKiBJZiB0aGUgaGFyZHdhcmUgY2FuIGRvIDY0ayBlcmFzZSB1c2UgdGhhdCB3aGVuIHBv
c3NpYmxlICovDQo+IC0gICAgICAgaWYgKGxlbiA+PSBTWl82NEsgJiYgaXNwaS0+ZXJhc2VfNjRr
KSB7DQo+ICsgICAgICAgc3dpdGNoIChvcGNvZGUpIHsNCj4gKyAgICAgICBjYXNlIFNQSU5PUl9P
UF9TRToNCg0KV291bGQgaXQgd29ydGggdG8gZXh0ZW5kIHRoZSBpbnRlbF9zcGlfbWVtX29wIHN0
cnVjdCBhbmQgaW50cm9kdWNlIGFuDQp1MzIgcmVwbGFjZW1lbnRfb3A7IG1lbWJlciBhbmQgdXNl
IGl0IGRpcmVjdGx5IGhlcmUgd2l0aG91dCBkb2luZyB0aGUNCnN3aXRjaCwgc28gdGhhdCB3ZSBk
b24ndCBtaXggU1BJIE5PUiBjb2RlIGluIHRoZSBkcml2ZXI/DQpBbHNvIHRoZSBjbWQgYXNzaWdu
ZW1lbnQgY2FuIGJlIGRvbmUgYWZ0ZXIgaWYgKGlzcGktPnN3c2VxX2VyYXNlKSwgcmlnaHQ/DQoN
Cj4gICAgICAgICAgICAgICAgIGNtZCA9IEhTRlNUU19DVExfRkNZQ0xFX0VSQVNFXzY0SzsNCj4g
LSAgICAgICAgICAgICAgIGVyYXNlX3NpemUgPSBTWl82NEs7DQo+IC0gICAgICAgfSBlbHNlIHsN
Cj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAgICAgY2FzZSBTUElOT1JfT1Bf
QkVfNEs6DQo+ICAgICAgICAgICAgICAgICBjbWQgPSBIU0ZTVFNfQ1RMX0ZDWUNMRV9FUkFTRTsN
Cj4gLSAgICAgICAgICAgICAgIGVyYXNlX3NpemUgPSBTWl80SzsNCj4gKyAgICAgICAgICAgICAg
IGJyZWFrOw0KPiArDQo+ICsgICAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KDQp5b3UgaGF2ZSBhIElOVEVMX1NQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQo
U1BJTk9SX09QX0JFXzRLXzRCLCAxKSwgLi4uKSBkZWZpbmVkLg0Kc3VwcG9ydGVkX29wIHdpbGwg
cmV0dXJuIHRydWUsIGJ1dCB5b3UgZ2V0IGFuIC1FSU5WQUwgaGVyZS4NCg0KPiAgICAgICAgIH0N
Cj4gDQo+IC0gICAgICAgaWYgKGlzcGktPnN3c2VxX2VyYXNlKSB7DQo+IC0gICAgICAgICAgICAg
ICB3aGlsZSAobGVuID4gMCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICB3cml0ZWwob2Zm
cywgaXNwaS0+YmFzZSArIEZBRERSKTsNCj4gKyAgICAgICB3cml0ZWwoYWRkciwgaXNwaS0+YmFz
ZSArIEZBRERSKTsNCj4gKw0KPiArICAgICAgIGlmIChpc3BpLT5zd3NlcV9lcmFzZSkNCj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBpbnRlbF9zcGlfc3dfY3ljbGUoaXNwaSwgb3Bjb2RlLCAwLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPUFRZUEVfV1JJVEVf
V0lUSF9BRERSKTsNCj4gKw0KPiArICAgICAgIC8qIE5vdCBuZWVkZWQgd2l0aCBIVyBzZXF1ZW5j
ZXIgZXJhc2UsIG1ha2Ugc3VyZSBpdCBpcyBjbGVhcmVkICovDQo+ICsgICAgICAgaXNwaS0+YXRv
bWljX3ByZW9wY29kZSA9IDA7DQo+ICsNCj4gKyAgICAgICB2YWwgPSByZWFkbChpc3BpLT5iYXNl
ICsgSFNGU1RTX0NUTCk7DQo+ICsgICAgICAgdmFsICY9IH4oSFNGU1RTX0NUTF9GREJDX01BU0sg
fCBIU0ZTVFNfQ1RMX0ZDWUNMRV9NQVNLKTsNCj4gKyAgICAgICB2YWwgfD0gSFNGU1RTX0NUTF9B
RUwgfCBIU0ZTVFNfQ1RMX0ZDRVJSIHwgSFNGU1RTX0NUTF9GRE9ORTsNCj4gKyAgICAgICB2YWwg
fD0gSFNGU1RTX0NUTF9GR087DQo+ICsgICAgICAgdmFsIHw9IGNtZDsNCj4gKyAgICAgICB3cml0
ZWwodmFsLCBpc3BpLT5iYXNlICsgSFNGU1RTX0NUTCk7DQo+ICsNCj4gKyAgICAgICByZXQgPSBp
bnRlbF9zcGlfd2FpdF9od19idXN5KGlzcGkpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgc3RhdHVzID0gcmVhZGwoaXNw
aS0+YmFzZSArIEhTRlNUU19DVEwpOw0KPiArICAgICAgIGlmIChzdGF0dXMgJiBIU0ZTVFNfQ1RM
X0ZDRVJSKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ICsgICAgICAgaWYgKHN0
YXR1cyAmIEhTRlNUU19DVExfQUVMKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQUNDRVM7
DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KDQpjdXQNCg0KPiArc3RhdGlj
IGludCBpbnRlbF9zcGlfZXhlY19tZW1fb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwgY29uc3Qgc3Ry
dWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBpbnRlbF9zcGkgKmlz
cGkgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1lbS0+c3BpLT5tYXN0ZXIpOw0KPiArICAgICAg
IGNvbnN0IHN0cnVjdCBpbnRlbF9zcGlfbWVtX29wICppb3A7DQo+IA0KPiAtICAgICAgICAgICAg
ICAgdmFsID0gcmVhZGwoaXNwaS0+YmFzZSArIEhTRlNUU19DVEwpOw0KPiAtICAgICAgICAgICAg
ICAgdmFsICY9IH4oSFNGU1RTX0NUTF9GREJDX01BU0sgfCBIU0ZTVFNfQ1RMX0ZDWUNMRV9NQVNL
KTsNCj4gLSAgICAgICAgICAgICAgIHZhbCB8PSBIU0ZTVFNfQ1RMX0FFTCB8IEhTRlNUU19DVExf
RkNFUlIgfCBIU0ZTVFNfQ1RMX0ZET05FOw0KPiAtICAgICAgICAgICAgICAgdmFsIHw9IGNtZDsN
Cj4gLSAgICAgICAgICAgICAgIHZhbCB8PSBIU0ZTVFNfQ1RMX0ZHTzsNCj4gLSAgICAgICAgICAg
ICAgIHdyaXRlbCh2YWwsIGlzcGktPmJhc2UgKyBIU0ZTVFNfQ1RMKTsNCj4gKyAgICAgICBpb3Ag
PSBpbnRlbF9zcGlfbWF0Y2hfbWVtX29wKGlzcGksIG9wKTsNCj4gKyAgICAgICBpZiAoIWlvcCkN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQpyZXR1cm4gLUVPUE5PVFNVUFA/
DQoNCj4gDQo+IC0gICAgICAgICAgICAgICByZXQgPSBpbnRlbF9zcGlfd2FpdF9od19idXN5KGlz
cGkpOw0KPiAtICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICByZXR1cm4gaW9wLT5leGVjX29wKGlzcGksIG9wKTsN
Cj4gK30NCj4gDQo+IC0gICAgICAgICAgICAgICBzdGF0dXMgPSByZWFkbChpc3BpLT5iYXNlICsg
SFNGU1RTX0NUTCk7DQo+IC0gICAgICAgICAgICAgICBpZiAoc3RhdHVzICYgSFNGU1RTX0NUTF9G
Q0VSUikNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+IC0gICAgICAg
ICAgICAgICBlbHNlIGlmIChzdGF0dXMgJiBIU0ZTVFNfQ1RMX0FFTCkNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FQUNDRVM7DQo+ICtzdGF0aWMgY29uc3QgY2hhciAqaW50ZWxf
c3BpX2dldF9uYW1lKHN0cnVjdCBzcGlfbWVtICptZW0pDQo+ICt7DQo+ICsgICAgICAgY29uc3Qg
c3RydWN0IGludGVsX3NwaSAqaXNwaSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEobWVtLT5zcGkt
Pm1hc3Rlcik7DQo+ICsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFJldHVybiBuYW1lIG9m
IHRoZSBmbGFzaCBjb250cm9sbGVyIGRldmljZSB0byBiZSBjb21wYXRpYmxlDQo+ICsgICAgICAg
ICogd2l0aCB0aGUgTVREIHZlcnNpb24uDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgcmV0dXJu
IGRldl9uYW1lKGlzcGktPmRldik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
c3BpX2NvbnRyb2xsZXJfbWVtX29wcyBpbnRlbF9zcGlfbWVtX29wcyA9IHsNCj4gKyAgICAgICAu
c3VwcG9ydHNfb3AgPSBpbnRlbF9zcGlfc3VwcG9ydHNfbWVtX29wLA0KPiArICAgICAgIC5leGVj
X29wID0gaW50ZWxfc3BpX2V4ZWNfbWVtX29wLA0KPiArICAgICAgIC5nZXRfbmFtZSA9IGludGVs
X3NwaV9nZXRfbmFtZSwNCj4gK307DQo+ICsNCj4gKyNkZWZpbmUgSU5URUxfU1BJX09QX0FERFIo
X19uYnl0ZXMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAg
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICAubmJ5dGVzID0gX19uYnl0ZXMsICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICB9DQo+ICsNCj4gKyNkZWZp
bmUgSU5URUxfU1BJX09QX05PX0RBVEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPiArICAgICAgIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICAuZGlyID0g
U1BJX01FTV9OT19EQVRBLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAg
ICAgICB9DQo+ICsNCj4gKyNkZWZpbmUgSU5URUxfU1BJX09QX0RBVEFfSU4oX19idXN3aWR0aCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgIHsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsg
ICAgICAgICAgICAgICAuZGlyID0gU1BJX01FTV9EQVRBX0lOLCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIC5idXN3aWR0aCA9IF9fYnVzd2lkdGgs
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgIH0NCj4gKw0KPiAr
I2RlZmluZSBJTlRFTF9TUElfT1BfREFUQV9PVVQoX19idXN3aWR0aCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcDQo+ICsgICAgICAgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIC5k
aXIgPSBTUElfTUVNX0RBVEFfT1VULCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiArICAgICAgICAgICAgICAgLmJ1c3dpZHRoID0gX19idXN3aWR0aCwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgfQ0KPiArDQo+ICsjZGVmaW5lIElOVEVMX1NQ
SV9NRU1fT1AoX19jbWQsIF9fYWRkciwgX19kYXRhLCBfX2V4ZWNfb3ApICAgICAgICAgICAgIFwN
Cj4gKyAgICAgICB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgICAgICAgICAgLm1lbV9vcCA9IHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIC5jbWQgPSBfX2NtZCwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLmFkZHIgPSBfX2FkZHIsICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAuZGF0YSA9
IF9fZGF0YSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAg
ICAgICB9LCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4gKyAgICAgICAgICAgICAgIC5leGVjX29wID0gX19leGVjX29wLCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgIH0NCj4gKw0KPiArLyoNCj4gKyAq
IFRoZSBjb250cm9sbGVyIGhhbmRsZXMgcHJldHR5IG11Y2ggZXZlcnl0aGluZyBpbnRlcm5hbGx5
IGJhc2VkIG9uIHRoZQ0KPiArICogU0ZEUCBkYXRhIGJ1dCB3ZSB3YW50IHRvIG1ha2Ugc3VyZSB3
ZSBvbmx5IHN1cHBvcnQgdGhlIG9wZXJhdGlvbnMNCj4gKyAqIGFjdHVhbGx5IHBvc3NpYmxlLiBP
bmx5IGNoZWNrIGJ1c3dpZHRoIGFuZCB0cmFuc2ZlciBkaXJlY3Rpb24sIHRoZQ0KPiArICogY29y
ZSB2YWxpZGF0ZXMgZGF0YS4NCj4gKyAqLw0KPiArI2RlZmluZSBJTlRFTF9TUElfR0VORVJJQ19P
UFMNCg0KY2hlY2twYXRjaCAtLXN0cmljdCBjb21wbGFpbnM6DQpFUlJPUjogTWFjcm9zIHdpdGgg
Y29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2VzDQojOTU1OiBG
SUxFOiBkcml2ZXJzL3NwaS9zcGktaW50ZWwuYzo4MjY6DQorI2RlZmluZSBJTlRFTF9TUElfR0VO
RVJJQ19PUFMNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiArICAgICAgIC8qIFN0YXR1cyByZWdpc3RlciBvcGVyYXRpb25zICovICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgSU5URUxfU1BJX01FTV9PUChTUElfTUVNX09Q
X0NNRChTUElOT1JfT1BfUkRJRCwgMSksICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIFNQSV9NRU1fT1BfTk9fQUREUiwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgSU5URUxfU1BJX09QX0RBVEFfSU4oMSksICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBpbnRlbF9z
cGlfcmVhZF9yZWcpLCAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCg0KSSBsaWtlIHRoZSBp
ZGVhCXdpdGggdGhlIGFycmF5IG9mIG9wcy4gTWF5YmUgeW91J2QgbGlrZSB0byBvcmRlciB0aGUg
b3BzIGFuZA0KcHV0IHRoZSBvcHMgdGhhdCBhcmUgaGlnaGx5IHVzZWQgYXMgdGhlIGZpcnN0IGVs
ZW1lbnRzIGluIHRoZSBhcnJheSwgc28gdGhhdA0KeW91IHNwZWVkIHVwIGEgYml0IHRoZSBvcCBz
ZWxlY3Rpb24gYXQgcnVuLXRpbWUuIE5vIGhhcmQgcmVxdWlyZW1lbnQuDQoNCk5lYXQgd29yay4g
VGhhbmtzIGZvciB0aGUgcGF0aWVuY2UuDQp0YQ0K
