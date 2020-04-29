Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8093D1BDC1D
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD2M1r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 08:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgD2M1q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 08:27:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92452137B;
        Wed, 29 Apr 2020 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588163266;
        bh=7mA/Zs8c6U9jvpH9tx9r1+1l9SOQW7B21xKBrlkGFYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPX0CuX/baQ/e5/z2OKBLvvPRDERL8D+dF//W4IlTYj/XdWT9mKzavqdkzk4D7id7
         REuF8/3HvI6zvCDXSopete1g31JkspbRICJaUVrCQzMnTrbgks4V+DVVeIhVJBGKgD
         0cW8oNZ/p8mypM9yN6l7BZSKUMRgEQsWRglVvDWE=
Date:   Wed, 29 Apr 2020 13:27:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.schwierzeck@gmail.com, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
Message-ID: <20200429122743.GI4201@sirena.org.uk>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <20200424112505.GD5850@sirena.org.uk>
 <616a5419-add3-085e-32dc-c83d9d975725@linux.intel.com>
 <20200427134555.GC4383@sirena.org.uk>
 <43ecffb1-4786-c038-09bb-648657c0f5f3@linux.intel.com>
 <20200428100055.GB5677@sirena.org.uk>
 <68948cb1-6c78-1545-45c6-5a95465b05e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline
In-Reply-To: <68948cb1-6c78-1545-45c6-5a95465b05e2@linux.intel.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2020 at 03:20:21PM +0800, Dilip Kota wrote:
> On 4/28/2020 6:00 PM, Mark Brown wrote:

> > The change was not entirely clear, I was having trouble convincing
> > myself that all the transformations were OK partly because I kept on
> > finding little extra changes in there and partly because there were
> > several things going on.  In theory it could work.

> You want me to split this in to multiple patches?

It needs to be clearer I think, splitting would probably help.

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pcr8ACgkQJNaLcl1U
h9C2lwf/cJDL8NucZllG+sa3PyODhCd+PwPyu4pLzLIM6VkzittYtDhkl6KLLEGw
Z9v0mNb/5SzCYheDtBoHnrBYGMF1tCKDNDwsNcMYPH2BpjRrnE1urK0X8bn2fZ+q
R3hvILiFClc0PaPP+afDjUayLT6P8qEQk5CYQQV7OPXuE/a99RlKO69MUKi4Rm8i
g4lFya3vRW/wEK8/vuBZLlFBwqL6iazg3SasB4Y2imNJuddGBtx2+6sNM6YcLQzi
frL3rC+q+JuGDLiXGwJsmRCBb3rr4kOC0/qkGpdr1WXaoF8wyNYMGoJH9z+A/vDj
7C7F9rEVsU4wvk0RtM5MwSfaa9GzxQ==
=lX60
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--
