Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F69157D56
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 15:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBJOZ6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 09:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBJOZ6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 Feb 2020 09:25:58 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581344758;
        bh=Ou1iU1zmmpWXZ5r0OXSuHfQlJ1eb1W46YYxshlEwso4=;
        h=Subject:From:Date:References:To:From;
        b=x3bP8Prcl2Pf/k/4St75/jBPrwh3epi3DnCciIxPfFFGeu0fNr0Xv6QziIcNm3jf8
         1Y7n8cNKoPU8bNKiQwMlVUUG1b6m6RAq0iD/MNYyRbghW9Yxg6olfDe0Cb6ae/10wz
         I6VHMqg+ioBUGMPoWNcaEpFhT4+YJvcDT9qaEGhY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158134475828.15893.14885047881847079218.git-patchwork-summary@kernel.org>
Date:   Mon, 10 Feb 2020 14:25:58 +0000
References: <1579262309-6542-1-git-send-email-claudiu.beznea@microchip.com>,
 <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: add device tree for SAM9X60 SoC and SAM9X60-EK board
  Submitter: Claudiu Beznea <claudiu.beznea@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=229897
    Patches: [v5,1/2] dt-bindings: atmel-usart: remove wildcard
             [v5,2/2] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}

Patch: powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on fsl,spi nodes
  Submitter: Christophe Leroy <christophe.leroy@c-s.fr>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=209489

Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
