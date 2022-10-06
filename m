Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD185F60D6
	for <lists+linux-spi@lfdr.de>; Thu,  6 Oct 2022 07:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJFF4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Oct 2022 01:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJFF4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Oct 2022 01:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77480489
        for <linux-spi@vger.kernel.org>; Wed,  5 Oct 2022 22:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE299617FE
        for <linux-spi@vger.kernel.org>; Thu,  6 Oct 2022 05:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50DA5C433D6;
        Thu,  6 Oct 2022 05:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665035806;
        bh=DKh15GdmNiIPdg6dMpou4vquBmPqoTmmPrkDeun5pb0=;
        h=Subject:From:Date:To:From;
        b=SLuWYFbFizSoWODkE0xU/0QD3LoQ40bJLQLiB7rV0qqcdvP+VBnLMHhULxAe33hU6
         09jCbREDJt9ls0N9qk3FWxyDo+C29+mrCFmUfQnVXLE11q0/0uqCJg3VE7IiMi8gO9
         CWLZTV78EyaPNG6+3INJOetYtXTd6Ro7UtCz9LYl9mrdTreE/+xPYkhV46jjrHaC7t
         lFg5zW3HCu71CRuMr6c8xCPrLl0Xcch8ai4uiwQ/PhCxZDpq0/53BlHuhhuja3CuUK
         gknRwYT2U/5sbe7Raj5DFEPLUy5e0TJ+u8k8UNDYpWq0GnlLMWbAs2A0J2pzBzEtW5
         LFEsfwrtZW1KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BF04E45BE7;
        Thu,  6 Oct 2022 05:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166503580609.22086.5261206189193400106.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 06 Oct 2022 05:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: microchip: pci1xxxx: Load SPI driver for SPI endpoint of PCI1XXXX switch (2022-10-06T05:05:12)
  Superseding: [v1] spi: microchip: pci1xxxx: Load SPI driver for SPI endpoint of PCI1XXXX switch (2022-09-28T03:43:34):
    [RFC,SPI,for-next,1/2] spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch
    [RFC,SPI,for-next,2/2] spi: microchip: pci1xxxx: Add suspend and resume support for PCI1XXXX SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

