Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE2361229
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhDOSel (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 14:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhDOSej (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 14:34:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9867A60E09;
        Thu, 15 Apr 2021 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618511656;
        bh=S88v+VZf+BdfcMDAyihmpF50TX9fEfuj3CgNgpOZGlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQsRlKBMIwlHb0GMTa7GdzXZ9+x66UXBBfu3ScL/vLhao36Tl297OKSCrKI5pUIrt
         BmlBScK4q+7Pzq7DfynTbd+GEjIx2sKrkYKd44/y5lqvz+t6WnOH9/4fFIpKeNDuag
         WWP/rBiBkwjyYDvimlN05fY7iYMRUGut3CNFPHZppz6M3IL2mXGh2S8E5sglUh0xc8
         iXyrdksAo56YzKapBxiSjd4I0UyGyB82doiXQOCoJBAwMfUZqW3+PQg+y+J0uqzAhQ
         TS3MmDe9APBuOZ+gyPgiBIbY1zJDI6Qt9yTwyt4pKBFbExs5vEPStqrhBFcZf0cK2/
         2gUi+akPq2NNg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/3] spi: s3c64xx: simplify getting of_device_id match data
Date:   Thu, 15 Apr 2021 19:33:42 +0100
Message-Id: <161851161879.23304.6673914019585638025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 14 Apr 2021 22:33:41 +0200, Krzysztof Kozlowski wrote:
> Use of_device_get_match_data() to make the code slightly smaller and to
> remove the of_device_id table forward declaration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: s3c64xx: simplify getting of_device_id match data
      commit: 609a2f9529d3d3e627776614b6cff34b21f64144
[2/3] spi: s3c64xx: correct kerneldoc of s3c64xx_spi_port_config
      commit: 7d712f799a938b37d24359ea836f58866be5e0bb
[3/3] spi: s3c64xx: constify driver/match data
      commit: d6371415517700ae225dd1aaa8a35a86a659ada6

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
