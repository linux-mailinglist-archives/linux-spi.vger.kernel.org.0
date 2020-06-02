Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBC41EC027
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgFBQfI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 12:35:08 -0400
Received: from mail-eopbgr700057.outbound.protection.outlook.com ([40.107.70.57]:30325
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgFBQfH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 12:35:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVe855BN+hvDCgqf/0w9yQsOyIDj8jAJi027Gx7KJBHnEbGupbeINtcdq/8soyP96TTh7od5inGKJlCD6tw7h1OPPdDYZsPKgPLYv7H/F+5/RNSfAPiUB820cbDEq0KDDR8TYOPLultEKCH74dnMI1Doas7Hg7eDDk9wz7iJKomvCSzCTx+h+J4sunEQlKqJRNiwkRUS8Ymr9DQCSGdV3eEcyBcub6DlQlFQEZPikEvgmvzH1SeI8wXRIJ4FSLFcC8J+wQxMbSE6b8PclP/quW+NCokISFTqr94tpmTXCMtD3gxUk72K/qaNvnburqQRbEc8z26hUcGVEtwDTcP4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrNYfKVm8jgkyRB6RAeqIk7sKNlgbRS+hxYhDAkRokw=;
 b=jvBcGYM6UY64Ow3O4+4/lRmGroyGkSkbc6Zb8QqMZiWmp3jL96BlfEQMtJKodxobKzxIKo4B4dgKzt6KaCKfVAImwIkOseAzI4Go6//mo1JFb2LqglB+uiRrTQk13vGz3w8zrO/I7+6ZXKlZzDKQ0Nwtx1dD3qBDNHK/V5a4O6BTpz2KB+QPVyFdbpqhFcUkmRvNdMZBE834pcKu8/+m/gUThyBWealbd6mxxEDjTOZ0AySK4/oVlbtKeqXp1hlb826zQYlchCyTUGAuLkXXxayzyVRKPTeBIvTlWUAqcOfkKW1KYBX0SQwRc/QrJ46XARdVrB32pfnJ0EY05AmbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrNYfKVm8jgkyRB6RAeqIk7sKNlgbRS+hxYhDAkRokw=;
 b=YOjeDdNfuMjt/ExDN9exr9yHRdbD1MYw7chD1zygRxW5sRS7uZYXVGHR8Do8hoNW52KJUeoXvGtJE+oe2A4A6doLP0UfK8BW0VKYhpWQGpzLJj8gSJdsBzD6gwqxPydAG4SS0gTx/JDotz7iyT0fKqAkfMVBUAKjkF6BR0mBYbM=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (2603:10b6:408:ae::24)
 by BN8PR10MB3268.namprd10.prod.outlook.com (2603:10b6:408:d2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 16:35:04 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941%2]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 16:35:04 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Linux as a SPI slave?
Thread-Topic: Linux as a SPI slave?
Thread-Index: AQHWOPvEoPGFwQqJ8U2iNDod95yI5w==
Date:   Tue, 2 Jun 2020 16:35:04 +0000
Message-ID: <4958d1437f88e47e57b9736b0c0fc067ece812f1.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d247d7-1e66-4d81-d1ae-08d80712e765
x-ms-traffictypediagnostic: BN8PR10MB3268:
x-microsoft-antispam-prvs: <BN8PR10MB32682755FE398CE66AA20473F48B0@BN8PR10MB3268.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTvss20qZ2k9qeZEYJLFVH9+FUh1Ref8CzAjmE2OsWW4SgMSRsFcgJXNYwX3z4qwQ38VYKfghW62CGNlt3X0kFMDopP4QDdYHgFbm5/vawTIir0WSPo4K6ihD2d6O6KD2rNnaM0fBAXqGaCZKTgCUJkU/i6gKiVMBaQ2C3VLeC0SmxrpDgYJwSrZ9WqSh+3znt+blGDiD1/49t4o96ZGDSCQDeGKOw3ycTjSJnF9+3FfcyhHjIfo/Khr6PcsNT8a3HergLCzskgDlB93NEE6fXWpbFOQ58PzMhe0DpMBzQHIhYy19fvQO9v+DpXCeepmHHJ75Y5ARMBIrhTt/C/0Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3540.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(478600001)(64756008)(66476007)(66446008)(316002)(66556008)(91956017)(76116006)(66946007)(86362001)(5660300002)(6506007)(6486002)(2616005)(558084003)(8936002)(26005)(36756003)(8676002)(186003)(2906002)(6916009)(71200400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DcCpmzB4IlRZqznuOAfZQO76InPZCP4V8l/Vy92FdSbyr3itSufd+C4pCGm4o7ow45HqnBPlPYCKaVRGixLJ3+IgJUrsHjwjHhwtqUGrSHqsWYpM9bbka3ramc55M/oC2OIiZ0qP70KXmka3jMNWE3F6o8rzckPPRmjXVDTD+pPUjzOYoWmzigtKTxu04s5CLbZkoXoQMw9ufEUH+qwQnfponUpSCBdFijx6755astr6/vUfrxXzoUdPkNNKaNwJ74GBXGpWtC5/7aqPzobUFrqwjI3u2opgD/uIcZTdZdrCjXXNHNtmkniZnMtvbS4FJcQ/M2VjD6uieaH4VjBkLHf3l5uSZnRGfpXwamp1s1RDhAM39XGfOUEW0mgrDu9IGZAXl+45xSC8cBns0NZdnavcl/5HqA9dw4znwm9SAZzgNhI0ntPUP2Ma2gKvhiGJRfv1yMYEqv7+yyJE1iTPu2TQaKZvkOXF30ILx6Mw23E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AD2FE1923AD1947A450AC3E2F2887BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d247d7-1e66-4d81-d1ae-08d80712e765
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 16:35:04.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SC9Rz5Riu2sEDZ1U+8IozYYfLXxjGxkhlxkzbXx9skvQ5zaubRIqULFdmAgOHWwot6FjEU5dTwwEk2GSdTGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRoZSB3YXN0IHVzZXMgb2YgU1BJIGluIExpbnV4IGlzIGFz
IGFuIFNQSSBtYXN0ZXIuIElzIHRoZXJlDQphbnkgdXNlIGNhc2VzIGFzIGEgU1BJIHNsYXZlPw0K
SSBmZWFyIHRoYXQgdGhlIGxhdGVuY3kgY2FuIG1ha2UgTGludXggdW5zdWl0YWJsZSBhcyBhIFNQ
SSBzbGF2ZSwgaGFzIGFueWJvZHkgdHJpZWQ/DQoNCiBKb2NrZQ0K
