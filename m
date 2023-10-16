Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8537CABEB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Oct 2023 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJPOr0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Oct 2023 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJPOrZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Oct 2023 10:47:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378495;
        Mon, 16 Oct 2023 07:47:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8587C433C8;
        Mon, 16 Oct 2023 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697467643;
        bh=DRdrnJg10Y4r+9wXQmc5/yfXdc+PtrcGCHG6+FdzrP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVdNKSrLH+3IDVW3itVBwVO5W7gIFiEgX9J2wr+WV/Og6LJ7jqD9HLZI/lIrYSmwU
         2V5rgTk35JPzPNeuO8hOmc1t05//HRfJXB6e2t6rajW6et5Bp//1tcbhlJ/RSRh1yA
         Zo60kDD//5tEaqjSu6zZUVoRUJxC7gpOExq8P75tZtC9ZV9krJ7EIeWrfpeILEnU8w
         l8Vwy7bnSFBJ25Kqg2WZ/Uzix3RLToIwB9mWd6lmXD0IfCrkaUU+iCwks9du17ffol
         qqGLDZg9ERfD4fuYZL5J2Qk8C4STEg4W/bJx76tzTIuJ1bE+fdRaHxuEwap2M6AKlR
         HgUzqHOgXsRgg==
Date:   Mon, 16 Oct 2023 15:47:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
Message-ID: <5d777654-4700-46ad-bec2-3921d0b7d0fc@sirena.org.uk>
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlne6lNoJTR0ySyH"
Content-Disposition: inline
In-Reply-To: <20231014205314.59333-5-hdegoede@redhat.com>
X-Cookie: If you're happy, you're successful.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jlne6lNoJTR0ySyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 14, 2023 at 10:53:14PM +0200, Hans de Goede wrote:

> +	.micd_force_micbias = 1,
> +	.micd_configs = lenovo_yt3_wm5102_micd_config,
> +	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
> +        .micbias={
> +           [0]={ /*MICBIAS1*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,

The indentation of this section seems weird - .micbias is indented and
the lack of spaces around =s is odd.  There's also an extra space before
the , consistently on the mV lines.

--jlne6lNoJTR0ySyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtTPYACgkQJNaLcl1U
h9CfZAf9GHbQ6wahif1bW+w/xlbkNLRtKO49yLrZ9WoNgv6AXjxFrY6+4udvxOhO
93jiuepZ/Y216CR5SLJ/uzQhsg/VNEqUPKpd/pSRHboBygknSuwtyjRwc05urReO
k/LQK44Jy/Eni1KPV/jWDp+EWK1ZT+8eCB9ciemH06rgbzQSKJodlG32trhtGQUO
+tOg8xTkIHppVBnR89Y6kCRzritu7RLjNSy5zPw9U6a1k76G0ykQam+XAu+5ri6g
JCmjvsC1BI/vxXWNbzIv3RL6TunINhXds2WcCA8Fey5g32hrwZYGC89DKcGkmUPI
nWsPV48aBxa9qMaTaFl3E1sJGGEHsw==
=9A+C
-----END PGP SIGNATURE-----

--jlne6lNoJTR0ySyH--
