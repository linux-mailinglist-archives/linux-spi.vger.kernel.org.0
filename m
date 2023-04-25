Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2C6EE11C
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjDYLeP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 07:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjDYLeO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 07:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E077A3C0A
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 04:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC09616F7
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 11:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE8CC433EF;
        Tue, 25 Apr 2023 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682422452;
        bh=BJECKTyL4M0Q6VTSvs6CkudlFlee1snqVlvV5ucEI/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4l6QPNslNTUfSlUfVLsTkT5Ed6r/OjfvlOzt70L0ex7HbzcHPcLTdvVJYZPH6Apg
         J1/LoR8yxeBxy/3r98i6yDHGyYizSKfkqIj1IqcknN+pRfQgyrlZcMtQY8xg87PeGs
         AGHAMgHfYGopPbS3DrqOdpoVPIT6we3Mdm4TwN45NAjAw+LIDkyaVU/T/Vxq6TSvVs
         P8kLk+2RoyujIA0BDt3geud8fRP+AixgpapfPn/GhwOA/KdyjcfTJ2/5J03b0IgfUH
         hW/akWMYDCYG2HEe4uBhDOxBz5Q8h//tu8+ku3eWuW6CLN7jzBAr+gFm33AWz1H30j
         zhEFaZ7r7Hyag==
Date:   Tue, 25 Apr 2023 12:34:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     qianfan <qianfanguijin@163.com>
Cc:     linux-sunxi@lists.linux.dev, linux-spi@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] drivers: spi: sunxi: Enable irq after the initialization
 is done
Message-ID: <48647774-e612-4084-a8d9-b82c53bb939a@sirena.org.uk>
References: <20230423023056.27929-1-qianfanguijin@163.com>
 <2fe1f98b-9126-4245-bce9-d8fbb3da9ba8@sirena.org.uk>
 <7cadd411-77a5-17d6-a145-54b01b0d0eee@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FDg1qXk4zXHJ6hzq"
Content-Disposition: inline
In-Reply-To: <7cadd411-77a5-17d6-a145-54b01b0d0eee@163.com>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FDg1qXk4zXHJ6hzq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 08:22:16AM +0800, qianfan wrote:
> =E5=9C=A8 2023/4/24 19:46, Mark Brown =E5=86=99=E9=81=93:
> > On Sun, Apr 23, 2023 at 10:30:56AM +0800, qianfanguijin@163.com wrote:

> > > +	enable_irq(irq);

> > The usual approach would be to move the requesting of the interrupt
> > later.  Why do this instead?

> Nothing special, this way does not change the goto logic.

It would be better to restructure the code, enable_irq() is a fairly
specialist function and should only be used if it is really needed -
it's a big warning sign to see it used.

--FDg1qXk4zXHJ6hzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRHuq4ACgkQJNaLcl1U
h9DZKwf/b6ukY3n/bvqLzNA1/ZGr4Kom9cl1IAcpOdfvcqqjNGdKe1MaWDPq5O04
iYDpB7+VJ0DjJwVgW5YdduvepDzhpHKVgHi+a4lXGmP3dmtUukSg4rAjLP4wUO32
2BArzrhXNeKolNJAvgj42sThiWVvaNhW2OowANbmFBuN92tqHqazxeJSE1up1yF/
2/wBQM1de7WzMlQQp43gNVRjFCfxyzP0F0wqTz686qiKjLF+JHBEffn5HKiBbqFW
ckV8SGsOi+vPIFfgQx+U/pnTguT9OgWnlrhgRdS1S32S/cjezVi6BpYpub2q0VIC
K4jEr8EzWEK1kgNZTel5imd4tYXcYA==
=mMoT
-----END PGP SIGNATURE-----

--FDg1qXk4zXHJ6hzq--
