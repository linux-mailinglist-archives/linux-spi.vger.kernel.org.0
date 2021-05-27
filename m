Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4108392B78
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhE0KL6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 06:11:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbhE0KL6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 06:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bNKkv9yJxBEyyDXHTUI6SZKiK1yjUg98KtcVpsPAERU=; b=Ad4mx7H7JX+wqD1k7MIb21sNfA
        B346yA3Yw8MFkddKzY6LWlqbCZhUMzWbR/iezUataMYFiyL/ZNPjv7PBOLxhQuQDYmEEOhRGplLWZ
        vbkn+rXHT4rom83k8KsYdSVirrzXy9WoKv0/LXhF0lIFROTosso3MrWBLdoEOcSpyqEE=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lmCy7-006Lnc-Ts; Thu, 27 May 2021 10:10:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8CF61D0DEC8; Thu, 27 May 2021 11:10:21 +0100 (BST)
Date:   Thu, 27 May 2021 11:10:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spidev: add platform driver support
Message-ID: <YK9wDd/+c1uAjwk7@sirena.org.uk>
References: <20210527084531.18989-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3c1S3HTTKrvMj23"
Content-Disposition: inline
In-Reply-To: <20210527084531.18989-1-christian.gmeiner@gmail.com>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--r3c1S3HTTKrvMj23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 27, 2021 at 10:45:15AM +0200, Christian Gmeiner wrote:

> This makes it possible to use spidev in combination with the
> MFD subsystem. The MFD subsystem add platform_driver devices.

This is a really strange thing to want to do so it needs a
changelog which explains what the goal is and why this is a good
way of accomplishing that goal.

> +static int spidev_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *parent = pdev->dev.parent;
> +	struct spi_device *spi;
> +
> +	if (strcmp(parent->bus->name, "spi"))
> +		return -ENODEV;
> +
> +	spi = to_spi_device(parent);
> +
> +	/* This only works if no drvdata is stored */
> +	if (spi_get_drvdata(spi)) {
> +		dev_err(&pdev->dev, "drvdata is not NULL\n");

Why?

> +		return -EOPNOTSUPP;
> +	}
> +
> +	return spidev_probe(spi);

This really does not seem like a good idea, this is exposing the
entire device to userspace in a completely unstructured fashion
while there will be other drivers controlling the same hardware.
That seems like it's asking for trouble, there's absolutely
nothing ensuring that userspace doesn't break things the drivers
are doing.

I really don't think it makes sense to mix kernel drivers with
unmoderated userspace access to the hardware in a single driver.

> +static struct platform_driver spidev_platfoem_driver = {

platfoem?

--r3c1S3HTTKrvMj23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCvcAwACgkQJNaLcl1U
h9CA1gf+LtoavMTh0+w1zEhGPCH+/YYD6y9bOFbrKoh5teYYrLwMur2ogt9d50Jw
qlyqeieFrDY9hWjQcDBUnT/Lt6Z2FEZTWpp4fmvhQwLQodHHkkDbpUaTDbgHBX7E
cP4jxSHa3TaecEMV+405QQmKCX6g7EQXVQygipgAcYU2bxnt89GGWxNSuSdU+0SS
aWNNj/Mx21sgUzIJQ0fJ4CL8I8duBXGoj3eNj3V2WVui7dTShyZUUYYrVZ/3nQ1l
UnZZX2G0YC/IARmpCPuNWtkG+S9WFgvkQ1aeC22cBkNK9d8oqFG1oonPusv0aJcc
vVJcrTDQNbbLxo5iChzksEZENG0exw==
=vDdo
-----END PGP SIGNATURE-----

--r3c1S3HTTKrvMj23--
