Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B74D074C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiCGTKb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 14:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbiCGTK0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 14:10:26 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2134.outbound.protection.outlook.com [40.107.114.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3022B22;
        Mon,  7 Mar 2022 11:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M39P2pUxhfLSZ1UlSd+40gsz3YHQTZB4/iprVXey4rlOAuLHRMom7ZfocPlK/ushOTdz+lQVYitymroRZHkj2KcGRZT0vtjx7hXPAOlkqgRtY+yyx2+nl4bWtxWB/r3nrUUBzHKZGAet/WELs1T5xnnLHCpdnPrS679RY7/WCIkdWiJzpli0VXGAk5uHvIRBytC2HaB0AIG0+awWNTVu2HWmsd+2cyrwco4ECLOh5fK6Cdb6t7/61Da6dJsY3A0WrJijbvLeOCVb/W8MNkB+jRrQJMn0ROnyeUJswnjimzfCulJrqI1lq6xBv/5YvWkK165PJHcbRJzbLCNs3YZs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2X74ISkGxCqq239YqutJDmWX1x5xPJFCFklK4tnZw4=;
 b=Mi8R2rie1esFBpOCD/NNstorrPqKT51uiaAmtXkG1QL/5nBFM0M96h07yv7SK/4aWD9IwUDGkN0o/W8kZHhUG7zgKg+xQ+kNX3VdVogwWm9MouJ6uyonbMjqEwUKYCVJgBkj/mtg3Jbc040My+DUvVNYgXKKiXUfJVH9JU1xzfN3AA+Jj/cKKFo6PrlEdmAVMJ0mrt19u/DNph9KvMdHD1ML2LSk+yjyOdzp+y2ti2sczk0W0udmmiWCApHuy8L2YKc/7scDlml9qXdnrwdhbz+tyLyYBMomQ9CqDE4KFtAGW+rbO4fst7sZj8FCiuxQqpXdasqh/svbXPTIWHsBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2X74ISkGxCqq239YqutJDmWX1x5xPJFCFklK4tnZw4=;
 b=k/T3tyo/CmjYedMa9YxguR5/zqW5NqwaaGn9Zj748z2n92W/48siyq0g+pf/yQ6fuiiNnGzB5LS8ZkdfFFjDHjOoG5eKuPKn21wAV2Eu2MCOWdnVVbYV2wFtvQFi5wq8czWLDdQbpQV+vr6VKU0mt+VKxiRNx1U19jZCb2H9GU8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYXPR01MB1597.jpnprd01.prod.outlook.com (2603:1096:403:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 19:09:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500%4]) with mapi id 15.20.5038.023; Mon, 7 Mar 2022
 19:09:29 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] spi: Fix invalid sgs value
Thread-Topic: [PATCH] spi: Fix invalid sgs value
Thread-Index: AQHYMk1bt5E5wl7NDk+Lte/agSpjXqy0N7sAgAACUqCAAAFAgIAADZJA
Date:   Mon, 7 Mar 2022 19:09:29 +0000
Message-ID: <OS0PR01MB5922561CD3A84433D8BDCAF986089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
 <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YiZMz+jrYS9xUzx4@sirena.org.uk>
