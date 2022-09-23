Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445CD5E77FF
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiIWKMa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiIWKM3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 06:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79856127559
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 03:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F400160FC0
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 10:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE79C433C1;
        Fri, 23 Sep 2022 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663927947;
        bh=7ueYBe5BRNiJkkJYW3omcGhySnPdxBfj5NHKL/p0M5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2cISRHHPNXmWeqi1q1nG7wgOX7EMFb8Hu5a/TPb6VnYprTVT2kk1Hhq8AIMHyVu+
         qrTyo4qw9A7f1ri7eMps5ROu/h66FVvqT5FVTYOLmxus0Ma/3HuREzXOUUwb0ZBFKV
         vY0eH9yYN1tgazH9McF4TMAFfBgKDv8AzG0RuhTt7BsndaiCaDdosc33dGmBa+KBnm
         tu4y8C5VXt02ab+vTueCXO6aJul285ieeV2ZPfUkiif0juw+tef0OzCzLXRH+GGUen
         r3DP6YZsM4M61A9/ceW33X5lD7iT0ONk1OkRJNfTQfRmXmQxD/lU3iVXBYiVmnqXr0
         DWQOc8TCZg8TQ==
Date:   Fri, 23 Sep 2022 11:12:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
Message-ID: <Yy2GhucvJyMwFAKV@sirena.org.uk>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <YyoHjY14hSJj85oP@sirena.org.uk>
 <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
 <YysEH6MwNc8naD27@sirena.org.uk>
 <20220923044258.GA28079@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RzD2smrIxAWnnJ6a"
Content-Disposition: inline
In-Reply-To: <20220923044258.GA28079@wunner.de>
X-Cookie: Heisenberg may have been here.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RzD2smrIxAWnnJ6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 23, 2022 at 06:42:58AM +0200, Lukas Wunner wrote:
> On Wed, Sep 21, 2022 at 01:37:49PM +0100, Mark Brown wrote:

> > Or just use devm_spi_alloc_controller() directly.

> There's no such thing.  The driver needs to explicitly allocate a
> master or slave and that will result in the slave bit being set
> correctly in struct spi_controller.

> Yang's v2 series now calls __devm_spi_alloc_controller()
> but drivers should never call that directly.

Right, we should probably make the actual function to wrap that though -
I'd misremembered that that hadn't been created.

--RzD2smrIxAWnnJ6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMthoYACgkQJNaLcl1U
h9CmTAf/TfdlJRp0rc8fz5SUNHlf4cmppE44d/9kw9N9+1nTxrEXgG1re0gVkN+2
ELGbXICiCf76HHVEzQhLYQIXvsm0BWD7OKw0E3tyjnAmkIrxZozP/n0b3WwQI6D4
1e6zlSkSt1dLkGmJvtmpSjwx+hxwaaf0dGAw3pVxGXgeRVOX1gkb77xZeUePYh9D
dgNHaLUioM38/mSDo3pmsMI2uMU4RRUy5NFaVD68DSO0YOT8dzsNoEi3oX+dh/ef
0md/HNGqHiI/kylf7Oc2EH/lnN7feLNZhcUdKq4JYIrWOYdpyISCe6d/ShGRoG0v
irliEXAAlBkb3kdxRKBFOUdBySVWKw==
=dmlM
-----END PGP SIGNATURE-----

--RzD2smrIxAWnnJ6a--
