Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5F67CC6B
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jan 2023 14:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbjAZNk6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Jan 2023 08:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjAZNk5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Jan 2023 08:40:57 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A7C6AF50
        for <linux-spi@vger.kernel.org>; Thu, 26 Jan 2023 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=JIYRwYSZAIT2QW3oy/CCsbEmybCi
        6tEGlcMWrRXa4Cs=; b=kzUypsVCCToymre1U9rZuvhoygvq0/Sc/2aAcqlLzP+m
        iWb6tUn+MtVmO49v5WpOf8LS/BkE/vbsF5A1rd0TS0Jkh1EW2rdskjAKFxWhxs9n
        4cRUaM2JT56rUs6tKyn9VJylpEn7d4/h/Sao7iE3kSs24iL/SfhhmVbPYD3NBOw=
Received: (qmail 3798059 invoked from network); 26 Jan 2023 14:40:49 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2023 14:40:49 +0100
X-UD-Smtp-Session: l3s3148p1@eKCL5SrzhL0ujnvo
Date:   Thu, 26 Jan 2023 14:40:48 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Message-ID: <Y9KC4Pu/AnnXOLhI@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
 <Y9J6+uoXxUIs4Bkk@ninjato>
 <CAMuHMdXRBYhR+_+r+akZ5nKYPgpVKMNEHB5KCP_pnPJYtHvU=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5y+AKo3ML6ty8233"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXRBYhR+_+r+akZ5nKYPgpVKMNEHB5KCP_pnPJYtHvU=A@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5y+AKo3ML6ty8233
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I have to disagree here. The docs say that other values are prohibited.
> > IMO the driver should take care of valid values then. We should not rely
> > on user provided input.
>=20
> Then we should make sure the user cannot override to an invalid value
> through "renesas,dtdl" either?

We do. The new flag is checked after sh_msiof_spi_parse_dt(), so any
user input will be overwritten with the only value allowed.

> To be clarified with Renesas?

Frankly, I don't think it is worth the hazzle and just stick to the
latest docs. Yes, they may be inaccurate for ES2.0 but what is the
downside? Will it break things or is this just a little overhead?


--5y+AKo3ML6ty8233
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPSgt0ACgkQFA3kzBSg
KbZaGxAAsyjz5BZ7SAaBzUuYStZr7w9CJDTffu0WCQjEip3XZLNeGVpaJ5xIJLzn
8eVAVHLhtdB6ORLqMKrlr5kT+Fio3F2OKPPFjJ9yWHJkiSpLu46ZVNIGAw2qcN8y
l299ImKEKHASrNWP8las7nL5CN5Evh/Jx2b8xn6XpKqYTIhw5tRiu87YsEsakGAM
K/KWb89FwxMmUuPghrBVUhLin9IH5urdxhiCHuW8k+JcsW4uzgkA0aKB0waXfLfM
EtqnwMOksiQhoWiaawTpDll3aHkt+W6wwTkNMR1Bm9fjgDAp5JYjLFs3vwVHBr0M
XvkIL3PMeciVruxmcUnPGwL4PyOcpB0ZmPrnaujC+TnQCm0hep8gUAD+H5Hq0rjf
mFvCi4T/8TmSLjRH1KCW7F4bsq4BSs0EZ11wqVY+nSGng/Uyz/4O/Ko6vZpgVDsN
vTQtZ4vJi1Tzd2r9NvZnagoW5nbO3R+mcAnhKimaNu9TUsz8DKkPaqLuL3RQmsKr
vnb8RlIqQHLrnX+RzMRPZLfUmepFLDFrVfaTGFN4IjTGAG5QnN76B26UhXzdqKwz
KsJq5gK/BJTUQaur49zenIFpNPO0C/tRe9kiyeEkWe/uADCnj2tSqRTXPYLqNB3U
whjmeM+kMeby4tIeh8Jg50Efpbkr9Mb5oET9K/Z4W10wmOGal74=
=vSNp
-----END PGP SIGNATURE-----

--5y+AKo3ML6ty8233--
