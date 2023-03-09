Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944856B1D30
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 08:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCIH6s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 02:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCIH6Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 02:58:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BCCDE1ED
        for <linux-spi@vger.kernel.org>; Wed,  8 Mar 2023 23:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73D3CB81E60
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 07:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21C11C433EF;
        Thu,  9 Mar 2023 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678348596;
        bh=Acy4rGOZlalUfu0rjmmzphZaLTIZJA0mVkJK7wtvHc8=;
        h=Subject:From:Date:To:From;
        b=GVQUH8mSnrl3fPRU6anjUmNXywFLptWwrgMWRM8QIzpmRMiykOYWpLXN+w9cZG7n1
         UIczUTOqd3vuOvM5kdbclPAGAkJTW3DMT4r9N3PcNgVFe0jKJj9T/4a/Iug2Nmuoho
         bhixyl4LxhVqva1K2iAUTnK46M2MBfZwSU+uzX9pqJKOxVYmhcv6anNb5d+pVhZVsd
         g8DNva3e+JiIsVdtkWSiZFoAgnb6a6uNyYpJc/qrP5LONh0CrDolGMjftiziGR0Ix8
         9I7y9Z2h/TrlGocdPZGOE+eodi0y/nt2l6ci1TUxlsGZ53MxhGiUHSXPDH96Fd/wQc
         y81PrRDwfQ6oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC90DE61B60;
        Thu,  9 Mar 2023 07:56:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167834859589.3881.1530015017710622443.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Mar 2023 07:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add Intel LJCA device driver (2023-03-09T07:10:55)
  Superseding: [v3] Add Intel LJCA device driver (2023-02-28T06:56:13):
    [v3,1/5] mfd: Add support for Intel LJCA device
    [v3,2/5] gpio: Add support for Intel LJCA USB GPIO driver
    [v3,3/5] i2c: Add support for Intel LJCA USB I2C driver
    [v3,4/5] spi: Add support for Intel LJCA USB SPI driver
    [v3,5/5] Documentation: Add ABI doc for attributes of LJCA device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

