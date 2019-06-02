Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9833238E
	for <lists+linux-spi@lfdr.de>; Sun,  2 Jun 2019 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfFBOUO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Jun 2019 10:20:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32780 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfFBOUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Jun 2019 10:20:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so6761216pgv.0;
        Sun, 02 Jun 2019 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gm5OUfBYt2rZ5++CvxJbeV901kE7mvqiml3mou2FzOk=;
        b=Z5fzM2KJ5F1WEsd1lSFWNKX6OqhyWzXe6/ML/6sT0TpxmiZpPVbVB8JX8jcN+0TXhg
         5ahR1zt59qVEUo+vuWi5FcX6ly+RPVcNaXGftC6b/rCGIGfr+1L5QTZUUmJnSZD3Ipjp
         BIOAlE3XoXQUwxq2pMZJ1CgNBa0Y9OYfSreEweoheCfycVQ/P80hsVA+jLZW42T05hkW
         tnotpMoTGoNNbNhPP3SWMBKUd+n3Qf5NVX+44NUOiMGfpmPCfTD7PakorNXAFmyQ/OXr
         ccHz/8gFsZz0spMvIFF7b3itr1CnGE7WJbdNhT2RTdpYmqXDLGHocHr6SPBre3eEUVYP
         Gzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gm5OUfBYt2rZ5++CvxJbeV901kE7mvqiml3mou2FzOk=;
        b=dqjxR8D4l1qjYiNKznLAwZD9vTRmYLBmNI/6gJt4FJ7z7sRPOSVTcpzLmJB73I7Rv8
         vOlzPVAOGfDId+m5AaUoGirSZFwnlH2YFTeu9rcZGKO+f5yK63IyZba95+Nem56fb18y
         LLUW7UbZ++CUMm6Vj6T/CUHX1FdRAp3OfZuMZh0Rjm2lZcVLP+KbCSBDHQ5GgtEMiOmQ
         v9EkdOu4SuwsBujpmmBrXOb7bCe7OS45DTDFZYnAIqaz+/qnWYnVDtXCBVSTcpquAiGw
         gM6clwL2w+vgXbhDw1WtAtXVXA2spd4DkptQ0VVx3L9qQiBdLqQ92tJlQzmXYQ54ztYU
         dxUQ==
X-Gm-Message-State: APjAAAWOZIbhwHXwNXN+WeALqJ33RsADAzTOJ75AkdRoVyd2dar88n/G
        2flGU7C0DQAgiW0Tc4lWgdi0lnCS
X-Google-Smtp-Source: APXvYqwQ1RTfwGwrUl833DLpdfu8jg+jL7nudr1ZHjRyUrACslFw0tE59equcReVwjWa1/bqXCDjJA==
X-Received: by 2002:a63:eb03:: with SMTP id t3mr22548381pgh.315.1559485213155;
        Sun, 02 Jun 2019 07:20:13 -0700 (PDT)
Received: from localhost.localdomain ([27.7.2.234])
        by smtp.googlemail.com with ESMTPSA id t33sm11768133pjb.1.2019.06.02.07.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 07:20:12 -0700 (PDT)
From:   Vivek Pernamitta <pervivek@gmail.com>
Cc:     pervivek@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spidev: Fix for reverting spi max speed value only on failure
Date:   Sun,  2 Jun 2019 19:49:59 +0530
Message-Id: <20190602141959.5616-1-pervivek@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When user space application request for change in spi clock
using ioctl, current value is taken back-up and new value is
assigned to spi->max_speed_hz, then spi_setup() function is
called with new value. If spi_setup() function fails, it needs
reverting to old spi_max_speed value only in failure condition.

Signed-off-by: Vivek Pernamitta <pervivek@gmail.com>
---
 drivers/spi/spidev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 30498cf25f3b..70382b642f37 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -458,9 +458,10 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			retval = spi_setup(spi);
 			if (retval >= 0)
 				spidev->speed_hz = tmp;
-			else
+			else {
 				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
-			spi->max_speed_hz = save;
+				spi->max_speed_hz = save;
+			}
 		}
 		break;
 
-- 
2.17.1

