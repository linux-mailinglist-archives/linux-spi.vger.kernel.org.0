Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72344B8EE4
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2019 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392177AbfITLUI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Sep 2019 07:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392160AbfITLUH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Sep 2019 07:20:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568978407;
        bh=mi2hcRooQXi8d+Z490qOXgtT2MbVJOt+z0QpQlr0dzk=;
        h=Subject:From:Date:References:To:From;
        b=UXG+HIxTe3ostYPNlJ1bIL0LxRc49Y74R8hYcF3SJmqFjcw18ADxwL4QEaU/BeA0E
         IZmnd8aUM/+jv67I1oFLXHbR/WIZRLEp20ug8APEGAwm8VDIz6LSC43j0UupnmK34s
         77ooTuEPT9zP9hm9Ic1uM/KILdrGtOrDMU0nriK8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156897840537.27377.18137445898803736122.git-patchwork-summary@kernel.org>
Date:   Fri, 20 Sep 2019 11:20:05 +0000
References: <20190903231856.GA165165@dtor-ws>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: gpiolib: of: fix fallback quirks handling
  Submitter: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=169129

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
