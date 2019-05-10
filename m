Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758A71A548
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2019 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfEJWfM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 18:35:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfEJWfM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 18:35:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so3669502pgv.0
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2019 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUHTu2iWYOnQ+FG1Jw9nXlKv7Z2ExyMTaZIZxvh4N1A=;
        b=hCrHuZS+46Po1sU6nnIKOLhIcano3vwfug8LQFQRcGVzUvhpAF+0tf28VytjzxOZqL
         Xl6JpsSL0vwxBpq7m+OZgEVIfWzalVEsf1aKQE9B6FEjYE8k3jMMYsejs2mvuqS9M7cn
         XASxVqZcO9nuQktMTgSgSLhuOrzwq+jc/LIXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUHTu2iWYOnQ+FG1Jw9nXlKv7Z2ExyMTaZIZxvh4N1A=;
        b=gKBXwfG4icjtHxT00sTFKSslACGKBlLvmWibTAUn2WMk6C4ZJNsEMTHmMaSHW04phD
         8yW6mQiXe+jETkz91E9Q4kNXpxDMaqT+BFsHgazJ2BfX2kUHVwWQWXQfnxFXbxhD3hk0
         uftxrQF4cw0D1nEgD7rvZHZp35ZLWv9Nr8jkyaTp80IlefuHd0oNmJpRgZTWxO98czFP
         vJB85X0SaOhlpciy0H8CZlrZQKWpW1p8uA8xYG2qffwpxXEdjTsBp+wSlqRN4wrlVOjC
         PFbYbEr8dhIQE4DBppuehx4mLi0GcsP7xvKKzaeDeUK+PFKpopRFP4F+xSlf6u+qTAb8
         j7+Q==
X-Gm-Message-State: APjAAAV7+MUUXjC0u/4t9UKnbud674rGTx/+5Py1VlIBb8bVZyYNe5DT
        XhHL05sICtTdbyClTwS33l/0oA==
X-Google-Smtp-Source: APXvYqyOeodYctuSbplQTqoU+d4nsO/QhEglv7cTdPcZH4nSpAWNrFBF8kqyyKdVfa8CLgtxbAjBHw==
X-Received: by 2002:a63:f315:: with SMTP id l21mr16528352pgh.417.1557527711448;
        Fri, 10 May 2019 15:35:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j6sm7689393pfe.107.2019.05.10.15.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:35:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/4] spi: A better solution for cros_ec_spi reliability
Date:   Fri, 10 May 2019 15:34:33 -0700
Message-Id: <20190510223437.84368-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series is a much better solution for getting the Chrome OS EC to
talk reliably and replaces commit 37a186225a0c ("platform/chrome:
cros_ec_spi: Transfer messages at high priority").

Note that the cros_ec bits can't land until the SPI bits are
somewhere.  If the SPI bits look OK to land it might be convenient if
they could be placed somewhere with a stable git hash?

Special thanks to Guenter Roeck for pointing out the "realtime"
feature of the SPI framework so I didn't re-invent the wheel.  I have
no idea how I missed it.  :-/


Douglas Anderson (4):
  spi: For controllers that need realtime always use the pump thread
  spi: Allow SPI devices to specify that they are timing sensitive
  platform/chrome: cros_ec_spi: Set ourselves as timing sensitive
  Revert "platform/chrome: cros_ec_spi: Transfer messages at high
    priority"

 drivers/platform/chrome/cros_ec_spi.c | 81 +++------------------------
 drivers/spi/spi.c                     | 41 +++++++++++---
 include/linux/spi/spi.h               |  3 +
 3 files changed, 43 insertions(+), 82 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

