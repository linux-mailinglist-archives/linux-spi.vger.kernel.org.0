Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56FEE05E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfKDMrX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 07:47:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46862 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfKDMrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Nov 2019 07:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nQW/bkzEewczaxT+3uYr2EI926apxCfUzfvK6W9flNM=; b=eX9YNLdaHWXApFC5WH3YUJSoz
        duye5V5aJxyEa0X2sRrWdWgQsDTo4uhgIwg2UK8SaMVGp11RGSodOlIl07eRtejb2BzATT5SOEPtv
        lq9Hkne174NX0ErvZCPnbeJU5n9yGScoQnxfQfhkJYoxb2ct+DWNG8cLD4lKkgleLNPE4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRblP-0002Yo-Ij; Mon, 04 Nov 2019 12:47:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F2AE1274301E; Mon,  4 Nov 2019 12:47:18 +0000 (GMT)
Date:   Mon, 4 Nov 2019 12:47:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     hslester96@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sifive: disable clk when probe fails and remove
Message-ID: <20191104124718.GC5238@sirena.co.uk>
References: <20191101121745.13413-1-hslester96@gmail.com>
 <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 04:07:29PM -0700, Palmer Dabbelt wrote:
> On Fri, 01 Nov 2019 05:17:45 PDT (-0700), hslester96@gmail.com wrote:
> > The driver forgets to disable and unprepare clk when probe fails and
> > remove.
> > Add the calls to fix the problem.

> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3AHdYACgkQJNaLcl1U
h9Bxbwf+PS/3tt1r3nRdDUeTgiw12asFTlFdosGPaCdJ0zCp0XBMPgFZBia9R16z
QBrOHOQ5BL+W7FEEOh9hfPpvdVPzgygwAip2n2uHEWrOZ7pt7PWoGj2ybu0JDXTu
rPhwWNvY36hCVKElOiixQeR43pU7yKJZzPoWVTxJgGarWaE03ngE0jEvQUqtsVMB
aI0LNK076Dt9geC7wg5FFSppQTVv6c9PvpTehaS5hKvY00hfUS3i9uFgYsXjuggz
TYsKknIrHD0gm0Q1bCfGK7u6C3YkbyPs6uj1j2xZLh5isMgVokBkrlpkbpMtKl+i
PPxqmUKox9ymgSDfmnZ1yGneuS3qVg==
=2j2y
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