In-Reply-To: <YiZMz+jrYS9xUzx4@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c4e566d-a864-4d0e-4d1e-08da006e0140
x-ms-traffictypediagnostic: TYXPR01MB1597:EE_
x-microsoft-antispam-prvs: <TYXPR01MB1597DCEF5D72FB5D707DD57F86089@TYXPR01MB1597.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dk1OBvGx/im8GpPgCae4fqmb6s9wn2iWM/BbAJiKlt3u9qWhaMSyhfXF/O7r7Jg260AP8OKH7nX0kXpwRIPy7Xj8FrIX6gXhJtPxSagrHZnLgR+uyLZHAXl99tc6FtP9a7T87Wx9NvmhDmmGWp3bKT320EVz4we0ACIx5h/Lz70zxXA6++p1Tw9O+1h468TZdLCm2U98L0kyXqjDTp4OlMYmfoTRdoqiTCyriNXXBeciWbHdBDwWJYriCl6kiT2JlxCBLIgZVWCgfkO4TbZ9ABxeDpM+52Fw0pRI10gQ38lCg8QrIpst8hLiv6r2Gump6AjJ7JGPFAX/XoJT3hhaVdHTehyAo7xjvpVHIPH5U985kliEfualu3sTMtQbMi5KsY6IZsoq9bLoRRzFDYpA3EIx9qWUISeIkcpXjHaNwlswq7z8RWiwitHs83IgmxGc+vqbznt4V1zsZPBKC7zI7m7MeRNW6xGc15/H2c8UUIRpRoUQBnahEm4bBVrynSGowuN6sgvEEt9GTKSo0gMYX1rdgLygus2c997ATZc+y8MNU6N+kfSHb73yfxVecGUSPoyoiyxatBXtpCPDWMN2b5QgGbRuFuukDCBgQGrYg4oZ+J/w/AFMfEQeWUkDX6HVGkyct5CNq79FIsySn3aY7g1CczOb4VQs1GqegasT99Nwx8Be8AHUsuwU6AxUx/GCJv3zaZYR8Gcrpiik2HVKAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(38070700005)(316002)(55016003)(5660300002)(7696005)(52536014)(83380400001)(86362001)(6506007)(8936002)(4326008)(76116006)(66446008)(64756008)(66556008)(8676002)(66946007)(54906003)(6916009)(9686003)(38100700002)(66476007)(508600001)(2906002)(4744005)(26005)(186003)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0QHuZOVk9PGXBq2YQIROqSAMDg1zfLgj+DMfOP9Y4uEm4lMTFOooteelzK+?=
 =?us-ascii?Q?fosYEF6sP1sk2GLNqkyvvVkW0DqFkIzXoIeekU3q9Hm4d1LRghPiKvnryAOg?=
 =?us-ascii?Q?tVUic+h1eyYPBOLXaSn1Xcs2+aZpOCDlg6b6Ulp22ZftuggXucz83nCUm9BW?=
 =?us-ascii?Q?+ogiL515YTBA6shKnHSeUhMM4Hr7rlvK8s2MjbyICNtamOP7Ey8esaYzWDLI?=
 =?us-ascii?Q?w2JUrj0rtxdx3FOCx0tbF6JysuOgGsfvC14omSOhCCzqwOfUYnuQWkBHs+EF?=
 =?us-ascii?Q?plAO17kcXmryCTHC+pxYy5pMiwiSAp18R7v3bdUgkRlr/CWgoyY0AYq+KAL1?=
 =?us-ascii?Q?shwQm/NbVXjv6u4unKzhEp+DaUcKkWxd2fCKKxpCK16ql0N6EALYpfzSTSYO?=
 =?us-ascii?Q?wGWTIbfX9z/1pDlGHAmccjCmW14eCPtQcwjrZ1ID5iwJM0/P+QhHvg5cLxii?=
 =?us-ascii?Q?ooWbh0cH13piQ6vwnXSdR7ZVwS4Ontfs9IdAtrgHB7I2qzlFAkLLRxyhXQ6+?=
 =?us-ascii?Q?V6a/wMZGw9CTdO7xy+bWiJD5LyDR8/UfkTFqgUnXf8fUaHrPX8wKrin45vmm?=
 =?us-ascii?Q?V9r74bjqArhHhoerIRVVY1FboXYjgRtxTc1or73iuHUGZNpFUPCsSoF5Ctgs?=
 =?us-ascii?Q?aDCuW99jl8gEd6PwK05N4kR7KzWBVUacrmzkPPGXitlv9Am0JlybObbRxwFM?=
 =?us-ascii?Q?MI165RtF1uQ0Iui392WyYiDPCiG70Nn0bOOdhvTSPFJZMpsa5CXn5yBn2+Gj?=
 =?us-ascii?Q?OAoa7eWg8CL+qhhJXgOAcaO+ILDEAgfU+GmddfRdRVwHPAkKxxsxCDP+ewTO?=
 =?us-ascii?Q?afdRqSlbB5ei9vTcvBSk+tL4Nu5PIRZuUq66p8iGFUd6gvKV7Vn3hHt7azk+?=
 =?us-ascii?Q?4th1js7xyJXKeGjjQKr0iR4HBQ35IMOcCVRAuAgQdaGDADNx/hagq6pnZtls?=
 =?us-ascii?Q?YM6r3iuIryqkDFK/0r+mNGsNur7a10V5oNahMH3ivqWqZmna75glzx61aSY+?=
 =?us-ascii?Q?pgTjjre7N3uF1N00FWD/f8LxNvTTL2Bg/mVjdyIjuibtO8IKBmyTI2RBBIZM?=
 =?us-ascii?Q?ntJEf+asgVoKRZnOm7+Hb/MMih7TjgdtGxdM9tmBLd5R1DYGnPiGQKR0hY3F?=
 =?us-ascii?Q?XbQQBta1T/9bwS5QpU8AVsclAzrMrzwkm2/n74aL4ROJBKbDA9D4cVPT/JY8?=
 =?us-ascii?Q?JNufwzMHRTs5Wkk0pyTYc1arVIku/1FKa1G4aVqYk3YofHeWxY5IgD4I6QiR?=
 =?us-ascii?Q?dd0ltg7ixkaO1VLcHUJtDxBWVomzmo6s9pUyLIpS186gejBb9vsFgtnfPAWP?=
 =?us-ascii?Q?6+6HEo8DjebUSGmDvUlELrv4IhVBSh+a54ideEbax/Y+alj+WXNysld97A73?=
 =?us-ascii?Q?tUT7hqj9F0BEac0q5jvROhCcJBwrZVCX8nytVI8ETEOHxqrWr6qAIRbLGD3m?=
 =?us-ascii?Q?LyS232qMbM1sf4PxmxzjBwLEiYu2OyO7axGjMwyW6cmIYF7EUc7xDX/qL91Q?=
 =?us-ascii?Q?5ROMA6LusbMQpwq8Nj6rteD/WmUAiwlNm0VW8pozzVjV64JGgxZ4v+R7X59y?=
 =?us-ascii?Q?tuDDgiKkEYtPpAClzV+BAscyc6xcyES7B5z+sPHubgnVTmYNElNyDQoMoxgH?=
 =?us-ascii?Q?5MP13fDJ51cvU2vBYFhamGaql6dz8395gir/+4Y8PgWB7DF1u0zkoj5/WkLP?=
 =?us-ascii?Q?Oo3XkQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e566d-a864-4d0e-4d1e-08da006e0140
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 19:09:29.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlxgDt9r0VUKg2i/JN+HT/dbP4kFREW2+2b0QZytW+5vokVEUU2W1u6o/w1l51cvuL0E6kxqZ1mafvrYNdrR3ZvDTmXwraijAXzeMaQy4K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1597
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> Subject: Re: [PATCH] spi: Fix invalid sgs value
>=20
> On Mon, Mar 07, 2022 at 06:17:23PM +0000, Biju Das wrote:
>=20
> > > >         if (vmalloced_buf || kmap_buf) {
> > > > -               desc_len =3D min_t(int, max_seg_size, PAGE_SIZE);
> > > > +               desc_len =3D min_t(unsigned int, max_seg_size,
> > > > + PAGE_SIZE);
> > > >                 sgs =3D DIV_ROUND_UP(len + offset_in_page(buf),
> desc_len);
> > > >         } else if (virt_addr_valid(buf)) {
> > > > -               desc_len =3D min_t(int, max_seg_size, ctlr-
> >max_dma_len);
> > > > +               desc_len =3D min_t(unsigned int, max_seg_size,
> > > > + (unsigned int)ctlr->max_dma_len);
>=20
> > > The cast of the last parameter is not needed.
>=20
> > OK. I thought since last param is size_t, casting is required.
> > OK will drop this.
>=20
> In general unless you're getting a warning and are *very* clear on why
> what's being done is valid casts should be avoided.

Agreed.

Cheers,
Biju
