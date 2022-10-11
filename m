Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982915FB101
	for <lists+linux-spi@lfdr.de>; Tue, 11 Oct 2022 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKLJM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Oct 2022 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJKLJK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Oct 2022 07:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D68E98F
        for <linux-spi@vger.kernel.org>; Tue, 11 Oct 2022 04:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 063E961172
        for <linux-spi@vger.kernel.org>; Tue, 11 Oct 2022 11:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C84BC433C1;
        Tue, 11 Oct 2022 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665486545;
        bh=C0KIp2fsTEZim5o07aA8vzlMORz/af5cz3cnvRFWooA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+puQ1Bhe2S+R6R6Jdr609xPOg1KUENqJhqbjeS0uQHvadiYDFWzYAplBSc0ohotL
         8WYRgP0zyZbqX3uce3cIReXHnoKU9+rE5/9Uu2JWC6HIa4CEAxv2/jstecIa4YXRjO
         AXRbHqo47DrM6PyZREO4o0AM1YRFUaR5hrRhxXhXev+jUPjW0q2aZIFuSk9Js0wZEe
         QxxWuZVVngps2lWjLtACwvCvkyrYYWAnLQDyim8pK4xcazVfqTsRdN4BCAGzy79Znv
         UfPQMJXDw2iwaJ8MivMBzCHG0JzK4+QSx5xqkKTLLZmgHqARgzcN68GTf8iCCDHBZv
         wVNRJfHVgojwQ==
Date:   Tue, 11 Oct 2022 12:09:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhichao Liu <zhichao.liu@mediatek.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: Fix packet division error
Message-ID: <Y0VOzQzRX24Jo1dC@sirena.org.uk>
References: <20220930115828.14442-1-zhichao.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bGcAR1t2DLC7vqbh"
Content-Disposition: inline
In-Reply-To: <20220930115828.14442-1-zhichao.liu@mediatek.com>
X-Cookie: I had pancake makeup for brunch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bGcAR1t2DLC7vqbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 07:58:28PM +0800, Zhichao Liu wrote:
> From: "zhichao.liu" <zhichao.liu@mediatek.com>
>=20
> Commit: 7e963fb2a33c ("spi: mediatek: add ipm design support for MT7986")
> take a mistake on packet dividing operation, this patch is to fix it.

Your commit description doesn't say what the problem is or how the
change fixes it which makes it very hard to review.

--bGcAR1t2DLC7vqbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNFTswACgkQJNaLcl1U
h9DbVwf8DQYy0yNdMIWKi53RUWTL400KuXMbXXLsIBKx9EKfE7/9ZCsl3dCMd+uc
/kJjpa9mXxxsy6baPWtrNMrlIurHr9v3LSRD8xZfQ+rtgYSPe5MQo/Re97e/YGvd
EqIFRc/CcTCHevsxBjlQ27b14zP8rrvxHYsBBniwIEDTuT+vwEiB6aMXrMsHzjny
QESyg7tAE2QqEKA+nEEvL7ujmVXXEoR6mIZz3IQPtV9wxfNIM5cvS2H2s5py45Zg
r9A/DpW8Ld/I3XXAUbZVlO+Jbstfmg4/4OVd9fxbYMp3ZtltvzYP+2+l18JMqX3U
46c79+pWesz8TiurVLhK9x1VlC0aPA==
=d5Ee
-----END PGP SIGNATURE-----

--bGcAR1t2DLC7vqbh--
