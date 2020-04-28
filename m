Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F601BBA82
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD1KA6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 06:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgD1KA6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 06:00:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB5220663;
        Tue, 28 Apr 2020 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588068057;
        bh=TAYZrlBNourlI1Exy25uV6LmaGBIsfM/j37IDhRQBeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YP3gcmI+bToxhAjSyPBKppOBFsSNVTOnQ4aujEb/Jz8bi9Zhyue9jtvZVCasxvidc
         bOAcar/jfuiUUTGcjCHxgN/CN6gTcY7DsgWGNdj8wdmS25xH/O7JwKNKBttGlyI/lc
         tLkzNQxg1tO7mfII7r2Uj8h8XUMpaNLUOW2dzRgI=
Date:   Tue, 28 Apr 2020 11:00:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.schwierzeck@gmail.com, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
Message-ID: <20200428100055.GB5677@sirena.org.uk>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <20200424112505.GD5850@sirena.org.uk>
 <616a5419-add3-085e-32dc-c83d9d975725@linux.intel.com>
 <20200427134555.GC4383@sirena.org.uk>
 <43ecffb1-4786-c038-09bb-648657c0f5f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <43ecffb1-4786-c038-09bb-648657c0f5f3@linux.intel.com>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 01:39:06PM +0800, Dilip Kota wrote:

> Do you suggest to use different ISRs for multiple interrupt lines and single
> ISR for single interrupt line? I see, this results in writing repetitive
> code lines.

It looks like the shared case is mainly a handler that calls the two
other handlers?

> Does single ISR looks erroneous! Please let me know.

The change was not entirely clear, I was having trouble convincing
myself that all the transformations were OK partly because I kept on
finding little extra changes in there and partly because there were
several things going on.  In theory it could work.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6n/tYACgkQJNaLcl1U
h9ChBQf+PGiMHXg9hs8O59dO1hggZfS7HcB5IPZdYhr6PQ5YTYvPR6Ay2ydDj7jY
tiv4E3ovjS8V5PGZo6facwPnmMGE5koCu7kwI9ZzZ334qMBlFI/57RbS9ghNGrwc
GUcfgt8W1YedLNaBmG11F1rLv4A7QpDfTIKONLdFbOArUY3Mxx2jX/AQUkDKV69y
Rrvto8lLvpWAwrWBXptzx1SldSwpbqvc5JblvXzumbaJid9znHrn4uy38a9WUpeP
kxOUdEW6bN94PHMH4ceLW3zXrPVJDSW1BeAkwFa8mQJcZTLQ8otwQgDcXV/WyG+h
XeY5fDQmBrsIeRoWgYF8MdTDArWYhg==
=sirA
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
