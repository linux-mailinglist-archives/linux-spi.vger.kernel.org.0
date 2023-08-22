Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30707843B7
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjHVOQL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjHVOQL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 10:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB70CFF
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 07:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF85865892
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 14:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D4CC433C8;
        Tue, 22 Aug 2023 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713719;
        bh=COmzrb1WZk6hPxJA8KwkaCIUec4DvG1bq/M7FGwj9Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6F/txs0R4bmmml1dxKmBwxOh4CEbol+WAnnKqvbYiLIL/2L/Db7O1NSjmBjbkfw8
         +UPG8I+/jAeeTiNc/P9PAN5jOcXftwTN/Yk5dJe0Zl+/D0/WgVFrbRTR2nApDj+BhE
         ZOtrgGkv0d1WSz/aNULswNd3fQim3AMy/dRXXs7t9P6X3tejJsaHrRiCIheuqO7zlL
         0k32+1kx/eScP9SRw93BtL/OzKO0Uwa9+sw84OwtoKlMiEWgeMI7vsGosvEBA2Eec+
         goFeiJ66ZMKWZ/chF/uvcXcUjLnPyJMWZEQVzS14xVTdQytHDpeasspj05cQG+gvwv
         Bp4RLkVLEyR6w==
Date:   Tue, 22 Aug 2023 15:15:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH -next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify
 code
Message-ID: <b11438ee-e05e-473b-a95b-433444fc77e0@sirena.org.uk>
References: <20230822124643.987079-1-ruanjinjie@huawei.com>
 <52e3a5df-41ae-db71-fe4c-f46db22db4c3@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBbulfkhOM/Fj8zO"
Content-Disposition: inline
In-Reply-To: <52e3a5df-41ae-db71-fe4c-f46db22db4c3@microchip.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GBbulfkhOM/Fj8zO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 03:11:01PM +0200, Nicolas Ferre wrote:

> Do we really need these changes?... oh well, no strong opinion but is it
> worth the effort?

I tend to go on the basis that for this sort of thing that's recognised
by pattern matching other people will end up sending versions of it no
matter what.

--GBbulfkhOM/Fj8zO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTkwvAACgkQJNaLcl1U
h9Dx+Qf+OGgw4KSsg3Oj+/VNlLxWzUXTZ21t23kiwdoPct2itoMikTV4y73UqVfs
TH/fzj/P/yskvGiLmv1P1e0lkRq3u2ooivvupOK+EGpm1LHoTRu2TWavqekvOZEH
9biTcttNo+ekXBjdkHwskiUl4bHKqI+Git56Ah4iRO3ZCZj1BpRasZc8fT1rmA70
Kfk8yEystk+GH3sYs8PUdOkvqzTx3s4P9aAQdObeR73ejwWOfRe6QWyC2z6R+cID
HMKAmWo06SsT67oHJbWmonuYtzNWPqqrWzL5o15SjDVXeLUtJ4nMTfe28GQrp21P
GoKdzKJ4fpRGhgRzw5lAVwuHmRiw4g==
=pU/Q
-----END PGP SIGNATURE-----

--GBbulfkhOM/Fj8zO--
