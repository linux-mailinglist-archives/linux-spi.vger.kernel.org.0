Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E05A9579
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiIALLZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiIALLX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 07:11:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880811AFA2
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 04:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31FE3B82569
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 11:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05648C433B5;
        Thu,  1 Sep 2022 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662030680;
        bh=93fpQUa1lqzvFTF/8um7oFHSwqkjIn65phieRIbJiPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRbFExKZVJBH7vda3N8/UaNLFpoYvLOX0TAxBlHMBp7ppGXIF3fm7jycF83lR4uxj
         dolX/T8FfLATQAZFRxPTq/uHM30ehDLIh55CC1+3oUDAB1uAUH3t4IoRSONI1A3EtX
         W4eJMZ7yIDNeC8K0pNWnl+y5c5AE44d8r7UlqMbjKU4HYwhYpF/EuvNyVm8tXyDeo9
         AZrf2cNsj9RyXSOcrF3GXHJmEbui9t9xGEgI2156w7tRC8PsxwWN4oN9cfxLK2I13I
         YRcGZjJ3/K0hWHZYum+JFbzF76ldZPBJ7FlBMGfM/ez2im1YvDPnPeT8eP0zsJBy+u
         2OeAnimIBVabw==
Date:   Thu, 1 Sep 2022 12:11:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     David Jander <david@protonic.nl>,
        Casper Andersson <casper.casan@gmail.com>,
        linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <YxCTUsexp+2cshvp@sirena.org.uk>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
 <20220829105613.476622d2@erd992>
 <Yw+HTj98V1ToLWIL@sirena.org.uk>
 <YxBX4bXG02E4lSUW@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iQZnYLgcmEE+p2Zv"
Content-Disposition: inline
In-Reply-To: <YxBX4bXG02E4lSUW@axis.com>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iQZnYLgcmEE+p2Zv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 01, 2022 at 08:57:37AM +0200, Vincent Whitchurch wrote:

> I'm seeing these problems with the roadtest test framework which uses
> UML and doesn't need any special hardware.  Roadtest puts its emulated
> devices under a spi-mux with gpio-mockup and there are no tests for the
> actual muxing, but other driver tests break since transfers using
> spi-mux don't work properly.

Oh, excellent - I was just trying to remember the name of roadtest a
couple of days ago so thanks for reminding me of that as well as for the
testing!  I'll try this out later.

--iQZnYLgcmEE+p2Zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQk1IACgkQJNaLcl1U
h9BKHwf7BlHDDLay6MEAq/PBQgT+YiV0bnjL5DHMTLnf2RgACib08oh+yKhemlq0
hNnuVnyimhKghlY6IkNejT3WCM3VTWfj1RZMH5f1BIGHly0/TO0+lj3hDqXkbAT+
TOcgTW2EXw6zytIv1tuCbYlmv8Pvkc2jCmVziTxNnArqPys+Av1lodtzsjaR7nWh
PS1ZDLoZ0ZQbk8IYxkgFP6SRD5Z1yzoscx5KW+hwK7QznPH4d9M43B3xWYbpiJLW
6IIClvE4NuWCcEO09z8QBaeiBU7dwFg31X8OVzCkEjzWKkC/AAdK/zxdgn3iAE38
9zPceLdCwUYQAjsiyExEiA4jqXjMmg==
=no43
-----END PGP SIGNATURE-----

--iQZnYLgcmEE+p2Zv--
