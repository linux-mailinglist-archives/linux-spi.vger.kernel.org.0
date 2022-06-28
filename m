Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701E755CC65
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbiF1Kbh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 06:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiF1Kbf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 06:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC172F3B4
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 03:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C57D618EC
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 10:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FBC3411D;
        Tue, 28 Jun 2022 10:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412293;
        bh=LgdZ688Ow16OcfaGO1xOFFHHZA21YTBwPSIPxlPDrU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VeGJ2Bq7F6tVRAgoP60UpINTCRV1PGvwzUdxMh/lStimcKzolUlAQOZoQqrNaaRWA
         C9Ty/wXeyypdI0YPRItyOvjlbjI15anp6ltawjijdF8UWU9JP0+WzLSdA5dCZmzdWU
         /le7SgzzoyOIgQQZNnEGG24jPLqOdB11t1BebVSLelpa0e27yYs4IMfZyd+VQ8oQJU
         23K3V82jgXVGiJo3uL5TxQCDuLNh4iF/8hX5OY6tJZdsB6XX/k/aimSRggizQHaz2v
         PVd55VACMPWBLRKi/8sDRtI0+0LSoyPYeiG+8z9mUmV8cy19eNoCRFkXsvgBM4Mxl1
         TRGUW6PZFmdHQ==
Date:   Tue, 28 Jun 2022 11:31:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Message-ID: <YrrYgVALI8XKvPPJ@sirena.org.uk>
References: <20220621061234.3626638-1-david@protonic.nl>
 <YrYfFiiYuvazKBtu@sirena.org.uk>
 <20220628083214.566e76da@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z7rkyUCGgfk5yEuO"
Content-Disposition: inline
In-Reply-To: <20220628083214.566e76da@erd992>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Z7rkyUCGgfk5yEuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2022 at 08:32:14AM +0200, David Jander wrote:

> Great. So I will wait for this series to hit -next and then send incremental
> patches to address Andy's feedback, or do you prefer I re-submit a v4 with
> Andy's comments addressed right away?

Incremental please - it should be in -next tomorrow.

--Z7rkyUCGgfk5yEuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK62IAACgkQJNaLcl1U
h9AMTAf+KI4VgGe+8BmNXy4zY5NXHueKVNrYyIavZDaEH4RGMqMpzbbxksGDuqVD
vXMnJJiY+kM15niglOUgwbVYNAM0L7BVnN1RuSIUj4sd2gAE006udnCBLPHtZ2Ze
e8ndjhRGw4hoFOEqRBoPyFhpPLFDzmmogZmpoF4pmK1AiVb0oYe1DIljJAktX4kS
CUiBiEzzG1t/JAuUdQMrr3l/SFGAu4B1ZbZQOhDxBSoLzBmFZWqBYgYfSAwqHGxD
zhTAZi9yLAEoUvDT6NfIZZz+3F5sPZwyl88RoRnsN6Niq/Qt/yECiA+EXkOiZ+PK
HqXbwWIocdDXOWfqleKpdzK7UEbTjg==
=O4ap
-----END PGP SIGNATURE-----

--Z7rkyUCGgfk5yEuO--
