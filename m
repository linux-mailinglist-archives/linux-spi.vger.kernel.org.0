Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16765B5D91
	for <lists+linux-spi@lfdr.de>; Mon, 12 Sep 2022 17:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiILPpE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Sep 2022 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiILPpC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Sep 2022 11:45:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2820F61
        for <linux-spi@vger.kernel.org>; Mon, 12 Sep 2022 08:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTsd3y5oy678jYEXsDQSmkgVMef3G9jXFhwOH6mDpbgllY7LZCPyT7qSPfhfyUtw5U5YgYluyLERTlALbRe2rQumvzH8A/nyC2kTiDaRlO5W/XWJKmpe0Rb8fXLZQbUQiXt6HS3QE8o0G93EUiMuo047vMCymD3Pjvp+9Eat/srIS04LvfPC7JfenYJAVETrLEDgBUGdoC++SdqxntWntYaa3oB3E/rDoslhfwwE9qTRnZCRT0/hNlsj5nzazqNg8T+71OA+ZnB0fLF7wZqS7bhGAztKBQVoyzBtSBER7Jkd2sG8pQbkIAQJmcbMi9vXgqTZfZa+6kAj9K3c+LPy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okXVi/kW0JC+NrsJxmp+DM9W+C6+PsPGuNFL7yK4mxQ=;
 b=RY8f3KKYhAgT6ubvcjhYnBsvTFaRTBKLtI/RhLBNj9ISEYrmFHKysGMYW9pra3Mr+a1ggXowYmYsP9N4OEOuCaDNbkfCvnseGOw2kiXLdnONg5o7/CiSHel0XQ61MAmiWxTRuHxnbsadAa57RzfLa7vPDNSpcjW7ei0ZLotjxWr1jdwkrQ/cIC2360u6BEgVQZGqtl5hFiFrmprm5sHLxzyCJQv1jutHppxg9WEbNxVzNmbdqCjn1O4CN9bb4JutAiOClJby83bdgnrs8z9hLHKipodUWFoji7pfKD+9VYtnAZ97XV3LeA4QZe85vcLyG3P7QDnGcw3olC/RhRamfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okXVi/kW0JC+NrsJxmp+DM9W+C6+PsPGuNFL7yK4mxQ=;
 b=T9mVPeJ+YjmfJ6uz69h4HwG++9qUWf9x90sL3A5xULsfQaxVx9oRHOJ/mcM+r88ussNMoYEFqHZFh4Qwy5ND6Y15G6Mro1DR3OKUEkeZ4Cn476yoiobZRE9HBsaP8wex7ScL8skHncH5SrLHcBB9w3EFCw87BSfqWXvXHKExCl8=
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 15:44:58 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f946:8762:96dc:6eb]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f946:8762:96dc:6eb%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:44:58 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Designware dw/dwc driver and qSPI?
Thread-Topic: Designware dw/dwc driver and qSPI?
Thread-Index: AQHYxr6cKC2VBKGqe0OOVkzdcNVoIw==
Date:   Mon, 12 Sep 2022 15:44:58 +0000
Message-ID: <10ff3268ca3e734b215d6a2b0bd5e1de38d0917d.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|BY5PR10MB4179:EE_
x-ms-office365-filtering-correlation-id: 721a4b92-f31e-424f-5834-08da94d5bf5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BebNtv+0GgazXJHu+u0GjuAD691MEE0Zky6pAIbiqZkIRbZHDY8XthZ9mQW/n0MHAh6jvFRVrQuXZTmRiJ4dw5xOIxNs81EkGL4dw5OPiAwsbnqfs6vybrPUhlZWmgB6QvLS6/OHYKFWq2k5OmUZAsyp0FpB2LEvtUFglTq7maRmBpe44v1lTRVwmQkgQ7zSuW9mOmjAndV1V1BcgYAu2JmYVKB3wEUh3skgesUdtEQihiW568iWVHWU8UXuqwtk3Y8D6DqaHRhKF/iteUiaAet8Qv0TeM01uUWXAN8SSJzVyZ/dIm5zs72nsENXF7fSfhUXI61CjcR8VOHp5ATBcvD3g07LmjZ8XHtD2miHRoWbbAyjK2DWIczqQcyLpBPALEI4iroZqi/dwh54n63CgSJU2csbWUQVUGWCRZEOuMyj7pE+ywk0M9131vdno9f34GUnaYgts5Wjfd7ylJdWLYBvox7clYSZv6U4hJM87rS4NOEjnDBAl29cxEGS1hHrTDbLqmLiktpaymFWyvoaXlLLPgpQ+n4G7spWXzEiug0+aq9ufDxWmwnIl94yoEgu38G5tpEvqA3AuHH0vkLe2dJbiQzxIkFdTOvievCrB1zvyygHjPaxDQEk72+hedfgq0t3NTxr2liUhR97LUgC2Za9+lf6ahS0RUl6/dQGcGh8kwQ6/qm25BhQlnfu9cBJPCqnAhH56mXCTUedAV5GNCJxivYCjG+PczvsqX896mQkwlsCZA1T8UsjPiqxGn32tP0t6k2ZtP1n9CnfC0/vVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39840400004)(396003)(316002)(6916009)(71200400001)(478600001)(91956017)(6486002)(2616005)(186003)(36756003)(26005)(2906002)(6506007)(6512007)(38070700005)(86362001)(558084003)(122000001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(41300700001)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzB0VFpuS0loZUVFSUN2V3VpeUJnM2hSM3BMeUZMMjBBaCszcWYrQkdWZGNL?=
 =?utf-8?B?ZXJ5TWlMQXBTYytJMGhuWmF1NVFSNERjL25PZGQxbnpOZ25vMkVuNXNxQ2J6?=
 =?utf-8?B?ZmVNaHZkVllPVUh3OVRldUU1Rzc5ZnFQZmY2cVVaeWVmbmJqOUpNTGdqUHdY?=
 =?utf-8?B?NGdkUnI1RnM5enhTa1FPN3FQOFU0blczTDBkdkoxNGtCcVpCN2QrQk9RdHhR?=
 =?utf-8?B?TiszWXN1SkhITm1nSGpjQk9ON09VVzlEUnMrUXJPNm9aUFJPeTIxNXVUY1U1?=
 =?utf-8?B?WWZVNzZiRUNKTDh6SlpTeVRlUE1ZSi84SVNKc2U0c3RxZHhOeVJoV0E5WWF1?=
 =?utf-8?B?MW9qRnQ2RDN3UVJDYk9tNWl3QWVQc3B1R1VoZ2NHMk54d0JJRjVMb2hEVVl4?=
 =?utf-8?B?ZkpwcitwWTFXK0JGWTNxeC9TTEl6TGd4ZWJqNWdhZWdpTDI4OUg2ckhoNTRm?=
 =?utf-8?B?dkNFNjF2b0hiQk9yclZFQUpmQ25Vd01vWmRFQ1hsNWlBWklZdzBNU3QwQlJI?=
 =?utf-8?B?Um9DQnpwL2QwVzJSZGZzdUFaTTZnSWdwQ2N1K0JtbXhRRklRc1FXb2FobUlE?=
 =?utf-8?B?Uml5cGZMY1p5akIxZnR5LzdCZ3k4MkxXdkd2ZVZFZjZNWEhUWUNXOHlyU05m?=
 =?utf-8?B?bzR3dGtpU1NwMStnVDd6SjhQMEpVaVdpMXBnc3czYzgycTJWVU1pNEVudG9T?=
 =?utf-8?B?TDBSK0xTdEs0OEZKMXFwczBmVnVQaVl3RDJiOGg1aGw0ZTB5MVc5QUFjeHJr?=
 =?utf-8?B?K1d5Tk9QcTBQY2NMT2dic2hUK21pSitvdCt6RzUwdWhTUklMakhhYndQcmpu?=
 =?utf-8?B?b2tHM0FldndsajNiQncrbjU1TFJwVmlyVGw0UXhmWG8xNlNrOW5PaWQxS3Ry?=
 =?utf-8?B?QituRnJadjNncDk1T2dnU25uQm5KZGtlVjFubTZONzZQVnVSQytYUEN5K3VC?=
 =?utf-8?B?VngwZzM1Y1g2bDhhbS8rWU1ReElnMU1hZzE1TnFXVWM2MFVhcENoSzFRVVlM?=
 =?utf-8?B?ZTMzODY4Rjk1UzQ2cTJaUFkzUTZXK2hUYTk3YldCck5xZ28rWDFkazBjbzlx?=
 =?utf-8?B?dHNqT1hIbVFTdWRQcHFMd2F6QWMrUU5XU1JIVndvcWZmVTNFSzYwM2g0NHdt?=
 =?utf-8?B?MTNJbjNESjRsR3Y0MnY1cEIzOVNJaHRXRWZYV3VOdXIzeG42c09SNHIvN1BK?=
 =?utf-8?B?YU81cDFVdXVNZjhlQlE4TlYxSHR6RGJLTzRMSFgzREljR3VGYjRGYkR2TWlz?=
 =?utf-8?B?MlFHVkMrMzRsaXRjUlVQaWJ4SWtWU2pYd1o2akx2VjllS21KcHIyZ2Rid29G?=
 =?utf-8?B?a1dmM3J0cDhBcHBHS0RiUWwwSmQ3RU9CNjcyRU9OdmthbTNmUHVYdmRjUFdF?=
 =?utf-8?B?WnBBYkJGeXdyUVF0Z1Z0YmQvN0hsdGlVbE1DYTZpbG1WWXo5SG5obmtwQzdI?=
 =?utf-8?B?RGhvcTRhUXJWRDhIc1dkVHpuR2lDQkxUTFpoZWF2MUo0MXRYQjlmdGRSdlBo?=
 =?utf-8?B?Z0hQMjJPR1ZIVUwzT0hsL1I0NExZQmttZ1ZmY052d0hSU0VVbzV2ckx6aWti?=
 =?utf-8?B?TTJoQjFnMTFrdFMzOXlpYU16RWsxL1V1MUJrQ2NxdEh0T0dLTlVYZzB2Tjkx?=
 =?utf-8?B?UndWSy80SEtIeFFhTTIzUzBiTVR5U056NDF0Smo4RWhKQkdLcVFxZ05YZmdo?=
 =?utf-8?B?czEyQzdTNnNHT3ozYzAxTERJVGhSYnVZYkI3Q1p4KzBBNksxVXoxcjVqY1ky?=
 =?utf-8?B?YnYyMUZsZVF6MXJaaVdncENHZkRWVjlhR3NjRnVoU3o0L253QWZMelp0Ly93?=
 =?utf-8?B?R0k0ckwzT1dVNUdNNXlPOWNMREQ3MUJvMmZBRnVia1BzRGphU3R2cEVRS1U0?=
 =?utf-8?B?bUdCWi9lc2l6Qyt2bUtVdTJQUkdabmk0bCtDT3lBdnFpWjhYVUt6eVZ6SzY4?=
 =?utf-8?B?VUJ4Y3oyUmJhcUg3OFZhUllhcmlBdWVZWEVnK0JTWGY3UTlwcjNmVFZ5Q2NQ?=
 =?utf-8?B?cnN4RHB0TktmRFdoQzI2enpaWi93N3NDTmtNOVM1Tm55QStBV2w2TUh0OWFz?=
 =?utf-8?B?YS8vUUlnWXY0N08wT0krdHlhKzc2ZHNRT0NBM0Q4R2diUUdTbm82RlZFamtq?=
 =?utf-8?Q?ZIvmHLn2FY6HkuMku1Qe8Izsl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA0E02E4A6275440B6A724BA403616F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721a4b92-f31e-424f-5834-08da94d5bf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:44:58.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5CEVtE5RPC2aY24SBPhHQV6DLcv/mBT1rDetVvPj3nkPI+lC8FhTjKRSukDZqM5UO49S3Vn850BQbr/4RY8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

VHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaWYgZHJpdmVycy9zcGkvc3BpLWR3KiBzdXBwb3J0cyBxU1BJ
IGFzIHdlbGw/DQpJIGRvbid0IHNlZSBxU1BJIG1lbnRpb25lZCBpbiB0aGVzZSBmaWxlcyBidXQg
SSBhbSBub3QgcmVhbGx5IHN1cmUuIEFueW9uZSBrbm93Pw0KDQogSm9ja2UNCg==
