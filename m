Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0653067B389
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjAYNjc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 08:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjAYNj3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 08:39:29 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F859577C6
        for <linux-spi@vger.kernel.org>; Wed, 25 Jan 2023 05:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=aEkGZEWeEElUSaex7s1IEQ4jcSga
        9F+LSlW2tGYvCeQ=; b=DMPe2/ahA1Zk6c9SzZx9SDhuHg1IM3JwI9Y0zHlRZU8r
        3tiUB7jfcKjroGHhDtPxAyByGD+7x9BrQnC7ZRTItMGtQ1ArXSqLcBsNBORbqzSW
        2psalv/M9YAdsGG97UZACJXZxpact+w+62qwdIKRmhKlJiz+Prqfwp6dIExY5t0=
Received: (qmail 3293923 invoked from network); 25 Jan 2023 14:39:14 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jan 2023 14:39:14 +0100
X-UD-Smtp-Session: l3s3148p1@tq8Rwhbzfrcujnvo
Date:   Wed, 25 Jan 2023 14:39:14 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] spi: sh-msiof: drop support for R-Car H3 ES1.[01]
Message-ID: <Y9ExAqx4qkypZYoR@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20230123075833.50925-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdX072wWj=h48oVe47bkaw144HmMeq2bNbiE+ZUMhz56eA@mail.gmail.com>
 <Y85bONoZzfTf2fXw@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1pGAqN8BhC6Oq6rV"
Content-Disposition: inline
In-Reply-To: <Y85bONoZzfTf2fXw@ninjato>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1pGAqN8BhC6Oq6rV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But if you want to get rid of it entirely, that is cleaner, of course.

I'll start with that work later today, removing ES1 of H3.


--1pGAqN8BhC6Oq6rV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPRMQIACgkQFA3kzBSg
KbZN1Q/+K9E0S+W36Sqqsr4nUrS6Vlh9NpWUqcvVY6dTBTTMt68qXBwcZaOcZdUw
dnWxUsw/CTkpw3GaaPVOojInwexwXa8G7umtrtX2ieS7Cadgvb327tV005E40nPA
Y5ENaceyTDASoRrZ9NYitIE01iVRGgAZdKJBEBmYSbDijDOFJdDVHBXarJERZZF7
jGFjxuGzXAqCMbkLAa5DYPnEyhr2c2Iq5/+y645KNjQqIuxS6JDN05GM23BIGvc3
o8uXXTPvKG1nXxPi20JsX3M/Yy/S5N4/UfU1TLX++z7WHZeL+0cIveEaJnPH0Iqz
Kk4hFe/X4NWYt97OZSs6WnrTYj+dD5ib0XZdsXVBzsLuOSnexOYA+aJfnFe1Rz7X
wqpKKOVPL6tInOi6zCE/scpiXFdhlwinOSfN9uP912pw353aU/dCElS4qqpJ92VB
zMZXLH8XFCfHJMVysO6qWme7Z1VeW9Y6SbCpseWiwZaHb8RV4HIMXQjVse/1ELdY
/KYZQin9VnfQD06NWm0tj6WZInEn9x6HKglHh9fPsVqQzKQlF55t8c7jz21Tcdfp
bKe+7BA8I3cgzNCzthcsgx2VxeGp9QsPc7TAvmvJA/irTSvILbIngklaWkbhMzbo
FZS1qaSWCclrIOg6WrDfgvTcNj+uPg8J4aG3G9/2WGnxJarbfR4=
=/yvQ
-----END PGP SIGNATURE-----

--1pGAqN8BhC6Oq6rV--
