Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB56E666C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjDRN4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDRN4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 09:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9849DB
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 06:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5B662841
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 13:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E6BAC433EF;
        Tue, 18 Apr 2023 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681826199;
        bh=Y8swcooi2j5eXh5f1W3ZDeA9IHos+w3WzP4TorbuFms=;
        h=Subject:From:Date:To:From;
        b=URHtYZBz24WSs8FZVV8nJG0Pm82Ds35uZlK9xQFdoBxfRVNnoRoLmiP2kkY2nI+UM
         he4K7JBmdXpU3YzbWA0rnOm+oV0Z4YoTGImkY3rJR8n96x3m0117YgqF6itABHYZNH
         msHNcbEA8wakqzAtjDcKjXqvbXWShTYUbdYUXoVKfgw0bPCn75+KSEZw0ANP/NcjRb
         j+KHa3Wgb+dFcBU5Oih4JAssZ+5gBnlKkNjkVKewNNyMXpBsAgFojebNJipVG94Rfs
         6yQZpARMBki+QNDjw+edVa6Smwyn1BeZINf/PFC/FjfSYwbvQet7xIyWiuGtKuMlBK
         68qZpGWp/Ta2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EACCC4167B;
        Tue, 18 Apr 2023 13:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168182619925.26915.7987589028626335829.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 Apr 2023 13:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-cadence: Add Slave mode support (2023-04-18T13:47:03)
  Superseding: [v1] spi: spi-cadence: Add Slave mode support (2023-03-29T11:46:22):
    [1/2] spi: spi-cadence: Switch to spi_controller structure
    [2/2] spi: spi-cadence: Add support for Slave mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

