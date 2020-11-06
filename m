Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529592A9200
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 10:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgKFJBr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Nov 2020 04:01:47 -0500
Received: from mail-eopbgr1300133.outbound.protection.outlook.com ([40.107.130.133]:43386
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgKFJBr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 04:01:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue5tyYTjLEvf2IGtCPm15jvIrtv4phbThdF7ES9VYntz7UBHzbc5J9OmJ6EeSmSu1urxI+PfIHuZe2hPmzwbnbLVb+/OfQ3G3bAVlBPBOQQ0nNYn3c2afvVaewiDXe6thHbpQpZoxTYCSfmfkr5nt94QhgQ/phcufgf1ei6PCqbbxoxMl6vJnlO+ZvaC9cG1649hKmnNlw6GD+ZPtWk7PpLmYEir5le75H1IrzKdaOcbH52G7ScBav6rsQ7B3uoUm6e3rpNfOyCjtR4VSW7KB9KPiYIoHbvgYpehzV2PvaOBuTEnxYfCqzR05AgalTbtycDXXWmEDidJKw4eL+FUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDO8aeL5lgUgafEvAw/ezQWT3ed1/MslZ9usXnV5ZHU=;
 b=H3MRjmHri25u5e18BJXB1vcW9XQ73omWEcPemQ4sjIOX0anSZ0ODjD8XJ0swDxvOZFY9H2uPXMaQRxz2pIlFrsingvQrD5RK8pncv3y/ayvOr9YxcgXyaUQh1nTdEK5N/nJH8/b2bJhbhSeIw2ZIfhQsL1QuDfuSGijeLw0iCQ8zN1ouYV+rCbpXwKBeNNDf3rW8L97kHuEzd+5k12X7vRQDLkQph1VK8lI4ObJbfW96JVYF92RC+t/8CBtUcPJjX5ltwChAOmmM7R0vNqVQ3UAUptceOA9fqe77k++Xlrsc0kSngV4FyEyvccc27xQAojO9j8nG/lUC+7nghalDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by HK0PR06MB2356.apcprd06.prod.outlook.com (2603:1096:203:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 09:01:42 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532%7]) with mapi id 15.20.3499.033; Fri, 6 Nov 2020
 09:01:42 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
Thread-Topic: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
Thread-Index: AQHWs2u0IlfHv/sBxE+PVdt+kUjCzqm5k6CAgAARawCAABmdAIABEHvQ
Date:   Fri, 6 Nov 2020 09:01:42 +0000
Message-ID: <HK0PR06MB27865D494F91D29B61A5B15BB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com> <20201105164312.GE4856@sirena.org.uk>
In-Reply-To: <20201105164312.GE4856@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72b6b85a-a303-46b8-85f9-08d882329467
x-ms-traffictypediagnostic: HK0PR06MB2356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB23567C549913876B4885B0AEB2ED0@HK0PR06MB2356.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRJPVvKyoB3DO2zJGT0yddAlH/LTBOawxUBtkEds3a2nUKjc0Vl6RWpbWPw2DojstbxBJHwFdT3YX75pOSKXcW9DaDXG5OaIXsOOBVbJHjkFkmm2pEinMB9EVvbUs9ryuiO95l2ekPz/lriHEYAyxBydPLjtAZmooVRvDe2WX1b5g4VDPKQn+56IcOdxLGwVitOOgp3XvgHZ7EKF36tWtCGEexC2g3GfzctckENLRDMeohKDkHGoJkJ+sxdTccmwYdsMSloj3Ek9Spabj0g0gYxzDGUBVnz68GoBc8e7ftD8jCBN6zoL/TNLsxy8h3QPk8k5RHUvUW04VMy+8mbOZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39840400004)(366004)(71200400001)(7416002)(66574015)(110136005)(4326008)(83380400001)(9686003)(107886003)(64756008)(55016002)(186003)(66446008)(76116006)(66946007)(8936002)(33656002)(316002)(26005)(6506007)(7696005)(54906003)(66556008)(5660300002)(66476007)(8676002)(52536014)(55236004)(53546011)(2906002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 66bdQxaphLW3i8Ndb8Zjz8002WDJcEcC/gA3j37i7c5h9KCM5OTxYOfTTiuE0L2HV0uqzK8Ju8AssUZvow3alGCZ4tLiEvY6bLEavsVmSYQeBvfM2ruuG+JJRvBxU/fLYPqIKvLtNjbyxkPcRubKt2W/4F83e1U4sukcbyppC56Cm57Rxqch8JTTG+E1Zl6UAsZJ8UU4dSrxWxogvmVfE7TWGeJZmrZx/K6j1AbgBWWhLTKRPwipMygm/tMeSpy2Vjea9iw6i0LVc9YKcekqrrgkhMxewSNqDQtGZGWUTN1QQEnmenNADXkhsVhNu1x3yNHH8NavmHJonFqi48nAoI2L6eqXsTE9JIvOGO9PwHk6aGBO7OJMEWgtB+1KZJE6ZamKUAJ6yw32auziwmA2X8fqV32zAnlMER6fJd21w/bF8K1hvasHP+w8kmy/ne+dWA2TW6jMhJVXN3V6BX2kudsXDWsRsA6abJ7jQnwbDzPfQIHk3kJyFteOEJLoDvjbnNUGGMImSqkc86ndX2RDgmD2XgTwmxnGuPzKCWl3NTLG6wBUwMKmpasQ2FA6Q0Rt80YnJ7mHEsS/Ckp0PF7gpWfWChoFoD+HNInyVGCfW0KdfNhEMr1Rb0zGkBvnxLDl67J3s/dA0+dzgc15R63N6A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b6b85a-a303-46b8-85f9-08d882329467
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 09:01:42.1833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKFYzK9gbK3nGIH/pWwF8re7YJxBYUOs/DAGd4PY2zgZ1PF8E5oj5gniYKJVac0fydbsfYL2sgjKqKA6i+hRmJDar3v68HTKifVev+UZ7hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2356
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, November 6, 2020 12:43 AM
> To: Boris Brezillon <boris.brezillon@collabora.com>
> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> driver
> 
> On Thu, Nov 05, 2020 at 04:11:32PM +0100, Boris Brezillon wrote:
> > Cédric Le Goater <clg@kaod.org> wrote:
> 
> > > Thanks for this driver. It's much cleaner than the previous and we
> > > should try adding support for the AST2500 SoC also. I guess we can
> > > keep the old driver for the AST2400 which has a different register layout.
> > >
> > > On the patchset, I think we should split this patch in three :
> > >
> > >  - basic support
> > >  - AHB window calculation depending on the flash size
> > >  - read training support
> 
> > I didn't look closely at the implementation, but if the read training
> > tries to read a section of the NOR, I'd recommend exposing that
> > feature through spi-mem and letting the SPI-NOR framework trigger the
> > training instead of doing that at dirmap creation time (remember that
> > spi-mem is also used for SPI NANDs which use the dirmap API too, and
> > this training is unlikely to work there).
> 
> > The SPI-NOR framework could pass a read op template and a reference
> > pattern such that all the spi-mem driver has to do is execute the
> > template op and compare the output to the reference buffer.
> 
> That seems like a good idea.

Yes, this idea will be implemented on the next patch version.

> 
> > > We should avoid magic values when setting registers. This is
> > > confusing and defines are much better.
> 
> It does depend a bit on documentation though, it's not a hard requirement.

I will update it on the next patch version.



Thanks.

Best Wishes,
Chin-Ting
