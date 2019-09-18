Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84AB5EF2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 10:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfIRIUI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 04:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbfIRIUI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Sep 2019 04:20:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568794807;
        bh=uF8GdYsTc7cuA8voZQYqK4OjEnJyzX31Hu6AtCVr9TQ=;
        h=Subject:From:Date:To:From;
        b=DTyAZupsLVdFaKK2yYYYveBZvE0bCti0AATrj5aQEk8HpZE9opl6hzIWv2JXdt5w0
         ZRZgC5yH7fWC3EkLSPo+CtNlvcVhFYF2syXB5zKpUUepXyApYxeqErJaf8uXRPKWIP
         DcZ+AiDsEinlkBLjdSP81bg3T1JEfb5Uhn53Icc0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156879480779.28961.3339130054233540956.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 18 Sep 2019 08:20:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw: Add basic runtime PM support (2019-09-18T08:04:32)
  Superseding: [v1] spi: dw: Add basic runtime PM support (2019-09-13T12:11:57):
    [1/3] dt: spi: Add Renesas RZ/N1 binding documentation
    [2/3] spi: dw: Add basic runtime PM support
    [3/3] spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
