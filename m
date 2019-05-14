Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155A91CF38
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfENSkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 14:40:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41553 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSkH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 14:40:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so1090274pfq.8
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5lmD3O2z0vSk4VQzRzNUrXAaT7ROOc/nk13EyEk/Z8=;
        b=H5Y9KXgwnq7ezY/NEDojzcCdz/MTUU2ltKGxRIk7MI7CfJPl17Hr+/0JzOFSuTp/HD
         jDhdlTjiAgAJeyqcChsshmGOG/i6tU6ESAAdF/KguksGOcQ3RtCOJPI7Ka+mo0jFkIES
         AF5gTR+hcgOEwZCn0zjbxF+tOlJQ23fa3GyBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5lmD3O2z0vSk4VQzRzNUrXAaT7ROOc/nk13EyEk/Z8=;
        b=uY+5i1x9zNM2IwHEgN2xlDx1580xHlZig6NGbnBvhqlfnp4Y56VLXqr/jeiBDt6YNo
         JYGwkdP+xstAePVHGJc7IsCUrIR511ECLQK0dNW4SRsiMP4nrSpNQWT+CJyCVOiym100
         5D6ZGrJyLIjf5/ZueRxvPBFiZWvkod6+85yFgq0WwGDdrh16fK42b5M01t9IHl6WSAAa
         MfZ5pbDi9fhjKj6HVyfITVGbRaKB9LSrFq73l6V3cMvOD3qW8/J8BSBrQAvcu6aDzQC4
         6LjzwxoIl/tzlQAtH+3gSV4U0FSEjw2KlgQzNU6IcbOiLkEJ4UR7a9egObws0x9oOWh/
         450w==
X-Gm-Message-State: APjAAAXqMcHzu+4Nt+p7HaepKMFZIMvV+xlrmDKFHshMaRa308bmcex3
        7gOR8Rp86QXNmGMp2q3zASDXaQ==
X-Google-Smtp-Source: APXvYqzB/ncd07lY8oKwjyYs9cE0Ws3ptZ6OOxXnzgYsvm+RO6GmbunYYA6NV+JxBn4oUSn8b/7Vug==
X-Received: by 2002:a63:7909:: with SMTP id u9mr33519089pgc.223.1557859206272;
        Tue, 14 May 2019 11:40:06 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 19sm19182454pgz.24.2019.05.14.11.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:40:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 0/3] spi: A better solution for cros_ec_spi reliability
Date:   Tue, 14 May 2019 11:39:32 -0700
Message-Id: <20190514183935.143463-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series is a much better solution for getting the Chrome OS EC to
talk reliably.

Patch #1 in this series is the most important.  It can land any time.

Patch #2 in this series (a SPI framework patch) needs to land before
patch #3.  Note that patches #2 and #3 really just fix a corner case
and just having patch #1 is the most important.  We don't end up on
the pumping thread very often.

Note:
- If you want some history on investigation done here, feel free to
  peruse the Chrome OS bug: <https://crbug.com/948742>.

Changes in v3:
- cros_ec realtime patch replaces revert; now patch #1
- SPI core change now like patch v1 patch #2 (with name "rt").
- Updated description and variable name since we no longer force.

Changes in v2:
- Now only force transfers to the thread for devices that want it.
- Squashed patch #1 and #2 together.
- Renamed variable to "force_rt_transfers".
- Renamed variable to "force_rt_transfers".

Douglas Anderson (3):
  platform/chrome: cros_ec_spi: Move to real time priority for transfers
  spi: Allow SPI devices to request the pumping thread be realtime
  platform/chrome: cros_ec_spi: Request the SPI thread be realtime

 drivers/platform/chrome/cros_ec_spi.c | 89 +++++++++++++++++++++++----
 drivers/spi/spi.c                     | 36 +++++++++--
 include/linux/spi/spi.h               |  2 +
 3 files changed, 110 insertions(+), 17 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

