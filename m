Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB847CE6F
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbhLVIoY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 03:44:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15740 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhLVIoX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 03:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640162663; x=1671698663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/xB4yAXdK2RhIlUQhbKY1quYwO0VsxYvr9Jhs8yr/tw=;
  b=L2gYjCGVfALaydjeaiLbW6oxXgTbzRpl+c/i4nBslTrTrjbff52v/is0
   zTSzVOBjkxRT0D+yWKXayeLcteOTfDrSqOMP2dCYzxtfiv3OLai2HEMKS
   jRpQ3ABvJ8tgzj1FXp2kNP+xALD/4I7+j3+o0tlcn37051hVHui4n3E6G
   k0tnbl6kzKN54ajlqdWbsAdxxDzMwOv0wubCEaxCv87dHrlQXssWHYt7V
   Bsi3dxalQsria852C9JROkI2TzAfYp9z1jIvy9IwCz3Q7hGlRbxxp3LqR
   jsgiTIUgHUur0ClKLvdgDNopjVwSoexsDJr6dLZIu+xS8wHzG+jkXIZUq
   A==;
IronPort-SDR: WRYDyaq13yqrCz3K9rbBKi/EmgZkaa/o/8o7SBrGujX9luelAW8X1nbXlHCT1/pBPGQP2E/uGm
 W/JqRyEI1Z8Ywbq0v+yJNPlFnMcsq0aZO90rIG98ROc2YjmCMEm8ewptRD8+wOdQrGcDTErGts
 Xhm2k8NTXwHbdSSVPnK9qu2cbVCdFWiMtztUjNiLqKcMjn0mTU4HbX15aILA3r5cD2442jkHfX
 leYDsxhsVmIhXTz58arFR/cS4GLQHt+LRhsJ7DYjaGvQ+sIZTohvHCz5EaoBmsdQUYt8F+KLX1
 wMeLzXsP2tdjIAh1aOJ5RFZt
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="143213252"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Dec 2021 01:44:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Dec 2021 01:44:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 22 Dec 2021 01:44:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsA9hEnYaC9dC4cbSullwoFA2qTfCpQ0xeeV2tgMFyzBrVFs0nLY0L4V9anhNPGP09Pf8wV//l7bTsjo4kasml1M9EpzJYf3Xk0DmQN4vTwgX8IYAc3it2OpNA+NhhwuLAp2YJ4F2WT7ZaV4aJZWjJidJqZIAIknH2juJCx3+UfZxvIQQb1zJVx3WQ5WvaU85JnsTZqrO+i5hquJerKXqWHFKsrh0qKY0eS+EJ1ylYlwnxSSYJ38DGU5ymaPK40JnO/+qsKpll4IpxfB8uWKRUvfIhGlcuBQgHc0Vr08GT8s05ZiOwM7fKR9f3cEjRC/NKBqQIdkPQXI0PT7eq7LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xB4yAXdK2RhIlUQhbKY1quYwO0VsxYvr9Jhs8yr/tw=;
 b=HS6dFKHAhtP76tNZfkKNAiqZyWQ5gbzh8Z+IPjvP9Bz0Cy+oERx8XVcBLWZKo7xyQlG5Yt3POkqgfKP0PDyT44Tj0ZeA9NOx0pu5u/1omlHoUllFwsCoMvCdZUW1rbcqpctEceVQxxBGEiS1IgsIKfovjNTnQb6sHyUrtHKbqNRtt5uIwcMmqyQRhyjrjRKFBnxfXaaLmIu10kTzgkcymkql9dRbmJ0YbV11w1GXQ2F5CysxHCoivXSAMtPnlmMscjPtXLMuBCgMYc+RRCzy2bMEhg28jQi4z9KTyjcsvH5QLa0olsQhvDtUUhs7LG0ttb+1Xsj5O1ImGqvGMdWVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xB4yAXdK2RhIlUQhbKY1quYwO0VsxYvr9Jhs8yr/tw=;
 b=STHXW8JTFYVCmDUh+YSX/FhIilUUw4fF+R7V14SBnzPtbMBAHrWAAZZWxpgFizBbzMIjERQ8Fg3JW5paICUeDO1pdAETZrbN8ov9gYDfiGkdewxuxCQkh0j2AD1dSby3zAwA7+Wzwqy2RYH/+93gi+Nz7dohw3Le1XacOWPN5D8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 08:44:16 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 08:44:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <monstr@monstr.eu>, <thomas.petazzoni@bootlin.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Topic: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Index: AQHX9wjnQ3zfS7UookqMlT7vSJeh9A==
