Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8BB2A6F40
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgKDUyn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 15:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbgKDUyk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Nov 2020 15:54:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC19C0613D4
        for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2020 12:54:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p63so53522ybc.7
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2020 12:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ydU8MqNb5ODaxL3+Z2DSyH1qiAoSfviF3VEkdiIDKBY=;
        b=Mi+nN8QIQ7x63V+TG/eYb4r6c6UacmC9riV2b3bPg3sSUVtnALhVnovndw/IexzccJ
         nx8Les/RmPNDQZDpqqytrNU82vpIYrJEEOw/MlSsV4hCS6sIDVhvOvXWlTszMpvrP1nl
         iSdNI7J0W6i3+3z87KzdLwSTQr6AEw+LipxCCs1IocG+9tkFWO6epStStoDcqwxzSDsY
         i5MBM4tspoQnVHGlZ4PAtsEecXczCzCKWjA2c/WonpQkECU5wL8woPGrIAmt5fxWFCmY
         hWwsXUMHpeyhOtvxkHcgqCZ8SUsTQTBZdHayWNXal4DLYAwiiH1LLtDiqi6SOXBP7d70
         gX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ydU8MqNb5ODaxL3+Z2DSyH1qiAoSfviF3VEkdiIDKBY=;
        b=uSCy0TJTL34htCeo50gU9Xo8+FxYVefE/WxwpygsL5Eu2Z8S2VyJ3FJ7axfaMq/0aA
         my3Q7y2rZmmpbCZaJTCzgyTt1d8ZjqEoOKi6NRl/ulo8qSB7tpa0lGawehwAWbUW+ZVD
         Hyu6djtfBDrmxUUtjE1hW3QSC9cy8TaxDQF0ywuQVRyU85z2uV9fpHA1rGCoufidkMkq
         NFT7ZhTRYrXFlQhPKPJ0620qbx+CexXwrYSvJ1/boFbGDcWLZYntDLr+aXyrDoiBooj3
         it1ZH7MdK6Z1Ykxbb2wj6zJHR0a6BUnyg4wBR8x/BKf9fH4iM4qPiXOyrKdCVHFYIyBx
         hVew==
X-Gm-Message-State: AOAM530GuNoYOpPLLpys7uIO7AZSbqJ4a/2yz0CzqHCpkSGi2C634+Q9
        BFU0g+NmzPwfKc59j0oEeue6w7DmIo4Llag=
X-Google-Smtp-Source: ABdhPJw5zVtQunGCPIAfu7fOW9XCFg0q3VsIcMowV4//GgSeDsTJfw4AS5PE/RJBihvUIcjkmYJH4b+ocO86DZg=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:8709:: with SMTP id
 a9mr36737716ybl.208.1604523278064; Wed, 04 Nov 2020 12:54:38 -0800 (PST)
Date:   Wed,  4 Nov 2020 12:54:31 -0800
In-Reply-To: <20201104205431.3795207-1-saravanak@google.com>
Message-Id: <20201104205431.3795207-2-saravanak@google.com>
Mime-Version: 1.0
References: <20201104205431.3795207-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 2/2] spi: Populate fwnode in of_register_spi_device()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Cheng-Jui.Wang@mediatek.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Daniel Mentz <danielmentz@google.com>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Daniel Mentz <danielmentz@google.com>

This allows the fw_devlink feature to work for spi devices
too.  This avoids unnecessary probe deferrals related to spi devices and
improves suspend/resume ordering for spi devices when fw_devlink=on.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
[saravanak: Minor commit text cleanup]
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..d533aa939cca 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2037,6 +2037,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
 	spi->dev.of_node = nc;
+	spi->dev.fwnode = of_fwnode_handle(nc);
 
 	/* Register the new device */
 	rc = spi_add_device(spi);
-- 
2.29.1.341.ge80a0c044ae-goog

