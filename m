Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB85BFE0B
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIUMiC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIUMiB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 08:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0A979E8
        for <linux-spi@vger.kernel.org>; Wed, 21 Sep 2022 05:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AD2862AD0
        for <linux-spi@vger.kernel.org>; Wed, 21 Sep 2022 12:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D26C433B5;
        Wed, 21 Sep 2022 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663763877;
        bh=np5mzihrlgVs+QurAhDwpeoapFor60h+7Qxw9ihpSkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nm1UsPrw0OqrGKrzWYFzJSE0VeYVUpLcS9GybAv+0L48nzzka9y4ouNfszTbSzUlT
         u3cVSEKPUMO/t2X0zlaKce3QoiyaN5uNTMiLSIQXdQsy7kinUUgV0uRaxpZBWiZJe2
         C1e2GK2plmQeoBjFwzoJ97IrTvueEgJ3z/FgQx7/D1+F8apT5yt2Kwis6rMbFJu1W8
         A8yckK5T0eLAdA1FHMDWvEkcx7kouCpesFaATmzuMf4n/rOz46BNwFULEiBRueRzSY
         RU1XBBX1O8HG71Y+cKF9lwnOW8KCwVyyWPAAJp1Q4WxVMHEl4N6AmWaryCIDbLP089
         Z6d8FfCIE5Ncg==
Date:   Wed, 21 Sep 2022 13:37:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
Message-ID: <YysEH6MwNc8naD27@sirena.org.uk>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <YyoHjY14hSJj85oP@sirena.org.uk>
 <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRPrekPg50lb7NiW"
Content-Disposition: inline
In-Reply-To: <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QRPrekPg50lb7NiW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 10:02:25AM +0800, Yang Yingliang wrote:
> On 2022/9/21 2:33, Mark Brown wrote:

> > If we're switching please update to the modern naming and use
> > "controller" rather than the old name.

> Do you mean to use spi_controller instead of spi_master? Something like
> this:
> 'struct spi_controller * ctlr =3D devm_spi_alloc_master();'

Or just use devm_spi_alloc_controller() directly.

> Dose spi_master_get_devdata()=A0 need be changed to
> spi_controller_get_devdata() ?

Ideally.

--QRPrekPg50lb7NiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMrBZwACgkQJNaLcl1U
h9DxNgf/VBILdrO859T2gNXYTK5p9d9B28JTg5bTgl1hfSyIDWcMj4J4Sq347f1M
kDqD9H4EvThQR9INj0O3e6N4UBdjXSXdZXhA3W1Yy7+Apbonh740XbzVtfR9ECBY
19s6CjQmzOavD3U3CBXBUJoUQUxj3vdLfBFjeIWJ5/0vVMXADxtogy8unYCD7Sc3
gLCLhl7dzs1V3X3n+TAan6e0cvuqx8fmfP3anE0s6uTk8o/aTY/lXW83/dj1FP6W
oIv1ziLSyt+WeeB1K1LyyLh+GGzzdhq9H4qCKPL4mn12G9ned9VInLTqyHstqQND
cs774TjFA2rQmwKskm+tCPPi76BRIg==
=oNhT
-----END PGP SIGNATURE-----

--QRPrekPg50lb7NiW--
