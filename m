Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04A89F2B
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2019 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfHLNGh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Aug 2019 09:06:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfHLNGg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Aug 2019 09:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZecCZ9w26px/XMlWrTJMf7OeSyYvghgJ40bY+3qMuvI=; b=GkYpSmwqLQmQTHK914OmSd2gE
        t1dc/UDVwd7rNV7p/1kK2XwVdYqXxWrv0H+jUk9eEnGob6G6Cvxv6PEDOna1/nkt51QGLC8gkk/W+
        UL+yKV9I66y2FD/VkCNeEy1j+valLdmOe5uBZse632FmHdVALMALluqo8rMHkK0HQFt/Q=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA1y-0001Kd-I9; Mon, 12 Aug 2019 13:06:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7F57B2740CB7; Mon, 12 Aug 2019 14:06:33 +0100 (BST)
Date:   Mon, 12 Aug 2019 14:06:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 07/16] spi: remove w90x900 driver
Message-ID: <20190812130633.GK4592@sirena.co.uk>
References: <20190809202749.742267-1-arnd@arndb.de>
 <20190809202749.742267-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <20190809202749.742267-8-arnd@arndb.de>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 10:27:35PM +0200, Arnd Bergmann wrote:
> The ARM w90x900 platform is getting removed, so this driver is obsolete.

This doesn't apply against current code, please check and resend.

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RZFgACgkQJNaLcl1U
h9D4tAf/QZWqB5njZanGjNO1DH1B3pBBDjVRROlyO3EsnnnH8Ro3vruDK+rX3324
mED3dhurDA9V7j5OywgEyaGE+m0bnVetxR68wsL2HhWXTn762ynlNE9k1ROsRoBt
DtXvD/O1OW2dv/HsPDPiYleYzTqHKQGgZJMeUp7trmb3s01SuEUE0wGQz29E7rXX
qnPTcynGKbZgJM2ZZJ14m9F0GlFxGuEl6FtbDEDrr2stX7cHoqXqcTBqwu74h7aJ
66vQlVC0RC+0Ek7UOVzU64n9mk5JTEdljY8Gh8I9pg0+Ulk9aUiTRUBLa+Pb3cIg
f+ezLxFbvwpFEob20b6fY8N9bnxgYA==
=yMIY
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
