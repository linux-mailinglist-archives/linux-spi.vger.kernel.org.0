Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31068032D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jan 2023 00:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjA2Xvl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Jan 2023 18:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2Xvj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Jan 2023 18:51:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7FFF32;
        Sun, 29 Jan 2023 15:51:38 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64034660086E;
        Sun, 29 Jan 2023 23:51:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675036296;
        bh=IIIAwVilRWbK/VxJ9R07BpYKGovKnA/g9pkFp6lqOE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqkFNT0Zs/lQ4ZAdZec7R7noK9RCNBkqilV/t1bQhOMZbIlDsCTR8QIJkJbNxvyOU
         VbE7ue6VTg0M3DdOWcJ6aGjsAcjTr2+ZxqzGv8a4wgAiwvMHBZJQ6DDXAkuexFJSWl
         X/R91K3+3QzQ9ulj8z1XnphRoMblYCn+zpF9EVSp+xN1/FLHdO8Hkm6XRWqdErQRuJ
         XeOTeXAI9WSIaEqngDpgSjhUg3RwspINiAkv6i7zlzWrTopqAX91YHvKTxV3bw79iu
         MRFOyiLlAzyqG/4UwvkFeNkVVuel8NH5rRpODeuULeaiH/bQDGOlXtMZ5C14IPTwFL
         k7BwaWsFHnZdQ==
Received: by mercury (Postfix, from userid 1000)
        id 44F4B1060A24; Mon, 30 Jan 2023 00:51:34 +0100 (CET)
Date:   Mon, 30 Jan 2023 00:51:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
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
        Mark Brown <broonie@kernel.org>,
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
Message-ID: <20230129235134.bmlr33mmxkges22h@mercury.elektranox.org>
References: <20230124230228.372305-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gicruapujo3hf3sv"
Content-Disposition: inline
In-Reply-To: <20230124230228.372305-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gicruapujo3hf3sv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 24, 2023 at 05:02:28PM -0600, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
>=20
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> [...]
> diff --git a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yam=
l b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
> index ce6fbdba8f6b..0542d4126cf5 100644
> --- a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
> @@ -28,6 +28,7 @@ properties:
>  patternProperties:
>    '^(ac|usb)$':
>      type: object
> +    additionalProperties: false
>      description: USB/AC charging parameters
>      properties:
>        charger-type:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--gicruapujo3hf3sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPXBoUACgkQ2O7X88g7
+ppJ7Q/9G9KiN17FVwYLLs8SnUjgqv/kYKrPVShDKerSSX6M0f7jyOVMBZz/QMpm
Qzn0tl5laK3KtKo8zTuT/nHHQrwIyURSi8k3pEYUNc4KW8lTxLA4gLOCNjU+mA3r
hFuUUvRcrmDnS9e+du/tWzYg8mSp0eucjWzURwTq+OA2qeUlEfH+1YAb+8LWHxWP
O1pnLG9pGJMA1D3WDQzfXB0YfKpOkPYhxczD3VK0xqO77Z/PFANzD0Us/1XKtoFn
NcsoPPSPBA/KpyjVWi94Rgy7zCXxKTeodChRqTVNUpms71aK75cO7z13ZOSYj3Kh
5ZDpVLxWk2Yp5UujqxsMBYkJ31nQHS63CirMS84oPRR6WKbWzl9Qavl9VdPLMDe5
9lwmcjlHoe0MSwwwuBDuwJRuO2Yr6KcOYvepEbv0/aes6hCB0e4IGq716JG2clLQ
ZDVV5R3dmZk3KR3Ctu5twKz22MXyzqmoemtciqIsHkrLePBXwK6ylrLJfadUpgc1
9hvsiNNTMntVlLI3gIQvsqw3W89s8UmTQAV02ykLZ19yAXhSQW34aslkoG204Dbk
JRW+Mp6cXkXwNoMyqq1rCt4yFIG3ys3ELjFNGRX4we4+XJ7ZVU6agwxNMbyrFuUt
UKXHATWoGucDR6hd83W0A7eREcm/GZzUnBKCAMTu4FUu1UBEOqM=
=p8Fr
-----END PGP SIGNATURE-----

--gicruapujo3hf3sv--
