Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A953E456329
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhKRTJ2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 14:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbhKRTJ1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 14:09:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DBC361B1B;
        Thu, 18 Nov 2021 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637262386;
        bh=ErQ/nsV6NGKXfTi3u48vwQs0bvmwyCa4rQaBQ2Jkz4o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e7j+my+k/2CbBU/sWB65orjTqPIZfGW1c8PIva2DmHN2yMkgLy1EI6bwNEKWDM6l6
         2/hVkdqusZcNgUNOa3YRcA7JyRh+sj1hUTV5fm0a3WnMJkS1WbYkMVlyfVGknn6WmJ
         LHCSgciQcGCImTBtsyJaXYy8isNwP5zb5y5LT3i7K5D3rmY4O5C223Qj8ajv6/zpwE
         IZai55qFKB9mkQed3Ps9VUeVhyAu/Y263pUD78FfXxOktw5BPO5Mou7hiF3WEBQ8St
         Cl6DhlHpBOGz2B8ZuR3ObeGK60jkZBozWnOCK/CgcoP/3Y4dO+gwl8sLDkd6N7M+ji
         Rh39ibhYAdY4w==
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117133110.2682631-1-vkoul@kernel.org>
References: <20211117133110.2682631-1-vkoul@kernel.org>
Subject: Re: [PATCH 1/3] spi: qcom: geni: remove unused defines
Message-Id: <163726238525.96493.17735171365340037570.b4-ty@kernel.org>
Date:   Thu, 18 Nov 2021 19:06:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 17 Nov 2021 19:01:08 +0530, Vinod Koul wrote:
> Commit b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> added GPI support but also added unused defines, so remove them
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: qcom: geni: remove unused defines
      commit: 61f6e38ae8b6cbe140cfd320b3003a52147edef0
[2/3] spi: qcom: geni: set the error code for gpi transfer
      (no commit info)
[3/3] spi: qcom: geni: handle timeout for gpi mode
      (no commit info)

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
