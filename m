Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8BEE9912
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfJ3JUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 05:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JUS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Oct 2019 05:20:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572427218;
        bh=VYX4tI0plMExXR+83UyGqGU60JXPp5IuYl0nrwxhFGw=;
        h=Subject:From:Date:To:From;
        b=zRfjyCpTB6Ih5Gx+CEdyd5XgSauzY7GV40wHTrTxtbH6xuu1cu0nHIZGWvrqYBZUJ
         XI7WWAGKyG1XTKpHYRasCxwU9tSGzbZ9mBKyb4fUPwbyxuRFf8BDm1ui7gsDdAfe9w
         k0uU7AmjxwB+tHEwD05G4Xcnthrq+s1MlRHOpcNo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157242721835.31480.16145043784088733218.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 30 Oct 2019 09:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: add power control when set_cs (2019-10-30T09:03:54)
  Superseding: [v2] spi: add power control when set_cs (2019-10-30T08:08:16):
    [V2] spi: add power control when set_cs


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
