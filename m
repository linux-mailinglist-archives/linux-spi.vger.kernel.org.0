Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704811CB08A
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgEHNdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHNdj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 09:33:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1B120708;
        Fri,  8 May 2020 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588944819;
        bh=mONIV7U+kyBJ+32pgZbmybpjfg+r5T9JwvmQQECspjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nyn14izNbLw13+C8aRmGKLcZ3BwlQUuLEJ+wYP5GhFb2XP30lsbQM10NmgZC09Vk+
         UckP1Oje+G2jOGzqWw2Ut/0r8k5jd+3UhDGOVWT+ssUTm6Cvxir3gVhiZHdxwzrl2M
         ywV18wQajYEE9Ko/eynJhng+mXsz4m3l1ELplzdk=
Date:   Fri, 8 May 2020 14:33:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200508133336.GK4820@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HcXnUX77nabWBLF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 04:29:25PM +0300, Serge Semin wrote:

> Serge Semin (17):
>   dt-bindings: spi: Convert DW SPI binding to DT schema

Please don't make new feature development dependent on conversion to the
new schema format, there's quite a backlog of reviews of schema
conversions so it can slow things down.  It's good to do the conversions
but please do them after adding any new stuff to the binding rather than
before.

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61X7AACgkQJNaLcl1U
h9CLnAf+O/mkQGXZWskF1aU9ifA3WKCaGO7ENKOG2HlI7+/2BtDt7ImOkCrcBbKb
K9yAjXfWqhx47uiQoeLJtmdZQVBhn73fL867tXqzbvo1IfIw8nAk7VNmePzIDMcL
61DQCKjbmBvQd70xDDzjrOCZbMSJ5zzjWSBClVFZDi7VvB0Q7ngIRoWJkKy/mm8D
joP8Y76nidk0LMvKgqhmCwxIXKTFgacy9ld8zckl1VgkzFAQ5AT1yKOOWZiCUHMt
8dfJt0DwzuBEUKUDcGFXFg4duheda20SgYnFkrM19Nh/D39dqJ//xyCUhViWz/yB
GaOwQ+OgauLqiTph56P0R/1rFek2/Q==
=FjO8
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--
