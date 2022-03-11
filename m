Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2D4D65C0
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350116AbiCKQHV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Mar 2022 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiCKQHV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Mar 2022 11:07:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1D1D087F
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 08:06:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3C96B82B40
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AD1C340E9;
        Fri, 11 Mar 2022 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647014775;
        bh=+kyJ3JU0bnYb8IVSD3sRNYjMCS9uR8Ej9Zikl2RQlt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaizimmrKOexwhcLBRq/gjyS957wlML4IIiOcjTGGMgVOyMrhqxYOrO7KoDDYu6/A
         mu+13LpOsf1Oo+5XJi/FT2rbXnT6p2shybs7txftvxOROcAI/JOshWYuTziAcVhv8p
         kZMUeHyB2u9UER2qyJ/4h9ENPGIz9Fs1ZPtk+2rQYapFS384GWbROoTPwqjYsrEOVl
         8dTEgHcXi9DtxK+w/95Pr4JgzXkIGGG1qe4yEq8H4SovWSzK9WsR26iRe8eoAvGhgF
         G/dXCnjWdb3t8DVppeS3zdU/1paVeZiIzPtFsGzaauNfwYLkUwd5/vr/HUIlinxs+G
         rzS5Q5L08aMww==
Date:   Fri, 11 Mar 2022 16:06:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
Message-ID: <YitzcXjKVLRPmQuF@sirena.org.uk>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
 <20220311142550.haw5jnrjycavr43m@mobilestation>
 <Yitv+tKTH2RpTV2K@x1-carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GY9duUr8kZMyyAqx"
Content-Disposition: inline
In-Reply-To: <Yitv+tKTH2RpTV2K@x1-carbon>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GY9duUr8kZMyyAqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 11, 2022 at 03:51:23PM +0000, Niklas Cassel wrote:

> I think it is a good to start off with all registers in their
> default reset values.

> Arguably, I think it looks wrong to see a reset_control_deassert()
> without any previous reset_control_assert().

I do tend to agree that if we've got the ability to do a reset it's good
practice to use it to get the hardware into a known state, it just
guards against the possibility that there's some system or configuration
where things are left in a surprising state which ends up causing
problems.  Unless the reset is going to take a long time there should be
no real downside even if the upside is marginal.

--GY9duUr8kZMyyAqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrc3AACgkQJNaLcl1U
h9BNyAf9F4k1LqcrVz4nYcj9LVqIx0+O9Xrvvb0hBgPqDL+g97aWmFs3m1ZfGS1D
B6NZmWZcBi/5VddEfCLhCVQHaCRoN8TowzHGABT0SLZ+WnSF0e5UqfzPFKkIO5QH
CP4oVR8NlpRe9nrzndUcQ0wWHiF75LVjHN1ul1gJnMOFCCeAPWp74q7GaIVa7rOv
jPHkz629KA6YTHwEDAC3cVp5Vk0yDHr+r92annKnqvq1nMcRVMDXNMlKz5XA5XlG
X2KZX5gTxNtAFWavRwxe9U7fXMn6QHdysUGindqXmJHTRdgU5CTNvqD4BwwZSJsn
npreSPGsK9fWK4R6aGSi+WMWNaPuIw==
=HM8R
-----END PGP SIGNATURE-----

--GY9duUr8kZMyyAqx--
