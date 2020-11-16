Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696D62B51C4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgKPUAq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 15:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgKPUAq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 15:00:46 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2131208C7;
        Mon, 16 Nov 2020 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605556846;
        bh=e6Pic+7L11QD6xi374GsTYuOp0GRbXjHHJECZ1AFmq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gw+LNtSyIkMGjoDYkFGWnukFLJoZkRTPy1a3rXed+cWjxxa95k2KE4I1t0Qj51GU5
         hugMMrEVrl9/j79pFtEFWugaqx0eHqtpCzBTb7eF4D4ktnP7DXLx7qQ8TcgAdlGAZ/
         jcJxYuUJOwYzEHvEtof7jjghtvaJuzkoqzEg69gI=
Date:   Mon, 16 Nov 2020 20:00:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bayi Cheng <bayi.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v1] add axi clock control for MT8192 spi-nor
Message-ID: <20201116200027.GI4739@sirena.org.uk>
References: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Content-Disposition: inline
In-Reply-To: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 04:55:01PM +0800, Bayi Cheng wrote:
> bayi cheng (1):
>   spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+y2loACgkQJNaLcl1U
h9CkIAf+LgGXsnM9kY0nd1NRS64B85c9CWhmqEIuIXyBnH9Nh5F97gqKOrGrcNT4
0Xg5bW0+V3LXXg3rBZTrH5wFF+D+ts10B45v9QHLp2FLCE9idgLUFEk5K3PmonAb
KPe15kR0dK2VMl6dKuWCGlPPlBPgvcIIRZU42gfjkkC5vq/AWuCnNRJRiYPSftl4
D7DKjEQVCHcM+d/V4vXLMtNnkI7IirMDeeMsXa4emlIjB3lnbsqU1x3Aux+/Q3CU
/6lu6PU3NP2RFrZP8fF/m2yJjYbofcDuaMn0tjLS06OMtZHZDuigdOUhBWchbEIO
D82R0UHAwq7NrkZOYZtHsLuKp+m1yw==
=86GQ
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