Date:   Wed, 22 Dec 2021 08:44:16 +0000
Message-ID: <5d8aa116-3f22-9d79-a7f8-2e634d3790e1@microchip.com>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
 <20211221170058.18333-3-miquel.raynal@bootlin.com>
 <a11a0650-4624-0a9f-d0a5-c45393fead7c@microchip.com>
 <20211222090542.43dfe12e@xps13>
 <be9d451a-6451-be58-1c2a-a9aea7f67c56@microchip.com>
 <20211222093523.30f8ae7c@xps13>
In-Reply-To: <20211222093523.30f8ae7c@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdf3fac1-c985-44f7-ef68-08d9c5273cd2
x-ms-traffictypediagnostic: SN6PR11MB2879:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2879D6E2F98323E72945742AF07D9@SN6PR11MB2879.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pzpIAAK6gtkKgmz8atRFaBnesK8ws/H5h6sTApOXKNEYO5pioPOyEjJ8rQ9xAdSrP2dB882RnfSAqMFnM8av1pnLrsxkBwGD3A0UmG6gODS9dlzm+k6QUcgYYu1DxJXWhYXIny30d3vMkbmbtoAhYx/a3JXQUpwmiLjhXUAy7Su4WJ3HBlRK9k5zTBCDYFh3zbW2IVnzHGHAS1iZKl+MXxe/bNAl9yuhKmaHsysiSkgd4zpdAiOpWFI9mRZgpvOE2KJEH99LDcofd+CyuSLjD25Bv7APMaZfeOwgV2fWslzMHLZ5e3dBs6ycIqzZ7nrEYSULdVFCN8qF/UMBmRPtMnqNsZk7QkACYQzy96fcJ1YXlVpZh/kfAn4utkKMPZwaon88FqZFi1eCe/gT/zwbv3aPwaDADCirEXNWeEZgniKVgfoJLTknYQ90vaK4gBwTc+E9ucMnc6qJBPY5cv062Dg02xf/lz0vDa6JAj84Z43NZnSxjFHLpnold94N9k+tdpkE7tCM/nLOK1uxWmStz8DbykVlV6ZAt9VxC+uE+I3wv6GMQtiUYKX8UamqQJXyU62uFeqQ9n70OQiS0a5C1r0FpTI5td9vDycoWUvEeX4wlAsqgqJ3nDSQO/9lq8deuW3gA1MzxQlq39IxzLCkESp2bV0O6gdarlQywm5UHkxxnrZhPragUIAGcsP9ZptpMHVxfxxRzFc1wTxHNIYkdv8HJOWsRVFAIhSiqY8qaTrDTKvmoCfXk3CgfilaCBPi9YT1g7wmIJiTGdIy1TBkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(26005)(186003)(4326008)(5660300002)(71200400001)(38070700005)(66574015)(83380400001)(31686004)(6506007)(53546011)(508600001)(7416002)(86362001)(76116006)(36756003)(91956017)(2906002)(316002)(31696002)(6486002)(8676002)(2616005)(66446008)(66556008)(8936002)(38100700002)(122000001)(64756008)(66946007)(66476007)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1ZYanY1czAwT1hWbEY0WWhRTm5xNzFnOEFmRW5KMEhGVkRnN2hHUTZQdWFt?=
 =?utf-8?B?QjVRTmltWjB6TXdsVXNVSFZJL3VhTDVLTit6SWFWWHFpaXJ3R1dDQThMQVVL?=
 =?utf-8?B?a2R2U3pUT0UvZEV3YkF0ZjI4ZExjZ0ZqeGZNemlsaW80NVhlRThvWGJGTDcx?=
 =?utf-8?B?akQ3ZVVqMUw1T3VEZHpoTGtvcUJGaUlVNmRBZ0tpc0E0NzFPWndRWlNCY21p?=
 =?utf-8?B?TDBtZlg0UkJmNWVKWEh3UEZYc1NkOEk2MWRSK3NwU0pEUnozd3ExKytwTkFD?=
 =?utf-8?B?RERETVBnb0FtOXFnOEswMHgySitxbDVvdkxMem53dUJxazdyb2tkaTF4b0dw?=
 =?utf-8?B?OXRYNFhmakV5QUVPRnBScFR4alRYRmgxbnF2YmhCQnA1K29MWi9ma0paQWlH?=
 =?utf-8?B?WmRqczNxSnFDTG1LL0ttNll3U1A4NnZmSC9BZXpiNjNCUE1oQnNoSG5iNE1F?=
 =?utf-8?B?N3l5K2RaRFlSMk1yMWdUYmlNY2hKZXR6YyszZUsyejlka3lzU3F3RWxvYlA2?=
 =?utf-8?B?RFhOMFptOFl2QUNoZ3l6akxEWU1XMW5kSTBtbUhGSHQvSS9kZjlRYjlOL0p4?=
 =?utf-8?B?ekVxYzBhaEs4eTdFVkFwbm9vSHJ4M2ZScE5FOCtBK2w5dzdEYnVWNVN0aFVi?=
 =?utf-8?B?MUFndDNDVnRnRE9hRm1PaFlXWDZnUkNsWVdDdCtRT0U2MU9zTDZPeS9WS1li?=
 =?utf-8?B?VUVVQTZKQXNvbmtZT3BjTEFzYkhSVCtEVzV6WVFSMzVJWGQ2V3h2Snc0OXJL?=
 =?utf-8?B?SENFM1NTL0lVdHZlUTJ6eHBJZ2EwZ051M1pMRnA0UGpCakkwRVA4bTlPdkRa?=
 =?utf-8?B?UzJMcUpNUE9DMFhBdHNURXpyTi9CM2RSQUN2djQzNzllKzhHNG10NTdwZXRu?=
 =?utf-8?B?K0FoZDFZUy9iQUU2SThiaWdDSDE2QUplTXB4VE40U0JCdUNKNWs0bGxjdHZK?=
 =?utf-8?B?KzlDUXkrRVJ6NnlFTHNEMUJYbnpWNE5USkkyazAzVWdsZFVpd1VJTVI4RlJF?=
 =?utf-8?B?cmovQVZtOXFDb3Z6WmFJclJjZ0JtZW15bzlVcnRJcFNEWGdGS01NVEZBSWhP?=
 =?utf-8?B?YVdlR2FncWtXWWsyc2E3QVprbHRxeFFWUWxQZmFSMWNZWElhajJoc0doWnR6?=
 =?utf-8?B?bEpRNEZ3bmpLWW5wRTBhc2pnTFJndUF6N3oyMWIzdVpzQzlYVHBVNlN5aVln?=
 =?utf-8?B?ZDkzQ0F0WVRTZThOV1dRalNSSUNHa1VWQzZDZC93bWRnb2RvV0lSUTMrVEFQ?=
 =?utf-8?B?M3orejZPcW1tNlJiUzZESzhWUFo0bGZDaGtvSXBtTDZOeURNeWozdjlVVHk4?=
 =?utf-8?B?SnNmZkovT21NVXgzWjFZOHc3L0pzMEZGMU1qUjQ5eUhzNE9CSmRTOTYwNFZ0?=
 =?utf-8?B?MTFVWFhlRjJOYzh3VU9aaWNJVXVxRHJSTXU2aEFqNWVjTHd2YkM4RERSMXV1?=
 =?utf-8?B?MlBlRW41d3YwbjNPb0dhaEVmYUpDYlVTLzJHem9CNDkxTlQvYm8vYlB4dXJW?=
 =?utf-8?B?OFRsK1Q5NVN3R3h6MkRISVBGQzd3NjZwOEVtUmhrWml1bWowekdRS1dqMmYr?=
 =?utf-8?B?eXBFTW9EYTVvaWo5UUZ3TUlaMjEzbSsxNkJ2M253eWo2REV0RzFmY3Y3SzRu?=
 =?utf-8?B?WDN1R2RIQ2VFd252U2x0d1VlSFF2TWM0VnVxYW1LejhlcnZFeXN3QzdIejhB?=
 =?utf-8?B?N1NuWmFVN2tuUGkyRHN3VGlSQTM3OTRORGIzeSsyTSs2K1RzWVFDVHcyZDRz?=
 =?utf-8?B?TStDaXVyaDZ2S3I5VEhnTWh4bnE5YkhuVTdnVkQ3SWova2s1dHduSkpPMFMx?=
 =?utf-8?B?MGM1UGRtZ3AyK2pjRUtrbWhiVzRac1pLdFRCdm9iM09ETnN3eW1HSWxTeGpR?=
 =?utf-8?B?ajJ4aUtueUdBRFRyZXRHcmtLbWJMNW9DbGtYaHJlSXFXdXJiT21EdVVGOUZn?=
 =?utf-8?B?NzBEK1lkUi9zZHBQR2VlRWZ5NDk5OHhyK1NaUisrOFFRK1cvT2h5K3NWZGc1?=
 =?utf-8?B?U2lBVlRCY2loS0lFVVFSd3Yra2FmYTFoWDF3V2dGQzRvR1ZzS2Y1clQxb211?=
 =?utf-8?B?TGZNUUdGQnZHZlZZbEhZbnZiUjJadWIxT2xiUWJXaXpjQWNKcnQwa1hLR05D?=
 =?utf-8?B?MzZwTzRMdmxtTDRuZGJoakM0Y2JoQzMyRWhuZjIzMjRLOTBxUWp4Mm9DNElr?=
 =?utf-8?B?dDVHczY0Nmxtd1BzUFJPQjdocXBYamQwQjN4d0Fkd25TM25MT1lzbXB3OTV1?=
 =?utf-8?B?SDJDZm5oVEpUQWNsbGR5U09NWDBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0148828CB81F554E88474F23F229A400@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3fac1-c985-44f7-ef68-08d9c5273cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 08:44:16.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnUe3TrROW5/jZamM9MJV0YkRa0dkIAcleGRJDKKnhjxrnxRC8+pQMFxNHDmSYlugFer8fJVNrCEe8eXjgbn3/VidHMaCPNTf4CprlzbdoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvMjIvMjEgMTA6MzUgQU0sIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgVHVkb3IsDQo+IA0KPiBUdWRvci5BbWJh
