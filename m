Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539556C6FC7
	for <lists+linux-spi@lfdr.de>; Thu, 23 Mar 2023 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCWR4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Mar 2023 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCWR4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Mar 2023 13:56:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA20144B8
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 10:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABAE6B821CB
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 17:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50C03C433D2;
        Thu, 23 Mar 2023 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679594200;
        bh=ZyLjngDoOk+rTVWw1dxp/toWJHhulSRG2N+OB4Y0I6w=;
        h=Subject:From:Date:To:From;
        b=euZm3OadcI/vYCeH9vFE/lSdsaqnWcWeznzXf1bDtKiJa3gUl9vhEk5k61o73vXVI
         eVUh7vHdGVdmM7zYjZ4Bbvjj4RSQrOvJxBApFWDl/ZHCZbndabhFtbNNICcjuaCyt0
         tZ6C7BEd7e9iFLzTxOY4eJyHvqtJfbvF2RHpjOcaWFcO4VNWpDQuWhM8toe6CTXyTE
         8pOqHWE6g9xLKkaok4I5BVIjWEzgdvmNkC+AwpFupSvArmA+sy7HvPQWLh6jlm6/ox
         8BhX0K7awK9lFlWFn0S2ojpthwzEGgFxvdfIKqBYg8AVYmBVqxUs2ZcwTZa00/wYpS
         XjsMa1sm7zodg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3283BE21ED4;
        Thu, 23 Mar 2023 17:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167959420020.21143.11077827121275248178.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 23 Mar 2023 17:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Add Intel LJCA device driver (2023-03-23T17:21:07)
  Superseding: [v5] Add Intel LJCA device driver (2023-03-12T19:04:30):
    [v5,1/5] usb: Add support for Intel LJCA device
    [v5,2/5] gpio: Add support for Intel LJCA USB GPIO driver
    [v5,3/5] i2c: Add support for Intel LJCA USB I2C driver
    [v5,4/5] spi: Add support for Intel LJCA USB SPI driver
    [v5,5/5] Documentation: Add ABI doc for attributes of LJCA device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

