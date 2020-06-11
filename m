Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179B71F6877
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFKNAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 09:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgFKNAP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 09:00:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591880415;
        bh=PmQPwjUVfmjkLOJZtcEVjcVhRelq9aPJMwK1yYQzKzQ=;
        h=Subject:From:Date:To:From;
        b=jBn2FAKz5sihdwhxJnJwwA/ERbZp447k/m86D90DjoPpNYrctbIqFP9DYzCwD2xjs
         UbGnkNf7xK7yOb1uVMLhNsqz23oCsjRGxtTgJzM3/+avnxo384Y+SfDj0nKIxmXe0m
         ncw7x+u1eBflSaYN6kbL0eLZgNyG0w+/CiWSYXzk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159188041555.16656.2609214643628553246.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 11 Jun 2020 13:00:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tools: Make default_tx/rx and input_tx static (2020-06-11T12:56:52)
  Superseding: [v1] spi: tools: Make default_tx/rx and input_tx static (2020-06-11T03:42:27):
    [1/2] spi: tools: Make default_tx/rx and input_tx static
    [2/2] spi: tools: Fix build errors


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
