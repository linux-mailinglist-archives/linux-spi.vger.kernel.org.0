Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0133E3B1764
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWKBD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 06:01:03 -0400
Received: from www.zeus03.de ([194.117.254.33]:50504 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhFWKBC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 06:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=w1QHaAQSPxAK8tA/vbz/Vy2Zy3h
        bg3SP3Mj8bdNwTTw=; b=NORZkO1KLGIAh/nIL/L3WUnPh51JJhGyDxfEcwxL4iZ
        uPxdVkYjDKqj779PkEErYsxlP8sa3FpA2pTmzJ6rUxxh14Mt1aTTAtPxP7wS7KNk
        uck4KpOYPNp5Tj25hCVAFFryUFRqqf80o5VRtYWiGW5IrUCx63wnZZLkhrHpDsmo
        =
Received: (qmail 2551444 invoked from network); 23 Jun 2021 11:58:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 11:58:44 +0200
X-UD-Smtp-Session: l3s3148p1@UGiq82vFCKogARa4RfhaAavnjlTTqzSz
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/2] spi: use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 11:58:41 +0200
Message-Id: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dmaengine_terminate_all() is deprecated in favor of explicitly saying if
it should be sync or async. Update the drivers I audited.


Wolfram Sang (2):
  spi: spi-rspi: : use proper DMAENGINE API for termination
  spi: spi-sh-msiof: : use proper DMAENGINE API for termination

 drivers/spi/spi-rspi.c     | 6 +++---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.30.2

