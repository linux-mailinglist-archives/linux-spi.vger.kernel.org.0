Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478075EC12C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiI0LYd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiI0LXt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 07:23:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B288124756
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 04:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30314CE18AC
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 11:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC3AC433C1;
        Tue, 27 Sep 2022 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277695;
        bh=QfBnD5R7DZQo/fjnTrBF+gDLI/+QwJR8Yp0Z8yzvlo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia82EAxsKhW34I/49o4nUcu1LhfT9CiCmmb3TN/9+zfJvzDOVAH189NIPk4HjbPEm
         UCO5rsGy21M/Lmoz05i3KnMpvaB8l51nXE1J8MVsc/eLBwxFDDUBw8S6xp7InzppzJ
         DQKfXiSFqxBxYTwTdzVnwbNC+7LmEpG4TQyzZi+isfoe142Sd9Cp34dXn8t+JChur9
         my4CG0vX/6SwibTW78xeFZsZEMLhFoOi78/5eAeFmKFkCr5XdK1X5lqmvGFufqVZft
         wpl/SwwMLduqZ25PqABwjTfCgIjSuNeY6ICxpeMLGYfR9O++EUx0OGDKwMgBmRElF7
         q7Hg+U2BIFu6w==
Date:   Tue, 27 Sep 2022 12:21:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzLct0v1ZRJVW2Gm@sirena.org.uk>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7dMAklQ5e8HqP+uF"
Content-Disposition: inline
In-Reply-To: <20220927034525.GA32253@wunner.de>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7dMAklQ5e8HqP+uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 05:45:25AM +0200, Lukas Wunner wrote:
> On Mon, Sep 26, 2022 at 10:29:32PM +0800, Yang Yingliang wrote:

> >  extern int devm_spi_register_controller(struct device *dev,
> >  					struct spi_controller *ctlr);

> This doesn't really make sense I'm afraid.  The umbrella term
> "spi_controller" can refer to either a master or a slave.
> One has to specify on allocation which of the two is desired.

> An API which purports to allow allocation of the umbrella term
> but defaults to a master behind the scenes seems misleading to me.

Yes, we'd need to either have two wrappers using some more appropriate
terminology than master/slave or have a parameter which specifies the
role.

--7dMAklQ5e8HqP+uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMy3LcACgkQJNaLcl1U
h9AlPQf/cpYsvnJO2IqT1MLDmEgDH6+pTZKgOcMUIxysyJGsZhrM8ItqA520LlBf
Uw2Vm+q/qhbuoocxno2DMTDPaBr2afDt1b4N+xCiA6rbOYIaH2gaWszcP8Gl8Qcs
G5ykwP6i1ka/WlZJO6yviAiVoQSNFu3wWOWwAZ7wm75UxpoqqQP1StMWFh6g82ml
5T5feLNmp5VBZHuBUcSMbQm9NFUew6yLM97VINjLHVg/Rs2H+cR7bSD1yMWlNv7b
syzyiEysH6SvnFmjLUqdm71quc3EE4JvF6Qx2Xxz33a6xVsNrNPt/pU3tqmC0hAI
kOWC928kWhnUydcQvm0T2TXo+/0R6w==
=gdBI
-----END PGP SIGNATURE-----

--7dMAklQ5e8HqP+uF--
