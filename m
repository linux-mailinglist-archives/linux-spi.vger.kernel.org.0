Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6504DB4A41
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfIQJUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 05:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfIQJUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Sep 2019 05:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568712017;
        bh=bNAn1LrHdfVepWCDAJDPCyWr4s0o8TIsUqmD9wdw/4k=;
        h=Subject:From:Date:To:From;
        b=egv8E5/NR+nAWSFihIWQlWGLDUK6gweKrXqUMH8fAGDHWDEmjknH8fw9jyf5Jmvdf
         v4R9TcoyIXlpMVRopWVzO8G4dIAU8waN8QoJwgdmHPZUkDoWTG55l/akDCZ/MnjGvl
         hKYyzESFBFRAbK1Agjo68r+xnxgLhUmeTmWE8aU4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156871200713.3664.3746250244790156937.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 17 Sep 2019 09:20:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: sifive: check return value for platform_get_resource() (2019-09-17T09:12:38)
  Superseding: [v1] spi: sifive: check return value for platform_get_resource() (2019-09-17T09:12:14):
    spi: sifive: check return value for platform_get_resource()


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
