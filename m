Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7C47CE05
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 09:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbhLVIWS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 03:22:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61883 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbhLVIWR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 03:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640161337; x=1671697337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0pF4+H0Y+ofBpBz6VpXJH0k/8OWyI0OavuXHtiElDKw=;
  b=d+n1MSEwBgfHpJlXDohEM/9W3ED2Ukddn66fUBLKacHIZ+M3DQqVs98B
   KMc0JbthcmllRqtNZc0IeP95A7Uc9y3S7EumbFZ0B7fAFI8YT88NfN+1i
   WcNtEM3rBwTNjaaNeGaK6bywQ3CUp3xJ2bkt3HN0j8hxmjc1gLvZzPxYZ
   QhyJ0i+wFbtBMsdd67ZLX+0dT8MAPD9NaHGqtjEhWRlvbBfp5gDMBfPhW
   V5H4KWUsrIw+BYOlXynfZ2fDvEs6LgMaDh/5z1juGRhoLVsouiQJ6bErZ
   VsuK4BQC6MI1SvqmpOf3qpNBPzevA8SYYJObXcEXMUdK+67QXFCw4pD7w
   Q==;
IronPort-SDR: u537vbmhQWdeoEj4rFod337eMfD9qxzOOYns2PJxs6m6N8we4OGNQlNAfNMZZQEGqbzFtU5OVo
 WyTM16pfFgJN7asW6d4XHfwRGoyLD5vsfrtOXXE4gs6kqNJ++sCJIKaEnPypslcIHMDolHY8wv
 gmrD0FAqdJ12ADaq8NT563TmkT7fvTF1TneTbrpEwUsPvH80aH881982u0EkFfHcR7KlSD5Syb
 nFN+Hq6/+dSHxCACUC0K5SO5gZs0YzGvURtl7h7nFtBkgCvXexM7+TVJBBI3K7KusnvnopmH/B
 7eJF3NXhfmJWFx/+W3/EZYxe
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="140572682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Dec 2021 01:22:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Dec 2021 01:22:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 22 Dec 2021 01:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8tbXYxDf538pxuLPj21s0SzrfeFF4kY8txjO/vj5w/bnaoGnazYWltbB5u4jjVu+/vcc2Gla4nMOfGhZzDKBfrte8zV94K/Q33mOwHtIrnv7H25SV++5CEVDE73Z0sLWILXnDLO1afnLmieedKWUASF3F19BU6SMgtkWC+QYdhFJ60/IIa+XWwCYHDhFsDMRS0/9AOhVn34UX6+bmZDPQNkpwHiv3Z7IVpFSmlUyeuVsNUOCrWXpDZuaVzJr5Xp7qNC8CHkF0IpKfmdmlZGHdmeHJ3utpQhuvhFvkNZ4+W38L8ooJzSuBIJpBzxVYgjtoVSXX8RTpWAf7OGAD+49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pF4+H0Y+ofBpBz6VpXJH0k/8OWyI0OavuXHtiElDKw=;
 b=QorEliHSu/NEqFhu2YHUs2t9P+zfacgeZS9uk9/EvZzEmmcAqnVDSEINwIYPZBXjFHBSLdZrmM+ZKoPrsloTM5ksUpzao2eFvf7XrWfo14J6IrUv5ZWxMrL+UtFX4aTZc9Myin3CN1vn1t1O93ib81g/gQamYsVzPLPVhvUVGhOj8B3ojB5pO3Kxnqz70miwEmrHlCtR+QL6pbo4x/zPam8K2vaEOPsUmwur97j81Ae7xVU/veLV7XvAoUDMT2NC6QRKKAxZJ+N+mLtMcZbFYV/X5gPQdABwa2qD37ezEdqD47kfRXBV0ytiPoZ4XZmu9jAzNEiswDgbtVstG0h0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pF4+H0Y+ofBpBz6VpXJH0k/8OWyI0OavuXHtiElDKw=;
 b=SZkYdMR8wvUpvXhgQyEob4piIel0QLuUey9/MWMTvoiZt3pvlbQf+epqgAx8K2393/fH5TXMzcc3+pbWdO1ZXzL0dseTU5TjrwKjvE0bBe3fU2h4jkAg1q0Mh67A4AxWbefQ+HSXK2Lc6rVxbSQsiffTtQKFY7yyxW5N9lMryrA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2941.namprd11.prod.outlook.com (2603:10b6:805:dc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 08:22:05 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 08:22:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <robh+dt@kernel.org>
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
Date:   Wed, 22 Dec 2021 08:22:05 +0000
Message-ID: <be9d451a-6451-be58-1c2a-a9aea7f67c56@microchip.com>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
 <20211221170058.18333-3-miquel.raynal@bootlin.com>
 <a11a0650-4624-0a9f-d0a5-c45393fead7c@microchip.com>
 <20211222090542.43dfe12e@xps13>
In-Reply-To: <20211222090542.43dfe12e@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 161876ae-f573-4c1f-a346-08d9c52423b0
x-ms-traffictypediagnostic: SN6PR11MB2941:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2941ECD1EF79D59474E61895F07D9@SN6PR11MB2941.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwJBbRIs+CASI1aC/S+0phtb5qCEQlC1ijlalz+kJ3gJvxkvShv7QEBhzVjp1yaXyc5ZP1yJXzGseyeZHTHC3BLFZagcUTJKhi9L+FfWSlIEQZhFoN9K4NmgXtmVFPYYQdHtMTdSfM20mdscQG71r/rvAYbdrfoUnUkaZnDIQMIKWqZiNKEKHZN+7CnnaPdWoxIobn67tp58xrLLlIvK7OxI+KrLal39WggjBQIzMYBPKvgvzfobQq7jtL91+Nmy8DXgTL8ybr692bwbSiTX4HMbRx+EBQZswWq2WrA73+uIeQVNPuVEXtB9t+ufoQ7EQ13RpqLoj1QIDBKw9MJigZuyQZnvFgckKJOILG9/EK0xPF/WsjXuXxekH3lRp0ugtxYnjrMyLMyvbvP+uV64CzO73v0J9Mr3rcq+ZGi1NzNCQ+P8hm+TxBsL1NA91fQuD/5NHdWS+Bk/9y7qtkFeN6hEVrS7QFJqYjJIQzxJQ7gWTZlz23O/tNovMjMWZ94r2VLe0GssxCiKngqre+IgwgBp7qHSRpInu2irbwB4TvlUsQ2cv3KtqYjfXBnTPB3Xqrb7G8fpGjEuSvzNcokNSUb2bJTNz7mSWAjCeXj5UowFgyXhU+sv2U7P4NuZpc9JuM6x0HNHZ1hKq0oJ3Gy+1j1lNlLEsFwEdkA71LSlW+iQ8pZeLc3mpwVnB2KnkJ/cp0T91ZW/oJaNYBwi7yGWtATVIRjmQKvPqoM1hz3Y7OfuoY/L8FVbGkex7VK3kG6/8EGNLxCl7Q8OGTSG+lTpjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(31686004)(110136005)(6512007)(36756003)(76116006)(91956017)(66476007)(6506007)(31696002)(26005)(38070700005)(86362001)(6486002)(5660300002)(66446008)(66556008)(2906002)(64756008)(54906003)(66946007)(83380400001)(508600001)(53546011)(316002)(8936002)(71200400001)(38100700002)(8676002)(186003)(4326008)(2616005)(122000001)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm1NeGNWRjIwOSt1N0tGOGhyNTViMHU5TVVuc1c3Z2J6UVN4ZmNOKzBTQUhi?=
 =?utf-8?B?b0hCQVo2WTNHU01jUnhKbDVPTkRSbkRHVHZlZXE1NU9heGtLRHRkckR6TWJR?=
 =?utf-8?B?SmRCK2djNFBmaFZ4QU5leTlNUHpaZnNtaWQxN0RUd1gxVnNlOE5aTmlWOWlD?=
 =?utf-8?B?Skk2dldsYVp4cVBQaUpVckhmK2s3SkpvcFFmUkxhYTgxTkVkZ3pBTkJUZWtO?=
 =?utf-8?B?UlFaSHQrNXhibncxTHRPNVQ3OXFWSWVQRmVEazJlRnBTUXd2RFEvTTlxWEx1?=
 =?utf-8?B?K3pyUmhXcEQySVJpVXc3WndpMXlkL0haRkFLbDFwMnJ1VU5NUk5iRTRhZit5?=
 =?utf-8?B?TFZaUzRzQTZlWGQxWGpOK2NNWlZzRUVxVHBOeUNMemlsZ0FGa0VlVXIxTDFu?=
 =?utf-8?B?TmdCT0dyWFFoWHZBMWtNUmJIL1BLT2w0ZTRBUVNMakZHbUJpN3VmaEp5aTk3?=
 =?utf-8?B?aUQ3YzhOZE1ybWJGRmg1bVVWOThhY1lIT0w4cFdReUJBTGxjZHVNUXlIU0I0?=
 =?utf-8?B?bWo4RDdBY0VIVUFvTkc5SVY2WmphYTZsbEdCZnArV3ZsTDQ5MnQxZnFJRFNU?=
 =?utf-8?B?RlJ6b1I0RGZaMHdWd1lNSDNHUFd5UUt1U1RxWlhER0cyVU93bDVjRzJZM3JH?=
 =?utf-8?B?LzR6dmFZcDVzY0VLemhnbVlLemRSa29hZGFBQkNpc2phSUpuUEpxVnc5N0tZ?=
 =?utf-8?B?OTMzSEtNeko4WXFjelkva2lHQnBPcHo1SmhjWEdhMXA0S2piSCtpaVhBbHQx?=
 =?utf-8?B?S3VwZjNvVnp0UjQ3bE43TlpzbGFwdHZjZnNCRFlSeG5sVTMvZmxRQUhvYVRU?=
 =?utf-8?B?RVNMV3lWZjd5eVNyUHZrd2N6am1JaHFLVjVqTlNhQUZ5WWZGS0JMTmpIeUpP?=
 =?utf-8?B?OGwwc09uSE9DaTh4dUYvdUpERFFYWDVxMnZ0NUl0RkZDektENzh4ZFIrdmdB?=
 =?utf-8?B?YXBrc0NYdGZ2ZklCUnNjbVlodE1pYTVvbDRXdTFyT1h5bEwvWXk4WUZCcEQ2?=
 =?utf-8?B?N3czazJQakhUKzhIYUh0S3U0bXdnTUtJV0dhSE90SFdSVjFuWHdlM3NiZUNa?=
 =?utf-8?B?d3RKNkRGSllpenhWMGwyM0FNZDg4dXo3MFlzMEFaYXY1Nm5Pd0tZR29tNk5I?=
 =?utf-8?B?aVRhelRneHo2Sjd5SkhJZ0NtM1RnOFd1cmNnWVFYVitVVzQ0b3BXNFU2Zlpr?=
 =?utf-8?B?YUptcG5PdW5kNmlBZ1U1RDVZMlJZeXpWZTJvR1hMR1hxU1kwM0lhdEVaYjBS?=
 =?utf-8?B?blJFTnlRWk92SWpoUVVDNDRXZERnOGovVzFZMm85OHVOL0haMG50aGlOQVBJ?=
 =?utf-8?B?ZCtIVjRZMnFZL3ZuTzEwTHVGek93V2dFSVBQc0NiZFBLU2NqMnlGRjh3YTRB?=
 =?utf-8?B?MXcyaE83NWtWVDRDVkdFUVpyQUJQU1RNSUl5enRHOGRVZDEyeVpOUzJIOCs5?=
 =?utf-8?B?WlhlMzlCN3hXUUtRWXUvbm9xUDFpenExQ3k5cTcrTHFEOGZxTHExa2U1YVo2?=
 =?utf-8?B?NDJ3UEgzZEVzM3F1SjhjcjB0NE9BOUhhTk5PaWd6OGdHRTBKS3Eyd3NnamRR?=
 =?utf-8?B?VWhnZm5GK0tuajVTbUE5NmtKUXZXdVc5OFV5TEQrTkNPQlVZWmR1N1FzQ2w3?=
 =?utf-8?B?V1R2Tzk4Nko2Nmw4RmZRdzJGRE5yL0tnRDQ2WFBJTGlrNXV0MEFIUk9QNkIr?=
 =?utf-8?B?L2kwYzVqZkQ5ZVF0RWRVVDN2MEdwTUFOa2cybE5CMDhBb0JJWk5KWUhBaW9L?=
 =?utf-8?B?T2lEZHkweklKa290UHJkeXRRWGQrbnk4R25MbjFoZTFTQWR2L2p4NDE4aUFG?=
 =?utf-8?B?Q29ReVJIeEN2RTJOSk00cW1pK3o3b1dEVzE5VXdrdkpxcTRqY1BNaDNxSE1t?=
 =?utf-8?B?MHpkbUZzaHAzMUJvUWd0cUpIRmgxRnMxMytaeEN6eUFYR29HSkk4anFpL0Zy?=
 =?utf-8?B?VnhTQ3d2NTJOTEFSRWUyY21INEROR1NaZUxDT3dRREVzWWJ4U1Nnd29wTmVv?=
 =?utf-8?B?SEMyd0RsdjJxZE1qZU5qVkx5V3NEWXB4eWpYYmZ3Vk4wbWQ4c0gyTEVUWnpO?=
 =?utf-8?B?STFoT3dJd2IzSmd2STJSRWY4Zld0QmtST2Myc0pRenZMclcyLzRCWE1jN0d4?=
 =?utf-8?B?c2FEa29qeUh1UmVxRG85MkNJNEFxQnYzdDdhbjB1bnlGWjZEWTd1N25Ub2pJ?=
 =?utf-8?B?UU8xclNkM2o3V0tncng3UThhQjdXYXV3NGtQVm1vOUpOWHZROHJTMUY2YjlK?=
 =?utf-8?B?RUQyLzMrWU9lZXU3YTFoQWNWOXJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F710C8556A768F4092703A0F153DB876@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161876ae-f573-4c1f-a346-08d9c52423b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 08:22:05.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99B3dP9nF05cU+I54swePREysQhh3ttURtWTqRwkIBr0FMQiUY8n2UUvY07krwHDeZiz3CRLBKQ6njyVRbLMp/JBtSlBtdgPwZUxBQk2hA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2941
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvMjIvMjEgMTA6MDUgQU0sIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8gVHVkb3IsDQoNCkhpIQ0KDQo+IA0K
PiBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGUgb24gV2VkLCAyMiBEZWMgMjAyMSAw
Nzo1Mjo0NCArMDAwMDoNCj4gDQo+PiBPbiAxMi8yMS8yMSA3OjAwIFBNLCBNaXF1ZWwgUmF5bmFs
IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4g
RGVzY3JpYmUgdHdvIG5ldyBtZW1vcmllcyBtb2RlczoNCj4+PiAtIEEgc3RhY2tlZCBtb2RlIHdo
ZW4gdGhlIGJ1cyBpcyBjb21tb24gYnV0IHRoZSBhZGRyZXNzIHNwYWNlIGV4dGVuZGVkDQo+Pj4g
ICB3aXRoIGFuIGFkZGl0aW5hbHMgd2lyZXMuDQo+Pj4gLSBBIHBhcmFsbGVsIG1vZGUgd2l0aCBw
YXJhbGxlbCBidXNzZXMgYWNjZXNzaW5nIHBhcmFsbGVsIGZsYXNoZXMgd2hlcmUNCj4+PiAgIHRo
ZSBkYXRhIGlzIHNwcmVhZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwg
PG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBIZWxsbyBSb2Is
DQo+Pj4NCj4+PiBJIGtub3cgdGhlIGJlbG93IGRvZXMgbm90IHBhc3MgdGhlIHRlc3RzIChhdCBs
ZWFzdCB0aGUgZXhhbXBsZSBwYXRjaCAzDQo+Pj4gZG9lcyBub3QgcGFzcykgYnV0IEkgYmVsaWV2
ZSB0aGUgaXNzdWUgaXMgcHJvYmFibHkgb24gdGhlIHRvb2xpbmcgc2lkZQ0KPj4+IGJlY2F1c2Ug
dGhlIGV4YWN0IHNhbWUgdGhpbmcgd2l0aCB1aW5nMzItYXJyYXkgaW5zdGVhZCBpcyBhY2NlcHRl
ZC4gVGhlDQo+Pj4gcHJvYmxlbSBjb21lcyBmcm9tIHRoZSBtaW5JdGVtcy9tYXhJdGVtcyBsaW5l
cy4gV2l0aG91dCB0aGVtLCB0aGlzIGlzDQo+Pj4gb2theS4gVGhlIG1heEl0ZW1zIGJ0dyBtYXRj
aGVzIHRoZSAiZ29vZCBlbm91Z2ggdmFsdWUgZm9yIG5vdyIgaWRlYS4NCj4+Pg0KPj4+IFRoZSBl
cnJvcnMgSSBnZXQgYXJlOg0KPj4+DQo+Pj4gJCBtYWtlIGR0X2JpbmRpbmdfY2hlY2sgRFRfU0NI
RU1BX0ZJTEVTPURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRy
b2xsZXIueWFtbA0KPj4+ICAgTElOVCAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MNCj4+PiAgIENIS0RUICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Byb2Nl
c3NlZC1zY2hlbWEtZXhhbXBsZXMuanNvbg0KPj4+ICAgU0NIRU1BICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcHJvY2Vzc2VkLXNjaGVtYS1leGFtcGxlcy5qc29uDQo+Pj4gICBE
VEVYICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRyb2xs
ZXIuZXhhbXBsZS5kdHMNCj4+PiAgIERUQyAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0LnlhbWwNCj4+PiAgIENIRUNLICAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29udHJvbGxlci5leGFt
cGxlLmR0LnlhbWwNCj4+PiAvc3JjL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvc3BpLWNvbnRyb2xsZXIuZXhhbXBsZS5kdC55YW1sOiBzcGlAODAwMTAwMDA6IGZsYXNoQDI6
c3RhY2tlZC1tZW1vcmllczogW1syNjg0MzU0NTYsIDI2ODQzNTQ1Nl1dIGlzIHRvbyBzaG9ydA0K
Pj4+ICAgICAgICAgRnJvbSBzY2hlbWE6IC9zcmMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9zcGktY29udHJvbGxlci55YW1sDQo+Pj4gL3NyYy9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLmV4YW1wbGUuZHQueWFtbDogc3Bp
QDgwMDEwMDAwOiBmbGFzaEAyOnN0YWNrZWQtbWVtb3JpZXM6IFtbMjY4NDM1NDU2LCAyNjg0MzU0
NTZdXSBpcyB0b28gc2hvcnQNCj4+PiAgICAgICAgIEZyb20gc2NoZW1hOiAvc3JjL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbXhzLXNwaS55YW1sDQo+Pj4gL3NyYy9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLmV4YW1wbGUu
ZHQueWFtbDogc3BpQDgwMDEwMDAwOiBVbmV2YWx1YXRlZCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxs
b3dlZCAoJyNhZGRyZXNzLWNlbGxzJywgJyNzaXplLWNlbGxzJywgJ2Rpc3BsYXlAMCcsICdzZW5z
b3JAMScsICdmbGFzaEAyJyB3ZXJlIHVuZXhwZWN0ZWQpDQo+Pj4gICAgICAgICBGcm9tIHNjaGVt
YTogL3NyYy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL214cy1zcGkueWFt
bA0KPj4+IC9zcmMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29u
dHJvbGxlci5leGFtcGxlLmR0LnlhbWw6IGZsYXNoQDI6IHN0YWNrZWQtbWVtb3JpZXM6IFtbMjY4
NDM1NDU2LCAyNjg0MzU0NTZdXSBpcyB0b28gc2hvcnQNCj4+PiAgICAgICAgIEZyb20gc2NoZW1h
OiAvc3JjL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLW5v
ci55YW1sDQo+Pj4NCj4+Pg0KPj4+ICAuLi4vYmluZGluZ3Mvc3BpL3NwaS1wZXJpcGhlcmFsLXBy
b3BzLnlhbWwgICAgfCAyNSArKysrKysrKysrKysrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1s
DQo+Pj4gaW5kZXggNWRkMjA5MjA2ZTg4Li5mZWRiN2FlOThmZjYgMTAwNjQ0DQo+Pj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9w
cy55YW1sDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9z
cGktcGVyaXBoZXJhbC1wcm9wcy55YW1sDQo+Pj4gQEAgLTgyLDYgKzgyLDMxIEBAIHByb3BlcnRp
ZXM6DQo+Pj4gICAgICBkZXNjcmlwdGlvbjoNCj4+PiAgICAgICAgRGVsYXksIGluIG1pY3Jvc2Vj
b25kcywgYWZ0ZXIgYSB3cml0ZSB0cmFuc2Zlci4NCj4+Pg0KPj4+ICsgIHN0YWNrZWQtbWVtb3Jp
ZXM6DQo+Pj4gKyAgICBkZXNjcmlwdGlvbjogU2V2ZXJhbCBTUEkgbWVtb3JpZXMgY2FuIGJlIHdp
cmVkIGluIHN0YWNrZWQgbW9kZS4NCj4+PiArICAgICAgVGhpcyBiYXNpY2FsbHkgbWVhbnMgdGhh
dCBlaXRoZXIgYSBkZXZpY2UgZmVhdHVyZXMgc2V2ZXJhbCBjaGlwDQo+Pj4gKyAgICAgIHNlbGVj
dHMsIG9yIHRoYXQgZGlmZmVyZW50IGRldmljZXMgbXVzdCBiZSBzZWVuIGFzIGEgc2luZ2xlDQo+
Pj4gKyAgICAgIGJpZ2dlciBjaGlwLiBUaGlzIGJhc2ljYWxseSBkb3VibGVzIChvciBtb3JlKSB0
aGUgdG90YWwgYWRkcmVzcw0KPj4+ICsgICAgICBzcGFjZSB3aXRoIG9ubHkgYSBzaW5nbGUgYWRk
aXRpb25hbCB3aXJlLCB3aGlsZSBzdGlsbCBuZWVkaW5nDQo+Pj4gKyAgICAgIHRvIHJlcGVhdCB0
aGUgY29tbWFuZHMgd2hlbiBjcm9zc2luZyBhIGNoaXAgYm91bmRhcnkuIFRoZSBzaXplIG9mDQo+
Pj4gKyAgICAgIGVhY2ggY2hpcCBzaG91bGQgYmUgcHJvdmlkZWQgYXMgbWVtYmVycyBvZiB0aGUg
YXJyYXkuDQo+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91
aW50NjQtYXJyYXkNCj4+PiArICAgIG1pbkl0ZW1zOiAyDQo+Pj4gKyAgICBtYXhJdGVtczogNA0K
Pj4NCj4+IFdoeSBkbyB3ZSBkZWZpbmUgbWF4SXRlbXM/IENhbid0IHdlIHJlbW92ZSB0aGlzIHJl
c3RyaWN0aW9uPw0KPiANCj4gUm9iIHVzdWFsbHkgcHJlZmVycyB0byBib3VuZCBwcm9wZXJ0aWVz
LCB0aGF0J3Mgd2h5IHdlIG9mdGVuIHNlZSAiZ29vZA0KPiBlbm91Z2ggdmFsdWVzIGZvciBub3ci
IGluIHRoZSBiaW5kaW5ncy4gSWYgaXQncyBubyBsb25nZXIgdGhlIGNhc2UgaXQncw0KDQpyaWdo
dCwgSSBzYXcgaXQuDQoNCj4gZmluZSB0byBkcm9wIHRoZSBtYXhJdGVtcyBwcm9wZXJ0eS4NCg0K
VGhlcmUncyBubyBzdWNoIGhhcmR3YXJlIGxpbWl0YXRpb24gYXMgZmFyIGFzIEkga25vdywgdGhh
dCdzIHdoeSBJJ3ZlDQphc2tlZC4gTWF5YmUgUm9iIGNhbiBhZHZpc2UuDQoNCkNoZWVycywNCnRh
DQoNCj4gDQo+Pj4gKw0KPj4+ICsgIHBhcmFsbGVsLW1lbW9yaWVzOg0KPj4+ICsgICAgZGVzY3Jp
cHRpb246IFNldmVyYWwgU1BJIG1lbW9yaWVzIGNhbiBiZSB3aXJlZCBpbiBwYXJhbGxlbCBtb2Rl
Lg0KPj4+ICsgICAgICBUaGUgZGV2aWNlcyBhcmUgcGh5c2ljYWxseSBvbiBhIGRpZmZlcmVudCBi
dXNlcyBidXQgd2lsbCBhbHdheXMNCj4+PiArICAgICAgYWN0IHN5bmNocm9ub3VzbHkgYXMgZWFj
aCBkYXRhIHdvcmQgaXMgc3ByZWFkIGFjcm9zcyB0aGUNCj4+PiArICAgICAgZGlmZmVyZW50IG1l
bW9yaWVzIChlZy4gZXZlbiBiaXRzIGFyZSBzdG9yZWQgaW4gb25lIG1lbW9yeSwgb2RkDQo+Pj4g
KyAgICAgIGJpdHMgaW4gdGhlIG90aGVyKS4gVGhpcyBiYXNpY2FsbHkgZG91YmxlcyB0aGUgYWRk
cmVzcyBzcGFjZSBhbmQNCj4+PiArICAgICAgdGhlIHRocm91Z2hwdXQgd2hpbGUgZ3JlYXRseSBj
b21wbGV4aWZ5aW5nIHRoZSB3aXJpbmcgYmVjYXVzZSBhcw0KPj4+ICsgICAgICBtYW55IGJ1c3Nl
cyBhcyBkZXZpY2VzIG11c3QgYmUgd2lyZWQuIFRoZSBzaXplIG9mIGVhY2ggY2hpcCBzaG91bGQN
Cj4+PiArICAgICAgYmUgcHJvdmlkZWQgYXMgbWVtYmVycyBvZiB0aGUgYXJyYXkuDQo+Pj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50NjQtYXJyYXkNCj4+
PiArICAgIG1pbkl0ZW1zOiAyDQo+Pj4gKyAgICBtYXhJdGVtczogNA0KPj4+ICsNCj4+PiAgIyBU
aGUgY29udHJvbGxlciBzcGVjaWZpYyBwcm9wZXJ0aWVzIGdvIGhlcmUuDQo+Pj4gIGFsbE9mOg0K
Pj4+ICAgIC0gJHJlZjogY2Rucyxxc3BpLW5vci1wZXJpcGhlcmFsLXByb3BzLnlhbWwjDQo+Pj4g
LS0NCj4+PiAyLjI3LjANCj4+Pg0KPj4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCj4g
DQoNCg==
