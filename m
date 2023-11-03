Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06957E0972
	for <lists+linux-spi@lfdr.de>; Fri,  3 Nov 2023 20:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjKCT2c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Nov 2023 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKCT2b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Nov 2023 15:28:31 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2097.outbound.protection.outlook.com [40.107.116.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BECD66
        for <linux-spi@vger.kernel.org>; Fri,  3 Nov 2023 12:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGL+C+I4rjN5btSXTnBkEF7m0Vf6k4PNHJ0vJ81GlydxMleqSLjdTZZHQXH2d1JQeSUxVKXZbtaj8KA2R97+7rmDL7jz7oNtrSwN+y6JhnvZ07hhOxyENEED6rdwcm0eyOZnNEIfRaKwOgbdXKh3+daCBkEIITkINoHL6JcAACei38vEhjnvSkfT0ZDmFTJMZiCw/CMGMBeJ7y5yHybHrSm1sG4LwtJDYrQQtjn3W/dX94aA15tyLRzAPRcR7Mem5Ce5EhtngoOOWObC9jQl+YB/lI7o1VrDT25Ye1TWF7n4anoa0m+waQw314wbf5E2GwPvqpHl+uMEnptKnGbxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m3/K/vR1i9XKbCjnXB4AEvAlffiPMa9apqSJee0j7U=;
 b=M+gD28hF8ZBPT493BD1yKVyqtp2MLvSXGRnG7kqDnQlfGFEffrNOosAOi8g5e3r9zTRCSfwY+YUHOhpTKPQr0NT3jMzIWGWnaTIe2g+dWPun91LshWe3S9yFPTstUC1fbsN8K02UkJVsu1VW81x1+qLxvMMvDlGhAU97h5Nn7rd+wEsGmFQ053iDebej54nTFZd/23t2yvNzpJpL7QcaUXA+MbSBEy1xgfIrJPYAjNGtHcM/IAqwSyieqMW306fiTCJNrjM9LH9rs8MldostmRCi4AlU80BbDZE9tZg2Q+99tedxTAJrAy8dzgaRs1VTtiUkO5I2xwQkDCk4JrZgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nautel.com; dmarc=pass action=none header.from=nautel.com;
 dkim=pass header.d=nautel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nautel.onmicrosoft.com; s=selector2-nautel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m3/K/vR1i9XKbCjnXB4AEvAlffiPMa9apqSJee0j7U=;
 b=Bvqzo5QJIFGW5EjiJkmpPtxAb24P+UHb4mgY0KhtCosEFdaGnDJHelTiZo2G7FxAlL5oXkjyoPV0NdYHgysGHmKRFuoZVc/Lx/PEf+yLddXg3xttCmmjktF6DaqNALN0ru5IY/olkSbQlNlB3mgvPW1yyCWuBMvheDs3TZygEcA=
Received: from YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:67::22)
 by YQBPR01MB10705.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 19:28:23 +0000
Received: from YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3e8c:ddba:db97:ab5c]) by YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3e8c:ddba:db97:ab5c%7]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 19:28:23 +0000
From:   Luke Morrison <lmorrison@nautel.com>
To:     Luke Morrison <lmorrison@nautel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vz@mleia.com" <vz@mleia.com>
Subject: RE: spi-pl022 on lpc32xx
Thread-Topic: spi-pl022 on lpc32xx
Thread-Index: AQJI1IeDVlIK0r/KprmXy6tPUPEc/K+IDh4QgANZ4tA=
Date:   Fri, 3 Nov 2023 19:28:22 +0000
Message-ID: <YT3PR01MB6339DFC8B6304D22DFD276F1C7A5A@YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM>
References: <e060912b-0a7d-9fd5-edde-c27a8da55569 () mleia ! com>
 <YT3PR01MB6339A54903A0DFDD3D1C1598C7A7A@YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT3PR01MB6339A54903A0DFDD3D1C1598C7A7A@YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nautel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB6339:EE_|YQBPR01MB10705:EE_
