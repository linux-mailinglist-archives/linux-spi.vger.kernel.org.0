Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77D054E1D0
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jun 2022 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiFPNWW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jun 2022 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiFPNWW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jun 2022 09:22:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F243486
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 06:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 097BBB811C7
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 13:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5304C34114;
        Thu, 16 Jun 2022 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655385737;
        bh=nnHqG2TQxQJv8H2UcCeZ/UdPywkYPQGfoUYTIkLIdRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ba1LwkyJUs8cpNseVYevyecadza51pH9jgr2xUqb3HDou3k03GmHB8yT47kSKXOo3
         LbbCQJ1v+p95qGRE5qijL69Gv/0T5Tjy3QCSP3KUlrotC2NMHBFKQyDpm6+io51L8S
         zvSOvuF4MbLqgLenf5zZTIjGjUG4LHWegfs1wDzacV66dD+KxnWkVUdxCnP6JFSHD0
         Qwd4N2/qEWZO11mZp69Xlyi67TwjUiTH+sEnzlh5fy5G+irK0ndiD+Oiiaj/ELZSIK
         zl5Lmn+Px2KilkbLwTc7IH+QXw1pzLiM4fQfm/Qlac7wLf53IteFnLPGebtMYZ7+JU
         f2SdwSO/yHMCA==
Date:   Thu, 16 Jun 2022 14:22:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <YqsuhfN1I54J+1gw@sirena.org.uk>
References: <20220615124634.3302867-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mr9w3SmC4KiQ+nTC"
Content-Disposition: inline
In-Reply-To: <20220615124634.3302867-1-david@protonic.nl>
X-Cookie: Pass with care.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Mr9w3SmC4KiQ+nTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 02:46:23PM +0200, David Jander wrote:
> These patches optimize the spi_sync call for the common case that the
> worker thread is idle and the queue is empty. It also opens the
> possibility to potentially further optimize the async path also, since
> it doesn't need to take into account the direct sync path anymore.

I've given this a first pass and it looks sensible so far - I'll need to
give it a more thorough look but I'd expect it should be fine.  The
numbers certainly look good.

--Mr9w3SmC4KiQ+nTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKrLoQACgkQJNaLcl1U
h9CXTQf/WCaBzi30gEAg7KQHS0FymIkH/FxBzmNrUlrWZTvPBF3DQ5FGFhjGS9/O
2zOQjDKHuLf9FV2goJN5IH4zmBmxiZ0dwlZndy7mVIVBU0ohFNTCPYdaY0bs4WIv
h7hdefJecbH2OBqpaaNMibB30csiLVk/IBvD4AffI4toRkXf8ScytNaJIv4hcqSI
JkqS8Yk9n4BFSvsIrojmFE7oEj4Q45cwwCSI/FWyIRTon7JQTToBg6gSSQFoovNv
I+Tn9fBw+S3UFjt0M6l5BoQ+kNaH+l1T84ZoVer+t3WjJs6An3zFHS1rTfBNFJzw
R8joEBvtNJsQNXGN4jQ43E64e7ISgA==
=oO1y
-----END PGP SIGNATURE-----

--Mr9w3SmC4KiQ+nTC--
