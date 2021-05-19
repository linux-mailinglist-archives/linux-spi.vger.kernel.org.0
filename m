Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EA388F2E
	for <lists+linux-spi@lfdr.de>; Wed, 19 May 2021 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhESNc0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 May 2021 09:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353714AbhESNcV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 May 2021 09:32:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0449960FF2;
        Wed, 19 May 2021 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621431061;
        bh=8YtvSIlzPn1cx4vHG50Skdf85hiMNOPG1hOxYRAcUJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tCK+143tCehOEquPwB334S9n5hZcM1AyS3RJN28gmLiP9DtI+fCFYyvJZPYxu6tAo
         Dq4QSjbeqbEllmRZkkFAP503rv35L4mdZcIUlNiPIjw6LGN5Ljbi/blbZrXCgVLh0Q
         Z0TuJA9YCWLvEW2BZ56OOnAvlK7y5osYOpcixTzhaR4rz5UfmxM5g3RB56vmF8DyCn
         U0I94cHIIUTta+enlkQf41ZH13rmaJA1dEDrGCzQ3cZqav3hmLrhRcgPMxmCpaiM7s
         yo2asLw+AlzxKdCDhKfiwA3z7pYv9dl7OdXD4f3gfhTgYmjnnJOqj0fQ4n/Vn43z6B
         6T6qrXZ+KyQbg==
Date:   Wed, 19 May 2021 15:30:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: fix some invalid char occurrences
Message-ID: <20210519153058.71b59658@coco.lan>
In-Reply-To: <20210519131043.GD4224@sirena.org.uk>
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
        <ff8d296e1fdcc4f1c6df94434a5720bcedcd0ecf.1621412009.git.mchehab+huawei@kernel.org>
        <20210519131043.GD4224@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Em Wed, 19 May 2021 14:10:43 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Wed, May 19, 2021 at 10:15:36AM +0200, Mauro Carvalho Chehab wrote:
> > One of the author names got an invalid char, probably due to
> > a bad charset conversion, being replaced by the
> > REPLACEMENT CHARACTER U+fffd ('=EF=BF=BD'). =20
>=20
> I only have patch 2 here, what's the story with dependencies?

Sorry, I sent three completely independent patches to different
subsystems. It was not supposed to be numerated... meaning that I need to
fix my send scripts ;-)=20

The only thing they have in common is that they touch files using
the REPLACEMENT CHARACTER (U+fffd).

The other two patches are:

	[PATCH 1/3] gpu: drm: replace occurrences of invalid character
	[PATCH 3/3] visorbus: fix a copyright symbol that was bad encoded

Thanks,
Mauro
