Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4133B23CF80
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHETVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 15:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgHERl7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 13:41:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99452173E;
        Wed,  5 Aug 2020 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596624860;
        bh=itzMvNq8nfgP8VKXOJXPOoZfq8+Pd5YP4oo6JUWZy/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daILxyCwv0M7mQeyhNXxvi03DAUtga5jJtqn9dQXwRgrXBcNva8DPZDusD/aFamB8
         Au9mHe9ABAS9MqqceMBsO7YPBu1LumIOWL9uh+TWE/OO/RKyxryVA4IqaKwGaUH9uK
         2Cbco3etFIjw9O/v4cujAsyuMP3cTEND8YVamfgM=
Date:   Wed, 5 Aug 2020 11:53:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 09/18] spi: stm32h7: fix race condition at end of transfer
Message-ID: <20200805105357.GD5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-10-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-10-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 09:02:04AM +0200, Alain Volmat wrote:
> From: Antonio Borneo <antonio.borneo@st.com>
>=20
> The caller of stm32_spi_transfer_one(), spi_transfer_one_message(),
> is waiting for us to call spi_finalize_current_transfer() and will
> eventually schedule a new transfer, if available.
> We should guarantee that the spi controller is really available
> before calling spi_finalize_current_transfer().
>=20
> Move the call to spi_finalize_current_transfer() _after_ the call
> to stm32_spi_disable().

This seems like a bug fix and should therefore be at the start of the
series so it can be sent to mainline without the new development work.

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qj8UACgkQJNaLcl1U
h9BPMwf/SVAa/tykTrFSDmtKpWBCSoTEQyhwBfjKuq+rQf3+01Akz63PIPooThf4
4hcsMCzyVNfFiNhOCvCyeK5ccZ3iJ6ZX+CBzIp82qadb35VN1MNxMVwHPy2kshTW
8S+oKpDXRIFEiuKmDTBW22swtHCy8m01Ng4gQXvQPBhdjIpff4sl/kAMBxPRUFBS
TjkRi39WPFNwmRWRBrAxa99mmyOt0+83zOs0jjLRRJADsfoIaDdkISbFGJ517Wh1
10XUqNK0kNJC8hqj6rK7jgkgQeMW3vAQaimhlJzFbnjVOgtiW74zF03RPmxM1w6V
R+0IRfA+AzMkXP1gTek7e+vjuBraaQ==
=4szv
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
