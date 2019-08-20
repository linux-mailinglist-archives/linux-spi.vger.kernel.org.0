Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592AC9687C
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTSVc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 14:21:32 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:44110 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfHTSVb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 14:21:31 -0400
Received: by mail-wr1-f98.google.com with SMTP id p17so13363505wrf.11
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 11:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5162E672VStvIUQfjEDN4iUa/Yrr+6tNSivQii4slfw=;
        b=lYzHtW9HL5poKnAiawk4BCKXgdmBZ0jKEzH5cNn3SAKgBYC1Pw8dMaZCyJiNX2HNRg
         sVFlRl8RtoK7EiBkjXMDyqGCwKvbhbAY6DyFqddbuNzQeWe6PK0EHx9waV20QGSwEX1c
         X1+RaGQ7EfffGviGAEDCDv4peEunaZr4fkVLOvAPxaBLNj/4YNRM6k0UWrWJW4IsrPzR
         PKFQPsRcAzslpS6jIxcpaO8Hn0pTVtVj0fkWwedVHbB9jKpUuKmdAld0DKL9G4oTZ+5z
         pEdNhFfCbT0o7f4z/1cNh6DmdiE7DKYoO/QEpyBdPMFzQ57aIBDpTW6lHrgETxmm+yLX
         m6Sw==
X-Gm-Message-State: APjAAAVFPExylcB/4F7cC9eMZsONBeR3v6CWucuyt17uWbWF/6PVsl0/
        SSE2GEgP92hZuB8sEBc7uvyWPDwo90BcvFNpePMyG5EZ6ZSr1B0SnFK8b68wJVoMvw==
X-Google-Smtp-Source: APXvYqw8oox5OaDCjhyZSnp/lm6NUy2KCkbIetE8wO/hHrE85oICEbjiUOXlfQ7UW7HSa5+oWtiWRKL59yqM
X-Received: by 2002:adf:e504:: with SMTP id j4mr34948926wrm.222.1566325289670;
        Tue, 20 Aug 2019 11:21:29 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id f19sm2750wmf.37.2019.08.20.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 11:21:29 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i08l7-0003Bf-C6; Tue, 20 Aug 2019 18:21:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 453122742B4A; Tue, 20 Aug 2019 19:21:28 +0100 (BST)
Date:   Tue, 20 Aug 2019 19:21:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH spi for-5.4 1/5] spi: Use an abbreviated pointer to
 ctlr->cur_msg in __spi_pump_messages
Message-ID: <20190820182128.GH4738@sirena.co.uk>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <20190818182600.3047-2-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <20190818182600.3047-2-olteanv@gmail.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 18, 2019 at 09:25:56PM +0300, Vladimir Oltean wrote:

>  	/* Extract head of queue */
> -	ctlr->cur_msg =
> -		list_first_entry(&ctlr->queue, struct spi_message, queue);
> +	mesg = list_first_entry(&ctlr->queue, struct spi_message, queue);
> +	ctlr->cur_msg = mesg;

Why mesg when the existing code uses msg as an abbreviation here?

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cOicACgkQJNaLcl1U
h9AOqgf/cjzfm7bvt631xQj45WADd1zxrsMogZIZK1dMYJhoUv9wZeeG9HRoTiQV
KFWp5wZJG7DZpJIIOTWvJruK9Kqg1xDx6Vn78qLBPwJDq9JnFb4g/PHV3tTkHGk0
QyexBehdFr6IcovmKnA2uyp0N3fSIgzysv5CfB54NqyZMwE+9hCzxnE+N2DsKjfn
FfLRuyDINJJChwWQokpNnlTYP13mpe7UTBueTxn7ye42jBbgIkrPV2JYRZZQtZLY
QP3+0raudadXAc67mHcQgNGPB3G9TRZgt3M1QEw9sOUb7uvqQBTN6roL2X9JEeVB
LQVdcmmYX4v6Qv8O731AKmKVvnckBw==
=BmOu
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
