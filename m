Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9784EB420
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiC2Tc7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbiC2Tcs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 15:32:48 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF973B7C6D
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=y1ipC1cpa1iw38bXt7kXRu+jOzzA
        8giV9UgB2XeS6Xg=; b=AkM5Bxti/QKKcFqioRrwnyWRcY9movcfshJF2ha9lf5e
        OBbdG8vb4hkenwwWSYu6t6tEKXZlRYl+rNoy9cgwIRL0ctXrL5I64C8RLWN8sFiw
        Swp646l18Optgl2UOPGDJ4hM0cbFm1YirKoYhDnS0n4Btz/7E0lnc23d7lG2gNg=
Received: (qmail 1912088 invoked from network); 29 Mar 2022 21:30:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2022 21:30:59 +0200
X-UD-Smtp-Session: l3s3148p1@xFrCd2DbhuIgAQnoAFHmAKSkhU0Puvxy
Date:   Tue, 29 Mar 2022 21:30:56 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: hyperbus: rpc-if: Fix RPM imbalance in probe
 error path
Message-ID: <YkNecA5xIWl21LW+@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ByFni+gSrBaOyIw3"
Content-Disposition: inline
In-Reply-To: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ByFni+gSrBaOyIw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 04:00:38PM +0200, Geert Uytterhoeven wrote:
> If rpcif_hw_init() fails, Runtime PM is left enabled.
>=20
> Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good catch!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ByFni+gSrBaOyIw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJDXmsACgkQFA3kzBSg
KbaLExAAr5kzeoqpZu30Yv3xsOmLfmACfNFvXT3zAL41CSGIFKFWhGgQTQK10BLq
PxXemL5mOM62X/DkBg1olWr55QqDwUmo2A3gpE2H/WprjHGmQ7N9kvA1DLzWTi++
TMuO+RuTvP7XKWfpX7IumW0vPfRlyRC6sqdys3vKwfYjvBU8ITcsRS0h4+XHeGfX
bRBuGk2SeK5080IoKJvKql21FIYl6Hr8a1pD28m6x3NaYnw6SufQZ9++FoQXSkgn
dAp4ue7zHUSgaG0HPTuYGP9jNKk6K0wui7TQsviJGwLdLDFO4mRDYkwoSWbirzpl
jKirRWrpdLMmHM0LVISmUI8dkV96fM/Hr0L8ZzrRYLCXQMcV+vt1ZwzGjWWLr8DI
XWJrr3DL2+b5I+u1Xw3nxsFGDVhgLz12w9xbZTAm3gPYFCVnG3wSGDXgPNuslJDv
4ML9yToOVBsyMcaw1Z+4dK0jWktQA7bKrNx4KDPLv+CR2mMPLWvOxVs7MImdimYr
GYu/D1IU/K6BUAnFosZDmm85qlnZrrPnXMl/VHI3kRMhWZDzdF29XlmXWNG/gPb8
e+eoTMmACEdg0d6Fhum1OuRnAaYMM2OzVs9QkGFmna3UlXgOvUcIiU2z95yHvx4C
iEXIL7rcvyv651bOeE3bm21pcJWb+sKy/ZmM3LLvkA6ymwf5bxQ=
=jHfi
-----END PGP SIGNATURE-----

--ByFni+gSrBaOyIw3--
