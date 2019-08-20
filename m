Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05A895F5D
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfHTNDB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:03:01 -0400
Received: from mail-wm1-f98.google.com ([209.85.128.98]:54230 "EHLO
        mail-wm1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTNDB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:03:01 -0400
Received: by mail-wm1-f98.google.com with SMTP id 10so2550499wmp.3
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pbpRd9PauQivhKh9PL1SEmY+8MgtL/PIqu/P2/TIZGk=;
        b=M9o7xQd3lDeNylhC4lYsYyeT61oInar8rTr1+xvDVrtrrh2diBa+Dqy7XUGELgFCXo
         SaoO74ururD0ehZo9ZJPJfVq6AxIOTp+MMQxmHnQwB6Rxm/27YuagxQW36G9qAek7MTL
         P5sFXdxDugJewrN9lPhwha8u90FZTwhr/U6vEE7U7YIK1sNsmjGOQSjnA3EED9wcYY9E
         V36ROuXtst5McRGpRhjoanE0HEfAKqB2ez0ACzLW2WijmSI6ptbncz+pwSWODfr7XXR0
         KrxTmYV4o560RSETti24jVJn1EaIH4tTwwzjBNlGyfG2u0NZeGukkdtHsTrp2j7tF5Km
         +Jhw==
X-Gm-Message-State: APjAAAXRUHlcSzpfacAUfRLNhHvMSSVS/K9n4zFtUeyvbiMhB5q1/85/
        okP4WkKsnUb1NjW04HujMRsCg6rzyscnK2HiIdEpgVZuJYlRqC9GfUg3A3tSDB//JA==
X-Google-Smtp-Source: APXvYqwcoINOv+g1/o5dZVW62lXQoKcz63FfgPTb+kqaPeByVKteMbAUnZcAQIOLU4/ZdQ78OvedddH6TMwT
X-Received: by 2002:a1c:ca11:: with SMTP id a17mr2053533wmg.45.1566306179457;
        Tue, 20 Aug 2019 06:02:59 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id v4sm273520wru.23.2019.08.20.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:02:59 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03mt-0002Gl-39; Tue, 20 Aug 2019 13:02:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 19BEE2742ABD; Tue, 20 Aug 2019 14:02:58 +0100 (BST)
Date:   Tue, 20 Aug 2019 14:02:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH spi for-5.4 13/14] spi: spi-fsl-dspi: Reduce indentation
 level in dspi_interrupt
Message-ID: <20190820130257.GD4738@sirena.co.uk>
References: <20190818180115.31114-1-olteanv@gmail.com>
 <20190818180115.31114-14-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <20190818180115.31114-14-olteanv@gmail.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 18, 2019 at 09:01:14PM +0300, Vladimir Oltean wrote:
> There is no point in checking which interrupt source was triggered in
> SPI_SR, since only EOQ and TCFQ modes trigger interrupts anyway (see the
> writes to SPI_RSER). In DMA mode, the RSER is configured for RFDF_DIRS=1
> and TFFF_DIRS=1, aka FIFO events generate eDMA requests and not CPU
> interrupts.

It's also good to check interrupt sources in case the interrupt line
might be shared, that means that it's possible that the interrupt
handler will be called when there's no interrupt at all from the IP.  It
also helps with robustness in case there's some system error though
that's (hopefully!) a lot less common.  This driver does set IRQF_SHARED
so it does support that, I don't know how many systems could do it but
it seems a shame to remove the support from the driver.

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1b74EACgkQJNaLcl1U
h9CRfwf+OkHzZHRN6E/u5MxnoBQoS9g28qi6T6IuBc36lzYOorfD5QAuvfDEzXiN
NXAaDSS4fV6KTQMq0rP+v7ksXrIRa4f2ViC5yopopiTtQlTvlxcQccmV09VMG+ka
EHLUmgVynCBw/kmzcB/VQBJ6qFbByDQQHlcxJqNYM1bE/A9S8WAANWMtQGdpBQxR
YAnFLSjFjn4FKjyZ090RPHs6lgE7QqSdIAnSN4IO2tQ0nx06Lzbstim1fxkhgj+q
Xwd+ZTNvJzW4nHeEfuu6KnCs31x5mGNnbLocNXmnBalbX45J27GY4sQJQ7csv1Fu
zLKC/NePn4vSzyyKE5gdjEB/8QNwGQ==
=0392
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
