Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF4D5EC1F9
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiI0L7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiI0L7g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 07:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296EA767C;
        Tue, 27 Sep 2022 04:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA684618A3;
        Tue, 27 Sep 2022 11:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0CBC433C1;
        Tue, 27 Sep 2022 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664279974;
        bh=nNaZ2uwzXtVL9imsBm5VYF7bk8vx/Y6VwBdujKGokcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+23zlwjWL6JKb+dyRA65oiV54i09OfcS80QRNvXv9OrfBq3eimLdxn+5CdYGK2ny
         enhOkWVqKBYC1QnaRWgTqbchIlrqk6nr2rC7gKfB5ADf2xUgSJ1akGvb/dvVtX5daW
         rejYTaYK4GJSGu6MIsQ6Rlbecbep9AdzZNEVxrzvLdtv3XsLt3hpVDSADf2vCtdCCB
         HhzcblDOeS68V37u4rWgjVSNETVPRFjjOAVxrxSBPxoUdtOaTT2PLrKZ62NDGGcEB+
         4MBPYqIDz0AWX70WxdzMxr3n+jiw8XOS3VzBfTJE3XXl890F5ff87xmZknz4qo2VP+
         9bcyKa1DJL1Uw==
Date:   Tue, 27 Sep 2022 12:59:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings
 to YAML
Message-ID: <YzLloE/AEdFiHsEj@sirena.org.uk>
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
 <YzLagn9/j0w4UymU@sirena.org.uk>
 <CAMhs-H8664babt9xwE-iCJNCdm+kues-c6V1iPwS63EtdWCV1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W7anHBPfj7xrPFu7"
Content-Disposition: inline
In-Reply-To: <CAMhs-H8664babt9xwE-iCJNCdm+kues-c6V1iPwS63EtdWCV1w@mail.gmail.com>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--W7anHBPfj7xrPFu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 01:36:04PM +0200, Sergio Paracuellos wrote:
> On Tue, Sep 27, 2022 at 1:12 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Sep 27, 2022 at 05:19:29AM +0200, Sergio Paracuellos wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.

> Since this is a binding migration change I sent the patch expecting
> this going into the devicetree kernel tree. So I just use the common
> device tree change style 'dt-bindings: spi: migrate mt7621 text
> bindings to YAML' as the subject. So I don't really understand what
> you mean above, sorry. What is wrong with this subject? I submitted
> this v3 [0] and I was told by Rob to resend it to you and the
> linux-spi mail list also.

Bindings mostly go through the subsystem rather than the DT tree.

--W7anHBPfj7xrPFu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMy5aAACgkQJNaLcl1U
h9Bv0Af+MriMXHEc8gmZoqCCPIRvO58TXJ/P7cwzGH+zIKbNCxHKOs4J4z2vtvTu
9KWQs2kXxYxLDi5hpmrJJQTuUGF7zphnEZmE5pp8HmxHgJaEAj2fIXLgWj6bFXiB
NUylKGkoL8mwvOpcQx4vLT4oqTIj0OUTP4gOVXD88rfgpg/5xKHQq4tEJT6E9Tqj
BGk2l0y/VxuOWiCES2YGiLV6LOa9kWkd7AeFAtxhkz3rKcoJKq142eMBACDwY57o
QbF6qOIbmUhi4I+WUc/tMThf3BhIWo8FxKe+zwT+Mm6dcqCBW/fZO5p3+soHZ42/
qOToIEr8omzPJXzN1o+Qako3LOR2Xw==
=2f4+
-----END PGP SIGNATURE-----

--W7anHBPfj7xrPFu7--
