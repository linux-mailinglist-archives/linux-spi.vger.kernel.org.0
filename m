Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20570754EAF
	for <lists+linux-spi@lfdr.de>; Sun, 16 Jul 2023 14:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGPMxa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 16 Jul 2023 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPMx3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 16 Jul 2023 08:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C283
        for <linux-spi@vger.kernel.org>; Sun, 16 Jul 2023 05:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C273860C97
        for <linux-spi@vger.kernel.org>; Sun, 16 Jul 2023 12:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806C9C433C7;
        Sun, 16 Jul 2023 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689512008;
        bh=fx+zh0+yc7qWjb2FR/OWNv7LoDP/giaL1eVcdlQHcdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmVqGMuvyr+3xJqjtCBLwGPcUknPH5i2+tvGlAzvytbqdNoPI6H9aXCEg3TN8yLTN
         qY0CsZ0eTr6FhxZSL1Tiy9NMZHBI18ZsKQtwS5nL3kObYJ/OpxOKhZWs/v830cTVXi
         KzFjYX8+NEB8qZxVeRg41/LFDQzkiLjuelxWXnA6dsng+eLoiCYYvNDtk++aePGGk9
         RCA4izwA18Tv3ik/hSqnocStumVA06+SP5iP9J29VS1Jzg36/ZYewee2qEMwjV6nRF
         XZ6oGcsoYi9SiRoYK4MI3od1aKavRmhNwvwIZNlbrfP77+VsL1+7vZkC99d9913Mjh
         gBDzQmHY9LXtQ==
Date:   Sun, 16 Jul 2023 13:53:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: spi-fsl-lpspi: Move controller initialization
 further down
Message-ID: <dcdacbbb-b4af-49f9-8f7a-9c5c6f3361c4@sirena.org.uk>
References: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
 <20230705090145.1354663-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KMOv5irw0G6/ZcbG"
Content-Disposition: inline
In-Reply-To: <20230705090145.1354663-2-alexander.stein@ew.tq-group.com>
X-Cookie: "But I don't like Spam!!!!"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KMOv5irw0G6/ZcbG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 11:01:44AM +0200, Alexander Stein wrote:
> This is a preparation for reading number of chip-selects from hardware.
> This needs IO resources mapped and peripheral clocking enabled.
> No functional changes intended.

This doesn't apply against current code, please check and resend.

--KMOv5irw0G6/ZcbG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSz6EMACgkQJNaLcl1U
h9Dvbwf+J67PB4tK6SalcTrQdNjH6j2TWn4GE7QzP6LHizgWUlmE0Qbcm/Gu7dRR
BTlzZL+0oqOsk/hDJI0Xe8Q39ONTIms2vDLeK0kCeIA5gT03bOWGVzGa5Ox91kEi
TZuCQc9P7U1AFK2n9NCJj4Za2l6YbSFtIRQ1UxHAWY5f/4WWHXd6oMIEey7nQdgF
CQpXqch0yN2RRoAz7SKYvr0vE8LSMupqJkAQ3hJ07xyxcOjCKpLDPXxbpErT2dPn
G/bHPRQMHPCnzniUt/3uyZwL6JYbtSuo8JFnn2NrZdmzzULhmYc80nFaEm2lCRTR
fp2xnWOdRb7dmcyaBbx2mfE2AUIdZA==
=jdDX
-----END PGP SIGNATURE-----

--KMOv5irw0G6/ZcbG--
