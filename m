Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59E321AA29
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgGIWBK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 18:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWBK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 18:01:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C08A20720;
        Thu,  9 Jul 2020 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332070;
        bh=5465ewyg8MdvQtK6kDkNf3vR6jyKNYnfzaqI7TcJus0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xO8luKZhOq9teQnCJytYCt+xVlwCKKoErVl9+n5hrXinAiS6rw/rHfQPGdJRBy3VO
         kxYqKZQEAZd3byucZCx/SbIyRjeLrMwDV8fd5ohLFcxwFr+8zcz2xfhD8Tr+eMGjea
         goOddP84IZZ4p012xFPfWXk0XblS/HCvjvP98Nd4=
Date:   Thu, 09 Jul 2020 23:01:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, linux-spi@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200708194400.22213-1-grandmaster@al2klimov.de>
References: <20200708194400.22213-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] SPI SUBSYSTEM: Replace HTTP links with HTTPS ones
Message-Id: <159433204447.479.16639997538518023197.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 8 Jul 2020 21:44:00 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] SPI SUBSYSTEM: Replace HTTP links with HTTPS ones
      commit: 3ea4eac3e29f8a63646ddc1bdf90f2efce7d082c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
