Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12827DE47C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Nov 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjKAQUI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Nov 2023 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQUG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Nov 2023 12:20:06 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2112.outbound.protection.outlook.com [40.107.115.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51701101
        for <linux-spi@vger.kernel.org>; Wed,  1 Nov 2023 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gthp5gBC2QKQYz0KShzwf1Gle9mjb1r9Nj3Z9P3bRyRYke6D9RdPrfEdNv77G33dRxXt8DmrnGrb7WI02BtkCz2aacI77QvyKQhQ03K3XpgC30NYHKc47UPSDyYwRkSBgt31na4msNSVBW/i6HkX0H1MQjcbioCPDyh6Gv/MijxdNyaAo1mrox8rw70ZQogFIvBh41FyCWnuILpuoCkCPn//PyNRWLA5oRN5LBeUfvOuM1aEGoKHus3mwCJaWzUIaLL/JyJorEHbAI2t+2rhD2jQLYNBfkzN/E5j9DQPZtbaL79QO+eZodUx43Y93E1j9cCYWmqxsvvpeiXQvA5SKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwld0f9oStFdKrPEfERK+YEhbEVbR8MzlZcrhkNNwn8=;
 b=RF1AtsTfwAj3UrJg9/DLeTttLfFkkK3hO+1eXQNr5Bs6SlEj7NOUy8XL+W6tKLAZwJyYbWn5vEM+9h9QhMp0TbF8xOZBLplw5xZa7u/EOOBjNbQCsQ0XEM4klaaPdX1SCvZ1HpddGwDg5r4R4G8tv/NzscnPGeV7mlDGulngTwGlPEZXjFRmNQdQ7hgd21qIfQde5Nft2Z8RYkk+NMdO8GcZlBhzqrlzcTK+S89+iOP2TTpxfSUbZFXmGC/HpWI1BjV2bR8QLgzcpmlAbhHGOuTGhnCBH0wfZE9IAqTkF9PyR4y0aImAX4jYDcv0f/mV6bpp4vdBxPxtb2RsIk7E3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nautel.com; dmarc=pass action=none header.from=nautel.com;
 dkim=pass header.d=nautel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nautel.onmicrosoft.com; s=selector2-nautel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwld0f9oStFdKrPEfERK+YEhbEVbR8MzlZcrhkNNwn8=;
 b=p1JxMR03LTQL4gNJOexpCohE5xMvVU8rgi66II8tokHKONx65RCM6PgkRzI+To+rgYpbURJqaMdkO9pe4fESYTLUxsQ4JrTe/pnjMGUAmGgOE+i2KyDgXEnCDDdtoDPvzAfHMCSF0ieeaYINC4B9WKhVBvz6NuW3s/VmUsBmL80=
Received: from YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:67::22)
 by YQBPR0101MB5896.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 16:20:01 +0000
