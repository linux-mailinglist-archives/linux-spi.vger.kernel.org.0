Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABF75FA0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfGZHVV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 03:21:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36249 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGZHVV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 03:21:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so24329393pgm.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jul 2019 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DPFbvaM0ffzn/S9lvtDvQ6X/wXEPD6IvdQw6DnygcpE=;
        b=Dcn0TQ5iRKLiq9la/u8PnkLoh/bQ2HK/pp5dNWDnoSTPgId5B1ES2XCZi8js0tnVhC
         KXOtq22CVWqlrrr+aJObx2rwiuJsfIl7mY9R3xWmrAFgRkh9A0GLxELmkTaWSiy/d51P
         s0bap92JtiqtNfdeVMzIxqhcUx6GIyuEaMsWzjldAXjQdkBdQjzVZXq03JkOdlEqsCr7
         +/7+BNEovq0MpwM8KHegM16BSHvp9FATaTzBq6pse5fXCApisAoCGuNKaecOlGBVxX9n
         LmfGDxRULfqXvBm7lRINK7qgeM4mx9z+WK8g8Cm7S5UQc9jKSK0AonVKhg+tPDB2PiFo
         qIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DPFbvaM0ffzn/S9lvtDvQ6X/wXEPD6IvdQw6DnygcpE=;
        b=C94gUQFk6QuAxoSaEB/ZVdeqE5QNqKtMCQUuweY9ENTnbT0N3MSlw5rZ53dexgbbhR
         l0g1LGaruaiv7wiP959JRsJiJ2hlMkYkp6wu1BRm73uP+Hv3hggPLcC12jdnAV/wymVl
         ORF88PJllVFA06walsrmXYOrLq30FE8upGhS6/UyuX1RXM74HIvkJYonXbaQvSRXVlkw
         h8szaGkLXh7ewcbLvnbBvATvkXtr7E1uLmF2kmJ8RlJzq3X8TcftjviLU/d3uZKvev9a
         n1ADgP0z/5UtbOHKfIBJWksBbK5E+iOLWflmYCWdHO8jL823dFthKN/C4ejJsDYHvwR4
         fq7A==
X-Gm-Message-State: APjAAAVdUz3r+ptIzVNFIsjGSK2+CqP4D4jyb/4F0O1FP8VDIPcmQPVF
        W1tuVjiCqnLSVTzm+jAQpXe4Zw==
X-Google-Smtp-Source: APXvYqyF4Tr6KpqzUUg1uyFSW7cNnma7IjvzfFuYcV2VA1wP1hJQrdEzG7PNSHLazixsMdq0cLRW9Q==
X-Received: by 2002:a63:c006:: with SMTP id h6mr56329731pgg.290.1564125680781;
        Fri, 26 Jul 2019 00:21:20 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Optimize Spreadtrum ADI driver
Date:   Fri, 26 Jul 2019 15:20:47 +0800
Message-Id: <cover.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset did some optimization to remove some redundant code,
add more reboot mode support and change hardware spinlock support
to be optional.

Baolin Wang (3):
  spi: sprd: adi: Remove redundant address bits setting
  spi: sprd: adi: Change hwlock to be optional
  dt-bindings: spi: sprd: Change the hwlock support to be optional

Chenxu Wei (1):
  spi: sprd: adi: Add a reset reason for TOS panic

Sherry Zong (2):
  spi: sprd: adi: Add a reset reason for factory test mode
  spi: sprd: adi: Add a reset reason for watchdog mode

 .../devicetree/bindings/spi/spi-sprd-adi.txt       |   11 ++-
 drivers/spi/spi-sprd-adi.c                         |   92 ++++++++++++++------
 2 files changed, 71 insertions(+), 32 deletions(-)

-- 
1.7.9.5

