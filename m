Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE579DE05
	for <lists+linux-spi@lfdr.de>; Wed, 13 Sep 2023 03:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjIMB5L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 21:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMB5K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 21:57:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF810EB
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 18:57:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B28D5C433C8;
        Wed, 13 Sep 2023 01:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694570226;
        bh=Svp2Z9K8qmgcFZHqSoGcneZ/G6j526rhrr0pBmjs9dw=;
        h=Subject:From:Date:To:From;
        b=ssisQogmMFQxvJrr17j5BWrejFpbj/nvbZbMq6GCyorNMcAIPl6AA4PyhYYEAFZue
         X9D6eOkXc7qaFnQkY6uh62mefJhnFGmGPY9p+8KBsmj7cNM+9lcT5eq3fd8OPejLsV
         AwI0QCFyoQmKlqT6sux2OlAOfB6+2Rcxvc0sNZAWDBorJBhWsWEN3JXJIBFT+A3yx1
         Sf+ujVlc7nP9Ws0quz/rc+nRiki4+R343EyC+FYS+g+hVZNnJJg289FhPVUyyyGlBw
         3Al4STV7eK0bGWN4uei/+vZZDtSp5grosiGx0RnaQgH8+IuXYFr7cK7un5TppqTiRj
         xgPZhVIHAXN2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98FC6C04DD9;
        Wed, 13 Sep 2023 01:57:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169457022662.17461.11344955250628463778.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 13 Sep 2023 01:57:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v16] Add Intel LJCA device driver (2023-09-13T01:40:08)
  Superseding: [v15] Add Intel LJCA device driver (2023-09-06T03:22:56):
    [v15,1/4] usb: Add support for Intel LJCA device
    [v15,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v15,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v15,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

