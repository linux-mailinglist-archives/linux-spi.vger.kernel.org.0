Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DE34E5BA
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 12:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhC3Krz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 06:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhC3Krl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Mar 2021 06:47:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1971261985;
        Tue, 30 Mar 2021 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617101261;
        bh=oxbxirPkUV1BGkuOehoCaSJHO2FqiyHDdMrKxz5B7rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaJ4Wp+WPpwRHDf/FxB2stTDD6kpu1cWk9fEult8kEaNlAb0TbpamLbfB+AwSr7DB
         Y5+oaN2G3z+8XzjoTIodfK2v/9PU5kKA63GPbg+68E0dYxY56fFcpt4DZPNGbKrC8C
         2l5emxsPpZkr6dwNMz3zmHj2tLhtP8uwlS3wPjO7eOgZadxHaH6NDJc88ZNwjEket0
         9siZSMPgSAvpVKbMSw6MdIBj0nzG6G2uQIIiTcIzcPxCzf6fieFDnNTez4IUC3f36N
         p7UqnEPd6sBJXow+7/eoweuzZ4FL4rk/GgJXnC8lNZ8hZa8i4HX7wGbu9JBMLTv/PX
         +T/1pdSeTtESw==
Date:   Tue, 30 Mar 2021 11:47:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
Message-ID: <20210330104730.GA4976@sirena.org.uk>
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk>
 <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 08:53:00AM +0800, tiantao (H) wrote:
> =E5=9C=A8 2021/3/29 23:21, Mark Brown =E5=86=99=E9=81=93:
> > On Mon, Mar 29, 2021 at 04:58:36PM +0800, Tian Tao wrote:

> > > +	spi_data =3D (struct davinci_spi_of_data *)
> > > +			of_device_get_match_data(&pdev->dev);
> > > +	if (!spi_data)

> > If we need to cast away from void * that's most likely pointing at a
> > bug.

> Even with of_match_device, there is still a type conversion=EF=BC=8Cas fo=
llows

> spi_data =3D (struct davinci_spi_of_data *)match->data;

A type conversion which shouldn't have any need for a cast.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjAcEACgkQJNaLcl1U
h9AP2Af8CHz5oMLlBf8VBe6X8KkC2/XKLZwmdDMMoVUU2rslzD84h6ALqViM4Coc
FAoU5xDp2D8JOsIY41G12v76z9ojPRzt3MQL+tN/kTtn0gUQ/Wsr96N/fZWjfViI
p+h9/jyeHLLzK9nwO2e8H1/ecDM4d2vDf26TQq8Kq73tFYW4EcYRlhuHV86NuPtu
8OsxgKVHM4rG5HqnpI1FYuduDlTXGUovPk2Mb+nYcXPx4qnqMBLX26qva889A8vs
+j7nBvfXdwU9XfUJgqSHCDm3nbTO1yynRtpSQCysnETFGvKPU9HlWmXrQbvlfW41
vCmqQcLgosjrCfYmJkI0mhq6rgG51A==
=pO0N
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