cnVzQG1pY3JvY2hpcC5jb20gd3JvdGUgb24gV2VkLCAyMiBEZWMgMjAyMSAwODoyMjowNSArMDAw
MDoNCj4+IE9uIDEyLzIyLzIxIDEwOjA1IEFNLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0KPj4+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gSGVsbG8gVHVkb3IsDQo+
Pg0KPj4gSGkhDQo+Pg0KPj4+DQo+Pj4gVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3Rl
IG9uIFdlZCwgMjIgRGVjIDIwMjEgMDc6NTI6NDQgKzAwMDA6DQo+Pj4NCj4+Pj4gT24gMTIvMjEv
MjEgNzowMCBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4+Pj4+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pj4NCj4+Pj4+IERlc2NyaWJlIHR3byBuZXcgbWVtb3JpZXMg
bW9kZXM6DQo+Pj4+PiAtIEEgc3RhY2tlZCBtb2RlIHdoZW4gdGhlIGJ1cyBpcyBjb21tb24gYnV0
IHRoZSBhZGRyZXNzIHNwYWNlIGV4dGVuZGVkDQo+Pj4+PiAgIHdpdGggYW4gYWRkaXRpbmFscyB3
aXJlcy4NCj4+Pj4+IC0gQSBwYXJhbGxlbCBtb2RlIHdpdGggcGFyYWxsZWwgYnVzc2VzIGFjY2Vz
c2luZyBwYXJhbGxlbCBmbGFzaGVzIHdoZXJlDQo+Pj4+PiAgIHRoZSBkYXRhIGlzIHNwcmVhZC4N
Cj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFs
QGJvb3RsaW4uY29tPg0KPj4+Pj4gLS0tDQo+Pj4+Pg0KPj4+Pj4gSGVsbG8gUm9iLA0KPj4+Pj4N
Cj4+Pj4+IEkga25vdyB0aGUgYmVsb3cgZG9lcyBub3QgcGFzcyB0aGUgdGVzdHMgKGF0IGxlYXN0
IHRoZSBleGFtcGxlIHBhdGNoIDMNCj4+Pj4+IGRvZXMgbm90IHBhc3MpIGJ1dCBJIGJlbGlldmUg
dGhlIGlzc3VlIGlzIHByb2JhYmx5IG9uIHRoZSB0b29saW5nIHNpZGUNCj4+Pj4+IGJlY2F1c2Ug
dGhlIGV4YWN0IHNhbWUgdGhpbmcgd2l0aCB1aW5nMzItYXJyYXkgaW5zdGVhZCBpcyBhY2NlcHRl
ZC4gVGhlDQo+Pj4+PiBwcm9ibGVtIGNvbWVzIGZyb20gdGhlIG1pbkl0ZW1zL21heEl0ZW1zIGxp
bmVzLiBXaXRob3V0IHRoZW0sIHRoaXMgaXMNCj4+Pj4+IG9rYXkuIFRoZSBtYXhJdGVtcyBidHcg
bWF0Y2hlcyB0aGUgImdvb2QgZW5vdWdoIHZhbHVlIGZvciBub3ciIGlkZWEuDQo+Pj4+Pg0KPj4+
Pj4gVGhlIGVycm9ycyBJIGdldCBhcmU6DQo+Pj4+Pg0KPj4+Pj4gJCBtYWtlIGR0X2JpbmRpbmdf
Y2hlY2sgRFRfU0NIRU1BX0ZJTEVTPURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvc3BpLWNvbnRyb2xsZXIueWFtbA0KPj4+Pj4gICBMSU5UICAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncw0KPj4+Pj4gICBDSEtEVCAgIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wcm9jZXNzZWQtc2NoZW1hLWV4YW1wbGVzLmpzb24NCj4+Pj4+ICAgU0NIRU1B
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHJvY2Vzc2VkLXNjaGVtYS1leGFt
cGxlcy5qc29uDQo+Pj4+PiAgIERURVggICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0cw0KPj4+Pj4gICBEVEMgICAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRyb2xsZXIuZXhhbXBsZS5k
dC55YW1sDQo+Pj4+PiAgIENIRUNLICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0LnlhbWwNCj4+Pj4+IC9zcmMvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0Lnlh
bWw6IHNwaUA4MDAxMDAwMDogZmxhc2hAMjpzdGFja2VkLW1lbW9yaWVzOiBbWzI2ODQzNTQ1Niwg
MjY4NDM1NDU2XV0gaXMgdG9vIHNob3J0DQo+Pj4+PiAgICAgICAgIEZyb20gc2NoZW1hOiAvc3Jj
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRyb2xsZXIueWFt
bA0KPj4+Pj4gL3NyYy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1j
b250cm9sbGVyLmV4YW1wbGUuZHQueWFtbDogc3BpQDgwMDEwMDAwOiBmbGFzaEAyOnN0YWNrZWQt
bWVtb3JpZXM6IFtbMjY4NDM1NDU2LCAyNjg0MzU0NTZdXSBpcyB0b28gc2hvcnQNCj4+Pj4+ICAg
ICAgICAgRnJvbSBzY2hlbWE6IC9zcmMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9teHMtc3BpLnlhbWwNCj4+Pj4+IC9zcmMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0LnlhbWw6IHNwaUA4MDAxMDAwMDog
VW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCcjYWRkcmVzcy1jZWxscycs
ICcjc2l6ZS1jZWxscycsICdkaXNwbGF5QDAnLCAnc2Vuc29yQDEnLCAnZmxhc2hAMicgd2VyZSB1
bmV4cGVjdGVkKQ0KPj4+Pj4gICAgICAgICBGcm9tIHNjaGVtYTogL3NyYy9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL214cy1zcGkueWFtbA0KPj4+Pj4gL3NyYy9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLmV4YW1wbGUuZHQu
eWFtbDogZmxhc2hAMjogc3RhY2tlZC1tZW1vcmllczogW1syNjg0MzU0NTYsIDI2ODQzNTQ1Nl1d
IGlzIHRvbyBzaG9ydA0KPj4+Pj4gICAgICAgICBGcm9tIHNjaGVtYTogL3NyYy9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPj4+Pj4NCj4+
Pj4+DQo+Pj4+PiAgLi4uL2JpbmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sICAg
IHwgMjUgKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPj4+
Pj4gaW5kZXggNWRkMjA5MjA2ZTg4Li5mZWRiN2FlOThmZjYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3Bz
LnlhbWwNCj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
c3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPj4+Pj4gQEAgLTgyLDYgKzgyLDMxIEBAIHByb3Bl
cnRpZXM6DQo+Pj4+PiAgICAgIGRlc2NyaXB0aW9uOg0KPj4+Pj4gICAgICAgIERlbGF5LCBpbiBt
aWNyb3NlY29uZHMsIGFmdGVyIGEgd3JpdGUgdHJhbnNmZXIuDQo+Pj4+Pg0KPj4+Pj4gKyAgc3Rh
Y2tlZC1tZW1vcmllczoNCj4+Pj4+ICsgICAgZGVzY3JpcHRpb246IFNldmVyYWwgU1BJIG1lbW9y
aWVzIGNhbiBiZSB3aXJlZCBpbiBzdGFja2VkIG1vZGUuDQo+Pj4+PiArICAgICAgVGhpcyBiYXNp
Y2FsbHkgbWVhbnMgdGhhdCBlaXRoZXIgYSBkZXZpY2UgZmVhdHVyZXMgc2V2ZXJhbCBjaGlwDQo+
Pj4+PiArICAgICAgc2VsZWN0cywgb3IgdGhhdCBkaWZmZXJlbnQgZGV2aWNlcyBtdXN0IGJlIHNl
ZW4gYXMgYSBzaW5nbGUNCj4+Pj4+ICsgICAgICBiaWdnZXIgY2hpcC4gVGhpcyBiYXNpY2FsbHkg
ZG91YmxlcyAob3IgbW9yZSkgdGhlIHRvdGFsIGFkZHJlc3MNCj4+Pj4+ICsgICAgICBzcGFjZSB3
aXRoIG9ubHkgYSBzaW5nbGUgYWRkaXRpb25hbCB3aXJlLCB3aGlsZSBzdGlsbCBuZWVkaW5nDQo+
Pj4+PiArICAgICAgdG8gcmVwZWF0IHRoZSBjb21tYW5kcyB3aGVuIGNyb3NzaW5nIGEgY2hpcCBi
b3VuZGFyeS4gVGhlIHNpemUgb2YNCj4+Pj4+ICsgICAgICBlYWNoIGNoaXAgc2hvdWxkIGJlIHBy
b3ZpZGVkIGFzIG1lbWJlcnMgb2YgdGhlIGFycmF5Lg0KPj4+Pj4gKyAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50NjQtYXJyYXkNCj4+Pj4+ICsgICAgbWluSXRl
bXM6IDINCj4+Pj4+ICsgICAgbWF4SXRlbXM6IDQNCj4+Pj4NCj4+Pj4gV2h5IGRvIHdlIGRlZmlu
ZSBtYXhJdGVtcz8gQ2FuJ3Qgd2UgcmVtb3ZlIHRoaXMgcmVzdHJpY3Rpb24/DQo+Pj4NCj4+PiBS
b2IgdXN1YWxseSBwcmVmZXJzIHRvIGJvdW5kIHByb3BlcnRpZXMsIHRoYXQncyB3aHkgd2Ugb2Z0
ZW4gc2VlICJnb29kDQo+Pj4gZW5vdWdoIHZhbHVlcyBmb3Igbm93IiBpbiB0aGUgYmluZGluZ3Mu
IElmIGl0J3Mgbm8gbG9uZ2VyIHRoZSBjYXNlIGl0J3MNCj4+DQo+PiByaWdodCwgSSBzYXcgaXQu
DQo+Pg0KPj4+IGZpbmUgdG8gZHJvcCB0aGUgbWF4SXRlbXMgcHJvcGVydHkuDQo+Pg0KPj4gVGhl
cmUncyBubyBzdWNoIGhhcmR3YXJlIGxpbWl0YXRpb24gYXMgZmFyIGFzIEkga25vdywgdGhhdCdz
IHdoeSBJJ3ZlDQo+PiBhc2tlZC4gTWF5YmUgUm9iIGNhbiBhZHZpc2UuDQo+IA0KPiBZZXMsIEkn
bGwgZm9sbG93IHdoYXQgUm9iIHRoaW5rcyBpdHMgYmVzdDoNCj4gLSBrZWVwaW5nIG1heEl0ZW1z
OiA0IChhcyBpdCBpcyksIHdoaWNoIGlzIGEgZ29vZCBlbm91Z2ggdmFsdWUNCj4gLSBkcm9wcGlu
ZyB0aGUgbWF4SXRlbXMgaGVyZSBiZWNhdXNlIGluIHRoZSBlbmQgbm8gYm91bmRpbmcgaXMgbmVj
ZXNzYXJ5DQpUaGVuIEkgd291bGQgZHJvcCBtYXhJdGVtcyBmb3Igc3RhY2tlZC1tZW1vcmllcy4g
Rm9yIHBhcmFsbGVsLW1lbW9yaWVzOg0KZG9lcyB0aGUgbWF4SXRlbXMgZGVwZW5kIG9uIHRoZSBu
dW1iZXIgb2YgSS9PIGxpbmVzPw0KIA0KPiAtIHVzaW5nIG1heEl0ZW1zOiAyIHRvIG1hdGNoIHRo
ZSBTUEkgQ1MgZXZlbiB0aG91Z2ggaW4gdGhlb3J5IHRoZXNlIHR3bw0KPiAgIG51bWJlcnMgYXJl
IG5vdCBjb3JyZWxhdGVkIChzdGFja2VkLW1lbW9yaWVzIG1pZ2h0IHZlcnkgd2VsbCBiZQ0KPiAg
IHVzZWQgYnkgb3RoZXIgbm9uIFNQSSBtZW1vcmllcyBhcyB3ZWxsKS4NCj4gDQo+IEJUVyBpZiB5
b3UncmUgZmluZSB3aXRoIHRoZSBwcm9wb3NhbCB5b3VyIEFjayBpcyB3ZWxjb21lIDspDQo+IA0K
PiBUaGFua3MsDQo+IE1pcXXDqGwNCj4gDQoNCg==
