Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BAE48A85B
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jan 2022 08:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiAKHZa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jan 2022 02:25:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28984 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348508AbiAKHZ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jan 2022 02:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641885929; x=1673421929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MuFzmFr0LPXWJUev3LbBVy2rcKpTd7e0o1odTZHY7po=;
  b=CoE2lHvu6bu4i8Bz1s1bLSf6MSfs4BT0kwRb8pPyJssvbg2lnKm1/E+g
   wJR7OwjHHNv/Y4fzRWUVIQ7YwR67ZEiepkOiuLN7m9sNaiMPLogmyBZo5
   p2NI0o2ZezeXfho7jGitCsZtRHhXTHP+CTirLsqBelXDiT5k5oELaIVz6
   E0r2nDaoW0ZRHZeCLSFLoVktfoqAc4IJyjTyo2dgajwZv8YJhHalhZUpK
   tMgLxjCtbdbgbeATXJPn90e9Vw4tB9o8rJIpkGuQKKBNQs9eYf6o9R9g1
   p1vk8YQd2D0WqlZ2Gz9rCXUJdarj/GVRSg+9MSg58UKnuGQw6uC6Um47r
   g==;
IronPort-SDR: GoFvjcrTBUq9ZctZPHNWBm0HTctS7EXPAOlk8hT5ZBybdz8XEcYmIgwn2g1tWuniNLVv5PVCnw
 2M3EwsqsmZSfTbUEOhaYvkLbEZLC4flGv4fqULsWzz/zV0tpPdNZ8zBCjheoLlrqXNB2Fug4fX
 ghEApN5410/lK6Y5vhTn0vi2RQliQznu6K/Yk+e3zb1lENtFKI8pIdDXRNB29TSCsC4ICg4/p5
 y9YZ5k4rlTNLGs87Qa7Do3PrpwUmnrpjUNKD5ce+mmJZiVTa3rOl6Cgu3YjEZhouaya7I/xdkp
 RZElIm+8FofjOA0+8LDMezH6
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="149793292"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 00:25:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 00:25:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 11 Jan 2022 00:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Crm2cfOpVBAl8eNB4ieWW0k6JYhfphIbTY/zKpdW32+rd+++vQr9zED0sHYMLUJhjc/f/oep/Opc7DNWmEDkeobDoeeRXWXX/yAI1ZDz1HpEAfOhB1DKEB6w7gLdRVKEYlrhc+DIiQ4NYXeK7rIyPLT9zci7Lup4Qz3jwApUeJ4PA1cU4Yzb+DYaTR2enzJAj+PP5maFZKxXbfwBTxfZrh99oT+g63vJjq1KxQktGEWpCDroDHhtx/VDh6k6gLPM82iR3IYvoaS9TWKlrLCCTKoL5oA0Ses1CnlSWWKsqKWhX1GeHKO+jDgU0eTF13NalsJP1/UvetpvminRLiDDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuFzmFr0LPXWJUev3LbBVy2rcKpTd7e0o1odTZHY7po=;
 b=kW43Bp0d08dZeOKdyIFWlIDGqdpNLRE13msxxkb/dNw1jvBkCYfw+cFaoygT8PlDX1iNbVzmLBeFTblkPDFDLSoEphnpGz58O8syHHvx5g4VR5sFMHVkfm3GlISvOiLjSmyBvLarvntSzw+YY6OqNxPbrpKocXISLzE69dSjFpZXh0NbWIxKqDIv9RVPQfGlWLbjlLj6tvuULcqEpFF/OBlqxFHHv8zO8djivZhvOHLI0drl7a0i8zXkGCniuP7IzU1gLSWQ3z4TlL8FXRr38iOX4jXcVkijcv5+q2JBp47DEwkDyN+RRwimTbjKYhsxA7S1IR75Y07HN17rgFzWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuFzmFr0LPXWJUev3LbBVy2rcKpTd7e0o1odTZHY7po=;
 b=hVLPNUtMek06n2NpT7eregLANGCQnlo5KnAhT3ju7tTBq+wYeeSHMg8g8eyNxalbYSjN++VbZui0+VzYkCKu6cHSFsqYawCKChoj2L8jm3AxhBa/4fjPp5+eKfid4HY4OkfpgnamTCarj7/jhM0pbnS5wWzSMh8KgIAv3WcU+TQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:25:26 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:25:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>, <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <boris.brezillon@collabora.com>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <corbet@lwn.net>,
        <mauro.lima@eclypsium.com>, <alexander.sverdlin@nokia.com>,
        <andriy.shevchenko@linux.intel.com>, <hans-gert.dahmen@immu.ne>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI
 MEM
