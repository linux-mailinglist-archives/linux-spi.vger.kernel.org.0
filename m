Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D757C337508
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCKOFm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 09:05:42 -0500
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:29665
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233910AbhCKOFU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Mar 2021 09:05:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJosvVEA29LeY7R+tgnUJOVZmddGbJPwOoSwCAnIlPalo8+h849xoirAZilE5Ql+bFHfVBr6m9K3IBIxHKLoBAktlLbEI0rjNdZ0Sq0RGIKN2yOwEWhJUC2WlBTV0wWufdBkBBg8xc7BobUlb9voiVEITKyy8E/vpg/0h2FQ6EueA7W3C5gMR24dly1lzJZ4Cj4YEwm/P/tvB10iaauy4SUh7JzeNd0Yq6Czr+qMl3bghWK/wMjdnXeba+MdRJwvG2Swg6m5fRbUmGAhIJuEDp0T2J20nH6lUuoZEfcZE1nByPzP3OYWq10MI4mkMcAXH5yo7xfBv1zs/Verh1AsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNGWXN0XdO7CDiFhAYh0XpzEUcblJQw+caudrFDfxh4=;
 b=JIVpxvDgpejhMhvJ9HlFbh5JE/Hw8gfa8O259EvwZghgCffDzVC7VRPOQS8dRB7KT82sJvUAuuwGfRxtTHdvh1NtXJ1SbDZ7/aPFWfJS+gNJUCCS59t5VugCDq2tC4/naHp0iLDSNx9Ws0m8ZVpQjsRYGyT9qM26hlHH5TEMrKqPDOSy6rMwKUksRadvpIOPQdr9XLsluVGJ9cRrJYwGtTilnjrCVdf04spedwklya7joaUPnE0NAJVTqG2gD2Jdm525NUVWm0+8e41EAE/qrHWsYzdsJERO6pxFVqdJo072KsLha1jpLR6EKVhVJxbRVsu9hOjwLzWM2occgayZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNGWXN0XdO7CDiFhAYh0XpzEUcblJQw+caudrFDfxh4=;
 b=bepQ98sHdMJMgWBgmZLKaJBiQJphSsVrDmr7hFx5GukyfEHseOpWyS7DcISJgPVQ7UnqmVv1UQ1RDC8ylQPJvkFcQ4oE+kORq1yaShmXk1nhl8sjWAqPMfzNaIdkdmmcjzE4PIVpth2pEp1/vgVw331voKQSV6zuwIsM3A9a1wE=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 14:05:18 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::d1ae:8c2:d0a0:4aa3]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::d1ae:8c2:d0a0:4aa3%5]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 14:05:18 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "vadivel.muruganx.ramuthevar@linux.intel.com" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] drivers: spi: cadence: set cqspi to the driver_data field
 of struct device
Thread-Topic: [PATCH] drivers: spi: cadence: set cqspi to the driver_data
 field of struct device
Thread-Index: AQHXFlauoNLM/KdYvU+fyStkKjY6e6p+x5yAgAAK17A=
Date:   Thu, 11 Mar 2021 14:05:18 +0000
Message-ID: <PH0PR11MB51912BDD33645BDAB88B0139F1909@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210311091220.3615-1-Meng.Li@windriver.com>
 <20210311132629.GD4962@sirena.org.uk>
