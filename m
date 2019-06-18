Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF649F35
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfFRLaL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 07:30:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfFRLaL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 07:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QerpjVgfGyK+CUUkW3NhKmw4c7uVZ7eMF5Igj39mQ5g=; b=mb0HAM+gM6Qc+8y7doOZWRy/w
        RuTQU3ILgJblKSY8TRhhCkPGal5Q28zk3P0eeM4qP3ODYGM/G0iQc9jLtTMLqSBARdKp6LfinOX++
        oS+x004yFT4g5+6qtYJqPnoTarIIVqpfACOwmqvE89ga+xRK7s/TD2AxxtPR6FWRV0JMI=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdCJP-0004wc-AS; Tue, 18 Jun 2019 11:30:03 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A48AA440046; Tue, 18 Jun 2019 12:30:02 +0100 (BST)
Date:   Tue, 18 Jun 2019 12:30:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64
 dependence
Message-ID: <20190618113002.GN5316@sirena.org.uk>
References: <20190617060957.16171-1-masahisa.kojima@linaro.org>
 <20190617101741.GK5316@sirena.org.uk>
 <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
 <20190617114630.GO5316@sirena.org.uk>
 <CADQ0-X_1kNChYr_vvOiafghk8h1AcERaGYWjo61ATLXy0_f_UA@mail.gmail.com>
 <20190618105714.GL5316@sirena.org.uk>
 <CADQ0-X-HSPMCY+NY5g_53KY18M2E-W9VJiUOrxB7oDy0hx+EeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EsYAkl0fYdqumOJS"
Content-Disposition: inline
In-Reply-To: <CADQ0-X-HSPMCY+NY5g_53KY18M2E-W9VJiUOrxB7oDy0hx+EeQ@mail.gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EsYAkl0fYdqumOJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2019 at 08:20:39PM +0900, Masahisa Kojima wrote:
> On Tue, 18 Jun 2019 at 19:57, Mark Brown <broonie@kernel.org> wrote:

> > On Tue, Jun 18, 2019 at 05:13:57PM +0900, Masahisa Kojima wrote:

> > Please don't top post, reply in line with needed context.  This allows
> > readers to readily follow the flow of conversation and understand what
> > you are talking about and also helps ensure that everything in the
> > discussion is being addressed.

> I'm sorry, I understood.

Rather than writing your reply to a message at the top of the message as
you did it's better to add your reply after some of the quoted message
(as you've done here) since that makes it easier for people to read your
message and follow what the reply is about.

--EsYAkl0fYdqumOJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0IyzkACgkQJNaLcl1U
h9B9xAf9ENz09xbXOdv2Z+F9ugYH44MRoBVsmtfvALCcLEzuZ6UNJOoUyLPrPGMH
qJHaT81bYJPClMkR+Qxr/4uzMBheeCbfG5ExjbE2l3jOBDPDWt44hcAiVP2nKyYV
feEZYX0SCHakPnXen5FnpihO6FyIgYK9NicXVTJMmjiWrwtrZgF31Ag4dWOjNaFp
CT+jLVVu0yT6nM2MvpJhnA3H8QpMForQatQ1hmrCAVc3oKykyaD8VHs11tgCm4YT
7fXrkESCgML/9Q+MHZ7wGLdL3a6MRPP2y7EOg7WdLXVAXxqA+qVadlOSNAwARhZp
trHUVBXIijbRXmvnDKL1tOiq6MnvQA==
=vopH
-----END PGP SIGNATURE-----

--EsYAkl0fYdqumOJS--
