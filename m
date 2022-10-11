Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD475FAFC6
	for <lists+linux-spi@lfdr.de>; Tue, 11 Oct 2022 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJKJ4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Oct 2022 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJKJ4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Oct 2022 05:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D2578BCD
        for <linux-spi@vger.kernel.org>; Tue, 11 Oct 2022 02:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1EA61042
        for <linux-spi@vger.kernel.org>; Tue, 11 Oct 2022 09:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 591D4C433D6;
        Tue, 11 Oct 2022 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665482207;
        bh=7jE3n7ZbF+ADOVl5uPnhiF5NgyQ+S73t+h8enKpz2rY=;
        h=Subject:From:Date:To:From;
        b=GimYsERY3hZLIHWr6N7pmTlbLs5o/l4uhUMub7k4eyjEZqnY7TCQKcMb4u6LKE7K+
         qUhKD3IxsrQ/MBtorDONvk+fSTIqRjicjqQshTncWK8s6Y1gqWJ6ftvXMKhx6/nukD
         U870FZ1+si0HFXyvCLUF0iR32MELWWlIwUne845fEPsyO7GqpC7e/p1Z4OfMUWC1gp
         f1dTiXbKm1hIVI+6/NQacqCK6WG/aSZ60wbxrptigcoUHaygyHMnmBp8fd8HZXloKR
         erxFDx9oXlNrAr8UfWPZ8M3tL9cfk4cxicqhYlMXKkLmKz/cKOxnDC7yDgA0tNDzcO
         34naSk9U0O91A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33687E270E4;
        Tue, 11 Oct 2022 09:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166548220714.20466.2377313771626031751.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 11 Oct 2022 09:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: introduce new helpers with using modern naming (2022-10-11T09:22:04)
  Superseding: [v1] spi: introduce new helpers with using modern naming (2022-09-29T13:20:41):
    [-next] spi: introduce new helpers with using modern naming


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

