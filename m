Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414557B4E6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiGTKyX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiGTKyV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 06:54:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A41B6D559;
        Wed, 20 Jul 2022 03:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu56m3af7uWauziPyxkALKaQE0EPaR+H4MdpbkIhzI+Mtb01BMAP9GqyoJ0cw4AEoyKZWtPtAkxO3i0xDa3fHh1aRpYJ4NQevtCAOxx3CH3Y3tKZIlAHky0UsOqm+kZNnjJpS35ePvFNsfYRtrD2MjD0jzY0BDzPAEM3PtvSn+y3XWnxJpOfjPb9z/kfoH90HYw3OteZH2NdgqJwO2hPQgGF/KK3RBkp1iuuKEn2GKQaRfoF4eYHhkhJYDBPfvinX8CbQUsoKjIalidn/d+868p8bdbD50OLvCEmzo+AwxHss2kMYIB3paIvmUofwe5bL1E73si8ZtRy7PQpSfWrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZZlcXb8JG12KFNn/YJJIAPKnIQxOo9F0wvz/bDqbIY=;
 b=MlCChZBcInKpkh7hjGm3eyA8sLUltM9/NUOzmjDquz4GmLRyxslWBuA6XQQrSljs/bajB4cD7+412YraQJPko4pmM71rJ/svzdiDKM+QIYTYYa3hoUDmD/8U9JseTJ6Nrp/qC+jTcf+PJHifphUbSuymULtJermPCnI0SM/mroYCnuoAI6qDH1sBMvEUOn58IWGu0bmjkBZ+osGVVCRQOM30M9sbmbC+Iv1DXRZJqNcI1vXqzFDChIIEv3eF2igHqF8mh0F88f7cpYKqPnoRLbXhTVQ6sKATzjKWldW5tOMyRs4dtv5MY/VnqilamrzTSl0FCaRVBVdg9p7syfJbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZZlcXb8JG12KFNn/YJJIAPKnIQxOo9F0wvz/bDqbIY=;
 b=fOOFHFnxLE9BdGL4ydS6NtH4M82DPFuFFoSOGMRytOCG80LWzsLsIFy/e2rV/7cIt8ubSp/AZlzXuz8+w67arZYLGkfAWU6bKUy/3ruD+JfF/GhuvIeJATHSBwGBh8pny7u0kbYGu3aEQBysaD8e1Ql6D7txsXGxd6sbY3PVig8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4834.jpnprd01.prod.outlook.com (2603:1096:604:6d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 10:54:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 10:54:10 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Topic: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Index: AQHYmSpFDIO6jbtkAU6yW6fT0KKX0K2FW9cAgAAB/jCAAAZhAIAAK6zggAEqbgCAAABdIIAAXF8AgAAAQiA=
Date:   Wed, 20 Jul 2022 10:54:10 +0000
Message-ID: <OS0PR01MB59225A3C2B0A891068DAF390868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
 <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
 <OS0PR01MB59220A67C039CCBF7D4D4AFE868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YteNFrNSsEfLDHR/@matsya>
 <OS0PR01MB592241E22FCEA9084FAAD24C868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Ytfa4NYhLGASHxk7@matsya>
In-Reply-To: <Ytfa4NYhLGASHxk7@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba7dd1ea-793d-43f4-e1f6-08da6a3e2d3f
x-ms-traffictypediagnostic: OSAPR01MB4834:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtY6R1/bD5QMuVeuaQthHY/PuSW0pBPECN3/W+OilrzBhLT/T6B72Efw4xe9pXo2umA6O0J7bgsWy0/i5geUNVoBT2rzcn4By8memPVIyk1gkp+usPNfI3Kea/JZd8waHi7e6qgJzF0S84Yq5bGLfoNI3mZQWeVb/+kNp1Y/v8hk5dNj/HUc3gkGtYfcSBu+gjqWtID7ZPG7JV5I/DzvckniUnZVUw7AmJadrQtZgDWr00o+31c26AAkjCL47zXV8PwYn4MBtE/YgQFnDq/aF46wZSHB/HGXGoGhWUoGhnBf1UhYGvXRm8z0OmuGm5RSm+C9Pb1rJLbj/fFTp/hRv/vgZQUQvAYnffJRhDj05Yh7JdAqNSuGi2VweJBiY2a0EpEH2ai5mM8MxhgRXoviVt1cmczd2GAeVPSTGTZDMGlw6rTPY2znP5FktD87iDuxMx+qF4zeDu/2nUkyPS0OH9vi5gQ8OgQHbGFmYSM5RFZl4Zv8j8ixxXJtqG+DLAvVmcVv/On+GHHlW3Jd0yBH4nXFY/bR1RZZpnd246MnjhNmV1Cn2g70xGKxN41nwS6xbvdoAySThpFfDINXMz/vBvmQ/Frh3x/eimfoXCHpKB7uicW57mA8TVtmvRVXEDTLJ2rcZ+R6UXG94H+1KRR+WahQZsPWdORfxJsTlmC3X1y24iO9zwC6QlSx3vFyhRg+AnFf6v5+e1ITqh0KQvKN8wZ18hEXEKHBDeA+n8ZOTPDKbksQvnZ6XN6qJOOwUylJ9RVyGDhl1MCJeVdmWM1c6ktzbztmK6W64UeGpF6Dtd0Qm/ATHT6/LDy0tDe7IjFSbhAb2Kw0fuE5ALaNu2sbW+S4VyFfI+njhuJ5dLmws6AXQA1P3xIIc9S4N4xPVNI2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(186003)(86362001)(38070700005)(6916009)(54906003)(316002)(9686003)(38100700002)(66446008)(107886003)(66946007)(478600001)(66556008)(4326008)(64756008)(122000001)(55016003)(71200400001)(76116006)(8676002)(83380400001)(966005)(53546011)(66476007)(26005)(6506007)(41300700001)(7696005)(52536014)(2906002)(5660300002)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1Iost1amtmXcsjTkuJ2Va36h5FYuBX0PES+2WGdPvYBN4j4WTp0YTku29kq?=
 =?us-ascii?Q?W8t1ggOL0eesfj4WZx6V6vQmLynyaSu4jR/K5jzmSYutyh2+HuDQUbAxpfjb?=
 =?us-ascii?Q?TsPNB6W2S678DcD+PsFwUjXud2DYBcOmfQnx3D5gg9I2Yxj173wisfhx8EAO?=
 =?us-ascii?Q?7QhF8Zg+yB1bzChmqdib3VMKj8/J2TI0tUJCAYgH2aJAwmufBhsJDbpPhSJv?=
 =?us-ascii?Q?NQ7CWWeb9+uDhmIAkSrRTVZxS85OpfxILLuVOqxkIeeT8AnmK5XQUN7QXBQ5?=
 =?us-ascii?Q?Pfs3IJyWv/y1142JfD1+gYO6wzMr0zQOhj7NUrZMqPMx41WGq7M35WmgAbep?=
 =?us-ascii?Q?wK5tixGsQy7fVoBAbg0c6hm9Ria4YimiGHoia74e0nkthtbt6ek01mPIvcZg?=
 =?us-ascii?Q?Uu1eApLT42RkYy2CtnqQORNX6ymtRXWhw/Owah6r03FYDeSyigolJe/RXxGF?=
 =?us-ascii?Q?xBeA9v6T38Ln8R6XprOi396lbHlUKgjtmYtym7G4bqn8+ZyAB0zpP0ccR1L5?=
 =?us-ascii?Q?lf9P6kSuJBG3pclByTEsNMfY/OLQ2GayZ6bp5s2TwoJZWhk3FWY09O+0dWSl?=
 =?us-ascii?Q?1P5fXdwxyoDGEpVQK+k1Li+FUT7TGXFd4gSC0rk3zKRB1xuh/FpZumKbtUuT?=
 =?us-ascii?Q?j+iIHY9z4811WdMY5D/wSZl5Sdbqu05pJiREaWXZgFO69r+GC/7cwT/C7jDD?=
 =?us-ascii?Q?/IhmzqRzXX9lzO0W5+ATrAmr2k6eI2gRRpcg8UZX8Bj+Kqpc3jznVdpfKqD9?=
 =?us-ascii?Q?TiY+ObeEqj1aAGxDNsRc74YRDYouizyBZbHjj+qYk2pw/gR279aLFtw3XHmz?=
 =?us-ascii?Q?MqY6Z1syOzVWEv6sxLVP0qNgOQ8fVLRQm/bXYc+HPd4SkzS9nDide0VFaeWu?=
 =?us-ascii?Q?UKBh0V/FWIqhB3gtDSXgKAeQK3byk8zaoCqg3M1F0YmBBA4iLAmwf4hPj3u7?=
 =?us-ascii?Q?nkfNr+cJEGsBbEPT5JtRbwSvGulbB3HIB4bbsKJI44EB0H6CNw6hRIi9drz6?=
 =?us-ascii?Q?5z1DbNT8jYcB1OwuY8GvJShWXw5Twz5Rm5EP4Fn3TZvRFGTV0FcCMw7TfGbv?=
 =?us-ascii?Q?MMKACnFU2S58vaA82PhCOzKcxLhlNRavFB02aNYxECYOjTnnvFzqXTzenx8U?=
 =?us-ascii?Q?UOjaPcOmPag4NdbnBIeiFitfleNOdYp/uoeTINWt5mW/0Wp2jxj+O0kTlpJG?=
 =?us-ascii?Q?S6s1IZje/b6fEL90rn1zw8Zxm7gRISx5S8Kd3QUx1al6p8Y3kdjSgH/rGC1P?=
 =?us-ascii?Q?gPiiVdao84SiJjSJSY30hFUG3Ha1pRKlVy9lGoDPBvl7WTqcWkUrtLbxTgta?=
 =?us-ascii?Q?HBYxt9kHK8FrHEdRmunWiNVSjuo/1qfkcstJ9mwDM3urMLSDwd/yVgltFfNy?=
 =?us-ascii?Q?cbr4qpgbjRwvAiy6sBG7hM1EfkgXd3CkqdWfLiCpJw/a7Nxdx5wpsLSWS68S?=
 =?us-ascii?Q?wG7aCz9Qis7fVSQ+dcPVAkTu4E0adH54+CXUkuG6FJiL79wRyRyar9Fd7hRK?=
 =?us-ascii?Q?h8w54+NUT83P1lOGgRjfZfQRLKAP/IAvllLWsJJ6+Hyws/kpHqhLkDId9zyJ?=
 =?us-ascii?Q?MEr1n9B5YPq5U16Y2/DvPHcXxNa75GkQTa6nraxD6abWTYkCUCxxUqJ3jwsB?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7dd1ea-793d-43f4-e1f6-08da6a3e2d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 10:54:10.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLLIxTu7EdyEOH8ZI6L5yUS1fJAGehl+NCliZiOgBXLMSu6aUEC0T/Q0043sPOTCBi3WmuGZ7wFVFLEAjp1KF2ND5EBwkElJx/0jmV1MRZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4834
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vinod,

> Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
>=20
> On 20-07-22, 05:13, Biju Das wrote:
> > Hi Vinod,
> >
> > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > spi_ops
> > >
> > > On 19-07-22, 11:28, Biju Das wrote:
> > > > Hi Geert,
> > > >
> > > > +Vinod
> > > >
> > > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > > > spi_ops
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Tue, Jul 19, 2022 at 10:29 AM Biju Das
> > > > > <biju.das.jz@bp.renesas.com>
> > > > > wrote:
> > > > > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable
> > > > > > > to spi_ops On Sat, Jul 16, 2022 at 5:39 PM Biju Das
> > > > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > > On RZ/G2L SoCs switching from DMA to interrupt mode,
> > > > > > > > causes timeout issue as we are not getting Rx interrupt
> > > > > > > > even though SPRF bit is set in the status register.
> > > > > > > >
> > > > > > > > But there is no issue if we don't switch between interrupt
> > > > > > > > to DMA mode or vice versa.
> > > > > > > >
> > > > > > > > Performance comparison between interrupt and DMA mode on
> > > > > > > > RZ/Five SMARC platform connected to a display module shows
> > > > > > > > that performance and CPU utilization is much better with
> > > > > > > > DMA mode compared to interrupt mode
> > > > > > > > (1->65 fps) and (98->8%).
> > > > > > > >
> > > > > > > > This patch introduces a variable force_dma to avoid
> > > > > > > > switching between DMA to interrupt mode for RZ platforms.
> > >
> > > Why do you need a variable for that, if DMA is availble (you were
> > > able to allocate channels) then use DMA, otherwise fall back to PIO..
> >
> > I was using DMA. We are not getting rspi interrupts after the DMA to
> > PIO switch because of [1]. ie, we are not clearing DMAR in DMA driver
> > and interrupt requests to the interrupt controller are masked.
> >
> > [1]
> >
> > >
> > > Or anything missing from context which I am not aware of?
> >
> > After this discussion, I have posted [1] and [2] to fix this issue.
> >
> > [2]
>=20
> Thanks for the explanation Biju. But why do we need .force_dma flag?

It is not required. This patch is not valid anymore.

Initially I met with an issue(PIO fallback does not work). So posted this p=
atch to make all transfer DMA by using .force_dma flag.

Then Mark suggested that we should find the root cause. After that, Geert m=
entioned=20
we are not clearing DMARS, that is the reason for interrupt miss.

During DMA prepare, we set RSPI DMARS and signal is set for DMA transfer re=
quest signal
and it masks rspi interrupts. When we do PIO mode, still DMARS is set, and =
we won't get rspi
interrupt.

The new patches which I posted[1] and [2] clears DMARS in dmaengine_synchro=
nize() in dma callback
after synchronizing with wait_event and PIO fallback works as expected.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022071915=
0000.383722-1-biju.das.jz@bp.renesas.com/
[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022071915=
0000.383722-2-biju.das.jz@bp.renesas.com/

Cheers,
Biju

