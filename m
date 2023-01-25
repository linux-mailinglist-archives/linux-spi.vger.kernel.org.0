Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1567B1B4
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjAYLlb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 06:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjAYLl3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 06:41:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D9298CC;
        Wed, 25 Jan 2023 03:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3C4614D4;
        Wed, 25 Jan 2023 11:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E044DC433D2;
        Wed, 25 Jan 2023 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646887;
        bh=BSf4VdDu/Cipkbp8RNs0rNyAzPjqHzof5Fj9ZYA48xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfilqO/eKu/QoPePHTTuTn8J1r0Gfr8WyYnJTWSK83NPY89Lt3LaqRMiaWnnxEdz1
         5GfmqGH8yJFKJlrPMbcp84JgDUzRLc2uldIX4k89jTMcPIFXHFbL6PPgMyEPoohaU3
         uAQ2xL2z2Rjhzaa8w1lCI5+i1z2YED4iJtXXyaxZ0XqaEafwrnSL76HnHSEhWrfZh2
         BSVoMTAFP3PkmPkb7Kyti1fKVYFgPbZvpPHr2csZ0HOGM4Do6P0nTDzzOAj/HPpgzU
         RU4p1z0AJO7YjLO6ciSZmTplImSf9p4ZS2V0k6wbLHUb3lAFakk5haqH41gWo/0kO1
         OKWEJLNDmmlsQ==
Date:   Wed, 25 Jan 2023 11:41:25 +0000
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
Message-ID: <Y9EVZQJEV8i5vdgp@sirena.org.uk>
References: <20230124230048.371144-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YLw58GmZKH9QcKuc"
Content-Disposition: inline
In-Reply-To: <20230124230048.371144-1-robh@kernel.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YLw58GmZKH9QcKuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 05:00:48PM -0600, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
>=20
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.

Acked-by: Mark Brown <broonie@kernel.org>

--YLw58GmZKH9QcKuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPRFWIACgkQJNaLcl1U
h9C5IQf9Gj9QI/FW6Xw+gMpDw41zL45NSAa01ZJ7G8XkRAaJNWXTMWR1sZKiK4XJ
5rjn6QJUusYQuPpRmgG2DjO115ttDY8PNNWUlbpHxdQ+0dQI/dzilsrEFOrFXH1S
PcEA3qn6o7eU3ICxhOnhcJzf1auMMUeq0hHtfjHxHLhgxeJZ13yZA61DnR9uShhF
DT2ZXj0DrflrKoX2haOnuhvLc0Rx5qV+O3LfPBcO53OdCgjkAkmW2Jll2UrtTUIc
9+G5v1R2fy/qBGUUQSzfPcTESH8bAwxpdP3i61xeoUYzaRNM/K4F/00nXADmY71w
uWdFdQq7y1nxrTCAKIbIk2i8KCJlTg==
=IpOI
-----END PGP SIGNATURE-----

--YLw58GmZKH9QcKuc--
