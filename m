Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAD6FFF8
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2019 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfGVMpN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jul 2019 08:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfGVMpN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jul 2019 08:45:13 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563799512;
        bh=IQP3tIuUVz1We7lD7OhQYlcUo4GEiv+URCsxPWWxZQI=;
        h=Subject:From:Date:References:To:From;
        b=w+e0T5gNKGbQRmqcWyPbGpLLYkVtAM0NJvbl6nJzi6s+zvvoGC0XAmxURT/hHYtzw
         5HHGWyuCQvkQIjoBsGaKQIcDA0bNLZddZhCzn92X2rcOSp8h7wCvOVGkSHJcRT9VFm
         3agn+EB6YCaKT1xvy4+lKqtV5mT10OXgo+R30r0w=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156379951205.24986.4907570697478427606.git-patchwork-summary@kernel.org>
Date:   Mon, 22 Jul 2019 12:45:12 +0000
References: <20190715230457.3901-1-robh@kernel.org>,
 <20190715204529.9539-1-linus.walleij@linaro.org>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: dt-bindings: Ensure child nodes are of type 'object'
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=146135

Patch: Revert "gpio/spi: Fix spi-gpio regression on active high CS"
  Submitter: Linus Walleij <linus.walleij@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=146097

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
