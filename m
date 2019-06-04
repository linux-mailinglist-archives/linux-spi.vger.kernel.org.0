Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A862C33E45
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 07:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFDFUJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 01:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfFDFUJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Jun 2019 01:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559625609;
        bh=XTGVxl/MbJetkxeNY849VihcHYB6b66YJ+zMxXP6re8=;
        h=Subject:From:Date:To:From;
        b=tmOVn4oVmUmT+6M/2JIFLwvmvjw0nJ9iEIr+nS/ME3a6fjvzWRSPwQbKjb0OfpO5t
         uGFbbCCNpb0cIH1Y2cr9J9SlZcneNfvXVn0W4ekMeuEexnEuwbMEGYzNSemZbOR9WS
         dkWdVuUxiUIJgMj3mWVQSTa7Zj+awGHZhtDiktaQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155962560932.15023.16922482470218642161.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 04 Jun 2019 05:20:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: support for Socionext Synquacer platform (2019-06-04T05:12:54)
  Superseding: [v6] spi: support for Socionext Synquacer platform (2019-05-28T09:27:10):
    [v6,1/3] MAINTAINERS: Add entry for Synquacer SPI driver
    [v6,2/3] dt-bindings: spi: Add DT bindings for Synquacer
    [v6,3/3] spi: Add spi driver for Socionext Synquacer platform


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
