Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7427844EF
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjHVPE7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjHVPE5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 11:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DE61B9
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 08:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B8B6639E4
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 15:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8BFC433C8;
        Tue, 22 Aug 2023 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692716694;
        bh=ogIGYQoKBbXpKZU6NADQiLhlftRVERg4UPFTlHqSO+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAkJ8Oa1/75ypsgeQdinYN2IdeKRofZyXl988dJrFPqe8lsMKSDgCQVVo4X6f2oo6
         jzmXH3pEkoc2JQ8cZOvTNa+dkEvoIO69Vy1P08rwroF2gcWo4HIN7dK3gMhCmz6vGs
         r9+hND2G4ddp86EEcoUGnPY/rrPewqATWUXp/GIX8fgt+W9LH8mnSVQglfp29/R299
         vhwNh5NmObZFCGzNBaSvQVQ5RDpzvR/5q+Dt/5rlPOQwBpMtrIFcT1plR0B5w5LVqR
         THz9ra99MZMez9nhVPJzzbuts++AR4FXYUaZYNZrfpuYLdQk/ow+Q1sbVKxQemWyxT
         y6GXlGwepDUow==
Date:   Tue, 22 Aug 2023 16:04:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH -next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify
 code
Message-ID: <78d84425-a8ac-42a4-946f-9906a7a4e875@sirena.org.uk>
References: <20230822124643.987079-1-ruanjinjie@huawei.com>
 <52e3a5df-41ae-db71-fe4c-f46db22db4c3@microchip.com>
 <b11438ee-e05e-473b-a95b-433444fc77e0@sirena.org.uk>
 <20230822144555d15b0dcd@mail.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3JBJZi0D2/z6byjd"
Content-Disposition: inline
In-Reply-To: <20230822144555d15b0dcd@mail.local>
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


--3JBJZi0D2/z6byjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 04:45:55PM +0200, Alexandre Belloni wrote:
> On 22/08/2023 15:15:13+0100, Mark Brown wrote:

> > I tend to go on the basis that for this sort of thing that's recognised
> > by pattern matching other people will end up sending versions of it no
> > matter what.

> And I'd love for people to explicitly write this has been automatically
> generated in their commit log so we know that probably no though has
> been given to the patch.

Well, a bunch of them are going to be manually written by someone based
on fixing warnings that some checker is generating rather than actually
automatically generated.

--3JBJZi0D2/z6byjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTkzpEACgkQJNaLcl1U
h9Dd6wf/Ujnb70p3i0yKsU7mklASAQJi/SHPPyyfz4GFhcHe0ssnqP9hm4Qo1bL4
WAGRhsUAGigyv6SAZkgKdnggW23O8QKhupdAxJODvwns6WKemMgPzpv4f5RnVZcN
IV1Y1r2o7aePgvA4JF6LgUo4zeKGPIfqBrPC7fIo0pBSp6Mo0ytBOsBkpbGdp+2m
2I+DhNfrIVHn/PrINoLUCcLQ+BotTjbKEP/+gVrXu4/c/tm/Pgp2dHeHQ63yG8BZ
EVj5C11lbcMXxzAaf48OUsnu7keX2vK3zhogl6wdaRbwtewgT1FHkcs2ZvtZh7r2
1F2JCZx0tu9jgLs5tlmaZP7vaF6Kqw==
=LzCm
-----END PGP SIGNATURE-----

--3JBJZi0D2/z6byjd--