Thread-Topic: [PATCH v5 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to
 SPI MEM
Thread-Index: AQHYBrxmQLRO4jWGjE2fhdFknwxLig==
Date:   Tue, 11 Jan 2022 07:25:25 +0000
Message-ID: <e5e7ba2f-b709-3c9d-6560-579e4fa081de@microchip.com>
References: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
 <Yd0ojpMnSjlguMi1@lahna>
In-Reply-To: <Yd0ojpMnSjlguMi1@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e5869bb-8ff0-4d3a-4b62-08d9d4d38989
x-ms-traffictypediagnostic: SA2PR11MB5179:EE_
x-microsoft-antispam-prvs: <SA2PR11MB517971F82F7E55B1EB83D178F0519@SA2PR11MB5179.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/L2QEaPy/Cjd+5lkTksMtD926cc3gG9nzjQ5B/dXD/giX1ftm0pZydYD97NCcl4igcCaMSMypYZz1e+6D6qX5hQzS0ffv1fHSnm8AFCL8KXTJjnBB0F42Yz4FLLLGhpVZtSsUeca1q2HXK9FMivinq347KpVJXs19wNZaRl5UGnMtxPgV3f8urBs8UiCcvIIFE3QPX/NlofmN9Zlilsl54YypKnumFPzEc6oaL9/K6a4s/dklqDhEkhcg8OXMf1cb4Z1IXvXYA7nP3FC/Mp25inJ6AQmzKtfEr2g4i9OKyU2MGsKr3itjANPppAsstACwYAqaT/lUee/cNm/sc+JeI6T2BhKmn8Ncfu54PRXvQSJvdvmnGKoX4etQZKcw8InQtQUYj1sBAzY8J6QTNNVgLX2/3ltTAanHbKqRGIiwZLO8SXrXxzC8eFVv2L3d679a9BE9dpkntJGLIQAJt0Nf74Dy4mkkUSAXiw/6rqzOUoP+t2n+ksfrHf+HLPzbUz/A1F79cV4NSxwexRGN6qt2iU1ZcU01HEMZXnUmC2aoMGhy8yiXx6ZOuFnE1nXB8Yf49heHPsDaFKoQ3Gw3aEmBKuAzfnq7yfl6YuKlMGpeydyYApfkRnYQnPwrf1QmB4SPU5r19GNYIDGPzogeMBoEmJt8CgSFUtD1RAxDL7fPuoaKvU5s9TbjJOfXkLhNMaDAraCP37mWt0gbAb84FIvHHOOHAL5ePJmiyrrr2vEhNtr/I6U+5hEMAlITwp8QxRRmJZz4owR/LTyYni9uQVAE5VGS0eIpzyRVHBryIm25rBPwGDinCRCURPNiQ+RYl7JOWb80YmCkblK6+J8g9bFFPXtzTuBPdp1DK7dpiGSvc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(91956017)(5660300002)(7416002)(66946007)(76116006)(110136005)(64756008)(66446008)(2906002)(508600001)(31696002)(4326008)(186003)(31686004)(26005)(36756003)(6486002)(86362001)(6512007)(54906003)(38100700002)(53546011)(6506007)(316002)(8936002)(966005)(71200400001)(2616005)(38070700005)(122000001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnZnQmsxYWtSTUZyUHNtdVBHMEtIV0VVRzN6dWI4Y1ppaFBROTFzVkRVMksv?=
 =?utf-8?B?Q2x5bWE0T3JXcG1xSUw4cWRCY29NT29VOUNLT3kzM3A5N3FiOWMvOTJXL1Ev?=
 =?utf-8?B?Q091RDRlOHVFWk5NLzN6ZTBBNm13emJTc2xKais1dm54SmdXeTA5REs1RnNt?=
 =?utf-8?B?TndIcHlxaERtdmVQRDlUYmxnU01Tc1lVQjQrTTgzSDNoOWwyaFU2UXFWZXBw?=
 =?utf-8?B?dFlEd1V3NEp4VzVuZVloak96VmE1Zmx6cnd5N2IrVEZKSUw0eHp4SW51czVJ?=
 =?utf-8?B?RWxSUURDYXFBNHZVam9yS0k2TjNDSzNCUEVhY0UwNmU4aktiQzBWdHQwL0Rt?=
 =?utf-8?B?emhkR1dLbkVYUGRwdHU3TkNpQTdReXFScjU4VktlSnV2SFN0bDZxRkRiazlR?=
 =?utf-8?B?M3dpdE15TjVwcXBSYTZKbWw2Qjd5STBGL2Q2VHJtN2JOc1BWK25JcWJELzRT?=
 =?utf-8?B?N2VRM2s2R3F3NGhFYXdtcmV2a2J4VmZjdndiV2IvQUVnU1NjRWZiTEMvMlFa?=
 =?utf-8?B?cEQ3Sk9VZGlmWEhMeXRLRFBKeFhxMUJRN0lqM1A3dnRvNmErTFMxTkhkWkly?=
 =?utf-8?B?Q3BiWTlIT3JLSDhaTFY1cFg1Q3RzRGhsL1A4WE5pL1NwbW1iSHZIS1YvcWJm?=
 =?utf-8?B?alRhSXV0UnZJelJlMHFiOTZxdndIZUNaOFpqdERrTlh0ZWJORGU0TXdHblpM?=
 =?utf-8?B?bGtVRjhBN0ZqdEhzc0doTm1Nc0QxWEREVk5xbitPazExeFpSSGNnbmxTd3lv?=
 =?utf-8?B?YkFkYlc5SlBIUExpZ2R6OUtzdWRTeWlHWWpSc0NybGZmeGplWHJ0ei9sdFZu?=
 =?utf-8?B?UWNFbDdQd3IreGhmYVhsSVVRSERyemxvRGVXcEpMRDdhRi96ckVkdUUyUzFL?=
 =?utf-8?B?b3Jta05qeUZ4VjVTckJTbG1BajQ1Wkd4eElsUzlTRURrbzV0S3Z0MG9mdWNX?=
 =?utf-8?B?QVZZcFI4dFhHU2Y4TXJkNWkzbk0yMmxOYS9PWlFkWDJYa1NzbThYdFI4RVFz?=
 =?utf-8?B?aGNXRjdLSlpYaEN0YXFZU2dTU0kxcTBiRnNERW9QYTZCaHcxcnRuU1lYWStF?=
 =?utf-8?B?WXpwZkVXZ056V09PY2J5eWxCWkJMaWlzWHp6NWNoaFpSN1gxN2UvMWpIRzh3?=
 =?utf-8?B?MEd2YWJuRDV3VmNMcXBJWS9YQVpISVRTSG5WaDdtb2J6NGtaK2p5MHlieTdT?=
 =?utf-8?B?UUxkaytzMktXa0xnWmdVWW9aeEpUQUY2KzZWTzk4Z2d1VWZWVU8rR2c3UHVj?=
 =?utf-8?B?d2xBN20rQmo0YVBhejF0T015d0JCUHNzbSswSmJNcFpkV1JSaStCR3dqbVFR?=
 =?utf-8?B?M04zc3ZzM1lWZmRqTUVCQWttR2VZbVdvMTZvRXN1cUJDNnFocURvRnFtSDNI?=
 =?utf-8?B?YXV5Y3hJWHFmN2xaMGV5UGo1REVKVEdldTZIdWVTY0pRRmZBNnlZQ0VEUUhK?=
 =?utf-8?B?eDZxVEdRemdtUDJMYzRuRlBaaVp1Uk01SFZVWGYvZUxvcXpMVDhObnhxUGNZ?=
 =?utf-8?B?cVRlTHFvUFdOZ0g5dzdYajVIbUNaS1IzcmtpNmREVzJxeXVRSVBXZ1oxOHI2?=
 =?utf-8?B?aW9Vc1pVTVY3Zmp0M3dIcWhobW5udi9OQmFQNDVQbWs0aElvUkIwRnB0NVhJ?=
 =?utf-8?B?WE1sSzZvZ3ZpNkFzRTVGZjd6VDN1Q25PcUFjcFMwRkV2Nm1maFJkcU13MnIr?=
 =?utf-8?B?NWl2cEN4aGg4UlEreXpGM0dNK0tPeGNma2dkZjVIUTRwWExuaDlxTjk5R1FV?=
 =?utf-8?B?UHd4U1ovTlVCODRFazdkT1B6M0hGZTdpY0RQQms3by9nV0RyK0dzNkJxYWp1?=
 =?utf-8?B?d0lsc1AxY3daOE9HcG1jR3BrVGNjb1JoVHYwdVB4QjZOalRkOG0vMTlqSTVX?=
 =?utf-8?B?bHlWUVliMkRrZjBzS0NMQ0xoaGltc3ZuRE1vM01KcXUyU2F5MW4zd1FhZDQy?=
 =?utf-8?B?ejRKSHlRTnBkZjQ2RERObEJBR21iWnpNM2I0cTRjVmsrd0dkaWNrcHZMYVZ3?=
 =?utf-8?B?a3dMZ0tpeHkzMG8vUExGSmpuOHBMVFdJWnF4eHEzbHZNeFg5eWxEZVcweCtX?=
 =?utf-8?B?NWVXcWU2N2dUT3RBLzRqWkw4ZUdIK3BIWXh2eGlTWUR0SDNXamFrQTRRVnBJ?=
 =?utf-8?B?K3Rka21uT0VxdXFLMU9Qbmh0czZIbVJxSkVRSlJ4ZWtVL25UNXMyR2lUQWZH?=
 =?utf-8?B?ay9WeDNFdXBYTHc3dTZ3b1ExbENraXJIY0lLUlBvOTVldkJrTzVQVFF4WHpw?=
 =?utf-8?B?Y3dvNk9PYm5mME92WUZSMXZwVFhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2506AF601868934ABCD16D7AED5CC988@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5869bb-8ff0-4d3a-4b62-08d9d4d38989
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 07:25:25.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N8TiGvlBnhd+lOD90If8xdOcsm41NVU1VwxOsNFUBwstfpamuAp5aWkP/0fuVVw2uhJqPaPWnQHnZYlXKTdiLeDSSxNPjDxhZwY2qC+tUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMS8xMS8yMiA4OjQ5IEFNLCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgVHVkb3IgYW5kIE1hcmssDQoNCkhpIQ0K
DQo+IA0KPiBPbiBNb24sIERlYyAyMCwgMjAyMSBhdCAwNzo0NjoyMlBNICswMzAwLCBNaWthIFdl
c3RlcmJlcmcgd3JvdGU6DQo+PiBIaSBhbGwsDQo+Pg0KPj4gQmFzZWQgb24gZGlzY3Vzc2lvbiBv
biB0aGUgcGF0Y2ggSSBzZW50IHNvbWUgdGltZSBhZ28gaGVyZToNCj4+DQo+PiAgIGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tdGQvMjAyMS1KdW5lLzA4Njg2Ny5o
dG1sDQo+Pg0KPj4gaXQgdHVybnMgb3V0IHRoYXQgdGhlIHByZWZlcnJlZCB3YXkgdG8gZGVhbCB3
aXRoIHRoZSBTUEkgZmxhc2ggY29udHJvbGxlcg0KPj4gZHJpdmVycyBpcyB0aHJvdWdoIFNQSSBN
RU0gd2hpY2ggaXMgcGFydCBvZiBMaW51eCBTUEkgc3Vic3lzdGVtLg0KPj4NCj4+IFRoaXMgc2Vy
aWVzIGRvZXMgdGhhdCBmb3IgdGhlIGludGVsLXNwaSBkcml2ZXIuIFRoaXMgYWxzbyByZW5hbWVz
IHRoZQ0KPj4gZHJpdmVyIHRvIGZvbGxvdyB0aGUgY29udmVudGlvbiB1c2VkIGluIHRoZSBTUEkg
c3Vic3lzdGVtLiBUaGUgZmlyc3QgcGF0Y2gNCj4+IGltcHJvdmVzIHRoZSB3cml0ZSBwcm90ZWN0
aW9uIGhhbmRsaW5nIHRvIGJlIHNsaWdodGx5IG1vcmUgc2FmZXIuIFRoZQ0KPj4gZm9sbG93aW5n
IHR3byBwYXRjaGVzIGRvIHRoZSBjb252ZXJzaW9uIGl0c2VsZi4gTm90ZSB0aGUgSW50ZWwgU1BJ
IGZsYXNoDQo+PiBjb250cm9sbGVyIG9ubHkgYWxsb3dzIGNvbW1hbmRzIHN1Y2ggYXMgcmVhZCwg
d3JpdGUgYW5kIHNvIG9uIGFuZCBpdA0KPj4gaW50ZXJuYWxseSB1c2VzIHdoYXRldmVyIGFkZHJl
c3NpbmcgZXRjLiBpdCBmaWd1cmVkIGZyb20gdGhlIFNGRFAgb24gdGhlDQo+PiBmbGFzaCBkZXZp
Y2UuDQo+IA0KPiBBbnkgY2hhbmNlIHRvIGdldCB0aGlzIG9uZSBtZXJnZWQ/DQo+IA0KDQpTdXJl
LCBpdCdzIGEgY2FuZGlkYXRlIGZvciA1LjE4LiBJIGRvbid0IGhhdmUgYW55dGhpbmcgYWdhaW5z
dCB0aGUgbW92ZSB0bw0KU1BJLCBidXQgSSBkaWRuJ3QgZ2V0IHRoZSBjaGFuY2UgdG8gZ28gdGhy
b3VnaCB5b3VyIHNlcmllcy4gV2lsbCB0cnkgdG8gZG8NCml0Lg0KDQpDaGVlcnMsDQp0YQ0K
