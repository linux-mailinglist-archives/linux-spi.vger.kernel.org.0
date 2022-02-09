Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D264AF3A9
	for <lists+linux-spi@lfdr.de>; Wed,  9 Feb 2022 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiBIOHX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Feb 2022 09:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiBIOHW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 09:07:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798BC061355
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 06:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644415641; x=1675951641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XIWasSMztU9X/TT1OwiN8V3RD8I+k5fZekxyc//7VA8=;
  b=DCuCfQLZqH5TSGJpAxVHLz3x8uOxvQKR6Uc/GO0m+ouWJ6PovfsaiAam
   XxGvfldpGmqrmTUzum/kQV6NYV8lR9SHwdDAqu6olIShzqjba6F58bj+m
   WX8PrfmbuiaKdFWUW1E3zP8tOaC0d68aOXBdQRowd4xgD/lce216DYWDx
   NQSykLaNGYy220jyXrpqZ2C2zf3we4glrpyIaH+Knwvm/1FRPCl04Y3+i
   BDUe/icWy3ZI1X/6+r5RrWYDRmo62RHB2ZgTQcFZmi2BN8cNRIaOLu9nR
   umno5y8gvRKEjSvm75CiinmS1aVD3/ENjF+ze++qTuFAhByWXMuf5+zhe
   w==;
