Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FF1BD8D0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2JyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 05:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2JyK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 05:54:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539BD20775;
        Wed, 29 Apr 2020 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588154050;
        bh=452VjGK66kSXwxqtayitNeyhDtlrc3sCAPk5XNOPFIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPwVpsMn7ZacqtQpHdfwWiIWdEva/CPwf+m9xczA9aV0gIBySjkTWIg3Ykyy/CW13
         DNjK8qVUm5AyFWGLBjbicAnfMSBe/dia6dpUYqMA6csT9ibMQfUOa51IrvgXifBv1U
         6A1gDshRLSkF9NA2FlCphsEJxfnDr2tk63MCexhg=
Date:   Wed, 29 Apr 2020 10:54:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     sanju.mehta@amd.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-amd: remove unused variable 'opcode'
Message-ID: <20200429095407.GB4201@sirena.org.uk>
References: <20200429013018.34046-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20200429013018.34046-1-zhengbin13@huawei.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 09:30:18AM +0800, Zheng Bin wrote:
> Fixes gcc '-Wunused-variable' warning:
>=20
> drivers/spi/spi-amd.c:171:17: warning: unused variable =E2=80=98opcode=E2=
=80=99 [-Wunused-variable]

This has already been fixed.

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pTr4ACgkQJNaLcl1U
h9CkAQf+IKXz6LRVF8IUR2H69XiPXB1wfQ1e1LUpitgHRceNMbJxLuIBoTzFAjEY
JBcMj52tl37rJtsGZHEJswjlgrCA5NdnLvvjXIgXSZffkz5OmjJlQhJ+jqMNTIhc
1dqS2AIISchLxd3zFxs2FkdcRO87WybcCCP/Rqc/vfijnW6E/ypMwLsMJOiFBsq/
P53ZMbM1atAVLpMJtPzSy2T7X41ErfdnUbw1dGHt+mw8sK8q8fcEOpkXJiCN/+Yg
sVNyrJl1xo+mcbsz5XbaAsgi2Ov19vORFSeEigv7WdUo40uaVqku2Uj167lYYsBS
b15lo+WXaZGwLzs59mksXJumu2V9VA==
=eGJ8
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
