Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23455C242
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiF0MpY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiF0MpX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 08:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84EEE01
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 05:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D4A611AE
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BAC3411D;
        Mon, 27 Jun 2022 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656333921;
        bh=sgFCqwo4c3R+iDiaE/t/QqFPzNNRZczQ5Rk29j8AcuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrOr1BFrzAxhyLQJr0J4NYxQsCVm2jI+MUpBfi4fbSoZh30fP93OpN0EMMQD0tVGI
         I1YiS51x9p63nUwsfWuk3yA0+Kvz/QW4KCsVyms75EglGVCPdJ/r/1Y6fAarAFf9dT
         geOKIlOg/ccEL2jCP7/Kx5vv5d9nQ4KiQtUVx90sz9PKPi1AthJcv717Z9qwBQvvHk
         2bHzETBh5Bwslosl2cLVPfqFm0DOhQsJ5nkaE9QuYMGYta2024KFINay8s2HZAdhs+
         RwPQWvmHs57xmsSDEnva97Nt+C+8VijVbUG9g5XwMBZmMG6a+y7iYbn/LVa9mrrc9D
         OwsQdGZKkMvGQ==
Date:   Mon, 27 Jun 2022 13:45:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guo Mengqi <guomengqi3@huawei.com>
Cc:     masahisa.kojima@linaro.org, jaswinder.singh@linaro.org,
        linux-spi@vger.kernel.org, xuqiang36@huawei.com
Subject: Re: [PATCH-next] drivers/spi: Add missing clk_disable_unprepare()
Message-ID: <YrmmXSuNZExQ3AAz@sirena.org.uk>
References: <20220624005614.49434-1-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ePn7AXaNrl5LBdeQ"
Content-Disposition: inline
In-Reply-To: <20220624005614.49434-1-guomengqi3@huawei.com>
X-Cookie: Your supervisor is thinking about you.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ePn7AXaNrl5LBdeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 24, 2022 at 08:56:14AM +0800, Guo Mengqi wrote:

> Add missing clk_disable_unprepare() in synquacer_spi_resume().

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ePn7AXaNrl5LBdeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK5plwACgkQJNaLcl1U
h9DVOwf+MJHudO5LdYF8l6FxyBbrseYTQh5nohxOmjFHMvtdHiZ3dI7U83US2b8+
JUu67uWIjM8etfXhEO57lrZyXhRdm8Xj4FkTT+450GyyxdC87PZfYcp1Q+GG3F7m
eAk0uy+pqy0Aq+2BoWcRLGe/H8ERf+AtrRVWfCYx4Y6RVpv7LLDVqaCkZJUXPMjf
vGTVQv9KX6MFLd41d+usLg23dIoqD6TIt5vAimnj8/shUZja6wy0govu4YmVuutO
/CevjDlkSB1lgmb7wE8jesLa8nuu4xjf7rypdIa5y4oT3y7tVt67drW6I81oeh+i
shGwg4OEqgTCtkqDX8qBT6YBTe9hsA==
=AZdl
-----END PGP SIGNATURE-----

--ePn7AXaNrl5LBdeQ--
