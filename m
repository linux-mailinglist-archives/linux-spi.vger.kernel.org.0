Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145E6964AA
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 14:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjBNN11 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 08:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjBNN10 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 08:27:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F501172E
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 05:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0305BB81D5B
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 13:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D531C433EF;
        Tue, 14 Feb 2023 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676381242;
        bh=9JzYshRaa+cIH8tzSymHzUcmGldlEkHBn7oaHHknLFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdpBbGJSvaMnkXNaxo0t0PWkCZLW8v2/+o7bH38UqV0CvyHrx80guWudfflfwbm/L
         ykm8EI4yWGRDOvcYhDfT4StaB2YduK9MIZ+yE1KcMH3KFfBTlQreuBgALLGtX8n+ee
         4xSUDmVXxGc0hBC2vZG11u526ehdK7KKxxc+DgpyJwGO+LZdGOkGZHOXcIDaoj884j
         qYJCf33bOBEvUL4m/NeiY3iH+9aD9byTPlfyKQVQNj4sKhBA1PHNlVfz1sW0ocaRNk
         gIRZcC06YxWsjGXedHorhA/gkUGO9t3/G1UXlyG1WGyyuk+tcEqe1Z50ndpSJb6Np8
         6zNiOQjCbJ4Fg==
Date:   Tue, 14 Feb 2023 13:27:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vadim Fedorenko <vadfed@meta.com>
Cc:     Ricardo Ribalda <ribalda@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        linux-spi@vger.kernel.org,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH] spi: xilinx: add force_irq for QSPI mode
Message-ID: <Y+uMNxQmi5lg10CN@sirena.org.uk>
References: <20230209211321.1427968-1-vadfed@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zm41z8M/j1XJwFL3"
Content-Disposition: inline
In-Reply-To: <20230209211321.1427968-1-vadfed@meta.com>
X-Cookie: You will be run over by a beer truck.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Zm41z8M/j1XJwFL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 01:13:21PM -0800, Vadim Fedorenko wrote:
> Xilinx PG158 page 80 [1] states that master transaction inhibit bit must
> be set to properly setup the transaction in QSPI mode. Add the force_irq
> flag to follow this sequence.

This doesn't apply against current code, please check and resend.

--Zm41z8M/j1XJwFL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPrjDYACgkQJNaLcl1U
h9BgQwf+M9uP4hLhG0N8iB4C4+SZ/LY2yI+4Abpy7EnzHbP8NaCpnMaks0QcL8Lt
sop2XityiGFfqsjkOA76msbRRIRHSZrWsYEVp0QhU84fI8W+ZUcIfXNNj1Y5zPL4
kfenmGmo601FIOsxoxU9E97oYalP28+ZI6KrqmqRItITBhcY1PCHrOM9QtIZK+py
mSOqAmMtExIUVtB1rUbzU1IHA+2yKXp5CezNAY7aL658huma0gk2hP5pthmYgzBU
ErrHLgawt95EvEHm0KuD8oPk5AIVqIt/pgOH9oPlzp/IG01J6cDlj9wQWliHZ1pw
zPKU5m+nxDkMGUpWwGiovzsMq7G+6Q==
=hyvs
-----END PGP SIGNATURE-----

--Zm41z8M/j1XJwFL3--
