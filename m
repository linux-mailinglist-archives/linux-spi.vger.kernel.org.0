Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E777540342C
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbhIHGSQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 02:18:16 -0400
Received: from mail-eopbgr1410042.outbound.protection.outlook.com ([40.107.141.42]:9184
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347743AbhIHGSJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Sep 2021 02:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na4o7mVlO7mMGkrWZ+K7Se6GOVORCbZ62eXRCQ6QVVMn21SbxRjbS+3lMe2TZqiXnjqxe3saWLPyTnWvlh+/zYakhwjwJSWCAuJlkajU9jf+9yKbpmbxbHcA8mQO7FXsKTf+zdgWZUX0gWzCXcTjtWyRrp4Vef2nf8UcMTFpADFR0ZekrZ5vQC+s/6JU4wr/Cacs4yV1tDiCsCpCYk9yI7b0kbhzCKVg/9MB7tZFFso/FrcLeg9qaYEmazwFDFzwNSVvtEXR0tSPQc+ldkqGaA24fruNfip3c/jKJuXp/0xWdUuC7BRltvm2eneadCV/EAd1fS/RH9nW5adLrj1glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+8W0mB2LwgEuncgZ4Q6+RCaBsK/lIlSLgWJd6JKEHmc=;
 b=eBbmD2ZH1nUvZycgdOf7nKfT1K46gJLqtHbkGlc8Ku2PoX04oVrXczCvnd00sMK0tA+M6w616V/kW6onnqLlvhA630nHV+sJc6iQi+uvIowjxukyjxfH05CXX6/JQu5ZnZ7657G02LqFrHeUw/ysFRAJTCysL8sxi2UT4zphA1lT5SReKJuJ9F8OktP7AYp5jy0gqCyT0TtcqQzshoABfUvvNtuQGK4SdolFdS4snW6QaBCHDOHd4M2ub2AwioABAbKIJCq/eSTiarNhQDrxCS5RvFqt5BMTM0pPqGRhLmiUCdzkVKOE6EZ7Rc+oNnk1p9c8oCXxqJ+s6yL+gpFuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8W0mB2LwgEuncgZ4Q6+RCaBsK/lIlSLgWJd6JKEHmc=;
 b=Uz0wnCyHFDtmocRIldFRnSKXvNlm+IvLljMTQJJIbnexC36CO324lJi3EAQ3ipFpa71AFs4TkUrM1Vy0NcAvHkBFw+t+aLpx84auuEKtWAdlY153W3sUxeCTG+G8fiBsEeLnUB6MQ/PSa0/5TFtdiUCJWMdOJXRp+4egtUez4W8=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OS3PR01MB6548.jpnprd01.prod.outlook.com (2603:1096:604:10a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 06:17:00 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::1502:1fa4:2cab:1975]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::1502:1fa4:2cab:1975%5]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 06:17:00 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH] spi: Fixed division by zero warning