Received: from YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3e8c:ddba:db97:ab5c]) by YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3e8c:ddba:db97:ab5c%7]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 16:20:00 +0000
From:   Luke Morrison <lmorrison@nautel.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vz@mleia.com" <vz@mleia.com>
Subject: RE: spi-pl022 on lpc32xx
Thread-Topic: spi-pl022 on lpc32xx
Thread-Index: AQJI1IeDVlIK0r/KprmXy6tPUPEc/K+IDh4Q
Date:   Wed, 1 Nov 2023 16:20:00 +0000
Message-ID: <YT3PR01MB6339A54903A0DFDD3D1C1598C7A7A@YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM>
References: <e060912b-0a7d-9fd5-edde-c27a8da55569 () mleia ! com>
In-Reply-To: <e060912b-0a7d-9fd5-edde-c27a8da55569 () mleia ! com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nautel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB6339:EE_|YQBPR0101MB5896:EE_
x-ms-office365-filtering-correlation-id: d7b04977-ef3e-4b6a-ab7c-08dbdaf665e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwcvmd8orQ5Lo16AIfX+bYNiMYnaHEiiprq1Cz0/gysFxkxR8X5eB0nBXc4o6M280RnOATXPZKRExZXYc3ILy5Af6L4vtdnDFMcxHWDjGbeeNQ8IxDUq/HMHEcdSMVXG6m7j+HxsjouqRaVitQvnq1H1WF4MIVAN/DXUegrpTDrQ9lZUikpYi6BLsyCRai5QJP2HRn+4gAfb941peaQ9c8xdWrowOEfuXXzRh/656frE6kUGwwmHF6TdNZafIeFsFH7wKSwvpzCEDVgwTX274WZjELcpigX2dXgujNCZ5lvflKLXT1HH1QWHffUgksORryWRxaGlB/kQptl5si+NJ5RavV3q1DKBq4p589zNDUqw4Uxe0cH+4qu/IQLa/M+C9joW1a/CnWZbwvfS2mfAqITzm1BfRoJncJx15VeQKSSK+1313kp0ls5+kj5nZ93fxz5AFuTJDR9WaXLXcZF2LKEnE0wNwaNKmibrLhFGeHcvG1IxI5NX1vY22nM+mcMlO7GwfOTweTJEbjz7e5cLCuMovgxbbg9n0LKnaEzTAeVpeWOD24NL1+PqgKo0aL+RGVcnMkE5JJ2VvioidF1GKK8exZdTebxpNAMO3LMFqObfdKL+n+28L0qgYkOxHrf4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39850400004)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(26005)(9686003)(38070700009)(33656002)(86362001)(122000001)(38100700002)(5660300002)(53546011)(2906002)(83380400001)(71200400001)(478600001)(7696005)(6506007)(8676002)(66476007)(8936002)(66556008)(66946007)(52536014)(64756008)(66446008)(316002)(41300700001)(110136005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXz9MLyFSaZcVfqMHd48SaVKVLOm/CFEI9cx8C6ffIwFHYVJtY+acrR0B2SF?=
 =?us-ascii?Q?IOrUtiEoLLpemAvqXsxZXmHpfLjWJ2Fl8sBpaf2+1Bucjjsld2v7EXU0xKJA?=
 =?us-ascii?Q?Y8CpLyt0gEzadeO+tEbZx8dX5goSwh5X37XuiYchMVNg9AprCRMSttfEqytt?=
 =?us-ascii?Q?8SlIi/wtuHo/MnjmgYMibgarTtL1CHjKwHPW9d3ur9uScuJi7Saytw5eoi/7?=
 =?us-ascii?Q?ySJI/WVQ7FqGrokzm8XUzXDEXmwGLz01hiDtjHUAGPC9mNHabQ5GeZFcXfzB?=
 =?us-ascii?Q?jHlZwkvhUXDugLKyzctwQdrmWy7AYeL7nAmP8j9IZRQ8kPGreRKf612ulGu8?=
 =?us-ascii?Q?otgQTiYYasNLjwiByg2eI040w2qafcfVeSaOYLUevzXWN0mpPLdt3Pn65yXh?=
 =?us-ascii?Q?cyWJu08ABwK7K93SrF7IvYjY72m9Ou18ZBwmNAkKhGTP3qCI4+Q35XrGnOns?=
 =?us-ascii?Q?r4TecOx1FCN0I368ei+BBqbpVhf7j9ixiCSpRTglc0MiCoaa+SHRxOLMxM5f?=
 =?us-ascii?Q?I53mQYIbtO0YEGM03igWIK3gnOYp3ByX4055y7A7niYZj8Di9BSe6DkWWb3O?=
 =?us-ascii?Q?gaWnQfncrEQ80VIW5OF08hCVxn4OjjveEzQlXgGxTXGed1HlbN/VNksAIkgU?=
 =?us-ascii?Q?CeSxbMU66HySyIM4zEFj2sQ6a2mk1L6bgmszUiLkAFrHTDRk3dLswJTHqZzW?=
 =?us-ascii?Q?hzBUPnFL7FinSsF5qtIb8TSZL+cmtBWwdQ7kzR1ztvq53olKDGUYqq0WqaEp?=
 =?us-ascii?Q?eqHmEFEKBj7d0+EJwCe0xuWzlT87PWHuveMhYDeUeAjevCkm5sz3kqozATyw?=
 =?us-ascii?Q?N6iL5IibKacN2V4E/5QxYbffVLawhQSpJM9iyJSNcQyc/vTl7uZ03lOuuOc1?=
 =?us-ascii?Q?LRTYaulSlO2rQ+JsGi0gadPHa1s1hWrfHYBtgV5C4vqeFN/PhxVTcD4GvA0r?=
 =?us-ascii?Q?q5jHxQpAsCvobWeFPNWyxausni7Bb3Yn4SGFjMs3ia+6xvOV+9uH1KtMF8FI?=
 =?us-ascii?Q?SsipPrNgNqGALgNQnNwbOWXD5DOTswGA5iTCzEejRjrczReF5wpLypFsn0nq?=
 =?us-ascii?Q?utpimmd/Mqf1MA89GELAkUAqhC6RHtAx8VbDUyWDzUgxheA/85cj5+f5jO9q?=
 =?us-ascii?Q?HDS4FqPJay6kNMC+k2kwI15pLt01p+Rk/LjvWEjKf5F7yYE0iq42og+X2wOs?=
 =?us-ascii?Q?taNBII8OvFiLpt1fCcSvZkoKN8xHWUJ/NIrtxduXgGe8SRY3A+Swu+7leJwa?=
 =?us-ascii?Q?1MlABzH57VwzXjeOuYwa1OCr1F0VP7xZExhqNbQEegxbK1PZKwumOZ2dJVfU?=
 =?us-ascii?Q?uoc6JFTES22CGRP6bcZieoZIMv65nGobcQfxfq43OZOfcpZaJ3eXNgjh95gT?=
 =?us-ascii?Q?TyhxZfUkdnuoG3O9FzNcy6btIn0/+/Upm5czuVYO+X8g2BIGDO/bKBxb15B2?=
 =?us-ascii?Q?mgDsXs9+cvCGdKetu99THmeypQNmLrzqTH7owX52SpN5UJloB8bmmlNTqm8K?=
 =?us-ascii?Q?kaCXg2gV6elAFVG+1+JiXyADXGG9pde/gkuLujOe76w6NQutXtcVQlxi3cRa?=
 =?us-ascii?Q?kCkdipl03YQFoZUIrRzlGUkg9yIEX8iM8kkqxkQi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nautel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6339.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b04977-ef3e-4b6a-ab7c-08dbdaf665e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 16:20:00.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 656f830c-eb88-49fe-90f1-433363ec7ccf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4eTluby1+1iHImkw9miOQW0KdJBNJvj4PfYbQAN3yx29cpv1VsxMVqDWC3uWTa8D+UW2e2xMHAzPW3SM5Njnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5896
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I'm with a team that's working on picking up this work where Trevor had to
leave it behind. We've worked around the issue up until now with a hack
using a userspace program that talks to the SPI peripheral registers throug=
h
/dev/mem. This won't be viable over the longer term, and we're revisiting
the task of getting the pl022 driver up and running.

On 3/30/22 10:56, Vladimir Zapolskiy wrote:
> years ago you've asked the same question, and the answer is that there is=
 no
> pinctrl IP or controls on the SoC. This sounds weird, but that's how it g=
oes.
>
> There are just a few multiplexed pins, and a pin function selection is do=
ne on
> basis of powering up a corresponding particular IP while keeping conflict=
ing
> ones disabled. Such implicit pin multiplexing is inconvenient, but workin=
g,
> fortunately the SoC is simple to have such a model supported.
>
> The newer LPC18xx/LPC43xx has a pin control IP, and it makes everything
> much more transparent and comprehensible, but it's not transferable to
> LPC32xx.
>
I am really curious about that statement. The LPC32xx reference manual does
document a number of registers related to selecting which peripheral gets t=
o
control which shared pins. It's described in chapter 33. Specifically, the
P_MUX_*, P0_MUX_*, P1_MUX_*, P2_MUX_*, and P3_MUX_* registers.

I note that these registers are defined in the kernel, but it doesn't appea=
r
that any drivers are written to actually make use of them. I think this mig=
ht
be part of the problem that Trevor was hitting when he was working on this.
Since neither the kernel nor U-Boot ever attempt to set the bits that would
need to be set in order to give the SCU control of these pins, and we know
that our stage1 bootloader was previously also leaving these bits cleared,
it's reasonable to conclude that the SCU wouldn't be able to access them.

We are working on a change that directly set the P*_MUX_* registers to
appropriate values for use by the SCU, but I think the more appropriate
approach would be to figure out a way to map these registers into a
proper pinmux driver.

> Best wishes,
> Vladimir

Regards,
Luke
This communication, including any attached documentation, is intended only =
for the person or entity to which it is addressed, and may contain confiden=
tial, personal, and/or privileged information. Any unauthorized disclosure,=
 copying, or taking action on the contents is strictly prohibited. If you h=
ave received this message in error, please contact us immediately so we may=
 correct our records. Please then delete or destroy the original transmissi=
on and any subsequent reply. Thank you.
