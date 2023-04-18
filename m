Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3A6E693A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDRQTz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 12:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjDRQTy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 12:19:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEFA4C21
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 09:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FEE86364D
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 16:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C52DC4339B;
        Tue, 18 Apr 2023 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834777;
        bh=uwVZCBZFeckmQw+h42fz5DbY3lTOSeeQA9P4HzVOOqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1kqvT5gXY50mUsgp8A5gsFJRUy/9TdqaJFEskfDbpeTWiVD8sGJS43268pt0udU8
         RJJ4YK99W5pXcl+dC6unJluYZ44PdaKUsjabzFaxQZha9QbwsEXmIdtIeEN3mg1X6Q
         3o0Ou7xhn7Zd9mGgB74zYZ95vdSTg20V7sR9ke0ytN36nYcWJ6tt+5QS/lQ09oz4t8
         iwzdjlEOf+6CmULs1MzaEpendC8/sL/2/Mzht6MnlsIO/43oeHiMUcGVUNsD+YcQJN
         UIcVJLnJTyQCiK1h1VTyJ4cXL6HsTICFeWJij4nq3mJF35tqe0e5Kt0C5vaRV/M3hp
         qhK1mYK7O0rew==
Date:   Tue, 18 Apr 2023 17:19:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gole, Dhruva" <d-gole@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: use macro SIMPLE_DEV_PM_OPS
Message-ID: <cfbee276-1a24-4795-b5d9-a411a6f25855@sirena.org.uk>
References: <20230417091027.966146-1-d-gole@ti.com>
 <20230417091027.966146-2-d-gole@ti.com>
 <e65683c1-9f1b-4cfb-8e14-087ef7d69595@sirena.org.uk>
 <c2cc4f31-97e0-fa1a-befd-f0dfad751022@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K6AUppLGNA5Wf6d8"
Content-Disposition: inline
In-Reply-To: <c2cc4f31-97e0-fa1a-befd-f0dfad751022@ti.com>
X-Cookie: Just to have it is enough.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--K6AUppLGNA5Wf6d8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2023 at 07:47:57PM +0530, Gole, Dhruva wrote:

> Are there any other improvements you'd like me to make in my next revision of this series?

That was it.  I think I queued patch 2 already.

--K6AUppLGNA5Wf6d8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ+wxQACgkQJNaLcl1U
h9Bhxwf8DPLKT4zhA9zzD2PTtAfwpFq9Exl3phZbVroo2SuNp4gLUeyNvC1giHn0
U1gk4h4hvd0e04ENJqoIvABQLsZf1myKMhjA+f42FSQSYnB4MWrD+EuJbw1arn42
Tp5kMm4qzSUjzHy1nWPHJHX8e5sBD0oJLBPqvJn/lrKcLnqU+m0Jjed/NjBTrwnt
tkP6gBOCNAKUUynKOc2k/MTKeMyZv5XmAoCUP9Y7uWnURMVN/WS88TF9R4r2e9YM
h6o1ISOXlQ+8s0cn/giP2YgEYFWIoumP9yw9F6/y//isEL6za1+fgSumn4nXCSai
3OgDcHzPvM6J8+8iyCnJqHvQkjkU1A==
=J6h+
-----END PGP SIGNATURE-----

--K6AUppLGNA5Wf6d8--
