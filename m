Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9885ECA5E
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiI0RBr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiI0RBp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 13:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65DE6B8CB
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 10:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFF1612FF
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 17:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C6C433D6;
        Tue, 27 Sep 2022 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664298103;
        bh=e1DaEBdNGacwimNKQbn5J4uq1I8n3bPfi5z5sz8/xzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPHwAhQl0zLL9l2k5Wp12KrVL5KUoTqiO+rzn3BvQ10hLNuBXB+OnRAqie0xkoZwE
         6i9ZvBPqP8gqLJ587zeFQjnBmkD7r0yyOCBEa91+ZU0tD48ljdFNhvGibmJ/PfZydr
         jElKbpAH7uBEkhou3yBiAQ13HBzROGlR63zrhk74WaDJj+EYfA6g7LG9WxL0ZBwvSK
         ffSPQd2bQXtFeHf7yq2YBhkwa93rOMXDBNBMo1JeRFur6tNxRQ7td/I6fiwUrEeMfg
         jfD8m6LIhOoISwGk8mdtfgoL2cSB5XW7I1OUId6fTlq+wR9RO3sDtFR9i6wNkfwoqA
         TdItfUeTH8FKg==
Date:   Tue, 27 Sep 2022 18:01:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzMsc1IM/73CMEeg@sirena.org.uk>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ip0YQvZrw0f65TAP"
Content-Disposition: inline
In-Reply-To: <20220927133129.GA29821@wunner.de>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Ip0YQvZrw0f65TAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 03:31:29PM +0200, Lukas Wunner wrote:
> On Tue, Sep 27, 2022 at 07:57:05PM +0800, Yang Yingliang wrote:

> > Do you mean to introduce two more proper wrappers to instead of
> > devm_spi_alloc_master/slave() ?

> Honestly I don't think there's room for (or a need for) improvement here.

The issue here is that we're trying to get rid of the master/slave
terminology.

--Ip0YQvZrw0f65TAP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMzLHIACgkQJNaLcl1U
h9Bm/wf/c5lJQ7W3Merq3KZJhvfvM8cxKkujqfTwGTs9sE+DK4f3CLj+L4z693q6
6QBSd8WqqRZBCLA3AS7Y01QV7nT4/58Y2tr3HnSh60/kEeuyfrSfoaWtbxQlqmOX
GCqdyXJcGu9HWbWI7yOKXUoOFHe3KkaME/ZYP9/6JGd1iu8yGZMEeQ+F7b5OPsdQ
IhMwaeImRu23p4WT+xAT0vXfbhCixfFmm0UFsK/4moxHOGXDrtgmXyKo0QMKGn8z
92vHlIVb6cLreWsdKBKP4e7qScgehhrSrJWrNEvzMUK7IqJa7dPqTNQnZWX+CNzF
fJn+rYmrOysNvYzwxYDjczB7U/ZR9w==
=OscE
-----END PGP SIGNATURE-----

--Ip0YQvZrw0f65TAP--
