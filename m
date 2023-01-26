Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E667CBAA
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jan 2023 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjAZNHK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Jan 2023 08:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjAZNHJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Jan 2023 08:07:09 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5430B3D
        for <linux-spi@vger.kernel.org>; Thu, 26 Jan 2023 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=tDawVOrKmaMo6AMdN7dGcAoRDRKS
        oTEXM/iUIV/kMEE=; b=pRCYn32YtwCsd/4ALO1eua4MaagoTGTEsWd4xjrw8/cE
        nwmb7er8AxUyE+teXrjQXP4wU9hL/nwKFSRDDzzYRWjDlJVVVXzN/XyZZQ4N49ef
        CUOtESh0L/nGCySVN0YBec+TrkQVthk8mTyI9RwzT4cj2wAKJ4wR0LezrTRWfW0=
Received: (qmail 3786278 invoked from network); 26 Jan 2023 14:07:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2023 14:07:06 +0100
X-UD-Smtp-Session: l3s3148p1@f/j7bCrzRtoujnvo
Date:   Thu, 26 Jan 2023 14:07:06 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Message-ID: <Y9J6+uoXxUIs4Bkk@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyD5pp/MwlBtOrWz"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nyD5pp/MwlBtOrWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > Documentation says only DTDL of 200 is allowed for this SoC.
>=20
> Do you have a pointer to that?

Yes: Gen3 docs Rev.2.30 from Aug 2021, Section 59.2.1, Bits 22-20:

"[R-Car H3, R-Car H3-N]
010: 2-clock-cycle delay
Other than above: Setting prohibited"

> We already have "renesas,dtdl" to configure this from DT.
> Iff this is really needed, perhaps it should be added to r8a77951.dtsi?

I have to disagree here. The docs say that other values are prohibited.
IMO the driver should take care of valid values then. We should not rely
on user provided input.

> I suspect this is a leftover in the BSP from attempts to get MSIOF
> working on R-Car H3 ES1.0 (which it never did for me, as CLK starts
> and stops too soon, compared to MOSI/MISO).
> On R-Car H3 ES2.0, everything works fine, without touching DTDL.

The BSP originally has this patch for ES3 only. I extended to ES2 as
well because that is what the docs say.

Happy hacking,

   Wolfram


--nyD5pp/MwlBtOrWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPSevkACgkQFA3kzBSg
Kbb7eA//fXnM2Yjek6yCfwy2pAEKUVydeycR7uwuk4WGDm1wlcXKSdeX9+H2nTw4
HWgpOvgUdOgTG7hjV2ZheQgHVRwndT1FxKqH0YJ/vF6i6KFERvyxdFlPwPZt1jyX
XUBJGRoZjdzvvzBT8DFkmk3u9/Eiqso12alztu+YB/CVMia4586EHMy1QzIe4gKV
CHbzaqoYqQEjpHV75nrYBkRTXBvA6HtBAigE0wv1eFeOiBYCN8zREex562vq7GoQ
UVM+M1WvvE4DlvClBydAt5xdBvyhMlzkGF7o0AaL+SZK+JlL5SlfFxzkqxZKjAB0
/kUAL3bXofZAwi5VRLsFoNnjUTzx5JkFwJ2iYkpB8WWET22UrIg7qZr9fF3Uq9P/
GXghmggzlYgU2aQ4Kb8pe4xcriETWq7reFC7XlMZ9w3rYeySr8VyH4aV9mTtVcRK
67eG46UbPzgqyCd+/4Cj/mzWPQXq/6JtVdvA/8wQQfnGH6FSjHCoM5uwfB+GsIt0
HWkLji2bMCD7VpclvJE7AG7oZ9Su4YAFL2THvqa2KAp9Wm5XALqhz2qUQnN76xZ2
lwS1PkNKp4ZC5Yu2H9CFyTzFNjoGREKbAVgK1gh9W+RM0Ml/tZCdava8LATQk8IF
qszSeOarufxAAGskbti26lR+ngPbeZPMkRhTLdLlj+KA2+lzFqY=
=MN30
-----END PGP SIGNATURE-----

--nyD5pp/MwlBtOrWz--