In-Reply-To: <20210311132629.GD4962@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 298d1b43-79c1-4ef3-b25a-08d8e496b39d
x-ms-traffictypediagnostic: PH0PR11MB4808:
x-microsoft-antispam-prvs: <PH0PR11MB4808B0AE1F5081C417292F16F1909@PH0PR11MB4808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJPRIzqTcqJ03EJM9ib7x/NRI6kvgfet7vwNQGgqfnpe+lH+N7SCB+k0/J9PF567nsv82mTkH8fX8i3ZyldXs/OHZeJd5QHYOyY1PNVRkkdSTGX2a99Uc7vWrLoGURzlI1UfxqPkiA0Zln55E7TGHPWMayQEIsJsIZSjSNDxKU1rcNi/IqeYmbJZshZNMXUfZJlEexiAGBHr5bjURdJ4dQ/i0yW/UnEqhdtITMa0RUnqnGXME5T49EpMt2wjTIJjRECThBiPgQ0MXPglvflBZ6nGaG8Uj+K85sYgq0Lk+PoIJiKQp0PFkI3NWUNaathOQC/EaPVZne1a4iGW9ypTLjqtb5LYAqZIx6LpZDJ4AxyZui92PGYOEYIybGm+juRVLOBOvJu8uWuisTPpInYlTAZnaQYZLcQwx3vRVMcC90Rhzuo0JNXw/NCS0rCaST1G8QS9shcH47kmCwLz9dQW+z4xkv6GIGPGuh0j6WJbyAPUs0qe9xESZMK6wLkpfkQncSBiaSeal2X8V5TRe0j5KC7xDFOKFqOMy2Shrh/HEXunTind658o2ozVMizFdUvx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(136003)(376002)(346002)(66946007)(5660300002)(83380400001)(33656002)(64756008)(66556008)(4326008)(52536014)(66476007)(66446008)(4744005)(53546011)(8936002)(6506007)(76116006)(7696005)(71200400001)(2906002)(86362001)(8676002)(6916009)(26005)(55016002)(54906003)(478600001)(186003)(9686003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uhG9+PgmXjg37rB8Dmyi+Iz69MXxas8M39l7x4Hh04IdnCDYLRdl9x1Ba/xr?=
 =?us-ascii?Q?9vsdjuUI0pOtFm7infDdopeRe2tDPGcVdNox5ETh4c5BZeKlUIoc1yoQBeYP?=
 =?us-ascii?Q?OWyoZ+GaoHfmWFf/muONx8qPGLFWlDrQfIldgtltRdEQkxW0Wqv0rgRNAv1/?=
 =?us-ascii?Q?ON5A/ex1Pgc4rmd00dOMIEfH1STXi3mNbH4hy6LWrMWlM5FVTe0B0G2mz44s?=
 =?us-ascii?Q?GXk6k+Mt0Ls4592g/B7TCe99nKxKTxF5q0s61G7JCCDaaaJnyzblxuIyIZ3v?=
 =?us-ascii?Q?Wy0PGHTFTXRTDwku98GB7c3vJuKbUUFyfzS9WYuKiAAbUsHk5BO6Nf4xNzf2?=
 =?us-ascii?Q?Xeo2IT1TJ1de9Pj3wyehJkI4ZcbKYJ770u3fOjE/FCbcz4Z5AzOp39E2YK9k?=
 =?us-ascii?Q?HTyTZGGllDcwD8OFRcS2I47NpORW6dMv8wr7GVUXgXRgXNyleqe2VGMh/ADM?=
 =?us-ascii?Q?OhWn4TQFRvlK47F39LqaJBh4y65+DBrzjHi/M6/yBQeFWduvFr3IcadHMJI1?=
 =?us-ascii?Q?5lB3FlPhdg6CXWlDosu205IPNaWyQbz2bXU8I9Vkka+B85cxpxaF1B41nKlF?=
 =?us-ascii?Q?fuLLTgM1tKxpqgH1DU/h5+XwjMVHhjrZizno5YPsTGGsenhjE1qXdb/SC2Wg?=
 =?us-ascii?Q?TO33KtzxnDUmgpKigrow1xO5qyOAm3XKG7vO64xLzZ+dqX4okRFkcVxBzXJh?=
 =?us-ascii?Q?PDN3RW3cAV6YSUHexLrqhypz7BubWWnQWgl7BsgLEy0yeZ+LM6wVVpFiHPRA?=
 =?us-ascii?Q?Qdk03S2f0hiJk1TA8v7kovt1gb0+VioDIrfa/+QJt9PVBM9XFXdwVehpoSf1?=
 =?us-ascii?Q?06mwTQzFoBRGFPGCjRde+4hyjFxr6xFk0piOLMbswuqobEPFfCXfakg7KGTF?=
 =?us-ascii?Q?LwdHIfA6q2WfLL5jOs20cyocMQC9qNyk1O5tW/f5Qe7qk1IOB4R+uStqWQbc?=
 =?us-ascii?Q?azIjJfm/0dAb4LwoKAjjUnCqCUFKI2H1B8PxwyRVWopLHGUhkC7DqBtao2UU?=
 =?us-ascii?Q?Fey4iL58oTR81uT/sBGBNCRAuaOT40wTnfuK77sUtGjTiJhe2cKAWVLOQsXU?=
 =?us-ascii?Q?1ilNmsOcc/V+MRfNEGMz5q0uu4ajH2UzITHJNt3DoXkoz92T8xNyYpvgX7el?=
 =?us-ascii?Q?j+8TEXUoAGueiijgEOB6VOhGBk6wMrcrTxJOUKw1Xf5lhWjYzLTj/orNChf3?=
 =?us-ascii?Q?rk0+ZRBKrH73+9xGPxIAu/Bg8Wc3SUQh92GDIY0KpA07Quc5LXgzv0CVWVpF?=
 =?us-ascii?Q?vlcDuMQM6ev2CCNu5z+5SOCKxJHNTEHxeDCQdXmB4qeF97tO2HToNSIma2ee?=
 =?us-ascii?Q?zunuRD4gL/uBckkmNNRtpBI/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298d1b43-79c1-4ef3-b25a-08d8e496b39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 14:05:18.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QultBP2yUm+lXkQIyIxudWhtaHHdB7HhbvCgUTwFl59QqhOcSRSe3oGs7zsqMv0REpl1gcMF+zZV72nBm3Mo6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thanks for reminding me these issues, and I will pay attention that when I =
submit patch next time.
Do I need to submit v2 patch to fix this issue?

Thanks,
Limeng

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, March 11, 2021 9:26 PM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: linux-kernel@vger.kernel.org; tudor.ambarus@microchip.com;
> vigneshr@ti.com; vadivel.muruganx.ramuthevar@linux.intel.com; linux-
> spi@vger.kernel.org
> Subject: Re: [PATCH] drivers: spi: cadence: set cqspi to the driver_data =
field
> of struct device
>=20
> On Thu, Mar 11, 2021 at 05:12:20PM +0800, Meng.Li@windriver.com wrote:
>=20
> > Fixes: 31fb632b5d43("spi: Move cadence-quadspi driver to drivers/spi/")
>=20
> Commit: 5e838bc8035a ("spi: cadence: set cqspi to the driver_data field o=
f
> struct device")
> 	Fixes tag: Fixes: 31fb632b5d43("spi: Move cadence-quadspi driver to
> drivers/spi/")
> 	Has these problem(s):
> 		- missing space between the SHA1 and the subject

