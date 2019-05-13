Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754BC1BE86
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 22:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEMUUy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 16:20:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfEMUUx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 16:20:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so7344633pgs.2
        for <linux-spi@vger.kernel.org>; Mon, 13 May 2019 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXevDClJ1rO45drgBiu5kidYCiWEsQSHa18BKuPnW/Y=;
        b=jKhuRwVHZ3BDtVl3GK1PW+UIy07oLOd5IrGmCdwWxvnXCmxeJzoFlxajPbhhCvYs5D
         BiKtENMbOnb3jOZgBHcaSrZP/l9Q7h3Tk58SPzLplMitZrLm80I4da33Lr1TFoHeSAEt
         6w+h3T+w38C2MNdgEkMVyS6QO1y00sDDyvCBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXevDClJ1rO45drgBiu5kidYCiWEsQSHa18BKuPnW/Y=;
        b=nV8SnPUYXv9MdhuSsPwvy1KCFUKoAF408jN6rxeAcL5Pdj6Pn9JZ9FPYwHG5tK60dd
         kSFZZ0asAFrVaioG3KooTunznEbpwPYQOEF2O+wbdgyL96ztfbH69qkTPtsVDGWaLsO7
         frOV0Xa9HBNXHywJ86WRfVL5uXK4CQP3iDEFa56FOuf1dmkxPzUsQwZu/18q7SogIlkd
         VoB11aXQdrmn7MC24QETZK2+UGSkXHAHT8qVFKo4mS/4ihetNPeUzALXBrioZWJaQMl4
         SeCei1n8Bp5/AVA4N/iFIwV3GR6DWL6y9w2CKUpQBg/O7Gm7kpHBvAx/IEYjvCWNepp1
         zdwQ==
X-Gm-Message-State: APjAAAXmUnMbpvkCqAz5/wE7BWOzw6PuZEHPyF1vmYUgLD1r2k2SH3m3
        C8E2HZCduJBzecda/H4wNPl8Hg==
X-Google-Smtp-Source: APXvYqyLcsaawFWNgUONZhu9RhQR6qJPBSqV6S0MF4CC/aTGIeqwjn8gtglL9ZCx9wEKemTyfiSkBQ==
X-Received: by 2002:a63:5c1c:: with SMTP id q28mr33373287pgb.45.1557778852872;
        Mon, 13 May 2019 13:20:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s198sm26356597pfs.34.2019.05.13.13.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:20:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 0/3] spi: A better solution for cros_ec_spi reliability
Date:   Mon, 13 May 2019 13:18:22 -0700
Message-Id: <20190513201825.166969-1-dianders@chromium.org>
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

Specifically note that even though the above commit made things
better, we still saw some failures.

The majority of these failures were because we were competing for time
with dm-crypt which also scheduled work on HIGHPRI workqueues.  While
we can consider reverting the change that made dm-crypt run its work
at HIGHPRI, the argument in commit a1b89132dc4f ("dm crypt: use
WQ_HIGHPRI for the IO and crypt workqueues") is somewhat compelling.
It does make sense for IO to be scheduled at a priority that's higher
than the default user priority.

It turns out that we could also see problems because loop devices also
run at high priority.  See the set_user_nice() in
loop_prepare_queue().

Looking in more detail, it can be seen that the high priority
workqueue isn't actually that high of a priority.  It runs at MIN_NICE
which is _fairly_ high priority but still below all real time
priority.  We can do better by using realtime priority.  That makes
sense because cros_ec_spi actually needs to run quickly for
correctness.  As I understand this is exactly what real time priority
is for.  Note that there is a discussion going on about the dm-crypt
priority [1].

We also had other problems with the previous patch because sometimes
we'd end up on the SPI pumping thread and had our priority downgraded.

Both the competition with other high priority things and the priority
downgrading are fixed by this new series.

After this series I can run the following test on Chrome OS (which
mounts /var as stateful encrypted) with no errors:
  dd if=/dev/zero of=/var/log/foo.txt bs=4M count=512&
  while true; do
    ectool version > /dev/null;
  done

Special thanks to Guenter Roeck for pointing out the "realtime"
feature of the SPI framework so I didn't re-invent the wheel.  I have
no idea how I missed it.  :-/

Also note: if you want some history on investigation done here, feel
free to peruse the Chrome OS bug [2].

[1] https://lkml.kernel.org/r/CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com
[2] https://crbug.com/948742

Changes in v2:
- Now only force transfers to the thread for devices that want it.
- Squashed patch #1 and #2 together.
- Renamed variable to "force_rt_transfers".

Douglas Anderson (3):
  spi: Allow SPI devices to force transfers on a realtime thread
  platform/chrome: cros_ec_spi: Force transfers to realtime priority
  Revert "platform/chrome: cros_ec_spi: Transfer messages at high
    priority"

 drivers/platform/chrome/cros_ec_spi.c | 81 +++------------------------
 drivers/spi/spi.c                     | 49 +++++++++++++---
 include/linux/spi/spi.h               |  5 ++
 3 files changed, 52 insertions(+), 83 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

