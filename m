Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9238B1EB8D4
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 11:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBJtu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 05:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBJtu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 05:49:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8582920679;
        Tue,  2 Jun 2020 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591091390;
        bh=7Cy56Bnu1NcpQ7UwmRjSTV/5jRN6OIJUxT52J5jFI6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cu0Rsuf7AbaiYX/J0nYfTDJppwK7y9QMiRWWqXdUSp7obOlFCpFRX7WjOpRrg1ZXT
         IMNiU6fo0dE5j/Zy4eYOZNY+1y81uZ9CQK3im/EkG7f1PIXMhOaggrZfCMjGhllpiz
         1w8GZdefBEVvpa7pLvHT8dEASWG2vhOojvkdRsEY=
Date:   Tue, 2 Jun 2020 10:49:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get
 failure
Message-ID: <20200602094947.GA5684@sirena.org.uk>
References: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 10:40:33AM +0200, Markus Elfring wrote:
> > The counter is incremented via pm_runtime_get even in failure case.
> > To correct the counter call pm_runtime_put in case of failure, too.
>=20
> How do you think about a wording variant like the following?
>=20
>    Change description:
>    The PM runtime reference counter is generally incremented by a call of
>    the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D.
>    Thus call the function =E2=80=9Cpm_runtime_put_autosuspend=E2=80=9D al=
so in one error case
>    to keep the reference counting consistent.

The original changelog is perfectly fine, please stop sending these.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7WILoACgkQJNaLcl1U
h9DjBAf8Cv2mppt2k43MzqHRc3jstaRWync9NLGQlJhGTT7Y3mPwynIc64JoOPKk
n88vwec+oBWDCnFUZZzNT7eK3XYJNFvnC10mt0p8kZSYu1wznntH/lBA8FNMu7Qy
varbbXp5irF+x1VyKfc3phJG/s7Gi5jnixtv/MZcEBY84GroD4nXvwlmIWzPrhxo
EJEAVd2F4Eea5n7p9ivEDRacCkP7G/2jYTYjWdfW6JYkJVpLgJdH6xzuD3cWZjIb
KkXT4EbKlh/6F6oOuutwsc0tRHG++YeOVAGNbqtSrpELbzOx9e8v4qeSedSzAxta
Bx995z3ICwchSCLdLMZWqRI44gr4ow==
=l1jf
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
