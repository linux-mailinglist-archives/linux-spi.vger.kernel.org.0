Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD547F77
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFQKRu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 06:17:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfFQKRu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 06:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yp8rDGQhV4knZevFuB1Z2myYN0qqPzWsPTMEM6LkDUc=; b=n0NC8qWfV7EkHM+jLzR644f7q
        K31sXsS75pSSTbTRvHh289Ft3Sg/9ROwSX4lKzMDHsC7rOW7cPq9EI6RG0fyvglncQf9MVifi8McV
        4zMjMJlHgbBPYzakzgvrIWjkC4CTxQUXCArBeh9eU+FQiUt8l6oCQTyKVMQkK0tm41G/w=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcohr-0001Lu-2F; Mon, 17 Jun 2019 10:17:43 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 05DB5440046; Mon, 17 Jun 2019 11:17:41 +0100 (BST)
Date:   Mon, 17 Jun 2019 11:17:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     lkp@intel.com, kbuild-all@01.org, linux-spi@vger.kernel.org,
        jaswinder.singh@linaro.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64
 dependence
Message-ID: <20190617101741.GK5316@sirena.org.uk>
References: <20190617060957.16171-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktyc2UzNUDZzGzis"
Content-Disposition: inline
In-Reply-To: <20190617060957.16171-1-masahisa.kojima@linaro.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ktyc2UzNUDZzGzis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 03:09:57PM +0900, Masahisa Kojima wrote:
> kbuild test reported that Alpha and some of the architectures
> are missing readsx/writesx functions.
> spi-synquacer driver is only targeted for arm and arm64 platforms.
> With that, added ARM and ARM64 dependence in Kconfig.

Are you sure it's those functions (which only appear to be defined on
arc according to a quick grep) and are you sure that there's no other
Kconfig symbol specifically for those being defined which can be used
rather than depending on specific architectures?

> This patch also specifies the default compile type as module.

This should be a separate patch and we don't generally change the
default unless there's a reason to do so.

--ktyc2UzNUDZzGzis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HaMIACgkQJNaLcl1U
h9C1CQf+LxXXmPg4g7EU/2kZj/J96bIcnUCkIAiJ1AXgmzUfmqlm06njo394qgS4
CHj+SCNay5L+zRll2tF/qZQMwj6c06yDhzWHbDp/GJqkPtIKJoWxpOUo8vQMrkG5
tAJVEH2X/7QbII3vC+b5SVKYYmb8FtQegH5f3MD6rd8YO8Dae7c/HEoMgMINXTiI
m7K4sXfJLK1T4uwVTsPlIcNVi5EFG9gCMJvSVHI89TMagGp5GdyecPQxh9TLwNbI
+0l0MNwYAzP6MSAVc8GwYog+5FzWKaGrWhsApHXNmXHhMKDLRRaa7HkxYeGSeoai
5fK7sx6GZtogpNzuxOGYkBajnwFDAw==
=rXE1
-----END PGP SIGNATURE-----

--ktyc2UzNUDZzGzis--
