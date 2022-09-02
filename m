Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8D5AB524
	for <lists+linux-spi@lfdr.de>; Fri,  2 Sep 2022 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiIBP2p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Sep 2022 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiIBP2Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Sep 2022 11:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC62C67D
        for <linux-spi@vger.kernel.org>; Fri,  2 Sep 2022 08:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6DE2B829FB
        for <linux-spi@vger.kernel.org>; Fri,  2 Sep 2022 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2EEC433C1;
        Fri,  2 Sep 2022 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130970;
        bh=cqYQrDWbsA259s6mDxyiNrdfRWNS+VT5pLMF5AfVRe8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nD0KjQXGacIWcblAj0sWtgtJkoxZ67TnNSoRGhTReDsolLLQvTlgd/SXgIiY7KEsi
         XEbBCWaAQS/8R2II4CcYVtrcLh0+VwileUb3Hzsd+Sitjlu5BX/BD6ogp9BIru3rWs
         g4wZahM9J9hUylaJ70kPbh48QyEHbdiyoTEzEYzl5Hu5d/ojyO8BydqZXdHGIXOIx+
         FQNgHm6cJuAs/k+GGDC44KiK/rAAYY491GUhc1TShE8SAbQ412c+tHC2au8HbBN/kE
         HFDfvYTHo6zY1ZOQ0CuhcMc8l3uww3HDDCXeDK1jt6QsN6mg7ag4gK4EC7p3utALCQ
         1D6WQDzhWWjzg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>,
        David Jander <david@protonic.nl>,
        Casper Andersson <casper.casan@gmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220901120732.49245-1-broonie@kernel.org>
References: <20220901120732.49245-1-broonie@kernel.org>
Subject: Re: [PATCH v1] spi: mux: Fix mux interaction with fast path optimisations
Message-Id: <166213096929.48295.4853697815455694348.b4-ty@kernel.org>
Date:   Fri, 02 Sep 2022 16:02:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7d1a0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 1 Sep 2022 13:07:32 +0100, Mark Brown wrote:
> The spi-mux driver is rather too clever and attempts to resubmit any
> message that is submitted to it to the parent controller with some
> adjusted callbacks.  This does not play at all nicely with the fast
> path which now sets flags on the message indicating that it's being
> handled through the fast path, we see async messages flagged as being on
> the fast path.  Ideally the spi-mux code would duplicate the message but
> that's rather invasive and a bit fragile in that it relies on the mux
> knowing which fields in the message to copy.  Instead teach the core
> that there are controllers which can't cope with the fast path and have
> the mux flag itself as being such a controller, ensuring that messages
> going via the mux don't get partially handled via the fast path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mux: Fix mux interaction with fast path optimisations
      commit: b30f7c8eb0780e1479a9882526e838664271f4c9

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