IronPort-SDR: ey+q4Pn2/fCUv9G40A4Ilxnd9UjmL6lc+ho48DAAVgCVUR7jeVvlX/NqpGWY2e6UN9MFNaeAsW
 XzKBOOxsb3pazK0HdXzP0C8BV1Rkihaf9WZRB5Fm64U8UsIbFtoelJLwG8jM4+yOx7zIv5bBW9
 ZqqZ2RaviRYdSFZUo17rbQJlBeye2J+wwSb1BDX3o8oAFZBericYMzfmZSZJoEHO70AU4uxy3b
 yQOcqPvm590SyMWr9goK6ioQSX9/1Q3AkRZkSRNV+nXkN6vILdcWFS66KPcqnVKmdgzdYNQ+f1
 wF1IrwvF6OBvgD0hCbN0oS+3
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152989622"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 07:07:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 07:07:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 07:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCwjWL1rtII2NkogTk+qtTxOeWye2NYRuQGDLX1sE67RWupX3V7hBhgqVqDkFjtTsO2zS1wuRNCL1ztA04XZ15T09WGUPTVyjBz63DHoJstccZ2y8vCKIqCMr0hMfB6+2KYfTRpck1Z5EXJ5IGhO0h/xS1HJ5YArrhRFC6rBBgY7MMgePFDd2EdBFiAvgN6LKrv7hpQc3FNjS/xdG1/Ua4x2FrkUblT69vhzv3icXV4s+jRt0hBhLaBXS1EX4DIxdkkEWH4Vx6/4GbUy0p62gU/ECVjKwlsSczr+ttAfk4OM+pMus+6PrJoINP0psh6/orKD1YUAKpveKSHw2q+HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIWasSMztU9X/TT1OwiN8V3RD8I+k5fZekxyc//7VA8=;
 b=cSbDFh2JrLJUbWQ4IhjckM1e+u0JaQv4VpyX1Y8FdICk0TzuGRkPV7W+kvcZCogVG4JdzrW1HMQ2xp0fq2du0UdYWXiNJ2lqPEVd05s7H0YjPuhRvAGKVdllFdtOvwxycbEQCMohGp1YKF/D9QONhZ/xZW5TEt1u8DBdzoNdfe2nUwwS1rvlySapzLJnsMK5gdPVNZOjQz5Rv+0+hGN3OLsayMr7Elr9nFSnQdExhfZpScTwI6A00sV7SPkjYkpXBowGt0feRkmMqkW93kzhP9jv2OG+CRk6NTYTFkI8D58oNs+r2iX99AeXbDJAps9L1lj/LToQ89WqF3kU8AvPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIWasSMztU9X/TT1OwiN8V3RD8I+k5fZekxyc//7VA8=;
 b=CWp7wH/46XognzmUZ3ZDaeICffXZnXeddwcTlhL/zrcUDhXVBEaGmV0/ZmnVk+DgPL1gxpvOcKJyFNMCxLYeB0w0yM30jjbBAlPREKEFyQCPrmL5H4oyqmiADwX5imfa/j+DqYSEsLJk6reY0rNn6YYl0ITawQADXc8pdY183Do=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2543.namprd11.prod.outlook.com (2603:10b6:805:56::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 14:07:15 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 14:07:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>, <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <boris.brezillon@collabora.com>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <corbet@lwn.net>,
        <mauro.lima@eclypsium.com>, <alexander.sverdlin@nokia.com>,
        <andriy.shevchenko@linux.intel.com>, <hans-gert.dahmen@immu.ne>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Thread-Topic: [PATCH v6 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Thread-Index: AQHYHb5XDLb+072+S0GtA8kXrwPNAg==
Date:   Wed, 9 Feb 2022 14:07:14 +0000
Message-ID: <b9b4135e-61a1-b227-57bc-29a5c3ead80e@microchip.com>
References: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
 <20220209122706.42439-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20220209122706.42439-3-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3512769-6a7e-4d8c-bc08-08d9ebd57994
x-ms-traffictypediagnostic: SN6PR11MB2543:EE_
x-microsoft-antispam-prvs: <SN6PR11MB25438C435ED92888495B4677F02E9@SN6PR11MB2543.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYkjwVVW586EGt6bKITTMdHzeddftH3n+/cKHWxxaF43KwCLLgJRdXePldTESVWT1UhMcVjyeWVTxCo2u2cPR8c+uWdQKdxlFxvUZeUTKuWjLk03jURegJx8X5eqwl0SCJO+yrxS2ni5QFLEn4WpHCNoKzgpV3imHh9Qtv2d/Kmngdyj9I2scemPvU599Aou++gJvwIC1oi8OYdPemI+V5uW6a6bYUzFIIYHuIbzioFphvgJc2Za/1sOG0emKWbm5eBiKR1v/b4It9H5Ypqo7Ev3zsohs+S/hUQQyP6qbPAyw5u7Um/n1obDS80JH2e2AY0WA3IH30O5WI2WcUWdG/kCd4AsKht9221jUWaF0gS19WTz+ciOLkyXN6zveRN23iW3qy2ePQ2AlsWK7NEg/fhhfHcHmpmfIFwqE8BbGtHPVonHh959PmtFEHZ8Zvc6cYmye5/VBjUOTKc7jG83U+wXItV3ApTwgnB8j6hEwtIcs6OwJPbSM748ny9GCQr2mHCxZDSIHBpG0JKPC6/pRlumkZMQdPC1jN9CGBP/8ITIDXXDkCHh97geZWf4d0V/y5AqMQsC4ViUZajS2EdGwINvFRN0YBLG47Wm6BSOSe+IpSXsNYFi1oI5AY4gCS6wq6jXDLP9n0cktd6RYsVyeq8LbUtywjK+Xm5eelDGIrpZ71Tdfk1DwjPPtteasHPbNjz9RkKbvqPKXU+RDmzA7/TKnFEFQxdzR2CTirCNtGvXvNP8eUjzCRbWcXFKTLKULo3oCPTB3Jo8I4reqptL6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(76116006)(66556008)(6486002)(8936002)(71200400001)(91956017)(508600001)(66446008)(66476007)(31686004)(110136005)(316002)(54906003)(53546011)(4326008)(8676002)(64756008)(2616005)(66946007)(6506007)(7416002)(36756003)(5660300002)(2906002)(38100700002)(38070700005)(186003)(122000001)(26005)(31696002)(6512007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1ZQ0tyNnpvdHVZWkFyVTVMUC85MnF1d3BUQjU2SHBqQUNYNFVlb0dnT1VF?=
 =?utf-8?B?NkJaREJKU1E1OHVMNU1DYm9hUS95M3gxMFlGdnkzR3Z3OFE1UUlJVUc0Rzdv?=
 =?utf-8?B?YjlWd0xaTWFUTVlwN0pmYkozYzlsVW9JVm1sTmFOYUthb1V3VGp4bVlUTHFa?=
 =?utf-8?B?VERkZEFkWEU0SXI4SUxnZi9Ud0lyVGlEVmFqK3dhcDdNSk1oOXFvV2VOSTZ1?=
 =?utf-8?B?b28ybXUvckFTTFJPT0VFMzRDdmxOSEhVSWxjODJBNk5Ub29jV0tiUzR3ekRI?=
 =?utf-8?B?QVNteFVqbGU0MjdiV3dpRnBneG9nSEFqazVCYmxxYVpGWnlOVjVKZldJNTNa?=
 =?utf-8?B?N1g4c21YY2tVU21SaUVHazRhSUFHRHNPWXBJd3EvMlFFdTgyYUk4RGZzb2dV?=
 =?utf-8?B?dVVRdWw5UTdLK2xiOUtTRFlabjJvWndiZDRmNCs4T1laQXVsZldaUVZ0SWl4?=
 =?utf-8?B?eGY3ODJPZGgrenp2TmtzRGtYRGlVb3BETmlvalU2dzdKQmJCWVlDMzQzZE80?=
 =?utf-8?B?WDlYREw2VjQ5MGhKTmhvYlg1di9XdVBjRDlqL2ozTGlIcnI0d2gzSlRpeWR2?=
 =?utf-8?B?Y3RwVlR1Myt1TG5iOWkwcllRMzVrVlVBK3Bra2J5clVxTFRiTnBJNzQ3VlJB?=
 =?utf-8?B?TEw5WWZmWEFXMHBzNXQzNHRQN29NczJITFczM0lpc2VyVGI4QmxCSldSZ29a?=
 =?utf-8?B?Ym5ITGxjbzh0S1pVcGVQZHplWE1OWWxiTDFlRFJXeTdMcTUzQnpkTGhtaUFr?=
 =?utf-8?B?QnlSZHVucVU1aTlMRFAvaFRYbUVVOUhuYzRXakQ4RnFXdzZzM2pTdUx4QS81?=
 =?utf-8?B?VXpzajlGZWhjc3dVVUo1a0hRaTBXaWJxQ3dpdUk0UkU4dzRpeWRXd2tpZUdr?=
 =?utf-8?B?VDJFdkN2cE9EVVRhT2kzZFVlU0lvV0N2dTNha1hXMGMxdnRMMUZ2clVUMHk1?=
 =?utf-8?B?NUJrMHl6TmVEcWdqYm5ncFI3SGR1ZmNjVStyRFZJdHpLNnRyTVJ2NHBWS3lq?=
 =?utf-8?B?TC9weVlIN054dnU5dDJaQVgxb2dYVXBHZzJJU3l1SE9oNUxVaDJoSUp4TWdq?=
 =?utf-8?B?U1kwQTRua0dYRjNYazlVU3QydVl5MlFBS1NkNE1VdTlvYUt5T08xTS9xeTRS?=
 =?utf-8?B?MjlrRUg5M1ArK1NsT25EbVhVWkIwTHZKUlFoWWpDdUMwNnhyMjNNallJQ2dH?=
 =?utf-8?B?UHdFN1dWQjRuS1hrRkRIN1NrY200VGpiUU9jQm1pek8wN2RPYkFHYUVJTnhK?=
 =?utf-8?B?NUlQRTB1c0c1RGs1UFZiTjhxa2NPMzg0YmdnOTkzTnRrYW1uTDNqcXhLT0kw?=
 =?utf-8?B?Sit1cXVRQkU1RVZUNlE3eFlYY2dwdjlGRnlFazdvdU9CdUdRcTNBV2pOUTBV?=
 =?utf-8?B?YjhuaitRRmpZWjhRcE1nSUtrSlc5UWpJTDFQS0NjczJyWGY2c21jS25QdFhC?=
 =?utf-8?B?Y3V4ZmE1b0NWQlFWK2V5dGsvRnNQZGcvb1pKRzZXVGFzOGJTSTMxSFc5YlZG?=
 =?utf-8?B?MDdvNEFocjFQeDI3andURVBXa1ViS2lRMnJkWlJNdHBWMnN1QWc5MlN3ZFpa?=
 =?utf-8?B?Yk5hUUs3bzhHaHg5Z0l2VVhKaDl4RTNNUmFGL1puQlBTbGg4d3dGUDM0aFBE?=
 =?utf-8?B?UE1WYlRKRUMyUk43ZTdwYmhTYU1BTTlKa1JlUHkrWVZQRFQ0LzY2RWxTOU94?=
 =?utf-8?B?aElqak5GZEppSG1DcmZITDlJcUhwaktFSDFJUHhNVnYvZ2NqRU9FQ0FUN0tT?=
 =?utf-8?B?cisrL0s3QWVTRlV3QkRIQXhwZEpEVmR5bTBMOXlTSUxVODV6cHhkVTQrSjVG?=
 =?utf-8?B?WmdtdlJicHB5cEtQSnZFMysvVlJXN1I3Y3phVDFLVll2bDdzck12ZXE5azRi?=
 =?utf-8?B?cDBzMVVRY01XZDJkWEp4eWh1OHdlOW9nT3l2U2NLTjdQanU3c1U5emRyTjZX?=
 =?utf-8?B?NUoxSkQ0MFBDMWl6NVlrcXI4djFvVzBpZHBlY1hReVFCRmgxRENhWTNDcUpJ?=
 =?utf-8?B?ZDNKZ2VxeElOVEJQTThUNjROcGt5eXZWMzBVOFRhWDU1YVR5ZG5qOHRIOGdx?=
 =?utf-8?B?Ti8vMlBTS0xjT3g2QmJrYTNTazN0Z2F5Q0JmU3FhVDh2QVVUYUp0dTYvVVgx?=
 =?utf-8?B?b3l6c1FVR1g0eXA3bkRNMHJsMFlmNzdTVWZ6REQ1SENSb25jay9EMEhyMGxD?=
 =?utf-8?B?L0Jlak5XWTJIaFRNWG9TcUxiZkJaajZGam9CODNldTV0WWhYZjdhOG5lZDZy?=
 =?utf-8?B?enVwaWQyWklISmxDUFlQVGtJWGt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE1D736E22150C499E57F2F1660D8088@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3512769-6a7e-4d8c-bc08-08d9ebd57994
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 14:07:14.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJKgcsXUMuNL0McaWa6MraqW/d0flG0Dk7YYintvWXW1gVNpwqLNkb/jTuR6PZwjORFcUMvMdsPzUKAK/jTjAiHTp4V6fPKLcZJnqg27+ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2543
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMi85LzIyIDE0OjI3LCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIHByZWZlcnJlZCB3YXkgdG8gaW1wbGVtZW50
IFNQSS1OT1IgY29udHJvbGxlciBkcml2ZXJzIGlzIHRocm91Z2ggU1BJDQo+IHN1YnN1YnN5c3Rl
bSB1dGlsaXppbmcgdGhlIFNQSSBNRU0gY29yZSBmdW5jdGlvbnMuIFRoaXMgY29udmVydHMgdGhl
DQo+IEludGVsIFNQSSBmbGFzaCBjb250cm9sbGVyIGRyaXZlciBvdmVyIHRoZSBTUEkgTUVNIGJ5
IG1vdmluZyB0aGUgZHJpdmVyDQo+IGZyb20gU1BJLU5PUiBzdWJzeXN0ZW0gdG8gU1BJIHN1YnN5
c3RlbSBhbmQgaW4gb25lIGdvIG1ha2UgaXQgdXNlIHRoZQ0KPiBTUEkgTUVNIGZ1bmN0aW9ucy4g
VGhlIGRyaXZlciBuYW1lIHdpbGwgYmUgY2hhbmdlZCBmcm9tIGludGVsLXNwaSB0bw0KPiBzcGkt
aW50ZWwgdG8gbWF0Y2ggdGhlIGNvbnZlbnRpb24gdXNlZCBpbiB0aGUgU1BJIHN1YnN5c3RlbS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxp
bnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogTWF1cm8gTGltYSA8bWF1
cm8ubGltYUBlY2x5cHNpdW0uY29tPg0KPiBSZXZpZXdlZC1ieTogQm9yaXMgQnJlemlsbG9uIDxi
b3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4gQWNrZWQtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+DQo+IEFja2VkLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0
aS5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3Jv
Y2hpcC5jb20+DQoNClRoYW5rcywgTWlrYSENCnRhDQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3Bp
LW5vci9jb250cm9sbGVycy9LY29uZmlnICAgICAgIHwgIDM2IC0NCj4gIGRyaXZlcnMvbXRkL3Nw
aS1ub3IvY29udHJvbGxlcnMvTWFrZWZpbGUgICAgICB8ICAgMyAtDQo+ICBkcml2ZXJzL210ZC9z
cGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5oICAgfCAgMjEgLQ0KPiAgZHJpdmVycy9zcGkv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM5ICsNCj4gIGRyaXZlcnMvc3Bp
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAuLi4vaW50ZWwt
c3BpLXBjaS5jID0+IHNwaS9zcGktaW50ZWwtcGNpLmN9ICAgfCAgMjAgKy0NCj4gIC4uLi9zcGkt
aW50ZWwtcGxhdGZvcm0uY30gICAgICAgICAgICAgICAgICAgICB8ICAyMSArLQ0KPiAgLi4uL2lu
dGVsLXNwaS5jID0+IHNwaS9zcGktaW50ZWwuY30gICAgICAgICAgIHwgODI5ICsrKysrKysrKysr
Ky0tLS0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLWludGVsLmggICAgICAgICAgICAgICAgICAgICAg
IHwgIDE5ICsNCj4gIGluY2x1ZGUvbGludXgvbWZkL2xwY19pY2guaCAgICAgICAgICAgICAgICAg
ICB8ICAgMiArLQ0KPiAgLi4uL3g4Ni97aW50ZWwtc3BpLmggPT4gc3BpLWludGVsLmh9ICAgICAg
ICAgIHwgICA2ICstDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCA2MjggaW5zZXJ0aW9ucygrKSwgMzcx
IGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29udHJvbGxlcnMvaW50ZWwtc3BpLmgNCj4gIHJlbmFtZSBkcml2ZXJzL3ttdGQvc3BpLW5vci9j
b250cm9sbGVycy9pbnRlbC1zcGktcGNpLmMgPT4gc3BpL3NwaS1pbnRlbC1wY2kuY30gKDg2JSkN
Cj4gIHJlbmFtZSBkcml2ZXJzL3ttdGQvc3BpLW5vci9jb250cm9sbGVycy9pbnRlbC1zcGktcGxh
dGZvcm0uYyA9PiBzcGkvc3BpLWludGVsLXBsYXRmb3JtLmN9ICg2NSUpDQo+ICByZW5hbWUgZHJp
dmVycy97bXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMgPT4gc3BpL3NwaS1pbnRl
bC5jfSAoNTclKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3BpL3NwaS1pbnRlbC5o
DQo+ICByZW5hbWUgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3g4Ni97aW50ZWwtc3BpLmgg
PT4gc3BpLWludGVsLmh9ICg4OSUpDQo+IA0K
