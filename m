Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9C6069ED
	for <lists+linux-spi@lfdr.de>; Thu, 20 Oct 2022 22:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJTU4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Oct 2022 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJTU4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Oct 2022 16:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF04F88C7
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 13:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6690C600BE
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 20:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9200C433D6;
        Thu, 20 Oct 2022 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666299405;
        bh=xJXcaOhRJmHXY60gAarCzJVtQDukeYWh+0qb3nR4Duk=;
        h=Subject:From:Date:To:From;
        b=TCvATkcVAEvKs7EUae5uWX9UcRkxytijFEgYNU9ZT2fzU0++KJ4Vn3dLhZK7fJkB7
         4LcTs9BTq8LY0ElIJ43If+NGG6ModPXFUTR7i8Ay55+fTcOYk7wdK0md+Cqmd3FKi1
         quZeDuF5bWKPs36xP+tIoco++V6oAC7L3IOrZdgFyaDSXDufeYwqsW6uiGCCOsZwOP
         MZk+D5zdfamST9pAxgfFmA7nqxwNE4dT78eWKUK24JYzL3hovoNJqOQkVYK7BR31U3
         D6Xd59G0bnXuRjbfzEX1P97ytH6/ZZPaheeaJcbsRIZ5RWY83PlxEcK9Qyxx5kM3X9
         GJVtzl6RU4qlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE523C4166D;
        Thu, 20 Oct 2022 20:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166629940570.24250.14573611425273492925.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Oct 2022 20:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Introduce spi_get_device_match_data() helper (2022-10-20T19:54:21)
  Superseding: [v1] spi: Introduce spi_get_device_match_data() helper (2022-09-21T20:45:20):
    [v1,1/1] spi: Introduce spi_get_device_match_data() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

