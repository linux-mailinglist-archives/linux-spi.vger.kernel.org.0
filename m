Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9917E580
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCIRQY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 13:16:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42011 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgCIRQY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 13:16:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so1985052plz.9;
        Mon, 09 Mar 2020 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aQaEz5n43Zv/bRgX8rTrwpFJGgT572GHf6K14yTbgTc=;
        b=QDYaXBJk9xBthEaQNh+gxQ88iXlNOPsMKsSDCxj7OkpI7OfwJFwLO8Asxvvhkxg5BV
         UWk/vPNpZiko4pfSCNz5xrk9/hQyY2nd3FFvlctZqIlK23+ELZZ31/BLT5XZIjOKwM67
         ibgnaH2TGIPBGviAdXotmEwQXQfg4MvwQ79EZAY0t4xlY4BZ47Wu9Qrm5zjJ9tgdiQDD
         Is+4oKO9s6sxQGfcdoyaggwBlVyKnqYD5jFxa4u2FEz+Bdi7f/KK2bbytYYyUIkEitQP
         qM/hsPe9a4HkSFibumar+FWnkb/7Moh9DTToWErSB6kD3LD02hdxmY+AYJnwXlKzNE58
         Nfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aQaEz5n43Zv/bRgX8rTrwpFJGgT572GHf6K14yTbgTc=;
        b=A+5hRq0Ka1Pd2Gz2AcCOfoPjzEblEuxX7fSGB9LlkaqC7NKYN9x5mUH1KSRhszN64I
         /LAVUm7ZU92AKPywk2mU2xSM/aofu6ZX8GFWvN1cl751GYQWywZKEHZTM4TaAJ+ajHYL
         6wYlzclxSQruRktfClNWMznDhaRKcm6U9Fa4HQUCEUTLbnRlILZdW2/rLj6zYCgAW1wa
         tQhyM8FO7e8mJyaQqGZSN2FWYT2aF+91cjvhQ3/y8RLYw/Xx67MxWu9L5LkCt4OilUE8
         mDMZMCkgzmA9YXRfhYTT9FmnBrknLfNp04DbRo6S32UsmtHCrheCdc+j9eOGBCgRJyog
         PXMQ==
X-Gm-Message-State: ANhLgQ3EFYVI63Eo5uRhmkt4hR8IoFsPlLY3JxDwOnmqzvSnwDUQ0do+
        MoaHDPegFaDPbWgGUT9fpgo=
X-Google-Smtp-Source: ADFU+vv96/cmd+ESTMe/yWp3mZTBy1Je98MgxBDt+qcLHmqckEQ238uv3hcur21QB24JCyHlsFazvg==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id m10mr310824pjq.105.1583774183135;
        Mon, 09 Mar 2020 10:16:23 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id u23sm45039835pfm.29.2020.03.09.10.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 10:16:22 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] spi: update the structure documentation
Date:   Tue, 10 Mar 2020 01:16:19 +0800
Message-Id: <1583774179-30736-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

some members were not described in documentation.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba0..2f28692 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -135,6 +135,8 @@ struct spi_delay {
  * @modalias: Name of the driver to use with this device, or an alias
  *	for that name.  This appears in the sysfs "modalias" attribute
  *	for driver coldplugging, and in uevents used for hotplugging
+ * @driver_override: If the name of a driver is written to this attribute, then
+ *	the device will bind to the named driver and only the named driver.
  * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
  *	the spi_master.
@@ -443,6 +445,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	@spi_transfer->ptp_sts_word_post were transmitted.
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
+ * @irq_flags: Interrupt enable state during PTP system timestamping
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
-- 
1.8.3.1

