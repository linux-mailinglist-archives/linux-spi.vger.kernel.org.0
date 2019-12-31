Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7D12D53E
	for <lists+linux-spi@lfdr.de>; Tue, 31 Dec 2019 01:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfLaA3c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Dec 2019 19:29:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfLaA3b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Dec 2019 19:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E2CRVJ0pla31OGboSymJBtJ7FSxHvmOY1w9JQQvCD/A=; b=GrnftHYLdETCv0Vpbc20gNKrT
        /9Sz3zOodG517fi/mF0KZxhh41t7FO7B809arEewV5h72lnVOgkPVR6GiH9act/hzi/JQtJ/OOQTj
        BKqkIq3O1ZbRvXunl0PS+sBESQLSd9cYc37b9FCQbpHUvtGmeVZdKsC5HebVUVCGIF+lk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1im5Pd-0002nL-4G; Tue, 31 Dec 2019 00:29:29 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 87AD4D01A22; Tue, 31 Dec 2019 00:29:28 +0000 (GMT)
Date:   Tue, 31 Dec 2019 00:29:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "wuxu.wu" <wuxu.wu@huawei.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com
Subject: Re: [PATCH] spi: spi-dw: Add lock protect dw_spi rx/tx to prevent
 concurrent calls
Message-ID: <20191231002928.GD3897@sirena.org.uk>
References: <1577418669-34821-1-git-send-email-wuxu.wu@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <1577418669-34821-1-git-send-email-wuxu.wu@huawei.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2019 at 11:51:09AM +0800, wuxu.wu wrote:

>  static void dw_writer(struct dw_spi *dws)
>  {
> -	u32 max = tx_max(dws);
> +	u32 max
>  	u16 txw = 0;

This is going to break the build, there's a missing ; in the
declaration of max.  Otherwise this looks good.

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4KlmcACgkQJNaLcl1U
h9AA4Qf8DzOXFKYiWrGAwiKjNf1jfbj33s54tU8nmpfWwnaLfIgpqwSj0fTRnfwy
tznV4UozcwcguyMAsbl4vn5Q0OrJOQfeLhwGdVBKXkJYOJLI40cgn0MFC6Ts4Ux3
il8MXI4Y93xXZ0OJh2BoW+j1MGNsCmAJ8PqtWiGr7yNygcp8aNmyytjXGbuBVooe
aiKeSt2yCDXUgWkkPS5CEcuLFmjodgumOlHravhrdDpRcAUR00YuTPCooZ28AMpx
kq+DAG4w0CcSyOsZcm0+ZJjIyO1DY5BYbNlb4TJJNPYQ6wNBi/3buiDZXfeBlGIN
DwRokHH0vSzHS75GN7ha/Shm8Bq0WQ==
=UER1
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
