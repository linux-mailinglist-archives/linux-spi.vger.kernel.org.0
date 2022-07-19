Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1400D57A5A2
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiGSRn5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiGSRn5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 13:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849255089;
        Tue, 19 Jul 2022 10:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1212616D1;
        Tue, 19 Jul 2022 17:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFD4C341CB;
        Tue, 19 Jul 2022 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658252634;
        bh=faiqk4f3iA99RZ119mlmfTi2lShRvfggSjO/MYwB1rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAeKH0tpjWqxNTzuvPNBKUj1bPiKSdSEMkdJG3gKBaG1UXB0hUAEj+A1xiTSxcSKY
         PTl07AFE8Bp0+1OyP0hAjkNP64jlNqJ4EvYKlwJumjwIYkQVih6YjE20Yx11nlPI/u
         blILq1P59x1BO6l3gR4k6HOfy5tGI6g8Kc5lQJ8kSbO2JCW7lZrH9EyEWAlfAcDoKo
         AXT+Fj9km1BeXnlldzGLfkywdl2q/eMclUSB7K3+ivXzqJP8jCpvlikcM5XK/Jx3bR
         cFPge9CM9hbOyOVXYxUpw1Q7Nf9QUUUodVeq4q5+xLiyi+gZ8uDW9AgvavZYdXYpPo
         vE66kme4VOGmQ==
Date:   Tue, 19 Jul 2022 18:43:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
Message-ID: <YtbtVdoantbZd7lg@sirena.org.uk>
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com>
 <20220719150000.383722-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YSrTx8XuycLBiJKv"
Content-Disposition: inline
In-Reply-To: <20220719150000.383722-2-biju.das.jz@bp.renesas.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YSrTx8XuycLBiJKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 04:00:00PM +0100, Biju Das wrote:
> RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt and
> DMA transfer request. Setting DMARS register for DMA transfer
> makes the signal to work as a DMA transfer request signal and
> subsequent interrupt requests to the interrupt controller
> are masked.

Acked-by: Mark Brown <broonie@kernel.org>

--YSrTx8XuycLBiJKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLW7VQACgkQJNaLcl1U
h9DvRAf/U1Dg40BIiv4vxtI2dbP/00dHEiwvD653YhJzTlYcqqCHcOim0tgEIhn2
5zgsmGhYkbNAPZlTJ9lZ1sWeNmYuCE1ozbi0XqDrUD9MpJBwB+Ru21BuDP3kBosT
YjBYKO9MdANpsnw6RxFUXOwfjqB+3pMoEQNJBTG71Cpc1GbxjlsNaZ2S+LTGV0qE
fBI7t90m5wmFS6MJTRA8z4hjdI+G9hiI8OSQqK8aqsIta2M8iUG72Azo+gq6amjg
AVnJe1sJ7I+w9Matu+wMn19XhYRFaCiMw+RWi08ltHUtNqaXGi46otTfQlwK/l5w
WuFa6rmkLuQ3bjvWT41jvfXa8C/TMw==
=P1qQ
-----END PGP SIGNATURE-----

--YSrTx8XuycLBiJKv--
