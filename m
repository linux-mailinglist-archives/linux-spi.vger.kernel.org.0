Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA88F4CFF90
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiCGNHW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiCGNHV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 08:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8672F8BE2F;
        Mon,  7 Mar 2022 05:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2206E611B7;
        Mon,  7 Mar 2022 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BF1C340F3;
        Mon,  7 Mar 2022 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646658386;
        bh=bHrNXZubqERE96hMDwAGFOI7IEclIfhDiZxml2U0E6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je4JF+v20BYm48Ppm97VRsjfsTaps7zbw9tus9HlRUFNhEFcMIxXDaqk+REeYeXEQ
         9aOZwIrL+Nni/pfMkXnDq1lM/fyvJjv6kaLCFbdiyf0NVTUF/a7o9BC0W+MtteYATe
         pBk0on8VAwj3pjNIzQ4OyBdahG3t7mexPNhW02cmaZAhNvufrpZU3QvQttKYKndX6p
         IXgU3wTIs0eq3wblCdaK1u+e6wSg0ljKYQY/b+dcaRl6n6qop7gawq9VOTB56vtKow
         J6yW4M5GdgT2RmdyeWbl/p8M+UNcAdVT72YNw60CDElC7PU0q7YPy2Ezjrn97evwwe
         vSgI3IF5326Ag==
Date:   Mon, 7 Mar 2022 13:06:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: Fix Tegra QSPI example
Message-ID: <YiYDTtrh0SKQADw9@sirena.org.uk>
References: <20220307113529.315685-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VV1K2Sn6MZs7evl2"
Content-Disposition: inline
In-Reply-To: <20220307113529.315685-1-jonathanh@nvidia.com>
X-Cookie: Whatever became of eternal truth?
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--VV1K2Sn6MZs7evl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2022 at 11:35:29AM +0000, Jon Hunter wrote:
> When running dt_binding_check on the nvidia,tegra210-quad.yaml binding
> document the following error is reported ...

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--VV1K2Sn6MZs7evl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImA00ACgkQJNaLcl1U
h9C13Qf/fQam7j73bo4+ozDnFm7iRf2mPVJRah7AdCGpo1hM+mcLrpyg2kj+lCUn
Lr11i+i5sbAXMYZmpmPGdQiuQ7l01QJaMeZ6rbKwUlRt1iKsfB1NKbT1zfT8Nk8X
1XjvkqQhLIXDsLgd0BGK+BhhoUThzr5ScAzR0+muHdPPEctS+6qIBymCNS4nCdmx
pIDniUJ9IX8qKUi3FW8zvokDeUafvxIayrRn3IOmfvQaTAIFHwBIoK4cz4SwFzVz
A/AlI5h/XR3WJjr/IqTNOYXMhS/WyFd0SKXKK7ioab5tvNkhFFEvnnU+MEMjWDxd
KCG+6TtTdZbG3oME8SI1VSC9drRzZw==
=G9wl
-----END PGP SIGNATURE-----

--VV1K2Sn6MZs7evl2--
