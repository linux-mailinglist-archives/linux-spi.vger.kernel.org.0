Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098885BCF50
	for <lists+linux-spi@lfdr.de>; Mon, 19 Sep 2022 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiISOmQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Sep 2022 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISOmA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Sep 2022 10:42:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7A1274E;
        Mon, 19 Sep 2022 07:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8C2AB81C95;
        Mon, 19 Sep 2022 14:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAA8C433C1;
        Mon, 19 Sep 2022 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663598517;
        bh=OtjpbeaSs0DOFS9kOf0McMZwUdBSfPvfxtQWSZ/40g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ch0uFShN8RHmZw7yPjqqQCuXY5njwYTuAm2/O6sZyLZ2X8jRkYeOqcXBCiCeHo+jg
         KqxR/EnNwBticr0u+HS/8DGC8K8zUEnofuYD/5e3++5avFUs04xbFCRRz9o/INZAWF
         uEQkLdfem5LsH256M7KuWG5B4JnTtnYW9huK7vwceMK+gjXmaaxf5A/mEAZNSMxxgi
         N237P1956RxE55+nOBclwmgy42BpEheWDBwjGVU/n10oVpitkesIau3+9maZugCzYf
         YLd0NxuD3jUFdqnJA1kyP8LIcNVu1YrwyMKDwl6LmGcwHaAMcDyaKMKNY/hf3j+zXY
         fLF/7Cs4k6Q7w==
Date:   Mon, 19 Sep 2022 15:41:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     krzysztof.kozlowski@linaro.org, andi@etezian.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] spi: spi-loopback-test: Add test to trigger DMA/PIO
 mixing
Message-ID: <Yyh/q5Ql8/QbCXqA@sirena.org.uk>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
 <20220916113951.228398-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o43Lq88mw5JPA5ld"
Content-Disposition: inline
In-Reply-To: <20220916113951.228398-2-vincent.whitchurch@axis.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--o43Lq88mw5JPA5ld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2022 at 01:39:48PM +0200, Vincent Whitchurch wrote:
> Add a test where a small and a large transfer in a message hit the same
> cache line.  This test currently fails on spi-s3c64xx on in DMA mode
> since it ends up mixing DMA and PIO without proper cache maintenance.

To make life easier with sending fixes as such fixes should come
at the start of a patch series and new features at the end.  This
avoids creating spurious dependencies.

--o43Lq88mw5JPA5ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMof6oACgkQJNaLcl1U
h9CRCQf/WQxRZ8b3fsI8NWiE0SBlk4tYD12r9n9NIpd70354mcRLpYIIrWz0M64k
mtV/wovHUmKHEC1b7xyVLrHNrJE4/PE6siJUtiJ1uNpxuWRgQ6zdoSKkCfep3D4M
n59R1MvLFo0zFBRtW2+3p8s1EGtdmRyV8E8CUXKmUE8vcdkSoTRwvboQG/yED7R0
IxD9cOxxmAsaS9myfkWM2Pyd92LMSe28oisHsV+oPr16GzO+e12/+jYGuU74kWWu
k8Memh1bLNqttcL2qSsBYvwEDEQ0SYeQ0+oF5HeAA/0yEwXf+LoZBI5exZ0Sge76
lhNd6VWEBPaMpANG2mAUqMbmgN95YQ==
=HLzQ
-----END PGP SIGNATURE-----

--o43Lq88mw5JPA5ld--