x-ms-office365-filtering-correlation-id: 4e138db4-57e6-481d-d92d-08dbdca30b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIbGn8/IHK0Us1hMDgqgBWhEPM0JTr25/NdxLSHZGxd/SgzL04lYbI8FrwSYWNc44nfvvhvkmHZ/1P1I9Bc+XYMKuMgdiY/z8UPLplW0cwMdhs/wjVKUbLO+hei2C5zrNlJJdSukLTvQFHSRzHN+82mNdKYvlI7jPC8PWpCP549JPRkGAjY/TBEeSBpW36iqXHxrwHB/d9ozI7GaysjVrHJuYc4V0z59wkq2ZsO75hejbqguui8JN5iAgffEitAnb/anyF5Z/orMMZB7cHUan6Tphp27OsL/G3b06ocPuzZZF15xJDMUQXMEPzQvcdsGgqrY2YMblhVyDStH2gM/oRC0pSBlVwkDWPedjZ8Vc9Mqxw6yghxiCv5mRVRB2uA30YKijkGeMQOoxtJikrpfM6nxvmK9LjjgxFkWyZKzg5RdaWmV5egmqEWo9/pMV+Y6dpCNVXDX+pbjztfyKb9PBqZCca1mBc/MselVPTbWapSt5EgnLKOsvKUuRQWDNUg/MHOBvLVNirvJA/NEVLLho5JMlSXedQmh0uIwFzGpbRuoA+cjyXusJLtsH5NbsPJJ+FjG/Ndon7TQnx88oEO3ZeXQWwT8LLPHtbxxE11hj5Kkp5E48ra9Uzc40lpEN61i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(136003)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(2906002)(26005)(7696005)(6506007)(53546011)(9686003)(33656002)(71200400001)(38070700009)(38100700002)(83380400001)(122000001)(478600001)(41300700001)(52536014)(316002)(64756008)(110136005)(66556008)(76116006)(66476007)(66946007)(8676002)(8936002)(55016003)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xCgukPttfqKsAtLRJKiGN7sLr2KqD2SLoK5uVeC0l9aWcB9ZQsBwdrgdThPs?=
 =?us-ascii?Q?Usriczp9EJPQ8Y6PLF68LN955IXikkLxRHHmjAvthTmGN0lmm7PYg8ThZPGZ?=
 =?us-ascii?Q?RKO+hjyOphTv/cI32ibDh63PCv/Tu3D0OGSyFdLxWdDfwccLsOpr7DsFUrae?=
 =?us-ascii?Q?UmntpFlYDLM2XL4mRnj3k8TM9iQM1RMGbF24MYKyQwPfaN4Rl4RFjSm5AmjO?=
 =?us-ascii?Q?oGvqnNskAMdIcfxQydubpdM0ck0VdnRYIKB5jOpZNj/AukA9Hy27zNwBbPAf?=
 =?us-ascii?Q?Sjg9s0Te8fbkM6klqq0y+D4dJH8OEx4Y7t5luCp6NH3nMcGBVOMZUJdssYgy?=
 =?us-ascii?Q?2gws6IHOyfIPOHa4lJwvYXUfUta22eQaa6pbQfg8imMoMbcRTU0tnUKkax9Z?=
 =?us-ascii?Q?prghAdlns2sZUIkyr3jHMdVgxxYfLIZ89Ylf4GJcII4jf+hWYgI5MAw9gvAH?=
 =?us-ascii?Q?kuAwphmp1lny2dpR+CcRItZ6ir1UOu5iOOFZR4TnOsw+P6tcq3wcMbYPNA6o?=
 =?us-ascii?Q?5LFzm/Ypq6xBNLy0Vk4/GNwv95xKvkJ/fjybiKTXmmhwN4zFcSTeiL14CL0r?=
 =?us-ascii?Q?BUnC3WBSb9pdHsPm+ACsBoVN45Q9+Lbvl4MsvI8KKYD0f12tjzmzXvieGoR2?=
 =?us-ascii?Q?ZbSOsKdcjQZ8+DailKXFexRkOc2ljzqwp758zx0B/Tbz3xTVBLAlpLO/LqXX?=
 =?us-ascii?Q?rfw51X7yMKSGuIsi7p/zXszQQKh1sgaUgfq+EEbTgyY2HJGS5sK/NZ+08Bw3?=
 =?us-ascii?Q?zvVbFQCHlBMQWHCtqvXOuEy8WbogAIW7eq1YxWMvvcgptToxKYP395DINvvf?=
 =?us-ascii?Q?li3v3o9ShUW3tpZ59WQVAPBwfKy/FkfxCZIF88OB+jxkByXMZLJmM8Wd6aa1?=
 =?us-ascii?Q?OAFOYXl7b7w0VhtAyOwNAQtAbSWbUneiKXwibCW78QI1OYhztGEAOFwZ4GNj?=
 =?us-ascii?Q?ujcZ3ygYqB1/R616lzjeRdjI1L9FSAp1z5Gitd1KRwbQHedPg7sq/hTekH9K?=
 =?us-ascii?Q?Fe0S/R8W2LU4lJND1RaAnI7dH5afNAyS01TYfJntX8gUNdNvD1+wwV/NKK0b?=
 =?us-ascii?Q?q0wGs6bSDVT844yF1xmNyq2CCrcn9rLz7SD1JBZ9ZxNRrYHtzJi2nB8ntXLs?=
 =?us-ascii?Q?SeqHMr9rGmKgS9TwBnOjAWxD9ASkbFQfXzOvO1CQ3ymItf0iis/X5jhapfF3?=
 =?us-ascii?Q?wv8aMYVeEEXSmit0Hpzbn8X9ije1wq9iaAC76d4LDIKwp/kCcXcSblt6pBzS?=
 =?us-ascii?Q?zt2acYaBSAZ9THdlKSz3Tvh3N7ZZ7LyuHzLZa+RZ5/yTHwJAp0PZ2zUievNO?=
 =?us-ascii?Q?X73CDFN+qdVtFqCkpUei4bOQfS06ODD269AAmNb09UvqJG5Ds9K9qZWE9Avw?=
 =?us-ascii?Q?9FmyOlL53C6TtbJ/OcsBJexIbj+l7BxzpULVVwPwn57oI4yBeAarqkMrKOxF?=
 =?us-ascii?Q?1ltBtkjzrO1/AR2J6iW1/yaEKl96d5vrzk9c6691KgMwja9XHIl4b2tcvxRi?=
 =?us-ascii?Q?+LmKaPIu18tXSKPrnZ2ZrLSpE9wmdKimIEJWy1m4Ese6aAD/wqZmPJdxLmcw?=
 =?us-ascii?Q?6GwujWHnKiZKjpYha+iaN8BzW9EUqa+m9p3BMOgx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nautel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e138db4-57e6-481d-d92d-08dbdca30b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 19:28:23.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 656f830c-eb88-49fe-90f1-433363ec7ccf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myBAsa++GQHR06vALxkl4NfDEc6qIqs6UzUjoaMEKJEIbpTnvnnnfU0lWA56wh1W6Qji7qD2CN3MFAa7E8Qitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10705
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/1/23, Luke Morrison wrote:
> Hello,
>=20
> I'm with a team that's working on picking up this work where Trevor had t=
o
> leave it behind. We've worked around the issue up until now with a hack
> using a userspace program that talks to the SPI peripheral registers thro=
ugh
> /dev/mem. This won't be viable over the longer term, and we're revisiting=
 the
