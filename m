Return-Path: <linux-spi+bounces-437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C382C583
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jan 2024 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E374C1F22E23
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jan 2024 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E714F72;
	Fri, 12 Jan 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmqGKdoi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E014F6C
	for <linux-spi@vger.kernel.org>; Fri, 12 Jan 2024 18:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF247C433F1;
	Fri, 12 Jan 2024 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705084645;
	bh=3MfSYYutN627vqtRtpRGU/xHCwJo9QABNg5VtdH3iOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmqGKdoiXjAqlIKLuAnDRqiS8bbSDcrRz3Sc6EJnkAbVqq8mZKPRN35fw77Mju3ab
	 ikpZi9QBRI6o7HJP6d0qJMJmcz8PxgfIOiKgO2sgfiNJ1tLR4t6SPGiPyT620YvzVn
	 rave/rHd6Ag0pVUL2Jx67l7b2TN1G6GGgN2vMRckpJMswsnWGNZGzRmZMLT7YROA6c
	 knN5GG4T5GeFI0xO8Y0Y+V9D/RIVUjZlUemIJ0mWOBvrzeliYCjGiMuE9zoDlrJDjG
	 L5lboJDi9fJde3om79ZHIZCSs588PHsw2gmcC23vyxjaqqXWxeLioQzb06QSbi97qv
	 1G9qNwMIWz2PQ==
Date: Fri, 12 Jan 2024 18:37:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: akinobu.mita@gmail.com,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	kernel@martin.sperl.org
Subject: Re: [PATCH 5/6] spi: loopback-test: add elapsed time check
Message-ID: <e3db65ab-be7e-45dc-9104-fe2a3b046b7d@sirena.org.uk>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
 <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
 <4f097d14-dc7f-453e-94f6-96ef568e7770@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+dIkSx+lCar1WGFL"
Content-Disposition: inline
In-Reply-To: <4f097d14-dc7f-453e-94f6-96ef568e7770@linaro.org>
X-Cookie: I want a WESSON OIL lease!!


--+dIkSx+lCar1WGFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2024 at 04:19:10PM +0000, Tudor Ambarus wrote:

> I'm playing with the spi-s3c64xx.c driver and the spi-loopback-test and
> sometimes I see that I get the following error:

> ```elapsed time x ns is shorter than minimum estimated time y ns```

> What's strange to me is that if I ignore the return value of
> spi_test_check_elapsed_time(), the test passes, there's no transfer
> mismatch and what we expect we actually get at RX.

> What kind of errors does the spi_test_check_elapsed_time() check want to
> discover? Under what conditions the test->elapsed_time is inaccurate?

The test is calculating the expected time based on the intended clock
rate for the bus and any delays in the message.  This should identify if
a driver is either ignoring specified delays or overclocking the bus.

> [ 6748.910773] spi-loopback-test spi13.0:     spi_transfer@00000000774992f1
> [ 6748.911035] spi-loopback-test spi13.0:       len:    1
> [ 6748.911225] spi-loopback-test spi13.0:       tx_buf: 00000000401e03ed
> [ 6748.911472]           TX: 00000000: 01
> [ 6748.911614] spi-loopback-test spi13.0:       rx_buf: 0000000010f7e3e4
> [ 6748.911860]           RX: 00000000: aa
> [ 6748.912004] spi-loopback-test spi13.0:       rx_buf filled with aa
> starts at offset: 0

> [ 6748.913400] spi-loopback-test spi13.0: elapsed time 532837 ns is
> shorter than minimum estimated time 82240000 ns

That's a *very* substantial error, it makes me suspect that the hardware
might be doing loopback at a stage before it actually clocks the bus and
doing something like just connecting the TX and RX FIFOs.

--+dIkSx+lCar1WGFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWhhuAACgkQJNaLcl1U
h9AbWgf/aMTPOAjiXbVmk59Wlw3dy1BhG/mIwqiCXL9tjz2rhjOA7fBYak/k6Yfm
dl/zZntyrzcEEGFv+TAxhFaF+eq8yxyPROTHqmvG42CDdy49E1ZBB/GHK8lfmcdo
X7JxhcJNgUJs3kpSipFYt4HzdyachbP9YpB+wVlRppaMKcouyyrAltoGFJG5HeCL
hEMAtQZ6dIo9xfq77FCYMNc8TXAFRuoJ23hmCmb8RvLSxanUG9d7u0YihIxpdyif
+d5dbgsBysMM6Eq/dhXg8P3WPUtJIE4+48Fb5H7U+WNO33DrLMfHNKo1qrhJXjJH
02LdmJNOoBimncJS/2+s1zYbioHyEQ==
=Jysl
-----END PGP SIGNATURE-----

--+dIkSx+lCar1WGFL--

