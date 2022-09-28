Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697735EDB71
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiI1LNf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiI1LNT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 07:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C957F393B
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 04:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F292661E34
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 11:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50942C433D6;
        Wed, 28 Sep 2022 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664363414;
        bh=AxwFO3eI0SKs+m+z4E30pjqL8CDnWCafrRero3qlHkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEA6Vb5vMbrNnBdY3xGiNg0J/1u8XlrXNZybHmcHxy0GkzMDBsFBFmMCElmn7M70e
         +XKsbAmBTO8P7kzlhSMOIyRp/oI9wzZDK89XNl+IQ92Ls10ulbeZmbRPcLKbGEldHv
         ZnAE9jZ8etjUzrvfJ00b0GW+5SSiZfpgmjeq0gtOK7szkbVip8zLdto+iU2f2uJPw5
         shqYUGV0RgvgsOUtoPiA7uTYDXk4ZlUYK6FIPS84uv5B9hLa7IUvyHyiM3On+Yy3bG
         gtZPvpydypyPSZqEIqU+SQlIzhtpFkpLFsHf7GBeGkhTawoFCkVwiwfulvZ21UUfV7
         P313IWhECibng==
Date:   Wed, 28 Sep 2022 12:10:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzQrkLAhvBUM1Vse@sirena.org.uk>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de>
 <YzNbhPjn27cWHwyi@sirena.org.uk>
 <f544de9f-2a57-fe59-79b1-f39857bb8d14@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5PLtx5pcWVmtajCW"
Content-Disposition: inline
In-Reply-To: <f544de9f-2a57-fe59-79b1-f39857bb8d14@huawei.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5PLtx5pcWVmtajCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 02:34:17PM +0800, Yang Yingliang wrote:
> On 2022/9/28 4:22, Mark Brown wrote:

> > Sure, but since the current wrappers use the legacy names this means
> > that we need new wrappers with more modern names hence there is
> > something to improve here.

> How about using primary/secondary, introduce two wrappers like this:

That's not going to be clear enough I think. =20

--5PLtx5pcWVmtajCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0K5AACgkQJNaLcl1U
h9A7GAf+PII65J2JmmL/OsD3d3gmeDrsCnnIWkhka53JOxGXRABeiEn+WmC/1mt+
ruyalS7fNT/WxHSyOkUJCSPBstd5Y5Cwtdne3od0aqpUx4YsUwW/lofjLuBGQHZZ
WohyP6SYLz4AuP8KRGOgbJ7wMnkddK++CRWSItRdwLd43/RYxOVZCWa4j0Ym+SMf
GLUwGHZRotYJYmEvvO8ohyBj+y45GsGUHDOVp5Rp8lOBOCOUIRPr5ML1YyZF5OZb
ICrEZT0xxr9XwCyeTfGeeLaN1E7/nd4+L4Hd7GCaVNqFnYYrt2hcjcPSAGpczk6d
PWxF4NEDxh3VRiClaWifD8hXCFitnQ==
=iEXi
-----END PGP SIGNATURE-----

--5PLtx5pcWVmtajCW--
