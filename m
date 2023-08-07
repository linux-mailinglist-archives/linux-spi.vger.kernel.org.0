Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3E7725F6
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHGNiY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjHGNiF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 09:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EDDE51
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 06:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3E5A61B47
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 13:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2051EC433C7;
        Mon,  7 Aug 2023 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415483;
        bh=zSbaVCU0Fn2wndPq6jwQUcPtwTZUL68zx6zxIhPQOnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvbtOB1F8fm61Z1dr4hFCXIVESGKI0VvIsHp6QNqEXXtKapBcwQ3Nw1nTeAdMTP3U
         HeXWakGBiMhbqSvvKoioe9dqeqpY/A4TiWIQqux5spg0i1vXp4yqoV4Jk+tpjAVe5B
         AsBeOsdIhMVWp3X6WtL4P8F0aXXjfrw1mpkbJ5KDiKp3VYEmol8wxEI9vnyiAptl2p
         q5SHrUaN6zUSndFaBy7m5XFDVSknCsCpInrDsX6pcAY58oT/uYF+MqFCfT8IyNY90D
         R1op0+4JR3cWlU6HlAfVTG+o2enKv2k9XLucRMjhIo1nX2L8saWkgPDNuAQR2OyYGD
         NFMDkyIDQYrYA==
Date:   Mon, 7 Aug 2023 14:37:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, geert@linux-m68k.org, lukas@wunner.de
Subject: Re: [PATCH -next 10/21] spi: cadence-quadspi: switch to use modern
 name
Message-ID: <1f8e961d-1810-4130-9403-793a28548140@sirena.org.uk>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
 <20230728093221.3312026-11-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vR7gYHqnNQ4kCgn8"
Content-Disposition: inline
In-Reply-To: <20230728093221.3312026-11-yangyingliang@huawei.com>
X-Cookie: hacker, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vR7gYHqnNQ4kCgn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 05:32:10PM +0800, Yang Yingliang wrote:
> Change legacy name master to modern name host or controller.
>=20
> No functional changed.

This doesn't apply against current code, please check and resend.

--vR7gYHqnNQ4kCgn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTQ87YACgkQJNaLcl1U
h9Adqgf/XTdoL2KAVztDTqjSYhQw6y7fK/Xz85SQ0ysRy+ZlVT+CgXM4quo3Mw8w
EZB9lnr8Jqaal6YItryg2Cp+CW+splJnBEgH0iKw5rDN8BRcL+l0ktLc8bLVtTFE
XRvXLL5gFR2sde+zhrZ4IVzd7F63r3GCROLGzq1Upr1pzav9hUzruprErfWQBO7z
paMtktdIWE+ReP6ti9b+UIcjUSem7KI2kl/fnzL4NLk578sUHHEmKrw5Z0ef2AgE
4gm4BmHuOlGtf0EUut3BA2VY5lw/kH4vYuCtitIHA3Isfs16P81DGwIK3jmGo85B
sYjWSUhT68gbBvE/Az0XWtFJwRFawA==
=8p4J
-----END PGP SIGNATURE-----

--vR7gYHqnNQ4kCgn8--