> task of getting the pl022 driver up and running.
>=20
> On 3/30/22 10:56, Vladimir Zapolskiy wrote:
> > years ago you've asked the same question, and the answer is that there
> > is no pinctrl IP or controls on the SoC. This sounds weird, but that's =
how it
> goes.
> >
> > There are just a few multiplexed pins, and a pin function selection is
> > done on basis of powering up a corresponding particular IP while
> > keeping conflicting ones disabled. Such implicit pin multiplexing is
> > inconvenient, but working, fortunately the SoC is simple to have such a
> model supported.
> >
> > The newer LPC18xx/LPC43xx has a pin control IP, and it makes
> > everything much more transparent and comprehensible, but it's not
> > transferable to LPC32xx.
> >
> I am really curious about that statement. The LPC32xx reference manual do=
es
> document a number of registers related to selecting which peripheral gets=
 to
> control which shared pins. It's described in chapter 33. Specifically, th=
e
> P_MUX_*, P0_MUX_*, P1_MUX_*, P2_MUX_*, and P3_MUX_* registers.
>=20
> I note that these registers are defined in the kernel, but it doesn't app=
ear
> that any drivers are written to actually make use of them. I think this m=
ight
> be part of the problem that Trevor was hitting when he was working on thi=
s.
> Since neither the kernel nor U-Boot ever attempt to set the bits that wou=
ld
> need to be set in order to give the SCU control of these pins, and we kno=
w
> that our stage1 bootloader was previously also leaving these bits cleared=
, it's
> reasonable to conclude that the SCU wouldn't be able to access them.
>=20
> We are working on a change that directly set the P*_MUX_* registers to
> appropriate values for use by the SCU, but I think the more appropriate
> approach would be to figure out a way to map these registers into a prope=
r
> pinmux driver.
>=20
> > Best wishes,
> > Vladimir
>=20
> Regards,
> Luke

I have a follow-up. We have experimentally confirmed that it is not
enough to shut off the SPI1 peripheral and power on the SSC0
peripheral; you also need to reconfigure the P*_MUX_* registers to
take away control of the clock and data pins from the SPI and give it
to the SSC. Trevor was on the verge of discovering that last year when
he reached out here, but other obligations stopped him from being
able to finish that work.

In general, it appears that some LPC32xx peripherals will unconditionally
take over control of pins simply by turning them on. Examples include
the LCD controller, motor controller, and SD card controller. But equally,
other peripherals which share pins will defer to pinmux registers instead.
I can see how that could add complication to a properly implemented
pinctrl driver.

Maybe that is a good enough reason to stick with configuring the pins
statically the way we need within the stage1 bootloader and let both
U-Boot and Linux pretend that none of these complexities exist?

Regards,
Luke
