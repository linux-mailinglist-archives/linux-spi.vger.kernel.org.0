Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B14300424
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 14:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhAVN1j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 08:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbhAVN1g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 Jan 2021 08:27:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA98923433;
        Fri, 22 Jan 2021 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611322016;
        bh=hjXQm8uoGxiu0jpIfIS+/eytZP7PKz1arwZhIf9bWIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku0u4ERgQVPxliCOIqFC85nnpxA29kEo/CrzgZNYgLcfQHTru18aajmd62E5IeIex
         wt6MWMyKHnDYggnHGwrkDjLK5TL7BAAzHkAbOZ32MJQyEyiKVJ5fXZWr/BRQy0LLw8
         Frme03AQAhrBRbtqoy/yh//hXnj7w5TrTx9AdL6UsSuH+P/h9ud7AXiwLOygpB6up8
         jw/GwH1c/8k2hFgjEgdPNii9uR3tJIycayswqC+Hido+mCBjaewAOQca5RZiWkPj/e
         MQoZ8pML5F87LEb5ZuexDz4NKwFflq50rlP3/QR2bfpTm6n7dB6QqdpuzUoJhBrPNV
         3XL9DoSH8egZQ==
Date:   Fri, 22 Jan 2021 13:26:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     xe-linux-external@cisco.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spidev: Add cisco device compatible
Message-ID: <20210122132616.GA6391@sirena.org.uk>
References: <20210121231237.30664-2-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20210121231237.30664-2-danielwa@cisco.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2021 at 03:12:36PM -0800, Daniel Walker wrote:
> Add compatible string for Cisco device present on the Cisco Petra
> platform.

I'm missing patch 1 of this series, what's the story with dependencies?

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAK0ncACgkQJNaLcl1U
h9AMoAf/SWETMvs5TwzdE0BaIffSd0xEsbkHnNQxMBpViE16u+H15jx4DcGFZo6n
mfmtCo5ywobgcHaFuxKpN/nZ3gQW8oUGoHWw3xzUFVwQNVdD3vZQx8nmnUrWkYwW
AVd9TD7bIYJVil+rQj8Y8afzV0fV5hnXlHdD67pVNZ58fMU5tgSFuagWuK2fLm6F
Db4hZ2HfRir4QQjBgCpS3sLzHWZtc7Ol8fDKTtRcS1wTGKVlUK/Zp/P/5oM9Cs2/
jFQoYlwYjugynxEkYwGdtlvrTqpWQnspTgDy2Op+EFU8Cah2xceLRlI+x7xwnfVL
H0xt1AI3OwkyXCxcnV+b+QYxoC4xQA==
=pnSl
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
