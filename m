Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4409546643
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiFJMFQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbiFJMFO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 08:05:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF83F319
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 05:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58FA5B834DC
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 12:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79C4C34114;
        Fri, 10 Jun 2022 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654862711;
        bh=JQIUQi3FYPOM/5+V1s4u6ksZweZ8UJi2AXqWfYnQVQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqn4z2ZER6HNZyzpomIs29vPaD+hSOq+n76XJIxOHwa1y8Tn8MzUN3GdG2GsXQ3VG
         MphFVuXs6vlFa0AdRc04+1OEPu2ROpRx8WTaE4Vu6N8/7izXK0uDB/cPx+zB0b2hyb
         c+0TH6REpq8RlA3iBhvffls/M9mTswM84x2IA8B2bhLb430wcHInJs4aY9fr7rzc82
         PYZO2vdTNTxVDwhZfYcadwizbqyt6UPNnlI2kXr3xeRtLOuscB5iDDTOL8dDQjXKRB
         yk9ZsONSt91eXxNL92IWFsYb877oQBSOhM7OCSiXQob+wAHcjfdgwuvBwBVtbP2C9p
         Em39HKqL0QNbQ==
Date:   Fri, 10 Jun 2022 13:05:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Chiu <andy.chiu@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH next 0/1] Add simple PM operations to sifive-spi
Message-ID: <YqMzcn9/otXYDdin@sirena.org.uk>
References: <20220610074459.3261383-1-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3vaPCi6nLk0w+oct"
Content-Disposition: inline
In-Reply-To: <20220610074459.3261383-1-andy.chiu@sifive.com>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3vaPCi6nLk0w+oct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2022 at 03:44:58PM +0800, Andy Chiu wrote:
> The patch has been tested on Unmatched using pm_test. The Unmatched board
> uses SD over SPI and it was tested by initiating S2RAM cycles for all
> devices while reading/writing files at the same time. We found no dropped
> connection to the card or corrupted filesystem during test cycles.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--3vaPCi6nLk0w+oct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjM3EACgkQJNaLcl1U
h9CwlAgAhv4owb1PAnbvVwhUGI8V47GKerrok6xW4Q+WaWi8eq+WWOz0XH7sBPaA
p6+ZbSgfN9eAh+hHS1H6pMZLB3Gmt4Fwk/f+3heUhZvOjVrG+KSWU5kjbqHRqd/v
JOU3B5o1I30lCRrlzh54pWh8+9KC72P7CMFvezTa7LYIEakda2WKrt14zIbRdmkV
Rj7IKzJFvj2jNqseaWZA4Y2F9/yu/7ov1OKO0J6G1FiOS0PprkzRzEQP+eIcD/vi
JRGsx55Xi62O+Q0Vz1V8n+/WQp4J2i861X+nXM8tE0fes+vnI608ZEjIMjN/+H2S
mFk5imuzfVWWdnGpNLWz0JMlTnoIGQ==
=wmFq
-----END PGP SIGNATURE-----

--3vaPCi6nLk0w+oct--
