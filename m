Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2472267B1C2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 12:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjAYLmA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 06:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjAYLl4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 06:41:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04622BB;
        Wed, 25 Jan 2023 03:41:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A02E0B819A2;
        Wed, 25 Jan 2023 11:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1CFC4339B;
        Wed, 25 Jan 2023 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646908;
        bh=ezg2eabCWSVB4l7XhnzfHs+x1Vn9MQYl2SLTazGntOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU/+AR2CwjeymulismW9BMOZiWHGFUxIhzBe/aKJI2+1c1gGId0ABjLtUTu03obBG
         0TFOLM7sjKuh6JqE19PasKUw/fvnXB7YE0xCaFg5WiyMAIKVkKtlhBM5bqlPOX0vF2
         jqOIv4Lzg2mbrHyFDTB/sT/C2DMoFJbEIIYrevZ3CAW7a2KiT9E0Re7km+4HgBgIOT
         zZP2aSxEMoUywBiSAljmGYeT2e7Ev0v8lhU58lq5FU2XR7xxT3c3QzPrbzSP8csD9I
         Q2YYEKrr+65C+KSNc3vZRbtDtiQJKw0dwU6Ei7YFxw7oqI2CdfL95Y8MAebk/UDJgf
         Dh8XnNgakkOTQ==
Date:   Wed, 25 Jan 2023 11:41:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing
 (unevaluated|additional)Properties on child node schemas
Message-ID: <Y9EVexQ3yAN1n1NF@sirena.org.uk>
References: <20230124230228.372305-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j0ZYRAV1FZ0iGu90"
Content-Disposition: inline
In-Reply-To: <20230124230228.372305-1-robh@kernel.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--j0ZYRAV1FZ0iGu90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 05:02:28PM -0600, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
>=20
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.

Acked-by: Mark Brown <broonie@kernel.org>

--j0ZYRAV1FZ0iGu90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPRFXoACgkQJNaLcl1U
h9DUcAf7Btv4DlmnSpwnSwLLZLZjLHnfTWVpZJ81qaPCs4SvmkBNiQxX1s9Vld21
8O/QaZxTRJp7+kru4tljDPFtPWIPRvcqVwgCtUoOJ2AIEKapcFBMVIh7nidnnNjs
+LXDzG2e4va5huH2/ghU9TQwULN6X3M3UY8y/sq604qT0koHoN9zoZo5idZF7BSQ
/GVeXQzXzB3UgOLv0hHuuQ9sD8QDIHfNn7ThUEPWhDwvinpB7VqkiIOD8nrr9mhr
AdbkpaWOi2iv3A5BgxyGFDMufybabjkqztUT54muSHZDxbCjU7vUe/fyyK1NEQGa
sgZbeoPjsTAlgN0ytBYi1aQSUR2wLw==
=DSza
-----END PGP SIGNATURE-----

--j0ZYRAV1FZ0iGu90--
