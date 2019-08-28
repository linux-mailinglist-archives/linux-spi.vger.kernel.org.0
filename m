Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6588A052B
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH1OkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 10:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfH1OkH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Aug 2019 10:40:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567003206;
        bh=TK9PA6knzix02A51Q48dKqzDOD/1KYea8hiJ1yTU3js=;
        h=Subject:From:Date:To:From;
        b=W3D9LKaRlXgA8XBBySDWe++WV5RFXHaFXlqWHzp+1v7tLMlMi1Gt/x1p+JcJFr4el
         vbToPEbsULRjbc2Lb1awQJ8J+uN8n860MkDaZCmRhEfssvX4Z+1t3YamxQojNRv+RN
         DhKHeOt69MjDxDqfX51aZmzEWS3HlWNQDT3nITKM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156700320683.7708.5575969917777882090.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 28 Aug 2019 14:40:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: add NPCM FIU controller driver (2019-08-28T14:25:13)
  Superseding: [v2] spi: add NPCM FIU controller driver (2019-08-08T13:14:48):
    [v2,1/2] dt-binding: spi: add NPCM FIU controller
    [v2,2/2] spi: npcm-fiu: add NPCM FIU controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
