Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9A3838A5
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbhEQP6T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 11:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343678AbhEQPwL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 11:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4AD660FEF;
        Mon, 17 May 2021 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621266611;
        bh=v+IC3Fkn1DqRIQwuacT6a0xfUaK38TnZ1/oziVax828=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSAPkrr/3SMLee031CW8f4eOd5n/X3JE/mc/8VXp8VL3t9DBBxBVWdatqrv97V3mW
         VGlkkuRK4Pjs117tXrGX6tSK9t77HxqYJFe4UdYZpHryNHdUM4ZDGQeEsiCLDnmIqL
         k068TXNngo9KRei/UmvJeyhFbHCryChz8SxMt4oCvITGreSvvJMz2YqnLHoHW/EQdI
         nX5bcIXN4Ujs+36xmdcpU2dylksDiPFV/8nMXG1I4T2QNEfrmTkTsVBN6wdZL/pXGg
         +3d2XA88EmMQeYLTMI3IOGjdESq+H7xGsqKuFI+ZZHrluhdTxh5ti8Um/5eBxC5b6G
         CvCIp0G2fjUHg==
Date:   Mon, 17 May 2021 16:49:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, jaimeliao@mxic.com.tw
Subject: Re: [PATCH v5 2/2] spi: mxic: patch for octal DTR mode support
Message-ID: <20210517154928.GA11957@sirena.org.uk>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw>
 <1621232088-12567-3-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1621232088-12567-3-git-send-email-zhengxunli@mxic.com.tw>
X-Cookie: Chicken Little was right.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 02:14:48PM +0800, Zhengxun Li wrote:
> Driver patch for octal DTR mode support.
>=20
> Owing to the spi_mem_default_supports_op() is not support dtr
> operation. Based on Pratyush patch "spi: spi-mem: add spi_mem_dtr
> _supports_op()" add spi_mem_dtr_supports_op() to support dtr and
> keep checking the buswidth and command bytes.

Acked-by: Mark Brown <broonie@kernel.org>

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCikIcACgkQJNaLcl1U
h9COewf/cNm1FKSaKXYdSEaP+MjW1+CYInU4QTZM6ElWK+dZ4tXlCCZnVDdLcCnO
glQrPUsJMgCtaldBE0FPTH7QrkDbHQZSgXCWeLIjaVJN0eKX+ZwDCmiVeiA1Hirk
3ShedrPGD8fZztfwp9wGpyKyHiTZysZVL0gSNKypar9N/SPFyCQCLVu1JKv5ohHA
wEvZQZF2s7WUhlxAWPm+M7uoAcsLJiNEfM6duVwOyAtTo/bsWnwTAbMtO5bwmvZJ
EJ+uqbA2D6KgbNhPWQ5RYT5HcjDfu5Rn+trvWOyPvN6PvkIWGt8Qqk/vHuTj0MFG
7WqfGs9kx4cqYZ8w/Q/Oyn1ZKpKUZw==
=lT6K
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
