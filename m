Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5535EC0B0
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiI0LNF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiI0LMr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 07:12:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8942528E07;
        Tue, 27 Sep 2022 04:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23D61B81B10;
        Tue, 27 Sep 2022 11:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27747C433C1;
        Tue, 27 Sep 2022 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277128;
        bh=dv3kOjQkN2747uDiGJnnkt1eBZPn4MDWS+H/rcToHKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irmnfS3HRA9ytPoTuAuYi4Z7DrmpMIC6waufvsh6ZKesIFzMAH1Cqd4//FyMsbPA/
         8DyZykNdqV5Wj79lJ/MqwAtb0zy035aadS81+R5iPzNXEVpb1EeAoBZHHeUSlOGAa9
         iVu/Q4JQVhbxJDLgIng8++VVm4phLypxLCYRRWiSQkAhPiLNUOwQDS3IhINDbzEO3a
         nNSWuoBSs9DmW8arw73mYYQqQcRKlRdhxxOs9+iGJzCdyQjytM4BSChhewBsCQOPja
         xEvDNLp8fSNtUZYWupuDGFe56uxK+W13kHSxe33gu1k0G++miwfbf45l+dIzksfJH+
         UbuZgCj6p1o/g==
Date:   Tue, 27 Sep 2022 12:12:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings
 to YAML
Message-ID: <YzLagn9/j0w4UymU@sirena.org.uk>
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="///nd/DeEmgELYTC"
Content-Disposition: inline
In-Reply-To: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--///nd/DeEmgELYTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 05:19:29AM +0200, Sergio Paracuellos wrote:
> SoC MT7621 SPI bindings used text format, so migrate them to YAML.
> There are some additions to the binding that were not in the original

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--///nd/DeEmgELYTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMy2oEACgkQJNaLcl1U
h9B5nQf/VidvFDvPMfROPjc+zsL8Jo7Odsl/VracE0VLJAgEpcFoaP30DoeZNdYq
PgNh0YChMBkVjTFP0eIX2IzEFVKzuEG99Z5ZUy4izeE3LBt58iopy+2UxNZs1LzG
ce5il9jWznceYRJ581TigI2W4Opc9KAKzEqRC+kPS1iSXs/i++Gv/eMtEDsdYq5I
xRfqmuSBMAVszvLtIXVs4ZAvOGk1iEqQFOpXjHD0kIR8+sideqs2OeU5NhRrTCAW
Sq53UbVhxVgLi1iPViZ8BS2YFybjcY0Jjl4NHakRSENNeGcbMctk7q6QXs7HMwOE
mm+3Pt1hEpuwvX9ffuq12Pt6/hGzTQ==
=N3+j
-----END PGP SIGNATURE-----

--///nd/DeEmgELYTC--
