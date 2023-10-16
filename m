Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888E87CB133
	for <lists+linux-spi@lfdr.de>; Mon, 16 Oct 2023 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJPRTm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Oct 2023 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJPRTm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Oct 2023 13:19:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026C683;
        Mon, 16 Oct 2023 10:19:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF3C433C7;
        Mon, 16 Oct 2023 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697476780;
        bh=A+l5AGsWFvAwh5Ck0PIKp7u9WxupnnFBmOjdmaSf/xY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m0988/uZMwOxxrh5UofWNdMGE2dCFE6/wauhysHd8WQR9LFa7vw658CJLl+r2sibS
         kD+/mekQPc4Hsk+ocBQ4H7C31pt6TtFDollYyd0C4o//UkyCfFhA65IjZirqHofArS
         mYQlNtGFm4Xz9kfC6VT3hjBcaAmz7XNqRLhzgTP4Syg5o+Ltu7HA6TFLuw93ohJSj9
         IB7UzzEkL1kWyc6WRKi2Oc7U5ibxfclH04cHZMUrIT3+XDbjMvIJvHgTyKJuN0iMps
         6hd23cZJkq3NJDI0QdDMwStgjtUN3L8vBV/i6X6BI084x1ssA+HTNjiJ9Q1N4ioDlk
         gpNw1f1DfTnqQ==
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20231014205314.59333-1-hdegoede@redhat.com>
References: <20231014205314.59333-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH 0/4] spi/ACPI: Add support for SPI WM5102
 coded on Lenovo YT3-X90
Message-Id: <169747677888.71661.12773488493424407339.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 18:19:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 14 Oct 2023 22:53:10 +0200, Hans de Goede wrote:
> Here is a patch series to fix audio on the Lenovo YT3-X90 x86 Android
> tablet.
> 
> This series takes care of instantiating the SPI device for the codec,
> to make things fully work there also are some sound/soc/intel/boards
> changes necessary which I'm still working on.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Export acpi_spi_find_controller_by_adev()
      commit: a8ecbc54165fca767e75a82372a7be3810c667cf

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

