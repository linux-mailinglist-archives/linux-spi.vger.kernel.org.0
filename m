Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC3C57987B
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiGSL2o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSL2o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 07:28:44 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A340BC6;
        Tue, 19 Jul 2022 04:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE8NBg4XjYG7hKjx1BK/vOFZc8t70snUrIPorJDNY/wFsx7nMllJWI0pagRNQYlZdeSaOzZ775PeNINNNq9EQp/EysILCoAf+ZIpM9khPFVYQ+SfqDJj3ySlDSMvffePW/Gz3vPnQxk+dWaXPQEAmRjSrP0AVtKTdXImLKFwfh0W1Zak8Sx2MpnXvTyZ1YANncFVop2ibfz01mzAYEI3r2ayG2XsVGunmDxpqj75K5WQweKG09B1gcUNTiFYn79vWQ8gUcjTsgzSD1v6nlXdWrB49tcHRyWGrb6t8gnKbT2Woi1AchQyr3BiIGvosqmTBbN8xydeYxXHCVX/KkKq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngVbVpnzA3YbEtRMxac2ZrV9+giMpw6f0H8UxS2W5sA=;
 b=dKUIJUjkixvfRvgUeuv4dCW1cprnM7iR8z4kgrcA/pgvaLUKy9cLZ2G4AESTIUpeAqaou7pRv87i+K/MmDckzzG9BYqDmU2tiJqru6qByEfsqkw0edFMyKarRfKR/JsvU5eTJJZt2HOtEbGQYa2vAhZyaqFs0GcrvUd0DdygrVkGvtu7C7CsMiFSqc8SYWoU4cb50fGiMTjJlZugr4Skx6L5FAEtHVNX2sWpdgI1J0JIvfugz2MUtp732Hj6Zu8uvFo/6CdsKBgPkSXWms8PyEJaMmg+dd3BlX8tG8bnxlSpcqazEmfcnP6U8m4amJveqTAxrZPQ6XzfZIQRye1c1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngVbVpnzA3YbEtRMxac2ZrV9+giMpw6f0H8UxS2W5sA=;
 b=mr2MmBujDX4defH5lmLyZaqHp5PCe25S1G95mbpY3OkCLY6b9NqjmU0xdSRJsYiV6izzEx7vtF4BBbPQSKmiQNxmGeZv1wLs2RM4EeqfKD0UaR5Jb41L1aYQZnLXCwvnGI92cgcgpBKWGAkCerrlIvLt6A+pfSRRr9PZOnwQQrc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB2554.jpnprd01.prod.outlook.com (2603:1096:404:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 11:28:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 11:28:39 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Topic: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Index: AQHYmSpFDIO6jbtkAU6yW6fT0KKX0K2FW9cAgAAB/jCAAAZhAIAAK6zg
Date:   Tue, 19 Jul 2022 11:28:39 +0000
Message-ID: <OS0PR01MB59220A67C039CCBF7D4D4AFE868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
 <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d11be2e8-25cd-4c6c-63cc-08da6979d431
x-ms-traffictypediagnostic: TY2PR01MB2554:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kS27CNUiPWuKdDw/kdu0ltpRN/0BFwZCKb4aLy6Y+JQeIq7MU5DjqbiqgQv1Qtd6r05GKZRjx0Lp0cVP+1YYQGJieDjgeDLi5hGyMpWc5zWjI8Wk4gfYq4uuQIyuaOvV/fgIWXZCivf3rTdya+XDKWDZj5Na5cH1S2iaQJcHR+oM13udcobivQ7/gd82BPOXqgT87Gu45GEWxkvw4Vj3z0cJeC1MaZytLOCFLyp2MtgChwPJq1GpkUBn05o61KSrLNR4adHQEic2Q+eRF9t7aeKd34ixP2mvJMBM6qOaDeqwA0TLXE8tmch1NlNNCnNhEFysIHgkplbgdnwwfpL70zxnQTagTEUDq2tzTUdRRTret1d0bfTTtccJpGuAN4LCM90BM9sQTwXxUh3bEVIbpwAU2Wy6ES0bT6OuwNVkbKEhXFop9eqdb3Mmo5n3yGufI/++B4aRW2C6m6fIhGJF8GtpmySNdTbP14vFW3ICWFrcWlaz6R363dqzx5pU9Txr/glzGQZfgW5MqiDjA73nk38cuHnKzMj8JrbxgFrgoGYXcYJ1pgPa2RbolnkSw5P80MlpFTpGZ8V3jK6VZ/oROVWJF/Me60Ynqcb8AF8IrBgFqbE8ee50orlseb2z+yQd7+A8v4HbvLmATC/DXofuXH9CytdNVmhvpcsOJGNHMbhVgyUeNmK0mJilRzwnr5G7HtPNN8B7/Q49u8ku2KcdhDZdVKqVUz249uzRzZai/s/fbk9fNfWdsPSyi/Abmx1LqXEJjNz6pcAsuuiaoZ1PYD3RpmfnNPimPS3J0LOQgkbUuXTzUMyixkwZ1chmvsTi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(9686003)(41300700001)(186003)(55016003)(122000001)(86362001)(71200400001)(5660300002)(478600001)(26005)(2906002)(8676002)(66556008)(66446008)(66946007)(4326008)(64756008)(76116006)(38100700002)(8936002)(6916009)(33656002)(52536014)(54906003)(53546011)(316002)(7696005)(6506007)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CgmgF38ft6NiFGC4jkaj3nvro/9Aqq7HixJFRnbAkBWPfPM0wdj7jdlV3EBK?=
 =?us-ascii?Q?Hgp47hcnmYHz0DkD4VxuhgsY993TAc6EldN9obDm1KZIap+6ewlSJeLZmEPK?=
 =?us-ascii?Q?7Iwu/d0NkVif/VLfbixFQv0LZs4od69+b08TrFynbvxQnTxt6bLaotlHURRE?=
 =?us-ascii?Q?boFtLyQpDcD0CmF3XU8pVBKe9BHNRbejI6SjJaRO5pD9LuRRQKwHweCl8Ifr?=
 =?us-ascii?Q?DjJPDbEeXY9WOtidi5TBfUkzHHgyKv1Ea5w6IJw7KF+j3iFAgFDvqcAIJs0O?=
 =?us-ascii?Q?1iVVEFbKPTOizpMq5oDV64c3amhz0xCkgzQG3jz53KneA0eQkudGCJzu3LDS?=
 =?us-ascii?Q?SePeuD5cK16c0SeVSZ9+cnqCCJ+ZCUOEeN9Ps7sg7PquaZWDr3L88iG5e9R4?=
 =?us-ascii?Q?2BKUWvy1YN5rcn8qcHNCZp9hDvQhRwrUkuMlhbev3DupqEfyjx06fwliHmDb?=
 =?us-ascii?Q?RVaTQbkJmVkfWxreFtnnc5zEeMXqBDmkFb1GhckxJUct+DRKaBfOruIImwsK?=
 =?us-ascii?Q?TiNGH7djooBtPGt0AWFtih1PDF0tXjhOOGXU0lCzYTQ++GIwPqxZ6ZGbFLsN?=
 =?us-ascii?Q?U/ynwZtF6ZVUWXqOTPVTEsrFQgpfeNmSFaSJ6kXul1qi+bTelmIfDgW0BIZa?=
 =?us-ascii?Q?c/gLt6eCNjMl0dZviyOLhC0eCswMJvpq3UUIVOOMZqlnGjTuvy7V2jFiav9B?=
 =?us-ascii?Q?4elKUDAVdodpWsXkizJviVbxOwUF5Gh1JKcym5hMEkV2eJKwpV1oh3P1M7VS?=
 =?us-ascii?Q?ed+NF59wa32Ozy4k0wFv9/+mVqTQl/HLJRttGo60thxlwDiEs2OQXdPXzOMG?=
 =?us-ascii?Q?sLvUCi3nUJ9sgRObYC+BSikpfMdW2yZvtjmqOyfPCbKRvviUkmrEJoy6Xtbk?=
 =?us-ascii?Q?C+jlYSqBohK98R8vExxi9+urwQI55Qun88kkweq/d9IYErcGYjmvHz1Rg3qd?=
 =?us-ascii?Q?rHkvygE1vgLlUKOqivtHugSceSQi36lzCa4bBZfYcxB+vpvWE2cgj5wfnp0X?=
 =?us-ascii?Q?UVNYxDinC/BT0KJZ8wgp3pHmynxQP4BiYWVV38g+UiaLvUB0I/SQDrFe1Bak?=
 =?us-ascii?Q?vEv/8HoVXSGMBP4GCDOy02zSu1yBYXGOlcKkuYJCtOIRxgVBNDuG+5zDJEYd?=
 =?us-ascii?Q?t1N2n5cfxTdu7USWZH8pQQ8TwMcwg8KuTrnY9seklGclcTMusKFgBzytwKxU?=
 =?us-ascii?Q?ixstJF8CK7POVYCWerdkT7hdcGJHQ/MfTGUDdSaAxsCokKw/3TjN9LT2P39b?=
 =?us-ascii?Q?B0ihPHua3AW9+zAjSb7pmYvZEiDwiB8vfjrm+b2mBTtnod/KbLJun+wevKYg?=
 =?us-ascii?Q?xrFt09F+fS0uDkLKwgQPlJBehkXtshNxEjnYp4q0dIx51RtrgfbuhwQ+KvCN?=
 =?us-ascii?Q?IzfJ13JmyfbThaO2D2KX2gbdUwtx0mYLz9NjVbulUTWPwxLF6FEaem+DFRY/?=
 =?us-ascii?Q?CPdeH7nJ0SkRrsFWMSNg5t4O17Iej5PQMgqVtyotbu09CR/NvaN7fGQ7rDzg?=
 =?us-ascii?Q?ytk67l5cmWXt2DS4M+OKmFJaNj/89Dali2jGydhzKZC89o4+XomSTEILcU7s?=
 =?us-ascii?Q?T7/pNv+F1W155nTeV+ZNH7nT42HGUPN45/ZCpfIlfo3WLqyXj8v/t8iTiwH/?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11be2e8-25cd-4c6c-63cc-08da6979d431
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 11:28:39.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnOwBCtbJeEgaa8hfz4iMrt59svc0RZiBNYAIGPfR7Zy8CvWL5M2HuavoS5d2o2VwD2jYQUWJUK+0BHwMDaOSHmPakjwccMboKtEibE96RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2554
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

+Vinod

> Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
>=20
> Hi Biju,
>=20
> On Tue, Jul 19, 2022 at 10:29 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > spi_ops On Sat, Jul 16, 2022 at 5:39 PM Biju Das
> <biju.das.jz@bp.renesas.com> wrote:
> > > > On RZ/G2L SoCs switching from DMA to interrupt mode, causes
> > > > timeout issue as we are not getting Rx interrupt even though SPRF
> > > > bit is set in the status register.
> > > >
> > > > But there is no issue if we don't switch between interrupt to DMA
> > > > mode or vice versa.
> > > >
> > > > Performance comparison between interrupt and DMA mode on RZ/Five
> > > > SMARC platform connected to a display module shows that
> > > > performance and CPU utilization is much better with DMA mode
> > > > compared to interrupt mode
> > > > (1->65 fps) and (98->8%).
> > > >
> > > > This patch introduces a variable force_dma to avoid switching
> > > > between DMA to interrupt mode for RZ platforms.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > @@ -1196,6 +1197,7 @@ static const struct spi_ops rspi_rz_ops =3D {
> > > >         .flags =3D                SPI_CONTROLLER_MUST_RX |
> > > SPI_CONTROLLER_MUST_TX,
> > > >         .fifo_size =3D            8,      /* 8 for TX, 32 for RX */
> > > >         .num_hw_ss =3D            1,
> > > > +       .force_dma =3D            true,
> > > >  };
> > >
> > > Do you know if this is needed on RZ/A series, too?
> >
> > I guess it is needed?? I may be wrong. I got a link from Chris [1]. As
> > per this still We haven't found a solution. May be the priority is
> > changed for this activity and no one looked after this.
> >
> > [1]
>=20
> Daniel said he found the issue, i.e. the dmac driver never resetting DMAR=
S?

Currently DMARS set during prepare and it never cleared. So I added device_=
synchronize
callback in DMA driver to clear the DMARS. RSPI client driver after synchro=
nizing
DMA callback, calls dmaengine_synchronize which clears DMARS.

With this DMA to interrupt mode switching is working fine.

Cheers,
Biju


