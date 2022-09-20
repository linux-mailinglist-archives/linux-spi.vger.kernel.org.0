Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260B5BECD3
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiITSd5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiITSd4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 14:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420673321
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 11:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8152462C91
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 18:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A5BC4314A;
        Tue, 20 Sep 2022 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698832;
        bh=jZPwPUHYqf0F8riCrfrT/bL8YNi30q6cllFy2j7Of58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4bawdLT6uDyo71ImbUUSLZjOfUBRyRBefw/qUnOODwA3ifm5DKGOD9iy+XjlqG9j
         jbBp5mYf8FVUWLNu7KOIu3f4tbgpaMYPdeneORXr3Gf3ycKolKtHffR05V37qlcQ+z
         hCxpsYQS++/KVZWOM+MQ/NnVTi7AXXdkkvsDZl1wwDWYKoc6DIlcJMzM/wytScU4Ye
         xEbppuqCvbWWZjO+TRrJQy0r/7eIoK4rOhdKHhCCPQ3VdbgXzjUDMH4CQZKc3oICQR
         6x2zM4ESVwmyxSgPy8haljWqjjpnt/MOSejMwHNQDaQJmmbdTxeUrS420eadEoqIUs
         im6Htx4iidUkw==
Date:   Tue, 20 Sep 2022 19:33:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
Message-ID: <YyoHjY14hSJj85oP@sirena.org.uk>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eJDno4sWW0q+1BEp"
Content-Disposition: inline
In-Reply-To: <20220920134819.2981033-1-yangyingliang@huawei.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eJDno4sWW0q+1BEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 20, 2022 at 09:48:13PM +0800, Yang Yingliang wrote:
> This patchset is trying to replace spi_alloc_master() with
> devm_spi_alloc_master() in some spi drivers. With this helper,
> spi_master_put() is called in devres_release_all() whenever
> the device is unbound, so the spi_master_put() in error path
> can be removed.

If we're switching please update to the modern naming and use
"controller" rather than the old name.

--eJDno4sWW0q+1BEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMqB4wACgkQJNaLcl1U
h9DqRQf/ZCEqNCEm2Hgf5DB/RKiYx/NiwCA/yXab1x373K8ykEnRqJhJv8oqeNZy
B1YyupuX2JfUnubf32AwYxNwL8fZaI+CyiO5yRJ5/Q07bKm91dmUT1uxX5eGtox5
1aiHS9tmuAAQXC4j85LdxeiGj3da9GpHALZ0J9Fr8AQ5BNPqAsqYaOcuFD8wc8nF
VKv1ao+LEK7xTs0LSgdwi8bkLnaf57HwnrpD1UEgMa87xe2LtPadBUNKRLG520l9
pgM5v1TFc3VMEj1MdXbATTxtdsvk8h+q2ZYeTl9VDvFkokkliOjksOWOz/QD1aYh
9tCIRU52vZ7cNFK1B7um2T6GOpsSzg==
=lv82
-----END PGP SIGNATURE-----

--eJDno4sWW0q+1BEp--
