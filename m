Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE93B6225
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfIRLUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 07:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbfIRLUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Sep 2019 07:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568805618;
        bh=UhyGQS+bdafkLKetS7heC7D2F26rLGB9N4f1Q57cfDc=;
        h=Subject:From:Date:To:From;
        b=BKE+WlTQ33+xMo6GuGYAGp5LK18Ty331viejO5kW3ykiHrHQr0A+I5ki0CKjuyAz2
         RcBCL7xlXzeUdUcwuDklZpVIhf9tUzIplCOc/6qKSdFrIevckJ/10tnxYgL7K429m0
         XSjPJWE5aSdDND+O3X0/r7E6W7RhHdLttzFr27c8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156880561886.6468.8396921443789837420.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 18 Sep 2019 11:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dt-bindings: Convert spi-sifive binding to json-schema (2019-09-18T11:08:39)
  Superseding: [v1] spi: dt-bindings: Convert spi-sifive binding to json-schema (2019-09-10T07:02:51):
    spi: dt-bindings: Convert spi-sifive binding to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
