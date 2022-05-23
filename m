Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD75A531B16
	for <lists+linux-spi@lfdr.de>; Mon, 23 May 2022 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiEWTVe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 May 2022 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiEWTVD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 May 2022 15:21:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA7215A3EC
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 11:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05E43CE1788
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 18:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA12C385AA;
        Mon, 23 May 2022 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653332177;
        bh=Z5RBgye4QEFZsAL+4f6/xwLdtNoEJpk/3aN1+FfTNVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiMjEVjeemV74uTfKQOqn+Wgoxur/nNPdp7cRGnTUQU8tncL78D+8T0muuRgI/iq3
         v3bJkuVRnfbl7AVUVVMr2e/XZkgIhZ3o37aUCoNP/73lcmY9IKeXQqaSdsfAmmF6nO
         R0KroeNe8BCOc3tn0YNcw6ERViAyKVymv5V2JW/h5hXfeQViqBjy0hrXC/RtS6GCGQ
         e62KVjHIllE/ktHmtMV7reajQRPMl9Hw/EQlzTiK9FfbI+eV6LU6rMb3LphZTOcuu8
         r6UEiIvo192xRh1WlRdLZ3y6ylJMWrvT6cs/9HDgEJeN6or8W/HnBN55483kG3foU4
         HRE3FTlh5SzzQ==
Date:   Mon, 23 May 2022 19:56:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     David Jander <david@protonic.nl>, linux-spi@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: spi: spi.c: Convert statistics to per-cpu
 u64_stats_t
Message-ID: <YovYzLcAQGhO35RQ@sirena.org.uk>
References: <20220523142009.2218738-1-david@protonic.nl>
 <YoukjLDGvz5kN5fp@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rNl6XFBrWGxs8/46"
Content-Disposition: inline
In-Reply-To: <YoukjLDGvz5kN5fp@lunn.ch>
X-Cookie: Sales tax applies.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rNl6XFBrWGxs8/46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2022 at 05:13:16PM +0200, Andrew Lunn wrote:
> On Mon, May 23, 2022 at 04:20:09PM +0200, David Jander wrote:

> > +			inc = u64_stats_read(&pcpu_stats->field);	\
> > +		} while (u64_stats_fetch_retry_irq(			\
> > +					&pcpu_stats->syncp, start));	\
> > +		ret += inc;						\
> > +	}								\
> > +} while (0)

> Looking at this from the perspective of a network reviewer, that is a
> pretty big macro. netdev would probably not allow this. But macro
> magic does seem normal in this file.

Yes, it's following the existing idiom so it's fine.  I didn't see any
issues Andrew didn't already mention, otherwise it looks pretty good to
me - it's a nice clean change for the performance improvement.

--rNl6XFBrWGxs8/46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKL2MwACgkQJNaLcl1U
h9A8OwgAhYzK7FA+MeErlVcBjr+d5HyJ4dJknlHyUB9i09Qt6vPxjDS0Ijcttnum
WcmE0E++5ON7UQfNEOM6uh+wr+KNCIRZ66jPdxOghYZgdM+RUYENjgyA1UUPOBHM
rCoOuIEoqaevnSwxXfErHNQZz3sTOUET6LROOduUzWX4wJf6J3Hs6x/25GyysF8x
CeO1kOA5aBZqHKojZjAmnhcrl7OyWivC/07Y0g88WHV7QrGqAmyKtiI727bXbcPm
l7ugtCUaUYVoL2VJjuSM2ccgJ4t7tQq/9qJAq1A5dNqpG7Wj74KvT+39dw5OZytB
wm/e5pw3bSHOM2BA/6cXtycFGnyEBQ==
=gz9l
-----END PGP SIGNATURE-----

--rNl6XFBrWGxs8/46--
