Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A860375C5C8
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jul 2023 13:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGULWC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jul 2023 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGULWB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jul 2023 07:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6941715;
        Fri, 21 Jul 2023 04:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780786108F;
        Fri, 21 Jul 2023 11:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06755C433C8;
        Fri, 21 Jul 2023 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689938519;
        bh=wljoYeyKibgYGj9r1tqZl8Ksf/AxWV7TNPzMjmz57Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RD2nUhSEGGWCIw42NtrqExPXPm9WZ29HOGfaEqbWl/RFL4DamIyoFIDTnfOTu1AZS
         gxQzlF77kkrx2H/EusZ5LjoKoZb3/Il6o3zwwFgFUuKsBqQTdS111PDmrnh183crIE
         IgGrTn87y/zAsn235czvDVyPHlnLRZL39Bv5H9hz0xDxLW4xjRMR0ZaX5GLytPeO2q
         +zcvISxHRr3/VBuljnlY/W2YH49r+gL5k8KY7G4WG2HWkajCxBPJhRBDORKZiPpn9Q
         /0f4BRXnKrd3pM6oQANj9zG55H7YiFNzzXeVZsGs6Fm1Qfy5JjlZgSGUTgtYSohoxZ
         rZW7ttdFMc7HA==
Date:   Fri, 21 Jul 2023 12:21:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: lpspi: Add power-domains
Message-ID: <93514451-f2db-412b-a9a5-274e8f528460@sirena.org.uk>
References: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
 <20230721111020.1234278-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p0iXJ+2BMhWm/gN4"
Content-Disposition: inline
In-Reply-To: <20230721111020.1234278-2-alexander.stein@ew.tq-group.com>
X-Cookie: Do, or do not
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p0iXJ+2BMhWm/gN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 01:10:19PM +0200, Alexander Stein wrote:
> i.MX8(X) based SoC use a power domain. Allow supplying this domain in
> bindings.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--p0iXJ+2BMhWm/gN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6alAACgkQJNaLcl1U
h9DSmQf4wKmB3Sn1fz13nzciTc0MXKDIsImUHpdIe8K8H2FEeDeSOaRVKC0wMwmT
MinwC1uoQ1sGA5+RZR2iodYlH7p5GeuzW9ftB3XV/wdmwzllTw8RNWqjkH03X/hN
G+25E7kf/USZjY8i2nz2ONAH1ElSrOwoio8910gNwVEzSeOuEeg6bKBSWYZgL31p
pauUaeCJMErleZVf/2fp1VObcdOVSfOkTb+rJqrmGm+tm+d6hHD1Uo/xZTn0Omti
LTpaEMzEz4QhgIYMgFcVhWGgAVXVtQXpkCgwyBfQIgCuxWyp+Zdfxdu5OhAfWz7U
LCFYO/WlAdxD27P/OJ9TTZJWPuhv
=B+5l
-----END PGP SIGNATURE-----

--p0iXJ+2BMhWm/gN4--
