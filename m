Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381AE785AB8
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjHWOdv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjHWOdu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 10:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4861E6E
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 07:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1FB66388
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 14:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57AFC433C7;
        Wed, 23 Aug 2023 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692801227;
        bh=C1hbzTT6cGFihe4H7gW/Ju/jQ9Q/OxtUlBHuZSP0Aao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiNDyfRPBz0JDIDpc6M+9dKrvS/aRPlmLvOCU2bx0bt46aHIVLafisFA6+khEH5Bk
         o6r/0eeU/0s/FAdjgpVIpkRdyEX9YDdleQJQToGyHz4qhHRb5rr9RHSvgNscVlPDyW
         R3uXSKp0d3rpIp7beUxmhuFd8neoGTIHpD97pND3hrUBvDQofTYu7TxxlkrnR7MacW
         ZRkgh0k9JGczZo+lBsGo8z1nDkBZBWSiXxI5vWq/3dXfiTQo1AJSZIOH5v7jLKDBAk
         NUnOk5mEJI7ZbZsAEGblRzqxg4GnI2k8b8utY/iEGAGJ1zVy4biyyrO11BWNwvurj1
         iI1WR338xShPg==
Date:   Wed, 23 Aug 2023 15:33:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     andrew@aj.id.au, angelogioacchino.delregno@collabora.com,
        avifishman70@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        benjaminfair@google.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, conor.dooley@microchip.com,
        daire.mcnamara@microchip.com, fancer.lancer@gmail.com,
        florian.fainelli@broadcom.com, heiko@sntech.de,
        jbrunet@baylibre.com, joel@jms.id.au, khilman@baylibre.com,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        martin.blumenstingl@googlemail.com, matthias.bgg@gmail.com,
        neil.armstrong@linaro.org, olteanv@gmail.com,
        openbmc@lists.ozlabs.org, rjui@broadcom.com, sbranden@broadcom.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com
Subject: Re: [PATCH -next v2 00/25] spi: Use devm_clk_get_*() helper function
 to simplify the drivers.
Message-ID: <027ab9d7-4c05-4ce6-a4c8-14a79ce8a11a@sirena.org.uk>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+LSyj1/J+nxUF5eC"
Content-Disposition: inline
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
X-Cookie: Some optional equipment shown.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+LSyj1/J+nxUF5eC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 09:39:13PM +0800, Li Zetao wrote:
> Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks") provides a new helper function for prepared and
> enabled clocks when a driver keeps a clock prepared (or enabled) during
> the whole lifetime of the driver. So where drivers get clocks and enable
> them immediately, it can be combined into a single function

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--+LSyj1/J+nxUF5eC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTmGMAACgkQJNaLcl1U
h9Ahbgf8DmK8AENTGZ3rHpzuOXsW2ZP5aIOm6S92ZFJyw2EZHDmCjszD8WoTtiU0
GJyELU/5q3nOfQB1kT9EdP5reA2E6Ak/GELG72pFrlofJ89iJyG0B2Of+8WFypx/
j/w+U3B0R0cd43VTQQVSfDpzP3WVOSYv212ysvnY1iU5JnrMUbanse/GROeFp7JU
WGsd/42DTpJlwqQbVOgxyyGVa7EWxhyZx4OdZWLWnKzSBm81TAXBcrU/lXJX5wVl
/61+l7cq4sIx72yGG26gXY85gg0cZspzYQQdZd6tpGFUUbFldZHuoGrtF1bDNUyt
MomQencPLvinPUy4FR8IqluPGiYJaQ==
=UpUO
-----END PGP SIGNATURE-----

--+LSyj1/J+nxUF5eC--