Thread-Topic: [PATCH] spi: Fixed division by zero warning
Thread-Index: AQHXpGzgpRfkzD6gr0adyzLhTJ/gQquZpXuA
Date:   Wed, 8 Sep 2021 06:17:00 +0000
Message-ID: <OSZPR01MB70043A2D2C932A74DA7796E98BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d81a3c4-32ef-4320-5b5f-08d97290449f
x-ms-traffictypediagnostic: OS3PR01MB6548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB65488FA7D6E2D41957D59EFA8BD49@OS3PR01MB6548.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMwdD/fXHJiAl+7Cl0tvA6CA52wRHCuj0QgZQ74xSKsNd1Qd16zDwu4n8mQM2hmQ73vnBwY+IlAFGFTUn6bHYV7VGWFIZvOU8dDdd6JtVM6XW0m7Zfn6zeZ20PBz6EBm9xABwM49lVmHxIpLWbkY7CmomMoQxPGPVX2k5fBKBhe/iYKOPeiTisht1YebyYsy8k6IQsxnTL1e4rxQDnRAS8uLrBm2QOH18tgbt76wnD5r9C40UoFUtTvoDPCb7dYm9XYM6kKvWGd0tnGDfnBMzUFAn0wDKwztwPco9MFKsDdKtQVdlglQnpX8u1CXACYtJMHp+yqwkfnLGcZAvGhClHLdrvb7fJmBYQ8lswI4pLxDIrdfdi8fbaX7ZlRowGcUVbpCBMRgnKyThv7MueOS0KvTvIF0UuWXDiRvy4wKac/MyEQ3mTHFYionCBtnr26ndjPlUSIQ68NLX9Ni5Gr5ZzUaOadMGep/R8Tqq3VgL43G2FHBZaJ3+p4KX30S72llS8l0wPvBhYYCbjndXFx6aXNk+Tr1ir5hDYQEhqpYJy41oewbREhzdHyPBeVlUDN/nizEg3H4Q/sGIy/XjFxjF502r2ci6OFy7scnYm/jF7gCoerNFlVqxBBwQdaoJYexO39dQpo9g71M3YdIPikJZQZLRojPDHIPmCFoxduczTZYno/2h2T3vx7q80sxWkBSL1eQ+nTg+OGqj+TZBb9U0LHSOSWgZN/onX3fG/ZdlVc/9zIaf5FFoqu7VuflUuPKHZV90fkjGdNtP/nz5x5tRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39840400004)(136003)(346002)(54906003)(2940100002)(7696005)(122000001)(186003)(66446008)(55016002)(5660300002)(26005)(76116006)(2906002)(8676002)(4326008)(33656002)(38100700002)(66476007)(9686003)(107886003)(316002)(66946007)(6916009)(86362001)(38070700005)(6506007)(71200400001)(558084003)(53546011)(52536014)(8936002)(478600001)(66556008)(64756008)(65966003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?teDaCimIQ4Z4EJA2Fp17WeXKtkpoglhjAmdFEph49dEJLcQONfPXImCw3V1b?=
 =?us-ascii?Q?U2mUyB275G6997obtOBYkgK9+eRiPyKFb/r7kp4iKXfTYsPFtKtsy4QuPQ4j?=
 =?us-ascii?Q?yamZcmp4TxJ4IQoicwW2cNvca61w3W0xyccWHlrcxVpn5nobgisKPs39xkDm?=
 =?us-ascii?Q?L9vVd6kX/hT3N9bb49BWgGlWYVHGc0JbrzuFfXlOaKOnK8c0vS7WI6DxS1sg?=
 =?us-ascii?Q?BgXSvZ/dKVpofM0tXx1GoL+H6VtYp7sPiNridSDw+UWgJRl7L1TDD+R0XJiR?=
 =?us-ascii?Q?nZARySqccT0Ki2w13ohZ74xlx71ox62/RGKPKJxHiPNwYia8qtzyq9WSznlZ?=
 =?us-ascii?Q?UOTWd3yMes+HUsxGnEOKXe2rxFyPce9hDxfDnd5yndgYY/wCnC1UZS6qmCxn?=
 =?us-ascii?Q?n4FMUTx4Bqw+bTFgKyDOe3FJXRAuXPGW9utWBdgyYl7ovw75awQaffXjQ9Bj?=
 =?us-ascii?Q?oxz53p5N4a1Lib2SKW6zZMxr6j7Azv9khV//9PnUPFeWwZr+9Xe2ASgq7rZd?=
 =?us-ascii?Q?6rgofASeRB+BVfPunez9on0SIdesSJZg58Vb4B4LyKzcSrO5S3StWXSp4UYz?=
 =?us-ascii?Q?ENrh2EF1mDrBKFeQ4Hz/Hprvg2xZrQoBbHWoz66cHkUZ8hvM7k5VkF65nH9h?=
 =?us-ascii?Q?09qIasgwvqPnV9zWZpb4RWkbhpf/UheJ4KzfY4l9uvwkbmdcaqL99KhJ4upi?=
 =?us-ascii?Q?YObFzDDDENI11mCZHEw4MFyz2YCNHLh++n7u1BesTLvQu6W0Saqb9YYEwVEd?=
 =?us-ascii?Q?FYbh34YZpkzCyOHwj9ytAeD89wpwKh44dvnuD6Ho0414VU4L9kzhgmMHNOoo?=
 =?us-ascii?Q?qWw1V/n8EvKjPhxKp9jME0fJjrmDzbu+qdH+BOyml0qSEiBrFM05z4+KlqFa?=
 =?us-ascii?Q?8TICbCA8c6YnAQpWmlDUZF33cLms3u8RLyXiDbMNH/89Up68Eyu+ExNs++3E?=
 =?us-ascii?Q?ZnTdrRa/IYr/uqHOBC8E8HLPHz3AyLaGo0M7xF5jkaHZF7BsUjQYToub0bQB?=
 =?us-ascii?Q?Rpi9juHZa7xl81d+oO4x1G3LjY3SFJtXXj3Lc0zmK99m8o4FsKdItX2X1zu2?=
 =?us-ascii?Q?mzpSBPbK6Etx/Jcu7CNmsHO8PxZmu/wOcrOyWgtS+l79se2KJHiZk0MZuLVP?=
 =?us-ascii?Q?j8cE6b45pL6nty12r6k5m7qe9W6LBOx+sl3N+hXEF+HeZKQbVLrFhx2i+xh+?=
 =?us-ascii?Q?gtluq8aG4YKYE/AqTYXB+qiRmD9V8RpJh7dlIqhqqcYkyHfmDFwkui2cpS1i?=
 =?us-ascii?Q?FZ/QZK4Dir+PcErdUNVdtqh0eZvZSKM/4jh6qwogjeAduj++gnMyR/RYbgYK?=
 =?us-ascii?Q?zeoDooeguLxgAzLYFoTIHeXL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8C0BFAEB7A15C44825C224610ABAB49@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d81a3c4-32ef-4320-5b5f-08d97290449f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 06:17:00.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtzWliSeTdm6qzkO/DngkF0Q6zqh3w0o6O+p5OY5qjDZWteVOUqpNX6Z/HxmRo4yefWYt0wzQcH8CQi0eYUsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6548
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/09/08 14:29, Yoshitaka Ikeda wrote:
> Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation w=
hen buswidth > 1")

I'm sorry, this is wrong and not necessary.

